vim9script
# Vim plugin FIF - find in files
# Description: Some minor extensions to run ripgrep or Windows own findstr.

if !executable("rg")
    finish
endif

import autoload "run.vim"

g:rg_excludes = get(g:, "rg_excludes", [])
g:rg_paths = get(g:, "rg_paths", ["."])
g:rg_option_all = get(g:, "rg_option_all", false)
g:rg_find_files_options = get(g:, "rg_find_files_options", "-u")

g:rg_glob_patterns = {
    c:      ['*.c', '*.h', '*.850', '*.s'],
    cpp:    ['*.c', '*.h', '*.850', '*.s', '*.cc', '*.hh'],
    vim:    ['*.vim', '*vimrc'],
    asm:    ['*.850', '*.s'],
    py:     ['*.py'],
    cmake:  ['*.cmake', 'CmakeLists.txt']
}

g:RgPattern = () =>  len(expand("<cword>")) == 0 ? "STRING" : '\b' .. expand("<cword>") .. '\b'
g:RgPaths = () => join(g:rg_paths, " ")

g:rg_dict = {}

def g:RgPrettyPrint()
    for e in getqflist({ "nr": "$", "all": 0 }).items
        var temp: list<number>
        if has_key(g:rg_dict, e.bufnr)
            temp = g:rg_dict[e.bufnr]
        else
            temp = []
        endif
        add(temp, e.lnum)
        g:rg_dict[e.bufnr] = temp
    endfor
enddef

def g:RgIncludes(): string
    var include_string: string
    if g:rg_option_all == true
        include_string = g:RgGlobSwitch("*")
    else
        if has_key(g:rg_glob_patterns, &ft)
            for e in g:rg_glob_patterns[&ft]
                include_string = include_string .. g:RgGlobSwitch(e) .. " "
            endfor
        endif
    endif
    return include_string
enddef

def g:RgExcludes(): string
    var exclude_string = ""
    for e in g:rg_excludes
        exclude_string = exclude_string .. RgGlobSwitchExclude(e) .. " "
    endfor
    return exclude_string
enddef

def RgGlobSwitchExclude(anti_pattern: string): string
    if has("unix")
        return "-g !" .. anti_pattern
    else
        return "--iglob !" .. anti_pattern
    endif
enddef

def g:RgGlobSwitch(pattern: string): string
    if has("unix")
        return "-g " .. pattern
    else
        return "--iglob " .. pattern
    endif
enddef

def g:RgConfig()
    echo printf("g:rg_paths\t= %s", join(g:rg_paths, ", "))
    echo printf("g:rg_excludes\t= %s", join(g:rg_excludes, ", "))
    echo printf("g:rg_option_all\t= %s", g:rg_option_all)
enddef

# Using links? Ripgrep supports this by the option '--follow'
set grepprg=rg\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

command!                -nargs=0 RgConfig call g:RgConfig()
command! -complete=file -nargs=* RgFiles run.RunStart({cmd: "rg --files " .. g:rg_find_files_options .. " " .. g:RgGlobSwitch('<args>'), name: "RgFiles"})
command! -complete=file -nargs=* Rg      run.RunStart({cmd: 'rg --vimgrep ' .. ' <args>', regexp: &grepformat, no_popup: true})

nnoremap <Leader>F :RgFiles ** .<Left><Left><Left>
nnoremap <expr> <Leader>R join([":Rg", g:RgExcludes(), g:RgIncludes(), g:RgPattern(), g:RgPaths()], " ")
nmap <silent> <Leader>r <Leader>R<CR>
