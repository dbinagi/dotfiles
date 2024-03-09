local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local wk = require('which-key')

------------------------------
--        cosmic-ui         --
------------------------------

local keys = {
    c = {
        name = "+ Commands",
        c = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>",                          "Comment"},
        l = { "<CMD>lua require('Comment.api').call('toggle_linewise_op')<CR>g@",                       "Comment Lines"},
        r = { "<cmd>lua require('cosmic-ui').rename()<cr>",                                             "Rename Var"},
        f = { "<cmd>lua if vim.o.scrolloff > 0 then vim.o.scrolloff=0 else vim.o.scrolloff=999 end<cr>","Fixed Cursror"},
    },
    f = {
        name = "+ File",
        f = { "<cmd>lua require('telescope.builtin').find_files({layout_strategy='vertical'})<cr>",     "Find File" },
        b = { "<cmd>Telescope buffers<cr>",                                                             "Find File in Buffer" },
        g = { "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args({layout_strategy='vertical'})<cr>",      "Search String" },
        h = { "<cmd>Telescope help_tags<cr>",                                                           "Search Help" },
        p = { "<cmd>Telescope projects<cr>",                                                            "Search in Projects" },
        s = { "<cmd>lua require('telescope.builtin').git_status({layout_strategy='vertical'})<cr>",     "Search Git diff" },
        t = { "<cmd>Telescope file_browser<cr>",                                                        "Show File Tree" },
        n = { "<cmd>lua require('telescope.builtin').find_files({layout_strategy='vertical', cwd='~/notes'})<cr>",              "Find in Notes" },
    },
    g = {
        name = "+ Git",
        n = {"<Cmd>GitGutterNextHunk<cr>",                                                              "Next Change"},
        p = {"<Cmd>GitGutterPrevHunk<cr>",                                                              "Prev Change"},
        b = {"<Cmd>GitBlameToggle<cr>",                                                                 "Git Blame Toggle"},
    },
    h = {
        name = "+ Harpoon",
        m = {"<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",                                  "Harpoon Menu"},
        a = {"<cmd>lua require('harpoon.mark').add_file()<cr>",                                         "Harpoon Mark"},
    },
    l = {
        name = "+ LSP",
        d = {vim.lsp.buf.definition,                                                                    "Definition"},
        D = {"<cmd>lua require('goto-preview').goto_preview_definition()<CR>",                          "Preview Definition"},
        t = {vim.lsp.buf.type_definition,                                                               "Type Def"},
        T = {"<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",                     "Preview Type Def"},
        a = {'<cmd>lua require("cosmic-ui").code_actions()<cr>',                                        "Actions"},
        f = {'<cmd>lua vim.lsp.buf.format { async = true }<cr>',                                        "Format"},
        r = {'<cmd>lua require("telescope.builtin").lsp_references()<cr>',                              "References"},
        R = {'<cmd>lua require("goto-preview").goto_preview_references()<CR>',                          "Preview References"},
        s = {vim.lsp.buf.signature_help,                                                                "Signature Help"},
        h = {vim.lsp.buf.hover,                                                                         "Hover"},
    },
    n = {
        name = "+ Notes/Neorg",
        c = {"<cmd>Neorg return<CR>",                                                                   "Close Workspace"},
        d = {"<cmd>Neorg keybind all core.qol.todo_items.todo.task_done<CR>",                           "Task Done"},
        e = {"<cmd>Neorg toggle-concealer<CR>",                                                         "Toggle edit mode"},
        j = {"<cmd>Neorg keybind all core.qol.todo_items.todo.task_cycle<CR>",                          "Task Next"},
        k = {"<cmd>Neorg keybind all core.qol.todo_items.todo.task_cycle_reverse<CR>",                  "Task Previous"},
        l = {"<cmd>Neorg keybind all core.esupports.hop.hop-link<CR>",                                  "Open Link"},
        n = {"<cmd>Neorg keybind all core.dirman.new.note<CR>",                                         "New Note"},
        o = {"<cmd>Neorg workspace notes<CR>",                                                          "Open Workspace"},
        t = {"<cmd>put =strftime('# %Y-%m-%d %H:%M:%S')<CR>",                                           "Insert timestamp"},
        T = {"<cmd>Neorg toc left<CR>",                                                                 "Open TOC"},
        u = {"<cmd>Neorg keybind all core.qol.todo_items.todo.task_undone<CR>",                         "Task Undone"},
    },
    p = {
        name = "+ Project",
        t = {"<cmd>Telescope asynctasks all<cr>",                                                       "List Project Tasks"},
    },
    t = {
        name = "+ Tabs",
        c = {"<Cmd>BufferClose<CR>",                                                                    "Tab Close"},
        p = {"<Cmd>BufferPin<CR>",                                                                      "Tab Pin"},
        [">"] = { "<Cmd>BufferMoveNext<CR>", "Move Tab Right"},
        ["<"] = { "<Cmd>BufferMovePrevious<CR>", "Move Tab Left"},
    },
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
    [","] = { "<Cmd>BufferPrevious<CR>", "Previous Buffer"},
    ["."] = { "<Cmd>BufferNext<CR>", "Next Buffer"},
}

-- map('n', '<leader>gpi', '<cmd>lua require("goto-preview").goto_preview_implementation()<CR>', opts)
-- map('n', '<leader>gpr', '<cmd>lua require("goto-preview").goto_preview_references()<CR>', opts)
-- map('n', '<leader>gP', '<cmd>lua require("goto-preview").close_all_win()<CR>', opts)
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
-- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
-- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
-- vim.keymap.set('n', '<space>wl', function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- end, opts)
-- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
-- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

wk.register(keys, { prefix = "<leader>" })
