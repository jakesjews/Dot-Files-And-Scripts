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

call plug#begin()

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdateSync' }
Plug 'tpope/vim-dispatch'
Plug 'b3nj5m1n/kommentary'
Plug 'machakann/vim-sandwich'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jesseleite/vim-agriculture', { 'commit': 'd8f0aec03fdec53c61d40fd92cd825f097f4ac78' }
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
Plug 'michaelb/sniprun', { 'do': 'bash install.sh' }
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'andymass/vim-matchup'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'tversteeg/registers.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'Pocco81/DAPInstall.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'b0o/schemastore.nvim'
Plug 'simrat39/rust-tools.nvim'
Plug 'kosayoda/nvim-lightbulb'
Plug 'weilbith/nvim-code-action-menu'
Plug 'ms-jpq/coq_nvim', { 'branch': 'coq' }
Plug 'ms-jpq/coq.artifacts', { 'branch': 'artifacts' }
Plug 'ms-jpq/coq.thirdparty', { 'branch': '3p' }

Plug 'scalameta/nvim-metals'
Plug 'CH-DanReif/haproxy.vim'
Plug 'IrenejMarc/vim-mint'
Plug 'MTDL9/vim-log-highlighting'
Plug 'McSinyx/vim-octave'
Plug 'TovarishFin/vim-solidity'
Plug 'adamclerk/vim-razor'
Plug 'alunny/pegjs-vim'
Plug 'brandonbloom/vim-factor'
Plug 'edwinb/idris2-vim'
Plug 'elubow/cql-vim'
Plug 'fladson/vim-kitty'
Plug 'gkz/vim-ls'
Plug 'hellerve/carp-vim'
Plug 'jakesjews/vim-emblem'
Plug 'jakwings/vim-pony'
Plug 'jdonaldson/vaxe'
Plug 'katusk/vim-qkdb-syntax'
Plug 'kchmck/vim-coffee-script'
Plug 'leafo/moonscript-vim'
Plug 'leanprover/lean.vim'
Plug 'lifepillar/pgsql.vim'
Plug 'mityu/vim-applescript', { 'for': 'applescript' }
Plug 'ollykel/v-vim'
Plug 'pearofducks/ansible-vim'
Plug 'petRUShka/vim-opencl'
Plug 'peterhoeg/vim-qml'
Plug 'purescript-contrib/purescript-vim'
Plug 'raimon49/requirements.txt.vim', { 'for': 'requirements' }
Plug 'robbles/logstash.vim'
Plug 'solarnz/thrift.vim'
Plug 'thyrgle/vim-dyon'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-salve', { 'for': 'clojure' }
Plug 'vim-crystal/vim-crystal'
Plug 'vmchale/ion-vim'
Plug 'wavded/vim-stylus'
Plug 'wlangstroth/vim-racket'
Plug 'zah/nim.vim'
Plug 'zebradil/hive.vim'
Plug 'rescript-lang/vim-rescript'
Plug 'reasonml-editor/vim-reason-plus'

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

let g:nvim_tree_git_hl = 1
let g:nvim_tree_highlight_opened_files = 1

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }

let g:matchup_matchparen_offscreen = {'method': 'popup'}

augroup filetypedetect
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

require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
  ignore_install = { "norg", "phpdoc" },
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

vim.g.coq_settings = { 
  auto_start = 'shut-up',
  xdg = true,
  clients = {
    paths = {
      resolution = { "file" },
    },
  },
}

local servers = {
  "bashls",
  "clojure_lsp",
  "cmake",
  "cssls",
  "dartls",
  "dockerls",
  "dotls",
  "elmls",
  "ember",
  "eslint",
  "fortls",
  "fsautocomplete",
  "gopls",
  "graphql",
  "hls",
  "html",
  "kotlin_language_server",
  "ocamllsp",
  "openscad_ls",
  "perlpls",
  "purescriptls",
  "r_language_server",
  "racket_langserver",
  "solargraph",
  "sourcekit",
  "sqls",
  "sumneko_lua",
  "svls",
  "terraformls",
  "texlab",
  "vala_ls",
  "vimls",
  "vuels",
  "yamlls",
  'clangd', 
  'mint',
  'pyright', 
  'rust_analyzer', 
  'solidity_ls',
  'tsserver',
}

local lspconfig = require('lspconfig')
local coq = require('coq')

local lsp_key_opts = { noremap = true, silent = true }

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', lsp_key_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', lsp_key_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', lsp_key_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', lsp_key_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', lsp_key_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', lsp_key_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', lsp_key_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', lsp_key_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', lsp_key_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', lsp_key_opts)
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(coq.lsp_ensure_capabilities({ on_attach = on_attach })) 
end

lspconfig.ansiblels.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern('playbook.yml'),
  single_file_support = false
})) 

lspconfig.jsonls.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
    },
  },
})) 

lspconfig.arduino_language_server.setup({
  on_attach = on_attach,
  cmd =  {
    "arduino-language-server",
    "-cli-config", "/Users/jacob/Library/Arduino15/arduino-cli.yaml",
  }
})

lspconfig.stylelint_lsp.setup({
  on_attach = on_attach,
  filetypes = { "css", "less", "scss", "sugarss", "wxss" },
})

lspconfig.elixirls.setup({
  on_attach = on_attach,
  cmd = { "elixir-ls" },
})

lspconfig.rescriptls.setup({
  on_attach = on_attach,
  cmd = {
    'node',
    '/Users/jacob/.local/share/nvim/plugged/vim-rescript/server/out/server.js',
    '--stdio'
  },
})

local null_ls = require("null-ls")
require("null-ls.helpers")

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.cppcheck,
    null_ls.builtins.diagnostics.credo,
    null_ls.builtins.diagnostics.hadolint,
    null_ls.builtins.diagnostics.selene,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.phpstan,
    null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.diagnostics.mypy,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.statix,
    null_ls.builtins.diagnostics.vint,
    null_ls.builtins.diagnostics.revive,
    null_ls.builtins.diagnostics.zsh,
  },
})

require("coq_3p") {
  { src = "nvimlua", short_name = "nLUA", conf_only = true },
}

require('colorizer').setup()

require('nvim-tree').setup {
  git = {
    enable = true,
    ignore = true,
  },
  renderer = {
    indent_markers = {
      enable = true,
    }
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

require('rust-tools').setup({})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "CursorHold,CursorHoldI *",
  callback = function(args)
    require('nvim-lightbulb').update_lightbulb()
  end,
})
EOF
