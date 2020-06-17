if exists('g:mine_move_selection_loaded')
  finish
endif
let g:mine_move_selection_loaded=1

if mapcheck('J', 'x') ==# ''
  xnoremap <silent><expr> J mode() ==# "V" ? ":move '>+1<CR>gv=gv" : "J"
endif

if mapcheck('K', 'x') ==# ''
  xnoremap <silent><expr> K mode() ==# "V" ? ":move '<-2<CR>gv=gv" : "K"
endif
