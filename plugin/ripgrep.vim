vim9script
# Vim plugin FIF - find in files
# Description: Some minor extensions to run ripgrep or Windows own findstr.

if !executable("rg")
    finish
endif

import autoload "run.vim"

g:rg_glob_patterns = {
    c:      ['*.c', "*.h", "*.850", "*.s"],
    cpp:    ['*.cc', '*.hh'],
    vim:    ['*.vim', '*vimrc'],
    asm:    ['*.850', '*.s'],
    py:     ['*.py'],
    cmake:  ['*.cmake', 'CmakeLists.txt']
}

g:rg_excludes = get(g:, "rg_excludes", [])
g:rg_paths = get(g:, "rg_paths", ["."])

g:RgPattern = () =>  len(expand("<cword>")) == 0 ? "STRING" : expand("<cword>")
g:RgPaths = () => join(g:rg_paths, " ")

def g:RgIncludes(): string
    var include_string: string
    if has_key(g:rg_glob_patterns, &ft)
        for e in g:rg_glob_patterns[&ft]
            include_string = include_string .. g:RgGlobSwitch() .. " " .. e .. " "
        endfor
    endif
    return include_string
enddef

def g:RgExcludes(): string
    var exclude_string = ""
    for e in g:rg_excludes
        exclude_string = exclude_string .. g:RgGlobSwitchExclude() .. " " .. e .. " "
    endfor
    return exclude_string
enddef

def g:RgGlobSwitchExclude(): string
    if has("unix")
        return "-g !"
    else
        return "--iglob !"
    endif
enddef

def g:RgGlobSwitch(): string
    if has("unix")
        return "-g"
    else
        return "--iglob"
    endif
enddef

# Using links? Ripgrep supports this by th option '--follow'
set grepprg=rg\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

command! -complete=file -nargs=* RgFiles run.RunStart({cmd: "rg --files" .. g:RgGlobSwitch() .. ' <args>', name: "RgFiles"})
command! -complete=file -nargs=* Rg      run.RunStart({cmd: 'rg --vimgrep ' .. ' <args>', regexp: &grepformat, no_popup: true})

nnoremap <Leader>F :RgFiles ** .<Left><Left><Left>
nnoremap <expr> <Leader>R join([":Rg", g:RgExcludes(), g:RgIncludes(), g:RgPattern(), g:RgPaths()], " ")
nmap            <Leader>r <Leader>R<CR>

