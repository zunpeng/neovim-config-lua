-- 当前配置已废弃，可以删除，使用bufferline.lua配置
return {
    'akinsho/bufferline.nvim',
    version = "*",
    -- nvim-tree插件也依赖于nvim-web-devicons 这里便注释掉即可
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        options = {
            mode = "tabs",
            diagnostics = "nvim_lsp",
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                local icon = level:match("error") and " " or " "
                return " " .. icon .. count
            end,
            indicator = {
                icon = '▎', -- this should be omitted if indicator style is not 'icon'
                -- style = 'icon' | 'underline' | 'none',
                style = "icon",
            },
            show_buffer_close_icons = false,
            show_close_icon = false,
            enforce_regular_tabs = true,
            show_duplicate_prefix = false,
            tab_size = 16,
            padding = 0,
            separator_style = "thick",
        }
    }
}

