local overseer = require('overseer')

return {
  -- Required fields
  name = "Test Task",
  builder = function(params)
        local cmd = "love src -eval \"KR_GAME='kr5';KR_TARGET='phone';DEBUG_IGNORE_FOCUS = true;I18N_LOG_MISSING=true\" -device_preset reference -repl 127.0.0.1 -localuser -level 9000 -custom "
        local cmd2 = " -custom2 " .. params.test_name
    -- This must return an overseer.TaskDefinition
    return {
        cmd = {cmd, vim.fn.expand('%:t'), cmd2}
    }
  end,
  -- Optional fields
  desc = "Optional description of task",
  -- Tags can be used in overseer.run_template()
  tags = {overseer.TAG.BUILD},
  params = {
      test_name = {
          type = "string",
          name="Name of the subcase",
          optional=false
      }
    -- See :help overseer.params
  },
  -- Determines sort order when choosing tasks. Lower comes first.
  priority = 50,
  -- Add requirements for this template. If they are not met, the template will not be visible.
  -- All fields are optional.
  condition = {
    -- A string or list of strings
    -- Only matches when current buffer is one of the listed filetypes
    filetype = {"lua"},
    -- A string or list of strings
    -- Only matches when cwd is inside one of the listed dirs
    -- dir = "/home/user/my_project",
    -- Arbitrary logic for determining if task is available
    -- callback = function(search)
    --   print(vim.inspect(search))
    --   return true
    -- end,
  },
}
