local Run = function(Func: () -> ())
    Func()
end
local cloneref = cloneref or function(Reference: Instance)
    return Reference
end

local Players: Players = cloneref(game:GetService("Players"))
local UserInputService: UserInputService = cloneref(game:GetService("UserInputService"))
local ReplicatedStorage: ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local LocalPlayer: Player = Players.LocalPlayer
local vape = shared.vape

local SendNotification = function(...)
    return vape:CreateNotification(...)
end

-- ExampleModule Template
Run(function()
    local ExampleModule

    ExampleModule = vape.Categories.Combat:CreateModule({
        Name = "ExampleModule",
        Function = function(Callback: boolean)
            if Callback then
                SendNotification("ExampleModule", "ExampleModule has been enabled!", 3)
                -- Add your module logic here when turned on
            else
                SendNotification("ExampleModule", "ExampleModule has been disabled!", 3)
                -- Clean up your module logic here when turned off
            end
        end,
        Tooltip = "An example template module."
    })
end)
