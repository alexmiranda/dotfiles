let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_winsize=15
let g:netrw_altv=1
let g:netrw_fastbrowse=0
let g:netrw_cursor=4
let g:netrw_bufsettings='noma nomod nonu nowrap ro nobl nornu colorcolumn=0 bufhidden=wipe'

nnoremap <silent> <C-b> :<C-u>Lexplore<CR>
augroup netrw_config
  autocmd!
  autocmd FileType netrw setlocal bufhidden=wipe colorcolumn=0
augroup END
