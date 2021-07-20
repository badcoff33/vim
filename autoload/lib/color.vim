" autoload lib colors

function! lib#color#Hi(group, guifg, guibg, attr, guisp)

  let FFg = {fgstr ->  ((fgstr == 'skip') || empty(fgstr)) ? '' : 'guifg='..(empty(fgstr) ? "foreground" : fgstr) }
  let FBg = {bgstr ->  ((bgstr == 'skip') || empty(bgstr)) ? '' : 'guibg='..(empty(bgstr) ? "background" : bgstr) }
  let FSp = {spstr ->  ((spstr == 'skip') || empty(spstr)) ? '' : 'guisp='..spstr }
  let FAttr = {astr -> (astr == 'skip')  ? '' : 'gui='.. (empty(astr) ? 'NONE' : astr) }

  execute "hi" a:group FFg(a:guifg) FBg(a:guibg) FSp(a:guisp) FAttr(a:attr)

endfunction

