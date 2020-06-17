if exists('g:mine_paste_loaded')
  finish
endif
let g:mine_paste_loaded=1

" Extend paste in select mode so that you can replace a selected block multiple
" times
xnoremap <silent> p p:if v:register == '"'<bar>let @@=@0<bar>endif<CR>
