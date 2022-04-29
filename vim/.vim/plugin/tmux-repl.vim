if exists('g:mine_tmux_repl_loaded')
  finish
endif
let g:mine_tmux_repl_loaded=1

function! s:get_visual_selection()
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)
  if len(lines) == 0
    return ''
  endif
  let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]
  return join(lines, "\n")
endfunction

function! <SID>TmuxSendSelection()
  let selectedText = s:get_visual_selection()
  if selectedText !=? ''
    silent execute "!tmux send -t 2 '" . selectedText . "' Enter"
    redraw!
  endif
endfunction

command! -nargs=0 TmuxSendSelection call <SID>TmuxSendSelection()

if mapcheck('<C-c>', 'v') ==# ''
  vnoremap <silent> <C-c> :<C-u>TmuxSendSelection<CR>
endif

if mapcheck('<C-c>c', 'n') ==# ''
  nnoremap <silent> <C-c>c V:<C-u>TmuxSendSelection<CR><Esc>
endif

