return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        mappings = {
          -- 插入模式下 Alt+j/k 上下选择
          i = {
            ["<M-j>"] = actions.move_selection_next,
            ["<M-k>"] = actions.move_selection_previous,
            ["<CR>"] = actions.select_default,
          },
          -- 普通模式下 Alt+j/k 上下选择
          n = {
            ["<M-j>"] = actions.move_selection_next,
            ["<M-k>"] = actions.move_selection_previous,
            ["<CR>"] = actions.select_default,
          },
        },
      },
    })
  end,
}
