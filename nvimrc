" set the runtime path to include Vundle and initialize
call plug#begin('~/.config/nvim/plugged')

Plug 'Valloric/YouCompleteMe'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'rust-lang/rust.vim'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-startify'
" Define runtime-path (rtp) if there is no explicit repo for vim
Plug 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'terryma/vim-multiple-cursors'
Plug 'suan/vim-instant-markdown'
Plug 'tpope/vim-markdown'
Plug 'KabbAmine/vCoolor.vim'
Plug 'nvie/vim-flake8'
Plug 'Raimondi/delimitMate'
Plug 'SirVer/ultisnips'
Plug 'rizzatti/dash.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'lervag/vimtex'
Plug 'ap/vim-css-color'
" Plug 'gilligan/vim-lldb'
Plug 'critiqjo/lldb.nvim'
Plug 'mattn/emmet-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'pangloss/vim-javascript'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-unimpaired'
Plug 'othree/yajs.vim'
Plug 'tpope/vim-surround'

" All of your Plugins must be added before the following line
call plug#end()  " required

"
" U S E R  S E T U P
"

" Recursive file search
set path+=**
set wildmenu

" jump between split lines
map j gj
map k gk

set relativenumber  " aka :set rnu

"map mapleader / to (german layout)
let mapleader = ","

" execute current file
nnoremap <leader>e :!'%:p'<CR>
" Run `make` in current directory
nnoremap <leader>m :!make<CR>
" open build/*.pdf
nnoremap <leader>o :!open build/*.pdf<CR>

" open Nerdtree with CTRL+n
map <C-n> :NERDTreeToggle<CR>

" open Tagbar with CTRL+m
map <C-m> :TagbarToggle<CR>

" toggle background with CTRL+I
map <C-I> :let &background = (&background == "dark" ? "light" : "dark")<CR>

" :w for :W
command W w
command Wq wq
command Q q
command Qa qa
command WQ wq

" color scheme
colo solarized

set ai  " Set auto inline on
set number  " Show line numbers
syntax on  " Set syntax highlighting on

set tabstop=4  " width of tab
" should be redundant after tabstop and expandtab,
" but vim-snipmate is messing up (?)
set softtabstop=4
set shiftwidth=4
set expandtab " use 'tabstop' spaces instead of tab
set colorcolumn=80 " Bar hinting for 80 chars
set breakindent "baby, yeah!
set mouse=a " activate mouse support
set ignorecase " ignore case while searching

" handling backupfiles
set backupdir=~/.config/nvim/backup//
set directory=~/.config/nvim/swap//
set undodir=~/.config/nvim/undo//

" YCM Configuration
" dont use python-mode autocomplete obsolete now, because of YCM
let g:ycm_filetype_whitelist = {'cpp': 1, 'py': 1, 'python': 1, 'arduino': 1, 'js': 1}
" set ycm_extra_conf
let g:ycm_global_ycm_extra_conf = '~/.ycm.py'
" turn off the ycm diagnostic because of struggling with root
"let g:ycm_show_diagnostics_ui = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_path_to_python_interpreter='/usr/local/bin/python'

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
let g:multi_cursor_quit_key='<Esc>'

" configure UltiSnips
let g:UltiSnipsExpandTrigger='<C-j>'
let g:UltiSnipsJumpForwardTrigger='<C-j>'
let g:UltiSnipsJumpBackwardTrigger='<C-k>'

" vCoolor config
let g:vcoolor_map = '<C-c>'
let g:vcool_ins_rgb_map = ''  " Insert rgb color.
let g:vcool_ins_hsl_map = ''  " Insert hsl color.
let g:vcool_ins_rgba_map = ''  " Insert rgba color.

" vim-javascript config
let g:javascript_enable_domhtmlcss = 1

" limelight+goyo settings
let g:limelight_conceal_ctermfg = 'gray'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
nnoremap <leader>g :Goyo<CR>

" Enable emmet-vim just for html/css
let g:user_emmet_isntall_global = 0
autocmd FileType html,css EmmetInstall

" configure flake8
" bind `,f` to Flake8
nnoremap <leader>f :call Flake8()<CR>

" instant markdown
let g:instant_markdown_autostart = 0

" activate mouse support
set mouse=a
set scrolloff=5

" add some cpp-keywords
syn keyword cppExceptions noexcept using

" allow mouse clicks to change cursor position
set noequalalways

" list whitespaces and some other characters
set listchars=tab:>-,trail:~
set list

" use latex flavour for plaintex files
let g:tex_flavour="latex"
" set some default options for my personal latexmk
let g:vimtex_latexmk_options=" -lualatex
                            \ -jobname=./build/document
                            \ -interaction=nonstopmode
                            \ -halt-on-error
                            \ -pvc"
" let youcompleteme complete tex
if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
      \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
      \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
      \ 're!\\hyperref\[[^]]*',
      \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
      \ 're!\\(include(only)?|input){[^}]*',
      \ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
      \ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
      \ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
      \ ]
