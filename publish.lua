local Settings,SaveSettings = {},nil do
    -- Read file
    local settingsfile = io.open("settings.txt","r+")
    local settingsstr = (settingsfile:read("a") .. "\n") or ""
    settingsfile:close()
    settingsfile = nil

    -- Decode string
    local settingstable = {}
    string.gsub(settingsstr,"(.-): (.-)\n",function(VarName,VarValue)
        settingstable[VarName] = VarValue
    end)
    
    -- settings class
    local settingsmt = {
        __newindex = function(self,key,value)
            value = string.gsub(value,"\n","%&&&TXTDATA-ES-NEWLINE&&&%")
            settingstable[key] = value
        end;
        __index = function(self,key)
            local value = settingstable[key] or ""
            value = string.gsub(value,"%&&&TXTDATA-ES-NEWLINE&&&%","\n")
            return value
        end;
    }
    setmetatable(Settings,settingsmt)

    -- save settings func
    SaveSettings = function()
        local Data = ""
        for VarName,VarValue in pairs(settingstable) do
            Data = Data .. ("%s: %s\n"):format(VarName,VarValue)
        end
        settingsfile = io.open("settings.txt","w")
        settingsfile:write(Data)
        settingsfile:close()
        return true
    end
end

Settings.commit_version = tostring(tonumber(Settings.commit_version) + 1)
SaveSettings()

print("Type comment ...")
local comment = io.read()
local CommitText = (Settings.commit_comment):format(Settings.commit_version) .. (comment == "" and "" or (" (%s)"):format(comment))

os.execute("mkdocs build")
os.execute("git add .")
os.execute(("git commit -m \"%s\""):format(CommitText))
os.execute("git push")

print("\n\n-----------------------")
print("Published !")
print("-----------------------\n")
