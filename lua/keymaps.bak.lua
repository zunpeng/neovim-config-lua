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
    -- 替换数字加减（后面的Ctrl+a换成了移动光标到行首）
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
    --  打开/关闭目录树
    { from = '<Leader>ee', to = ':NvimTreeToggle<CR>' },
    --{ from = '<Leader>ee', to = ':NvimTreeOpen<CR>' },
    --{ from = '<Leader>ec', to = ':NvimTreeClose<CR>' },
    -- 分割窗口
    -- 向左分割,光标在当前窗口
    { from = '<localleader>wh', to = ':set splitright<CR>:vsplit<CR>' },
    -- 向下分割,光标在当前窗口
    { from = '<localleader>wj', to = ':set nosplitbelow<CR>:split<CR>:set splitbelow<CR>' },
    -- 向上分割,光标在当前窗口
    { from = '<localleader>wk', to = ':set splitbelow<CR>:split<CR>' },
    -- 向右分割,光标在当前窗口
    { from = '<localleader>wl', to = ':set nosplitright<CR>:vsplit<CR>:set splitright<CR>' },
    -- 调整窗口大小(有分割窗口时) alt + 上下左右
    -- { from = '<M-right>', to = '<C-w>>' },
    -- { from = '<M-left>', to = '<C-w><' },
    -- { from = '<M-up>', to = '<C-w>-' },
    -- { from = '<M-down>', to = '<C-w>+' },
    -- 调整窗口大小(有分割窗口时) alt + 上下左右，一次调整5单位
    { from = '<M-right>', to = '5<C-w>>' },
    { from = '<M-left>', to = '5<C-w><lt>' },  -- 修复原左调整不生效的问题
    { from = '<M-up>', to = '5<C-w>+' },
    { from = '<M-down>', to = '5<C-w>-' },
    -- 窗口大小调整（字母版，<Leader>w + 大写方向字母）
    { from = '<Leader>wH', to = '5<C-w><lt>' },  -- 窗口向左收缩（宽度减少）
    { from = '<Leader>wL', to = '5<C-w>>' },     -- 窗口向右扩展（宽度增加）
    { from = '<Leader>wK', to = '5<C-w>+' },     -- 窗口向上扩展（高度增加）
    { from = '<Leader>wJ', to = '5<C-w>-' },     -- 窗口向下收缩（高度减少）
    -- 切换窗口
    { from = '<Leader>wk', to = '<C-w>k' },
    { from = '<Leader>wj', to = '<C-w>j' },
    { from = '<Leader>wh', to = '<C-w>h' },
    { from = '<Leader>wl', to = '<C-w>l' },
    ------------------------------
    -- === markdowm <leader>m
    --------------------------------
    -- markdown 预览开启
    { from = '<Leader>mp', to = '<Plug>MarkdownPreview' },
    -- markdown 预览关闭 quit
    { from = '<Leader>mq', to = '<Plug>MarkdownPreviewStop' },
    -- markdown预览(开启或关闭),MarkdownPreview与MarkdownPreviewStop是一对
    -- MarkdownPreviewToggle开启后再执行则会关闭当前预览的页面
    -- 而MarkdownPreview每执行一次会打开一个预览页面,必须使用MarkdownPreviewStop来关闭
    { from = '<leader>mt', to = '<Plug>MarkdownPreviewToggle' },
    -----------------------noremap/vnoremap----------------------------
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
    -- ctrl+h 向右5个字符
    { from = '<C-l>', to = '5l', mode = mode_nv },
    -----------------------vnoremap----------------------------
    -- 复制/粘贴
    { from = '<Leader>p', to = '"+p', mode = mode_v },
    { from = '<Leader>y', to = '"+y', mode = mode_v },
    -----------------------inoremap----------------------------
    -- 插入模式下光标上下左右移动
    { from = '<C-h>', to = '<Left>', mode = mode_i },
    { from = '<C-l>', to = '<Right>', mode = mode_i },
    { from = '<C-j>', to = '<Down>', mode = mode_i },
    { from = '<C-k>', to = '<Up>', mode = mode_i },
    -- 插入模式下shift+回车向下插入空行，并跳转到插入的空行
    -- TODO 插入空行在lua中 shift + enter 不能用，暂时没有解决办法
    -- { from = '<S-CR>', to = '<Esc>o', mode = mode_i },
    -- { from = '<C-S-CR>', to = '<Esc>O', mode = mode_i },
    -- 跳转到行首/行尾
    { from = '<M-l>', to = '<Esc>A', mode = mode_i },
    { from = '<M-h>', to = '<Esc>I', mode = mode_i },
    { from = '<M-l>', to = '<Esc>$' },
    { from = '<M-h>', to = '<Esc>0' },
}
--vim.keymap.set("i", "<S-CR>", "<Esc>o", { noremap = true })
-- vim.keymap.set("n", "q", "<nop>", { noremap = true })
-- vim.keymap.set("n", ",q", "q", { noremap = true })
-- 循环加载配置
for _, mapping in ipairs(mappings) do
    vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, { noremap = true })
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
