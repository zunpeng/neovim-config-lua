local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", --latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- 插件
require("lazy").setup({
    -- require("plug-cfg.color-everforest"),    -- 主题插件
    require("plug-cfg.color-deus"),
    require("plug-cfg.indent"),         -- 缩进线插件
    require("plug-cfg.nvim-tree"),      -- 文件树插件
    require("plug-cfg.tabline"),   -- 标签栏插件
    require("plug-cfg.nvim-lualine"),  -- 状态栏插件
    -- require("plug-cfg.markdown-preview"),   -- markdown预览插件(使用render-markdown实时预览)
    require("plug-cfg.render-markdown"),   -- markdown预览插件(实时预览)
    require("plug-cfg.flash_nvim"),   -- 
    require("plug-cfg.lsp"),   -- mason等相关语言服务器配置
})

