vim9script

var torchlight_warnings: list<dict<any>>
var torchlight_errors: list<dict<any>>

export def TorchlightClearAll()
    prop_type_delete('Error')
    prop_type_delete('Warning')
    torchlight_errors = []
    torchlight_warnings = []
enddef

export def TorchlightEdit()
    prop_remove({types: ["Error", "Warning"]}, line("."))
enddef

# Run as autocommand after quickfix has been updated
export def TorchlightUpdate()
    torchlight_errors = []
    torchlight_warnings = []

    prop_type_add('Error', {highlight: 'ErrorMsg'})
    prop_type_add('Warning', {highlight: 'ModeMsg'})

    for e in getqflist({ "nr": "$", "all": 0 }).items
        if e.type ==? "e"
            torchlight_errors = add(torchlight_errors, {
                bufnr: e.bufnr,
                lnum: e.lnum,
                text: e.text
            })
        endif
        if e.type ==? "w"
            torchlight_warnings = add(torchlight_warnings, {
                bufnr: e.bufnr,
                lnum: e.lnum,
                text: e.text
            })
        endif
    endfor

enddef

export def TorchlightInCurrentBuf()
     var b = bufnr("%")

     for w in torchlight_warnings
         if w.bufnr ==  b
             prop_add(w.lnum, 0, {
                 type: 'Warning',
                 text:  " " .. w.text,
                 text_align: 'below',
                 text_padding_left: 4
             })
         endif
     endfor

     for e in torchlight_errors
         if e.bufnr ==  b
             prop_add(e.lnum, 0, {
                 type: 'Error',
                 text:  " " .. e.text,
                 text_align: 'below',
                 text_padding_left: 4
             })
         endif
     endfor

enddef

# uncomment during dev
defcompile
