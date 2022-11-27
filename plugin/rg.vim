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

let RgIncludes = {ft -> has_key(g:rg_glob_patterns, ft) ? g:rg_glob_patterns[ft].." " : " "}
let RgPaths = { -> join(g:rg_paths, " ")}
let RgPattern = { ->  len(expand("<cword>")) == 0 ? "PATTERN" : expand("<cword>") }

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

command! -complete=file -nargs=* RgFiles
      \ call run#run({'cmd':'rg --files '..' <args>', 'hidden':0, 'regexp':'%f'})

command! -complete=file -nargs=* Rg
      \ call run#run({'cmd':'rg --vimgrep '..' <args>', 'hidden':0, 'regexp':&grepformat})

nnoremap <Leader>rf :RgFiles <C-r>=RgExcludes()<CR> -g <C-r><C-w>
nnoremap <Leader>rG :Rg <C-r>=RgExcludes()<CR> <C-r>=RgIncludes(&ft)<CR> <C-r>=RgPattern()<CR> <C-r>=RgPaths()<CR>
nmap <Leader>rg <Leader>rG<CR>
