-- luacheck: globals vim
vim.g.loaded_matchit = 1 -- matchup compatibility
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.skip_ts_context_commentstring_module = true
vim.g.python3_host_prog = '/opt/homebrew/bin/python3.13'

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
vim.opt.formatoptions:remove { 'c', 'r', 'o' }

vim.keymap.set('n', 'x', '"_x') -- prevent character delete from writing to the clipboard
vim.keymap.set('v', '.', ':normal .<CR>')
vim.keymap.set('n', '[', vim.cmd.tabprevious, { silent = true })
vim.keymap.set('n', ']', vim.cmd.tabnext, { silent = true })

vim.api.nvim_create_user_command('Nt', function() vim.cmd.tabnew() end, {})

vim.treesitter.language.register('bash', 'zsh')

vim.filetype.add({
  extension = {
    jq = 'jq',
    kdl = 'kdl',
  },
})

vim.diagnostic.config({ virtual_text = true })

vim.lsp.set_log_level('error')
-- vim.lsp.set_log_level('debug')
-- require('vim.lsp.log').set_format_func(vim.inspect)

local file_type_detect_id = vim.api.nvim_create_augroup('filetypedetect', { clear = true })

local indents = {
  cs = 'setl sw=4 sts=4 ts=4 et',
  c = 'setl sw=4 sts=4 ts=4 et',
  cpp = 'setl sw=4 sts=4 ts=4 et',
  make = 'setl noexpandtab sw=4 sts=0 ts=4',
}

for pattern, command in pairs(indents) do
  vim.api.nvim_create_autocmd('FileType', { pattern = pattern, group = file_type_detect_id, command = command })
end

local format_options_id = vim.api.nvim_create_augroup('formatoptions', { clear = true })

vim.api.nvim_create_autocmd('BufEnter', {
  group = format_options_id,
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end
})

local yank_highlight_id = vim.api.nvim_create_augroup('highlightyank', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = yank_highlight_id,
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 150, on_visual = true })
  end
})

local mason_packages = {
  'fennel_language_server',
  'fsautocomplete',
  'julials',
  'matlab_ls',
  'nim_langserver',
  'ocamllsp',
  'omnisharp',
  'perlnavigator',
  'r_language_server',
  'raku_navigator',
  'serve_d',
}

local LSP_SERVERS = {
  'asm_lsp',
  'autotools_ls',
  'awk_ls',
  'bashls',
  'buf_ls',
  'clojure_lsp',
  'cmake',
  'coffeesense',
  'crystalline',
  'css_variables',
  'cssls',
  'cypher_ls',
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
  'jinja_lsp',
  'jqls',
  'kotlin_language_server',
  'm68k',
  'mint',
  'mlir_lsp_server',
  'nginx_language_server',
  'nomad_lsp',
  'nushell',
  'openscad_lsp',
  'prolog_ls',
  'psalm',
  'pug',
  'purescriptls',
  'pyright',
  'racket_langserver',
  'rescriptls',
  'ruff',
  'rune_languageserver',
  'solargraph',
  'solidity_ls_nomicfoundation',
  'somesass_ls',
  'sourcekit',
  'sqlls',
  'terraformls',
  'texlab',
  'turtle_ls',
  'uiua',
  'v_analyzer',
  'vacuum',
  'vala_ls',
  'veryl_ls',
  'vhdl_ls',
  'vimls',
  'vls',
  'volar',
  'yls',
  'zls',
}

vim.list_extend(LSP_SERVERS, mason_packages)

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
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, lsp_key_opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.rename, lsp_key_opts)
  vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, lsp_key_opts)
  vim.keymap.set('n', 'gR', vim.lsp.buf.references, lsp_key_opts)
  vim.keymap.set('n', 'gl', vim.lsp.codelens.run, lsp_key_opts)
  vim.keymap.set('n', 'gf', function() vim.lsp.buf.format({ async = true }) end, lsp_key_opts)
end

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable', -- latest stable release
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'williamboman/mason.nvim',
    opts = {},
  },

  {
    'williamboman/mason-lspconfig.nvim',
    opts = {},
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    cmd = {
      'MasonToolsInstall',
      'MasonToolsUpdate',
      'MasonToolsUpdateSync',
      'MasonToolsClean',
    },
    opts = {
      ensure_installed = mason_packages,
      run_on_start = false,
    },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'RRethy/nvim-treesitter-textsubjects',
      {
        'andymass/vim-matchup',
        init = function()
          vim.g.matchup_matchparen_offscreen = {}
          vim.g.matchup_matchparen_deferred = 1
          vim.g.matchup_surround_enabled = 0
        end,
      },
    },
    main = 'nvim-treesitter.configs',
    opts = {
      auto_install = true,
      ensure_installed = 'all',
      highlight = {
        enable = true,
      },
      ignore_install = { 'norg', 'phpdoc', 'smali' },
      matchup = {
        enable = true,
      },
      textsubjects = {
        enable = true,
        keymaps = {
          ['.'] = 'textsubjects-smart',
          [';'] = 'textsubjects-container-outer',
          ['i;'] = 'textsubjects-container-inner',
        },
      },
      indent = {
        enable = true,
      },
    },
  },

  { 'RRethy/vim-illuminate' },

  { 'nvim-treesitter/nvim-treesitter-context' },

  {
    'windwp/nvim-ts-autotag',
    opts = {
      filetypes = {
        'html',
        'javascript.glimmer',
        'javascriptreact',
        'typescriptreact',
        'svelte',
        'vue',
        'tsx',
        'jsx',
        'rescript',
        'xml',
        'php',
        'glimmer',
        'handlebars',
        'hbs'
      },
    },
  },

  {
    'Wansmer/treesj',
    keys = { '<space>m', '<space>j', '<space>s' },
    config = function()
      local tsj = require('treesj')
      local lang_utils = require('treesj.langs.utils')
      tsj.setup({
        langs = {
          glimmer = {
            element_node_start = lang_utils.set_default_preset({
              both = {
                omit = { 'tag_name' },
              },
            }),
          },
        },
      })
    end,
  },
  {
    'numToStr/Comment.nvim',
    dependencies = {
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        opts = {
          enable_autocmd = false,
        },
      },
    },
    opts = function()
      return {
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
      }
    end,
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      { 'echasnovski/mini.nvim', version = false },
    },
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {},
  },

  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    opts = {
      keymaps = {
        normal = 'sa',
        visual = 'sa',
        delete = 'sd',
        change = 'sc',
      },
      aliases = {
        ['s'] = { '}', ']', ')', '>', '"', "'", '`' },
      },
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    version = '0.1.x',
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
    opts = function()
      require('plenary.filetype').add_table({
        extension = {
          ['gjs'] = 'javascript.glimmer',
        },
      })

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
    config = function(_plugin, opts)
      local telescope = require('telescope')

      telescope.setup(opts)
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
    config = function(_plugin, opts)
      require('nvim-tree').setup(opts)
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

  {
    'NMAC427/guess-indent.nvim',
    opts = {},
  },

  'hiphish/rainbow-delimiters.nvim',

  {
    'ellisonleao/glow.nvim',
    cmd = 'Glow',
    opts = {},
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
    opts = {},
  },

  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {},
  },

  {
    'andrewferrier/debugprint.nvim',
    opts = function()
      local js_like = {
        left = "console.warn('",
        right = "');",
        mid_var = "', ",
        right_var = ');',
      }

      return {
        display_counter = false,
        filetypes = {
          javascript = js_like,
          javascriptreact = js_like,
          typescript = js_like,
          typescriptreact = js_like,
          glimmer = js_like,
          ['javascript.glimmer'] = js_like,
        },
      }
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'b0o/schemastore.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'https://codeberg.org/FelipeLema/cmp-async-path.git',
      {
        'L3MON4D3/LuaSnip',
        version = '*',
        build = 'make install_jsregexp',
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
          filetypes = { 'zsh' },
        },
      },
      {
        'David-Kunz/cmp-npm',
        dependencies = { 'nvim-lua/plenary.nvim' },
        ft = 'json',
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
        opts = {},
      },
    },
    opts = function()
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
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false })
        else
          fallback()
        end
      end

      return {
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
          { name = 'nvim_lua', group_index = 1 },
          { name = 'nvim_lsp', group_index = 1 },
          { name = 'nvim_lsp_signature_help', group_index = 1 },
          { name = 'luasnip_choice', group_index = 1 },
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
    end,
    config = function(_plugin, opts)
      local cmp = require('cmp')
      cmp.setup(opts)

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
    'CopilotC-Nvim/CopilotChat.nvim',
    cmd = {
      'CopilotChat',
      'CopilotChatOpen',
      'CopilotChatClose',
      'CopilotChatToggle',
      'CopilotChatReset',
      'CopilotChatSave',
      'CopilotChatLoad',
      'CopilotChatDebugInfo',
      'CopilotChatModels',
      'CopilotChatAgents',
      'CopilotChatExplain',
      'CopilotChatReview',
      'CopilotChatFix',
      'CopilotChatOptimize',
      'CopilotChatDocs',
      'CopilotChatTests',
      'CopilotChatFixDiagnostic',
      'CopilotChatCommit',
      'CopilotChatCommitStaged',
    },
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim' },
    },
    build = "make tiktoken",
    opts = {},
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'yioneko/nvim-vtsls',
    },
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      for _, lsp in ipairs(LSP_SERVERS) do
        lspconfig[lsp].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end

      lspconfig.verible.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { 'verible-verilog-ls', '--rules_config_search' },
      })

      lspconfig.eslint.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = {
          'javascript',
          'javascriptreact',
          'javascript.jsx',
          'typescript',
          'typescriptreact',
          'typescript.tsx',
          'glimmer',
          'javascript.glimmer',
        },
        settings = {
          experimental = {},
          useESLintClass = true,
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
        init_options = {
          editor = 'vscode',
        },
        root_dir = lspconfig.util.root_pattern('ember-cli-build.js', 'ember-cli-build.mjs'),
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

      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc') then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT'
            },
            workspace = {
              checkThirdParty = false,
              telemetry = {
                enable = false,
              },
              library = vim.tbl_extend(
                'force',
                vim.tbl_filter(
                  function(path) return vim.fn.isdirectory(path) == 1 end,
                  {
                    vim.fn.expand('$HOME/github/lua-language-server'),
                  }
                ),
                { vim.env.VIMRUNTIME }
              )
            }
          })
        end,
        settings = {
          Lua = {}
        }
      }

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

      lspconfig.html.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = {
          'html',
          'javascript.glimmer',
          'javascriptreact',
          'typescriptreact',
          'svelte',
          'vue',
          'tsx',
          'jsx',
          'rescript',
          'glimmer',
          'handlebars',
          'hbs'
        },
      })

      lspconfig.glint.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern(
          '.glintrc.yml',
          '.glintrc',
          '.glintrc.json',
          '.glintrc.js',
          'glint.config.js',
          'ember-cli-build.js',
          'ember-cli-build.mjs'
        ),
      })

      require('lspconfig.configs').vtsls = require('vtsls').lspconfig

      lspconfig.vtsls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = {
          'javascript',
          'javascriptreact',
          'javascript.jsx',
          'typescript',
          'typescriptreact',
          'typescript.tsx',
          'glimmer',
          'javascript.glimmer',
        },
        settings = {
          javascript = {
            preferGoToSourceDefinition = true,
            inlayHints = {
              parameterNames = {
                enabled = 'all',
                propertyDeclarationTypes = {
                  enabled = true,
                },
                enumMemberValues = {
                  enabled = true,
                },
                functionLikeReturnTypes = {
                  enabled = true,
                },
              },
            },
            suggest = {
              completeFunctionCalls = true,
            },
            preferences = {
              importModuleSpecifier = 'non-relative',
            },
            validate = {
              enable = false,
            },
          },
        },
      })
    end,
  },

  {
    'linrongbin16/lsp-progress.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },

  {
    'klen/nvim-test',
    keys = '<C-t>',
    opts = {
      runners = {
        javascript = 'nvim-test.runners.mocha',
      },
    },
    config = function(_plugin, opts)
      local nvim_test = require('nvim-test')
      nvim_test.setup(opts)

      vim.keymap.set('', '<C-t>', function()
        nvim_test.run('nearest')
      end)
    end,
  },

  {
    'mfussenegger/nvim-lint',
    config = function()
      local lint = require('lint')

      lint.linters_by_ft = {
        cpp = { 'cppcheck' },
        elixir = { 'credo' },
        dockerfile = { 'hadolint' },
        php = { 'phpstan' },
        go = { 'revive' },
        vim = { 'vint' },
      }

      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },

  'jrop/mongo.nvim',

  {
    'scalameta/nvim-metals',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  {
    'mrcjkb/rustaceanvim',
    version = '*',
    ft = 'rust',
    init = function()
      vim.g.rustaceanvim = {
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      }
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
    version = '*',
    ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
    init = function()
      vim.g.haskell_tools = {
        hls = {
          on_attach = function(_client, bufnr, ht)
            local opts = vim.tbl_extend('keep', { noremap = true, silent = true }, { buffer = bufnr, })
            vim.keymap.set('n', '<space>ca', vim.lsp.codelens.run, opts)
            vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)
          end,
        },
      }
    end,
  },

  {
    "TamaMcGlinn/nvim-lspconfig-ada",
    ft = 'ada',
  },

  {
    'wavded/vim-stylus',
    ft = 'stylus',
  },

  'konfekt/vim-office',
  'MTDL9/vim-log-highlighting',
  'jlcrochet/vim-razor',
  'fladson/vim-kitty',
  'jakesjews/vim-emblem',
  'katusk/vim-qkdb-syntax',
  'kchmck/vim-coffee-script',
  'robbles/logstash.vim',
  'stevearc/vim-arduino',
  'q60/vim-brainfuck',
  'modularml/mojo.vim',

  {
    'ShinKage/idris2-nvim',
    ft = { 'idris2', 'ipkg', 'lidris2' },
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {},
  },

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
    'vuki656/package-info.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    cmd = 'Npm',
    config = function()
      local packageInfo = require('package-info')

      packageInfo.setup({
        autostart = false,
      })

      vim.api.nvim_create_user_command('Npm', packageInfo.show, {})
    end
  },

  {
    'Mofiqul/dracula.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent_bg = true,
    },
    config = function(_plugin, opts)
      require('dracula').setup(opts)
      vim.cmd.colorscheme('dracula')
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
    dependencies = { 'Mofiqul/dracula.nvim' },
  },
},
{
  install = { colorscheme = { 'dracula' } },
})

