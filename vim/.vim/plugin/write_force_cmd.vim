if exists('g:mine_write_force_cmd_loaded')
  finish
endif
let g:mine_write_force_cmd_loaded=1

" Use w!! to save using sudo
cmap w!! w !sudo tee % >/dev/null
