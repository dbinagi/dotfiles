local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local previewers = require("telescope.previewers")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local file_path = "~/.config/flashcard.csv"
local column_question = 1
local column_answer = 2
local column_filter = 4
local filter_string = "no"
local file_separator = ";"

local function shuffle(t)
    math.randomseed(os.time())
    for i = #t, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
end

local function parse_csv(filepath)
    local items = {}
    for line in io.lines(filepath) do
        local parts = vim.split(line, file_separator, { trimempty = true })
        if #parts >= 2 then
            if (parts[column_filter] ~= filter_string) then
              table.insert(items, { key = parts[column_question], value = parts[column_answer] })
            end
        end
    end
    shuffle(items)
    return items
end

local function move_to_end(line)
  local filepath = vim.fn.expand(file_path)
  local lines = {}
  for current_line in io.lines(filepath) do
    if current_line ~= line then
      table.insert(lines, current_line)
    end
  end
  table.insert(lines, line)

  local file = io.open(filepath, "w")
  if file then
    for _, l in ipairs(lines) do
      file:write(l .. "\n")
    end
    file:close()
  end
end

local function custom_picker()
    local filepath = vim.fn.expand(file_path)

    if (io.open(filepath, "r") == nil) then
        print("Flashcard: File " .. filepath .. " not found")
        return
    end

    local items = parse_csv(filepath)
    table.insert(items, 1, {key = "COMENZAR", value = "COMENZAR"})

    pickers.new({}, {
        prompt_title = "Selecciona un elemento",
        finder = finders.new_table({
            results = items,
            entry_maker = function(entry)
                return {
                    value = entry.value,
                    display = entry.key,
                    ordinal = entry.key,
                    preview_command = function(_, bufnr)
                        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { entry.value })
                    end,
                }
            end,
        }),
        sorter = conf.generic_sorter({}),
        previewer = previewers.new_buffer_previewer({
            define_preview = function(self, entry)
                vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, { entry.value })
            end,
        }),
        attach_mappings = function(_, map)
            map("i", "<CR>", function(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                if selection then
                  move_to_end(selection[1]) -- Mueve la línea seleccionada al final del archivo
                end
            end)
            return true
        end,
        layout_strategy = "vertical",
        layout_config = {
          height = 0.9,
          width = 0.5,
          prompt_position = "top",
        },
    }):find()
end

vim.api.nvim_create_user_command("Study", custom_picker, {})
