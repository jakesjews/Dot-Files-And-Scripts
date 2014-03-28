" Keymapping 

" Disable ex mode
nnoremap Q <nop>

nnoremap <C-K> :call HighlightNearCursor()<CR>
map <C-c> <leader>c<space>
map <C-f> <leader><leader>w

set nocompatible
filetype off

" Plugins

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'taglist.vim'
Bundle 'The-NERD-tree'
Bundle 'The-NERD-Commenter'
Bundle 'surround.vim'
Bundle 'scrooloose/syntastic'
Bundle 'kien/ctrlp.vim'
Bundle 'rking/ag.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-dispatch'

Bundle 'elzr/vim-json'
Bundle 'rails.vim'
Bundle 'derekwyatt/vim-scala'
Bundle 'jimenezrick/vimerl'
Bundle 'slimv.vim'
Bundle 'eagletmt/ghcmod-vim'
Bundle 'vim-coffee-script'
Bundle 'digitaltoad/vim-jade'
Bundle 'wavded/vim-stylus'
Bundle 'moll/vim-node'
Bundle 'ahayman/vim-nodejs-complete'
Bundle 'jnwhiteh/vim-golang'
Bundle 'adimit/prolog.vim'
Bundle 'leafgarland/typescript-vim'
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'darthdeus/vim-emblem'
Bundle 'applescript.vim'
Bundle 'kongo2002/fsharp-vim'
Bundle 'elixir-lang/vim-elixir'
Bundle 'tpope/vim-cucumber'
Bundle 'slim-template/vim-slim'
Bundle 'ekalinin/Dockerfile.vim'
Bundle 'vim-scripts/Vim-R-plugin'
Bundle 'JuliaLang/julia-vim'
Bundle 'nosami/Omnisharp'
Bundle 'wting/rust.vim'

" Bundle 'Shougo/neocomplete.vim'
" let g:neocomplete#enable_at_startup = 1

" Re-add when not so slow
" Bundle 'rizzatti/funcoo.vim'
" Bundle 'rizzatti/dash.vim'

let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'

let g:agprg="ag --smart-case --column"

let NERDTreeIgnore = [
\ '\.hgcheck',    '\.hglf',     '\.nuget',           'publish',
\ '.\vagrant$',   '\.idea',      'eflex.bbprojectd', 'tmp',
\ 'test-results', 'TestResults', 'public',           'compiled',
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
let g:syntastic_cs_checkers = ['syntax', 'issues']
autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

"don't autoselect first item in omnicomplete, show if only one item (for
"preview)
set completeopt=longest,menuone,preview

" automatically add new cs files to the nearest project on save
autocmd BufWritePost *.cs call OmniSharp#AddToProject()

set updatetime=500
set cmdheight=2

set showcmd
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab
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

syntax on
filetype plugin indent on

if &term =~ '^screen'
  set ttymouse=xterm2
endif

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -S -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

if has("gui_running")
  colorscheme molokai
  set guifont=Consolas:h12
  let do_syntax_sel_menu = 1|runtime! synmenu.vim|aunmenu &Syntax.&Show\ filetypes\ in\ menu
endif

" Functions

function HighlightNearCursor()
  if !exists("s:highlightcursor")
    match Todo /\k*\%#\k*/
    let s:highlightcursor=1
  else
    match None
    unlet s:highlightcursor
  endif
endfunction
