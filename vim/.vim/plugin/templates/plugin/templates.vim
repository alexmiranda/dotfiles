if exists('g:mine_templates_loaded')
  finish
endif
let g:mine_templates_loaded=1

function! <SID>LoadTemplate()
  let b:mine_template_evaluated=1
  let l:template=tmpl#find()
  if filereadable(l:template)
    let b:mine_template=l:template
    execute printf('0read %s', l:template)
    normal! G
  endif
endfunction

augroup templates
  autocmd!
  autocmd BufNewFile * silent! call <SID>LoadTemplate()
augroup END
