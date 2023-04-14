local overseer = require'overseer'


local function current_session()
	return ''
	--if require('auto-session-library') then
	--	return require('auto-session-library').current_session_name
	--end
end

local lualine = require'lualine'
lualine.setup({
    options = {
        theme = 'tokyonight'
    },
    sections = {
        lualine_c = {current_session()},
        lualine_x = {
            require('nomodoro').status,
            {
            "overseer",
            label = '',     -- Prefix for task counts
            colored = true, -- Color the task icons and counts
            symbols = {
                [overseer.STATUS.FAILURE] = "F:",
                [overseer.STATUS.CANCELED] = "C:",
                [overseer.STATUS.SUCCESS] = "S:",
                [overseer.STATUS.RUNNING] = "R:",
            },
            unique = false,     -- Unique-ify non-running task count by name
            name = nil,         -- List of task names to search for
            name_not = false,   -- When true, invert the name search
            status = nil,       -- List of task statuses to display
            status_not = false, -- When true, invert the status search
        },
    },}
})
