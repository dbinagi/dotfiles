local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local wk = require('which-key')

------------------------------
--         custom           --
------------------------------

-- Toggle Fullscreen
-- local function toggle_fullscreen()
--     local enable = vim.g.GuiWindowFullScreen == 1 and 0 or 1
--     return "<cmd>call GuiWindowFullScreen(" .. enable .. ")<CR>"
-- end
--vim.keymap.set('n', '<f11>', toggle_fullscreen, { noremap = true, silent = true, expr = true })

------------------------------
--        cosmic-ui         --
------------------------------

map('n', '<leader>ga', '<cmd>lua require("cosmic-ui").code_actions()<cr>', opts)
map('v', '<leader>ga', '<cmd>lua require("cosmic-ui").range_code_actions()<cr>', opts)
map('n', '<leader>gn', '<cmd>lua require("cosmic-ui").rename()<cr>', opts)

------------------------------
--      goto-preview        --
------------------------------
map('n', '<leader>gpi', '<cmd>lua require("goto-preview").goto_preview_implementation()<CR>', opts)
map('n', '<leader>gpr', '<cmd>lua require("goto-preview").goto_preview_references()<CR>', opts)
map('n', '<leader>gP', '<cmd>lua require("goto-preview").close_all_win()<CR>', opts)


vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Mappings.
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts)
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
vim.keymap.set('n', '<leader>fo', vim.lsp.buf.formatting, opts)

------------------------------
--          LSP             --
------------------------------

wk.register({
    ["<leader>"] = {
        l = {
            d = { vim.lsp.buf.definition,                                                                   "Definition"},
            D = { "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",                         "Preview Definition"},
            t = { vim.lsp.buf.type_definition,                                                              "Type Def"},
            T = { "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",                    "Preview Type Def"},
        }
    }
})

------------------------------
--         Comment          --
------------------------------

wk.register({
    ["<leader>"] = {
        ["cc"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment"},
        ["cl"] = { "<CMD>lua require('Comment.api').call('toggle_linewise_op')<CR>g@", "Comment"},
    },
})

------------------------------
--         barbar           --
------------------------------

wk.register({
    ["<leader>"] = {
        [","] = { "<Cmd>BufferPrevious<CR>", "Previous Buffer"},
        ["."] = { "<Cmd>BufferNext<CR>", "Next Buffer"},
        ["<"] = { "<Cmd>BufferMovePrevious<CR>", "Move Tab Left"},
        [">"] = { "<Cmd>BufferMoveNext<CR>", "Move Tab Right"},
        ["1"] = { "<Cmd>BufferGoto 1<CR>", "Tab 1"},
        ["2"] = { "<Cmd>BufferGoto 2<CR>", "Tab 2"},
        ["3"] = { "<Cmd>BufferGoto 3<CR>", "Tab 3"},
        ["4"] = { "<Cmd>BufferGoto 4<CR>", "Tab 4"},
        ["5"] = { "<Cmd>BufferGoto 5<CR>", "Tab 5"},
        ["6"] = { "<Cmd>BufferGoto 6<CR>", "Tab 6"},
        ["7"] = { "<Cmd>BufferGoto 7<CR>", "Tab 7"},
        ["8"] = { "<Cmd>BufferGoto 8<CR>", "Tab 8"},
        ["9"] = { "<Cmd>BufferGoto 9<CR>", "Tab 9"},
        ["0"] = { "<Cmd>BufferLast<CR>", "Last Tab"},
    },
})

-- Pin/unpin buffer
map('n', '<leader>p', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<leader>c', '<Cmd>BufferClose<CR>', opts)
map('n', '<leader>bc', '<Cmd>BufferCloseAllButCurrent<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

------------------------------
--     Telescope/Files      --
------------------------------

wk.register({
    ["<leader>"] = {
        f = {
            name = "+ File",
            f = { "<cmd>lua require('telescope.builtin').find_files({layout_strategy='vertical'})<cr>",     "Find File" },
            b = { "<cmd>Telescope buffers<cr>",                                                             "Find File in Buffer" },
            g = { "<cmd>Telescope live_grep<cr>",                                                           "Search String" },
            h = { "<cmd>Telescope help_tags<cr>",                                                           "Search Help" },
            p = { "<cmd>Telescope projects<cr>",                                                            "Search in Projects" },
            s = { "<cmd>lua require('telescope.builtin').git_status()<cr>",                                 "Search Git diff" },
            t = { "<cmd>Telescope file_browser<cr>",                                                        "Show File Tree" },
    },
  },
})

