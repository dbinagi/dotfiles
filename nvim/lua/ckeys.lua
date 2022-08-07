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
map('n', '<leader>gpd', '<cmd>lua require("goto-preview").goto_preview_definition()<CR>', opts)
map('n', '<leader>gpt', '<cmd>lua require("goto-preview").goto_preview_type_definition()<CR>', opts)
map('n', '<leader>gpi', '<cmd>lua require("goto-preview").goto_preview_implementation()<CR>', opts)
map('n', '<leader>gpr', '<cmd>lua require("goto-preview").goto_preview_references()<CR>', opts)
map('n', '<leader>gP', '<cmd>lua require("goto-preview").close_all_win()<CR>', opts)



-- Toggle using count
--vim.keymap.set('n', 'gcc', "v:count == 0 ? '<Plug>(comment_toggle_current_linewise)' : '<Plug>(comment_toggle_linewise_count)'", )
vim.keymap.set('n', 'gbc', "v:count == 0 ? '<Plug>(comment_toggle_current_blockwise)' : '<Plug>(comment_toggle_blockwise_count)'", { expr = true, remap = true, replace_keycodes = false })

wk.register({
    ["<leader>"] = {
        ["c"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment"},
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
    },
})

-- Goto buffer in position...
map('n', '<leader>1', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<leader>2', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<leader>3', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<leader>4', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<leader>5', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<leader>6', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<leader>7', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<leader>8', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<leader>9', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<leader>0', '<Cmd>BufferLast<CR>', opts)
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
            l = { "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>",                            "Go to LSP definition" },
            t = { "<cmd>Telescope file_browser<cr>",                                                        "Show File Tree" },
    },
  },
})

