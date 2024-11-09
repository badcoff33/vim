vim9script

export def TorchlightClearAll()
    prop_type_delete("text_prop_warning")
    prop_type_delete("text_prop_error")
enddef

# Clear properties on current line
# This might work for you
#       `autocmd TextChanged * torchlight.TorchlightChanged()`
export def TorchlightChanged()
    prop_clear(line("."))
enddef

def CreateProps()
    if prop_type_get('text_prop_warning') == {}
        prop_type_add('text_prop_warning', {
            highlight: 'CursorLine'
        })
    endif
    if prop_type_get('text_prop_error') == {}
        prop_type_add('text_prop_error', {
            highlight: 'Error'
        })
    endif
enddef

# Run as autocommand after entering buffer
export def TorchlightUpdate()
    var qf_items = getqflist({ "nr": "$", "all": 0 }).items

    CreateProps()

    for item in qf_items
        if item.type ==? "w"
            bufload(item.bufnr)
            prop_add(item.lnum, 0, {
                bufnr: item.bufnr,
                type: "text_prop_warning",
                text: "> " .. substitute(item.text, "\\s\\{2,\\}", " ", "g"),
                text_align: 'below',
                text_padding_left: 0
            })
        elseif item.type ==? "e"
            bufload(item.bufnr)
            prop_add(item.lnum, 0, {
                bufnr: item.bufnr,
                type: "text_prop_error",
                text: "> " .. substitute(item.text, "\\s\\{2,\\}", " ", "g"),
                text_align: 'below',
                text_padding_left: 0
            })
        elseif item.valid == 1
            bufload(item.bufnr)
            prop_add(item.lnum, 0, {
                bufnr: item.bufnr,
                type: "text_prop_warning",
                text: " " .. substitute(item.text, "\\s\\{2,\\}", " ", "g"),
                text_align: 'below',
                text_padding_left: 0
            })
        endif
    endfor
enddef

# uncomment during dev
defcompile

