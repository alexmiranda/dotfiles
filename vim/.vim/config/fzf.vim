let g:fzf_buffers_jump=1
let g:fzf_commits_log_options=
      \ '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

nnoremap <C-p> :<C-u>Files<CR>
if executable('rg')
  nnoremap <C-g>g :<C-u>Rg<CR>
  nnoremap <C-g><C-g> :<C-u>Rg<Space>
elseif executable('ag')
  nnoremap <C-g>g :<C-u>Ag<CR>
  nnoremap <C-g><C-g> :<C-u>Ag<Space>
endif
nnoremap <C-g>l :<C-u>Lines<CR>
nnoremap <C-g>L :<C-u>BLines<CR>
nnoremap <C-g>b :<C-u>Buffers<CR>
nnoremap <C-g>h :<C-u>History<CR>
nnoremap <C-g>f :<C-u>GFiles<CR>
nnoremap <C-g>F :<C-u>GFiles?<CR>
nnoremap <C-g>t :<C-u>Tags<CR>
nnoremap <C-g>T :<C-u>BTags<CR>
nnoremap <C-g>m :<C-u>Marks<CR>
nnoremap <C-g>w :<C-u>Windows<CR>
nnoremap <C-g>c :<C-u>Commands<CR>
nnoremap <C-g>C :<C-u>History:<CR>
nnoremap <C-g>K :<C-u>Helptags<CR>
nnoremap <C-g>v :<C-u>Commits<CR>
nnoremap <C-g>V :<C-u>BCommits<CR>
nnoremap <C-g>; :<C-u>Locate<Space>
nnoremap <C-g>/ :<C-u>History/<CR>
nnoremap <C-g>? :<C-u>Maps<CR>
