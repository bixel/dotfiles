" Using vundle: just git clone https://github.com/gmarik/Vundle.vim.git
" ~/.vim/bundle/Vundle.vim
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
" Define runtime-path (rtp) if there is no explicit repo for vim
Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'suan/vim-instant-markdown'
Plugin 'tpope/vim-markdown'
Plugin 'KabbAmine/vCoolor.vim'
Plugin 'nvie/vim-flake8'
" Plugin 'Townk/vim-autoclose'
" all three following plugins are needed for vim-snipmate
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" U S E R  S E T U P

"set right encoding
set encoding=utf-8
set fileencoding=utf-8

"use jk for Escape
inoremap jk <ESC>

map j gj
map k gk

"lajdflasldflsajflasdlfjslajfsjremap mapleader / to , this vim stuff ist really not thaaaat comfortable if
"you are not used to it O.o
let mapleader = ","

"execute current file
nnoremap <leader>e :!%:p<Enter>

"open Nerdtree with CTRL+n
map <C-n> :NERDTreeToggle<CR>

"open Tagbar with CTRL+m
map <C-m> :TagbarToggle<CR>

" trigger snipmate
imap kj <Plug>snipMateNextOrTrigger

"configure for guivim if its active
if has("gui_macvim")
    set guifont=Meslo\ LG\ M\ for\ Powerline:h13
endif

"Set auto inline on
set ai

"Show line numbers
set number

"Set syntax highlighting on
syntax on

" Spaces instead of Tabs
" Use 4 Spaces as default and 2 Spaces for cpp files
if expand("%:e")=="cpp"
    set tabstop=2
    set shiftwidth=2
else
    set tabstop=4
    set shiftwidth=4
endif

set expandtab

set colorcolumn=80

"Tomorrow color scheme
colo Tomorrow-Night-Eighties

" Close tip-window when selection is done or leaving insert mode
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" YCM Configuration
" dont use python-mode autocomplete obsolete now, because of YCM
let g:ycm_filetype_whitelist = {'cpp': 1, 'py': 1}
" set ycm_extra_conf
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
" turn off the ycm diagnostic because of struggling with root
"let g:ycm_show_diagnostics_ui = 0

" NERDTree Configuration
" hide some fileextenxions
let NERDTreeIgnore = ['\.pyc$']

" Airline stuff
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" multiple-cursors mapping
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" configure snipmate
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['latextex'] = 'tex'
let g:snipMate.scope_aliases['plaintex'] = 'tex'

" vCoolor config
let g:vcoolor_map = '<C-c>'

" configure flake8
" autorun flake on save
autocmd BufWritePost *.py call Flake8()
let g:flake8_ignore="F403"

" activate mouse support
set mouse=a
