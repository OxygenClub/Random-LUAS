getgenv().Lynx = {locals = {}} 
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

local Settings = {
    Enabled = true 
    Part = "HumanoidRootPart",
    Method = "FindPartOnRayWithIgnoreList",
    FOV = 100,
    HitChance = 100 
}

function Lynx:GetTarget()
    local Target = {
        Player = nil,
        Object = nil,
        Part = nil,
        Magnitude = Huge
    }
    --
    local PossibleTarget = {
        Player = nil,
        Object = nil,
        Magnitude = Huge
    }
    --
    local MouseLocation = UserInputService:GetMouseLocation()
    --
    local FieldOfView = Settings.FOV
    local Hitboxes = Settings.Part
    --
    for Index, Player in pairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer then
            --if (Library and Library.Relations[Player.UserId] and Library.Relations[Player.UserId] == "Friend") then continue end
            --
            local Object, Humanoid, RootPart = Lynx:ValidateClient(Player)
            --
            if (Object and Humanoid and RootPart) then
                if (Object:FindFirstChildOfClass("ForceField")) then continue end
                if (not Lynx:ClientAlive(Player, Object, Humanoid)) then continue end
                --
                local Position, Visible = Camera:WorldToViewportPoint(RootPart.CFrame.Position)
                local Position2 = NewVector2(Position.X, Position.Y)
                local Magnitude = (MouseLocation - Position2).Magnitude
                local Distance = (Camera.CFrame.Position - RootPart.CFrame.Position).Magnitude
                --
                if Visible and Magnitude <= PossibleTarget.Magnitude then
                    PossibleTarget = {
                        Player = Player,
                        Object = Object,
                        Distance = Distance,
                        Magnitude = Magnitude
                    }
                end
                --
                --
                if Visible and Magnitude <= Target.Magnitude then
                    local ClosestPart, ClosestMagnitude = nil, Huge
                    --
                    for Index2, Part in pairs(Lynx:GetBodyParts(Object, RootPart, false, Hitboxes)) do
                        if (true and not (Part.Transparency ~= 1)) then continue end
                        --
                        local Position3, Visible2 = Camera:WorldToViewportPoint(Part.CFrame.Position)
                        local Position4 = NewVector2(Position3.X, Position3.Y)
                        local Magnitude2 = (MouseLocation - Position4).Magnitude
                        --
                        if Position4 and Visible2 then
                            --if (WallCheck and not Lynx:RayCast(Part, Lynx:GetOrigin(Origin), {Lynx:GetCharacter(LocalPlayer), Lynx:GetIgnore(true)})) then continue end
                            --
                            if Magnitude2 <= ClosestMagnitude then
                                ClosestPart = Part
                                ClosestMagnitude = Magnitude2
                            end
                        end
                    end
                    --
                    if ClosestPart and ClosestMagnitude then
                        Target = {
                            Player = Player,
                            Object = Object,
                            Part = ClosestPart,
                            Distance = Distance,
                            Magnitude = ClosestMagnitude
                        }
                    end
                end
            end
        end
    end
    --
    if Target.Player and Target.Object and Target.Part and Target.Magnitude then
        PossibleTarget = {
            Player = Target.Player,
            Object = Target.Object,
            Distance = Target.Distance,
            Magnitude = Target.Magnitude
        }
        --
        Lynx.Locals.Target = Target
    else
        Lynx.Locals.Target = nil
    end
    --
    if PossibleTarget and PossibleTarget.Distance then
        Lynx.Locals.PossibleTarget = PossibleTarget
    else
        Lynx.Locals.PossibleTarget = nil
    end
end  

--[[
    WTF HOW DO I USE THIS FUNCTION???!?!?!?
    WHY DOES ETERNAL COMPLICATE HIS CODE SO MUCH :(
]]