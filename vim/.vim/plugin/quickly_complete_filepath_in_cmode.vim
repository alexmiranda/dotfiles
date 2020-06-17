if exists('g:mine_quickly_complete_path_file_in_cmode_loaded')
  finish
endif
let g:mine_quickly_complete_path_file_in_cmode_loaded=1

" expands to the current buffer file path, without filename
cnoremap :: <C-r>=expand('%:h')<CR>
