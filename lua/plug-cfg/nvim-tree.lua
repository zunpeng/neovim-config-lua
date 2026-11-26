-- 如果最后一个窗口是NvimTree，则自动关闭
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*',
    callback = function()
        -- 原有逻辑：只剩文件树窗口时自动退出
        local wins = vim.api.nvim_list_wins()
        local only_tree = true
        for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].filetype ~= 'NvimTree' then
                only_tree = false
                break
            end
        end
        if only_tree and #wins >= 1 then
            vim.cmd('q')
            return
        end

        -- ========== 核心修复：NvimTree 自身缓冲区直接跳过 ==========
        if vim.bo.filetype == 'NvimTree' then
            return
        end
        -- ========================================================

        -- 智能定位 + 自动切根
        local ok, api = pcall(require, 'nvim-tree.api')
        if not ok then return end
        if not api.tree.is_visible() then return end

        -- 获取当前文件绝对路径，空缓冲区/新建未保存文件直接跳过
        local file_path = vim.fn.expand('%:p')
        if file_path == '' then return end
        file_path = file_path:gsub('\\', '/')

        -- 获取 nvim-tree 当前根目录
        local core = require('nvim-tree.core')
        local root_dir = core.get_cwd()
        if not root_dir then return end
        root_dir = root_dir:gsub('\\', '/')

        -- 判断当前文件是否在现有根目录内
        local is_inside = vim.startswith(file_path, root_dir .. '/')

        if is_inside then
            -- 在目录内：只定位高亮，不切换根目录
            api.tree.find_file({
                buf = 0,
                open = false,
                focus = false,
            })
        else
            -- 不在目录内：自动切换根目录到文件所在目录，再定位
            local file_dir = vim.fn.expand('%:p:h'):gsub('\\', '/')
            api.tree.change_root(file_dir)
            api.tree.find_file({
                buf = 0,
                open = false,
                focus = false,
            })
        end
    end
})

return {
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        config = function()
            local function my_on_attach(bufnr)
                local api = require "nvim-tree.api"

                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end
                api.config.mappings.default_on_attach(bufnr)
                -- 自定义快捷键
                vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
                vim.keymap.set('n', 'L', api.node.open.preview, opts('Open Preview'))
                vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
                vim.keymap.set('n', 'K', api.tree.change_root_to_parent, opts('Up'))
                vim.keymap.set('n', 'J', api.tree.change_root_to_node, opts('CD'))
            end

            require("nvim-tree").setup {
                on_attach = my_on_attach,
                -- 关闭原生自动跟随，使用自定义的智能判断逻辑
                update_focused_file = {
                    enable = false,
                },
            }

            -- 方案二，使用原生实现文件在根内只定位，不在则切根
            -- require("nvim-tree").setup {
            --     on_attach = my_on_attach,
            --     update_focused_file = {
            --         enable = true,
            --         update_root = true, -- 文件不在根目录时自动切根，在则只定位
            --         ignore_list = {},
            --     },
            -- }
        end
    }
}
