" Vim compiler file
" Compiler:   Try to match most common compiler formats (Make, Green Hills , GCC)
" Maintainer: Markus Prepens (markus.prepens@gmail.com)

set makeprg=make

" multi-line
set errorformat=%W\"%f\"\\,\ line\ %l:\ %t%*[^0-9]%n-%m,%Z%m
set errorformat+=%E\"%f\"\\,\ line\ %l:\ %t%*[^0-9]%n-%m,%Z%m
set errorformat+=%*[^\"]\"%f\"%*\\D%l:%c:\ %m
set errorformat+=%*[^\"]\"%f\"%*\\D%l:\ %m
set errorformat+=\"%f\"%*\\D%l:%c:\ %m
set errorformat+=\"%f\"%*\\D%l:\ %m
set errorformat+=%-G%f:%l:\ %trror:\ (Each\ undeclared\ identifier\ is\ reported\ only\ once
set errorformat+=%-G%f:%l:\ %trror:\ for\ each\ function\ it\ appears\ in.)
set errorformat+=%f:%l:%c:\ %trror:\ %m
set errorformat+=%f:%l:%c:\ %tarning:\ %m
set errorformat+=%f:%l:%c:\ %m
set errorformat+=%f:%l:\ %trror:\ %m
set errorformat+=%f:%l:\ %tarning:\ %m
set errorformat+=%f:%l:\ %m
set errorformat+=%f:\\(%*[^\\)]\\):\ %m
set errorformat+=\"%f\"\\,\ line\ %l%*\\D%c%*[^\ ]\ %m
set errorformat+=%D%*\\a[%*\\d]:\ Entering\ directory\ %*[`']%f'
set errorformat+=%X%*\\a[%*\\d]:\ Leaving\ directory\ %*[`']%f'
set errorformat+=%D%*\\a:\ Entering\ directory\ %*[`']%f'
set errorformat+=%X%*\\a:\ Leaving\ directory\ %*[`']%f'
set errorformat+=%DMaking\ %*\\a\ in\ %f

" single-line
set errorformat+=\"%f\"\\,\ line\ %l:\ %m
