vim9script
import autoload 'filter_menu.vim'
import autoload 'utils.vim'

# filter and open buffers
def g:SelectBuf()
  filter_menu.FilterMenu("Buffers",
    getbufinfo({'buflisted': 1})->mapnew((_, v) => {
      return {bufnr: v.bufnr, text: (v.name ?? $'[{v.bufnr}: No Name]')}
    }),
    (res, key) => {
      if key == "\<c-t>"
        exe $":tab sb {res.bufnr}"
      elseif key == "\<c-w>"
        exe $":bwipeout {res.bufnr}"
      else
        exe $":b {res.bufnr}"
      endif
    })
enddef

var FileSig = (fn) => substitute(fn, "[\\\\/]", "", "g") # get rid of the slash problem

# works with tag file an relative file paths.
# Restrictions: No etags support or with line  numbers
def g:SelectTags()
  if empty(findfile('tags', expand('%:p') .. ';'))
    return
  endif
  var fsig = substitute(FileSig(expand('%:p')), FileSig(getcwd()), '', '') # make file relative as ctags files names
  var buf_tag_dict = filter(taglist('.'), (key, val) => FileSig(val['filename']) =~ fsig)
  filter_menu.FilterMenu("Tags",
    mapnew(buf_tag_dict, (key, val) => val['name']),
    (res, key) => {
      var cmd = filter(buf_tag_dict, 'v:val["name"] == "' .. res.text .. '"')[0]['cmd']
      execute ":" .. escape(cmd, '*')
    })
enddef

# filter and open MRU (Most Recently Used) aka oldfiles
def g:SelectFiles()
  filter_menu.FilterMenu("MRU",
    split(system('rg --files -g * .'), '\n'),
    (res, key) => {
    if key == "\<c-t>"
      exe $":tab sb {res.bufnr}"
    else
      exe $":e {res.text}"
    endif
  })
enddef

utils.Map('nnoremap', '<Leader>1', '<Cmd>call SelectBuf()<CR>')
utils.Map('nnoremap', '<Leader>2', '<Cmd>call SelectTags()<CR>')
utils.Map('nnoremap', '<Leader>3', '<Cmd>call SelectFiles()<CR>')


defcompile
