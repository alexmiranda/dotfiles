function! <SID>LoadNixPlugins()
  packadd vim-nix
  autocmd! lazyload_nix_plugins
endfunction

augroup lazyload_nix_plugins
  autocmd!
  autocmd BufReadPre,BufNewFile *.nix call <SID>LoadNixPlugins()
augroup END
