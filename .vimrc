" Disable ex mode
nnoremap Q <nop>
nnoremap x "_x

map <C-c> <leader>c<space>
map <C-f> <leader><leader>w
map <C-t> :TestNearest<CR>
map <C-q> :Dash<CR>
map <C-p> :Files<CR>
vmap <Enter> <Plug>(EasyAlign)
vnoremap . :normal .<CR>
nnoremap <C-e> :e.<CR>

if has('nvim')
  tnoremap <C-w> <C-\><C-n> 
  set termguicolors
endif

set backspace=indent,eol,start
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//
set undodir=~/.vim/undo//

set hlsearch
set autoread
syntax on
filetype plugin indent on

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup install_vim_plug
    autocmd VimEnter * PlugInstall
  augroup end
endif

let g:polyglot_disabled = ['coffee-script', 'emblem', 'yaml', 'cs', 'jinja', 'ansible']

"" Plugins
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-dispatch'
Plug 'scrooloose/nerdcommenter'
Plug 'dense-analysis/ale'
Plug 'machakann/vim-sandwich'
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'pearofducks/ansible-vim'
Plug 'tpope/vim-repeat'
Plug 'majutsushi/tagbar'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'scrooloose/nerdtree'
Plug 'rizzatti/dash.vim'
Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
Plug 'junegunn/rainbow_parentheses.vim', { 'for': ['lisp', 'clojure', 'scheme'] }
Plug 'tpope/vim-rails', { 'for': 'ruby' } 
Plug 'moll/vim-node'
Plug 'Konfekt/FastFold'
Plug 'janko-m/vim-test'
Plug 'sukima/vim-javascript-imports'
Plug 'AndrewRadev/ember_tools.vim'
Plug 'sukima/vim-ember-imports'
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-fugitive'
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-sleuth'
Plug 'OmniSharp/omnisharp-vim'
Plug 'metakirby5/codi.vim'
Plug 'Yggdroot/indentLine'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'ngn/vim-apl'
Plug 'brandonbloom/vim-factor'
Plug 'alunny/pegjs-vim'
Plug 'robbles/logstash.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'rhysd/vim-wasm'
Plug 'jakesjews/vim-emblem'
Plug 'wlangstroth/vim-racket'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

call plug#end()

let g:coc_global_extensions = [
  \ 'coc-ember'
\ ]

let g:test#strategy = 'neovim'

let g:vim_javascript_imports_use_semicolons = 0
let g:vim_ember_imports_multiline_max_col = 120
let g:ember_imports_ember_data_next = 1

let g:ansible_template_syntaxes = { 
\ '*.sh.j2': 'sh', 
\ '*.json.j2': 'json', 
\ '*.js.j2': 'javascript', 
\ '*.conf.j2': 'dosini', 
\ }

let g:ale_echo_msg_format = '%linter% says %s'
let g:ale_linter_aliases = {'coffee': ['javascript']}

let g:ale_linters = {
\ 'coffee': ['eslint'],
\ 'javascript': ['eslint'],
\ 'cs': ['OmniSharp']
\}

let g:ale_fixers = {
\ 'coffee': ['eslint'],
\ 'javascript': ['eslint']
\}

let g:OmniSharp_server_stdio = 1
let g:OmniSharp_highlight_types = 3

inoremap <expr><Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr><Up>   pumvisible() ? "\<C-p>" : "\<Up>"

augroup rainbow_lisp
    autocmd!
    autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END

augroup filetypedetect
    au! BufRead,BufNewFile *.m setfiletype objc
    au BufRead,BufNewFile *.AWL setfiletype asm
    au BufRead,BufNewFile *.razor setfiletype razor
    au FileType cs setl sw=4 sts=4 ts=4 et
    au FileType c setl sw=4 sts=4 ts=4 et
    au FileType cpp setl sw=4 sts=4 ts=4 et
    au FileType zsh setl sw=4 sts=4 ts=4 et
    au FileType sh setl sw=4 sts=4 ts=4 et
    au FileType make setl noexpandtab sw=4 sts=0 ts=4
augroup END

let g:NERDTreeIgnore = [
\ '\.hgcheck',    '\.hglf', '\.nuget', 'publish',
\ '.\vagrant$',   '\.idea', 'eflex.bbprojectd', 'tmp',
\ 'test-results', 'TestResults', 'compiled',
\ 'node_modules', 'bin', 'obj', 'Properties', 'coverage',
\
\ '\.suo$',            '\.hgtabs$',      '\.orig$',       '\.userconfig$', 
\ 'npm-debug.log',     '\.swp$',         '\.tmp$',        '\.reh$', 
\ '.DS_Store',         '\.iml$',         '\~$',           '.sublime-workspace', 
\ '\.userprefs$',      '.tm_properties', '\.jar$',        '\.pfx$', 
\ '\.sublime-project', '\.DotSettings',  'TestResult.xml'
\ ]

let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeCascadeSingleChildDir = 0

"don't autoselect first item in omnicomplete, show if only one item (for preview)
set completeopt=longest,menuone,preview

set showcmd
set tabstop=2
set shiftwidth=2
set autoindent
set expandtab
set smarttab
set ignorecase
set smartcase
set number
set incsearch
set autowrite
set pastetoggle=<F2>
set mouse=a
set clipboard=unnamed
set foldmethod=indent
set foldlevel=99
set splitright
set ruler
set wildmenu
set formatoptions+=j " Delete comment character when joining commented lines
set autoread
set fileformats+=mac

setglobal tags-=./tags tags-=./tags; tags^=./tags;

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

if &term =~? '^screen'
  set ttymouse=xterm2
endif

cnoreabbrev rg Rg
cnoreabbrev rG Rg
cnoreabbrev RG Rg

set background=dark
colorscheme dracula
hi! link SpecialComment DraculaCyan
hi! link Type DraculaCyan
hi! def link coffeeObjAssign Function
hi! def link coffeeSpecialIdent DraculaOrange
hi! def link coffeeKeyword DraculaRed
hi! def link coffeeStatement DraculaRed
hi Normal guibg=NONE ctermbg=NONE

