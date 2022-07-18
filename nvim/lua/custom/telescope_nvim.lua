require('telescope').setup({
  defaults = {
    layout_config = {
      vertical = { width = 0.9 }
    },
    file_ignore_patterns = { "^.git/" }
  },
})

require("telescope").load_extension "file_browser"

