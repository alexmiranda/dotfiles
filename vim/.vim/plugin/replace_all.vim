if exists('g:mine_replace_all_loaded')
  finish
endif
let g:mine_replace_all_loaded=1

" Replace all is aliased to S
nnoremap S :<C-u>%s/<C-r>=expand('<cword>')<CR>//g<Left><Left>
