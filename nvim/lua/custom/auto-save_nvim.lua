local autosave = require("auto-save")

autosave.setup({
    enabled = true,
    execution_message = {
	    message = function() -- message to print on save
			return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
		end
    },
    trigger_events = {"InsertLeave", "TextChanged"},
		--dim = 0.18, -- dim the color of `message`
		--cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
})
