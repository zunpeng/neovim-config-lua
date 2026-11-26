-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- 自定义模式
local mode_nv = { "n", "v" }
local mode_n = { "n" }
local mode_v = { "v" }
local mode_i = { "i" }

local mappings = {
    -----------------------noremap----------------------------
    -- 打开配置文件
    { from = '<Leader>fc', to = ':e ~/AppData/Local/nvim/lua/base.lua<CR>' },
    -- 保存文件
    { from = '<Leader>fs', to = ':w<CR>' },
    -- 转换为unix/linux格式文件
    { from = '<Leader>ftu', to = ':set ff=unix<CR>' },
    -- 转换为dos(windows)格式文件
    { from = '<Leader>ftd', to = ':set ff=dos<CR>' },
    -- 检查当前文件是什么格式
    { from = '<Leader>ft?', to = ':set ff?<CR>' },
    -- 检查当前文件编码格式
    { from = '<Leader>fe?', to = ':set encoding?<CR>' },
    -- 转换为utf8
    { from = '<Leader>feu', to = ':set encoding=UTF-8<CR>' },
    -- WhichKey 激活快捷键
    { from = '<Leader>', to = ':WhichKey""<CR>' },
    -- 替换数字加减
    { from = '+', to = '<C-a>' },
    { from = '-', to = '<C-x>' },
    -- 退出所有窗口
    { from = '<Leader>qa', to = ':qall<CR>' },
    -- 强制关闭当前窗口
    { from = '<Leader>qf', to = ':q!<CR>' },
    -- 关闭当前窗口
    { from = '<Leader>qq', to = ':q<CR>' },
    { from = 'Q', to = ':q<CR>' },
    -- 关闭当前窗口的左侧窗口
    { from = '<Leader>qh', to = '<C-w>h:q<CR>' },
    -- 关闭当前窗口的下方窗口
    { from = '<Leader>qj', to = '<C-w>j:q<CR>' },
    -- 关闭当前窗口的上方窗口
    { from = '<Leader>qk', to = '<C-w>k:q<CR>' },
    -- 关闭当前窗口的右侧窗口
    { from = '<Leader>ql', to = '<C-w>l:q<CR>' },
    -- 光标移至行首/尾
    { from = '<C-a>', to = '<Home>' },
    { from = '<C-e>', to = '<End>' },
    -- 清除行尾空格，同时取消高亮
    { from = '<localleader>cs', to = ':%s/\\s\\+$//g<CR>:noh<CR>' },
    -- 清除^M，同时取消高亮
    { from = '<localleader>cm', to = ':%s/\\r$//g<CR>:noh<CR>' },
    -- 取消高亮
    { from = '<localleader>ch', to = ':noh<CR>' },
    -- 删除空行
    { from = '<localleader>cl', to = ':g/^$/d<CR>:noh<CR>' },
    -- 从当前字符换行
    { from = '<Leader>cj', to = 'i<CR><ESC>' },
    -- 打开/关闭目录树
    { from = '<Leader>ee', to = ':NvimTreeToggle<CR>' },

    -- ========== 新增：bufferline 标签页操作 ==========
    { from = '<Leader>th', to = '<cmd>BufferLineCyclePrev<CR>', silent = true, desc = '切换到左侧标签页' },
    { from = '<Leader>tl', to = '<cmd>BufferLineCycleNext<CR>', silent = true, desc = '切换到右侧标签页' },
    {
        from = '<Leader>tq',
        to = function()
            local bufnr = vim.api.nvim_get_current_buf()
            -- 先切换到上一个标签，再删除当前缓冲区
            -- 保证编辑窗口始终存在，避免触发 NvimTree 自动退出
            vim.cmd("BufferLineCyclePrev")
            vim.schedule(function()
                vim.cmd("bdelete " .. bufnr)
            end)
        end,
        silent = true,
        desc = '关闭当前标签页（保留窗口布局）'
    },
    -- telescope 标签列表操作
    {
    from = '<Leader>tm',
    to = '<cmd>Telescope buffers sort_mru=true select_current=true<CR>', 
    silent = true, 
    desc = '列出所有打开的标签页' 
    },

    -- ==============================================

    -- 分割窗口
    -- 向左分割,光标在当前窗口
    { from = '<localleader>wh', to = ':set splitright<CR>:vsplit<CR>' },
    -- 向下分割,光标在当前窗口
    { from = '<localleader>wj', to = ':set nosplitbelow<CR>:split<CR>:set splitbelow<CR>' },
    -- 向上分割,光标在当前窗口
    { from = '<localleader>wk', to = ':set splitbelow<CR>:split<CR>' },
    -- 向右分割,光标在当前窗口
    { from = '<localleader>wl', to = ':set nosplitright<CR>:vsplit<CR>:set splitright<CR>' },

    -- 调整窗口大小 alt + 上下左右，一次调整5单位
    { from = '<M-right>', to = '5<C-w>>' },
    { from = '<M-left>', to = '5<C-w><lt>' },
    { from = '<M-up>', to = '5<C-w>+' },
    { from = '<M-down>', to = '5<C-w>-' },

    -- 窗口大小调整（字母版，<Leader>w + 大写方向字母）
    { from = '<Leader>wH', to = '5<C-w><lt>' },
    { from = '<Leader>wL', to = '5<C-w>>' },
    { from = '<Leader>wK', to = '5<C-w>+' },
    { from = '<Leader>wJ', to = '5<C-w>-' },

    -- 切换窗口
    { from = '<Leader>wk', to = '<C-w>k' },
    { from = '<Leader>wj', to = '<C-w>j' },
    { from = '<Leader>wh', to = '<C-w>h' },
    { from = '<Leader>wl', to = '<C-w>l' },

    ------------------------------
    -- === markdown <leader>m
    --------------------------------
    -- markdown 预览开启
    { from = '<Leader>mp', to = '<Plug>MarkdownPreview', remap = true },
    -- markdown 预览关闭
    { from = '<Leader>mq', to = '<Plug>MarkdownPreviewStop', remap = true },
    -- markdown 预览切换
    { from = '<leader>mt', to = '<Plug>MarkdownPreviewToggle', remap = true },

    -----------------------noremap/vnoremap----------------------------
    -- alt+h/j/k/l 基础方向移动（普通+可视模式）
    { from = '<M-h>', to = 'h', mode = mode_nv },
    { from = '<M-j>', to = 'j', mode = mode_nv },
    { from = '<M-k>', to = 'k', mode = mode_nv },
    { from = '<M-l>', to = 'l', mode = mode_nv },

    -- Alt+Shift+H/L/J/K 跳行首/行尾/最后一行/第一行（普通+可视模式）
    { from = '<M-S-h>', to = '0', mode = mode_nv },
    { from = '<M-S-l>', to = '$', mode = mode_nv },
    { from = '<M-S-j>', to = 'G', mode = mode_nv },
    { from = '<M-S-k>', to = 'gg', mode = mode_nv },

    -- alt+w 向后5个单词 第5个词首
    { from = '<m-w>', to = '5w', mode = mode_nv },
    -- alt+e 向后5个单词 第5个词尾
    { from = '<m-e>', to = '5e' , mode = mode_nv},
    -- alt+b 向前5个单词,第5个词首
    { from = '<m-b>', to = '5b', mode = mode_nv },
    -- ctrl+h 向左5个字符
    { from = '<C-h>', to = '5h', mode = mode_nv },
    -- ctrl+j 向下5行
    { from = '<C-j>', to = '5j', mode = mode_nv },
    -- ctrl+k 向上5行
    { from = '<C-k>', to = '5k', mode = mode_nv },
    -- ctrl+l 向右5个字符
    { from = '<C-l>', to = '5l', mode = mode_nv },

    -----------------------vnoremap----------------------------
    -- 系统剪贴板复制/粘贴
    { from = '<Leader>p', to = '"+p', mode = mode_v },
    { from = '<Leader>y', to = '"+y', mode = mode_v },

    -----------------------inoremap----------------------------
    -- 插入模式下光标上下左右移动
    { from = '<C-h>', to = '<Left>', mode = mode_i },
    { from = '<C-l>', to = '<Right>', mode = mode_i },
    { from = '<C-j>', to = '<Down>', mode = mode_i },
    { from = '<C-k>', to = '<Up>', mode = mode_i },

    -- 插入模式下跳转到行首/行尾（Ctrl+Shift+H/L）
    { from = '<C-S-h>', to = '<Esc>I', mode = mode_i },
    { from = '<C-S-l>', to = '<Esc>A', mode = mode_i },
}

-- ========== 修改：循环加载配置，新增 silent 和 desc 支持 ==========
for _, mapping in ipairs(mappings) do
    vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, {
        noremap = not mapping.remap,
        silent = mapping.silent or false,
        desc = mapping.desc or nil,
    })
end

local function run_vim_shortcut(shortcut)
    local escaped_shortcut = vim.api.nvim_replace_termcodes(shortcut, true, false, true)
    vim.api.nvim_feedkeys(escaped_shortcut, 'n', true)
end

-- close win below
-- vim.keymap.set("n", "<leader>q", function()
--     vim.cmd("TroubleClose")
--     local wins = vim.api.nvim_tabpage_list_wins(0)
--     if #wins > 1 then
--         run_vim_shortcut([[<C-w>j:q<CR>]])
--     end
-- end, { noremap = true, silent = true })
