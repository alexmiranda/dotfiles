if exists('g:mine_stripwhitespace_loaded')
  finish
endif
let g:mine_stripwhitespace_loaded=1

let g:mine_stripwhitespace_manual_only=
      \ get(g:, 'mine_stripwhitespace_manual_only', 0)

function! s:executeWithKeepp(expr)
  try
    keepp execute a:expr
  catch /^Vim\%((\a\+)\)\=:E486:/
    " pass
  endtry
endfunction

function! s:StripBlankLinesBeginning()
  call s:executeWithKeepp("normal! :\<C-u>%s/\\%^\\($\\n\\s*\\)*//\<CR>")
endfunction

function! s:StripBlankLinesEnd()
  call s:executeWithKeepp("normal! :\<C-u>%s/\\($\\n\\s*\\)\\+\\%$//\<CR>")
endfunction

function! s:StripBlankLinesConsecutive()
  call s:executeWithKeepp("normal! :\<C-u>%s/\\n\\{3,\\}/\\r\\r/e\<CR>")
endfunction

function! s:StripLineTrailingWhitespaces()
  call s:executeWithKeepp("normal! :\<C-u>%s/\\s\\+$//e\<CR>")
endfunction

function! <SID>StripWhitespaces() abort
  if !&binary && &filetype !=# 'diff'
    normal! mz
    normal! Hmy
    call s:StripBlankLinesBeginning()
    call s:StripBlankLinesEnd()
    call s:StripBlankLinesConsecutive()
    call s:StripLineTrailingWhitespaces()
    normal! 'yz<CR>
    if getpos("'z") != [0,0,0,0]
      normal! `z
    endif
  endif
endfunction

command! -nargs=0 StripWhitespaces
      \ silent call <SID>StripWhitespaces()

nnoremap <silent> <Plug>(StripWhitespaces) :<C-u>StripWhitespaces<CR>

augroup strip_whitespace
  autocmd!
augroup END

if !hasmapto('<Plug>(StripWhitespaces)', 'n') && mapcheck('<localleader>x', 'n') ==# ''
  autocmd strip_whitespace BufNewFile,BufRead,BufWinEnter *
        \ nmap <buffer><nowait> <localleader>x <Plug>(StripWhitespaces)
endif

if !g:mine_stripwhitespace_manual_only
  autocmd strip_whitespace FileType * if &filetype !~ 'markdown' |
        \ autocmd BufWritePre <silent><buffer> call <SID>StripWhitespaces()
endif
