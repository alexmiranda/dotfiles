if exists('g:mine_preview_window_loaded')
  finish
endif
let g:mine_preview_window_loaded=1

augroup preview_window_customisation
  autocmd!
  autocmd BufWinEnter * if &previewwindow |
        \ setlocal nonumber norelativenumber colorcolumn=0 scrolloff=0 |
        \ endif
augroup END
