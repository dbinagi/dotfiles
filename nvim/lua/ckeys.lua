local wk = require('which-key')

local function cmd(cmd_string)
    return '<cmd>' .. cmd_string .. '<cr>'
end

local function configure_group(prefix, group, commands)
    wk.add({ prefix, group = group })
    for _, v in ipairs(commands) do
        wk.add({ prefix .. v[1], v[3], desc = v[2] })
    end
end

-- Commands
configure_group('<leader>c', "Commands", {
    { 'c', 'Comment',         cmd("lua require('Comment.api').toggle_current_linewise()") },
    { 'l', 'Comment Lines',   "<CMD>lua require('Comment.api').call('toggle_linewise_op')<CR>g@" },
    { 'r', 'Rename Variable', cmd("lua require('cosmic-ui').rename()") },
    { 'f', 'Fixed Cursor',    cmd("lua if vim.o.scrolloff > 0 then vim.o.scrolloff=0 else vim.o.scrolloff=999 end") },
})

-- Files
configure_group('<leader>f', "Files", {
    { 'f', 'Find File',   cmd("lua require('telescope.builtin').find_files({layout_strategy='vertical'})") },
    { 'b', 'Find Buffer', cmd("Telescope buffers") },
    { 'g', 'Search String',
        cmd("lua require('telescope').extensions.live_grep_args.live_grep_args({layout_strategy='vertical'})") },
    { 'h', 'Search Help',     cmd("Telescope help_tags") },
    { 's', 'Search Git Diff', cmd("lua require('telescope.builtin').git_status({layout_strategy='vertical'})") },
    { 't', 'Show File Tree',  cmd("Telescope file_browser") },
    { 'n', "Find Note",       cmd(
    "lua require('telescope.builtin').find_files({layout_strategy='vertical', cwd='~/notes'})") },
    { 'c', "File Compare",    cmd("lua require('telescope').extensions.diff.diff_current({ hidden = true })") },
})

-- LSP
configure_group('<leader>l', 'LSP', {
    { 'd', "Definition",         vim.lsp.buf.definition },
    { 'D', "Preview Definition", cmd("lua require('goto-preview').goto_preview_definition()") },
    { 't', "TypeDef",            vim.lsp.buf.type_definition },
    { 'T', "Preview TypeDef",    cmd("lua require('goto-preview').goto_preview_type_definition()") },
    { 'a', "Actions",            cmd('lua require("cosmic-ui").code_actions()') },
    { 'f', "Format",             cmd("lua vim.lsp.buf.format { async = true }") },
    { 'r', "References",         cmd("lua require('telescope.builtin').lsp_references()") },
    { 'R', "Preview References", cmd("lua require('goto-preview').goto_preview_references()") },
    { 's', "Signature Help",     vim.lsp.buf.signature_help },
    { 'h', "Hover",              vim.lsp.buf.hover },
})

-- Notes
configure_group('<leader>n', 'Notes', {
    { 'g', "Search in Notes", cmd("ObsidianSearch") },
    { 'f', "Find Note",       cmd("ObsidianQuickSwitch") },
    { 'n', "New Note",        cmd("ObsidianNew") },
    { 't', "List Headers",    cmd("MarkdownToc") },
    { 'q', "Query Tags",      cmd("ObsidianTags") },
    { 'c', "Toggle Checkbox", cmd("ObsidianToggleCheckbox") },
})

-- Git
configure_group('<leader>g', 'Git', {
    { 'n', "Next Change",      cmd('GitGutterNextHunk') },
    { 'p', "Prev Change",      cmd('GitGutterPrevHunk') },
    { 'b', "Git Blame Toggle", cmd('GitBlameToggle') },
})

-- Tabs
configure_group('<leader>t', 'Tabs', {
    { 'c', "Tab Close",      cmd("BufferClose") },
    { 'p', "Tab Pin",        cmd("BufferPin") },
    { '>', "Move Tab Right", cmd("BufferMoveNext") },
    { '<', "Move Tab Left",  cmd("BufferMovePrevious") },
})

wk.add({
    { "<leader>1", "<Cmd>BufferGoto 1<CR>",       desc = "Tab 1" },
    { "<leader>2", "<Cmd>BufferGoto 2<CR>",       desc = "Tab 2" },
    { "<leader>3", "<Cmd>BufferGoto 3<CR>",       desc = "Tab 3" },
    { "<leader>4", "<Cmd>BufferGoto 4<CR>",       desc = "Tab 4" },
    { "<leader>5", "<Cmd>BufferGoto 5<CR>",       desc = "Tab 5" },
    { "<leader>6", "<Cmd>BufferGoto 6<CR>",       desc = "Tab 6" },
    { "<leader>7", "<Cmd>BufferGoto 7<CR>",       desc = "Tab 7" },
    { "<leader>8", "<Cmd>BufferGoto 8<CR>",       desc = "Tab 8" },
    { "<leader>9", "<Cmd>BufferGoto 9<CR>",       desc = "Tab 9" },
    { "<leader>0", "<Cmd>BufferLast<CR>",         desc = "Last Tab" },
    { "<leader>,", "<Cmd>BufferPrevious<CR>",     desc = "Previous Buffer" },
    { "<leader>.", "<Cmd>BufferNext<CR>",         desc = "Next Buffer" },
    { "<leader>]", ":execute '/^# '<CR>:noh<CR>", desc = "Next Header 1" },
    { "<leader>[", ":execute '?^# '<CR>:noh<CR>", desc = "Previous Header 1" },
})


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


-- Useful hotkeys
-- Close Other windows: C-w - o
