" Init buffer for file {{{1
if !exists('b:did_ftplugin')
  " default emacs settings
  setlocal comments=fb:*,b:#,fb:-
  setlocal commentstring=#\ %s
  setlocal conceallevel=2 concealcursor=nc
  " original emacs settings are: setlocal tabstop=6 shiftwidth=6, but because
  " of checkbox indentation the following settings are used:
  setlocal tabstop=6 shiftwidth=6
  if exists('g:org_tag_column')
    exe 'setlocal textwidth='.g:org_tag_column
  else
    setlocal textwidth=77
  endif

  " expand tab for counting level of checkbox
  setlocal expandtab

  " enable % for angle brackets < >
  setlocal matchpairs+=<:>

endif

" Load orgmode just once {{{1
if &cp || exists("g:loaded_org")
    finish
endif
let g:loaded_org = 1

" Default org plugin settings {{{2
" What does this do?
if ! exists('g:org_syntax_highlight_leading_stars') && ! exists('b:org_syntax_highlight_leading_stars')
  let g:org_syntax_highlight_leading_stars = 1
endif

" setting to conceal aggresively
if ! exists('g:org_aggressive_conceal') && ! exists('b:org_aggressive_conceal')
  let g:org_aggressive_conceal = 0
endif

" Defined in separate plugins
" Adding Behavior preference:
"       1:          go into insert-mode when new heading/checkbox/plainlist added
"       0:          retain original mode when new heading/checkbox/plainlist added
if ! exists('g:org_prefer_insert_mode') && ! exists('b:org_prefer_insert_mode')
    let g:org_prefer_insert_mode = 1
endif

