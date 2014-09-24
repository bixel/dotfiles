execute pathogen#infect()

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
    set guifont=Meslo\ LG\ S\ for\ Powerline:h13
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

filetype off       "Required for vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle (required)
Bundle 'gmarik/vundle'

" Own bundles
" Only use YCM if macvim is available. YCM is incompatible with vim version <
" 7.3...
"if has("gui_macvim")
"    Bundle 'Valloric/YouCompleteMe'
"endif
Bundle 'davidhalter/jedi-vim'
"Bundle 'klen/python-mode'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/nerdtree'
"Bundle 'lervag/vim-latex'
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'
" Define runtime-path (rtp) if there is no explicit repo for vim
Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Bundle 'altercation/vim-colors-solarized'
Bundle 'bling/vim-airline'
" all three following plugins are needed for vim-snipmate
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"

filetype plugin indent on       " required for vundle

"Tomorrow color scheme
colo Tomorrow-Night-Eighties
"if has("gui_macvim")
"    set transparency=10
"endif

" Close tip-window when selection is done or leaving insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" YCM Configuration
" dont use python-mode autocomplete obsolete now, because of YCM
let g:pymode_rope = 0
" only use ycm for python code
let g:ycm_filetype_whitelist = {'cpp': 1}
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

" allways show tagbar
"autocmd VimEnter * nested :call tagbar#autoopen(1)
"let g:tagbar_autoclose = 0

" activate mouse support
set mouse=a
