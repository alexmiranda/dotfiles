if exists('g:mine_plugin_tmpl_loaded')
  finish
endif
let g:mine_plugin_tmpl_loaded=1

let s:my_plugin_folder='$HOME/.vim/plugin'
let s:my_actual_plugin_folder=resolve(expand(s:my_plugin_folder))

let s:plugin_tmpl =<< trim END
  if exists('g:mine_%s_loaded')
    finish
  endif
  let g:mine_%s_loaded=1

END

function! s:Template()
  let filename=expand('%:t:r')
  let template=printf(join(s:plugin_tmpl, "\n") . "\n", filename, filename)
  0put=template
  normal! G
endfunction

function! s:SID()
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfunction

augroup plugin_tmpl
  autocmd!
  execute printf('autocmd BufNewFile %s/*.vim,%s/*.vim call <SNR>%s_Template()',
        \ s:my_plugin_folder, s:my_actual_plugin_folder, s:SID())
augroup END
