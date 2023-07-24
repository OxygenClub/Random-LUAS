-- Services
local InputService, TeleportService, RunService, Workspace, Lighting, Players, HttpService, StarterGui, ReplicatedStorage, TweenService  = game:GetService("UserInputService"), game:GetService("TeleportService"), game:GetService("RunService"), game:GetService("Workspace"), game:GetService("Lighting"), game:GetService("Players"), game:GetService("HttpService"), game:GetService("StarterGui"), game:GetService("ReplicatedStorage"), game:GetService("TweenService")
-- Decendants 
local LocalPlayer = Players.LocalPlayer
local Mouse, Camera = LocalPlayer:GetMouse(), Workspace.Camera
-- Optimizers
local GetUpvalue = debug.getupvalue
local Sub, Upper, Lower = string.sub, string.upper, string.lower
local Find, Clear, Insert, Remove = table.find, table.clear, table.insert, table.remove
local Huge, Pi, Clamp, Ceil, Round, Abs, Floor, Random, Cos, Acos = math.huge, math.pi, math.clamp, math.ceil, math.round, math.abs, math.floor, math.random, math.cos, math.acos
local NewVector2, NewVector3, NewCFrame = Vector2.new, Vector3.new, CFrame.new
local NewRGB, NewHex = Color3.fromRGB, Color3.fromHex
local Spawn, Wait = task.spawn, task.wait
local Create, Resume = coroutine.create, coroutine.resume
local NewInstance = Instance.new

getgenv().Lynx = {Connections = {}}

do 
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
    function Lynx:GetBodyParts(Character, RootPart, Indexes, Hitboxes)
        local Parts = {}
        local Hitboxes = Hitboxes or {"Head", "Torso", "Arms", "Legs"}
        --
        for Index, Part in pairs(Character:GetChildren()) do
            if Part:IsA("BasePart") and Part ~= RootPart then
                if Find(Hitboxes, "Head") and Part.Name:lower():find("head") then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                elseif Find(Hitboxes, "Torso") and Part.Name:lower():find("torso") then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                elseif Find(Hitboxes, "Arms") and Part.Name:lower():find("arm") then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                elseif Find(Hitboxes, "Legs") and Part.Name:lower():find("leg") then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                elseif (Find(Hitboxes, "Arms") and Part.Name:lower():find("hand")) or (Find(Hitboxes, "Legs ") and Part.Name:lower():find("foot")) then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                end
            end
        end
        --
        return Parts
    end
    --
    function Lynx:GetRootPart(Player, Character, Humanoid)
        return Humanoid.RootPart
    end
    --
    function Lynx:ValidateClient(Player)
        local Object = Player.Character
        local Humanoid = (Object and Lynx:GetHumanoid(Player, Object))
        local RootPart = (Humanoid and Lynx:GetRootPart(Player, Object, Humanoid))
        --
        return Object, Humanoid, RootPart
    end
    --
    function Lynx:ClientAlive(Player, Character, Humanoid)
        local Health, MaxHealth = Lynx:GetHealth(Player, Character, Humanoid)
        --
        return (Health > 0)
    end
    -- 
    function Lynx:newDrawing(type, prop)
        local obj = Drawing.new(type)
        --
        if prop then
            for i,v in next, prop do
                obj[i] = v
            end
        end
        return obj  
    end
    --
    function Lynx:GetClosestPlayer()
        local shortestDistance = Huge
        --  
        local closestPlayer
        for _, Player in pairs(Players:GetPlayers()) do
            if Player ~= LocalPlayer and Lynx:GetPlayerStatus(Player) then
                local pos,OnScreen = Camera:WorldToViewportPoint(Player.Character.HumanoidRootPart.Position)
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude
                --
                if magnitude < shortestDistance and OnScreen then
                        closestPlayer = Player
                        shortestDistance = magnitude
                    end
                end
            end 
        return closestPlayer
    end
    -- 
    function Lynx:RayCast(Part, Origin, Ignore, Distance)
        local Ignore = Ignore or {}
        local Distance = Distance or 5000
        --
        local Cast = Ray.new(Origin, (Part.Position - Origin).Unit * Distance)
        local Hit = Workspace:FindPartOnRayWithIgnoreList(Cast, Ignore)
        --
        return (Hit and Hit:IsDescendantOf(Part.Parent)) == true, Hit
    end
    --
    function Lynx:GetOrigin(Origin)
        if Origin == "Head" then
            local Object, Humanoid, RootPart = Lynx:ValidateClient(LocalPlayer)
            local Head = Object:FindFirstChild("Head")
            --
            if Head and Head:IsA("RootPart") then
                return Head.CFrame.Position
            end
        elseif Origin == "Torso" then
            local Object, Humanoid, RootPart = Lynx:ValidateClient(LocalPlayer)
            --
            if RootPart then
                return RootPart.CFrame.Position
            end
        end
        --
        return Workspace.CurrentCamera.CFrame.Position
    end
    -- 
    function Lynx:GetIgnore(Unpacked)
        if Unpacked then
            return
        else
            return {}
        end
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
    function Lynx:GetHealth(Player, Character, Humanoid)
        if Humanoid then
            return Clamp(Humanoid.Health, 0, Humanoid.MaxHealth), Humanoid.MaxHealth
        end
    end
    --
    function Lynx:GetTeam(Player)
        return Player.Team
    end
    --
    function Lynx:CheckTeam(Player1, Player2)
        return (Lynx:GetTeam(Player1) ~= Lynx:GetTeam(Player2))
    end
    --
    function Lynx:GetClosestPart(Player: Instance, List: Table)
        local shortestDistance = Huge
        local closestPart
        if Lynx:GetPlayerStatus(Player) then
            for _, Value in pairs(Player.Character:GetChildren()) do
                if Value:IsA("BasePart") then 
                    local pos = Camera:WorldToViewportPoint(Value.Position)
                    local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y + 36)).magnitude
                        if magnitude < shortestDistance and Find(List, Value) then
                            closestPart = Value
                            shortestDistance = magnitude
                        end
                    end
                end 
            return closestPart
        end
    end 
    --
    function Lynx:RandomChance(Percentage: Int)
        local Chance = Percentage
        --
        if Random(1,100) <= Chance then
            return true 
        else
            return false
        end
    end
    --
    function Lynx:CloneCharacter(Player: Instance, Color: Color3, Material: Enum, Transparency: Int)
        for i,v in pairs(Player.Character:GetChildren()) do 
            if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then 
                local ClonedPart = Instance("Part")
                ClonedPart.Anchored = true 
                ClonedPart.CanCollide = false 
                ClonedPart.Position = v.Position
                ClonedPart.Parent = Workspace.Terrain 
                ClonedPart.Material = Enum.Material[Material]
                ClonedPart.Shape = Enum.PartType.Block 
                ClonedPart.Transparency = Transparency 
                ClonedPart.Color = Color
                ClonedPart.Size = v.Size + Vector3.new(0.01,0.01,0.01)
                ClonedPart.Name = v.Name
                ClonedPart.Rotation = v.Rotation
            end 
        end
    end 
    --
    function Lynx:CalculateAbsolutePosition(Player: Instance)
        if Lynx:GetPlayerStatus(Player) then
            local root = Player.Character.HumanoidRootPart
            local character = Player.Character 
            --
            local currentPosition = root.Position
            local currentTime = tick() 
            --
            task.wait()
            --
            local newPosition = root.Position
            local newTime = tick()
            --
            local distanceTraveled = (newPosition - currentPosition) 
            --
            local timeInterval = newTime - currentTime
            local velocity = distanceTraveled / timeInterval
            currentPosition = newPosition
            currentTime = newTime
            --
            return velocity
        end
    end 
    --
    function Lynx:GetPlayerStatus(Player: Instance)
        if not Player then Player = LocalPlayer end
        return Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health > 0 and true or false
    end 
    --
    function Lynx:CreateBeam(Origin, End, Color1, Color2, Texture)
        local BeamPart = Instance("Part", workspace)
        BeamPart.Name = "BeamPart"
        BeamPart.Transparency = 1
        --
        local Part = Instance("Part", BeamPart)
        Part.Size = Vector3.new(1, 1, 1)
        Part.Transparency = 1
        Part.CanCollide = false
        Part.CFrame = CFrame.new(Origin)
        Part.Anchored = true
        local Attachment = Instance("Attachment", Part)
        local Part2 = Instance("Part", BeamPart)
        Part2.Size = Vector3.new(1, 1, 1)
        Part2.Transparency = 1
        Part2.CanCollide = false
        Part2.CFrame = CFrame.new(End)
        Part2.Anchored = true
        Part2.Color = Color3.fromRGB(255, 255, 255)
        local Attachment2 = Instance("Attachment", Part2)
        local Beam = Instance("Beam", Part)
        Beam.FaceCamera = true
        Beam.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color1),
            ColorSequenceKeypoint.new(1, Color2),
        }
        Beam.Attachment0 = Attachment
        Beam.Attachment1 = Attachment2
        Beam.LightEmission = 6
        Beam.LightInfluence = 1
        Beam.Width0 = 1
        Beam.Width1 = 0.6
        Beam.Texture = "rbxassetid://".. Texture ..""
        Beam.LightEmission = 1
        Beam.LightInfluence = 1
        Beam.TextureMode = Enum.TextureMode.Wrap 
        Beam.TextureLength = 3 
        Beam.TextureSpeed = 3
        delay(1, function()
        for i = 0.5, 1, 0.02 do
            wait()
            Beam.Transparency = NumberSequence.new(i)
        end
        Part:Destroy()
        Part2:Destroy()
        BeamPart:Destroy()
        end)
    end
    --
    function Lynx:GetTool() 
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Tool") and Lynx:GetPlayerStatus() then 
            return LocalPlayer.Character:FindFirstChildWhichIsA("Tool") 
        end 
    end 
    -- 
    function Lynx:Rainbow(Speed: Int)
        return Color3.fromHSV(Abs(Sin(tick()) / (5 - Speed)),1,1)
    end 
    --
    function Lynx:CheckIfEven(Number: Int)
        if (Number % 2 == 0) then
            return true
        else
            return false 
        end
    end
    --
    function Lynx:ClampString(String, Length, Font)
        local Font = (Font or 2)
        local Split = String:split("\n")
        --
        local Clamped = ""
        --
        for Index, Value2 in pairs(Split) do
            if (Index * 13) <= Length then
                Clamped = Clamped .. Value2 .. (Index == #Split and "" or "\n")
            end
        end
        --
        return (Clamped ~= String and (Clamped == "" and "" or Clamped:sub(0, #Clamped - 1) .. " ...") or Clamped)
    end
end