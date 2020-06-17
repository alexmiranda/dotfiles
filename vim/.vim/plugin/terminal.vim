if exists('g:mine_terminal_loaded')
  finish
endif
let g:mine_terminal_loaded=1

if mapcheck('<F6>', 'n') ==# ''
  nnoremap <silent> <F6> :terminal<CR>
  tnoremap <F6> exit<CR>
endif

" Never leaves a terminal buffer hanging...
function! <SID>ForceQuitTerminal()
  bufdo! if &buftype ==# 'terminal' | bw! | endif
endfunction

augroup mine_terminal
  autocmd!
  autocmd BufLeave * if &buftype ==# 'terminal' | call <SID>ForceQuitTerminal()
augroup END
