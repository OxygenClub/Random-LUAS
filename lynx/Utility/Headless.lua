--[[
    i made this for the funny 
    for usage check Criminality Misc_Headless
]]

local StartUpArguments = ({...})[1] or {}
--
local Headless = (StartUpArguments.On or false)
--
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
--
if LocalPlayer.Character and LocalPlayer.Character.Humanoid then
    for i,v in pairs(LocalPlayer.Character:GetChildren()) do
        if (v.Name == "Head" and v.ClassName == "Part") then
            v.Transparency = (Headless and 1 or 0)
            if v:FindFirstChild("face") then
                v.face.Transparency = (Headless and 1 or 0)
            end
        end
    end
end