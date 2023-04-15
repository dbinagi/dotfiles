local actions = require("telescope.actions")

local filter_file_extensions = {
    -- Unity
    ".meta",
    ".prefab",
    ".shader",
}

local find_files_commands = {"rg", "--files", "--hidden", "--glob", "!**/.git/*"}
for _, extension in ipairs(filter_file_extensions) do
    table.insert(find_files_commands, "-g")
    table.insert(find_files_commands, "!*" .. extension)
end

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
    pickers = {
        find_files = {
            find_command = find_files_commands,
        },
    }
})

require("telescope").load_extension "file_browser"
require("telescope").load_extension "live_grep_args"
require("telescope").load_extension('harpoon')
