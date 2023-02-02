vim9script

prop_type_delete('Error')
prop_type_delete('Warning')

prop_type_add('Error', {highlight: 'ErrorMsg'})
prop_type_add('Warning', {highlight: 'ModeMsg'})

export def TorchlightClearAll()
    prop_clear(1, line("$"))
enddef

export def TorchlightChanged()
    prop_clear(line("."))
enddef


# Run as autocommand after entering buffer
export def TorchlightInCurrentBuf()
    var key_b = string(bufnr("%"))
    var qf_items = getqflist({ "nr": "$", "all": 0 }).items

    prop_clear(1, line("$"))

    for item in qf_items
        if item.bufnr == str2nr(key_b)
            if item.type ==? "e" || item.type ==? "w"
                prop_add(item.lnum, 0, {
                    type: item.type ==? "e" ? "Error" : "Warning",
                    text:  " " .. item.text,
                    text_align: 'below',
                    text_padding_left: 4
                })
            endif
        endif
    endfor
enddef

# uncomment during dev
defcompile
