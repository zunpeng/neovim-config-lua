-- 如果最后一个窗口是NvimTree ，则自动关闭
-- vim.cmd(
--     [[
--         autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'NvimTree') | q | endif
--     ]]
-- )

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*',
    callback = function()
        if vim.fn.winnr('$') == 1 and vim.bo.filetype == 'NvimTree' then
        vim.cmd('q')
        end
        if vim.fn.exists(":NvimTreeFindFile") == 1 then
            vim.cmd("NvimTreeFindFile")  -- 定位当前文件
        end
    end
})

return {
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        -- git = {
        --     enable = true,  -- 启用Git集成
        --     ignore = false,  -- 不忽略Git忽略的文件
        --     timeout = 400,  -- Git操作超时时间(ms)
        -- },
        -- renderer = {
        --     indent_width = 2,  -- 缩进宽度
        --     group_empty = true,  -- 空目录分组
        --     icons = {
        --         show = {
        --             file = true,  -- 显示文件图标
        --             folder = true,  -- 显示文件夹图标
        --             git = true,  -- 显示Git状态图标
        --         },
        --     },
        -- },

        config = function()
            local function my_on_attach(bufnr)
                local api = require "nvim-tree.api"

                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end
                -- default mappings
                api.config.mappings.default_on_attach(bufnr)
                -- custom mappings
                vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))  -- 打开当前文件，同时跳回到窗口
                vim.keymap.set('n', 'L', api.node.open.preview, opts('Open Preview'))   -- 打开当前文件，但不跳转到编辑窗口
                vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))   -- 关闭当前目录
                vim.keymap.set('n', 'K', api.tree.change_root_to_parent, opts('Up'))    -- 打开上父级
                vim.keymap.set('n', 'J', api.tree.change_root_to_node, opts('CD'))    -- 定位当前节点为根节点 默认Ctrl+]
            end
            require("nvim-tree").setup {
                on_attach = my_on_attach,
            }
        end
    }
}

