if exists('g:mine_window_mappings_loaded')
  finish
endif
let g:mine_window_mappings_loaded=1

if !exists('g:mine_dont_change_my_s_key')
  let g:mine_dont_change_my_s_key=0
endif

nnoremap <C-w><Down> <Nop>
nnoremap <C-w><Up> <Nop>
nnoremap <C-w><Left> <Nop>
nnoremap <C-w><Right> <Nop>

if mapcheck('<C-w>t', 'n') ==# ''
  " CTRL-w + t creates a tab with an empty buffer
  nnoremap <silent> <C-w>t :<C-u>tabedit<CR>
endif

if mapcheck('<C-w>]', 'n') ==# ''
  " CTRL-w + ] moves to the tab to the right
  nnoremap <silent> <C-w>] :<C-u>tabnext<CR>
endif

if mapcheck('<C-w>[', 'n') ==# ''
  " CTRL-w + [ moves to the tab to the left
  nnoremap <silent> <C-w>[ :<C-u>tabprevious<CR>
endif

" Because I have a ultrawide monitor, I prefer to use more of the horizontal
" real state, thus most key mappings are targeting vertical splits
if !g:mine_dont_change_my_s_key
  if mapcheck('ss', 'n') ==# ''
    " ss takes the current buffer to a new split to the right
    " and shows alternate file in the existing split
    nnoremap <silent> ss :<C-u>b#<bar>vert sb#<CR>
  endif

  if mapcheck('sh', 'n') ==# ''
    " sh (split horizontally) is the same as <C-w>s
    nnoremap <silent> sh <C-w>s
  endif

  if mapcheck('sv', 'n') ==# ''
    " sv (split vertically) is the same as <C-w>v
    nnoremap <silent> sv <C-w>v
  endif

  if mapcheck('st', 'n') ==# ''
    " st (split tab) takes the current buffer to a new tab and shows alternate
    " file in the existing window
    nnoremap <silent> st :<C-u>b#<bar>tabedit#<CR>
  endif

  if mapcheck('sn', 'n') ==# ''
    " sn (split new) quickly creates a new buffer on a split to the right
    nnoremap <silent> sn :vnew<CR>
  endif

  if mapcheck('sf', 'n') ==# ''
    " sf (split file) opens to the file under cursor in a new vertical split
    nnoremap <silent> sf <C-w>vgf
  endif

  if mapcheck('sd', 'n') ==# ''
    " sd (split definition) goes to definition under cursor in a new vertical
    " split
    nnoremap <silent> sd <C-w>vgd
  endif

  if mapcheck('s]', 'n') ==# ''
    " s] (split tag) goes to tag under cursor in a new vertical split
    nnoremap <silent> s] <C-w>vg]
  endif

  if mapcheck('sq', 'n') ==# ''
    " sq (split quit) is the same as <C-w>q
    nnoremap <silent> sq <C-w>q
  endif
endif
