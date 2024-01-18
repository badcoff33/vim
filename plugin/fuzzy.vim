vim9script
import autoload 'fuzzy.vim'

# filter and open buffers
def g:FBuf()
  fuzzy.FilterMenu("Buffers",
    getbufinfo({'buflisted': 1})->mapnew((_, v) => {
      return {bufnr: v.bufnr, text: (v.name ?? $'[{v.bufnr}: No Name]')}
    }),
    (res, key) => {
      if key == "\<c-t>"
        exe $":tab sb {res.bufnr}"
      elseif key == "\<c-j>"
        exe $":sb {res.bufnr}"
      elseif key == "\<c-v>"
        exe $":vert sb {res.bufnr}"
      else
        exe $":b {res.bufnr}"
      endif
    })
enddef


# filter and open MRU (Most Recently Used) aka oldfiles
def g:FMRU()
  fuzzy.FilterMenu("MRU",
    v:oldfiles->copy()->filter((_, v) => {
      return filereadable(expand(v)) &&
        expand(v)->stridx(expand("$VIMRUNTIME")) == -1
    }),
    (res, key) => {
      if key == "\<c-t>"
        exe $":tab e {res.text}"
      elseif key == "\<c-j>"
        exe $":split {res.text}"
      elseif key == "\<c-v>"
        exe $":vert split {res.text}"
      else
        exe $":e {res.text}"
      endif
    })
enddef

defcompile
