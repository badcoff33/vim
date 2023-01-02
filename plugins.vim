vim9script

# FZF
g:fzf_colors = {
  'fg':      ['fg', 'Normal'],
  'bg':      ['bg', 'Normal'],
  'hl':      ['fg', 'Comment'],
  'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  'hl+':     ['fg', 'Statement'],
  'info':    ['fg', 'PreProc'],
  'border':  ['fg', 'Ignore'],
  'prompt':  ['fg', 'Conditional'],
  'pointer': ['fg', 'Exception'],
  'marker':  ['fg', 'Keyword'],
  'spinner': ['fg', 'Label'],
  'header':  ['fg', 'Comment']
}

# NETRW variables
g:netrw_use_errorwindow = 0
g:netrw_banner = 1
g:netrw_liststyle = 3
g:netrw_browse_split = 0
g:netrw_altv = 1
g:netrw_winsize = 25
g:netrw_preview = 1

# EASYALIGN
# Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <Leader>a <Plug>(EasyAlign)
# Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <Leader>a <Plug>(EasyAlign)

# DIRCFG

g:config_functions = [
 "Config_Hvh",
 "Config_T0X",
 "Config_RL78_AAE",
 "Config_RL78_AGF",
 "Config_Vim",
 "Config_C234",
 "Config_FUSA"
]


# WORDY

# Define your own ring of dictionaries, overriding the default one in your .vimrc:
g:wordy#ring = [
   'weak',
   ['being', 'passive-voice', ],
   'business-jargon',
   'weasel',
   'puffery',
   ['problematic', 'redundant', ],
   'adjectives',
   'adverbs'
   ]

# You can navigate the ring with the following commands:
# :NextWordy
# :PrevWordy

