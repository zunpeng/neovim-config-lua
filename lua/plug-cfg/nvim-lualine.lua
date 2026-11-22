                --theme = "dracula",
                --component_separators = { left = '', right = ''},
                --section_separators = { left = '', right = '' },

return {
    "nvim-lualine/lualine.nvim",
    config = function()
        -- 统计 UTF-8 可见字符数：中文/英文/数字/标点均1个计1，所有空白完全排除
        local function count_visible_chars(text)
            if not text or type(text) ~= 'string' or text == '' then
                return 0
            end
            local clean = text
            clean = clean:gsub('%s', '')       -- ASCII空白：空格、制表符、换行、回车
            clean = clean:gsub('　', '')       -- 全角空格 U+3000
            clean = clean:gsub('\xc2\xa0', '') -- 不间断空格 NBSP
            clean = clean:gsub('\xe2\x80\x8b', '') -- 零宽空格
            clean = clean:gsub('\xe2\x80\x8c', '') -- 零宽不连字
            clean = clean:gsub('\xe2\x80\x8d', '') -- 零宽连字
            return vim.str_utfindex(clean)
        end

        local function status_count()
            local ok, result = pcall(function()
                local total_lines = vim.fn.line('$')
                local mode = vim.fn.mode()
                local is_visual = mode == 'v' or mode == 'V' or mode == '\22'

                -- 全文可见字符总数
                local all_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
                local all_text = table.concat(all_lines, '')
                local total_chars = count_visible_chars(all_text)

                if not is_visual then
                    return string.format('W:%d | L:%d', total_chars, total_lines)
                end

                -- ========== 1. 行可视模式（Shift+V）：整行选中 ==========
                if mode == 'V' then
                    local s_line = vim.fn.line('v')
                    local e_line = vim.fn.line('.')
                    if s_line > e_line then s_line, e_line = e_line, s_line end

                    local vis_line_count = e_line - s_line + 1
                    local vis_lines = vim.api.nvim_buf_get_lines(0, s_line - 1, e_line, false)
                    local vis_text = table.concat(vis_lines, '')
                    local vis_chars = count_visible_chars(vis_text)

                    return string.format('W:%d/%d | L:%d/%d',
                        vis_chars, total_chars,
                        vis_line_count, total_lines)
                end

                -- ========== 2. 块可视模式（Ctrl+v）：矩形选区 ==========
                if mode == '\22' then
                    local s_line = vim.fn.line('v')
                    local s_col = vim.fn.col('v')
                    local e_line = vim.fn.line('.')
                    local e_col = vim.fn.col('.')

                    -- 起止完全重合 = 刚按未拖动，显示0
                    if s_line == e_line and s_col == e_col then
                        return string.format('W:0/%d | L:0/%d', total_chars, total_lines)
                    end

                    -- 排序行范围
                    local min_l, max_l = s_line, e_line
                    if min_l > max_l then min_l, max_l = max_l, min_l end

                    -- 排序列范围 + 排他逻辑（和字符模式一致，拖动多少算多少）
                    local min_c, max_c = s_col, e_col
                    if min_c > max_c then min_c, max_c = max_c, min_c end
                    local end_c = max_c - 1
                    if end_c < min_c then
                        return string.format('W:0/%d | L:0/%d', total_chars, total_lines)
                    end

                    -- 逐行截取矩形区域内的文本
                    local parts = {}
                    for l = min_l, max_l do
                        local line = vim.api.nvim_buf_get_lines(0, l - 1, l, false)[1] or ''
                        table.insert(parts, line:sub(min_c, end_c))
                    end
                    local vis_text = table.concat(parts, '')
                    local vis_chars = count_visible_chars(vis_text)
                    local vis_line_count = max_l - min_l + 1

                    return string.format('W:%d/%d | L:%d/%d',
                        vis_chars, total_chars,
                        vis_line_count, total_lines)
                end

                -- ========== 3. 字符可视模式（v）：逐字符选中 ==========
                local s_line = vim.fn.line('v')
                local s_col = vim.fn.col('v')
                local e_line = vim.fn.line('.')
                local e_col = vim.fn.col('.')

                -- 起止完全重合 = 刚按未拖动，显示0
                if s_line == e_line and s_col == e_col then
                    return string.format('W:0/%d | L:0/%d', total_chars, total_lines)
                end

                -- 统一排序，兼容反向选择
                if s_line > e_line or (s_line == e_line and s_col > e_col) then
                    s_line, e_line = e_line, s_line
                    s_col, e_col = e_col, s_col
                end

                -- 排他结束位置：修正多算1个字符的问题
                local sl = s_line - 1
                local sc = s_col - 1
                local el = e_line - 1
                local ec = math.max(0, e_col - 1)

                -- 精确截取选中文本
                local ok_get, vis_lines = pcall(vim.api.nvim_buf_get_text, 0, sl, sc, el, ec, {})
                if not ok_get or not vis_lines then
                    return string.format('W:0/%d | L:0/%d', total_chars, total_lines)
                end
                local vis_text = table.concat(vis_lines, '')
                local vis_chars = count_visible_chars(vis_text)
                local vis_line_count = e_line - s_line + 1

                return string.format('W:%d/%d | L:%d/%d',
                    vis_chars, total_chars,
                    vis_line_count, total_lines)
            end)

            return ok and result or 'W:-- | L:--'
        end

        require("lualine").setup{
            options = {
                theme = "everforest",
                section_separators = '',
                component_separators = '|',
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'filename'},
                lualine_x = {
                    status_count,
                    'encoding',
                    'fileformat',
                    'filetype',
                },
                lualine_y = {'progress'},
                lualine_z = {'location'},
            },
            refresh = {
                statusline = { 'ModeChanged', 'CursorMoved', 'CursorMovedI' },
            },
        }
    end
}
