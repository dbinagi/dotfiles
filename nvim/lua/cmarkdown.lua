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

markdown_toc.changes_on_linked_buffer = function()
    markdown_toc.load_markdown_headers()
    markdown_toc.load_content(markdown_toc.headers_title)
end

markdown_toc.load_content = function(content)
    vim.api.nvim_set_option_value('modifiable', true, { buf = markdown_toc.temporal_buffer })
    vim.api.nvim_buf_set_lines(markdown_toc.temporal_buffer, 0, -1, false, content)
    vim.api.nvim_set_option_value('modifiable', false, { buf = markdown_toc.temporal_buffer })
end

markdown_toc.create_buffer = function(content)
    local linked_buf = vim.api.nvim_get_current_buf()
    markdown_toc.linked_buffer = linked_buf
    markdown_toc.linked_win = vim.api.nvim_get_current_win()

    local bufnr = vim.api.nvim_create_buf(true, true)
    local buflength = markdown_toc.max_title_length + markdown_toc.width_offset
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, content)
    vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = bufnr })
    vim.api.nvim_set_option_value('readonly', true, { buf = bufnr })
    vim.api.nvim_set_option_value('modifiable', false, { buf = bufnr })
    vim.api.nvim_set_option_value('buflisted', true, { buf = bufnr })
    vim.api.nvim_set_option_value('filetype', 'markdown', { buf = bufnr })
    vim.api.nvim_buf_set_name(bufnr, "MarkdownTOC")

    vim.api.nvim_create_augroup("markdown_toc", { clear = true })

    local autocmd_cmd = string.format(
        "autocmd BufEnter <buffer=%s> nnoremap <buffer> <CR> :lua require('cmarkdown').jump_to_header()<CR>",
        bufnr)
    -- vim.api.nvim_command(autocmd_cmd)
    vim.api.nvim_exec(autocmd_cmd, false)

    -- autocmd_cmd = string.format(
    --     "autocmd InsertLeave,TextChanged <buffer=%s> lua require('cmarkdown').changes_on_linked_buffer()",
    --     bufnr)
    -- vim.api.nvim_command(autocmd_cmd)

    -- vim.api.nvim_buf_attach(markdown_toc.linked_buffer, false, {
    --     on_lines = function()
    --         require('cmarkdown').changes_on_linked_buffer()
    --     end
    -- })

    vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
        group = "markdown_toc",
        buffer = markdown_toc.linked_buffer,
        callback = require('cmarkdown').changes_on_linked_buffer
    })


    local vsplit_cmd = string.format("vsplit | vertical resize %s | buffer %s", buflength, bufnr)
    vim.api.nvim_command(vsplit_cmd)

    local win_id = vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(win_id)

    markdown_toc.temporal_buffer = bufnr
end

markdown_toc.close = function()
    vim.api.nvim_buf_delete(markdown_toc.temporal_buffer, {force = true})
    markdown_toc.temporal_buffer = nil
end

markdown_toc.open = function()
    if markdown_toc.temporal_buffer and vim.api.nvim_buf_is_loaded(markdown_toc.temporal_buffer) then
        markdown_toc.close()
    end
    markdown_toc.load_markdown_headers()
    markdown_toc.create_buffer(markdown_toc.headers_title)
end

command("MarkdownTocOpen", function()
    markdown_toc.open()
end, {})

command("MarkdownTocClose", function()
    markdown_toc.close()
end, {})

command("MarkdownToc", function()
    markdown_toc.open()
end, {})

return markdown_toc
