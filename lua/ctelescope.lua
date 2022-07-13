local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

require('telescope').setup({
  defaults = {
    layout_config = {
      vertical = { width = 0.9 }
    },
  },
})

map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files({layout_strategy='vertical'})<cr>", opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)

map('n', '<leader>fp', '<cmd>Telescope projects<cr>', opts)
map('n', '<leader>fs', "<cmd>lua require('telescope.builtin').git_status()<cr>", opts)
map('n', '<leader>fl', "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", opts)

