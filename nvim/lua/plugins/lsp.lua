return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    {
      'mason-org/mason.nvim', -- Must be loaded before dependants
      ---@module 'mason.settings'
      ---@type MasonSettings
      ---@diagnostic disable-next-line: missing-fields
      opts = {}
    }, 
    -- mason-lspconfig:
    -- - Bridges the gap between LSP config names (e.g. "lua_ls") and actual Mason package names (e.g. "lua-language-server").
    -- - Used here only to allow specifying language servers by their LSP name (like "lua_ls") in `ensure_installed`.
    -- - It does not auto-configure servers — we use vim.lsp.config() + vim.lsp.enable() explicitly for full control.
    'mason-org/mason-lspconfig.nvim',
    -- mason-tool-installer:
    -- - Installs LSPs, linters, formatters, etc. by their Mason package name.
    -- - We use it to ensure all desired tools are present.
    -- - The `ensure_installed` list works with mason-lspconfig to resolve LSP names like "lua_ls".
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP.
    {
      'j-hui/fidget.nvim',
      opts = {
        notification = {
          window = {
            winblend = 0, -- Background color opacity in the notification window
          },
        },
      },
    },
  },

  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        -- Create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end
        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('gca', vim.lsp.buf.code_action, '[G]oto [C]ode [A]ction', { 'n', 'x' })

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    -- Enable the following language servers
    --
    -- Add any additional override configuration in the following tables. Available keys are:
    -- - cmd (table): Override the default command used to start the server
    -- - filetypes (table): Override the default list of associated filetypes for the server
    -- - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    -- - settings (table): Override the default settings passed when initializing the server.
    ---@type table<string, vim.lsp.Config>
    local servers = {
      ts_ls = {},
      ruff = {},
      pylsp = {
        settings = {
          pylsp = {
            plugins = {
              pyflakes = { enabled = false },
              pycodestyle = { enabled = false },
              autopep8 = { enabled = false },
              yapf = { enabled = false },
              mccabe = { enabled = false },
              pylsp_mypy = { enabled = false },
              pylsp_black = { enabled = false },
              pylsp_isort = { enabled = false },
            },
          },
        },
      },
      html = { filetypes = { 'html', 'twig', 'hbs' } },
      cssls = {},
      tailwindcss = {},
      dockerls = {},
      sqlls = {},
      terraformls = {},
      jsonls = {},
      yamlls = {},
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file('', true),
            },
            diagnostics = {
              globals = { 'vim' },
              disable = { 'missing-fields' },
            },
            format = {
              enable = false,
            },
          },
        },
      },
    }

    -- Ensure the servers and tools above are installed
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format Lua code
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    for server, cfg in pairs(servers) do
      vim.lsp.config(server, cfg)
      vim.lsp.enable(server)
    end
  end,
}
