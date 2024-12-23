local config_file = ""
if os.getenv("HOME") then
     config_file = os.getenv("HOME") .. "/.config/config_env"
end

local f = io.open(config_file, "r")

local config = {}

if f then
    for l in f:lines() do
        local key, value = l:match("([^=]+)=(.+)")
        if key and value then
            config[key] = value
        end
    end
    f:close()
else
    print("Missing config_env file in ~/.config")
end

return config
