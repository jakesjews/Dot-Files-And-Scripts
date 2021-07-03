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
tnoremap <C-w> <C-\><C-n> 

set termguicolors
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

let g:polyglot_disabled = ['coffee-script', 'emblem', 'yaml', 'cs', 'jinja', 'ansible', 'handlebars']

"" Plugins
call plug#begin('~/.vim/plugged')

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'tpope/vim-dispatch'
Plug 'scrooloose/nerdcommenter'
Plug 'dense-analysis/ale'
Plug 'machakann/vim-sandwich'
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim', { 'commit': '75798afff51e764ada87149b16bb56a6ef971042' }
Plug 'jesseleite/vim-agriculture'
Plug 'editorconfig/editorconfig-vim'
Plug 'majutsushi/tagbar'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'scrooloose/nerdtree'
Plug 'rizzatti/dash.vim'
Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
Plug 'junegunn/rainbow_parentheses.vim', { 'for': ['lisp', 'clojure', 'scheme'] }
Plug 'janko-m/vim-test'
Plug 'sukima/vim-javascript-imports', { 'for': ['coffee', 'javascript', 'typescript'] }
Plug 'Quramy/vim-js-pretty-template'
Plug 'sukima/vim-ember-imports', { 'for': ['coffee', 'javascript', 'typescript'] }
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-fugitive'
Plug 'eraserhd/parinfer-rust', { 'do': 'cargo build --release' }
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-projectionist'
Plug 'metakirby5/codi.vim'
Plug 'Yggdroot/indentLine'
Plug 'puremourning/vimspector'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'tpope/vim-rails', { 'for': 'ruby' } 
Plug 'moll/vim-node', { 'for': ['coffee', 'javascript', 'typescript'] }
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }
Plug 'OmniSharp/omnisharp-vim', { 'for': ['cs', 'fsharp', 'vbnet'] }
Plug 'ngn/vim-apl'
Plug 'pearofducks/ansible-vim', { 'for': 'ansible' }
Plug 'brandonbloom/vim-factor', { 'for': 'factor' }
Plug 'alunny/pegjs-vim', { 'for': 'pegjs' }
Plug 'robbles/logstash.vim', { 'for': 'logstash' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'rhysd/vim-wasm', { 'for': 'wast' }
Plug 'jakesjews/vim-emblem', { 'for': 'emblem' }
Plug 'katusk/vim-qkdb-syntax', { 'for': ['q', 'k'] }
Plug 'leanprover/lean.vim'
Plug 'joukevandermaas/vim-ember-hbs', { 'for': 'handlebars' }
Plug 'tpope/vim-salve', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'thyrgle/vim-dyon', { 'for': 'dyon' }
Plug 'sheerun/vim-polyglot'

call plug#end()

let g:coc_global_extensions = [
\ 'coc-actions',
\ 'coc-clangd',
\ 'coc-cmake',
\ 'coc-css',
\ 'coc-elixir',
\ 'coc-erlang_ls',
\ 'coc-flutter',
\ 'coc-go',
\ 'coc-html',
\ 'coc-java',
\ 'coc-json',
\ 'coc-metals',
\ 'coc-omnisharp',
\ 'coc-perl',
\ 'coc-phpls',
\ 'coc-powershell',
\ 'coc-python',
\ 'coc-r-lsp',
\ 'coc-rls',
\ 'coc-sh',
\ 'coc-solargraph',
\ 'coc-sourcekit',
\ 'coc-sql',
\ 'coc-svg',
\ 'coc-texlab',
\ 'coc-tsserver',
\ 'coc-vimlsp',
\ 'coc-xml',
\ 'coc-yaml',
\ 'coc-ember'
\ ]

let g:test#strategy = 'neovim'

let g:vim_javascript_imports_multiline_max_col = 120
let g:vim_javascript_imports_multiline_max_vars = 100
let g:ember_imports_ember_data_next = 1

let g:salve_auto_start_repl = 1

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
\ 'elixir': ['elixir-ls'],
\ 'javascript': ['eslint'],
\ 'cs': ['OmniSharp'],
\ 'html': { 'handlebars': ['ember-template-lint'] }
\}

let g:ale_fixers = {
\ 'coffee': ['eslint'],
\ 'javascript': ['eslint'],
\ 'html': { 'handlebars': ['ember-template-lint'] }
\}

let g:ale_elixir_elixir_ls_release = expand("~/.config/coc/extensions/node_modules/coc-elixir/els-release")

let g:OmniSharp_server_stdio = 1
let g:OmniSharp_highlight_types = 3

let g:agriculture#disable_smart_quoting = 1
let g:agriculture#rg_options = '--smart-case'

let g:vimspector_enable_mappings = 'HUMAN'

inoremap <expr><Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr><Up>   pumvisible() ? "\<C-p>" : "\<Up>"

nmap <silent> ga <Plug>(coc-codeaction)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END

augroup filetypedetect
  au! BufRead,BufNewFile *.m setfiletype objc
  au BufRead,BufNewFile *.AWL setfiletype asm
  au BufRead,BufNewFile *.razor setfiletype razor
  au! BufRead,BufNewFile *.fs setfiletype fsharp
  au FileType cs setl sw=4 sts=4 ts=4 et
  au FileType c setl sw=4 sts=4 ts=4 et
  au FileType cpp setl sw=4 sts=4 ts=4 et
  au FileType zsh setl sw=4 sts=4 ts=4 et
  au FileType sh setl sw=4 sts=4 ts=4 et
  au FileType make setl noexpandtab sw=4 sts=0 ts=4
augroup END

au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}

autocmd FileType scss setl iskeyword+=@-@

let g:NERDTreeIgnore = [
\ '\.hgcheck',    '\.hglf', '\.nuget', 'publish',
\ '.\vagrant$',   '\.idea', 'eflex.bbprojectd', 'tmp',
\ 'test-results', 'TestResults', 'compiled',
\ 'node_modules', 'bin', 'obj', 'Properties', 'coverage', 'dist',
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
set foldlevel=99
set splitright
set ruler
set wildmenu
set formatoptions+=j " Delete comment character when joining commented lines
set autoread
set fileformats+=mac
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

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

cnoreabbrev rg RgRaw
cnoreabbrev rG RgRaw
cnoreabbrev RG RgRaw
cnoreabbrev Rg RgRaw

set background=dark
colorscheme dracula
hi! link SpecialComment DraculaCyan
hi! link Type DraculaCyan
hi! def link coffeeObjAssign Function
hi! def link coffeeSpecialIdent DraculaOrange
hi! def link coffeeKeyword DraculaRed
hi! def link coffeeStatement DraculaRed
hi Normal guibg=NONE ctermbg=NONE

function EnableTemplateLiteralColors()
  " list of named template literal tags and their syntax here
  call jspretmpl#register_tag('hbs', 'handlebars')

  autocmd FileType javascript JsPreTmpl
  autocmd FileType typescript JsPreTmpl

  " compat with leafgarland/typescript-vim
  autocmd FileType typescript syn clear foldBraces
endfunction

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  ignore_install = { "haskell" },
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  },
}
EOF

call EnableTemplateLiteralColors()
