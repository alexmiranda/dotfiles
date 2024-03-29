set encoding=utf-8
scriptencoding utf-8

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=0
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=1
let g:syntastic_aggregate_errors=1
let g:syntastic_vim_checkers=['vint']
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
