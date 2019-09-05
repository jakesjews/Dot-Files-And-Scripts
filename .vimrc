" Disable ex mode
nnoremap Q <nop>
nnoremap x "_x

map <C-c> <leader>c<space>
map <C-f> <leader><leader>w
map <C-t> :TestNearest<CR>
map <silent> <C-@> <Plug>DashSearch
vmap <Enter> <Plug>(EasyAlign)
vnoremap . :normal .<CR>
nnoremap <C-e> :e.<CR>

if has('nvim')
  tnoremap <C-w> <C-\><C-n> 
  set termguicolors
endif

set backspace=indent,eol,start
set backupdir=$HOME/.vim/swap//
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

"" Plugins
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-dispatch'
Plug 'scrooloose/nerdcommenter'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-surround'
Plug 'machakann/vim-sandwich'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nixprime/cpsm', { 'do': 'env ./install.sh' }
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-repeat'
Plug 'majutsushi/tagbar'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'mhinz/vim-grepper'
Plug 'racer-rust/vim-racer'
Plug 'rizzatti/dash.vim', { 'on': '<Plug>DashSearch' }
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
Plug 'yegappan/mru'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-fugitive'
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'adimit/prolog.vim'
Plug 'guersam/vim-j'
Plug 'ngn/vim-apl'
Plug 'brandonbloom/vim-factor'
Plug 'alunny/pegjs-vim'
Plug 'robbles/logstash.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'rhysd/vim-wasm'
Plug 'jakesjews/vim-emblem'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

call plug#end()

let g:polyglot_disabled = ['coffee-script', 'emblem']

let g:test#strategy = 'neovim'

let g:racer_cmd = '/Users/jacob/.cargo/bin/racer'

let g:ctrlp_match_func = { 'match': 'cpsm#CtrlPMatch' }

let g:vim_javascript_imports_use_semicolons = 0
let g:vim_ember_imports_multiline_max_col = 120
let g:ember_imports_ember_data_next = 1

let g:ansible_template_syntaxes = { 
\ '*.sh.j2': 'sh', 
\ '*.json.j2': 'json', 
\ '*.js.j2': 'javascript' 
\ }

let g:ale_echo_msg_format = '%linter% says %s'

inoremap <expr><Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr><Up>   pumvisible() ? "\<C-p>" : "\<Up>"

augroup rainbow_lisp
    autocmd!
    autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END

augroup filetypedetect
    au! BufRead,BufNewFile *.m setfiletype objc
    au BufRead,BufNewFile *.AWL set filetype=asm
    au FileType cs setl sw=4 sts=4 ts=4 et
    au FileType c setl sw=4 sts=4 ts=4 et
    au FileType cpp setl sw=4 sts=4 ts=4 et
    au FileType zsh setl sw=4 sts=4 ts=4 et
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
\ '\.sublime-project', '\.DotSettings',  'TestResult.xml', 'target'
\ ]

let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeCascadeSingleChildDir = 0

"don't autoselect first item in omnicomplete, show if only one item (for
"preview)
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

let g:grepper = {
    \ 'prompt': 0,
    \ 'rg': {
    \   'grepprg': 'rg -H --no-heading --vimgrep --smart-case'
    \ }}

if executable('rg')
  cnoreabbrev rg GrepperRg
  cnoreabbrev rG GrepperRg
  cnoreabbrev Rg GrepperRg
  cnoreabbrev RG GrepperRg

  let g:ctrlp_user_command_async = 1
  let g:ctrlp_user_command = 'rg %s -S -l --files -g ""'
  let g:ctrlp_use_caching = 0
endif

set background=dark
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

if has('gui_running')
  set guifont=Consolas:h12
  let g:do_syntax_sel_menu = 1|runtime! synmenu.vim|aunmenu &Syntax.&Show\ filetypes\ in\ menu
else
  " make black background work in iterm
  highlight Normal ctermbg=NONE
  highlight nonText ctermbg=NONE
endif

