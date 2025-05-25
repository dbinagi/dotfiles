-- Check if already loaded
if vim.g.loaded_simpleflashcards then
    return
end

vim.g.loaded_simpleflashcards = true

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local previewers = require("telescope.previewers")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local file_path = "~/.config/flashcard.csv"
local column_question = 1
local column_answer = 2
local column_filter = 3
local column_difficulty = 4
local column_timestamp = 5
local filter_string = "no"
local file_separator = ";"
-- local minutes_to_show = 60

local minutes_offset = {}
minutes_offset[1] = 30
minutes_offset[2] = 2 * 60
minutes_offset[3] = 8 * 60

--- The default options
local DEFAULT_OPTIONS = {
    sources = {
        {
            path = '~/.config/flashcard.csv',
            col_front = 1,
            col_back = 2,
            col_filter = 3,
            col_difficulty = 4,
            col_timestamp = 5,
            separator = ';',
            filter_ignore = 'no',
        }
    },
    options = {
        {
            name = 'Easy',
            key = 1,
            minutes = 8 * 60 * 24,
        },
        {
            name = 'Medium',
            key = 2,
            minutes = 2 * 60,
        },
        {
            name = 'Hard',
            key = 3,
            minutes = 30,
        },
        {
            name = 'Remove',
            key = 0,
            minutes = nil,
        }
    },
    reference_first_element = {
        hidden = false,
        key_text = "REFERENCE",
    },
    minutes_offset = { 30, 2 * 60, 8 * 60 },
}



local function shuffle(t)
    math.randomseed(os.time())
    for i = #t, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
end

local function line_to_card(line)
    local parts = vim.split(line, file_separator, { trimempty = true })

    if #parts >= 2 then
        local card = {}
        card.question = #parts >= column_question and parts[column_question] or nil
        card.answer = #parts >= column_answer and parts[column_answer] or nil
        card.filter = #parts >= column_filter and parts[column_filter] or nil
        card.difficulty = #parts >= column_difficulty and tonumber(parts[column_difficulty]) or nil
        card.timestamp = #parts >= column_timestamp and parts[column_timestamp] or nil
        return card
    end

    return nil
end

local function minutes_from_now(target_timestamp)
    local now = os.time()
    local diff = os.difftime(now, target_timestamp)
    return (diff / 3600) * 60
end

local function parse_csv(filepath)
    local items = {}
    for line in io.lines(filepath) do
        local card = line_to_card(line)
        if card then
            if ((card.filter and card.filter ~= filter_string) or (card.filter == nil)) then
                if (card.timestamp) then
                    -- print(minutes_from_now(card.timestamp))
                end
                if (card.timestamp ~= nil and card.difficulty ~= nil) then
                    -- if ((minutes_from_now(card.timestamp)) >= minutes_offset[tonumber(card.difficulty)]) then
                    if ((minutes_from_now(card.timestamp)) >= vim.g.simpleflashcards.minutes_offset[tonumber(card.difficulty)]) then
                        table.insert(items, { key = card.question, value = card.answer })
                    end
                else
                    table.insert(items, { key = card.question, value = card.answer })
                end
            end
        end
    end
    shuffle(items)
    return items
end

local function move_to_end(question_line, difficulty)
    local filepath = vim.fn.expand(file_path)
    local lines = {}

    local last_line = ''

    for line in io.lines(filepath) do
        local card = line_to_card(line)
        if card then
            if (card.question == question_line) then
                if (tonumber(difficulty) == 0) then
                    card.filter = "no"
                end
                last_line = card.question ..
                    ";" ..
                    card.answer ..
                    ";" ..
                    (card.filter ~= nil and card.filter or "si") .. ";" .. tonumber(difficulty) .. ";" .. os.time()
            else
                table.insert(lines, line)
            end
        end
    end

    table.insert(lines, last_line)

    local file = io.open(filepath, "w")
    if file then
        for _, l in ipairs(lines) do
            file:write(l .. "\n")
        end
        file:close()
    end
end

local function load_source(source_data)
    local source = {}

    local filepath = vim.fn.expand(source_data.path)
    if (io.open(filepath, "r") == nil) then
        print("Flashcard: File " .. filepath .. " not found")
        return
    end

    local items = parse_csv(filepath)

    print(vim.inspect(source_data))

    return source
end

local function open_picker()
    local filepath = vim.fn.expand(file_path)

    if (io.open(filepath, "r") == nil) then
        print("Flashcard: File " .. filepath .. " not found")
        return
    end

    local items = parse_csv(filepath)

    for _, v in ipairs(vim.g.simpleflashcards.sources) do
        load_source(v)
    end

    if (not vim.g.simpleflashcards.reference_first_element.hidden) then
        local reference_text = ""

        for i, option in ipairs(vim.g.simpleflashcards.options) do
            local value_dimension = 0
            local value_calculated = 0
            local value_text = ''

            if (option.minutes == nil) then
                reference_text = reference_text .. "[" .. option.key .. ": " .. option.name .. ")] "
            else
                value_dimension = option.minutes < 60 and 1 or option.minutes < 24 * 60 and 2 or 3

                value_calculated = value_dimension == 1 and option.minutes or
                value_dimension == 2 and option.minutes / 60 or option.minutes / 60 / 24
                value_text = value_dimension == 1 and "minutes" or value_dimension == 2 and "hours" or "days"

                reference_text = reference_text ..
                "[" .. option.key .. ": " .. option.name .. " (" .. value_calculated .. " " .. value_text .. ")] "
            end
        end
        table.insert(items, 1, { key = vim.g.simpleflashcards.reference_first_element.key_text, value = reference_text })
    end

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

                -- print(vim.inspect(selection))

                if selection then
                    move_to_end(selection.ordinal, 2)
                    actions.close(prompt_bufnr)
                    vim.defer_fn(function()
                        open_picker()
                    end, 50)
                else
                    print("No selection found")
                end
            end)

            map("i", "1", function(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                    move_to_end(selection.ordinal, 1)
                    actions.close(prompt_bufnr)
                    vim.defer_fn(function()
                        open_picker()
                    end, 50)
                else
                    print("No selection found")
                end
            end)

            map("i", "2", function(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                    move_to_end(selection.ordinal, 2)
                    actions.close(prompt_bufnr)
                    vim.defer_fn(function()
                        open_picker()
                    end, 50)
                else
                    print("No selection found")
                end
            end)

            map("i", "3", function(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                    move_to_end(selection.ordinal, 3)
                    actions.close(prompt_bufnr)
                    vim.defer_fn(function()
                        open_picker()
                    end, 50)
                else
                    print("No selection found")
                end
            end)

            map("i", "0", function(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                    move_to_end(selection.ordinal, 0)
                    actions.close(prompt_bufnr)
                    vim.defer_fn(function()
                        open_picker()
                    end, 50)
                else
                    print("No selection found")
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

local simpleflashcards = {}

function simpleflashcards.open()
    open_picker()
end

function simpleflashcards.setup(options)
    local new_config = vim.tbl_deep_extend('force', DEFAULT_OPTIONS, options)
    vim.g.simpleflashcards = new_config
end

vim.api.nvim_create_user_command("SimpleFlashcards", function()
    simpleflashcards.open()
end, {})

return simpleflashcards
