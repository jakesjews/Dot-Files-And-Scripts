vim.opt.number = true
vim.opt.autowrite = true
vim.opt.termguicolors = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.shortmess:append({ c = true })
vim.opt.signcolumn = 'number'
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.pastetoggle = '<F2>'
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamed'
vim.opt.foldlevel = 99
vim.opt.splitright = true
vim.opt.fileformats:append({ mac = true })
vim.opt.foldmethod = 'indent'
vim.opt.swapfile = false
vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 5

vim.keymap.set('n', 'x', '"_x') -- prevent character delete from writing to the clipboard
vim.keymap.set('', '<C-t>', ':TestNearest<CR>')
vim.keymap.set('', '<C-q>', ':Dash<CR>')
vim.keymap.set('', '<C-p>', ':Files<CR>')
vim.keymap.set('v', '<Enter>', '<Plug>(EasyAlign)')
vim.keymap.set('v', '.', ':normal .<CR>')
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<C-f>', ':NvimTreeFindFile<CR>')
vim.keymap.set('n', '[', ':BufferLineCyclePrev<CR>', { silent = true })
vim.keymap.set('n', ']', ':BufferLineCycleNext<CR>', { silent = true })
vim.keymap.set("n", "<C-c>", "<Plug>kommentary_line_default")
vim.keymap.set("x", "<C-c>", "<Plug>kommentary_visual_default")

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'tpope/vim-dispatch'
  use 'b3nj5m1n/kommentary'
  use 'machakann/vim-sandwich'
  use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
  use 'junegunn/fzf.vim'
  use { 'jesseleite/vim-agriculture', commit = 'd8f0aec03fdec53c61d40fd92cd825f097f4ac78' }
  use 'editorconfig/editorconfig-vim'
  use { 'dracula/vim', as = 'dracula' }
  use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' }
  use 'rizzatti/dash.vim'
  use 'junegunn/vim-easy-align'
  use 'vim-test/vim-test'
  use { 'rcarriga/vim-ultest', run = ':UpdateRemotePlugins' }
  use { 'jakesjews/vim-ember-imports', ft = {'coffee', 'javascript', 'typescript'}, requires = { "sukima/vim-javascript-imports" } }
  use 'tpope/vim-dadbod'
  use 'tpope/vim-fugitive'
  use { 'eraserhd/parinfer-rust', run = 'cargo build --release' }
  use 'tpope/vim-sleuth'
  use 'tpope/vim-projectionist'
  use { 'michaelb/sniprun', run = 'bash install.sh' }
  use 'lukas-reineke/indent-blankline.nvim'
  use 'andymass/vim-matchup'
  use 'norcalli/nvim-colorizer.lua'
  use 'tversteeg/registers.nvim'
  use 'mfussenegger/nvim-dap'
  use 'Pocco81/DAPInstall.nvim'
  use 'neovim/nvim-lspconfig'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'b0o/schemastore.nvim'
  use 'simrat39/rust-tools.nvim'
  use 'kosayoda/nvim-lightbulb'
  use 'weilbith/nvim-code-action-menu'
  use { 'ms-jpq/coq_nvim', branch = 'coq', run = ":COQdeps" }
  use { 'ms-jpq/coq.artifacts', branch = 'artifacts', run = ":COQdeps" }
  use { 'ms-jpq/coq.thirdparty', branch = '3p', run = ":COQdeps"  }

  use 'scalameta/nvim-metals'
  use 'CH-DanReif/haproxy.vim'
  use 'IrenejMarc/vim-mint'
  use 'MTDL9/vim-log-highlighting'
  use 'McSinyx/vim-octave'
  use 'TovarishFin/vim-solidity'
  use 'adamclerk/vim-razor'
  use 'alunny/pegjs-vim'
  use 'brandonbloom/vim-factor'
  use 'edwinb/idris2-vim'
  use 'elubow/cql-vim'
  use 'fladson/vim-kitty'
  use 'gkz/vim-ls'
  use 'hellerve/carp-vim'
  use 'jakesjews/vim-emblem'
  use 'jakwings/vim-pony'
  use 'jdonaldson/vaxe'
  use 'katusk/vim-qkdb-syntax'
  use 'kchmck/vim-coffee-script'
  use 'leafo/moonscript-vim'
  use 'leanprover/lean.vim'
  use 'lifepillar/pgsql.vim'
  use { 'mityu/vim-applescript', ft = 'applescript' }
  use 'ollykel/v-vim'
  use 'pearofducks/ansible-vim'
  use 'petRUShka/vim-opencl'
  use 'peterhoeg/vim-qml'
  use 'purescript-contrib/purescript-vim'
  use { 'raimon49/requirements.txt.vim', ft = 'requirements' }
  use 'robbles/logstash.vim'
  use 'solarnz/thrift.vim'
  use 'thyrgle/vim-dyon'
  use 'tpope/vim-rails'
  use { 'tpope/vim-fireplace', ft = 'clojure' }
  use { 'tpope/vim-salve', ft = 'clojure' }
  use 'vim-crystal/vim-crystal'
  use 'vmchale/ion-vim'
  use 'wavded/vim-stylus'
  use 'wlangstroth/vim-racket'
  use 'zah/nim.vim'
  use 'zebradil/hive.vim'
  use 'rescript-lang/vim-rescript'
  use 'reasonml-editor/vim-reason-plus'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

vim.g['test#strategy'] = 'neovim'
vim.g['agriculture#disable_smart_quoting'] = 1

vim.g.vim_javascript_imports_multiline_max_col = 120
vim.g.vim_javascript_imports_multiline_max_vars = 100

vim.g.salve_auto_start_repl = 1

vim.g.ansible_template_syntaxes = {
  ['*.sh.j2'] = 'bash',
  ['*.json.j2'] = 'json',
  ['*.js.j2'] = 'javascript',
  ['*.conf.j2'] = 'dosini',
}

vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1,
  folder_arrows = 1,
}

vim.g.fzf_layout = { window = { width = 0.9, height = 0.8 } }

vim.g.matchup_matchparen_offscreen = { method = 'popup' }

local fileTypeDetectId = vim.api.nvim_create_augroup("filetypedetect", { clear = true })
vim.api.nvim_create_autocmd("FileType", { pattern = "cs", group = fileTypeDetectId, command = "setl sw=4 sts=4 ts=4 et" })
vim.api.nvim_create_autocmd("FileType", { pattern = "c", group = fileTypeDetectId, command = "setl sw=4 sts=4 ts=4 et" })
vim.api.nvim_create_autocmd("FileType", { pattern = "cpp", group = fileTypeDetectId, command = "setl sw=4 sts=4 ts=4 et" })
vim.api.nvim_create_autocmd("FileType", { pattern = "make", group = fileTypeDetectId, command = "setl noexpandtab sw=4 sts=0 ts=4" })
vim.api.nvim_create_autocmd("FileType", { pattern = "scss", group = fileTypeDetectId, command = "setl iskeyword+=@-@" })

vim.api.nvim_create_autocmd("TextYankPost", { callback = function()
  vim.highlight.on_yank({ higroup="IncSearch", timeout=150, on_visual=true })
end })

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "CursorHold,CursorHoldI *",
  callback = require('nvim-lightbulb').update_lightbulb
})

vim.cmd('cnoreabbrev rg RgRaw')
vim.cmd('cnoreabbrev Rg RgRaw')
vim.cmd('cnoreabbrev RG RgRaw')

vim.cmd('colorscheme dracula')
vim.cmd('hi! link SpecialComment DraculaCyan')
vim.cmd('hi! link Type DraculaCyan')
vim.cmd('hi Normal guibg=NONE ctermbg=NONE')

vim.g.kommentary_create_default_mappings = false
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

local on_attach = function(client, bufferNum)
  local lsp_key_opts = {
    noremap = true,
    silent = true,
    buffer = bufferNum,
  }

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, lsp_key_opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, lsp_key_opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, lsp_key_opts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, lsp_key_opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, lsp_key_opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, lsp_key_opts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, lsp_key_opts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, lsp_key_opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, lsp_key_opts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, lsp_key_opts)
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

lspconfig.sumneko_lua.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

local null_ls = require("null-ls")
require("null-ls.helpers")

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.cppcheck,
    null_ls.builtins.diagnostics.credo,
    null_ls.builtins.diagnostics.hadolint,
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
