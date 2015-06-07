" Disable ex mode
nnoremap Q <nop>
nnoremap x "_x

map <C-c> <leader>c<space>
map <C-f> <leader><leader>w
map <silent> <C-@> <Plug>DashSearch
vmap <Enter> <Plug>(EasyAlign)

vnoremap . :normal .<CR>
nnoremap <C-e> :e.<CR>

set backspace=indent,eol,start
set backupdir=$HOME/.vim/swap//
set directory=$HOME/.vim/swap//

set nocompatible
syntax on
filetype plugin indent on

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-dispatch'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-repeat'
Plug 'kurkale6ka/vim-sequence'
Plug 'vim-scripts/taglist.vim'
Plug 'vim-scripts/guicolorscheme.vim'
Plug 'scrooloose/nerdtree'
Plug 'rking/ag.vim',                     { 'on': 'Ag' }
Plug 'Valloric/YouCompleteMe',           { 'do': './install.sh --clang-completer --omnisharp-completer' }
Plug 'rizzatti/dash.vim',                { 'on': '<Plug>DashSearch' }
Plug 'junegunn/vim-easy-align',          { 'on': '<Plug>(EasyAlign)' }
Plug 'junegunn/rainbow_parentheses.vim', { 'for': ['lisp', 'clojure', 'scheme'] }

Plug 'tpope/vim-rails', { 'for': 'ruby' } 
Plug 'derekwyatt/vim-scala'
Plug 'jimenezrick/vimerl'
Plug 'kchmck/vim-coffee-script'
Plug 'digitaltoad/vim-jade'
Plug 'wavded/vim-stylus'
Plug 'marijnh/tern_for_vim'
Plug 'fatih/vim-go'
Plug 'adimit/prolog.vim'
Plug 'leafgarland/typescript-vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'heartsentwined/vim-emblem'
Plug 'vim-scripts/applescript.vim'
Plug 'kongo2002/fsharp-vim'
Plug 'elixir-lang/vim-elixir'
Plug 'tpope/vim-cucumber'
Plug 'slim-template/vim-slim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'vim-scripts/Vim-R-plugin'
Plug 'JuliaLang/julia-vim'
Plug 'nosami/Omnisharp'
Plug 'rust-lang/rust.vim'
Plug 'andreimaxim/vim-io'
Plug 'guersam/vim-j'
Plug 'idris-hackers/idris-vim'
Plug 'ngn/vim-apl'
Plug 'b4winckler/vim-objc'
Plug 'tfnico/vim-gradle'
Plug 'petRUShka/vim-opencl'
Plug 'lambdatoast/elm.vim'
Plug 'brandonbloom/vim-factor'
Plug 'toyamarinyon/vim-swift'
Plug 'alunny/pegjs-vim'
Plug 'jplaut/vim-arduino-ino'
Plug 'zah/nimrod.vim'
Plug 'cespare/vim-toml'

"" Clojure
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'tpope/vim-leiningen', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'dgrnbrg/vim-redl', { 'for': 'clojure' }

call plug#end()

autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 tabstop=2
autocmd BufNewFile,BufReadPost *.feature setl shiftwidth=2 tabstop=2
autocmd BufNewFile,BufReadPost *.js setl shiftwidth=2 tabstop=2
autocmd BufNewFile,BufReadPost *.rb setl shiftwidth=2 tabstop=2
autocmd BufNewFile,BufReadPost *.styl setl shiftwidth=2 tabstop=2
autocmd BufNewFile,BufReadPost *.yml setl shiftwidth=2 tabstop=2
autocmd BufNewFile,BufReadPost *.cs setl shiftwidth=4 tabstop=4
autocmd BufNewFile,BufReadPost *.jade setl shiftwidth=2 tabstop=2

au BufRead,BufNewFile *.AWL set filetype=asm

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0

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
\ '\.sublime-project', '\.DotSettings',  'TestResult.xml'
\ ]

""" Omnisharp settings
" check for csharp syntax errors and code issues with syntastic
let g:syntastic_cs_checkers = ['syntax']
autocmd InsertLeave *.cs SyntasticCheck

"don't autoselect first item in omnicomplete, show if only one item (for
"preview)
set completeopt=longest,menuone,preview

"nnoremap <leader><space> :OmniSharpGetCodeActions<cr>

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

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
set cursorline
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

if &term =~ '^screen'
  set ttymouse=xterm2
endif

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor

  let g:agprg="ag --smart-case --column"
  let g:ctrlp_user_command = 'ag %s -S -l --depth -1 --nocolor -g ""'
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

