" autoload lib color

function! lib#color#Hi(group, guifg, guibg, attr, guisp)

  let FFg = {fgstr -> (fgstr == 'skip') ? '' : 'guifg='..(empty(fgstr) ? "foreground" : fgstr) }
  let FBg = {bgstr -> (bgstr == 'skip') ? '' : 'guibg='..(empty(bgstr) ? "background" : bgstr) }
  let FSp = {spstr -> (spstr == 'skip' || empty(spstr)) ? '' : 'guisp='..spstr }
  let FAttr = {astr -> (astr == 'skip' || empty(astr)) ? '' : 'gui='..astr }

  execute "hi" a:group FFg(a:guifg) FBg(a:guibg) FSp(a:guisp) FAttr(a:attr)
"  echo "hi" a:group FFg(a:guifg) FBg(a:guibg) FSp(a:guisp) FAttr(a:attr)


endfunction

