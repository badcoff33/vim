vim9script
import autoload 'fuzzy.vim'

# filter and open buffers
def g:FuzzyBuf()
  fuzzy.FilterMenu("Buffers",
    getbufinfo({'buflisted': 1})->mapnew((_, v) => {
      return {bufnr: v.bufnr, text: (v.name ?? $'[{v.bufnr}: No Name]')}
    }),
    (res, key) => {
        exe $":b {res.bufnr}"
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
        exe $":e {res.text}"
    })
enddef

nnoremap <Leader>b <Cmd>call FuzzyBuf()<CR>
nnoremap <Leader>B <Cmd>call FuzzyMRU()<CR>

defcompile
