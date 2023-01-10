vim9script

import autoload 'run.vim' as run

def CompleteHg(arg_lead: string, cmd_line: string, cur_pos: number): string
    var matching_keys = ""
    for k in sort(["commit", "status", "heads", "resolve"])
        if match(k, arg_lead) >= 0
            matching_keys = matching_keys .. k .. "\n"
        endif
    endfor
    return matching_keys
enddef

command! -complete=custom,CompleteHg -nargs=+ Hg run.Run({cmd: 'hg <args>', out_buf: true})

nnoremap <A-x>vv :<C-u>Hg<Space>
nnoremap <A-x>vs <ScriptCmd>run.Run({cmd: 'hg status -v', out_buf: true})<CR>
nnoremap <A-x>vl <ScriptCmd>run.Run({cmd: 'hg last', out_buf: true})<CR>

