local command = vim.api.nvim_create_user_command

local markdown_toc = {}

markdown_toc.linked_buffer = nil
markdown_toc.temporal_buffer = nil

local function get_markdown_headers()
    local headers = {}
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(lines) do
        local header1 = line:match("^#%s+(.+)$")
        local header2 = line:match("^##%s+(.+)$")
        local header3 = line:match("^###%s+(.+)$")

        if header1 then
            table.insert(headers, header1)
        elseif header2 then
            table.insert(headers, "  " .. header2)
        elseif header3 then
            table.insert(headers, "    " .. header3)
        end
    end
    return headers
end

markdown_toc.jump_to_header = function()
    -- Obtener la lista de encabezados de nivel 1
    local headers = markdown_toc.get_markdown_headers()

    -- Obtener la línea seleccionada en el buffer actual
    local current_line = vim.api.nvim_win_get_cursor(0)[1]
    print(current_line)

    -- Verificar si la línea seleccionada está dentro del rango de los encabezados
    if current_line <= #headers then
        -- Obtener el número de línea correspondiente al encabezado en el otro buffer
        local target_line = vim.fn.search('^# ' .. headers[current_line], 'cnW')
        if target_line > 0 then
            -- Cambiar al otro buffer y establecer la posición del cursor
            vim.cmd('wincmd w')                                -- Cambiar al otro buffer
            vim.api.nvim_win_set_cursor(0, { target_line, 0 }) -- Establecer la posición del cursor
        end
    end
end

markdown_toc.open = function()
    markdown_toc.linked_buffer = vim.api.nvim_get_current_buf()

    local headers = get_markdown_headers()

    vim.cmd('vsplit')
    local bufnr = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_set_current_buf(bufnr)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, headers)
    markdown_toc.temporal_buffer = bufnr
    -- markdown_toc.setup_autocommand()
end

command("MarkdownToc", function()
    markdown_toc.open()
end, {})

-- Función para configurar el autocomando
-- markdown_toc.setup_autocommand = function()
--     vim.cmd([[
--     augroup JumpToHeader
--       autocmd!
--       autocmd BufEnter <buffer> nnoremap <buffer> <CR> :lua require'cmarkdown'.jump_to_header()<CR>
--     augroup END
--   ]])
-- end

vim.cmd("au BufEnter <buffer> nnoremap <buffer> <CR> :lua require'cmarkdown'.jump_to_header()'")


return markdown_toc
