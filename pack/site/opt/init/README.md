# site.vim :speech_balloon:

Copying the whole repository on different machines, running either with Linux
or Windows, requires always small modifications in the setup. Exactly this is
why `plugin/site.vim` exists.  The idea is to have a template, stored in this
directory and is under VCS control. Sure, it can be sourced with the command
`packadd site`. But the idea is to copy the file beside `init.vim`, modify it
fro your needs.  A Vim/Nvim startup will source `site.vim` from `init.vim`.

Features
--------

- _Mappings:_ Different machines, different keyboards, different plugins may
  need additional key mappings. 
- _GUIs:_ Especially for Nvim, there a different GUIs available with different
  approaches ow to e.g. set the font.
- _Tools:_ Like to use the available grep-like tool. Do it here!
