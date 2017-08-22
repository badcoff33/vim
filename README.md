# Vim Tips

## Vim Scripts

### Books

The web has a load of good Vim tutorials, covering how to use Vim and scripting
tips.Here is a link to a very comprehensive online book:
http://learnvimscriptthehardway.stevelosh.com

### Plugins

A plain installation works surprisingly well for me. I tried really a lot of optional Vim plugins, but removed most of them, becausse all I need comes with Vim "out of the box". But some plugins may help in certain situations. This is my short list of noteable Vim plugins:

- Per file tags navigation with *Tagbar*: https://github.com/majutsushi/tagbar.git 
- Buffer overview with *Bufexplorer*: https://github.com/jlanzarotta/bufexplorer.git

Install plugins as recommended by Vim's manual `:help packages` 

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

To run any shell command you can use :! {cmd}. Characters with a special meaning for Vim, line "%", gets expanded, befor the shell executes the command line. To avoid Vims character expansion, use  quotes: "%"

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

To start using relative numbers, I recommend to put the following combination of settings into your `vimrc`:

    set number
    set relativenumber

Together, they make Vim show the absolute number for the current line, and relative numbers for other lines.

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

Vim defines a WORD as a set of consecutive characters. The normal mode command `dW` will delete A/path/like/this assuming cursors positions is on the A character. Using normal mode command `dw` (cursors position is on A character) will delete only the A.

## Building Neovim with MSYS2/MinGW

Neovim can be build using MinGW. However getting all the necessary dependencies is not easy. 
Using something like MSYS2 to get all the tools and libraries makes things a lot faster.

These instructions use MSYS2 to get the some of the necessary dependencies, but the build itself takes
does not use the MSYS2 shell.

#### System dependencies

Install these packages with pacman.

- mingw-w64-x86_64-gcc
- mingw-w64-x86_64-libtool
- mingw-w64-x86_64-cmake
- mingw-w64-x86_64-perl
- mingw-w64-x86_64-python2

Replace with x86_64 with i686 for 32bit builds. 

#### Before starting

Now from a real windows console (cmd.exe) setup the PATH to point to the msys environment. This is necessary
because we want the tools installed inside the MSYS environment, but not the MSYS2 shell itself.

```
set PATH=%PATH%;c:\msys64\mingw64\bin
```

Again adjust accordingly if you want 32bit builds.

**Know issue:** In MinGW builds, sh.exe MUST NOT be in the PATH, you might have to adjust the path to address this.
For example Git for Windows has an sh.exe in the PATH.

#### Build third party dependencies

```
mkdir .deps
cd .deps
cmake  -G "MinGW Makefiles" ..\third-party\
mingw32-make
cd ..
```

#### Build Neovim

```
mkdir build
cd build
cmake -G "MinGW Makefiles" ..
mingw32-make nvim
```