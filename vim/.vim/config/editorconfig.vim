let g:EditorConfig_max_line_indicator='line'
augroup editorconfig_setup
  autocmd!
  autocmd VimEnter *
        \ if filereadable(findfile('.editorconfig', expand('<afile>:p:h', 1).'.;')) |
        \ packadd editorconfig-vim
augroup END
