if exists('g:mine_get_around_ctrl_a_loaded')
  finish
endif
let g:mine_get_around_ctrl_a_loaded=1

" <C-A> is my tmux prefix of choice
nnoremap <C-x>a <C-a>
vnoremap <C-x>a <C-a>gv
vnoremap g<C-x>a g<C-a>gv

nnoremap <C-x>x <C-x>
vnoremap <C-x>x <C-x>gv
vnoremap g<C-x>x g<C-x>gv
