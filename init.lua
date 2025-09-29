-- luacheck: globals vim

local function assign(root, opts)
  for name, value in pairs(opts) do
    root[name] = value
  end
end

local function bind(func, ...)
  local args = {...}
  return function() return func(unpack(args)) end
end

assign(vim.g, {
  loaded_matchit = 1, -- matchup compatibility
  loaded_netrw = 1,
  loaded_netrwPlugin = 1,
  skip_ts_context_commentstring_module = true,
  python3_host_prog = '/opt/homebrew/bin/python3.13',
})

assign(vim.opt, {
  number = true,
  autowrite = true,
  backup = false,
  writebackup = false,
  updatetime = 300,
  signcolumn = 'number',
  completeopt = 'menu,menuone,noselect',
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  ignorecase = true,
  smartcase = true,
  clipboard = 'unnamed',
  splitright = true,
  foldlevel = 99,
  foldmethod = 'indent',
  swapfile = false,
  scrolloff = 1,
  sidescrolloff = 5,
})

local function set_keys(mappings)
  for _, mapping in ipairs(mappings) do
    vim.keymap.set(unpack(mapping))
  end
end

local augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

set_keys({
  { 'n', 'x', '"_x' }, -- prevent character delete from writing to the clipboard
  { 'v', '.', ':normal .<CR>' },
  { 'n', '[', vim.cmd.tabprevious, { silent = true } },
  { 'n', ']', vim.cmd.tabnext, { silent = true } },
})

vim.api.nvim_create_user_command('Nt', bind(vim.cmd.tabnew), {})

vim.treesitter.language.register('bash', 'zsh')

vim.filetype.add({
  extension = {
    jq = 'jq',
    kdl = 'kdl',
    re = 'reason',
    rei = 'reason',
    merlin = 'merlin',
  },
})

vim.diagnostic.config({
  virtual_lines = { current_line = true },
})
vim.lsp.set_log_level('error')
vim.lsp.inlay_hint.enable()
-- vim.lsp.set_log_level('debug')
-- require('vim.lsp.log').set_format_func(vim.inspect)

local indent_grp = augroup('UserIndent', { clear = true })

local function setIndentFour()
  assign(vim.bo, {
    shiftwidth = 4,
    tabstop = 4,
    expandtab = true,
  })
end

local indent_cmds = {
  cs = setIndentFour,
  c = setIndentFour,
  cpp = setIndentFour,
  make = function()
    assign(vim.bo, {
      expandtab = false,
      tabstop = 4,
    })
  end,
}

for ft, fn in pairs(indent_cmds) do
  create_autocmd('FileType', {
    group = indent_grp,
    pattern = ft,
    callback = fn,
    desc = ('Set %s indentation').format(ft),
  })
end

create_autocmd('FileType', {
  callback = function()
    if not vim.treesitter.get_parser(nil, nil, { error = false }) then
      return
    end

    vim.treesitter.start()
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
  end,
})

local format_options_id = augroup('UserFormatOptions', { clear = true })

vim.api.nvim_create_autocmd('BufWinEnter', {
  group = format_options_id,
  callback = function() vim.opt.formatoptions:remove({ 'c', 'r', 'o' }) end
})

local yank_highlight_id = augroup('UserHighlightYank', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = yank_highlight_id,
  callback = bind(vim.highlight.on_yank, {
    higroup = 'IncSearch',
    timeout = 150,
    on_visual = true,
  })
})

local cursor_hold_id = augroup('CursorHold', { clear = true })

vim.api.nvim_create_autocmd('CursorHold', {
  group = cursor_hold_id,
  callback = bind(vim.diagnostic.open_float,
    nil,
    {
      focusable = false,
      close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
  ),
})

local jsOptions = {
  preferGoToSourceDefinition = true,
  -- inlayHints = {
  --   parameterNames = { enabled = 'literals' },
  --   parameterTypes = { enabled = true },
  --   variableTypes = { enabled = true },
  --   propertyDeclarationTypes = { enabled = true },
  --   functionLikeReturnTypes = { enabled = true },
  --   enumMemberValues = { enabled = true },
  -- },
  suggest = {
    completeFunctionCalls = true,
  },
  preferences = {
    importModuleSpecifier = 'non-relative',
  },
  diagnostics = { enable = true },
}

local jsLikeOptions = {
  typescript = jsOptions,
  javascript = jsOptions,
}

local mason_packages = {
  'fennel_language_server',
  'julials',
  'matlab_ls',
  'nim_langserver',
  'ocamllsp',
  'omnisharp',
  'perlnavigator',
  'phpactor',
  'r_language_server',
  'raku_navigator',
  'serve_d',
  'vhdl_ls',
}

local LSP_SERVERS = {
  'ansiblels',
  'arduino_language_server',
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
  'cssmodules_ls',
  'cypher_ls',
  'dartls',
  'docker_compose_language_service',
  'dockerls',
  'dotls',
  'elixirls',
  'elmls',
  'ember',
  'erg_language_server',
  'erlangls',
  'eslint',
  'fortls',
  'futhark_lsp',
  'gdscript',
  'gleam',
  'gopls',
  'graphql',
  'html',
  'jinja_lsp',
  'jqls',
  'jsonls',
  'kotlin_language_server',
  'lua_ls',
  'm68k',
  'mint',
  'nginx_language_server',
  'nomad_lsp',
  'nushell',
  'openscad_lsp',
  'postgres_lsp',
  'powershell_es',
  'prismals',
  'prolog_ls',
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
  'stylelint_lsp',
  'svelte',
  'tailwindcss',
  'terraformls',
  'texlab',
  'turtle_ls',
  'uiua',
  'v_analyzer',
  'vacuum',
  'vala_ls',
  'verible',
  'veryl_ls',
  'vimls',
  'vls',
  'vtsls',
  'vue_ls',
  'yamlls',
  'yls',
  'zls',
}

vim.list_extend(LSP_SERVERS, mason_packages)

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
      ensure_installed = vim.list_extend(
        {
          'haskell-debug-adapter',
        },
        mason_packages
      ),
      run_on_start = false,
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    opts = {},
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    branch = 'main',
  },
  {
    'andymass/vim-matchup',
    opts = {
      treesitter = {
        stopline = 500,
      }
    },
  },
  { 'RRethy/vim-illuminate' },
  { 'nvim-treesitter/nvim-treesitter-context' },
  { 'windwp/nvim-ts-autotag', opts = {} },
  {
    'Wansmer/treesj',
    keys = { '<space>m', '<space>j', '<space>s' },
    opts = {},
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
    "ibhagwan/fzf-lua",
    keys = { "<C-e>", "<C-p>" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local fzf = require("fzf-lua")
      local actions = fzf.actions

      local function enter_or_qf(selected, opts)
        if #selected > 1 then
          actions.file_sel_to_qf(selected, opts)
          vim.cmd("copen")
        else
          actions.file_edit(selected, opts)
        end
      end

      return {
        keymap = {
          builtin = {
            ["<Esc>"] = "hide",
          },
          fzf = {
            ["ctrl-a"] = "toggle-all",
            ["ctrl-q"] = "select-all+accept",
          },
        },

        actions = {
          files = {
            ["enter"] = enter_or_qf,
            ["ctrl-s"] = actions.file_split,
            ["ctrl-v"] = actions.file_vsplit,
            ["ctrl-t"] = actions.file_tabedit,
          },
        },

        fzf_opts = {
          ["--layout"] = "reverse",
          ["--height"] = "100%",
        },
      }
    end,
    config = function(_, opts)
      local fzf = require("fzf-lua")
      fzf.setup(opts)

      set_keys({
        { "", "<C-p>", bind(fzf.files) },
        { "", "<C-e>", bind(fzf.live_grep_native) },
      })
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
          '^\\.git$',
        },
      },
    },
    config = function(_, opts)
      require('nvim-tree').setup(opts)
      local nvim_tree_api = require('nvim-tree.api')

      set_keys({
        { 'n', '<esc>', nvim_tree_api.tree.close },
        { 'n', '<C-n>', nvim_tree_api.tree.toggle },
        { 'n', '<C-f>', bind(nvim_tree_api.tree.find_file, { open = true, focus = true }) }
      })
    end,
  },
  {
    'mfussenegger/nvim-dap',
    keys = { "<F5>", "<F10>", "<F12>" },
    opts = {},
  },
  {
    'tpope/vim-dadbod',
    cmd = { "DB", "DBUI", "DBExecute" },
  },
  {
    'NMAC427/guess-indent.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {},
  },
  {
    'hiphish/rainbow-delimiters.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown', 'quarto' },
    opts = {
      completions = {
        lsp = {
          enabled = true,
        },
      },
    },
  },
  {
    'michaelb/sniprun',
    build = 'bash install.sh',
    cmd = { "SnipRun", "SnipInfo", "SnipReset" },
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
    'andrewferrier/debugprint.nvim',
    dependencies = {
      'nvim-mini/mini.hipatterns',
    },
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
          svelte = js_like,
        },
      }
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        'lazy.nvim',
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
      enabled = function(root_dir)
        return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
      end,
    },
  },
  {
    'saghen/blink.cmp',
    version = '^1.7.0',
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      'rafamadriz/friendly-snippets',
      'alexandre-abrioux/blink-cmp-npm.nvim',
      {
        'tamago324/cmp-zsh',
        dependencies = {
          {
            'saghen/blink.compat',
            version = '*',
            lazy = true,
            opts = {},
          },
        },
      },
      {
        'fang2hou/blink-copilot',
        dependencies = { 'zbirenbaum/copilot.lua' },
      },
    },
    opts = {
      keymap = {
        preset = 'enter',
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
      signature = { enabled = true },
      completion = { documentation = { auto_show = true } },
      cmdline = {
        completion = { menu = { auto_show = true } },
      },
      sources = {
        default = { 'lazydev', 'copilot', 'lsp',  'buffer', 'snippets', 'path' },
        per_filetype = {
          zsh = { inherit_defaults = true, 'zsh' },
          json = { inherit_defaults = true, 'npm' },
        },
        providers = {
          copilot = {
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
          },
          zsh = {
            name = 'zsh',
            module = 'blink.compat.source',
          },
          npm = {
            module = 'blink-cmp-npm',
            async = true,
            opts = {
              only_latest_version = true,
            }
          },
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },
    },
    opts_extend = { 'sources.default' }
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
    build = 'make tiktoken',
    opts = {},
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'yioneko/nvim-vtsls',
      {
        'b0o/schemastore.nvim',
        lazy = true,
      },
    },
    config = function()
      vim.lsp.config('*', {
        on_attach = function(_, bufferNum)
          local lsp_key_opts = {
            noremap = true,
            silent = true,
            buffer = bufferNum,
          }

          set_keys({
            {'n', 'gD', vim.lsp.buf.declaration, lsp_key_opts},
            {'n', 'gd', vim.lsp.buf.definition, lsp_key_opts},
            {'n', 'gi', vim.lsp.buf.implementation, lsp_key_opts},
            {'n', '<space>D', vim.lsp.buf.type_definition, lsp_key_opts},
            {'n', '<C-k>', vim.lsp.buf.signature_help, lsp_key_opts},
            {'n', 'gr', vim.lsp.buf.rename, lsp_key_opts},
            {'n', 'ga', vim.lsp.buf.code_action, lsp_key_opts},
            {'n', 'gR', vim.lsp.buf.references, lsp_key_opts},
            {'n', 'gl', vim.lsp.codelens.run, lsp_key_opts},
            {'n', 'gf', bind(vim.lsp.buf.format, { async = true }), lsp_key_opts},
          })
        end,
      })

      vim.lsp.config('verible', {
        cmd = { 'verible-verilog-ls', '--rules_config_search' },
      })

      vim.lsp.config('eslint', {
        settings = {
          useESLintClass = true,
        },
      })

      local lspconfig = require('lspconfig')

      vim.lsp.config('ansiblels', {
        root_dir = lspconfig.util.root_pattern('playbook.yml'),
        single_file_support = true
      })

      vim.lsp.config('jsonls', {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      })

      vim.lsp.config('ember', {
        init_options = {
          editor = 'vscode',
        },
        root_dir = lspconfig.util.root_pattern('ember-cli-build.js', 'ember-cli-build.mjs'),
      })

      vim.lsp.config('arduino_language_server', {
        cmd = {
          'arduino-language-server',
          '-cli-config', '/Users/jacob/Library/Arduino15/arduino-cli.yaml',
        }
      })

      vim.lsp.config('stylelint_lsp', {
        filetypes = { 'css', 'less', 'scss', 'sugarss', 'wxss' },
      })

      vim.lsp.config('elixirls', {
        cmd = { 'elixir-ls' },
      })

      vim.lsp.config('powershell_es', {
        bundle_path = '/Users/jacob/.powershell',
      })

      vim.lsp.config('yamlls', {
        opts = function()
          return {
            yaml = {
              schemaStore = {
                enable = false,
                url = '',
              },
              keyOrdering = false,
              schemas = require('schemastore').yaml.schemas(),
            },
          }
        end,
      })

      vim.lsp.config('html', {
        filetypes = {
          'glimmer',
          'handlebars',
          'hbs',
          'html',
          'javascript.glimmer',
          'javascript.jsx',
          'javascriptreact',
          'jsx',
          'rescript',
          'svelte',
          'tsx',
          'typescript.tsx',
          'typescriptreact',
          'vue',
        },
      })

      vim.lsp.config('cssls', {
        settings = {
          css = {
            validate = false,
          },
        },
      })

      vim.lsp.config('gopls', {
        settings = {
          staticcheck = true,
          gofumpt = true,
        },
      })

      require('lspconfig.configs').vtsls = require('vtsls').lspconfig
      require('lspconfig.configs').svelte = require('vtsls').lspconfig

      vim.lsp.config('svelte', {
        init_options = {
          configuration = jsLikeOptions,
        }
      })

      vim.lsp.config('vtsls', {
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
        settings = jsLikeOptions,
      })

      for _, lsp in ipairs(LSP_SERVERS) do
        vim.lsp.enable(lsp)
      end
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
    config = function(_, opts)
      local nvim_test = require('nvim-test')
      nvim_test.setup(opts)

      set_keys({
        { '', '<C-t>', bind(nvim_test.run, 'nearest') },
      })
    end,
  },
  {
    'mfussenegger/nvim-lint',
    config = function()
      local lint = require('lint')

      lint.linters_by_ft = {
        cpp = { 'cppcheck' },
        dockerfile = { 'hadolint' },
        elixir = { 'credo' },
        make = { 'checkmake' },
        php = { 'phpstan' },
        vim = { 'vint' },
      }

      local link_group = augroup('UserIndent', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        group = link_group,
        callback = bind(lint.try_lint),
      })
    end,
  },
  {
    'dmmulroy/ts-error-translator.nvim',
    opts = {},
  },
  {
    'scalameta/nvim-metals',
    ft = { "scala", "sbt" },
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'mrcjkb/rustaceanvim',
    version = '*',
    ft = 'rust',
    opts = {},
  },
  {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
    config = function()
      require('jdtls').start_or_attach({
        cmd = { '/opt/homebrew/opt/jdtls/bin/jdtls' },
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
    init = function()
      vim.g.haskell_tools = {
        hls = {
          on_attach = function(_, bufnr, ht)
            local opts = vim.tbl_extend('keep', { noremap = true, silent = true }, { buffer = bufnr, })
            set_keys({
              { 'n', '<space>ca', vim.lsp.codelens.run, opts },
              { 'n', '<space>ea', ht.lsp.buf_eval_all, opts },
            })
          end,
        },
      }
    end,
  },
  {
    'TamaMcGlinn/nvim-lspconfig-ada',
    ft = 'ada',
  },
  {
    'apple/pkl-neovim',
    lazy = true,
    ft = 'pkl',
    config = function()
      vim.g.pkl_neovim = {
        start_command = { 'pkl-lsp' },
        pkl_cli_path = '/opt/homebrew/bin/pkl',
      }
    end,
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
    'Mofiqul/dracula.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent_bg = true,
    },
    config = function(_, opts)
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

