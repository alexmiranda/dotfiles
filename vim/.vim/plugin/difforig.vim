if exists('g:mine_difforig_loaded')
  finish
endif
let g:mine_difforig_loaded=1

if !exists(':DiffOrig')
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
        \ | diffthis | wincmd p | diffthis
endif
