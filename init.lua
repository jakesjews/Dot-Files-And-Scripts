-- luacheck: globals vim
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
vim.opt.hidden = false

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

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({
    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path
  })
end

local packer = require('packer')

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'p00f/nvim-ts-rainbow'
  use 'numToStr/Comment.nvim'
  use 'machakann/vim-sandwich'
  use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
  use 'junegunn/fzf.vim'
  use { 'jesseleite/vim-agriculture', commit = 'd8f0aec03fdec53c61d40fd92cd825f097f4ac78' }
  use { 'dracula/vim', as = 'dracula' }
  use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' }
  use 'rizzatti/dash.vim'
  use 'junegunn/vim-easy-align'
  use 'vim-test/vim-test'
  use { 'rcarriga/vim-ultest', run = ':UpdateRemotePlugins' }
  use { 'jakesjews/vim-ember-imports',
    ft = {'coffee', 'javascript', 'typescript'},
    requires = { "sukima/vim-javascript-imports" }
  }
  use 'tpope/vim-dadbod'
  use { 'tpope/vim-fugitive', requires = 'tpope/vim-dispatch' }
  use { 'eraserhd/parinfer-rust', run = 'cargo build --release' }
  use 'tpope/vim-sleuth'
  use 'editorconfig/editorconfig-vim'
  use { 'michaelb/sniprun', run = 'bash install.sh' }
  use 'lukas-reineke/indent-blankline.nvim'
  use 'andymass/vim-matchup'
  use 'norcalli/nvim-colorizer.lua'
  use 'mfussenegger/nvim-dap'
  use 'Pocco81/DAPInstall.nvim'
  use 'neovim/nvim-lspconfig'
  use { 'jose-elias-alvarez/null-ls.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'b0o/schemastore.nvim'
  use { 'simrat39/rust-tools.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { 'kosayoda/nvim-lightbulb', requires = 'antoinemadec/FixCursorHold.nvim' }
  use { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' }
  use { 'ms-jpq/coq_nvim', branch = 'coq', run = ":COQdeps" }
  use { 'ms-jpq/coq.thirdparty', branch = '3p' }

  use { 'scalameta/nvim-metals', requires = 'nvim-lua/plenary.nvim' }
  use 'CH-DanReif/haproxy.vim'
  use 'IrenejMarc/vim-mint'
  use 'MTDL9/vim-log-highlighting'
  use 'McSinyx/vim-octave'
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
  use { 'tpope/vim-rails', requires = 'tpope/vim-dispatch' }
  use { 'tpope/vim-fireplace', ft = 'clojure' }
  use { 'tpope/vim-salve', ft = 'clojure', requires = 'tpope/vim-dispatch' }
  use 'vim-crystal/vim-crystal'
  use 'vmchale/ion-vim'
  use 'wavded/vim-stylus'
  use 'wlangstroth/vim-racket'
  use 'zah/nim.vim'
  use 'zebradil/hive.vim'
  use 'rescript-lang/vim-rescript'
  use 'reasonml-editor/vim-reason-plus'
  use 'mfussenegger/nvim-jdtls'
  use 'ionide/Ionide-vim'
  use 'stevearc/vim-arduino'

  if packer_bootstrap then
    packer.sync()
  end
end)

vim.g['test#strategy'] = 'neovim'
vim.g['agriculture#disable_smart_quoting'] = 1

vim.g.crystal_enable_completion = 0

vim.g.vim_javascript_imports_multiline_max_col = 120
vim.g.vim_javascript_imports_multiline_max_vars = 100

vim.g.salve_auto_start_repl = 1

vim.g.ansible_template_syntaxes = {
  ['*.sh.j2'] = 'bash',
  ['*.json.j2'] = 'json',
  ['*.js.j2'] = 'javascript',
  ['*.conf.j2'] = 'dosini',
}

vim.g.fzf_layout = { window = { width = 0.9, height = 0.8 } }

vim.g.matchup_matchparen_offscreen = { method = 'popup' }

local fileTypeDetectId = vim.api.nvim_create_augroup("filetypedetect", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cs", group = fileTypeDetectId, command = "setl sw=4 sts=4 ts=4 et"
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "c", group = fileTypeDetectId, command = "setl sw=4 sts=4 ts=4 et"
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp", group = fileTypeDetectId, command = "setl sw=4 sts=4 ts=4 et"
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "make", group = fileTypeDetectId, command = "setl noexpandtab sw=4 sts=0 ts=4"
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "scss", group = fileTypeDetectId, command = "setl iskeyword+=@-@"
})

vim.api.nvim_create_autocmd("FileType", { pattern = "java", group = fileTypeDetectId, callback = function()
  local root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'})

  require('jdtls').start_or_attach({
    root_dir = root_dir,
    cmd = {
      'java',
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xms1g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

      '-jar', '/opt/homebrew/opt/jdtls/libexec/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
      '-configuration', '/opt/homebrew/opt/jdtls/libexec/config_mac',
      '-data', root_dir,
    },
  })
end})

vim.api.nvim_create_autocmd("TextYankPost", { callback = function()
  vim.highlight.on_yank({ higroup="IncSearch", timeout=150, on_visual=true })
end })

require('nvim-lightbulb').setup({ autocmd = { enabled = true } })

vim.cmd('cnoreabbrev rg RgRaw')
vim.cmd('cnoreabbrev Rg RgRaw')
vim.cmd('cnoreabbrev RG RgRaw')

vim.cmd('colorscheme dracula')
vim.cmd('hi! link SpecialComment DraculaCyan')
vim.cmd('hi! link Type DraculaCyan')
vim.cmd('hi Normal guibg=NONE ctermbg=NONE')

require('Comment').setup({
  mappings = {
    basic = false,
    extra = false,
    extended = false,
  }
})

require('Comment.ft').set('handlebars', '{{!-- %s --}}')

vim.keymap.set("n", "<C-c>", "<Plug>(comment_toggle_current_linewise)")
vim.keymap.set("x", "<C-c>", "<Plug>(comment_toggle_linewise_visual)")

require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
  ignore_install = { "norg", "phpdoc" },
  matchup = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
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
  match = {
    unifying_chars = { "-", "_", "." }, -- fix completions after .
  },
  clients = {
    tags = {
      enabled = false,
    },
    tmux = {
      enabled = false,
    },
    paths = {
      resolution = { "file" },
    },
    snippets = {
      warn = {},
    },
  },
}

local servers = {
  "awk_ls",
  "bashls",
  "clojure_lsp",
  "cmake",
  "crystalline",
  "cssls",
  "dartls",
  "dockerls",
  "dotls",
  "elmls",
  "ember",
  "erlangls",
  "eslint",
  "fortls",
  "gdscript",
  "gopls",
  "graphql",
  "hdl_checker",
  "hls",
  "html",
  "julials",
  "kotlin_language_server",
  "mint",
  "ocamllsp",
  "openscad_ls",
  "perlpls",
  "purescriptls",
  "pyright",
  "r_language_server",
  "racket_langserver",
  "salt_ls",
  "solargraph",
  "solc",
  "sourcekit",
  "sqls",
  "svls",
  "terraformls",
  "texlab",
  "vala_ls",
  "vimls",
  "vuels",
  "yamlls",
  "zls",
}

local lspconfig = require('lspconfig')
local coq = require('coq')

local on_attach = function(_client, bufferNum)
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
      validate = { enable = true },
    },
  },
}))

lspconfig.arduino_language_server.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  cmd =  {
    "arduino-language-server",
    "-cli-config", "/Users/jacob/Library/Arduino15/arduino-cli.yaml",
  }
}))

lspconfig.stylelint_lsp.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  filetypes = { "css", "less", "scss", "sugarss", "wxss" },
}))

lspconfig.elixirls.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  cmd = { "elixir-ls" },
}))

lspconfig.sumneko_lua.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    }
  }
}))

lspconfig.omnisharp.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  cmd = {
    "/Users/jacob/.omnisharp/OmniSharp",
    "--languageserver",
    "--hostPID",
    tostring(vim.fn.getpid()),
  },
}))

lspconfig.powershell_es.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  bundle_path = '/Users/jacob/.powershell',
}))

lspconfig.tsserver.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  init_options = {
    hostInfo = 'neovim',
    npmLocation = '/opt/homebrew/bin/npm',
    preferences = {
      disableSuggestions = true,
    },
  }
}))

local null_ls = require("null-ls")
require("null-ls.helpers")

local diagnostics = null_ls.builtins.diagnostics

null_ls.setup(coq.lsp_ensure_capabilities({
  sources = {
    diagnostics.checkmake,
    diagnostics.cppcheck,
    diagnostics.credo,
    diagnostics.hadolint,
    diagnostics.luacheck,
    diagnostics.markdownlint,
    diagnostics.mypy,
    diagnostics.phpstan,
    diagnostics.pylint,
    diagnostics.revive,
    diagnostics.shellcheck,
    diagnostics.statix,
    diagnostics.vint,
    diagnostics.zsh,
  },
}))

require("coq_3p") {
  { src = "nvimlua", short_name = "nLUA", conf_only = true },
}

require('rust-tools').setup(coq.lsp_ensure_capabilities({}))

require('colorizer').setup()

require('nvim-tree').setup {
  git = {
    enable = true,
    ignore = true,
  },
  renderer = {
    highlight_git = true,
    highlight_opened_files = 'all',
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
      },
    },
    indent_markers = {
      enable = true,
    },
  },
  filters = {
    custom = {
      '.git',
    }
  },
}