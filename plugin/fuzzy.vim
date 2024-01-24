vim9script
import autoload 'fuzzy.vim'

# filter and open buffers
def g:FuzzyBuf()
  fuzzy.FilterMenu("Buffers",
    getbufinfo({'buflisted': 1})->mapnew((_, v) => {
      return {bufnr: v.bufnr, text: (v.name ?? $'[{v.bufnr}: No Name]')}
    }),
    (res, key) => {
      if key == "\<c-t>"
        exe $":tab sb {res.bufnr}"
      else
        exe $":b {res.bufnr}"
      endif
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

nnoremap <Leader><Space> <Cmd>call FuzzyBuf()<CR>
nnoremap <Leader><S-Space> <Cmd>call FuzzyBuf()<CR>


defcompile
