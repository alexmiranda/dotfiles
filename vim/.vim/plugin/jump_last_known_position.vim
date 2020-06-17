if exists('g:mine_jump_last_known_position_loaded')
  finish
endif
let g:mine_jump_last_known_position_loaded=1

" Jump to the last known cursor position when opening a file
augroup jump_to_last_known_position
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"")<=line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END
