" Colorscheme: little monster

let g:colors_name = "little_monster"
set background=dark

if exists('&wincolor')
  augroup Wincolor
    au!
    " Low-key colors for non-file buffers
    autocmd BufWinEnter,WinEnter * if (&buftype!='' && &buftype!='nofile')
          \ | set wincolor=BlendDown | else | set wincolor= | endif
  augroup END
elseif exists('&winhighlight')
  augroup Winhighlight
    au!
    " Low-key colors for non-file buffers
    autocmd BufWinEnter,WinEnter * if &readonly
          \ | set winhighlight=Normal:BlendDown | set winhighlight= | endif
  augroup END
endif

let s:white             = "#FFFFFF"
let s:workbench_passive = "#272F3F"
let s:workbench_active  = "#373F5F"
let s:workbench_grey    = "#3E4468"
let s:background        = "#1D2433"
let s:background_plus   = "#212735"
let s:foreground        = "#B2BACC"
let s:accent            = "#FFCC66"
let s:red               = "#EF6B73"
let s:green             = "#BAE67E"
let s:yellow            = "#FFD580"
let s:orange            = "#FFAE57"
let s:blue              = "#5CAFE0"
let s:purple            = "#C3A6FF"
let s:white             = "#D7DCE2"
let s:light_silver      = "#90909F"
let s:silver            = "#70707A"

let GuiFg = {str -> empty(str) ? "":"guifg=".str}
let GuiBg = {str -> empty(str) ? "":"guibg=".str}
let GuiAttr = {str -> empty(str) ? "":"gui=".str}

" Editor
execute 'hi ColorColumn'  GuiBg(s:light_silver)
execute 'hi Cursor' GuiFg(s:yellow) GuiBg(s:silver) GuiAttr('NONE')
execute 'hi CursorLine' GuiBg(s:background_plus)
execute 'hi Error' GuiFg(s:red) GuiBg('bg')
execute 'hi iCursor' GuiFg(s:light_silver) GuiBg(s:workbench_grey)
execute 'hi LineNr' GuiFg(s:light_silver) GuiBg('bg')
execute 'hi MatchParen' GuiFg(s:blue) GuiBg(s:workbench_grey)
execute 'hi NonText' GuiFg(s:red) GuiBg(s:silver)
execute 'hi Normal' GuiFg(s:foreground) GuiBg(s:background)
execute 'hi PMenu' GuiFg(s:background_plus) GuiBg(s:light_silver) GuiAttr('NONE')
execute 'hi PmenuSbar' GuiFg(s:silver) GuiBg(s:silver)
execute 'hi PmenuThumb' GuiFg(s:blue) GuiBg(s:workbench_grey)
execute 'hi SpecialKey' GuiFg(s:silver)
execute 'hi SpellBad' GuiFg(s:red) GuiBg('bg') GuiAttr('undercurl')
execute 'hi SpellCap' GuiFg(s:yellow) GuiBg('bg') GuiAttr('undercurl')
execute 'hi SpellLocal' GuiFg(s:red) GuiBg('bg') GuiAttr('undercurl')
execute 'hi SpellRare' GuiFg(s:red) GuiBg('bg') GuiAttr('undercurl')
execute 'hi Visual' GuiFg(s:workbench_grey) GuiBg(s:blue)
execute 'hi VisualNOS' GuiFg(s:foreground) GuiBg(s:blue)
execute 'hi Whitespace' GuiFg(s:silver)
hi! link PMenuSel IncSearch
hi! link CursorColumn CursorLine

" Frost specific
execute 'hi BlendDown' GuiFg(s:light_silver) GuiBg(s:background_plus)

" Neovim Support
execute 'hi healthError' GuiFg(s:red) GuiBg(s:light_silver)
execute 'hi healthSuccess' GuiFg(s:green) GuiBg(s:light_silver)
execute 'hi healthWarning' GuiFg(s:yellow) GuiBg(s:light_silver)
execute 'hi TermCursorNC'  GuiBg(s:light_silver)

" Gutter
execute 'hi CursorLineNr' GuiFg(s:purple) GuiBg(s:background_plus) GuiAttr('NONE')
execute 'hi FoldColumn' GuiFg(s:workbench_grey) GuiBg(s:background)
execute 'hi Folded' GuiFg(s:red) GuiBg(s:background) GuiAttr('bold')
execute 'hi SignColumn' GuiFg(s:light_silver) GuiBg(s:background)

" Navigation
execute 'hi Directory' GuiFg(s:blue) GuiAttr('underline')

" Prompt/Status
execute 'hi EndOfBuffer' GuiFg(s:light_silver) GuiBg('bg')
execute 'hi ErrorMsg' GuiFg(s:red) GuiBg('bg')
execute 'hi ModeMsg' GuiFg(s:green) GuiBg('bg') GuiAttr('' )
execute 'hi MoreMsg' GuiFg(s:yellow) GuiBg('bg') GuiAttr('' )
execute 'hi Question' GuiFg(s:accent) GuiBg('bg')
execute 'hi StatusLine' GuiFg(s:yellow) GuiBg(s:workbench_active) GuiAttr('bold')
execute 'hi StatusLineNC' GuiFg(s:yellow) GuiBg(s:workbench_passive) GuiAttr('NONE')
execute 'hi VertSplit' GuiFg(s:workbench_passive) GuiBg(s:workbench_passive) GuiAttr('NONE')
execute 'hi WarningMsg' GuiFg(s:accent) GuiBg('bg')
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link WildMenu IncSearch

" Search
execute 'hi IncSearch' GuiFg(s:background) GuiBg(s:green) GuiAttr('bold')
execute 'hi Search' GuiFg(s:white) GuiBg(s:workbench_grey) GuiAttr('underline')

" QuickFix
execute 'hi qfSeparator' GuiFg('fg') GuiBg('bg')
execute 'hi QuickFixLine' GuiFg('fg') GuiBg('bg') GuiAttr('bold')
hi! link qfFileName Directory
hi! link qfLineNr Directory

" Tabs
execute 'hi TabLineSel' GuiFg(s:yellow) GuiBg(s:workbench_active) GuiAttr('bold')
execute 'hi TabLine' GuiFg(s:yellow) GuiBg(s:workbench_passive) GuiAttr('none')
hi! link TabLineSel StatusLine
hi! link TabLineFill Normal

" Window
execute 'hi Title' GuiFg(s:green)  GuiAttr('bold')
execute 'hi Bold'   GuiAttr('bold')
execute 'hi Italic'   GuiAttr('italic')
execute 'hi Boolean' GuiFg(s:blue)
execute 'hi Character' GuiFg(s:yellow)
execute 'hi Comment' GuiFg(s:green)
execute 'hi Conditional' GuiFg(s:orange)
execute 'hi Constant' GuiFg(s:accent)
execute 'hi Define' GuiFg(s:orange)
execute 'hi Delimiter' GuiFg(s:blue)
execute 'hi Exception' GuiFg(s:blue)
execute 'hi Float' GuiFg(s:purple)
execute 'hi Function' GuiFg(s:blue)
execute 'hi Identifier' GuiFg(s:green)  GuiAttr('NONE')
execute 'hi Include' GuiFg(s:blue)
execute 'hi Keyword' GuiFg(s:blue)
execute 'hi Label' GuiFg(s:blue)
execute 'hi Number' GuiFg(s:purple)
execute 'hi Operator' GuiFg(s:yellow)  GuiAttr('NONE')
execute 'hi PreProc' GuiFg(s:blue)  GuiAttr('NONE')
execute 'hi Repeat' GuiFg(s:blue)
execute 'hi Special' GuiFg(s:accent)
execute 'hi SpecialChar' GuiFg(s:yellow)
execute 'hi SpecialComment' GuiFg(s:blue)
execute 'hi Statement' GuiFg(s:orange)
execute 'hi StorageClass' GuiFg(s:blue)
execute 'hi String' GuiFg(s:purple)
execute 'hi Structure' GuiFg(s:blue)
execute 'hi Tag' GuiFg(s:silver)
execute 'hi Todo' GuiFg(s:yellow) GuiBg('NONE')
execute 'hi Type' GuiFg(s:blue)  GuiAttr('NONE')
execute 'hi Typedef' GuiFg(s:blue)
hi! link Macro Define
hi! link PreCondit PreProc

execute 'hi DiffAdd' GuiFg(s:green) GuiBg(s:workbench_passive)
execute 'hi DiffChange' GuiFg(s:yellow) GuiBg(s:workbench_passive) GuiAttr('bold')
execute 'hi DiffDelete' GuiFg(s:red) GuiBg(s:red)
execute 'hi DiffText' GuiFg(s:blue) GuiBg(s:workbench_passive)

execute 'hi cIncluded' GuiFg(s:blue)
hi! link cOperator Operator
hi! link cPreCondit PreCondit

execute 'hi htmlArg' GuiFg(s:blue)
execute 'hi htmlLink' GuiFg(s:silver)  GuiAttr('NONE')
hi! link htmlBold Bold
hi! link htmlEndTag htmlTag
hi! link htmlItalic Italic
hi! link htmlH1 markdownH1
hi! link htmlH2 markdownH1
hi! link htmlH3 markdownH1
hi! link htmlH4 markdownH1
hi! link htmlH5 markdownH1
hi! link htmlH6 markdownH1
hi! link htmlSpecialChar SpecialChar
hi! link htmlTag Keyword
hi! link htmlTagN htmlTag

execute 'hi markdownBlockquote' GuiFg(s:blue)
execute 'hi markdownCode' GuiFg(s:background_plus) GuiBg('bg')
execute 'hi markdownCodeBlock' GuiFg(s:background_plus) GuiBg('bg')
execute 'hi markdownCodeDelimiter' GuiFg(s:green) GuiBg('bg')
execute 'hi markdownFootnote' GuiFg(s:blue)
execute 'hi markdownId' GuiFg(s:blue)
execute 'hi markdownIdDeclaration' GuiFg(s:blue)
execute 'hi markdownH1' GuiFg(s:yellow)
execute 'hi markdownLinkText' GuiFg(s:blue)
execute 'hi markdownUrl' GuiFg(s:light_silver)  GuiAttr('underline')
hi! link markdownBold Bold
hi! link markdownItalic Italic
hi! link markdownItalicDelimiter Keyword
hi! link markdownBoldDelimiter Keyword
hi! link markdownFootnoteDefinition markdownFootnote
hi! link markdownH2 markdownH1
hi! link markdownH3 markdownH1
hi! link markdownH4 markdownH1
hi! link markdownH5 markdownH1
hi! link markdownH6 markdownH1
hi! link markdownIdDelimiter Keyword
hi! link markdownLinkDelimiter Keyword
hi! link markdownLinkTextDelimiter Keyword
hi! link markdownListMarker Keyword
hi! link markdownRule Keyword
hi! link markdownHeadingDelimiter Keyword
