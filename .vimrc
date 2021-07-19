" Disable ex mode
nnoremap Q <nop>
nnoremap x "_x

map <C-t> :TestNearest<CR>
map <C-q> :Dash<CR>
map <C-p> :Files<CR>
vmap <Enter> <Plug>(EasyAlign)
vnoremap . :normal .<CR>
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <C-r> :NvimTreeRefresh<CR>

set hidden
set autowrite
set termguicolors
set backspace=indent,eol,start
set nobackup
set nowritebackup
set directory=$HOME/.vim/swap/
set hlsearch
set autoread
set updatetime=300
set shortmess+=c
set signcolumn=number
set completeopt=longest,menuone,preview "don't autoselect first item in omnicomplete, show if only one item (for preview)
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
set pastetoggle=<F2>
set mouse=a
set clipboard=unnamed
set foldlevel=99
set splitright
set ruler
set wildmenu
set formatoptions+=j "Delete comment character when joining commented lines
set fileformats+=mac
set foldmethod=indent

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

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdateSync' }
Plug 'tpope/vim-dispatch'
Plug 'b3nj5m1n/kommentary'
Plug 'dense-analysis/ale'
Plug 'machakann/vim-sandwich'
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim', { 'commit': '75798afff51e764ada87149b16bb56a6ef971042' }
Plug 'jesseleite/vim-agriculture'
Plug 'editorconfig/editorconfig-vim'
Plug 'majutsushi/tagbar'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
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
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-projectionist'
Plug 'metakirby5/codi.vim'
Plug 'Yggdroot/indentLine'
Plug 'puremourning/vimspector'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'tpope/vim-rails', { 'for': 'ruby' } 
Plug 'moll/vim-node', { 'for': ['coffee', 'javascript', 'typescript'] }
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }
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
\ 'coc-fsharp',
\ 'coc-flutter',
\ 'coc-go',
\ 'coc-html',
\ 'coc-java',
\ 'coc-jedi',
\ 'coc-json',
\ 'coc-julia',
\ 'coc-lists',
\ 'coc-metals',
\ 'coc-omnisharp',
\ 'coc-perl',
\ 'coc-phpls',
\ 'coc-powershell',
\ 'coc-r-lsp',
\ 'coc-rls',
\ 'coc-sh',
\ 'coc-solargraph',
\ 'coc-sourcekit',
\ 'coc-sumneko-lua',
\ 'coc-sql',
\ 'coc-svg',
\ 'coc-texlab',
\ 'coc-tsserver',
\ 'coc-vimlsp',
\ 'coc-lsp-wl',
\ 'coc-xml',
\ 'coc-yaml',
\ 'coc-highlight',
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

let g:ale_linters = {
\ 'elixir': ['elixir-ls'],
\ 'javascript': ['eslint'],
\ 'cs': ['OmniSharp'],
\ 'html': { 'handlebars': ['ember-template-lint'] }
\}

let g:ale_fixers = {
\ 'javascript': ['eslint'],
\ 'html': { 'handlebars': ['ember-template-lint'] }
\}

let g:ale_elixir_elixir_ls_release = expand("~/.config/coc/extensions/node_modules/coc-elixir/els-release")

let g:agriculture#disable_smart_quoting = 1
let g:agriculture#rg_options = '--smart-case'

let g:vimspector_enable_mappings = 'HUMAN'

nmap <silent> ga <Plug>(coc-codeaction)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Make <CR> auto-select the first completion item
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" completions
inoremap <expr><Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr><Up> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

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

let g:nvim_tree_ignore = [
\ '.hgcheck', '.hglf', '.nuget', 'publish',
\ '.vagrant', '.idea', 'eflex.bbprojectd', 'tmp',
\ 'test-results', 'TestResults', 'compiled',
\ 'node_modules', 'bin', 'obj', 'Properties', 'coverage', 'dist',
\ '.suo$', '.hgtabs$', '.orig$', '.userconfig$', 
\ 'npm-debug.log', '.swp$', '.tmp$', '.reh$', 
\ '.DS_Store', '.iml$', '.sublime-workspace', 
\ '.userprefs$', '.tm_properties', '.jar$', '.pfx$', 
\ '.sublime-project', '.DotSettings', 'TestResult.xml',
\ '.git', '.github',
\ ]

let g:nvim_tree_gitignore = 1
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_highlight_opened_files = 1

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
vim.g.kommentary_create_default_mappings = false
vim.api.nvim_set_keymap("n", "<C-c>", "<Plug>kommentary_line_default", {})

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
}
EOF

call EnableTemplateLiteralColors()
