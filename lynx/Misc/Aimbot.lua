getgenv().utility = {Cursor = {Lines = {}, Outlines = {}}, Connections = {}}
local Functions, Tween = loadfile("lynx/Utility/Functions.lua")(), loadfile("lynx/Utility/TweenModule.lua")();
-- Services
local InputService, TeleportService, RunService, Workspace, Lighting, Players, HttpService, StarterGui, ReplicatedStorage, TweenService  = game:GetService("UserInputService"), game:GetService("TeleportService"), game:GetService("RunService"), game:GetService("Workspace"), game:GetService("Lighting"), game:GetService("Players"), game:GetService("HttpService"), game:GetService("StarterGui"), game:GetService("ReplicatedStorage"), game:GetService("TweenService")
-- Decendants 
local LocalPlayer = Players.LocalPlayer
local Mouse, Camera = LocalPlayer:GetMouse(), Workspace.Camera
-- Optimizers
local Find, Clear, Sub, Upper, Lower, Insert = table.find, table.clear, string.sub, string.upper, string.lower, table.insert
local Huge, Pi, Clamp, Round, Abs, Floor, Random, Sin, Cos, Rad, Halfpi = math.huge, math.pi, math.clamp, math.round, math.abs, math.floor, math.random, math.sin, math.cos, math.rad, math.pi/2
local rgb, v3, v2, cf, Instance, White = Color3.fromRGB, Vector3.new, Vector2.new, CFrame.new, Instance.new, Color3.new(1, 1, 1)
-- Settings 
getgenv().Settings = {
    Enabled = true,
    Keybind = Enum.KeyCode.V,
    Prediction = {false, 0.1413},
    HitPart  = "HumanoidRootPart",
    UseClosest = false,
    Smoothing = true,
    Smoothing_Value = 2,
    Toggled = false,
    Target = nil,
}
-- Keybind Loop
InputService.InputBegan:Connect(function(Key, Chatting)
    if not Chatting and Key.KeyCode == Settings.Keybind then 
        Settings.Toggled = not Settings.Toggled
        if Settings.Toggled == true then 
            Settings["Target"] = Lynx:GetClosestPlayer()
        end 
    end 
end)
--
Lynx:Connection(RunService.RenderStepped, function(Frame)
    if Settings.Toggled and Lynx:GetPlayerStatus(Settings["Target"]) then 
        local Char, Humanoid, RootPart = Lynx:ValidateClient(Settings["Target"])
        local EndPoint = CFrame.new(Camera.CFrame.p, Char[Settings.HitPart].Position + (Settings["Prediction"][1] and Char.HumanoidRootPart.Velocity * Settings["Prediction"][2] or Vector3.new(0, 0, 0)))
        Camera.CFrame = Camera.CFrame:Lerp(EndPoint, (100 - Settings.Smoothing_Value) / 100 , Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut)
    end 
end)
--
print("loaded")