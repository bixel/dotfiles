call plug#begin('~/.vim/plugged')

" let Vundle manage Vundle, required
Plug 'Shougo/neocomplete.vim'
Plug 'osyo-manga/vim-marching'
Plug 'Shougo/vimproc.vim'
Plug 'osyo-manga/vim-reunions'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'rust-lang/rust.vim'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-startify'
" Dene runtime-path (rtp) if there is no explicit repo for vim
Plug 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-airline'
Plug 'terryma/vim-multiple-cursors'
Plug 'suan/vim-instant-markdown'
Plug 'tpope/vim-markdown'
Plug 'KabbAmine/vCoolor.vim'
Plug 'nvie/vim-flake8'
Plug 'Raimondi/delimitMate'
Plug 'SirVer/ultisnips'
Plug 'rizzatti/dash.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
" Plugin 'gilligan/vim-lldb'

" All of your Plugins must be added before the following line
call plug#end()            " required

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

" NeoComplete Setup
let g:neocomplete#enable_at_startup = 1
" use smartcase
let g:neocomplete#enable_smart_case = 1

" vim-marching setup
let g:marching_include_paths = [
\   "/Users/bixel/binaries/root/include/root"
\]
let g:marching_clang_command = "/usr/bin/clang"
" cooperate with neocomplete.vim
let g:marching_enable_neocomplete = 1

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
" for c and c++
let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

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
