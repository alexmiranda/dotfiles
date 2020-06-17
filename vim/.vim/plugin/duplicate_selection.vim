if exists('g:mine_duplicate_selection_loaded')
  finish
endif
let g:mine_duplicate_selection_loaded=1

" Duplicate selected text: <C-y>
if mapcheck('<C-y', 'v') ==# ''
  vnoremap <C-y> y'>p
endif
