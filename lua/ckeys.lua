local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Toggle Fullscreen
local function toggle_fullscreen()
    local enable = vim.g.GuiWindowFullScreen == 1 and 0 or 1
    return "<cmd>call GuiWindowFullScreen(" .. enable .. ")<CR>"
end

vim.keymap.set('n', '<f11>', toggle_fullscreen, { noremap = true, silent = true, expr = true })

