if exists('did_load_filetypes')
  finish
endif

augroup filetypedetect
  autocmd!
  autocmd BufNewFile,BufRead .sandboxrc setfiletype zsh
augroup END
