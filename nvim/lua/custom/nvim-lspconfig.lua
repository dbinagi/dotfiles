-- Installer must go before LSP config
require("nvim-lsp-installer").setup {}

-- Variable to support completition from LSP
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
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
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

-- JavaScript
require'lspconfig'.tsserver.setup{
    capabilities = capabilities,
}

-- HTML
require'lspconfig'.html.setup {
    capabilities = capabilities,
    cmd = {
        "vscode-eslint-language-server", "--stdio"
    }
}

-- C#

require'lspconfig'.csharp_ls.setup{
    capabilities = capabilities
}

