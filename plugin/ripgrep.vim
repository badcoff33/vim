vim9script
# Vim plugin FIF - find in files
# Description: Some minor extensions to run ripgrep or Windows own findstr.

import autoload "run.vim"

if !executable("rg")
    finish
endif

g:rg_glob_patterns = {
    c: '-g *.c -g *.h -g *.850 -g *.s',
    cpp: '-tcpp -tc',
    vim: '-g *.vim -g *vimrc',
    asm850: '-g *.850 -g *.c -g *.h',
    py: '-tpy',
    cmake: '-tcmake',
}

g:rg_excludes = get(g:, "rg_excludes", [])
g:rg_paths = get(g:, "rg_paths", ["."])

g:RgIncludes = (ft) => has_key(g:rg_glob_patterns, ft) ? g:rg_glob_patterns[ft] : ""
g:RgPattern = () =>  len(expand("<cword>")) == 0 ? "STRING" : expand("<cword>")

def g:RgExcludes(): string
    var exclude_string = ""
    for e in g:rg_excludes
        exclude_string = exclude_string .. " -g !" .. e
    endfor
    return exclude_string
enddef

def g:RgGlobSwitch(): string
    if has("unix")
        return " -g "
    else
        return " --iglob "
    endif
enddef

# Using links? Ripgrep supports this by th option '--follow'
set grepprg=rg\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

command! -complete=file -nargs=* RgFiles run.Run({cmd: "rg --files" .. g:RgGlobSwitch() .. join(split(<q-args>, " "), g:RgGlobSwitch() ), name: "RG-OUTPUT"})
command! -complete=file -nargs=* Rg      run.Run({cmd: 'rg --vimgrep ' .. ' <args> ' .. join(g:rg_paths, " "), regexp: &grepformat, no_popup: true})
command! -complete=file -nargs=* RgNoDir run.Run({cmd: 'rg --vimgrep ' .. ' <args> ', regexp: &grepformat, no_popup: true})

nnoremap <Leader>F :RgFiles<C-r>=g:RgExcludes()<CR><C-r>=g:RgGlobSwitch()<CR> **<Left>
nnoremap <Leader>R :Rg <C-r>=g:RgExcludes()<CR> <C-r>=RgIncludes(&ft)<CR> <C-r>=RgPattern()<CR>
nnoremap <Leader>r :Rg <C-r>=g:RgExcludes()<CR> <C-r>=RgIncludes(&ft)<CR> <C-r>=RgPattern()<CR><CR>
