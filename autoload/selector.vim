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

# Buffers, sorted in order of last used
export def Buffers()

  def GetSortedList(): list<dict<any>>
    var bufinfo = getbufinfo({"buflisted": 1})
    var unsorted = mapnew(bufinfo, (_, v) => {
      return {bufnr: v.bufnr, text: v.name ?? $'[{v.bufnr}: No Name]', time: v.lastused}
    })
    return sort(unsorted, (a, b) => {
      return (a.time == b.time) ? 0 : (a.time > b.time) ? -1 : 1
    })
  enddef

  core.OpenMenu("Buffers",
    GetSortedList(),
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

defcompile
