set encoding=utf-8
scriptencoding utf-8

" vint: -ProhibitSetNoCompatible
set nocompatible
set exrc
set number
set relativenumber
set hidden
set cursorline
set laststatus=2
set modelines=5
set visualbell t_vb=
set noerrorbells
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
" set list listchars=eol:¬,tab:▸·,trail:×,precedes:←,extends:→,nbsp:␣
set list listchars=eol:¬,tab:▸\ ,trail:×,precedes:←,extends:→,nbsp:␣
set textwidth=80
set colorcolumn=+1
set incsearch
set nojoinspaces
set display+=lastline
set wildmenu
set wildmode=longest:full,full
set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab
set pastetoggle=<F2>
set updatetime=250
set balloondelay=250
set ttyfast
set mouse=a
set splitbelow
set splitright
set winheight=10
set winwidth=20
set timeoutlen=1000 ttimeoutlen=0
" set shell=/bin/sh
set wildignore+=*.class,*.exe,*.dll,.git,.hg,.svn,**/target/**,**/build/**,
set wildignore+=**/obj/**,**/bin/**,**/x64/**,**/x86/**,**/node_modules/**,
set scrolloff=5
set path+=**
set report=99999
set shortmess=astWAIc
set signcolumn=number
set clipboard+=unnamed
set spelllang=en_gb

if has('patch-8.1.1904')
  set completeopt+=popup
  set completepopup=align:menu,border:off,highlight:Pmenu
endif

" http://vim.wikia.com/wiki/Remove_swap_and_backup_files_from_your_working_directory
if !isdirectory($HOME.'/.cache/vim/backup')
  call mkdir($HOME.'/.cache/vim/backup', 'p', 0700)
endif
set directory-=~/.cache/vim/backup
set directory^=~/.cache/vim/backup//
set backupdir-=~/.cache/vim/backup
set backupdir=~/.cache/vim/backup//

" Undo directory: allows undo to be persistent after vim is closed
if !isdirectory($HOME.'/.cache/vim/undo')
  call mkdir($HOME.'/.cache/vim/undo', 'p', 0700)
endif
set undodir=~/.cache/vim/undo
set undofile
