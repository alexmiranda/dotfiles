if exists('g:mine_reload_loaded')
  finish
endif
let g:mine_reload_loaded=1

" Reload vimrc changes
let s:myvimrc=resolve(expand($MYVIMRC))
let s:quitting=0
function! s:SID()
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfunction

function! <SID>IsQuittingVim()
  return s:quitting
endfunction

augroup reload_vimrc
  autocmd!
  autocmd QuitPre * let s:quitting=1
  execute printf('autocmd BufWritePost %s,%s if !<SNR>%s_IsQuittingVim() | '
        \ . 'source %s | '
        \ . 'echom "%s reloaded." | '
        \ . 'AirlineRefresh | '
        \ . 'redraw', s:myvimrc, $MYVIMRC, s:SID(), $MYVIMRC, $MYVIMRC)
  execute printf('autocmd BufWinLeave %s,%s let s:quitting=0',
        \ s:myvimrc, $MYVIMRC)
augroup END

nnoremap <leader>r :<C-u>source $MYVIMRC<bar>AirlineRefresh<bar>redraw<CR>

" if mapcheck('<leader>r', 'n') ==# ''
"   nnoremap <leader>r :<C-u>source $MYVIMRC<bar>AirlineRefresh<bar>redraw<CR>
" endif
