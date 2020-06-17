if exists('g:mine_focus_loaded')
  finish
endif
let g:mine_focus_loaded=1

function! <SID>OnWinEnter()
  if exists('w:mine_focus_color_column')
    let &colorcolumn=w:mine_focus_color_column
  endif
  if exists('w:mine_focus_cursor_line')
    let &cursorline=w:mine_focus_cursor_line
  endif
endfunction

function! <SID>OnWinLeave()
  if !exists('w:mine_focus_color_column')
    let w:mine_focus_color_column=&colorcolumn
  endif
  if !exists('w:mine_focus_cursor_line')
    let w:mine_focus_cursor_line=&cursorline
  endif
  let &colorcolumn=0
  let &cursorline=0
endfunction

augroup mine_focus_autocmds
  autocmd!
  autocmd WinEnter * call <SID>OnWinEnter()
  autocmd WinLeave * call <SID>OnWinLeave()
augroup END
