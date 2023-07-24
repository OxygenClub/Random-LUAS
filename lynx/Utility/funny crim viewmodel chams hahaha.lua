--[[ 
    made by eternal
    yes theres a better way of doing it but im lazy
    femware couldnt make working ones lmao
]]

local Lynx = {
    Safe = true,
    Connections = {}
}

-- // Services
local UserInputService, ReplicatedStorage, TeleportService, VirtualUser, HttpService, RunService, Workspace, Lighting, Players = game:GetService("UserInputService"), game:GetService("ReplicatedStorage"), game:GetService("TeleportService"), game:GetService("VirtualUser"), game:GetService("HttpService"), game:GetService("RunService"), game:GetService("Workspace"), game:GetService("Lighting"), game:GetService("Players") 

-- // Locals
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- // Optimization Variables
local GetUpvalue = debug.getupvalue
local Sub, Upper, Lower = string.sub, string.upper, string.lower
local Find, Clear, Insert, Remove = table.find, table.clear, table.insert, table.remove
local Huge, Pi, Clamp, Ceil, Round, Abs, Floor, Random, Cos, Acos = math.huge, math.pi, math.clamp, math.ceil, math.round, math.abs, math.floor, math.random, math.cos, math.acos
local NewVector2, NewVector3, NewCFrame = Vector2.new, Vector3.new, CFrame.new
local NewRGB, NewHex = Color3.fromRGB, Color3.fromHex
local Spawn, Wait = task.spawn, task.wait
local Create, Resume = coroutine.create, coroutine.resume
local NewInstance = Instance.new
--
local ViewModel = Camera:FindFirstChild("ViewModel")
--
if not ViewModel then
    return
end
--
do -- // Lynx
    function Lynx:ThreadFunction(Func, Name, ...)
        local Func = Name and function()
            local Passed, Statement = pcall(Func)
            --
            if not Passed and not Lynx.Safe then
                warn("Lynx:\n", "              " .. Name .. ":", Statement)
            end
        end or Func
        local Thread = Create(Func)
        --
        Resume(Thread, ...)
        return Thread
    end
    --
    function Lynx:Connection(Type, Callback)
        local Connection = Type:Connect(Callback)
        Lynx.Connections[#Lynx.Connections + 1] = Connection
        --
        return Connection
    end
    --
    function Lynx:GetCharacter(Player)
        return Player.Character
    end
    --
    function Lynx:GetHumanoid(Player, Character)
        return Character:FindFirstChildOfClass("Humanoid")
    end
    --
    function Lynx:GetRootPart(Player, Character, Humanoid)
        return Humanoid.RootPart
    end
    --
    function Lynx:GetHealth(Player, Character, Humanoid)
        if Humanoid then
            return Clamp(Humanoid.Health, 0, Humanoid.MaxHealth), Humanoid.MaxHealth
        end
    end
    --
    function Lynx:ValidateClient(Player)
        local Object = Lynx:GetCharacter(Player)
        local Humanoid = (Object and Lynx:GetHumanoid(Player, Object))
        local RootPart = (Humanoid and Lynx:GetRootPart(Player, Object, Humanoid))
        --
        return Object, Humanoid, RootPart
    end
    --
    function Lynx:IsFirstPerson()
        return (LocalPlayer.Character.Head.CFrame.Position - Camera.CFrame.Position).Magnitude < 1
    end
end
--
do -- // Init
    Lynx:Connection(ViewModel.ChildAdded, function(Instance)
        if Instance.ClassName == "Tool" then
            for Index, Part in pairs(Instance:GetChildren()) do
                if Part.TextureID then
                    Part.TextureID = "rbxassetid://2163189692"
                end
                if Part.Material then
                    Part.Material = Enum.Material.ForceField
                end
                if Part.Color then
                    Part.Color = Color3.fromHex("#1A66FF")
                end
            end
        end
    end)
    --
    Lynx:Connection(RunService.Heartbeat, function(Delta) 
        local Object, Humanoid, RootPart = Lynx:ValidateClient(LocalPlayer)
        --
        if (Object and Humanoid and RootPart) then
            if (Lynx:IsFirstPerson() == true) then
                for Index, Instance in pairs(ViewModel:GetChildren()) do
                    if Instance.ClassName == "Part" then
                        if Instance.Name ~= "HumanoidRootPart" then
                            Instance.Transparency = 0
                            Instance.Material = Enum.Material.ForceField
                            Instance.Color = Color3.fromHex("#1A66FF")
                        else
                            Instance.Transparency = 1
                        end
                    end
                end
            else
                for Index, Instance in pairs(ViewModel:GetChildren()) do
                    if Instance.ClassName == "Part" then
                        Instance.Transparency = 1
                    end
                end
            end
        end
    end)
end