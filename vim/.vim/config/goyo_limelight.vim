let g:goyo_width=120
let s:colorcolumn=&colorcolumn

function! <SID>GoyoLoad()
  packadd goyo.vim
  " packadd limelight.vim
  nmap <silent> <C-w>o :<C-u>Goyo<CR>
  Goyo
endfunction

function! <SID>GoyoEnter()
  let s:colorcolumn=&colorcolumn
  setlocal colorcolumn=
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  setlocal scrolloff=999
  " Limelight
  normal! zz
endfunction

function! <SID>GoyoLeave()
  let &colorcolumn=s:colorcolumn
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  setlocal scrolloff<
  " Limelight!
  AirlineRefresh
endfunction

augroup goyo_events
  autocmd!
  autocmd! User GoyoEnter nested call <SID>GoyoEnter()
  autocmd! User GoyoLeave nested call <SID>GoyoLeave()
augroup END

nnoremap <silent> <C-w>o :<C-u>call <SID>GoyoLoad()<CR>
