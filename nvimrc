" set the runtime path to include Vundle and initialize
call plug#begin('~/.config/nvim/plugged')

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'whiteinge/diffconflicts'
Plug 'mhinz/vim-startify'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'suan/vim-instant-markdown'
Plug 'tpope/vim-markdown'
Plug 'nvie/vim-flake8'
Plug 'SirVer/ultisnips'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'lervag/vimtex'
Plug 'ap/vim-css-color'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'pangloss/vim-javascript', { 'for': 'javacript' }
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
Plug 'roxma/vim-tmux-clipboard'
Plug 'Chiel92/vim-autoformat'
Plug 'keith/swift.vim'
Plug 'snakemake/snakemake', {'rtp': 'misc/vim/'}
Plug 'junegunn/vim-easy-align'
Plug 'glench/vim-jinja2-syntax'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

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

" toggle background with ,i
nnoremap <leader>i :let &background = (&background == "dark" ? "light" : "dark")<CR>

" Open fzf file list
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader>b  :Buffers<CR>
nnoremap <silent> <Leader>t  :Tags<CR>

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

" startify
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1

" vim-javascript config
let g:javascript_enable_domhtmlcss = 1

" limelight+goyo settings, automatically fire up limelight with goyo
let g:limelight_conceal_ctermfg = 'gray'
let g:goyo_width = 85
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
let g:tex_flavor = "latex"

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
    \   '-shell-escape',
    \ ],
    \ 'build_dir' : 'livepreview',
    \}
let g:vimtex_quickfix_ignore_filters = [
    \ 'Marginpar on page',
    \]
let g:vimtex_quickfix_autoclose_after_keystrokes = 5

let g:vimtex_matchparen_enabled=0  " turn off folding to speed up things


"
" coc.nvim
"

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
" use them anyway
" set nobackup
" set nowritebackup

" Give more space for displaying messages.
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"
" End COC
"

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
