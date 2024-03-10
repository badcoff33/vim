vim9script
import autoload 'fuzzy.vim'
import autoload 'utils.vim'

# filter and open buffers
def g:FuzzyBuf()
  fuzzy.FilterMenu("Buffers",
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

def FuzzyTagsFilterFunc(tags_filename: string, file: string): bool
  var a = substitute(tags_filename, "[\\.\\\\/]", "", "g")
  var b = substitute(file, "[\\.\\\\/]", "", "g")
  if a == b
    return true
  endif
  return false
enddef

# filter and open tags of current buffer
# aaa/fdgfdg/ccc.x
def g:FuzzyTags()
  var current_file = expand('%')
  var buf_tag_dict = filter(taglist('.'), (key, val) => FuzzyTagsFilterFunc(val['filename'], current_file))
  fuzzy.FilterMenu("Tags",
    mapnew(buf_tag_dict, (key, val) => val['name']),
    (res, key) => {
      var cmd = filter(buf_tag_dict, 'v:val["name"] == "' .. res.text .. '"')[0]['cmd']
      execute ":" .. escape(cmd, '*')
    })
enddef

# filter and open MRU (Most Recently Used) aka oldfiles
def g:FuzzyMRU()
  fuzzy.FilterMenu("MRU",
    v:oldfiles->copy()->filter((_, v) => {
      return filereadable(expand(v)) &&
        expand(v)->stridx(expand("$VIMRUNTIME")) == -1
    }),
    (res, key) => {
      if key == "\<c-t>"
        exe $":tab sb {res.bufnr}"
      else
        exe $":e {res.text}"
      endif
    })
enddef

utils.Map('nnoremap', '<Leader>1', '<Cmd>call FuzzyBuf()<CR>')
utils.Map('nnoremap', '<Leader>2', '<Cmd>call FuzzyTags()<CR>')
utils.Map('nnoremap', '<Leader>3', '<Cmd>call FuzzyMRU()<CR>')


defcompile
