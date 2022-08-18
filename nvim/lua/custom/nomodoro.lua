require('nomodoro').setup({
    on_break_complete = function()
        require("notify")("Break complete!")
    end,
    on_work_complete = function()
        require("notify")("Work complete!")
    end
})
