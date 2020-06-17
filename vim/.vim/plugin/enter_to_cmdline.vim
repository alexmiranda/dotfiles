if exists('g:mine_enter_to_cmdline_loaded')
  finish
endif
let g:mine_enter_to_cmdline_loaded=1

" 'Enter' replaces ':' in normal mode (for normal buffers only)
augroup enter_to_cmdline
  autocmd!
  autocmd FileType * if &buftype ==# '' | nnoremap <buffer> <CR> :
augroup END
