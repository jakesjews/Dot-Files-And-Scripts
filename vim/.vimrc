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
filetype off

" Plugins

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-dispatch'
Plugin 'rizzatti/dash.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'junegunn/rainbow_parentheses.vim'
Plugin 'tpope/vim-repeat'
Plugin 'kurkale6ka/vim-sequence'
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/guicolorscheme.vim'

Plugin 'tpope/vim-rails'
Plugin 'derekwyatt/vim-scala'
Plugin 'jimenezrick/vimerl'
Plugin 'eagletmt/ghcmod-vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'digitaltoad/vim-jade'
Plugin 'wavded/vim-stylus'
Plugin 'moll/vim-node'
Plugin 'marijnh/tern_for_vim'
Plugin 'fatih/vim-go'
Plugin 'adimit/prolog.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'heartsentwined/vim-emblem'
Plugin 'vim-scripts/applescript.vim'
Plugin 'kongo2002/fsharp-vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'tpope/vim-cucumber'
Plugin 'slim-template/vim-slim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'vim-scripts/Vim-R-plugin'
Plugin 'JuliaLang/julia-vim'
Plugin 'nosami/Omnisharp'
Plugin 'rust-lang/rust.vim'
Plugin 'andreimaxim/vim-io'
Plugin 'guersam/vim-j'
Plugin 'idris-hackers/idris-vim'
Plugin 'ngn/vim-apl'
Plugin 'b4winckler/vim-objc'
Plugin 'tfnico/vim-gradle'
Plugin 'petRUShka/vim-opencl'
Plugin 'lambdatoast/elm.vim'
Plugin 'brandonbloom/vim-factor'
Plugin 'toyamarinyon/vim-swift'
Plugin 'alunny/pegjs-vim'
Plugin 'jplaut/vim-arduino-ino'
Plugin 'zah/nimrod.vim'
Plugin 'cespare/vim-toml'

" Clojure
Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-leiningen'
Plugin 'tpope/vim-fireplace'
Plugin 'dgrnbrg/vim-redl'

call vundle#end()
syntax on
filetype plugin indent on

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

