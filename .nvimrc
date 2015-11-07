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
Plugin 'rust-lang/rust.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'mhinz/vim-startify'
" Define runtime-path (rtp) if there is no explicit repo for vim
Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'suan/vim-instant-markdown'
Plugin 'tpope/vim-markdown'
Plugin 'KabbAmine/vCoolor.vim'
Plugin 'nvie/vim-flake8'
Plugin 'Raimondi/delimitMate'
Plugin 'SirVer/ultisnips'
Plugin 'rizzatti/dash.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
" Plugin 'gilligan/vim-lldb'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" U S E R  S E T U P

"set right encoding
set encoding=utf-8
set fileencoding=utf-8

" jump between split lines
map j gj
map k gk

"map mapleader / to (german layout)
let mapleader = ","

"execute current file
nnoremap <leader>e :!'%:p'<Enter>
"make
nnoremap <leader>m :!make<Enter>

"open Nerdtree with CTRL+n
map <C-n> :NERDTreeToggle<CR>

"open Tagbar with CTRL+m
map <C-m> :TagbarToggle<CR>

" :w for :W
command W w
command Wq wq
command Q q
command WQ wq

"configure for guivim if its active
if has("gui_macvim")
    set guifont=Meslo\ LG\ M\ DZ\ for\ Powerline:h12
endif

set ai "Set auto inline on
set number "Show line numbers
syntax on "Set syntax highlighting on

set tabstop=4 " width of tab
set softtabstop=4 "should be redundant after tabstop and expandtab, but vim-snipmate is messing up (?)
set shiftwidth=4
set expandtab " use 'tabstop' spaces instead of tab
set colorcolumn=80 " Bar hinting for 80 chars
set breakindent "baby, yeah!
set mouse=a " activate mouse support
set backspace=indent,eol,start "this is the backspace you want!

" handling backupfiles
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

"Tomorrow color scheme
colo Tomorrow-Night-Eighties

" YCM Configuration
" dont use python-mode autocomplete obsolete now, because of YCM
let g:ycm_filetype_whitelist = {'cpp': 1, 'py': 1, 'python': 1, 'arduino': 1}
" set ycm_extra_conf
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm.py'
" turn off the ycm diagnostic because of struggling with root
"let g:ycm_show_diagnostics_ui = 0

" NERDTree Configuration
" hide some fileextenxions
let NERDTreeIgnore = ['\.pyc$']

" vim-fugitive
" gdiff vertical instead of horizontal
set diffopt+=vertical

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

" configure UltiSnips
let g:UltiSnipsExpandTrigger='<C-j>'
let g:UltiSnipsJumpForwardTrigger='<C-j>'
let g:UltiSnipsJumpBackwardTrigger='<C-k>'

" vCoolor config
let g:vcoolor_map = '<C-c>'
let g:vcool_ins_rgb_map = ''   " Insert rgb color.
let g:vcool_ins_hsl_map = ''   " Insert hsl color.
let g:vcool_ins_rgba_map = ''  " Insert rgba color.

" configure flake8
" autorun flake on save
autocmd BufWritePost *.py call Flake8()

" instant markdown
let g:instant_markdown_autostart = 0

" vebugger
let g:vebugger_leader = "."

" activate mouse support
set mouse=a
set scrolloff=5

syn keyword cppExceptions noexcept

set noequalalways
