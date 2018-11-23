# Vim Tips

## Vim Scripts

### US Keyboard

Vim/Neovim works best with US keyboard layout. Even when you are used to a
German keyboard layout, in some situations it might be useful to switch to this
keyboard layout in the OS.  Especially when you spend a lot of time in Vim. 

Here is a short list of shifted
keys: `1=!`  `2=@`  `3=#`  `4=$`  `5=%`  `6=^`  `7=&` `8=*`  `9=(` `0=)`

A differnt approach: Drop this line in your startup code to make better use of
the umlaute keys `set langmap=Ü?,ü/,ö[,ä],Ö{,Ä}`.

### Books
The web has a load of good Vim tutorials, covering how to use Vim and scripting
tips.Here is a link to a very comprehensive online book:
http://learnvimscriptthehardway.stevelosh.com

### Open the commandline window

Sure, you can do `:` followed by a `<C-f>`. Or, sometimes more convinient, just
press in normal mode `q:` for the command line or `q/` or `q?` to enter the
search window. The advantage to open one of these windows is that normal mode
commands can be used.

### Plugins

A plain installation works surprisingly well for me. I tried really a lot of
optional Vim plugins, but removed most of them, becausse all I need comes with
Vim "out of the box". But some plugins may help in certain situations. This is
my short list of noteable Vim plugins:

- Per file tags navigation with *Tagbar*: https://github.com/majutsushi/tagbar.git
- Buffer overview with *Bufexplorer*: https://github.com/jlanzarotta/bufexplorer.git

Install plugins as recommended by Vim's manual `:help packages`

### Vim Knowledge

*Vim Tips* -- http://vim.wikia.com/wiki/Vim_Tips_Wiki

*Vim Galore* -- https://github.com/mhinz/vim-galore

### Wipe out a set of buffers

Want to wipe out all buffers in current session containing `snap` in its name?
Just type `:bw *snap<TAB><C-a><CR>`. The `<TAB>` is required for take a quick 
look which buffers will be wiped-out. Another solution might be this:

    :bufdo if expand("%") =~ '.*snap.*' | bw | endif

### Custom Command Completion

Here is a Vim script to show custom completion of a new command:

    function! CompleteFavPath(arg_lead, cmd_line, cur_pos)
      let l:matchingKeys = ""
      for k in sort(keys(g:workspacePathDict))
        if match(k, a:arg_lead) >= 0
          let l:matchingKeys .=  k . "\n"
        endif
      endfor
      return l:matchingKeys
    endfunction

    function! GotoFavPath(pathKey)
      if has_key(g:workspacePathDict, a:pathKey)
        exe "cd " . g:workspacePathDict[a:pathKey]
      endif
    endfunction

    let g:workspacePathDict = {"vim": "~\\vimfiles", "emacs": "~\\.emacs.d"}
    command! -nargs=1 -complete=custom,CompleteFavPath WorkspacePath call GotoFavPath('<args>')

## Run shell commands

To run any shell command you can use :! {cmd}. Characters with a special meaning
for Vim, line "%", gets expanded, befor the shell executes the command line. To
avoid Vims character expansion, use  quotes: "%"

## Run shell commands 2

Here is an approach to use asynchronous processes:

    if !has('job') || !has('channel') || !has('quickfix') finish endif

    function! s:JobHandler(handler)
      let l:cbufnr = bufnr("make.io")
      if l:cbufnr < 0
        echoerr "make.io does not exist."
        return
      endif
      execute "cbuffer " . l:cbufnr
      echomsg "closed " . a:handler
    endfunction

    function! RunMake(commandString)
      let l:opts = {
            \ 'close_cb':       function('s:JobHandler'),
            \ 'out_io':         'buffer',
            \ 'out_name':       "make.io",
            \ 'out_modifiable': 0,
            \ 'out_msg':        0,
            \ 'err_io':         'buffer',
            \ 'err_name':       "make.io",
            \ 'err_modifiable': 0,
            \ 'in_io':          'null'
            \ }
      if bufnr("make.io") >= 0
        bwipeout make.io
      endif
      let g:job = job_start("cmd /C " . a:commandString, l:opts)
    endfunction

    command! -nargs=+  MakeJob :call RunMake(<q-args>)

## Show unsaved buffers

Simply enter `:ls +` to get a filtered view of unsaved buffers. The unfiltered
output of the `:ls` command indicates those buffers with the plus sign.

## View last messages

The `g<` command can be used to see the last page of previous command output.

## How to remove ^M

In command mode you can use this substitute command `:%s/<C-v><C-m>//`.
If you like to remove the annoying character from VimL script, use `:%s/\r//e`.
The optional `e` flag suppresses error messages if no ^M is found. Therefor, I
would recommend to use this flag from scripts.

## Relative Line Numbers

To start using relative numbers, I recommend to put the following combination of
settings into your `vimrc`:

    set number set relativenumber

Together, they make Vim show the absolute number for the current line, and
relative numbers for other lines.

## Netrw

Netrw comes as a prepacked plugin in Vims standard installation. To start Netrw,
type `:Explore`. The new Netrw buffer that will show up can be customized to
match your needs. This may be a good start:

    let g:netrw_use_errorwindow = 0
    let g:netrw_liststyle = 1

Navigation is supported by the bookmark feature. Netrw stores bookmarks
permanently in file .netrwbook, located in Vims home directory. To store a new
bookmark press `mb`. To remove it, press `mB`. A preceding bookmark number is
accepted. To find out the bookmark number for all bookmark, press `qb`. To go to
a bookmark, press `gb`.

The list of bookmarks also displays the history marks. Those history marks are
set when visiting a new directory. Use keys `u` and `U` to walk backward and
forward in Netrws directory history.

To change the current directory `:pwd` to the actual display Netrw directory
press key `c`.

## Indent Code

Press `==` in visual or normal mode. Or `Ctrl-f` in insert mode.

## How to switch between the actual and previous buffer

Press CTRL-^ or CTRL-6 to have a quick way to toggle between two files.

## WORDS and words

Vim defines a WORD as a set of consecutive characters. The normal mode command
`dW` will delete A/path/like/this assuming cursors positions is on the A
character. Using normal mode command `dw` (cursors position is on A character)
will delete only the A.

## Grep, Grep Grep

It is very easy to configure any type of grep backend in Vim. This are the most
common grep tools that is use in the past.

### Ripgrep

    set grepformat=%f:%l:%c:%m,%f:%l:%m
    set grepprg=rg
            \\ --vimgrep
            \\ -t\ c
            \\ -g\ !C_AUTOSAR
            \\ -g\ !TLSim
            \\ -g\ !TLProj
            \\ -g\ !_sfprj

### Grep (The Original)

    set grepprg=grep\ -Hn\ -r\ --include='*.[ch]'
                \\ --exclude-dir=TLProj
                \\ --exclude-dir=TLSim
                \\ --exclude-dir=Doc
                \\ --exclude-dir=C_AUTOSAR
    
### GNU Global

    set grepprg=global\ --result=grep\ --grep
    set grepformat=%f:%l:%m
    set cscopeprg=gtags-cscope

### Windows findstr

    if has("win32") || has("win64")
      set grepprg=findstr\ /N\ /F:.index
    endif
