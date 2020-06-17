if exists('g:mine_spellcheck_loaded')
  finish
endif
let g:mine_spellcheck_loaded=1

nnoremap <silent> <Plug>(ToggleSpell) setlocal spell<CR>

if !hasmapto('<Plug>(ToggleSpell)') && mapcheck('<leader>o', 'n') ==# ''
  nmap <silent> <leader>o :setlocal spell!<CR>
endif
