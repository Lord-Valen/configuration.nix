"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General maps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = " "

nnoremap <leader>wq :q<CR>
nnoremap <leader>wc :clo<CR>
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Remap ESC to ii
imap ii <Esc>

" Smart home
function! SmartHome()
        let first_nonblank = match(getline('.'), '\S') + 1
        if first_nonblank == 0
                return col('.') + 1 >= col('$') ? '0' : '^'
        endif
        if col('.') == first_nonblank
                return '0'  " if at first nonblank, go to start line
        endif
        return &wrap && wincol() > 1 ? 'g^' : '^'
endfunction

noremap <expr> <silent> <Home> SmartHome()
imap <silent> <Home> <C-O><Home>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colemak-DH remaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap m h
noremap M H
noremap n j
noremap N J
noremap e k
noremap E K
noremap i l
noremap I L

noremap k n
noremap K N
noremap u i
noremap U I
noremap l u
noremap L U
noremap N J

noremap f e
noremap F E
noremap t f
noremap T F
noremap j t
noremap J T

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Splits and Tabbed Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap splits navigation to just CTRL + mnei
nnoremap <C-m> <C-w>h
nnoremap <C-n> <C-w>j
nnoremap <C-e> <C-w>k
nnoremap <C-i> <C-w>l

" Make adjusing split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>
