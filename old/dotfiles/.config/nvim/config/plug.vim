"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle For Managing Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plugin.vim'))
        silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --createdirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

"{{ The Basics }}
        Plug 'VundleVim/Vundle.vim'                        " Vundle
        Plug 'itchyny/lightline.vim'                       " Lightline statusbar
        Plug 'suan/vim-instant-markdown', {'rtp': 'after'} " Markdown Preview
        Plug 'frazrepo/vim-rainbow'
"{{ File management }}
        Plug 'vifm/vifm.vim'                               " Vifm
        Plug 'scrooloose/nerdtree'                         " Nerdtree
        Plug 'tiagofumo/vim-nerdtree-syntax-highlight'     " Highlighting Nerdtree
        Plug 'ryanoasis/vim-devicons'                      " Icons for Nerdtree
"{{ Productivity }}
        Plug 'vimwiki/vimwiki'                             " VimWiki
        Plug 'itchyny/vim-gitbranch'                       " Function to show git branch name in lightline
        Plug 'jreybert/vimagit'                            " Magit, but for vim
        Plug 'axvr/org.vim'                                " Syntax higlinghting for .org files
"{{ Tim Pope Plugins }}
        Plug 'tpope/vim-surround'                          " Change surrounding marks
"{{ Syntax Highlighting and Colors }}
        Plug 'PotatoesMaster/i3-vim-syntax'                " i3 config highlighting
        Plug 'kovetskiy/sxhkd-vim'                         " sxhkd highlighting
        Plug 'vim-python/python-syntax'                    " Python highlighting
        Plug 'ap/vim-css-color'                            " Color previews for CSS
"{{ Junegunn Choi Plugins }}
        Plug 'junegunn/goyo.vim'                           " Distraction-free viewing
        Plug 'junegunn/limelight.vim'                      " Hyperfocus on a range
        Plug 'junegunn/vim-emoji'                          " Vim needs emojis!

call plug#end()

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lightline settings
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \         'left': [ [ 'mode', 'paste' ],
      \                 [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \         'gitbranch': 'gitbranch#name'
      \ },
      \ }

" Always show statusline
set laststatus=2

" Uncomment to prevent non-normal modes showing in powerline and below powerline.
set noshowmode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Uncomment to autostart the NERDTree
" autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let g:NERDTreeWinSize=38

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vifm
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Leader>vv :Vifm<CR>
map <Leader>vs :VsplitVifm<CR>
map <Leader>sp :SplitVifm<CR>
map <Leader>dv :DiffVifm<CR>
map <Leader>tv :TabVifm<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VimWiki
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-Instant-Markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:instant_markdown_autostart = 0         " Turns off auto preview
let g:instant_markdown_browser = "surf"      " Uses surf for preview
map <Leader>md :InstantMarkdownPreview<CR>   " Previews .md file
map <Leader>ms :InstantMarkdownStop<CR>      " Kills the preview
