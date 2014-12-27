" Keymapping 

" Disable ex mode
nnoremap Q <nop>

nnoremap <C-K> :call HighlightNearCursor()<CR>
map <C-c> <leader>c<space>
map <C-f> <leader><leader>w
map <silent> <C-@> <Plug>DashSearch
vmap <Enter> <Plug>(EasyAlign)

vnoremap . :normal .<CR>
nnoremap <C-e> :e.<CR>

set backspace=indent,eol,start

set nocompatible
filetype off


" Plugins

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'taglist.vim'
Plugin 'The-NERD-tree'
Plugin 'The-NERD-Commenter'
Plugin 'surround.vim'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-dispatch'
Plugin 'guicolorscheme.vim'
Plugin 'rizzatti/dash.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'editorconfig/editorconfig-vim'

Plugin 'rails.vim'
Plugin 'derekwyatt/vim-scala'
Plugin 'jimenezrick/vimerl'
Plugin 'guns/vim-clojure-static'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'eagletmt/ghcmod-vim'
Plugin 'vim-coffee-script'
Plugin 'digitaltoad/vim-jade'
Plugin 'wavded/vim-stylus'
Plugin 'moll/vim-node'
Plugin 'marijnh/tern_for_vim'
Plugin 'fatih/vim-go'
Plugin 'adimit/prolog.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'darthdeus/vim-emblem'
Plugin 'applescript.vim'
Plugin 'kongo2002/fsharp-vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'tpope/vim-cucumber'
Plugin 'slim-template/vim-slim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'vim-scripts/Vim-R-plugin'
Plugin 'JuliaLang/julia-vim'
Plugin 'nosami/Omnisharp'
Plugin 'wting/rust.vim'
Plugin 'andreimaxim/vim-io'
Plugin 'guersam/vim-j'
Plugin 'idris-hackers/idris-vim'
Plugin 'ngn/vim-apl'
Plugin 'b4winckler/vim-objc'
Plugin 'tfnico/vim-gradle'
Plugin 'petRUShka/vim-opencl'
Plugin 'lambdatoast/elm.vim'
Plugin 'Keithbsmiley/swift.vim'

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

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0

let g:agprg="ag --smart-case --column"

let g:rbpt_colorpairs = [
  \ [ '13', '#6c71c4'],
  \ [ '5',  '#d33682'],
  \ [ '1',  '#dc322f'],
  \ [ '9',  '#cb4b16'],
  \ [ '3',  '#b58900'],
  \ [ '2',  '#859900'],
  \ [ '6',  '#2aa198'],
  \ [ '4',  '#268bd2'],
  \ ]

augroup rainbow_parentheses
  au!
  au VimEnter *.clj RainbowParenthesesActivate
  au BufEnter *.clj RainbowParenthesesLoadRound
  au BufEnter *.clj RainbowParenthesesLoadSquare
  au BufEnter *.clj RainbowParenthesesLoadBraces
augroup END

augroup filetypedetect
    au! BufRead,BufNewFile *.m       setfiletype objc
augroup END

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

if &term =~ '^screen'
  set ttymouse=xterm2
endif

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
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


" Functions
"
function HighlightNearCursor()
  if !exists("s:highlightcursor")
    match Todo /\k*\%#\k*/
    let s:highlightcursor=1
  else
    match None
    unlet s:highlightcursor
  endif
endfunction

