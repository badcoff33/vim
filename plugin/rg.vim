" Vim plugin FIF - find in files
" Description: Some minor extensions to run ripgrep or Windows own findstr.

if !executable("rg")
  finish
endif

let g:rg_glob_patterns = {
      \ 'c': '-g *.c -g *.h -g *.850 -g *.s',
      \ 'cpp': '-tcpp -tc',
      \ 'vim': '-g *.vim -g *vimrc',
      \ 'asm850': '-g *.850 -g *.c -g *.h',
      \ 'py': '-tpy',
      \ 'cmake': '-tcmake',
      \ }

let g:rg_excludes = get(g:, "rg_excludes", [])
let g:rg_paths = get(g:, "rg_paths", ["."])

let RgIncludes =  {ft -> has_key(g:rg_glob_patterns, ft) ? g:rg_glob_patterns[ft].." " : " "}
let RgPaths =     { -> join(g:rg_paths, " ")}

function RgExcludes()
  let exclude_string = ""
  for e in g:rg_excludes
    let exclude_string .= "-g !" .. e .. " "
  endfor
  return exclude_string
endfunction
" Using links? Ripgrep supports this by th option '--follow'
set grepprg=rg\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

command! -complete=file -nargs=* Rg
      \ call run#run({'cmd':'rg --vimgrep '..' <args>', 'hidden':0, 'regexp':&grepformat})

command! -complete=file -nargs=* RgFiles enew | read !rg --files --glob-case-insensitive --glob *<args>*

nnoremap <Leader>G :Rg <C-r>=RgExcludes()<CR> <C-r>=RgIncludes(&ft)<CR> <C-r><C-W> <C-r>=RgPaths()<CR>
nmap <Leader>g :let @/="<C-r><C-w>"<CR><Leader>G<CR>
