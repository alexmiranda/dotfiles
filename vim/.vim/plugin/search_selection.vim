if exists('g:mine_search_selection_loaded')
  finish
endif
let g:mine_search_selection_loaded=1

" Search selected text with //
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>")
