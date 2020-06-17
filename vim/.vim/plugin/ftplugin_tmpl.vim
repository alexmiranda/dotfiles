if exists('g:mine_ftplugin_tmpl_loaded')
  finish
endif
let g:mine_ftplugin_tmpl_loaded=1

let s:my_ftplugin_folder='$HOME/.vim/ftplugin'
let s:my_actual_ftplugin_folder=resolve(expand(s:my_ftplugin_folder))

let s:ftplugin_tmpl =<< trim END
  if get(b:, 'mine_ftplugin_%s_loaded', 0) == 1
    finish
  endif
  let b:mine_ftplugin_%s_loaded=1

END

function! s:Template()
  let filename=expand('%:t:r')
  let template=printf(join(s:ftplugin_tmpl, "\n") . "\n", filename, filename)
  0put=template
  normal! G
endfunction

function! s:SID()
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfunction

augroup ftplugin_tmpl
  autocmd!
  execute printf('autocmd BufNewFile %s/*.vim,%s/*.vim call <SNR>%s_Template()',
        \ s:my_ftplugin_folder, s:my_actual_ftplugin_folder, s:SID())
augroup END
