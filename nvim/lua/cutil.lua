local util = {}

util.is_mac = function()
    return vim.loop.os_uname().sysname == 'Darwin'
end

util.is_linux = function()
    return vim.loop.os_uname().sysname == 'Linux'
end

return util
