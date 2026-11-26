return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
  config = function()
    vim.opt.showtabline = 2

    require("bufferline").setup({
      options = {
        mode = "buffers",
        themable = true,
        separator_style = "thin",
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        offsets = {
          {
            filetype = "NvimTree",
            text = "目录",
            highlight = "Directory",
            text_align = "left",
          },
        },
        show_buffer_icons = true,
        show_close_icon = true,
        buffer_close_icon = "󰅖",
        close_icon = "",
        modified_icon = "●",
      },
    })
  end,
}
