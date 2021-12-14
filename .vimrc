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
nnoremap <silent>] :BufferLineCycleNext<CR>
nnoremap <silent>[ :BufferLineCyclePrev<CR>

set autowrite
set termguicolors
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set signcolumn=number
set completeopt=menu,menuone,noselect
set tabstop=2
set shiftwidth=2
set expandtab
set ignorecase
set smartcase
set number
set pastetoggle=<F2>
set mouse=a
set clipboard=unnamed
set foldlevel=99
set splitright
set fileformats+=mac
set foldmethod=indent
set noswapfile

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup install_vim_plug
    autocmd VimEnter * PlugInstall
  augroup end
endif

let g:ale_disable_lsp = 1 " must be before plugin load

call plug#begin('~/.vim/plugged')

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdateSync' }
Plug 'tpope/vim-dispatch'
Plug 'b3nj5m1n/kommentary', { 'branch': 'main' }
Plug 'dense-analysis/ale'
Plug 'machakann/vim-sandwich'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jesseleite/vim-agriculture'
Plug 'editorconfig/editorconfig-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'rizzatti/dash.vim'
Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
Plug 'vim-test/vim-test'
Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }
Plug 'sukima/vim-javascript-imports', { 'for': ['coffee', 'javascript', 'typescript'] }
Plug 'jakesjews/vim-ember-imports', { 'for': ['coffee', 'javascript', 'typescript'] }
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-fugitive'
Plug 'eraserhd/parinfer-rust', { 'do': 'cargo build --release' }
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-projectionist'
Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'andymass/vim-matchup'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'tversteeg/registers.nvim', { 'branch': 'main' }
Plug 'mfussenegger/nvim-dap'
Plug 'Pocco81/DAPInstall.nvim', { 'branch': 'main' }
Plug 'neovim/nvim-lspconfig'
Plug 'ms-jpq/coq_nvim', { 'branch': 'coq' }
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/coq.thirdparty', { 'branch': '3p' }

Plug 'CH-DanReif/haproxy.vim'
Plug 'ElmCast/elm-vim'
Plug 'IrenejMarc/vim-mint'
Plug 'MTDL9/vim-log-highlighting'
Plug 'McSinyx/vim-octave'
Plug 'TovarishFin/vim-solidity'
Plug 'adamclerk/vim-razor'
Plug 'alunny/pegjs-vim'
Plug 'arrufat/vala.vim'
Plug 'brandonbloom/vim-factor'
Plug 'chr4/nginx.vim'
Plug 'digitaltoad/vim-pug'
Plug 'edwinb/idris2-vim'
Plug 'elubow/cql-vim'
Plug 'fladson/vim-kitty'
Plug 'gkz/vim-ls'
Plug 'gleam-lang/gleam.vim'
Plug 'hashivim/vim-terraform'
Plug 'hellerve/carp-vim'
Plug 'jakesjews/vim-emblem'
Plug 'jakwings/vim-pony'
Plug 'jdonaldson/vaxe'
Plug 'katusk/vim-qkdb-syntax'
Plug 'kchmck/vim-coffee-script'
Plug 'keith/swift.vim', { 'for': ['swift', 'swiftgyb'] }
Plug 'leafo/moonscript-vim'
Plug 'leanprover/lean.vim'
Plug 'lifepillar/pgsql.vim'
Plug 'mityu/vim-applescript', { 'for': 'applescript' }
Plug 'moll/vim-node'
Plug 'neovimhaskell/haskell-vim', { 'for': ['haskell', 'lhaskell', 'chaskell', 'cabalproject', 'cabalconfig'] }
Plug 'ollykel/v-vim'
Plug 'pearofducks/ansible-vim'
Plug 'petRUShka/vim-opencl'
Plug 'peterhoeg/vim-qml'
Plug 'purescript-contrib/purescript-vim', { 'branch': 'main' }
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
Plug 'reasonml-editor/vim-reason-plus'
Plug 'rhysd/vim-llvm'
Plug 'robbles/logstash.vim'
Plug 'solarnz/thrift.vim'
Plug 'thyrgle/vim-dyon'
Plug 'tikhomirov/vim-glsl'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-rails'
Plug 'tpope/vim-salve', { 'for': 'clojure' }
Plug 'vim-crystal/vim-crystal'
Plug 'vmchale/ion-vim'
Plug 'wavded/vim-stylus'
Plug 'wlangstroth/vim-racket'
Plug 'zah/nim.vim'
Plug 'zebradil/hive.vim'

call plug#end()

let g:test#strategy = 'neovim'

let g:agriculture#disable_smart_quoting = 1

let g:vim_javascript_imports_multiline_max_col = 120
let g:vim_javascript_imports_multiline_max_vars = 100

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

let g:nvim_tree_indent_markers = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_highlight_opened_files = 1

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }

let g:coq_settings = { 'auto_start': v:true }

augroup filetypedetect
  au BufRead,BufNewFile *.hbs setfiletype handlebars
  au FileType cs setl sw=4 sts=4 ts=4 et
  au FileType c setl sw=4 sts=4 ts=4 et
  au FileType cpp setl sw=4 sts=4 ts=4 et
  au FileType make setl noexpandtab sw=4 sts=0 ts=4
  au FileType scss setl iskeyword+=@-@
augroup END

au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif

if &term =~? '^screen'
  set ttymouse=xterm2
endif

cnoreabbrev rg RgRaw
cnoreabbrev Rg RgRaw
cnoreabbrev RG RgRaw

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

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  matchup = {
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

local servers = {
  "ansiblels",
  "bashls",
  "clojure_lsp",
  "cmake",
  "cssls",
  "dartls",
  "dockerls",
  "dotls",
  "elmls",
  "ember",
  "fortls",
  "fsautocomplete",
  "gopls",
  "graphql",
  "hls",
  "html",
  "jsonls",
  "kotlin_language_server",
  "ocamllsp",
  "purescriptls",
  "solargraph",
  "sorbet",
  "terraformls",
  "texlab",
  "vala_ls",
  "vimls",
  "vuels",
  "yamlls",
  'clangd', 
  'pyright', 
  'rust_analyzer', 
  'tsserver' 
}

local lspconfig = require('lspconfig')
local coq = require "coq"

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(coq.lsp_ensure_capabilities()) 
end

require("coq_3p") {
  { src = "nvimlua", short_name = "nLUA", conf_only = true },
}

require'colorizer'.setup()

require'nvim-tree'.setup {
  git = {
    enable = true,
    ignore = true,
  },
  filters = {
    custom = {
      '.hgcheck', 
      '.hglf', 
      '.nuget', 
      'publish',
      '.vagrant', 
      '.idea', 
      'eflex.bbprojectd', 
      'tmp',
      'test-results', 
      'TestResults', 
      'compiled',
      'node_modules', 
      'bin', 
      'obj', 
      'Properties', 
      'coverage', 
      'dist',
      '.suo$', 
      '.hgtabs$', 
      '.orig$', 
      '.userconfig$', 
      'npm-debug.log', 
      '.swp$', 
      '.tmp$', 
      '.reh$', 
      '.DS_Store', 
      '.iml$', 
      '.sublime-workspace', 
      '.userprefs$', 
      '.tm_properties', 
      '.jar$', 
      '.pfx$', 
      '.sublime-project', 
      '.DotSettings', 
      'TestResult.xml',
      '.git', 
      '.github',
    }
  },
}
EOF
