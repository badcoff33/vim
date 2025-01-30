vim9script

import "selector_core.vim" as core

# Source:
#   https://www.reddit.com/r/vim/comments/wjxo3k/diy_fuzzy_completion/
#   https://github.com/habamax/.vim/blob/920e6ca906bb6f2890e6379ad794e09f0e4954d5/autoload/popup.vim

# Popup menu with fuzzy filtering
# Example usage 1:
# OpenMenu("Echo Text",
#            ["He was aware there were numerous wonders of this world including the",
#             "unexplained creations of humankind that showed the wonder of our",
#             "ingenuity. There are huge heads on Easter Island. There are the",
#             "Egyptian pyramids. There's Stonehenge."]
#            (res, key) => {
#               echo res
#            })
# Example usage 2:
# OpenMenu("Buffers",
#         getbufinfo({'buflisted': 1})->mapnew((_, v) => {
#                 return {bufnr: v.bufnr, text: (v.name ?? $'[{v.bufnr}: No Name]')}
#             }),
#         (res, key) => {
#             if key == "\<c-t>"
#                 exe $":tab sb {res.bufnr}"
#             elseif key == "\<c-j>"
#                 exe $":sb {res.bufnr}"
#             elseif key == "\<c-v>"
#                 exe $":vert sb {res.bufnr}"
#             else
#                 exe $":b {res.bufnr}"
#             endif
#         })

var selector_list_of_files = []

augroup GroupSelectorUse
  au!
  au DirChanged * selector_list_of_files = []
augroup END

# filter and open buffers
export def Buffers()
  core.OpenMenu("Buffers",
    getbufinfo({'buflisted': 1})->mapnew((_, v) => {
      return {bufnr: v.bufnr, text: v.name ?? $'[{v.bufnr}: No Name]'}
    }),
    (res, key) => {
      if key == "\<c-t>"
        exe $":tab sb {res.bufnr}"
      elseif key == "\<c-w>"
        exe $":bwipeout {res.bufnr}"
        g:Buffer()
      else
        exe $":b {res.bufnr}"
      endif
    })
enddef

# Description:  Works with tag file, found in current buffers directory and upwards
# Restrictions: No etags support or tag file with line numbers
export def Tags()

  var tag_file: string
  var tags_list: list<dict<any>>
  var buf_tags_list: list<dict<any>>
  var fsig: string

  def FileSignature(fn: string): string
    # get rid of the slashes problem
    return substitute(fn, "[\\\\/]", "", "g")
  enddef

  tag_file = findfile('tags', expand('%:h') .. ';,.;')
  if empty(tag_file)
    echomsg "No tag file in " .. expand('%:h') .. " and upwards"
    return
  endif

  tags_list = taglist('.', tag_file)
  fsig = substitute(FileSignature(expand('%:p')), FileSignature(getcwd()), '', '') # make file relative as ctags files names
  buf_tags_list = filter(tags_list, (key, val) => FileSignature(val['filename']) =~ fsig)
  core.OpenMenu(
    "Tags",
    mapnew(buf_tags_list, (key, val) => val['name']),
    (res, key) => {
      var cmd = filter(buf_tags_list, 'v:val["name"] == "' .. res.text .. '"')[0]['cmd']
      execute ":" .. escape(cmd, '*')
    })
enddef

# Description: filter all files from current dir
# In case of Ripgrep: Rg does ignore files, when '.ignore' or '.gitignore'
# files exists is current directory. To ignore both ignore definition files,
# put '!*' in the '.ignore' file.
export def Files()
  var dir_depth = 5
  if len(selector_list_of_files) == 0
    selector_list_of_files = split(system($'fd --exclude "*.git" -g *'), '\n')
  endif
  core.OpenMenu(
    $"Files, {dir_depth} dirs deep",
    selector_list_of_files,
    (res, key) => {
    if key == "\<c-t>"
      exe $":tab sb {res.bufnr}"
    else
      exe $":e {res.text}"
    endif
  })
enddef

# filter and open buffers
export def RecentBuffers()
  core.OpenMenu("Most recent buffers",
    v:oldfiles,
    (res, key) => {
      exe $":edit {res.text}"
    })
enddef

defcompile
