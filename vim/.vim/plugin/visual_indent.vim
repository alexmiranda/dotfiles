if exists('g:mine_visual_indent_loaded')
  finish
endif
let g:mine_visual_indent_loaded=1

if mapcheck('<', 'v') ==# ''
  vnoremap < <gv
endif

if mapcheck('>', 'v') ==# ''
  vnoremap > >gv
endif
