" set the runtime path to include Vundle and initialize
call plug#begin('~/.config/nvim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-clang'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-startify'
" Define runtime-path (rtp) if there is no explicit repo for vim
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'suan/vim-instant-markdown'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-markdown'
Plug 'KabbAmine/vCoolor.vim'
Plug 'nvie/vim-flake8'
Plug 'SirVer/ultisnips'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'lervag/vimtex'
Plug 'ap/vim-css-color'
Plug 'mattn/emmet-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'pangloss/vim-javascript', { 'for': 'javacript' }
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
Plug 'roxma/vim-tmux-clipboard'
Plug 'Chiel92/vim-autoformat'
" Plug 'apple/swift', { 'rtp': 'utils/vim', 'for': 'swift', 'frozen': 'true' }
Plug 'keith/swift.vim'
Plug 'https://bitbucket.org/johanneskoester/snakemake.git', {'rtp': 'misc/vim/'}
Plug 'junegunn/vim-easy-align'
Plug 'glench/vim-jinja2-syntax'
Plug 'fatih/vim-go'

" All of your Plugins must be added before the following line
call plug#end()  " required

"
" U S E R  S E T U P
"

" Recursive file search
set path+=**

" Ignore some stuff esp. for ctrlP
set wildignore+=*/node_modules/*,*/build*/*,*/InstallArea/*

" Make watchdogs possible
set backupcopy=yes

" jump between split lines
map j gj
map k gk

nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

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

" toggle background with ,i
nnoremap <leader>i :let &background = (&background == "dark" ? "light" : "dark")<CR>

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
set relativenumber  " aka :set rnu

" searching
set ignorecase " ignore case while searching
nnoremap <C-s> :set hlsearch!<CR>

" autoformatting
let g:formatter_python = ['yapf']
let g:formatter_yapf_style = 'pep8'

" handling backupfiles
set backupdir=~/.config/nvim/backup//
set directory=~/.config/nvim/swap//
set undodir=~/.config/nvim/undo//

" NERDTree Configuration
" hide some fileextenxions
let NERDTreeIgnore = ['\.pyc$']

" vim-fugitive
" gdiff vertical instead of horizontal
set diffopt+=vertical

" Airline stuff
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

" limelight+goyo settings, automatically fire up limelight with goyo
let g:limelight_conceal_ctermfg = 'gray'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
" map `,g` to start goyo
nnoremap <leader>g :Goyo<CR>

" Enable emmet-vim just for html/css
let g:user_emmet_isntall_global = 0
autocmd FileType html,css,md EmmetInstall

" configure flake8
" bind `,f` to Flake8
nnoremap <leader>f :call Flake8()<CR>
let g:flake8_show_quickfix=1
let g:flake8_show_in_gutter=1

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
let g:vimtex_compiler_progname="nvr"
let g:vimtex_view_method = 'skim'
" let g:vimtex_view_general_viewer = 'open'
" let g:vimtex_view_general_options = '-a Skim'

let g:vimtex_compiler_latexmk={
    \ 'options' : [
    \   '-lualatex',
    \   '-silent',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \ 'build_dir' : 'livepreview',
    \}

" use deoplete
let g:deoplete#enable_at_startup = 1
" close preview window after completion or on leave https://github.com/Shougo/deoplete.nvim/issues/115
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" deoplete clang completion
let g:deoplete#sources#clang#clang_complete_database = '/net/nfshome/home/kheinicke/DevEnvironments/FTDevelopment/PHYS/PHYS_flavtagmaster/build.x86_64-centos7-gcc62-opt/'
let g:deoplete#sources#clang#libclang_path = '/net/nfshome/home/kheinicke/.local/lib/libclang.so'
" show docstring in preview window
let g:deoplete#sources#jedi#show_docstring = 1

" vimtex settings
let g:vimtex_matchparen_enabled=0  " turn off folding to speed up things

" Snakemake syntax
au BufNewFile,BufRead Snakefile set syntax=snakemake
au BufNewFile,BufRead *.rules set syntax=snakemake
au BufNewFile,BufRead *.snakefile set syntax=snakemake
au BufNewFile,BufRead *.snake set syntax=snakemake

" golang
let g:go_fmt_command = "goimports"
" only for the e5 interactive machines
let g:go_version_warning = 0

" easy align
vmap <Enter> <Plug>(EasyAlign)

source $HOME/.config/nvim/local.vimrc
