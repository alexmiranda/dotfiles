if exists('g:mine_buffer_close_loaded')
  finish
endif
let g:mine_buffer_close_loaded=1

function! <SID>CloseAllOtherBuffers()
  let l:curr=bufnr('%')
  let l:last=bufnr('$')
  if l:curr>1
    silent! execute '1,'.(l:curr-1).'bd'
  endif
  if l:curr<l:last
    silent! execute (l:curr+1).','.l:last.'bd'
  endif
endfunction

command! -nargs=0 CloseOthers call <SID>CloseAllOtherBuffers()
command! -nargs=0 CloseThis normal :<C-u>b#<bar>bw#<CR>

augroup buffer_close
  autocmd!
  autocmd BufWinEnter * nnoremap <silent><buffer><nowait>
        \ <localleader>d :CloseThis<CR>
  autocmd BufWinEnter * nnoremap <silent><buffer><nowait>
        \ <localleader>D :<C-u>CloseOthers<CR>
augroup END
