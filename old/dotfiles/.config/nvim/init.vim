let g:vim_config = get(g:, 'vim_config', expand('~/.config/nvim/config/'))
let config_list = [
        \ 'plug.vim',
        \ 'opti.vim',
        \ 'maps.vim',
        \ 'auto.vim',
        \ 'gvim.vim'
        \ ]
for file in config_list
        exec 'source ' g:vim_config.file
endfor
