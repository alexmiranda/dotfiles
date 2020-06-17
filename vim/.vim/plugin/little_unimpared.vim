if exists('g:mine_little_unimpared_loaded')
  finish
endif
let g:mine_little_unimpared_loaded=1

function! <SID>LocationPrevious()
  if empty(getloclist(0))
    return
  endif
  try
    lprevious
  catch /^Vim\%((\a\+)\)\=:E553:/
    llast
  endtry
endfunction

function! <SID>LocationNext()
  if empty(getloclist(0))
    return
  endif
  try
    lnext
  catch /^Vim\%((\a\+)\)\=:E553:/
    lfirst
  endtry
endfunction

function! <SID>QuickfixPrevious()
  if empty(getqflist())
    return
  endif
  try
    cprevious
  catch /^Vim\%((\a\+)\)\=:E553:/
    clast
  endtry
endfunction

function! <SID>QuickfixNext()
  if empty(getqflist())
    return
  endif
  try
    cnext
  catch /^Vim\%((\a\+)\)\=:E553:/
    cfirst
  endtry
endfunction

" Quick navigation commands (a small subset of tpope/vim-unimpaired plugin)
augroup navcmds
  autocmd!
  " File arguments
  autocmd FileType * if &filetype !~ 'netrw' |
        \ nnoremap <buffer><silent> ]a :<C-u>next<CR>
  autocmd FileType * if &filetype !~ 'netrw' |
        \ nnoremap <buffer><silent> [a :<C-u>previous<CR>
  "Buffers
  autocmd FileType * if &filetype !~ 'netrw' |
        \ nnoremap <buffer><silent> ]b :<C-u>bnext<CR>
  autocmd FileType * if &filetype !~ 'netrw' |
        \ nnoremap <buffer><silent> [b :<C-u>bprevious<CR>
  " Quick fixes
  autocmd FileType * if &filetype !~ 'netrw' |
        \ nnoremap <buffer><silent> ]c :<C-u>call <SID>QuickfixNext()<CR>
  autocmd FileType * if &filetype !~ 'netrw' |
        \ nnoremap <buffer><silent> [c :<C-u>call <SID>QuickfixPrevious()<CR>
  autocmd FileType * if &filetype !~ 'netrw' |
        \ nnoremap <nowait><buffer><silent> <localleader>cc :copen<CR>
  " Location list
  autocmd FileType * if &filetype !~ 'netrw' |
        \ nnoremap <buffer><silent> ]l :<C-u>call <SID>LocationNext()<CR>
  autocmd FileType * if &filetype !~ 'netrw' |
        \ nnoremap <buffer><silent> [l :<C-u>call <SID>LocationPrevious()<CR>
  autocmd FileType * if &filetype !~ 'netrw' |
        \ nnoremap <nowait><buffer><silent> <localleader>ll :lopen<CR>
  " Tags
  autocmd FileType * if &filetype !~ 'netrw' |
        \ nnoremap <buffer><silent> ]t :<C-u>tnext<CR>
  autocmd FileType * if &filetype !~ 'netrw' |
        \ nnoremap <buffer><silent> [t :<C-u>tprevious<CR>
augroup END
