return {
  -- 1. Mason：依然用来在后台帮你下载和管理 LSP 二进制文件
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = {
          icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" }
        }
      })
    end,
  },

  -- 2. Mason-lspconfig：仅仅用来实现“自动下载”功能，不再接管配置
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",     -- Lua
          "pyright",    -- Python
          "ts_ls",      -- TypeScript/JS
          -- "gopls",      -- Go
          "jsonls",     -- JSON
        },
        automatic_installation = true,
      })
    end,
  },

  -- 3. Nvim-lspconfig：使用 Neovim 0.11+ 的全新原生 API
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()

      -- [可选] 如果你需要对某个 LSP 进行特殊定制，使用 vim.lsp.config
      -- 例如：为 lua_ls 消除 "Undefined global 'vim'" 的警告
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } }
          }
        }
      })

      -- 🔥 核心：使用 vim.lsp.enable() 启动你的语言服务器
      -- 这取代了以前复杂的 setup 和 setup_handlers
      local servers = { "lua_ls", "pyright", "ts_ls", "gopls", "jsonls" }
      for _, server in ipairs(servers) do
        vim.lsp.enable(server)
      end

      -- 🔥 配置快捷键（当 LSP 成功附加到文件时触发）
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }

          -- 基础跳转
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)       -- 跳转到定义
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)       -- 查找引用
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)             -- 悬浮文档提示

          -- 重命名与代码重构
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)   -- 变量重命名
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts) -- 代码动作

          -- 格式化
          vim.keymap.set('n', '<leader>lf', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
    end,
  }
}
