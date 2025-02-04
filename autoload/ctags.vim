vim9script
# autoload file
#
# Maintainer: markus prepens (markus dot prepens at gmail dot com)

import "run.vim"
import "utils.vim"
import "popnews.vim"
import "selector_core.vim" as sc

var ctags_tags_list: list<dict<any>>
var ctags_rebuild_sel_list: bool
var ctags_job: job

ctags_rebuild_sel_list = true
ctags_tags_list = []

export def TagCycle(direction: string)
  var tl = taglist('.')
  if !exists('b:tag_number')
    # Initialize
    b:max_tag_number = len(tl) - 1
    if direction == 'n'
      b:tag_number = 0
    else
      b:tag_number = b:max_tag_number
    endif
  else
    if direction == 'n'
      # Count up
      b:tag_number += 1
      if b:tag_number > b:max_tag_number
        b:tag_number = 0
      endif
    elseif direction == 'p'
      # or count down
      b:tag_number -= 1
      if b:tag_number < 0
        b:tag_number = b:max_tag_number
      endif
    endif
  endif
  # Jump to tag
  var n = b:tag_number
  b:tag_name = tl[n]['name']
  var name = b:tag_name
  echo ':tag ' .. b:tag_name
  execute 'tag ' .. b:tag_name
enddef

export def CtagsUpdate(opt = {verbose: false, rebuild_sel_list: false})

  if !has_key(opt, "verbose")
    opt.verbose = false
  endif
  if !has_key(opt, "rebuild_sel_list")
    opt.rebuild_sel_list = false
  endif

  ctags_rebuild_sel_list = opt.rebuild_sel_list

  if job_status(ctags_job) == "run"
    return
  endif

  ctags_job = run.RunStart({
    cmd: g:ctags_cmd .. ' ' .. utils.ToString(g:ctags_options),
    background: true
  })

  if job_status(ctags_job) != "run"
    popnews.Open("check ctags options", {t: 4000, hl: "ErrorMsg"})
  elseif opt.verbose == true
    popnews.Open(g:ctags_cmd .. ' ' .. utils.ToString(g:ctags_options), {t: 3000})
  endif
enddef

def TagsUpdateList()
  var l: list<dict<any>>
  var tag_file: string

  if ctags_rebuild_sel_list == true
    tag_file = findfile('tags', expand('%:h') .. ';,.;')
    if empty(tag_file)
      echomsg "TagsUpdateList: No tag file in " .. expand('%:h') .. " and upwards"
      ctags_tags_list = []
      ctags_rebuild_sel_list = true
    else
      l = taglist('.', tag_file)
      ctags_tags_list = copy(l)
      ctags_rebuild_sel_list = false
    endif
  endif
enddef

export def Tags(scope = "global")
  var buf_tags_list: list<dict<any>>
  var first_entry: dict<any>

  def FilterBufPath(l: list<dict<any>>): list<dict<any>>
    var path_relative: string

    def UnixSep(fn: string): string
      return substitute(fn, "[\\/]", "/", "g") # get rid of the 'slash problem'
    enddef

    path_relative = substitute(UnixSep(expand('%:p')), UnixSep(getcwd()), '', '')[1 : ]
    return filter(copy(l), (key, val) => val['filename'] =~ path_relative)
  enddef

  TagsUpdateList()

  if scope == "local"
    buf_tags_list = FilterBufPath(ctags_tags_list)
  else
    buf_tags_list = copy(ctags_tags_list)
  endif

  sc.OpenMenu(
    "Tags",
    mapnew(buf_tags_list, (key, val) => val['name']),
    (res, key) => {
      first_entry = filter(buf_tags_list, 'v:val["name"] == "' .. res.text .. '"')[0]
      execute $":tjump {first_entry.name}"
    })
enddef

# re-compile when debugging
defcompile
