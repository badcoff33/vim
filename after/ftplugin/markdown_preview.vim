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

let b:markdown_command = "pandoc -f gfm -t html5 --toc --toc-depth=3"
      \ .. b:markdown_css_file
      \ .. b:markdown_template_file
      \ .." --metadata title=\""..expand("%:t:r").."\""
      \ .." -o "..getenv("TEMP")..g:slash..expand("%:t")..".html"
      \ .." "..getenv("TEMP")..g:slash.."_"..expand("%:t")

function! s:OpenHTML()
    exe "terminal ++close ++hidden cmd /C start" getenv("TEMP")..g:slash..expand("%:t")..".html"
endfunction

function! s:MakeHTML(...)
    if exists("b:markdown_command")
        silent exe "write!" getenv("TEMP")..g:slash.."_"..expand("%:t")
        silent exe "bwipeout!" getenv("TEMP")..g:slash.."_"..expand("%:t")
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

