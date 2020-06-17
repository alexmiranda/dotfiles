if exists('g:mine_capitalise_loaded')
  finish
endif
let g:mine_capitalise_loaded=1

if mapcheck('<C-u>', 'i') ==# ''
  inoremap <C-u> <Esc>viwUea
endif

if mapcheck('<C-u>', 'n') ==# ''
  nnoremap <C-u> viwU
endif
