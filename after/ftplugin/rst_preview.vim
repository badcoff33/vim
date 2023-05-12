" reStructuredText filetype plugin file
" A nice one: Learn RST her http://rst.ninjs.org/
" Desciption: Preview in HTML

let b:rst_css_file = g:vim_home .. "\\templates\\simple.css"
if !filereadable(b:rst_css_file)
  let b:rst_css_file =  ""
else
  let b:rst_css_file = " --css=" .. b:rst_css_file
endif

let b:rst_template_file = g:vim_home .. "\\templates\\template.html"
if !filereadable(b:rst_template_file)
 let b:rst_template_file = ""
else
  let b:rst_template_file = " --template=" .. b:rst_template_file
endif

function! s:OpenHTML()
    exe "terminal ++close ++hidden cmd /C start" b:rst_temp_html_file
endfunction

let b:rst_temp_file = getenv("TEMP") .. expand("/") .. "_" .. expand("%:t")
let b:rst_temp_html_file = getenv("TEMP") .. expand("/") .. expand("%:t") .. ".html"

function! s:ComputeCommand(file)
    return "pandoc -f rst -t html5 --toc --toc-depth=3"
                \ .. b:rst_css_file
                \ .. b:rst_template_file
                \ .. " --metadata title=\"" .. expand("%:t:r") .. "\""
                \ .. " -o " .. b:rst_temp_html_file
                \ .. " " .. b:rst_temp_file
endfunction

function! s:MakeHTML(...)
    if filereadable(expand("%"))
        let b:rst_command = s:ComputeCommand(expand("%"))
        silent exe "write!" b:rst_temp_file
        silent exe "bwipeout!" b:rst_temp_file
        call run#RunStart(#{
                    \ cmd: b:rst_command,
                    \ background: v:true,
                    \ no_write: v:true
                    \ })
    endif
endfunction

command! -buffer RstOpenPreview call <SID>OpenHTML()
command! -buffer RstUpdatePreview call <SID>MakeHTML()

autocmd FocusLost <buffer> call <SID>MakeHTML()
