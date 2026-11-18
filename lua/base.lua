-- vim.o.guifont='JetBrainsMono Nerd Font Mono:h11' -- 设置字体
vim.o.guifont='Maple Mono NL NF CN:h11' -- 设置字体
vim.g.encoding = "UTF-8"    -- 设置编码utf8

-- 文件格式，默认 ffs=dos,unix
vim.o.fileformat='unix'
vim.o.fileformats='unix,dos,mac'
vim.o.fileencoding = "utf-8"
vim.o.scrolloff = 5   -- 光标上下移动时，光标距离顶部/底部保留的行数
vim.o.sidescrolloff = 15  -- 光标左右移动时，光标距离行首/行尾保留的字符（列）数a（该配置不拆迁时比较有用）
-- 样式
-- vim.o.background = "dark"
-- vim.o.termguicolors = true
-- vim.opt.termguicolors = true
-- 启用鼠标
vim.o.mouse = "a"
vim.o.selection = "exclusive"
vim.o.selectmode = "mouse,key"

vim.opt.clipboard:append('unnamedplus')

vim.o.number = true   -- 设置开启行号
vim.o.relativenumber = true   --相对行号
-- 设置tab 为4个空格
vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftround = true
vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4
-- tab以空格替换
vim.o.expandtab = true
vim.bo.expandtab = true

vim.wo.cursorline = true    --高亮所在行
--vim.wo.cursorcolumn = true  -- 高亮所在列
-- 关闭警告音
vim.o.errorbells = false
vim.o.visualbell = true
vim.g.v_vb = " "

-- 自动缩进，新行对齐到当前行
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true

-- 搜索大小写不敏感，除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true

-- 搜索实时匹配
vim.o.incsearch = true
-- 搜索高亮，默认是true
vim.o.hlsearch = true

-- 复制时文本高亮
vim.api.nvim_create_autocmd("TextYankPost",{
    callback=function()
    vim.highlight.on_yank({
        higroup="IncSearch",
        timeout=300
    })
    end
})

-- 命令行高为2，提供足够的显示空间
-- vim.o.cmdheight = 2

-- 当文件被外部程序修改时，自动加载
vim.o.autoread = true
vim.bo.autoread = true

vim.wo.wrap = false -- 禁止折行
vim.o.whichwrap = '<,>,[,]' -- 光标在行首尾时<Left><Right>可以跳到下一行
vim.o.hidden = true -- 允许隐藏被修改过的buffer
-- vim.o.backup = false -- 禁止创建备份文件
-- vim.o.writebackup = false
-- vim.o.swapfile = false

-- smaller updatetime
-- vim.o.updatetime = 300
-- 设置 timeoutlen 为等待键盘快捷键连击时间500毫秒，可根据需要设置
-- vim.o.timeoutlen = 500
-- split window 从下边和右边出现

vim.o.splitbelow = true
vim.o.splitright = true
vim.g.completeopt = "menu,menuone,noselect,noinsert" -- 自动补全不自动选中
--
-- 不可见字符的显示，这里只把空格显示为一个点 关闭后，后面的opt.listchars也就不生效了
-- 注意 `vim.o` 只接受字符串；只有 `vim.opt` 才支持直接传 table
vim.opt.list = false
--vim.o.listchars = "space:·"
vim.opt.listchars = {
  tab = "▸ ",
  trail = "·", -- 尾随空格
  -- space = "-",  -- 删掉这一行！就不会把普通空格画成横线
  extends = "›",
  precedes = "‹",
  nbsp = "␣",
}


-- Dont' pass messages to |ins-completin menu|
vim.o.shortmess = vim.o.shortmess .. 'c'

vim.o.pumheight = 10 -- 补全最多显示10行
vim.o.showtabline = 2 -- 永远显示 tabline
vim.o.wildmenu = true -- 补全增强

vim.o.showmode = false -- 使用增强状态栏插件后不再需要 vim 的模式提示

vim.o.autochdir=true --自动切换到当前文件目录


vim.api.nvim_create_autocmd(
    {
        "BufRead", "BufNewFile"
    },
    {
        pattern = "*.md", command = "setlocal spell",
    }
)

vim.api.nvim_create_autocmd(
    "BufEnter",
    {
        pattern = "*", command = "silent! lcd %:p:h",
    }
)
vim.cmd(
    [[
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    ]]
)
vim.cmd(
    [[
        autocmd TermOpen term://* startinsert
    ]]
)
vim.cmd(
    [[
        augroup NVIMRC
            autocmd!
            autocmd BufWritePost .vim.lua exec ":so %"
        augroup END
        tnoremap <C-N> <C-\><C-N>
        tnoremap <C-O> <C-\><C-N><C-O>
    ]]
)

-- 取消新行自动生成注释
vim.cmd(
    [[
        autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    ]]
)
-- vim.api.nvim_set_autocmd('InsertEnter', '*', function()
--     vim.o.paste = true
-- end)
-- vim.api.nvim_set_autocmd('InsertLeave', '*', function()
--     vim.o.paste = false
-- end)
