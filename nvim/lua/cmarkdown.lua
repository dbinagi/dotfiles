local command = vim.api.nvim_create_user_command

local markdown_toc = {}

markdown_toc.linked_win = nil
markdown_toc.linked_buffer = nil

markdown_toc.temporal_buffer = nil

markdown_toc.headers_title = {}
markdown_toc.headers_line = {}

markdown_toc.max_title_length = nil
markdown_toc.width_offset = 10

markdown_toc.load_markdown_headers = function()
    markdown_toc.headers_title = {}
    markdown_toc.headers_line = {}
    markdown_toc.max_title_length = 0

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for i, line in ipairs(lines) do
        local header1 = line:match("^#%s+(.+)$")
        local header2 = line:match("^##%s+(.+)$")
        local header3 = line:match("^###%s+(.+)$")

        if header1 then

            table.insert(markdown_toc.headers_title, "--------------------")
            table.insert(markdown_toc.headers_line, i)

            table.insert(markdown_toc.headers_title, header1)
            table.insert(markdown_toc.headers_line, i)
            if #header1 > markdown_toc.max_title_length then
                markdown_toc.max_title_length = #header1
            end

            table.insert(markdown_toc.headers_title, "--------------------")
            table.insert(markdown_toc.headers_line, i)
        elseif header2 then
            table.insert(markdown_toc.headers_title, "  " .. header2)
            table.insert(markdown_toc.headers_line, i)
            if #header2 + 2 > markdown_toc.max_title_length then
                markdown_toc.max_title_length = #header2 + 2
            end
        elseif header3 then
            table.insert(markdown_toc.headers_title, "    " .. header3)
            table.insert(markdown_toc.headers_line, i)
            if #header3 + 4 > markdown_toc.max_title_length then
                markdown_toc.max_title_length = #header3 + 4
            end
        end
    end
end

markdown_toc.jump_to_header = function()
    local current_line = vim.api.nvim_win_get_cursor(0)[1]
    if current_line <= #markdown_toc.headers_title then
        local col = 0
        local row = markdown_toc.headers_line[current_line]

        vim.api.nvim_set_current_win(markdown_toc.linked_win)
        vim.api.nvim_set_current_buf(markdown_toc.linked_buffer)

        vim.cmd('normal! ' .. row .. 'G')
    end
end

markdown_toc.open = function()
    local linked_buf = vim.api.nvim_get_current_buf()
    markdown_toc.linked_buffer = linked_buf
    markdown_toc.linked_win = vim.api.nvim_get_current_win()

    markdown_toc.load_markdown_headers()

    local bufnr = vim.api.nvim_create_buf(true, true)
    local buflength = markdown_toc.max_title_length + markdown_toc.width_offset
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, markdown_toc.headers_title)
    vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'wipe')
    vim.api.nvim_buf_set_option(bufnr, 'readonly', true)
    vim.api.nvim_buf_set_option(bufnr, 'buflisted', true)
    vim.api.nvim_buf_set_name(bufnr, "MarkdownTOC")
    vim.api.nvim_buf_set_option(bufnr, 'filetype', 'markdown')

    local autocmd_cmd = string.format(
        "autocmd BufEnter <buffer=%s> nnoremap <buffer> <CR> :lua require('cmarkdown').jump_to_header()<CR>",
        bufnr)
    vim.api.nvim_command(autocmd_cmd)

    local vsplit_cmd = string.format("vsplit | vertical resize %s | buffer %s", buflength, bufnr)
    vim.api.nvim_command(vsplit_cmd)

    local win_id = vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(win_id)

    markdown_toc.temporal_buffer = bufnr
end

command("MarkdownToc", function()
    markdown_toc.open()
end, {})

return markdown_toc
