" Vim plugin FIF - find in files
" Description: Some minor extensions to run ripgrep or Windows own findstr.

if !executable("rg")
  finish
endif

let g:rg_glob_patterns = {
      \ 'c': '-tc',
      \ 'cpp': '-tcpp',
      \ 'vim': '-g *.vim -g *vimrc',
      \ 'asm': '-g *.850',
      \ 'py': '-tpy',
      \ 'cmake': '-tcmake',
      \ }

let RgIncludes = {ft -> has_key(g:rg_glob_patterns, ft) ? g:rg_glob_patterns[ft].." " : "-g *.* "}
let RgExcludes = { -> "-g !"..join(get(g:, "rg_excludes", []), " -g !").." "}
let RgPaths =    { -> join(get(g:, "rg_paths", ["."]), " ")}

" Using links? Ripgrep supports this by th option '--follow'
set grepprg=rg\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

command! -complete=file -nargs=* Rg
      \ call run#run({'cmd':'rg --vimgrep '..RgExcludes()..RgIncludes(&ft)..' <args> '..RgPaths(), 'hidden':0, 'regexp':&grepformat})

command! -complete=file -nargs=* RgFiles
      \ call run#run({'cmd':"rg --files --glob-case-insensitive --glob *<args>*"})

nnoremap <Leader>G :Rg <C-r><C-W>
nmap <Leader>g <Leader>G<CR>
