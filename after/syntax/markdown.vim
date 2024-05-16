syn region markdownLink matchgroup=markdownLinkDelimiter
      \ start="(" end=")" keepend contained conceal contains=markdownUrl
" syn match markdownExt /{[.:#][^}]*}/ conceal contains=ALL
