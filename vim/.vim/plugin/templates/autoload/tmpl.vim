" makes sure templates_dir doesn't change after loaded
let g:mine_templates_dir=get(g:, 'mine_templates_dir', glob('~/.vim/templates'))
let s:templates_dir=g:mine_templates_dir
let s:template_file_name='.template'
let s:template_alt_name='.templates/template'

function! s:TemplateFileName(basename, ext) abort
  return a:basename . (empty(a:ext) ? '' : '.'.a:ext)
endfunction

function! s:Search(ext, startpath, stoppath) abort
  let l:tmplnormal=s:TemplateFileName(s:template_file_name, a:ext)
  let l:tmplhidden=s:TemplateFileName(s:template_alt_name, a:ext)
  let l:pathexpr=printf('%s;%s',
        \ simplify(a:startpath.'/'),simplify(a:stoppath.'/'))
  let l:foundn=findfile(l:tmplnormal, l:pathexpr, 1)
  let l:foundalt=findfile(l:tmplhidden, l:pathexpr, 1)
  return s:BestMatch(l:foundn, l:foundalt)
endfunction

function! s:BestMatch(tmpln, tmplalt) abort
  if empty(a:tmpln) && empty(a:tmplalt)
    return v:none
  endif
  if empty(a:tmpln)
    return a:tmplalt
  endif
  if empty(a:tmplalt)
    return a:tmpln
  endif
  let l:pathn=fnamemodify(a:tmpln, ':p:h')
  let l:pathalt=fnamemodify(a:tmplalt, ':p:h:h')
  if len(l:pathn) >= len(l:pathalt)
    return a:tmpln
  else
    return a:tmplalt
  endif
endfunction

function! s:IsChildDir(path, ppath) abort
  return stridx(simplify(glob(a:path.'/')), simplify(glob(a:ppath.'/'))) == 0
endfunction

function! s:IsChildFile(fpath, ppath) abort
  return s:IsChildDir(fnamemodify(a:fpath, ':p:h'), a:ppath)
endfunction

function! s:IsTemplateFile(filename) abort
  return a:filename ==? s:template_file_name ||
        \ a:filename ==? s:template_alt_name
endfunction

function! tmpl#find() abort
  let l:filename=expand('<afile>:t:r')
  let l:ext=expand('<afile>:e')
  let l:path=expand('<afile>:p')
  let l:dir=fnamemodify(l:path, ':h')

  " ignore if the new file is a template in s:templates_dir
  if s:IsTemplateFile(l:filename) && s:IsChildFile(l:path, s:templates_dir)
    return v:none
  endif

  " search in cwd
  let l:cwd=getcwd()
  if s:IsChildFile(l:path, l:cwd)
    let l:found=s:Search(l:ext, l:dir, l:cwd)
    if !empty(l:found)
      return l:found
    endif
  endif

  " search in s:templates_dir
  let l:srchpath=expand('<afile>:~:h:s?^\~??')
  return s:Search(l:ext, simplify(s:templates_dir.l:srchpath), s:templates_dir)
endfunction

