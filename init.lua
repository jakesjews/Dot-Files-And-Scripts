-- luacheck: globals vim
vim.g.loaded_matchit = 1 -- matchup compatibility
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.python3_host_prog="/opt/homebrew/bin/python3.11"

vim.opt.shortmess:append({ c = true })
vim.opt.number = true
vim.opt.autowrite = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.signcolumn = 'number'
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.pastetoggle = '<F2>'
vim.opt.clipboard = 'unnamed'
vim.opt.foldlevel = 99
vim.opt.splitright = true
vim.opt.foldmethod = 'indent'
vim.opt.swapfile = false
vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 5
vim.opt.hidden = false

vim.keymap.set('n', 'x', '"_x') -- prevent character delete from writing to the clipboard
vim.keymap.set('v', '.', ':normal .<CR>')
vim.keymap.set('n', '[', vim.cmd.bprevious, { silent = true })
vim.keymap.set('n', ']', vim.cmd.bnext, { silent = true })

local fileTypeDetectId = vim.api.nvim_create_augroup("filetypedetect", { clear = true })

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
  vim.keymap.set('n', 'gr', vim.lsp.buf.rename, lsp_key_opts)
  vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, lsp_key_opts)
  vim.keymap.set('n', 'gR', vim.lsp.buf.references, lsp_key_opts)
  vim.keymap.set('n', 'gf', function() vim.lsp.buf.format({ async = true }) end, lsp_key_opts)
end

vim.filetype.add({
  extension = {
    jq = 'jq'
  }
})

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

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup="IncSearch", timeout=150, on_visual=true })
  end
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'mrjones2014/nvim-ts-rainbow',
      'nvim-treesitter/nvim-treesitter-refactor',
      'RRethy/nvim-treesitter-textsubjects',
      'nvim-treesitter/playground',
      'nvim-treesitter/nvim-treesitter-context',
      {
        'andymass/vim-matchup',
        config = function()
          vim.g.matchup_matchparen_offscreen = { method = 'popup' }
          vim.g.matchup_matchparen_deferred = 1
          vim.g.matchup_surround_enabled = 0
        end
      },
      'windwp/nvim-ts-autotag',
    },
    opts = {
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
      textsubjects = {
        enable = true,
        keymaps = {
          ['.'] = 'textsubjects-smart',
          [';'] = 'textsubjects-container-outer',
          ['i;'] = 'textsubjects-container-inner',
        },
      },
      refactor = {
        highlight_definitions = {
          enable = true,
          clear_on_cursor_move = true,
        },
      },
      playground = {
        enable = true,
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
      autotag = {
        enable = true,
      }
    },
    config = function(_self, opts)
      local parsers = require('nvim-treesitter.parsers');
      local ft_to_lang_original = parsers.ft_to_lang

      parsers.ft_to_lang = function(ft)
        if ft == 'zsh' then
          return 'bash'
        end
        return ft_to_lang_original(ft)
      end

      require('nvim-treesitter.configs').setup(opts)
      require('treesitter-context').setup({})
    end
  },

  {
    'numToStr/Comment.nvim',
    opts = {
      mappings = {
        basic = true,
        extra = false,
        extended = false,
      },
      toggler = {
        line = '<C-c>',
      },
      opleader = {
        line = '<C-c>',
      },
    },
  },

  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
      require("which-key").setup({})
    end
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    opts = {
      keymaps = {
        normal = "sa",
        visual = "sa",
        delete = "sd",
        change = "sc",
      },
      aliases = {
        ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
      },
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    keys = {
      '<C-e>',
      '<C-p>',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
    },
    branch = '0.1.x',
    opts = function()
      local telescope_actions = require("telescope.actions")

      local function multi_select(prompt_bufnr)
        local telescope_state = require('telescope.actions.state')
        local picker = telescope_state.get_current_picker(prompt_bufnr)
        local multi = picker:get_multi_selection()
        if #multi > 1 then
          telescope_actions.send_selected_to_qflist(prompt_bufnr)
          telescope_actions.open_qflist(prompt_bufnr)
        else
          telescope_actions.select_default(prompt_bufnr)
        end
      end

      return {
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
      }
    end,
    config = function(_self, opts)
      local telescope = require('telescope')

      telescope.setup(opts)
      telescope.load_extension('fzf')
      telescope.load_extension('live_grep_args')

      vim.keymap.set('', '<C-p>', require('telescope.builtin').find_files)
      vim.keymap.set('', '<C-e>', telescope.extensions.live_grep_args.live_grep_args)
    end
  },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      '<C-n>',
      '<C-f>',
    },
    opts = {
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
    },
    config = function(_self, opts)
      require('nvim-tree').setup(opts)
      vim.keymap.set('n', '<C-n>', vim.cmd.NvimTreeToggle)
      vim.keymap.set('n', '<C-f>', vim.cmd.NvimTreeFindFile)
    end
  },

  {
    'jakesjews/vim-ember-imports',
    dependencies = { "sukima/vim-javascript-imports" },
    ft = {'coffee', 'javascript', 'typescript'},
    config = function()
      vim.g.vim_javascript_imports_multiline_max_col = 120
      vim.g.vim_javascript_imports_multiline_max_vars = 100
    end
  },

  'mfussenegger/nvim-dap',
  'tpope/vim-dadbod',
  'tpope/vim-sleuth',
  'gpanders/editorconfig.nvim',

  {
    'michaelb/sniprun',
    build = 'bash install.sh',
    opts = {
      live_mode_toggle='enable',
      repl_enable = { 'Clojure_fifo' },
    },
  },

  { 'NvChad/nvim-colorizer.lua', config = true },
  { 'windwp/nvim-autopairs', config = true },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'b0o/schemastore.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      {
        'David-Kunz/cmp-npm',
        dependencies = { 'nvim-lua/plenary.nvim' },
      },
      {
        'KadoBOT/cmp-plugins',
        opts = {
          files = { 'plugins.lua', '~/.local/share/nvim/lazy' },
        },
      },
    },
    opts = function()
      local cmp = require('cmp')
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')

      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )

      return {
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
        }),
        sources = cmp.config.sources(
          {
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_document_symbol' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'path' },
            { name = 'npm', keyword_length = 4 },
            { name = 'nvim_lua' },
            { name = 'plugins' },
          },
          {
            { name = 'buffer' },
          }
        )
      }
    end,
  },

  {
    'neovim/nvim-lspconfig',
    config = function()
      local servers = {
        'bashls',
        'bufls',
        'clojure_lsp',
        'cmake',
        'coffeesense',
        'crystalline',
        'csharp_ls',
        'cssls',
        'dartls',
        'docker_compose_language_service',
        'dockerls',
        'dotls',
        'elmls',
        'ember',
        'erg_language_server',
        'erlangls',
        'fortls',
        'futhark_lsp',
        'gdscript',
        'gleam',
        'gopls',
        'graphql',
        'hls',
        'html',
        'julials',
        'kotlin_language_server',
        'm68k',
        'mint',
        'mlir_lsp_server',
        'nomad_lsp',
        'ocamllsp',
        'openscad_lsp',
        'perlpls',
        'prolog_ls',
        'purescriptls',
        'pyright',
        'r_language_server',
        'racket_langserver',
        'salt_ls',
        'solargraph',
        'solidity_ls',
        'sourcekit',
        'sqls',
        'svlangserver',
        'terraformls',
        'texlab',
        'turtle_ls',
        'vala_ls',
        'veryl_ls',
        'vimls',
        'vuels',
        'yamlls',
        'zls',
      }

      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end

      lspconfig.eslint.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          useESLintClass = true,
          packageManager = 'yarn',
        },
      })

      lspconfig.ansiblels.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern('playbook.yml'),
        single_file_support = false
      })

      lspconfig.jsonls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      })

      lspconfig.ember.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern('ember-cli-build.js'),
      })

      lspconfig.arduino_language_server.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd =  {
          "arduino-language-server",
          "-cli-config", "/Users/jacob/Library/Arduino15/arduino-cli.yaml",
        }
      })

      lspconfig.stylelint_lsp.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "css", "less", "scss", "sugarss", "wxss" },
      })

      lspconfig.elixirls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "elixir-ls" },
      })

      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
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
      })

      lspconfig.powershell_es.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        bundle_path = '/Users/jacob/.powershell',
      })

      lspconfig.tsserver.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { 'typescript-language-server', '--stdio', '--log-level', '1', '--tsserver-log-verbosity', 'off' },
        init_options = {
          hostInfo = 'neovim',
          npmLocation = '/opt/homebrew/bin/npm',
          preferences = {
            importModuleSpecifierPreference = 'non-relative',
            disableSuggestions = true,
            includeCompletionsForModuleExports = false,
            ignoreDeprecations = '5.0',
          },
        }
      })

      lspconfig.awk_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "/opt/homebrew/opt/node@16/bin/node", '/opt/homebrew/bin/awk-language-server', 'start' },
      })
    end,
  },

  {
    'klen/nvim-test',
    keys = '<C-t>',
    opts = {
      runners = {
        javascript = "nvim-test.runners.mocha",
      }
    },
    config = function(_self, opts)
      local nvim_test = require('nvim-test')
      nvim_test.setup(opts)

      vim.keymap.set('', '<C-t>', function()
        nvim_test.run('nearest')
      end)
    end
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = function()
      local diagnostics = require("null-ls").builtins.diagnostics

      return {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        on_attach = on_attach,
        sources = {
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
      }
    end,
  },

  {
    'scalameta/nvim-metals',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  {
    'simrat39/rust-tools.nvim',
    ft = 'rust',
    opts = function()
      return {
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      }
    end
  },

  {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
    config = function()
      require('jdtls').start_or_attach({
        cmd = {'/opt/homebrew/opt/jdtls/bin/jdtls'},
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        root_dir = vim.fs.dirname(vim.fs.find({'.gradlew', '.git', 'mvnw'}, { upward = true })[1]),
      })
    end
  },

  {
    'ionide/Ionide-vim',
    ft = { 'fsharp', 'fsharp_project' },
  },

  {
    'jdonaldson/vaxe',
    ft = {
      'flow',
      'haxe',
      'hss',
      'hxml',
      'lime',
      'nmml',
    },
  },

  {
    'iloginow/vim-stylus',
    ft = 'stylus',
  },

  'Joorem/vim-haproxy',
  'IrenejMarc/vim-mint',
  'MTDL9/vim-log-highlighting',
  'jlcrochet/vim-razor',
  'alunny/pegjs-vim',
  'elubow/cql-vim',
  'fladson/vim-kitty',
  'gkz/vim-ls',
  'hellerve/carp-vim',
  'jakesjews/vim-emblem',
  'jakwings/vim-pony',
  'katusk/vim-qkdb-syntax',
  'kchmck/vim-coffee-script',
  'leafo/moonscript-vim',
  'petRUShka/vim-opencl',
  'purescript-contrib/purescript-vim',
  'robbles/logstash.vim',
  'thyrgle/vim-dyon',
  'lifepillar/pgsql.vim',
  'vmchale/ion-vim',
  'alaviss/nim.nvim',
  'zebradil/hive.vim',
  'reasonml-editor/vim-reason-plus',
  'stevearc/vim-arduino',

  {
    'pearofducks/ansible-vim',
    config = function()
      vim.g.ansible_template_syntaxes = {
        ['*.sh.j2'] = 'bash',
        ['*.json.j2'] = 'json',
        ['*.js.j2'] = 'javascript',
        ['*.conf.j2'] = 'dosini',
      }
    end
  },

  {
    'vim-crystal/vim-crystal',
    ft = { 'crystal', 'ecrystal' },
    config = function()
      vim.g.crystal_enable_completion = 0
    end
  },

  {
    'Mofiqul/dracula.nvim',
    priority = 1000,
    opts = {
      transparent_bg = true,
    },
    config = function(_self, opts)
      require('dracula').setup(opts)
      vim.cmd.colorscheme('dracula')
    end
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    dependencies = { 'Mofiqul/dracula.nvim' },
  },
}, { install = { colorscheme = { 'dracula' } } })
