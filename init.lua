-- luacheck: globals vim
vim.g.loaded_matchit = 1 -- matchup compatibility
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.python3_host_prog = '/opt/homebrew/bin/python3.11'

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
vim.opt.clipboard = 'unnamed'
vim.opt.splitright = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'indent'
vim.opt.swapfile = false
vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 5
vim.opt.hidden = false
vim.opt.showtabline=2

vim.keymap.set('n', 'x', '"_x') -- prevent character delete from writing to the clipboard
vim.keymap.set('v', '.', ':normal .<CR>')
vim.keymap.set('n', '[', vim.cmd.tabprevious, { silent = true })
vim.keymap.set('n', ']', vim.cmd.tabnext, { silent = true })
vim.api.nvim_create_user_command('Nt', function() vim.cmd.tabnew() end, {})

vim.filetype.add({
  extension = {
    jq = 'jq',
    kdl = 'kdl',
  },
})

local fileTypeDetectId = vim.api.nvim_create_augroup('filetypedetect', { clear = true })

local indents = {
  cs = 'setl sw=4 sts=4 ts=4 et',
  c = 'setl sw=4 sts=4 ts=4 et',
  cpp = 'setl sw=4 sts=4 ts=4 et',
  make = 'setl noexpandtab sw=4 sts=0 ts=4',
}

for pattern, command in pairs(indents) do
  vim.api.nvim_create_autocmd('FileType', { pattern = pattern, group = fileTypeDetectId, command = command })
end

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 150, on_visual = true })
  end
})

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

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'HiPhish/nvim-ts-rainbow2',
      'nvim-treesitter/nvim-treesitter-refactor',
      'RRethy/nvim-treesitter-textsubjects',
      'nvim-treesitter/playground',
      'nvim-treesitter/nvim-treesitter-context',
      'JoosepAlviste/nvim-ts-context-commentstring',
      {
        'andymass/vim-matchup',
        init = function()
          vim.g.matchup_matchparen_offscreen = { method = 'popup' }
          vim.g.matchup_matchparen_deferred = 1
          vim.g.matchup_surround_enabled = 0
        end,
      },
      'windwp/nvim-ts-autotag',
    },
    config = function()
      local parsers = require('nvim-treesitter.parsers')
      local ft_to_lang_original = parsers.ft_to_lang

      parsers.ft_to_lang = function(ft)
        if ft == 'zsh' then
          return 'bash'
        end
        return ft_to_lang_original(ft)
      end

      require('nvim-treesitter.configs').setup({
        auto_install = true,
        ensure_installed = 'all',
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        highlight = {
          enable = true,
        },
        ignore_install = { 'norg', 'phpdoc', 'smali' },
        matchup = {
          enable = true,
        },
        rainbow = {
          enable = true,
          extended_mode = true,
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
          lint_events = { 'BufWrite', 'CursorHold' },
        },
        autotag = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },

  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
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
      })
    end,
  },

  {
    'folke/which-key.nvim',
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
      require('which-key').setup({})
    end,
  },

  {
    'kylechui/nvim-surround',
    version = '*',
    opts = {
      keymaps = {
        normal = 'sa',
        visual = 'sa',
        delete = 'sd',
        change = 'sc',
      },
      aliases = {
        ["s"] = { '}', ']', ')', '>', '"', "'", '`' },
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
    config = function()
      local telescope_actions = require('telescope.actions')

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

      local telescope = require('telescope')

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

      vim.keymap.set('', '<C-p>', require('telescope.builtin').find_files)
      vim.keymap.set('', '<C-e>', telescope.extensions.live_grep_args.live_grep_args)
    end,
  },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      '<C-n>',
      '<C-f>',
    },
    config = function()
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
      local nvim_tree_api = require('nvim-tree.api')
      vim.keymap.set('n', '<C-n>', nvim_tree_api.tree.toggle)
      vim.keymap.set('n', '<C-f>', function()
        nvim_tree_api.tree.find_file({ open = true, focus = true })
      end)
    end,
  },

  {
    'jakesjews/vim-ember-imports',
    dependencies = { 'sukima/vim-javascript-imports' },
    ft = { 'coffee', 'javascript', 'typescript' },
    init = function()
      vim.g.vim_javascript_imports_multiline_max_col = 120
      vim.g.vim_javascript_imports_multiline_max_vars = 100
    end
  },

  'mfussenegger/nvim-dap',
  'tpope/vim-dadbod',
  'tpope/vim-sleuth',

  {
    'ellisonleao/glow.nvim',
    cmd = 'Glow',
    config = true,
  },

  {
    'samodostal/image.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'm00qek/baleia.nvim',
    },
    config = function()
      require('image').setup {
        render = {
          foreground_color = true,
          background_color = true
        },
      }
    end,
  },

  {
    '0xStabby/chatgpt-vim',
    cmd = 'Gpt',
  },

  {
    'dpayne/CodeGPT.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Chat',
    config = function()
      require('codegpt.config')

      vim.g['codegpt_commands'] = {
        ['tests'] = {
          language_instructions = {
            javascript = 'Use the mocha framework and the chai.js expect api for assertions.',
          }
        },
      }
    end,
  },

  {
    'michaelb/sniprun',
    build = 'bash install.sh',
    opts = {
      live_mode_toggle = 'enable',
      repl_enable = { 'Clojure_fifo' },
    },
  },

  {
    'NvChad/nvim-colorizer.lua',
    config = true,
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'b0o/schemastore.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'FelipeLema/cmp-async-path',
      {
        'L3MON4D3/LuaSnip',
        version = "1.*",
        build = "make install_jsregexp",
      },
      'L3MON4D3/cmp-luasnip-choice',
      'onsails/lspkind.nvim',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      {
        'tamago324/cmp-zsh',
        opts = {
          filetypes = { "zsh" },
        },
      },
      {
        'David-Kunz/cmp-npm',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
          only_latest_version = true,
        },
      },
      {
        'zbirenbaum/copilot-cmp',
        dependencies = {
          {
            'zbirenbaum/copilot.lua',
            opts = {
              suggestion = { enabled = false },
              panel = { enabled = false },
            },
          },
        },
        config = true,
      },
    },
    config = function()
      local cmp = require('cmp')
      local types = require('cmp.types')
      local compare = cmp.config.compare

      local select_if_active = function(direction, fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp['select_' .. direction .. '_item']({ behavior = types.cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end

      local confirm_if_active = function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end

      local config = {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<Down>'] = {
            i = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }),
            c = function(fallback)
              select_if_active('next', fallback)
            end,
          },
          ['<Up>'] = {
            i = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }),
            c = function(fallback)
              select_if_active('prev', fallback)
            end,
          },
          ['<Tab>'] = {
            i = function(fallback)
              select_if_active('next', fallback)
            end,
            c = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }),
          },
          ['<S-Tab>'] = {
            i = function(fallback)
              select_if_active('prev', fallback)
            end,
            c = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }),
          },
          ['<CR>'] = cmp.mapping({
            i = function(fallback)
              confirm_if_active(fallback)
            end,
            s = cmp.mapping.confirm({ select = true }),
            c = function(fallback)
              confirm_if_active(fallback)
            end,
          }),
        },
        formatting = {
          format = require('lspkind').cmp_format({
            mode = 'symbol_text',
            menu = {
              buffer = '[Buffer]',
              nvim_lsp = '[LSP]',
              nvim_lua = '[Lua]',
              async_path = '[Path]',
              nvim_lsp_document_symbol = '[Symbol]',
              npm = '[NPM]',
              luasnip_choice = '[LuaSnip]',
              zsh = '[Zsh]',
              cmdline = '[Cmd]',
              copilot = '',
            },
          })
        },
        sources = {
          { name = 'nvim_lsp', group_index = 1 },
          { name = 'nvim_lsp_signature_help', group_index = 1 },
          { name = 'luasnip_choice', group_index = 1 },
          { name = 'nvim_lua', group_index = 1 },
          { name = 'npm', keyword_length = 4, group_index = 1 },
          { name = 'async_path', group_index = 1 },
          { name = 'zsh', group_index = 1 },
          { name = 'copilot', group_index = 1 },
          { name = 'buffer', group_index = 2 },
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            compare.offset,
            compare.exact,
            require('copilot_cmp.comparators').prioritize,
            compare.score,
            compare.recently_used,
            compare.locality,
            compare.kind,
            compare.length,
            compare.order,
          },
        },
      }

      cmp.setup(config)

      cmp.setup.cmdline({ '/', '?' },  {
        sources = {
          { name = 'nvim_lsp_document_symbol', group_index = 1 },
        },
      })

      cmp.setup.cmdline(':', {
        sources = {
          { name = 'async_path', group_index = 1 },
          { name = 'cmdline', group_index = 1 },
        }
      })
    end,
  },

  {
    'neovim/nvim-lspconfig',
    config = function()
      local servers = {
        'awk_ls',
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
        'helm_ls',
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
        'ruff_lsp',
        'salt_ls',
        'solargraph',
        'solidity_ls_nomicfoundation',
        'sourcekit',
        'sqlls',
        'svlangserver',
        'terraformls',
        'texlab',
        'turtle_ls',
        'vala_ls',
        'veryl_ls',
        'vhdl_ls',
        'vimls',
        'vuels',
        'yls',
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
        single_file_support = true
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
        cmd = {
          'arduino-language-server',
          '-cli-config', '/Users/jacob/Library/Arduino15/arduino-cli.yaml',
        }
      })

      lspconfig.stylelint_lsp.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { 'css', 'less', 'scss', 'sugarss', 'wxss' },
      })

      lspconfig.elixirls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { 'elixir-ls' },
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
              library = vim.api.nvim_get_runtime_file('', true),
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

      lspconfig.yamlls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          yaml = {
            keyOrdering = false,
            schemaStore = { enable = true },
          },
        },
      })
    end,
  },

  {
    'jose-elias-alvarez/typescript.nvim',
    config = function()
      require('typescript').setup({
        server = {
          cmd = { 'typescript-language-server', '--stdio', '--log-level', '1', '--tsserver-log-verbosity', 'off' },
          on_attach = on_attach,
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
          init_options = {
            hostInfo = 'neovim',
            npmLocation = '/opt/homebrew/bin/npm',
            preferences = {
              importModuleSpecifierPreference = 'non-relative',
              disableSuggestions = true,
              ignoreDeprecations = '5.0',
            },
          },
        }
      })
    end,
  },

  {
    'klen/nvim-test',
    keys = '<C-t>',
    config = function()
      local nvim_test = require('nvim-test')
      nvim_test.setup({
        runners = {
          javascript = 'nvim-test.runners.mocha',
        },
      })

      vim.keymap.set('', '<C-t>', function()
        nvim_test.run('nearest')
      end)
    end,
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local null_ls = require('null-ls')
      local diagnostics = null_ls.builtins.diagnostics

      null_ls.setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        on_attach = on_attach,
        sources = {
          diagnostics.cppcheck,
          diagnostics.credo,
          diagnostics.hadolint,
          diagnostics.phpstan,
          diagnostics.revive,
          diagnostics.statix,
          diagnostics.vint,
          diagnostics.zsh,
          require('typescript.extensions.null-ls.code-actions'),
        },
      })
    end,
  },

  {
    'scalameta/nvim-metals',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  {
    'simrat39/rust-tools.nvim',
    ft = 'rust',
    config = function()
      require('rust-tools').setup({
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      })
    end,
  },

  {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
    config = function()
      require('jdtls').start_or_attach({
        cmd = { '/opt/homebrew/opt/jdtls/bin/jdtls' },
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        root_dir = vim.fs.dirname(vim.fs.find({ '.gradlew', '.git', 'mvnw' }, { upward = true })[1]),
      })
    end,
  },

  {
    'ionide/Ionide-vim',
    ft = { 'fsharp', 'fsharp_project' },
  },

  {
    'mrcjkb/haskell-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    branch = '1.x.x',
    config = function()
      local ht = require('haskell-tools')
      ht.setup({
        hls = {
          on_attach = function(_client, bufnr)
            local opts = vim.tbl_extend('keep', { noremap = true, silent = true }, { buffer = bufnr, })
            vim.keymap.set('n', '<space>ca', vim.lsp.codelens.run, opts)
            vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)
          end,
        },
      })
    end,
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
    'wavded/vim-stylus',
    ft = 'stylus',
  },

  'Joorem/vim-haproxy',
  'IrenejMarc/vim-mint',
  'MTDL9/vim-log-highlighting',
  'jlcrochet/vim-razor',
  'alunny/pegjs-vim',
  'elubow/cql-vim',
  'fladson/vim-kitty',
  'wsdjeg/vim-livescript',
  'hellerve/carp-vim',
  'jakesjews/vim-emblem',
  'katusk/vim-qkdb-syntax',
  'kchmck/vim-coffee-script',
  'leafo/moonscript-vim',
  'petRUShka/vim-opencl',
  'purescript-contrib/purescript-vim',
  'robbles/logstash.vim',
  'thyrgle/vim-dyon',
  'vmchale/ion-vim',
  'alaviss/nim.nvim',
  'zebradil/hive.vim',
  'reasonml-editor/vim-reason-plus',
  'stevearc/vim-arduino',
  'llathasa-veleth/vim-brainfuck',

  {
    'pearofducks/ansible-vim',
    init = function()
      vim.g.ansible_template_syntaxes = {
        ['*.sh.j2'] = 'bash',
        ['*.json.j2'] = 'json',
        ['*.js.j2'] = 'javascript',
        ['*.conf.j2'] = 'dosini',
      }
    end,
  },

  {
    'vim-crystal/vim-crystal',
    ft = { 'crystal', 'ecrystal' },
  },

  {
    'Mofiqul/dracula.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('dracula').setup({
        transparent_bg = true,
      })
      vim.cmd.colorscheme('dracula')
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    dependencies = { 'Mofiqul/dracula.nvim' },
  },
}, { install = { colorscheme = { 'dracula' } } })
