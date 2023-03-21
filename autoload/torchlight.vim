vim9script

export def TorchlightClearAll()
    for item in getbufinfo({buflisted: 1})
        if !empty(prop_type_get("Warning", {bufnr: item.bufnr}))
            prop_type_delete("Warning", {bufnr: item.bufnr})
        endif
        if !empty(prop_type_get("Error", {bufnr: item.bufnr}))
            prop_type_delete("Error", {bufnr: item.bufnr})
        endif
    endfor
enddef

# Clear properties on current line
# This might work for you
#       `autocmd TextChanged * torchlight.TorchlightChanged()`
export def TorchlightChanged()
    prop_clear(line("."))
enddef

# Run as autocommand after entering buffer
export def TorchlightUpdate()
    var qf_items = getqflist({ "nr": "$", "all": 0 }).items

    for item in qf_items
        if bufnr("%") == item.bufnr
            if item.type ==? "w"
                # bufload(bufname(item.bufnr))
                if empty(prop_type_get("Warning", {bufnr: item.bufnr}))
                    prop_type_add('Warning', {bufnr: item.bufnr, highlight: 'WarningMsg'})
                endif
                prop_add(item.lnum, 0, {
                    bufnr: item.bufnr,
                    type: "Warning",
                    text: ">> " .. substitute(item.text, "\\s\\{2,\\}", " ", "g"),
                    text_align: 'below',
                    text_padding_left: 4
                })
            elseif item.type ==? "e"
                # bufload(bufname(item.bufnr))
                if empty(prop_type_get("Error", {bufnr: item.bufnr}))
                    prop_type_add('Error', {bufnr: item.bufnr, highlight: 'ErrorMsg'})
                endif
                prop_add(item.lnum, 0, {
                    bufnr: item.bufnr,
                    type: "Error",
                    text: "►" .. substitute(item.text, "\\s\\{2,\\}", " ", "g"),
                    text_align: 'below',
                    text_padding_left: 4
                })
            endif
        endif
    endfor
enddef

# uncomment during dev
defcompile
