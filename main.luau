local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

if game.GameId ~= 3808081382 then
    StarterGui:SetCore("SendNotification", {
        Title = "Script failed",
        Text = "Blud this isn't TSB",
        -- Icon = "rbxassetid://1234567890",
        Duration = 5
    })
    
    return
end

pcall(function()
    getgenv().lethalDunk:Disconnect() -- webbySlam
    getgenv().lethalDunk = nil
end)

-- X, Y, Z
local force = Vector3.new(0, 5000, 0)
local delay = 0.75

local Replication = ReplicatedStorage:WaitForChild("Replication")

local LocalPlayer = Players.LocalPlayer
local LocalCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = LocalCharacter:FindFirstChildWhichIsA("Humanoid")
local HumanoidRootPart = Humanoid.RootPart

getgenv().lethalDunk = Replication.OnClientEvent:Connect(function(...)
    local info = ({...})[1]
    
    if info.Effect == "Hunter Grind" and info.Attachment then
        local Character = info.Attachment:FindFirstAncestorWhichIsA("Model")
    
        -- For some reason Character == LocalCharacter is nil but DebugId == DebugId is true?
        if Character:GetDebugId() == LocalCharacter:GetDebugId() then
            task.wait(delay)
            HumanoidRootPart:ApplyImpulse(force)
        end
    end
end)
