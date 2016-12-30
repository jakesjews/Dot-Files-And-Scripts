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
endif

set backspace=indent,eol,start
set backupdir=$HOME/.vim/swap//
set directory=$HOME/.vim/swap//
set undodir=~/.vim/undo//

set nocompatible
set hlsearch
syntax on
filetype plugin indent on

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

"" Plugins
call plug#begin('~/.vim/plugged')

Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-dispatch'
Plug 'scrooloose/nerdcommenter'
Plug 'neomake/neomake'
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-repeat'
Plug 'kurkale6ka/vim-sequence'
Plug 'vim-scripts/taglist.vim'
Plug 'vim-scripts/guicolorscheme.vim'
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/nerdtree', { 'tag': '5.0.0' }
"Plug 'mhinz/vim-grepper'
Plug 'mileszs/ack.vim'
Plug 'Valloric/YouCompleteMe',           { 'do': './install.py --clang-completer --omnisharp-completer --gocode-completer --racer-completer --tern-completer' }
Plug 'rizzatti/dash.vim',                { 'on': '<Plug>DashSearch' }
Plug 'junegunn/vim-easy-align',          { 'on': '<Plug>(EasyAlign)' }
Plug 'junegunn/rainbow_parentheses.vim', { 'for': ['lisp', 'clojure', 'scheme'] }
Plug 'tpope/vim-rails', { 'for': 'ruby' } 
Plug 'moll/vim-node'
Plug 'Konfekt/FastFold'
Plug 'janko-m/vim-test'
Plug 'AndrewRadev/ember_tools.vim'
Plug 'slashmili/alchemist.vim', { 'for': ['elixir'] }

Plug 'adimit/prolog.vim'
Plug 'kongo2002/fsharp-vim'
Plug 'OmniSharp/omnisharp-vim'
Plug 'andreimaxim/vim-io'
Plug 'guersam/vim-j'
Plug 'idris-hackers/idris-vim'
Plug 'ngn/vim-apl'
Plug 'tfnico/vim-gradle'
Plug 'brandonbloom/vim-factor'
Plug 'alunny/pegjs-vim'
Plug 'JuliaLang/julia-vim'
Plug 'sheerun/vim-polyglot'

""" Clojure
Plug 'tpope/vim-leiningen', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

call plug#end()

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_rust_src_path = '/usr/local/src/rust/src'
let g:ycm_python_binary_path = '/usr/local/bin/python3'

let g:polyglot_disabled = ['julia']

let test#strategy = "neovim"

augroup rainbow_lisp
    autocmd!
    autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END

augroup filetypedetect
    au! BufRead,BufNewFile *.m       setfiletype objc
augroup END

let NERDTreeIgnore = [
\ '\.hgcheck',    '\.hglf',     '\.nuget',           'publish',
\ '.\vagrant$',   '\.idea',      'eflex.bbprojectd', 'tmp',
\ 'test-results', 'TestResults',            'compiled',
\ 'node_modules', 'bin',         'obj',              'Properties',
\
\ '\.suo$',            '\.hgtabs$',      '\.orig$',       '\.userconfig$', 
\ 'npm-debug.log',     '\.swp$',         '\.tmp$',        '\.reh$', 
\ '.DS_Store',         '\.iml$',         '\~$',           '.sublime-workspace', 
\ '\.userprefs$',      '.tm_properties', '\.jar$',        '\.pfx$', 
\ '\.sublime-project', '\.DotSettings',  'TestResult.xml', 'target'
\ ]

autocmd! BufWritePost * Neomake

"don't autoselect first item in omnicomplete, show if only one item (for
"preview)
set completeopt=longest,menuone,preview

set showcmd
set tabstop=4
set shiftwidth=4
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

au FileType python setl sw=2 sts=2 ts=2 et
au FileType coffee setl sw=2 sts=2 ts=2 et
au FileType javascript setl sw=2 sts=2 ts=2 et
au FileType javascript set sw=2 sts=2 ts=2 et
au FileType ruby setl sw=2 sts=2 ts=2 et
au FileType stylus setl sw=2 sts=2 ts=2 et
au FileType yml setl sw=2 sts=2 ts=2 et
au FileType cs setl sw=4 sts=4 ts=4 et
au FileType pug setl sw=2 sts=2 ts=2 et

au BufRead,BufNewFile *.AWL set filetype=asm

setglobal tags-=./tags tags-=./tags; tags^=./tags;

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

if &term =~ '^screen'
  set ttymouse=xterm2
endif

if executable('rg')
  let g:ackprg = 'rg --vimgrep --smart-case'   
  cnoreabbrev rg Ack
  cnoreabbrev rG Ack
  cnoreabbrev Rg Ack
  cnoreabbrev RG Ack

  let g:ctrlp_user_command = 'rg %s -S -l --files -g ""'
  let g:ctrlp_use_caching = 0
endif

" Colors
colorscheme jellybeans

if has("gui_running")
  set guifont=Consolas:h12
  let do_syntax_sel_menu = 1|runtime! synmenu.vim|aunmenu &Syntax.&Show\ filetypes\ in\ menu
else
  " make black background work in iterm
  highlight Normal ctermbg=NONE
  highlight nonText ctermbg=NONE
endif
