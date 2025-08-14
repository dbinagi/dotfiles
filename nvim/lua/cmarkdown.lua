
if vim.g.loaded_markdown_toc then
    return
end

vim.g.loaded_markdown_toc = true

local command = vim.api.nvim_create_user_command

local markdown_toc = {}

local linked_win = nil
local linked_buffer = nil
local temporal_buffer = nil

markdown_toc.headers_title = {}
markdown_toc.headers_line = {}

markdown_toc.max_title_length = nil
markdown_toc.width_offset = 10

markdown_toc.auto_cmd_id = 0

markdown_toc.highlights1 = {}
markdown_toc.highlights2 = {}
markdown_toc.highlights3 = {}

--- The default options
local DEFAULT_OPTIONS = {
    style = {
        enable_highlights = true,
        header1 = {
            highlight_name = "MarkdownTocHeader1",
            -- fg = "#81A1C1",
            -- bg = "#3B4252",
            fg = nil,
            bg = nil,
            bold = true,
            prefix = "",
        },
        header2 = {
            highlight_name = "MarkdownTocHeader2",
            fg = nil,
            bg = nil,
            prefix = "  ",
        },
        header3 = {
            highlight_name = "MarkdownTocHeader3",
            fg = nil,
            bg = nil,
            prefix = "      ",
        }
    },
}

-- Local functions

local add_line = function(line_text, line_index, prefix, separator)
    table.insert(markdown_toc.headers_title,  prefix.. line_text)
    table.insert(markdown_toc.headers_line, line_index)

    if separator ~= nil and #separator > 0 then
        table.insert(markdown_toc.headers_title, separator)
        table.insert(markdown_toc.headers_line, line_index)
    end

    if #(prefix..line_text) > markdown_toc.max_title_length then
        markdown_toc.max_title_length = #(prefix..line_text)
    end
end

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
            add_line(header1, i, vim.g.markdown_toc.style.header1.prefix, vim.g.markdown_toc.style.header1.separator)

            local has_separator = vim.g.markdown_toc.style.header1.separator ~= nil and
                                    #vim.g.markdown_toc.style.header1.separator > 0

            table.insert(markdown_toc.highlights1, #markdown_toc.headers_title + (has_separator and -2 or -1))
        elseif header2 then
            add_line(header2, i, vim.g.markdown_toc.style.header2.prefix, vim.g.markdown_toc.style.header2.separator)

            local has_separator = vim.g.markdown_toc.style.header2.separator ~= nil and
                                    #vim.g.markdown_toc.style.header2.separator > 0

            table.insert(markdown_toc.highlights2, #markdown_toc.headers_title + (has_separator and -2 or -1))
        elseif header3 then
            add_line(header3, i, vim.g.markdown_toc.style.header3.prefix, vim.g.markdown_toc.style.header3.separator)

            local has_separator = vim.g.markdown_toc.style.header3.separator ~= nil and
                                    #vim.g.markdown_toc.style.header3.separator > 0

            table.insert(markdown_toc.highlights3, #markdown_toc.headers_title + (has_separator and -2 or -1))
        end
    end
end

markdown_toc.jump_to_header = function()
    local current_line = vim.api.nvim_win_get_cursor(0)[1]
    if current_line <= #markdown_toc.headers_title then
        local col = 0
        local row = markdown_toc.headers_line[current_line]

        if (linked_win ~= nil) then
            vim.api.nvim_set_current_win(linked_win)
        end

        if (linked_buffer ~= nil) then
            vim.api.nvim_set_current_buf(linked_buffer)
        end

        vim.cmd('normal! ' .. row .. 'G')
    end
end

markdown_toc.changes_on_linked_buffer = function()
    markdown_toc.load_markdown_headers()
    markdown_toc.load_content(markdown_toc.headers_title)
end

markdown_toc.load_content = function(content)
    if temporal_buffer == nil or not vim.api.nvim_buf_is_valid(temporal_buffer) then
        return
    end
    vim.api.nvim_set_option_value('modifiable', true, { buf = temporal_buffer })
    vim.api.nvim_buf_set_lines(temporal_buffer, 0, -1, false, content)
    vim.api.nvim_set_option_value('modifiable', false, { buf = temporal_buffer })
end

markdown_toc.create_buffer = function(content)
    local linked_buf = vim.api.nvim_get_current_buf()
    linked_buffer = linked_buf
    linked_win = vim.api.nvim_get_current_win()

    local bufnr = vim.api.nvim_create_buf(true, true)
    local buflength = markdown_toc.max_title_length + markdown_toc.width_offset
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, content)
    vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = bufnr })
    vim.api.nvim_set_option_value('readonly', true, { buf = bufnr })
    vim.api.nvim_set_option_value('modifiable', false, { buf = bufnr })
    vim.api.nvim_set_option_value('buflisted', true, { buf = bufnr })
    vim.api.nvim_set_option_value('filetype', 'markdown', { buf = bufnr })

    if vim.api.nvim_buf_get_name(bufnr) ~= "MarkdownTOC" then
        vim.api.nvim_buf_set_name(bufnr, "MarkdownTOC")
    end

    if vim.g.markdown_toc.style.enable_highlights then
        if (vim.api.nvim_get_hl_id_by_name(vim.g.markdown_toc.style.header1.highlight_name) ~= nil) then
            for _, value in ipairs(markdown_toc.highlights1) do
                vim.api.nvim_buf_add_highlight(bufnr, vim.api.nvim_get_hl_id_by_name(vim.g.markdown_toc.style.header1.highlight_name), vim.g.markdown_toc.style.header1.highlight_name, value, 0, buflength)
            end
        end

        if (vim.api.nvim_get_hl_id_by_name(vim.g.markdown_toc.style.header2.highlight_name) ~= nil) then
            for _, value in ipairs(markdown_toc.highlights2) do
                vim.api.nvim_buf_add_highlight(bufnr, vim.api.nvim_get_hl_id_by_name(vim.g.markdown_toc.style.header2.highlight_name), vim.g.markdown_toc.style.header2.highlight_name, value, 0, buflength)
            end
        end

        if (vim.api.nvim_get_hl_id_by_name(vim.g.markdown_toc.style.header3.highlight_name) ~= nil) then
            for _, value in ipairs(markdown_toc.highlights3) do
                vim.api.nvim_buf_add_highlight(bufnr, vim.api.nvim_get_hl_id_by_name(vim.g.markdown_toc.style.header3.highlight_name), vim.g.markdown_toc.style.header3.highlight_name, value, 0, buflength)
            end
        end
    end

    vim.api.nvim_create_augroup("markdown_toc", { clear = true })

    local autocmd_cmd = string.format(
        "autocmd BufEnter <buffer=%s> nnoremap <buffer> <CR> :lua require('cmarkdown').jump_to_header()<CR>",
        bufnr)

    vim.api.nvim_exec(autocmd_cmd, false)

    markdown_toc.auto_cmd_id = vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
        group = "markdown_toc",
        buffer = linked_buffer,
        callback = require('cmarkdown').changes_on_linked_buffer
    })

    local vsplit_cmd = string.format("vsplit | vertical resize %s | buffer %s", buflength, bufnr)
    vim.api.nvim_command(vsplit_cmd)

    local win_id = vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(win_id)

    temporal_buffer = bufnr
end

local concatenate_if_exist = function(node, put_before, put_after)
    local has_element = node ~= nil and #node > 0

    return has_element and put_before..node..put_after or ""
end

local configure_highlights = function()
    local highlights_config = {
        vim.g.markdown_toc.style.header1,
        vim.g.markdown_toc.style.header2,
        vim.g.markdown_toc.style.header3
    }

    for _, value in ipairs(highlights_config) do
        local fg = concatenate_if_exist(value.fg, "guifg=", " ")
        local bg = concatenate_if_exist(value.bg, "guibg=", " ")
        local bold = value.bold and "gui=bold" or ""

        if (#fg > 0 or #bg > 0) then
            local cmd = "highlight "..value.highlight_name.." "..fg..bg..bold
            vim.cmd(cmd)
        end
    end
end

-- Plugin functions

markdown_toc.close = function()
    if (temporal_buffer ~= nil) then
        vim.api.nvim_buf_delete(temporal_buffer, {force = true})
    end
    temporal_buffer = nil
    vim.api.nvim_del_autocmd(markdown_toc.auto_cmd_id)
end

markdown_toc.open = function()
    if temporal_buffer and vim.api.nvim_buf_is_loaded(temporal_buffer) then
        markdown_toc.close()
    end

    configure_highlights()

    markdown_toc.load_markdown_headers()

    if (markdown_toc.headers_title ~= nil and #markdown_toc.headers_title == 0) then
        print("No content to show")
    else
        markdown_toc.create_buffer(markdown_toc.headers_title)
    end
end

function markdown_toc.setup(options)
    local new_config = vim.tbl_deep_extend('force', DEFAULT_OPTIONS, options)
    vim.g.markdown_toc = new_config
end

-- Expose commands

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
