" Colorscheme: little monster

let g:colors_name = "little_monster"
set background=dark

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

let s:GuiFg = {str -> empty(str) ? "":"guifg=".str}
let s:GuiBg = {str -> empty(str) ? "":"guibg=".str}
let s:GuiAttr = {str -> empty(str) ? "":"gui=".str}

" Editor
execute 'hi ColorColumn'  s:GuiBg(s:light_silver)
execute 'hi Cursor' s:GuiFg(s:yellow) s:GuiBg(s:silver) s:GuiAttr('NONE')
execute 'hi CursorLine' s:GuiBg(s:background_plus)
execute 'hi Error' s:GuiFg(s:red) s:GuiBg('bg')
execute 'hi iCursor' s:GuiFg(s:light_silver) s:GuiBg(s:workbench_grey)
execute 'hi LineNr' s:GuiFg(s:light_silver) s:GuiBg('bg')
execute 'hi MatchParen' s:GuiFg(s:blue) s:GuiBg(s:workbench_grey)
execute 'hi NonText' s:GuiFg(s:red) s:GuiBg(s:silver)
execute 'hi Normal' s:GuiFg(s:foreground) s:GuiBg(s:background)
execute 'hi PMenu' s:GuiFg(s:background_plus) s:GuiBg(s:light_silver) s:GuiAttr('NONE')
execute 'hi PmenuSbar' s:GuiFg(s:silver) s:GuiBg(s:silver)
execute 'hi PmenuThumb' s:GuiFg(s:blue) s:GuiBg(s:workbench_grey)
execute 'hi SpecialKey' s:GuiFg(s:silver)
execute 'hi SpellBad' s:GuiFg(s:red) s:GuiBg('bg') s:GuiAttr('undercurl')
execute 'hi SpellCap' s:GuiFg(s:yellow) s:GuiBg('bg') s:GuiAttr('undercurl')
execute 'hi SpellLocal' s:GuiFg(s:red) s:GuiBg('bg') s:GuiAttr('undercurl')
execute 'hi SpellRare' s:GuiFg(s:red) s:GuiBg('bg') s:GuiAttr('undercurl')
execute 'hi Visual' s:GuiFg(s:workbench_grey) s:GuiBg(s:blue)
execute 'hi VisualNOS' s:GuiFg(s:foreground) s:GuiBg(s:blue)
execute 'hi Whitespace' s:GuiFg(s:silver)
hi! link PMenuSel IncSearch
hi! link CursorColumn CursorLine

" Frost specific
execute 'hi BlendDown' s:GuiFg(s:light_silver) s:GuiBg(s:background_plus)

" Neovim Support
execute 'hi healthError' s:GuiFg(s:red) s:GuiBg(s:light_silver)
execute 'hi healthSuccess' s:GuiFg(s:green) s:GuiBg(s:light_silver)
execute 'hi healthWarning' s:GuiFg(s:yellow) s:GuiBg(s:light_silver)
execute 'hi TermCursorNC'  s:GuiBg(s:light_silver)

" Gutter
execute 'hi CursorLineNr' s:GuiFg(s:purple) s:GuiBg(s:background_plus) s:GuiAttr('NONE')
execute 'hi FoldColumn' s:GuiFg(s:workbench_grey) s:GuiBg(s:background)
execute 'hi Folded' s:GuiFg(s:red) s:GuiBg(s:background) s:GuiAttr('bold')
execute 'hi SignColumn' s:GuiFg(s:light_silver) s:GuiBg(s:background)

" Navigation
execute 'hi Directory' s:GuiFg(s:blue) s:GuiAttr('underline')

" Prompt/Status
execute 'hi EndOfBuffer' s:GuiFg(s:light_silver) s:GuiBg('bg')
execute 'hi ErrorMsg' s:GuiFg(s:red) s:GuiBg('bg')
execute 'hi ModeMsg' s:GuiFg(s:green) s:GuiBg('bg') s:GuiAttr('' )
execute 'hi MoreMsg' s:GuiFg(s:yellow) s:GuiBg('bg') s:GuiAttr('' )
execute 'hi Question' s:GuiFg(s:accent) s:GuiBg('bg')
execute 'hi StatusLine' s:GuiFg(s:yellow) s:GuiBg(s:workbench_active) s:GuiAttr('bold')
execute 'hi StatusLineNC' s:GuiFg(s:yellow) s:GuiBg(s:workbench_passive) s:GuiAttr('NONE')
execute 'hi VertSplit' s:GuiFg(s:workbench_passive) s:GuiBg(s:workbench_passive) s:GuiAttr('NONE')
execute 'hi WarningMsg' s:GuiFg(s:accent) s:GuiBg('bg')
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link WildMenu IncSearch

" Search
execute 'hi IncSearch' s:GuiFg(s:background) s:GuiBg(s:green) s:GuiAttr('bold')
execute 'hi Search' s:GuiFg(s:white) s:GuiBg(s:workbench_grey) s:GuiAttr('underline')

" QuickFix
execute 'hi qfSeparator' s:GuiFg('fg') s:GuiBg('bg')
execute 'hi QuickFixLine' s:GuiFg('fg') s:GuiBg('bg') s:GuiAttr('bold')
hi! link qfFileName Directory
hi! link qfLineNr Directory

" Tabs
execute 'hi TabLineSel' s:GuiFg(s:yellow) s:GuiBg(s:workbench_active) s:GuiAttr('bold')
execute 'hi TabLine' s:GuiFg(s:yellow) s:GuiBg(s:workbench_passive) s:GuiAttr('none')
hi! link TabLineSel StatusLine
hi! link TabLineFill Normal

" Window
execute 'hi Title' s:GuiFg(s:green)  s:GuiAttr('bold')
execute 'hi Bold'   s:GuiAttr('bold')
execute 'hi Italic'   s:GuiAttr('italic')
execute 'hi Boolean' s:GuiFg(s:blue)
execute 'hi Character' s:GuiFg(s:yellow)
execute 'hi Comment' s:GuiFg(s:green)
execute 'hi Conditional' s:GuiFg(s:orange)
execute 'hi Constant' s:GuiFg(s:accent)
execute 'hi Define' s:GuiFg(s:orange)
execute 'hi Delimiter' s:GuiFg(s:blue)
execute 'hi Exception' s:GuiFg(s:blue)
execute 'hi Float' s:GuiFg(s:purple)
execute 'hi Function' s:GuiFg(s:blue)
execute 'hi Identifier' s:GuiFg(s:green)  s:GuiAttr('NONE')
execute 'hi Include' s:GuiFg(s:blue)
execute 'hi Keyword' s:GuiFg(s:blue)
execute 'hi Label' s:GuiFg(s:blue)
execute 'hi Number' s:GuiFg(s:purple)
execute 'hi Operator' s:GuiFg(s:yellow)  s:GuiAttr('NONE')
execute 'hi PreProc' s:GuiFg(s:blue)  s:GuiAttr('NONE')
execute 'hi Repeat' s:GuiFg(s:blue)
execute 'hi Special' s:GuiFg(s:accent)
execute 'hi SpecialChar' s:GuiFg(s:yellow)
execute 'hi SpecialComment' s:GuiFg(s:blue)
execute 'hi Statement' s:GuiFg(s:orange)
execute 'hi StorageClass' s:GuiFg(s:blue)
execute 'hi String' s:GuiFg(s:purple)
execute 'hi Structure' s:GuiFg(s:blue)
execute 'hi Tag' s:GuiFg(s:silver)
execute 'hi Todo' s:GuiFg(s:yellow) s:GuiBg('NONE')
execute 'hi Type' s:GuiFg(s:blue)  s:GuiAttr('NONE')
execute 'hi Typedef' s:GuiFg(s:blue)
hi! link Macro Define
hi! link PreCondit PreProc

execute 'hi DiffAdd' s:GuiFg(s:green) s:GuiBg(s:workbench_passive)
execute 'hi DiffChange' s:GuiFg(s:yellow) s:GuiBg(s:workbench_passive) s:GuiAttr('bold')
execute 'hi DiffDelete' s:GuiFg(s:red) s:GuiBg(s:red)
execute 'hi DiffText' s:GuiFg(s:blue) s:GuiBg(s:workbench_passive)

execute 'hi cIncluded' s:GuiFg(s:blue)
hi! link cOperator Operator
hi! link cPreCondit PreCondit

execute 'hi htmlArg' s:GuiFg(s:blue)
execute 'hi htmlLink' s:GuiFg(s:silver)  s:GuiAttr('NONE')
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

execute 'hi markdownBlockquote' s:GuiFg(s:blue)
execute 'hi markdownCode' s:GuiFg(s:background_plus) s:GuiBg('bg')
execute 'hi markdownCodeBlock' s:GuiFg(s:background_plus) s:GuiBg('bg')
execute 'hi markdownCodeDelimiter' s:GuiFg(s:green) s:GuiBg('bg')
execute 'hi markdownFootnote' s:GuiFg(s:blue)
execute 'hi markdownId' s:GuiFg(s:blue)
execute 'hi markdownIdDeclaration' s:GuiFg(s:blue)
execute 'hi markdownH1' s:GuiFg(s:yellow)
execute 'hi markdownLinkText' s:GuiFg(s:blue)
execute 'hi markdownUrl' s:GuiFg(s:light_silver)  s:GuiAttr('underline')
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
