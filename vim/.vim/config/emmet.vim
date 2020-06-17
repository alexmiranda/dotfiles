let g:emmet_html5=1
let g:user_emmet_install_global=0
let g:user_emmet_leader_key='<C-y>'
let g:user_emmet_mode='a'

function <SID>LoadEmmet()
  if !exists(':EmmetInstall')
    packadd emmet-vim
  endif
  EmmetInstall
endfunction

augroup emmet_lazy_loading
  autocmd!
  autocmd FileType html,js,css call <SID>LoadEmmet()
augroup END
