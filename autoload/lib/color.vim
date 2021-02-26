" autoload lib color

function! lib#color#Hi(group, guifg, guibg, attr, guisp)
  let FallbackFg= {colorstr -> empty(colorstr) ? "foreground" : colorstr }
  let FallbackBg= {colorstr -> empty(colorstr) ? "background" : colorstr }
  let FallbackSp= {colorsp  -> empty(colorsp) ? "foreground" : colorsp }
  let FallbackAttr= {attrstr -> empty(attrstr) ? "NONE" : attrstr }

  execute "hi " .. a:group .. " guifg=" .. FallbackFg(a:guifg)
  execute "hi " .. a:group .. " guibg=" .. FallbackBg(a:guibg)
  execute "hi " .. a:group .. " guisp=" .. FallbackSp(a:guisp)
  execute "hi " .. a:group .. " gui="   .. FallbackAttr(a:attr)
endfunction

