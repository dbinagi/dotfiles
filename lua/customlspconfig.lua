
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- VIM

require'lspconfig'.vimls.setup{
    capabilities = capabilities
}

-- LUA

require'lspconfig'.sumneko_lua.setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
    capabilities = capabilities
}

-- PYTHON

require'lspconfig'.pylsp.setup{
    capabilities = capabilities
}


require'lspconfig'.csharp_ls.setup{}


-- JavaScript

require'lspconfig'.eslint.setup{
    --root_dir = vim.fn.getcwd(),
    capabilities = capabilities,
    single_file_support = true,
}

-- HTML

require'lspconfig'.html.setup {
    capabilities = capabilities,
}
