return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons'
  },
  ft = { 'markdown', 'quarto' },
  config = function()
    -- ====================== 渲染核心配置 ======================
    require('render-markdown').setup({
      anti_conceal = { enabled = true },
      win_options = { spell = { rendered = false } },
      indent = { enabled = false },
      heading = {
        enabled = true,
        render_modes = false,
        atx = true,
        setext = true,
        sign = true,
        icons = { 'H1 ', 'H2 ', 'H3 ', 'H4 ', 'H5 ', 'H6 ' },
        position = 'overlay',
        signs = { '󰫎 ' },
        width = 'full',
        left_margin = 0,
        left_pad = 0,
        right_pad = 0,
        min_width = 0,
        border = false,
        border_virtual = false,
        border_prefix = false,
        above = '▄',
        below = '▀',
        backgrounds = {
          'RenderMarkdownH1Bg', 'RenderMarkdownH2Bg', 'RenderMarkdownH3Bg',
          'RenderMarkdownH4Bg', 'RenderMarkdownH5Bg', 'RenderMarkdownH6Bg',
        },
        foregrounds = {
          'RenderMarkdownH1', 'RenderMarkdownH2', 'RenderMarkdownH3',
          'RenderMarkdownH4', 'RenderMarkdownH5', 'RenderMarkdownH6',
        },
        custom = {},
      },
    })

    -- ====================== 任务列表循环切换逻辑 ======================
    local function toggle_task()
      local line = vim.api.nvim_get_current_line()
      local cursor_col = vim.api.nvim_win_get_cursor(0)[2]
      local new_line = nil
      local offset = 0

      -- 1. 已勾选任务 → 转为未勾选
      local indent, content = line:match('^(%s*)[-*+] %[[xX]%] (.*)')
      if indent then
        new_line = indent .. '- [ ] ' .. content
        offset = 0
      end

      -- 2. 未勾选任务 → 转为已勾选
      if not new_line then
        indent, content = line:match('^(%s*)[-*+] %[ %] (.*)')
        if indent then
          new_line = indent .. '- [x] ' .. content
          offset = 0
        end
      end

      -- 3. 普通无序列表 → 转为未勾选任务（替换前缀，不叠加）
      if not new_line then
        indent, content = line:match('^(%s*)[-*+] (.*)')
        if indent then
          new_line = indent .. '- [ ] ' .. content
          offset = 4
        end
      end

      -- 4. 普通文本 → 转为未勾选任务
      if not new_line then
        indent, content = line:match('^(%s*)(.*)')
        new_line = indent .. '- [ ] ' .. content
        offset = 6
      end

      vim.api.nvim_set_current_line(new_line)
      vim.api.nvim_win_set_cursor(0, {
        vim.api.nvim_win_get_cursor(0)[1],
        math.max(0, cursor_col + offset)
      })
    end

    -- ====================== 快捷键绑定 ======================
    local function setup_keymaps()
      vim.keymap.set('n', '<C-m>', toggle_task, {
        buffer = 0,
        desc = 'Markdown: 循环切换任务列表状态',
        noremap = true,
        silent = true,
      })
    end

    -- 插件加载时立即为当前缓冲区绑定（解决懒加载时机问题）
    local ft = vim.bo.filetype
    if ft == 'markdown' or ft == 'quarto' then
      setup_keymaps()
    end

    -- 为后续新打开的文件注册自动绑定
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { 'markdown', 'quarto' },
      callback = setup_keymaps,
    })
  end,
}
