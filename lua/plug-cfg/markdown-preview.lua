return {
    -- install without yarn or npm
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
        init = function()
            vim.g.mkdp_auto_start = 0 -- 设置为1时，在markdown进入预览区后则自动打开预览
            vim.g.mkdp_auto_close = 1
            vim.g.mkdp_refresh_slow = 0
            vim.g.mkdp_command_for_global = 0 -- 如果设置为1,所有文件都可以使用markdownpreview 命令预览,默认为0
            vim.g.mkdp_open_to_the_world = 1 -- 设置为1时，局域网内其他人也可以预览,默认为0,为0时只能本机预览
            vim.g.mkdp_open_ip = '' -- 用于使用本地浏览器预览远程服务器上vim下的markdown文档,默认为空
            vim.g.mkdp_browser = '' -- 预览使用的默认浏览器
            vim.g.mkdp_echo_preview_url = 0
            vim.g.mkdp_browserfunc = ''
            vim.g.mkdp_port = '8888' -- 预览url端口，为空是随机生成一个端口
            vim.g.mkdp_page_title = '「${name}」' -- markdown 预览窗口标题，${name}是当前文件名称
            vim.g.mkdp_filetypes = { "markdown" } -- 预览可识别的文件类型
        end,

    }
}
-- return {
-- -- install with yarn or npm
--     {
--     "iamcco/markdown-preview.nvim",
--     cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
--     build = "cd app && yarn install",
--     init = function()
--         vim.g.mkdp_filetypes = { "markdown" }
--     end,
--     ft = { "markdown" },
--     },
-- }
