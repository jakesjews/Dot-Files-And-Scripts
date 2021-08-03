" Disable ex mode
nnoremap Q <nop>
nnoremap x "_x

map <C-t> :TestNearest<CR>
map <C-q> :Dash<CR>
map <C-p> :Files<CR>
vmap <Enter> <Plug>(EasyAlign)
vnoremap . :normal .<CR>
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <C-f> :NvimTreeFindFile<CR>

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
set noswapfile

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

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdateSync' }
Plug 'tpope/vim-dispatch'
Plug 'b3nj5m1n/kommentary'
Plug 'dense-analysis/ale'
Plug 'blackCauldron7/surround.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jesseleite/vim-agriculture'
Plug 'editorconfig/editorconfig-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'rizzatti/dash.vim'
Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
Plug 'p00f/nvim-ts-rainbow'
Plug 'vim-test/vim-test'
Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }
Plug 'sukima/vim-javascript-imports', { 'for': ['coffee', 'javascript', 'typescript'] }
Plug 'sukima/vim-ember-imports', { 'for': ['coffee', 'javascript', 'typescript'] }
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-fugitive'
Plug 'eraserhd/parinfer-rust', { 'do': 'cargo build --release' }
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-projectionist'
Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'Pocco81/DAPInstall.nvim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'tpope/vim-rails'
Plug 'moll/vim-node'
Plug 'ngn/vim-apl'
Plug 'pearofducks/ansible-vim'
Plug 'brandonbloom/vim-factor'
Plug 'alunny/pegjs-vim'
Plug 'robbles/logstash.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'jakesjews/vim-emblem'
Plug 'katusk/vim-qkdb-syntax'
Plug 'leanprover/lean.vim'
Plug 'tpope/vim-salve', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'thyrgle/vim-dyon'
Plug 'mityu/vim-applescript', { 'for': 'applescript' }
Plug 'hellerve/carp-vim'
Plug 'elubow/cql-vim'
Plug 'vim-crystal/vim-crystal'
Plug 'calviken/vim-gdscript3'
Plug 'gleam-lang/gleam.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'CH-DanReif/haproxy.vim'
Plug 'neovimhaskell/haskell-vim', { 'for': ['haskell', 'lhaskell', 'chaskell', 'cabalproject', 'cabalconfig'] }
Plug 'jdonaldson/vaxe'
Plug 'zebradil/hive.vim'
Plug 'edwinb/idris2-vim'
Plug 'vmchale/ion-vim'
Plug 'gkz/vim-ls'
Plug 'rhysd/vim-llvm'
Plug 'MTDL9/vim-log-highlighting'
Plug 'IrenejMarc/vim-mint'
Plug 'leafo/moonscript-vim'
Plug 'chr4/nginx.vim'
Plug 'zah/nim.vim'
Plug 'McSinyx/vim-octave'
Plug 'petRUShka/vim-opencl'
Plug 'lifepillar/pgsql.vim'
Plug 'jakwings/vim-pony'
Plug 'digitaltoad/vim-pug'
Plug 'purescript-contrib/purescript-vim'
Plug 'peterhoeg/vim-qml'
Plug 'wlangstroth/vim-racket'
Plug 'adamclerk/vim-razor'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
Plug 'TovarishFin/vim-solidity'
Plug 'wavded/vim-stylus'
Plug 'keith/swift.vim', { 'for': ['swift', 'swiftgyb'] }
Plug 'hashivim/vim-terraform'
Plug 'solarnz/thrift.vim'
Plug 'ollykel/v-vim'
Plug 'arrufat/vala.vim'

call plug#end()

let g:coc_global_extensions = [
\ 'coc-actions',
\ 'coc-clangd',
\ 'coc-cmake',
\ 'coc-css',
\ 'coc-dictionary',
\ 'coc-dlang',
\ 'coc-docker',
\ 'coc-elixir',
\ 'coc-ember',
\ 'coc-erlang_ls',
\ 'coc-flutter',
\ 'coc-fsharp',
\ 'coc-go',
\ 'coc-highlight',
\ 'coc-html',
\ 'coc-java',
\ 'coc-jedi',
\ 'coc-json',
\ 'coc-julia',
\ 'coc-kotlin',
\ 'coc-lists',
\ 'coc-lsp-wl',
\ 'coc-marketplace',
\ 'coc-marketplace',
\ 'coc-metals',
\ 'coc-omnisharp',
\ 'coc-perl',
\ 'coc-phpls',
\ 'coc-powershell',
\ 'coc-r-lsp',
\ 'coc-rust-analyzer',
\ 'coc-sh',
\ 'coc-solargraph',
\ 'coc-sourcekit',
\ 'coc-sql',
\ 'coc-sumneko-lua',
\ 'coc-svg',
\ 'coc-syntax',
\ 'coc-texlab',
\ 'coc-toml',
\ 'coc-tsserver',
\ 'coc-vimlsp',
\ 'coc-webpack',
\ 'coc-xml',
\ 'coc-yaml',
\ ]

let g:test#strategy = 'neovim'

let g:agriculture#disable_smart_quoting = 1

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
\ 'html': { 'handlebars': ['ember-template-lint'] }
\}

let g:ale_fixers = {
\ 'javascript': ['eslint'],
\ 'html': { 'handlebars': ['ember-template-lint'] }
\}

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

augroup filetypedetect
  au BufRead,BufNewFile *.hbs setfiletype handlebars
  au FileType cs setl sw=4 sts=4 ts=4 et
  au FileType c setl sw=4 sts=4 ts=4 et
  au FileType cpp setl sw=4 sts=4 ts=4 et
  au FileType make setl noexpandtab sw=4 sts=0 ts=4
  au FileType scss setl iskeyword+=@-@
augroup END

au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}

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

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }

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
cnoreabbrev Rg RgRaw
cnoreabbrev RG RgRaw

set background=dark
colorscheme dracula
hi! link SpecialComment DraculaCyan
hi! link Type DraculaCyan
hi Normal guibg=NONE ctermbg=NONE

lua <<EOF
vim.g.kommentary_create_default_mappings = false
vim.api.nvim_set_keymap("n", "<C-c>", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("x", "<C-c>", "<Plug>kommentary_visual_default", {})
require('kommentary.config').configure_language("default", {
  prefer_single_line_comments = true,
})

require'surround'.setup {}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  ignore_install = { "haskell", "swift" },
  highlight = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
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
