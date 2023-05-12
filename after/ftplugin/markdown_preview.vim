" Preview Markdown as HTML

let b:markdown_css_file = g:vim_home .. "\\templates\\simple.css"
if !filereadable(b:markdown_css_file)
  let b:markdown_css_file =  ""
else
  let b:markdown_css_file = " --css=" .. b:markdown_css_file
endif

let b:markdown_template_file = g:vim_home .. "\\templates\\template.html"
if !filereadable(b:markdown_template_file)
 let b:markdown_template_file = ""
else
  let b:markdown_template_file = " --template=" .. b:markdown_template_file
endif

let b:markdown_temp_file = getenv("TEMP") .. expand("/") .. "_" .. expand("%:t")
let b:markdown_temp_html_file = getenv("TEMP") .. expand("/") .. expand("%:t") .. ".html"

function! s:OpenHTML()
    exe "terminal ++close ++hidden cmd /C start" b:markdown_temp_html_file
endfunction

function! s:ComputeCommand(file)
    return "pandoc -f gfm -t html5 --toc --toc-depth=3"
                \ .. b:markdown_css_file
                \ .. b:markdown_template_file
                \ .. " --metadata title=\"" .. expand("%:t:r") .. "\""
                \ .. " -o " .. b:markdown_temp_html_file
                \ .. " " .. b:markdown_temp_file
endfunction

function! s:MakeHTML(...)
    if filereadable(expand("%"))
        let b:markdown_command = s:ComputeCommand(expand("%"))
        let b:markdown_temp_file = getenv("TEMP") .. expand("/") .. "_" .. expand("%:t")
        silent exe "write!" b:markdown_temp_file
        silent exe "bwipeout!" b:markdown_temp_file
        call run#RunStart(#{
                    \ cmd: b:markdown_command,
                    \ background: v:true,
                    \ no_write: v:true
                    \ })
    endif
endfunction

command! -buffer MarkdownOpenPreview call <SID>OpenHTML()
command! -buffer MarkdownUpdatePreview call <SID>MakeHTML()

autocmd FocusLost <buffer> call s:MakeHTML()

