if exists('g:mine_tmux_repl_loaded')
  finish
endif
let g:mine_tmux_repl_loaded=1

if empty($TMUX)
  finish
endif

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

" Sends the current selected text to the last active tmux pane and execute.
function! <SID>TmuxSendSelection()
  let curr_tmux_pane = trim(system("tmux display -p '#{pane_index}'"))

  " There needs to be at least two panes in the current window.
  let tmux_window_panes = trim(system("tmux display -p '#{window_panes}'"))->str2nr()
  if tmux_window_panes == 1
    return
  endif

  let tmux_last_pane = trim(system("tmux display -p -t '{last}' '#{pane_index}'"))

  " If there wasn't a last active pane, it tries the pane immediately to the right
  " of the active pane (the pane where vim is).
  if empty(tmux_last_pane) || tmux_last_pane ==# curr_tmux_pane
    let tmux_last_pane = trim(system("tmux display -p -t '{right-of}' '#{pane_index}'"))
    " If there wasn't a pane to the right of the active one, then it tries the pane below.
    if empty(tmux_last_pane) || tmux_last_pane ==# curr_tmux_pane
      let tmux_last_pane = trim(system("tmux display -p -t '{down-of}' '#{pane_index}'"))
    endif
  endif

  " Sometimes the panes 'right-of' or 'down-of' reported by tmux can be the active
  " pane, e.g. when there's only one pane in the row/column. In this case, it's
  " necessary to check if they are not the same in either case...
  if curr_tmux_pane ==# tmux_last_pane
    return
  endif

  let selectedText = s:get_visual_selection()
  if len(selectedText) > 0
    silent execute "!tmux send -t " . tmux_last_pane . " '" . selectedText . "' Enter"
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

