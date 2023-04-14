-- Installer must go before LSP config
require("nvim-lsp-installer").setup {}

-- Variable to support completition from LSP
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true


local custom_attach = function(client)
    -- Temporal until fix omnisharp
    if client.name == 'omnisharp' then
        client.server_capabilities.semanticTokensProvider.legend = {
          tokenModifiers = { "static" },
          tokenTypes = { "comment", "excluded", "identifier", "keyword", "keyword", "number", "operator", "operator", "preprocessor", "string", "whitespace", "text", "static", "preprocessor", "punctuation", "string", "string", "class", "delegate", "enum", "interface", "module", "struct", "typeParameter", "field", "enumMember", "constant", "local", "parameter", "method", "method", "property", "event", "namespace", "label", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "regexp", "regexp", "regexp", "regexp", "regexp", "regexp", "regexp", "regexp", "regexp" }
        }
    end
end

-- VIM
require 'lspconfig'.vimls.setup {
    capabilities = capabilities,
    on_attach = custom_attach,
}

-- LUA
require 'lspconfig'.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
    capabilities = capabilities,
    on_attach = custom_attach,
}

-- PYTHON
require 'lspconfig'.pylsp.setup {
    capabilities = capabilities,
    on_attach = custom_attach,
}

-- JavaScript
require 'lspconfig'.tsserver.setup {
    capabilities = capabilities,
    on_attach = custom_attach,
}

-- JavaScript
require 'lspconfig'.tsserver.setup {
    capabilities = capabilities,
    on_attach = custom_attach,
}

require 'lspconfig'.ccls.setup {
    capabilities = capabilities,
    on_attach = custom_attach,
}

-- HTML
require 'lspconfig'.html.setup {
    capabilities = capabilities,
    on_attach = custom_attach,
    cmd = {
        "vscode-eslint-language-server", "--stdio"
    }
}

-- CSS, JS
require 'lspconfig'.cssls.setup {
    capabilities = capabilities,
    on_attach = custom_attach,
}

-- C++
require 'lspconfig'.ccls.setup {
    capabilities = capabilities,
    on_attach = custom_attach,
}

-- C#
if vim.loop.os_uname().sysname == 'Linux' then
    require 'lspconfig'.omnisharp.setup {
        cmd = { "mono", "/home/bini/.local/share/nvim/mason/packages/omnisharp-mono/omnisharp/OmniSharp.exe"},
        capabilities = capabilities,
        on_attach = custom_attach,
    }
else
    require 'lspconfig'.omnisharp.setup {
        capabilities = capabilities,
    }
end

