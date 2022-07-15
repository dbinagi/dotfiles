
require("nvim-lsp-installer").setup {}

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

local pid = vim.fn.getpid()
local omnisharp_bin = os.getenv("OMNISHARP_BIN") .. "/OmniSharp.exe"

require'lspconfig'.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
    capabilities = capabilities
}

