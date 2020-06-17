let g:tagbar_left=0
let g:tagbar_vertical=0
let g:tagbar_width=30
let g:tagbar_zoomwidth=0
let g:tagbar_autoclose=0
let g:tagbar_autofocus=0
let g:tagbar_case_insensitive=0
let g:tagbar_compact=1
let g:tagbar_indent=2
let g:tagbar_show_visibility=1
let g:tagbar_show_linenumbers=0
let g:tagbar_expand=0
let g:tagbar_singleclick=1
let g:tagbar_foldlevel=2
let g:tagbar_autoshowtag=1
let g:tagbar_previewwin_pos='botright'
let g:tagbar_autopreview=1
let g:tagbar_silent=1
let g:tagbar_use_cache=1

function! <SID>LoadTagbar()
  if !exists(':Tagbar')
    packadd tagbar
  endif
  call tagbar#autoopen(0)
endfunction

augroup open_tagbar_for_supported_files
  autocmd!
  autocmd FileType go nested call <SID>LoadTagbar()
augroup END
