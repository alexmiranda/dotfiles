set statusline+=%{gutentags#statusline()}
let g:gutentags_cache_dir=expand('$HOME/.cache/vim/gutentags')
let g:gutentags_generate_on_new=1
let g:gutentags_generate_on_missing=1
let g:gutentags_generate_on_write=1
let g:gutentags_generate_on_empty_buffer=0
let g:gutentags_file_list_command='git ls-files'
let g:gutentags_ctags_extra_args=[
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS']

command! -nargs=0 GutentagsClearCache
      \ call system('rm ' . g:gutentags_cache_dir . '/*')
