if exists('g:mine_format_loaded')
  finish
endif
let g:mine_format_loaded=1

let g:mine_format_on_write=get(g:, 'mine_format_on_write', 1)

function! <SID>ReformatBuffer()
  normal! mz
  normal! Hmy
  normal! gg=G
  normal! 'yz<CR>
  normal! `z
endfunction

command! -nargs=0 Format call <SID>ReformatBuffer()
nnoremap <silent> <Plug>(Format) :Format<CR>

augroup format
  autocmd!
augroup END

if !hasmapto('<Plug>(Format)') && mapcheck('<localleader>f', 'n') ==# ''
  autocmd format BufWinEnter *
        \ nmap <buffer><nowait> <localleader>f :<C-u>call <SID>ReformatBuffer()<CR>
endif

if g:mine_format_on_write
  autocmd format FileType vim
        \ autocmd BufWritePre <buffer> call <SID>ReformatBuffer()
endif
