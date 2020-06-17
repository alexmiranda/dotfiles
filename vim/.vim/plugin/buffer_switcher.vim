if exists('g:mine_buffer_switcher_loaded')
  finish
endif
let g:mine_buffer_switcher_loaded=1

command! -nargs=0 Bprev silent normal :<C-u>bprevious<CR>
command! -nargs=0 Bnext silent normal :<C-u>bnext<CR>

nnoremap <silent> <Plug>(buffer_switcher#Bprev) :Bprev<CR>
nnoremap <silent> <Plug>(buffer_switcher#Bnext) :Bnext<CR>

augroup buffer_switcher
  autocmd!
augroup END

if !hasmapto('<Plug>Bprev', 'n') && mapcheck('<localleader><') ==# ''
  autocmd buffer_switcher BufWinEnter *
        \ nmap <buffer><nowait> <localleader>< <Plug>(buffer_switcher#Bprev)
endif

if !hasmapto('<Plug>Bnext', 'n') && mapcheck('<localleader>,') ==# ''
  autocmd buffer_switcher BufWinEnter *
        \ nmap <buffer><nowait> <localleader>, <Plug>(buffer_switcher#Bnext)
endif
