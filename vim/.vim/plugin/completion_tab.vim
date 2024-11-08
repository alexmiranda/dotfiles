if exists('g:mine_completion_tab_loaded')
  finish
endif
let g:mine_completion_tab_loaded=1

" function! <SID>CheckBackSpace() abort
"   let l:col=col('.') - 1
"   return !l:col || getline('.')[l:col - 1] =~# '\s'
" endfunction

" if mapcheck('<Tab>', 'i') ==# ''
"   inoremap <silent><expr> <Tab>
"         \ <SID>CheckBackSpace() ? "\<Tab>" : "\<C-n>"
" endif

" if mapcheck('<S-Tab>', 'i') ==# ''
"   inoremap <silent><expr> <S-Tab>
"         \ pumvisible() ? "\<C-p>" : "\<C-h>"
" endif

" if mapcheck('<CR>', 'i') ==# ''
"   inoremap <silent><expr> <CR>
"         \ pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif
