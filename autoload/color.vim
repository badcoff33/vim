" Vim autoload file

" Description: Print highlighting information at current cursor position.
function! color#InfoHighlightAttr()
  let synid = synID(line("."), col("."), 0)
  let synidtrans = synIDtrans(synid)
  echo "highlight name:" synIDattr(synidtrans, "name")
  echo "foreground:" synIDattr(synidtrans, "fg")
  echo "background:" synIDattr(synidtrans, "bg")
endfunction

function color#BlendDownWindow()
  if (&previewwindow || &buftype=='help')
    if hlexists('BlendDown') == v:true
      setlocal wincolor=BlendDown
    else
      setlocal wincolor=NonText
    endif
  endif
endfunction
