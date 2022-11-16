-- luacheck: globals vim
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true
vim.opt.autowrite = true
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
vim.keymap.set('', '<C-q>', ':DashWord<CR>')
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
  use({ "kylechui/nvim-surround", tag = "*" })
  use { 'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-live-grep-args.nvim' }
    },
    branch = '0.1.x',
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
  }
  use 'Mofiqul/dracula.nvim'
  use { 'nvim-tree/nvim-tree.lua', requires = 'nvim-tree/nvim-web-devicons' }
  use { 'mrjones2014/dash.nvim', run = 'make install', requires = 'nvim-telescope/telescope.nvim' }
  use { 'jakesjews/vim-ember-imports',
    ft = {'coffee', 'javascript', 'typescript'},
    requires = "sukima/vim-javascript-imports"
  }
  use 'tpope/vim-dadbod'
  use { 'tpope/vim-fugitive', requires = 'tpope/vim-dispatch' }
  use { 'eraserhd/parinfer-rust', run = 'cargo build --release' }
  use 'tpope/vim-sleuth'
  use 'gpanders/editorconfig.nvim'
  use { 'michaelb/sniprun', run = 'bash install.sh' }
  use 'lukas-reineke/indent-blankline.nvim'
  use 'andymass/vim-matchup'
  use 'NvChad/nvim-colorizer.lua'
  use 'mfussenegger/nvim-dap'
  use 'neovim/nvim-lspconfig'
  use { 'jose-elias-alvarez/null-ls.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'b0o/schemastore.nvim'
  use { 'ms-jpq/coq_nvim', branch = 'coq' }
  use { 'ms-jpq/coq.thirdparty', branch = '3p' }

  use { 'scalameta/nvim-metals', requires = 'nvim-lua/plenary.nvim' }
  use { 'simrat39/rust-tools.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'mfussenegger/nvim-jdtls'
  use 'ionide/Ionide-vim'
  use 'Joorem/vim-haproxy'
  use 'IrenejMarc/vim-mint'
  use 'MTDL9/vim-log-highlighting'
  use 'jlcrochet/vim-razor'
  use 'alunny/pegjs-vim'
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
  use 'Julian/lean.nvim'
  use 'lifepillar/pgsql.vim'
  use 'pearofducks/ansible-vim'
  use 'petRUShka/vim-opencl'
  use 'purescript-contrib/purescript-vim'
  use 'robbles/logstash.vim'
  use 'solarnz/thrift.vim'
  use 'thyrgle/vim-dyon'
  use { 'tpope/vim-rails', requires = 'tpope/vim-dispatch' }
  use { 'tpope/vim-fireplace', ft = 'clojure' }
  use { 'tpope/vim-salve', ft = 'clojure', requires = 'tpope/vim-dispatch' }
  use 'vim-crystal/vim-crystal'
  use 'vmchale/ion-vim'
  use 'iloginow/vim-stylus'
  use 'alaviss/nim.nvim'
  use 'zebradil/hive.vim'
  use 'reasonml-editor/vim-reason-plus'
  use 'stevearc/vim-arduino'
  use 'imsnif/kdl.vim'

  if packer_bootstrap then
    packer.sync()
  end
end)

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

require('dracula').setup({
  transparent_bg = true,
})

vim.cmd[[colorscheme dracula]]

require('Comment').setup({
  mappings = {
    basic = false,
    extra = false,
    extended = false,
  }
})

local comment_api = require('Comment.api')

vim.keymap.set("n", "<C-c>", comment_api.toggle.linewise.current)
vim.keymap.set("x", "<C-c>", "<Plug>(comment_toggle_linewise_visual)")

require('nvim-treesitter.configs').setup {
  auto_install = true,
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
      enabled = false,
      warn = {},
    },
  },
}

local servers = {
  "bashls",
  "bufls",
  "clojure_lsp",
  "cmake",
  "crystalline",
  "csharp_ls",
  "cssls",
  "dartls",
  "dockerls",
  "dotls",
  "elmls",
  "ember",
  "erg_language_server",
  "erlangls",
  "fortls",
  "gdscript",
  "gopls",
  "graphql",
  "hls",
  "html",
  "julials",
  "kotlin_language_server",
  "m68k",
  "mint",
  "mlir_lsp_server",
  "ocamllsp",
  "openscad_ls",
  "perlpls",
  "purescriptls",
  "pyright",
  "r_language_server",
  "racket_langserver",
  "salt_ls",
  "solargraph",
  "solidity_ls",
  "sourcekit",
  "sqls",
  "svlangserver",
  "terraformls",
  "texlab",
  "turtle_ls",
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

lspconfig.eslint.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  settings = {
    useESLintClass = true,
    packageManager = 'yarn',
  },
}))

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

lspconfig.ember.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern('ember-cli-build.js'),
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
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    }
  }
}))

lspconfig.powershell_es.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  bundle_path = '/Users/jacob/.powershell',
}))

lspconfig.tsserver.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  cmd = { 'typescript-language-server', '--stdio', '--log-level', '1', '--tsserver-log-verbosity', 'off' },
  init_options = {
    hostInfo = 'neovim',
    npmLocation = '/opt/homebrew/bin/npm',
    tsserver = {
      trace = 'messages',
    },
    preferences = {
      importModuleSpecifierPreference = 'non-relative',
      disableSuggestions = true,
      includeCompletionsForModuleExports = false,
    },
  }
}))

lspconfig.awk_ls.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  cmd = { "/opt/homebrew/opt/node@16/bin/node", '/opt/homebrew/bin/awk-language-server', 'start' },
}))

local null_ls = require("null-ls")
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
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
    diagnostics.statix,
    diagnostics.vint,
    diagnostics.zsh,
  },
}))

require('rust-tools').setup(coq.lsp_ensure_capabilities({ on_attach = on_attach }))

require("coq_3p") {
  { src = "nvimlua", short_name = "nLUA", conf_only = true },
}

require('colorizer').setup({})
require('nvim-surround').setup({})

require('nvim-tree').setup({
  git = {
    enable = true,
    ignore = true,
  },
  renderer = {
    add_trailing = true,
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
    },
  },
})

local telescope = require('telescope')
local telescope_actions = require("telescope.actions")
local telescope_builtin = require('telescope.builtin')
local telescope_state = require('telescope.actions.state')

local function multi_select(prompt_bufnr)
  local picker = telescope_state.get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()
  if #multi > 1 then
    telescope_actions.send_selected_to_qflist(prompt_bufnr)
    telescope_actions.open_qflist(prompt_bufnr)
  else
    telescope_actions.select_default(prompt_bufnr)
  end
end

telescope.setup({
  defaults = {
    sorting_strategy = 'ascending',
    mappings = {
      i = {
        ['<esc>'] = telescope_actions.close,
        ['<C-a>'] = telescope_actions.toggle_all,
        ['<CR>'] = multi_select
      },
      n = {
        ['<esc>'] = telescope_actions.close,
        ['<C-a>'] = telescope_actions.toggle_all,
        ['<CR>'] = multi_select
      },
    }
  },
})
telescope.load_extension('fzf')
telescope.load_extension('live_grep_args')

vim.keymap.set('', '<C-p>', telescope_builtin.find_files)
vim.keymap.set('', '<C-e>', telescope.extensions.live_grep_args.live_grep_args)
