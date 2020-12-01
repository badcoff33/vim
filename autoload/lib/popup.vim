
function! lib#popup#OpenFloatingWin(text_list)
  if !has('nvim')
    call popup_create(split(a:text, '\n'), #{ pos: 'topleft',
      \ line: 'cursor+1', col: 'cursor', moved: 'WORD' })
    return
  endif
  let l:opts = {
        \ 'relative': 'editor',
        \ 'row': 0,
        \ 'col': 0,
        \ 'anchor': 'NW',
        \ 'height': 10,
        \ 'width': &columns,
        \ 'style': 'minimal'
        \ }
  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, l:opts)
  call nvim_win_set_option(win, 'winhl', 'Normal:NormalFloat')
  call nvim_win_set_option(win, 'winblend', 10)
  call nvim_buf_set_option(buf, 'buftype', 'nofile')
  call nvim_buf_set_option(buf, 'buflisted', v:true)
  call nvim_buf_set_option(buf, 'bufhidden', 'hide')
  call nvim_win_set_option(win, 'signcolumn', 'no')
  call append(0, a:text_list)
  normal gg
  autocmd BufLeave <buffer> bwipeout!
  nmap <buffer> <Esc> :bwipeout!<CR>
  nmap <buffer> <CR>  :bwipeout!<CR>
endfunction

function! lib#popup#OpenFloatingHelp(help_arg)
  if !has('nvim')
    echo "sorry, nvim only."
  endif
  let width = min([&columns - 4, max([80, &columns - 20])])
  let height = min([&lines - 4, max([20, &lines - 10])])
  let top = ((&lines - height) / 2) - 1
  let left = (&columns - width) / 2
  let opts = {'relative': 'editor',
        \'row': top,
        \'col': left,
        \'width': width,
        \'height': height,
        \'style': 'minimal'}
  let s:buf = nvim_create_buf(v:false, v:true)
  let l:win = nvim_open_win(s:buf, v:true, opts)
  call nvim_win_set_option(win, 'winhl', 'Normal:NormalFloat')
  setlocal nonumber norelativenumber buftype=help
  exe "help " . a:help_arg
endfunction

