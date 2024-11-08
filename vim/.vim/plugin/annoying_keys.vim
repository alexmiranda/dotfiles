if exists('g:mine_annoying_keys_loaded')
  finish
endif
let g:mine_annoying_keys_loaded=1

" Disable ZZ (write current buffer and quit)
nnoremap Z <Nop>
nnoremap ZZ <Nop>

" Disable enter command mode (it's so annoying)
nnoremap Q <Nop>

" Disable the useless F1 key that's too close to the escape key
nmap <F1> <Nop>

" jk for exiting insert mode
" inoremap jk <Esc>
