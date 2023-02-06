vim9script

export def TorchlightClearAll()
    var qf_items = getqflist({ "nr": "$", "all": 0 }).items

    prop_clear(1, line("$"))

    for item in qf_items
        if !empty(prop_type_get("Warning", {bufnr: item.bufnr}))
            prop_type_delete("Warning", {bufnr: item.bufnr})
        endif
        if !empty(prop_type_get("Error", {bufnr: item.bufnr}))
            prop_type_delete("Error", {bufnr: item.bufnr})
        endif
    endfor
enddef

export def TorchlightChanged()
    prop_clear(line("."))
enddef

# Run as autocommand after entering buffer
export def TorchlightUpdate()
    var qf_items = getqflist({ "nr": "$", "all": 0 }).items

    prop_clear(1, line("$"))

    for item in qf_items
        if item.type ==? "w"
            if empty(prop_type_get("Warning", {bufnr: item.bufnr}))
                prop_type_add('Warning', {bufnr: item.bufnr, highlight: 'WarningMsg'})
            endif
            prop_add(item.lnum, 0, {
                bufnr: item.bufnr,
                type: "Warning",
                text: item.text,
                text_align: 'below',
                text_padding_left: 4
            })
        elseif item.type ==? "e"
            if empty(prop_type_get("Error", {bufnr: item.bufnr}))
                prop_type_add('Error', {bufnr: item.bufnr, highlight: 'ErrorMsg'})
            endif
            prop_add(item.lnum, 0, {
                bufnr: item.bufnr,
                type: "Error",
                text: item.text,
                text_align: 'below',
                text_padding_left: 4
            })
        endif
    endfor
enddef

# uncomment during dev
defcompile
