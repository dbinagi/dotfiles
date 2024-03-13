
local command = vim.api.nvim_create_user_command

local notes = {}

local pass = "" -- loaded on start
local encrypt_cmd = "" -- depends on password
local decrypt_cmd = "" -- depends on password

local notes_path = "notes"
local notes_encrypted_name = "notes.tar.gz"
local zip_cmd = "tar -zcvf " .. notes_encrypted_name .. " " .. notes_path
local unzip_cmd = "tar -xvzf " .. notes_encrypted_name
local remove_notes_path_cmd = "rm -R " .. notes_path .. " && " .. "rm " .. notes_encrypted_name

local function load_commands_with_pass(pass)
    encrypt_cmd = "openssl enc -aes-256-cbc -salt -in " .. notes_encrypted_name .. " -out " .. notes_encrypted_name .. ".enc -pass pass:" .. pass
    decrypt_cmd = "openssl enc -d -aes-256-cbc -in " .. notes_encrypted_name .. ".enc -out " .. notes_encrypted_name .. " -pass pass:" .. pass
end

local function file_exists(path)
    local home = vim.loop.os_homedir()
    local full_path = home .. '/' .. path
    local stat = vim.loop.fs_stat(full_path)
    return stat and stat.type == 'file'
end

local function directory_exists(path)
    local home = vim.loop.os_homedir()
    local full_path = home .. '/' .. path
    local stat = vim.loop.fs_stat(full_path)
    return stat and stat.type == 'directory'
end

-- if file_exists(notes_encrypted_name..".enc") then
--     pass = vim.fn.input("Notes Found! Enter password: ")
--     load_commands_with_pass(pass)
--
--     vim.cmd("autocmd VimEnter * silent! execute '!cd ~ && " .. decrypt_cmd .. " && " .. unzip_cmd .. "'")
--     vim.cmd("autocmd VimLeave * silent! execute '!cd ~ && " .. zip_cmd .. " && " .. encrypt_cmd .. " && " .. remove_notes_path_cmd .. "'")
-- else
--     if directory_exists(notes_path) then
--         pass = vim.fn.input("Directory notes Found! Enter password: ")
--         load_commands_with_pass(pass)
--         vim.cmd("autocmd VimLeave * execute '!cd ~ && " .. zip_cmd .. " && " .. encrypt_cmd .. " && " .. remove_notes_path_cmd .. "'")
--     end
-- end

notes.push = function()
    os.execute('cd ~ && rclone copy notes DriveRemote:')
    -- local handle = io.popen("cd ~ && rclone copy notes DriveRemote:")
    -- local result = handle:read()
    -- handle:close()
end

notes.pull = function()
    -- local handle = io.popen("cd ~ && rclone copy DriveRemote: notes")
    os.execute('cd ~ && rclone copy DriveRemote: notes')
    -- local result = handle:read()
    -- handle:close()
end

notes.decrypt = function()
    pass = vim.fn.input("Enter password: ")
    load_commands_with_pass(pass)

    local handle = io.popen("cd ~ && " .. decrypt_cmd .. " && " .. unzip_cmd)
    local result = handle:read()
    handle:close()
end

notes.encrypt = function()
    pass = vim.fn.input("Enter password: ")
    load_commands_with_pass(pass)

    local handle = io.popen("cd ~ && " .. zip_cmd ..  " && " .. encrypt_cmd .. " && " .. remove_notes_path_cmd)
    local result = handle:read()
    handle:close()
end

notes.clear_local = function()
    os.execute("cd ~ && " .. remove_notes_path_cmd)
    -- local handle = io.popen("cd ~ && " .. remove_notes_path_cmd)
    -- local result = handle:read()
    -- handle:close()
end

command("NotesPush", function ()
	notes.push()
end, {})

command("NotesPull", function ()
	notes.pull()
end, {})

command("NotesDecrypt", function ()
	notes.decrypt()
end, {})

command("NotesEncrypt", function ()
	notes.encrypt()
end, {})

command("NotesClearLocal", function ()
	notes.clear_local()
end, {})

