vim9script
# autoload file
#
# Maintainer: markus prepens (markus dot prepens at gmail dot com)

import "run.vim"
import "utils.vim"
import "config.vim"
import "popnews.vim"
import "selector_core.vim" as sc

var ctags_tags_list: list<dict<any>>
var ctags_job: job

ctags_tags_list = []

export def Update(opt: dict<bool>)

  if opt->has_key("verbose") == 0
    opt.verbose = false
  endif

  if opt->has_key("rebuild") == 0
    opt.rebuild = false
  endif

  if opt.rebuild == true
    ctags_tags_list = []
  endif

  if job_status(ctags_job) == "run"
    return
  endif

  config.Update()
  ctags_job = run.RunStart({
    cmd: join(['ctags',
      utils.ToString(g:cfg.ctags.options),
      utils.ToString(g:cfg.src_paths)
    ]),
    background: true
  })

  if job_status(ctags_job) != "run"
    popnews.Open("check ctags options", {t: 4000, hl: "ErrorMsg"})
  elseif opt.verbose == true
    popnews.Open('ctags_cmd ' .. utils.ToString(g:cfg.ctags.options), {t: 3000})
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

  if len(ctags_tags_list) == 0
    ctags_tags_list = taglist('.')
  endif

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
      execute $":tag {first_entry.name}"
    })
enddef

# re-compile when debugging
defcompile
