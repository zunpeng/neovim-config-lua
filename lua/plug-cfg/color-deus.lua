-- deus 主题（替换你原文件中注释的 deus 段落即可）
return {
    "ajmwagar/vim-deus",
    lazy = false,
    priority = 1000,
    config = function()
        -- 确保真彩色开启（你已在全局设置，此处冗余保证主题加载时生效）
        vim.opt.termguicolors = true
        -- 强制暗色模式
        vim.opt.background = "dark"

        -- Deus 官方标准 16 色终端配色（作用于 Neovim 内置 :terminal）
        vim.g.terminal_color_0  = '#242a32'  -- Black
        vim.g.terminal_color_1  = '#d54e53'  -- Red
        vim.g.terminal_color_2  = '#98c379'  -- Green
        vim.g.terminal_color_3  = '#e5c07b'  -- Yellow
        vim.g.terminal_color_4  = '#83a598'  -- Blue
        vim.g.terminal_color_5  = '#c678dd'  -- Magenta (Purple)
        vim.g.terminal_color_6  = '#70c0ba'  -- Cyan (Teal)
        vim.g.terminal_color_7  = '#eaeaea'  -- White
        vim.g.terminal_color_8  = '#666666'  -- Bright Black
        vim.g.terminal_color_9  = '#ec3e45'  -- Bright Red
        vim.g.terminal_color_10 = '#90c966'  -- Bright Green
        vim.g.terminal_color_11 = '#edbf69'  -- Bright Yellow
        vim.g.terminal_color_12 = '#73ba9f'  -- Bright Blue
        vim.g.terminal_color_13 = '#c858e9'  -- Bright Magenta
        vim.g.terminal_color_14 = '#2bcec2'  -- Bright Cyan
        vim.g.terminal_color_15 = '#ffffff'  -- Bright White

        -- 可选：开启斜体（需你的终端支持斜体，不需要可注释掉）
        -- vim.g.deus_italic = 1

        -- 加载主题
        vim.cmd([[colorscheme deus]])

        -- 细节高亮微调：优化行号、不可见字符对比度，更适配深夜编码
        vim.cmd([[
            hi NonText    guifg=#3a4049  ctermfg=darkgray
            hi LineNr     guifg=#545861  ctermfg=gray
            hi CursorLineNr guifg=#eaeaea gui=bold
        ]])
    end,
}
