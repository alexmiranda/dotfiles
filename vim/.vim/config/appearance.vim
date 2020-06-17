set background=dark
set t_Co=256
if has('termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  let &t_ZH="\e[3m"
  let &t_ZR="\e[23m"
  set termguicolors
endif

let g:gruvbox_contrast_dark='medium'
let g:gruvbox_contrast_light='hard'
let g:gruvbox_italic=1
let g:gruvbox_italicize_comments=1
let g:gruvbox_italicize_strings=0
let g:gruvbox_invert_indent_guides=1
let g:gruvbox_improved_strings=0
let g:gruvbox_improved_warnings=1
silent! colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

if has('gui_running')
  set macligatures
  set guifont=FiraCode\ Nerd\ Font:h16
endif

" No colorcolumn on help buffer
augroup help_buffer_customisation
  autocmd!
  autocmd BufEnter * if &buftype ==# 'help' | setlocal colorcolumn=0
augroup END
