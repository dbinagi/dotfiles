local actions = require("telescope.actions")

require('telescope').setup({
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close
            },
        },
        layout_config = {
            vertical = { width = 0.9 }
        },
        file_ignore_patterns = { "^.git/" }
    },
    -- pickers = {
    --     find_files = {
    --         find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
    --     },
    -- }
})

require("telescope").load_extension "file_browser"
require("telescope").load_extension "live_grep_args"
require("telescope").load_extension('harpoon')
