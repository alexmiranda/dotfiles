if exists('g:mine_insert_leave_loaded')
  finish
endif
let g:mine_insert_leave_loaded=1

" disable paste mode when leaving insert mode
augroup insert_leave
  autocmd!
  autocmd InsertLeave * set nopaste
augroup END
