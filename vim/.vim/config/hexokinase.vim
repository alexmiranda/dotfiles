let g:Hexokinase_highlighters=['backgroundfull']
let g:Hexokinase_refreshEvents=['BufWrite', 'BufRead', 'TextChanged', 'InsertLeave']
let g:Hexokinase_ftEnabled=['css', 'html', 'javascript']
let g:Hexokinase_ftOptInPatterns={
      \ 'css': 'full_hex,rgb,rgba,hsl,hsla,colour_names',
      \ 'html': 'full_hex',
      \ 'javascript': 'full_hex',
      \}

function! <SID>LoadHexokinase()
  packadd vim-hexokinase
  autocmd! hexokinase_lazy_loading
endfunction

augroup hexokinase_lazy_loading
  autocmd!
  autocmd FileType css,html,javascript call <SID>LoadHexokinase()
augroup END
