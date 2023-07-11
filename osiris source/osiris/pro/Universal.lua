-- // Start Up
local StartUpArguments = ({...})[1] or {}

--for i,v in pairs(StartUpArguments) do -- prints the start up args
--    print(i,v)
--end

-- // Tables
local Library, Utility, Flags, Theme = loadfile("Utility/Library1.lua")()
local Osiris, Visuals, Misc, Color, Math = {
    Safe = StartUpArguments.Safe,
    Connections = {},
    Account = {
        Username = game:GetService("Players").LocalPlayer.Name,
        UserID = game:GetService("Players").LocalPlayer.UserId,
        Game = "Universal"
    },
    Locals = {
        Window = {},
        PlayerList = {},
        AimAssistTarget = nil,
        LastStutter = tick(),
        TriggerTick = tick(),
        AimAssistFOV = 15,
        DeadzoneFOV = 10
    },
}, {
    Drawings = {},
    LastEspTick = tick()
}, {
}, {
}, {
}

-- // Services
local UserInputService, TeleportService, RunService, Workspace, Lighting, Players = game:GetService("UserInputService"), game:GetService("TeleportService"), game:GetService("RunService"), game:GetService("Workspace"), game:GetService("Lighting"), game:GetService("Players") 

-- // Locals
local LocalPlayer = Players.LocalPlayer

-- // Variables
local GetUpvalue = debug.getupvalue
local Sub, Upper, Lower = string.sub, string.upper, string.lower
local Find, Clear = table.find, table.clear
local Huge, Pi, Clamp, Round, Abs, Floor, Random = math.huge, math.pi, math.clamp, math.round, math.abs, math.floor, math.random
local Create, Resume = coroutine.create, coroutine.resume
--
local CreateRenderObject = GetUpvalue(Drawing.new, 1)
local DestroyRenderObject = GetUpvalue(GetUpvalue(Drawing.new, 7).__index, 3)
local SetRenderProperty = GetUpvalue(GetUpvalue(Drawing.new, 7).__newindex, 4)
local GetRenderProperty = GetUpvalue(GetUpvalue(Drawing.new, 7).__index, 4)

-- // Misc Fetch
local Saturation = Lighting:FindFirstChildOfClass("ColorCorrectionEffect")

-- // Cheat
do -- // Renders
    for Index = 1, 2 do
        local Circle = (Index == 1 and "AimAssist" or "Deadzone")
        --
        Visuals[Circle .. "Circle"] = CreateRenderObject("Circle")
        SetRenderProperty(Visuals[Circle .. "Circle"], "Filled", true)
        SetRenderProperty(Visuals[Circle .. "Circle"], "ZIndex", 59)
        --
        Visuals[Circle .. "Outline"] = CreateRenderObject("Circle")
        SetRenderProperty(Visuals[Circle .. "Outline"], "Thickness", 1.5)
        SetRenderProperty(Visuals[Circle .. "Outline"], "Filled", false)
        SetRenderProperty(Visuals[Circle .. "Outline"], "ZIndex", 60)
    end
end
--
do -- // Color
    function Color:Multiply(Color, Multiplier)
        return Color3.new(Color.R * Multiplier, Color.G * Multiplier, Color.B * Multiplier)
    end
    --
    function Color:Add(Color, Addition)
        return Color3.new(Color.R + Addition, Color.G + Addition, Color.B + Addition)
    end
    --
    function Color:Lerp(Value, MinColor, MaxColor)
        if Value <= 0 then return MaxColor end
        if Value >= 100 then return MinColor end
        --
        return Color3.new(
            MaxColor.R + (MinColor.R - MaxColor.R) * Value,
            MaxColor.G + (MinColor.G - MaxColor.G) * Value,
            MaxColor.B + (MinColor.B - MaxColor.B) * Value
        )
    end
end
--
do -- // Math
    function Math:RoundVector(Vector)
        return Vector2.new(Round(Vector.X), Round(Vector.Y))
    end
    --
    function Math:Shift(Number)
        return Acos(Cos(Number * Pi)) / Pi
    end
    --
    function Math:Random(Number)
        return Random(-Number, Number)
    end
    --
    function Math:RandomVec3(X, Y, Z)
        return Vector3.new(Math:Random(X), Math:Random(Y), Math:Random(Z))
    end
end
--
do -- // Osiris
    function Osiris:PlayerAdded(Player)
        Visuals:Add(Player)
    end
    --
    function Osiris:GetTableIndexes(Table, Custom)
        local Table2 = {}
        --
        for Index, Value in pairs(Table) do
            Table2[Custom and Value[1] or #Table2 + 1] = Index 
        end
        --
        return Table2
    end
    --
    function Osiris:ThreadFunction(Func, Name, ...)
        local Func = Name and function()
            local Passed, Statement = pcall(Func)
            --
            if not Passed and not Osiris.Safe then
                warn("Osiris:\n", "              " .. Name .. ":", Statement)
            end
        end or Func
        local Thread = Create(Func)
        --
        Resume(Thread, ...)
        return Thread
    end
    --
    function Osiris:Connection(Type, Callback)
        local Connection = Type:Connect(Callback)
        Osiris.Connections[#Osiris.Connections + 1] = Connection
        --
        return Connection
    end
    --
    function Osiris:ToHitboxes(Hitboxes)
        if Hitboxes == "Upper Top" then
            return {"Head", "Torso"}
        elseif Hitboxes == "Top" then
            return {"Head", "Torso", "Arms"}
        elseif Hitboxes == "Lower" then
            return {"Torso", "Arms", "Legs"}
        elseif Hitboxes == "All" then
            return {"Head", "Torso", "Arms", "Legs"}
        else
            return {Hitboxes}
        end
    end
    --
    function Osiris:GetBodyParts(Character, RootPart, Indexes, Hitboxes)
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
    function Osiris:GetCharacter(Player)
        return Player.Character
    end
    --
    function Osiris:GetHumanoid(Player, Character)
        return Character:FindFirstChildOfClass("Humanoid")
    end
    --
    function Osiris:GetHealth(Player, Character, Humanoid)
        if Humanoid then
            return Clamp(Humanoid.Health, 0, Humanoid.MaxHealth), Humanoid.MaxHealth
        end
    end
    --
    function Osiris:GetRootPart(Player, Character, Humanoid)
        return Humanoid.RootPart
    end
    --
    function Osiris:GetTeam(Player)
        return Player.Team
    end
    --
    function Osiris:CheckTeam(Player1, Player2)
        return (Osiris:GetTeam(Player1) ~= Osiris:GetTeam(Player2))
    end
    --
    function Osiris:GetIgnore(Unpacked)
        if Unpacked then
            return
        else
            return {}
        end
    end
    --
    function Osiris:GetOrigin(Origin)
        if Origin == "Head" then
            local Object, Humanoid, RootPart = Osiris:ValidateClient(Client)
            local Head = Object:FindFirstChild("Head")
            --
            if Head and Head:IsA("RootPart") then
                return Head.CFrame.Position
            end
        elseif Origin == "Torso" then
            local Object, Humanoid, RootPart = Osiris:ValidateClient(Client)
            --
            if RootPart then
                return RootPart.CFrame.Position
            end
        end
        --
        return Workspace.CurrentCamera.CFrame.Position
    end
    --
    function Osiris:RayCast(Part, Origin, Ignore, Distance)
        local Ignore = Ignore or {}
        local Distance = Distance or 5000
        --
        local Cast = Ray.new(Origin, (Part.Position - Origin).Unit * Distance)
        local Hit = Workspace:FindPartOnRayWithIgnoreList(Cast, Ignore)
        --
        return (Hit and Hit:IsDescendantOf(Part.Parent)) == true, Hit
    end
    --
    function Osiris:ValidateClient(Player)
        local Object = Osiris:GetCharacter(Player)
        local Humanoid = (Object and Osiris:GetHumanoid(Player, Object))
        local RootPart = (Humanoid and Osiris:GetRootPart(Player, Object, Humanoid))
        --
        return Object, Humanoid, RootPart
    end
    --
    function Osiris:ClientAlive(Player, Character, Humanoid)
        local Health, MaxHealth = Osiris:GetHealth(Player, Character, Humanoid)
        --
        return (Health > 0)
    end
    --
    function Osiris:CursorOffSet()
        if (Flags["LegitMisc_CursorOffset"]:Get() == true) then
            local CursorOffsetX = tonumber(Flags["LegitMisc_CursorOffsetX"]:Get())
            local CursorOffsetY = tonumber(Flags["LegitMisc_CursorOffsetY"]:Get())
            --
            return Vector2.new(CursorOffsetX, CursorOffsetY)
        else
            return Vector2.new(0, 0)
        end
    end
    --
    function Osiris:MousePosition(Offset)
        if Offset then
            return UserInputService:GetMouseLocation() + Osiris:CursorOffSet()
        else
            return UserInputService:GetMouseLocation()
        end
    end
    --
    function Osiris:UpdateFieldOfView()
        local ScreenSize = Workspace.CurrentCamera.ViewportSize
        --
        local FieldOfView = tonumber(Flags["LegitAimAssist_FieldOfView"]:Get())
        local Deadzone = ((Flags["LegitAimAssist_Deadzone"]:Get() == true) and tonumber(Flags["LegitAimAssist_DeadzoneAmmount"]:Get()) or 0)
        local Multiplier = (Osiris.Locals.PossibleTarget and Osiris.Locals.PossibleTarget.Multiplier or 1)
        --
        Osiris.Locals.AimAssistFOV = ((FieldOfView / 100) * ScreenSize.Y)
        Osiris.Locals.DeadzoneFOV = (Osiris.Locals.AimAssistFOV * 0.9) * (Deadzone / 100)
        --
        Osiris.Locals.VisualAimAssistFOV = (Osiris.Locals.AimAssistFOV * Multiplier)
        Osiris.Locals.VisualDeadzoneFOV = (Osiris.Locals.DeadzoneFOV * Multiplier)
    end
    --
    function Osiris:GetAimAssistTarGet()
        local Target = {
            Player = nil,
            Object = nil,
            Part = nil,
            Vector = nil,
            Magnitude = Huge
        }
        --
        local MouseLocation = Osiris:MousePosition(true)
        --
        print("!")
        local FieldOfView = tonumber(Flags["LegitAimAssist_FieldOfView"]:Get()) 
        local Origin = pointers["LegitAimAssist_WallCheckOrigin"]:Get()
        local FOVType = pointers["LegitAimAssist_FOVType"]:Get()
        local Deadzone = "Off" 
        local Hitboxes = pointers["LegitAimAssist_Hitbox"]:Get() 
        local HitboxesPriority = {pointers["LegitAimAssist_HitboxPriority"]:Get()}
        --
        local Checks = Flags["LegitAimAssist_Checks"]:Get()
        --
        local TeamCheck = Find(Checks, "Team")
        local WallCheck = Find(Checks, "Wall") 
        local VisibleCheck = Find(Checks, "Visible") 
        local ForceFieldCheck = Find(Checks, "Forcefield") 
        local AliveCheck = Find(Checks, "Alive") 
        local DistanceCheck = Find(Checks, "Distance")
        --
        local DistanceCheckMax = Flags["LegitAimAssist_Distance"]:Get()
        --
        print("2")
        local Disabled = false --max fov
        local FieldOfView = Osiris.Locals.AimAssistFOV / 2
        local Disabled2 = false 
        local Deadzone = Osiris.Locals.DeadzoneFOV / 2
        --
        local Dynamic = 625
        local DynamicHigh = Dynamic * 2
        local DynamicLow = Dynamic / 8.5
        --
        print("3")
        local PossibleTarget = {
            Player = nil,
            Object = nil,
            Magnitude = Huge
        }
        --
        for Index, Player in pairs(Players:GetPlayers()) do
            if Player ~= LocalPlayer then
                if (Library.Relations[Player.UserId] and Library.Relations[Player.UserId] == "Friend") then continue end
                if (TeamCheck and not Osiris:CheckTeam(LocalPlayer, Player)) then continue end
                --
                local Object, Humanoid, RootPart = Osiris:ValidateClient(Player)
                --
                if (Object and Humanoid and RootPart) then
                    if (ForceFieldCheck and Object:FindFirstChildOfClass("ForceField")) then continue end
                    if (AliveCheck and not Osiris:ClientAlive(Player, Character, Humanoid)) then continue end
                    --
                    local Position, Visible = Workspace.CurrentCamera:WorldToViewportPoint(RootPart.CFrame.Position)
                    local Position2 = Vector2.new(Position.X, Position.Y)
                    local Magnitude = (MouseLocation - Position2).Magnitude
                    local Distance = (Workspace.CurrentCamera.CFrame.Position - RootPart.CFrame.Position).Magnitude
                    local SelfAimAssistFOV = FieldOfView
                    local SelfDeadzoneFOV = Deadzone
                    local SelfMultiplier = 1
                    --
                    if (DistanceCheck and Distance >= DistanceCheckMax) then continue end
                    --
                    if FOVType == "Dynamic" then
                        SelfMultiplier = (Distance - DynamicLow) > 0 and (1 - ((Distance - DynamicLow) / Dynamic)) or (1 + (Clamp(Abs((Distance - DynamicLow) * 1.75), 0, DynamicHigh) / 100)) * 1.25
                    end
                    --
                    if Visible and Magnitude <= PossibleTarget.Magnitude then
                        PossibleTarget = {
                            Player = Player,
                            Object = Object,
                            Distance = Distance,
                            Multiplier = SelfMultiplier,
                            Magnitude = Magnitude
                        }
                    end
                    --
                    SelfAimAssistFOV = (SelfAimAssistFOV * SelfMultiplier)
                    SelfDeadzoneFOV = (SelfDeadzoneFOV * SelfMultiplier)
                    --
                    if ((not Disabled) and not (Magnitude <= SelfAimAssistFOV)) then continue end
                    --
                    if Visible and Magnitude <= Target.Magnitude then
                        local ClosestPart, ClosestVector, ClosestMagnitude = nil, nil, Huge
                        --
                        for Index2, Part in pairs(Osiris:GetBodyParts(Object, RootPart, false, Hitboxes)) do
                            if (VisibleCheck and not (Part.Transparency ~= 1)) then continue end
                            --
                            local Position3, Visible2 = Workspace.CurrentCamera:WorldToViewportPoint(Part.CFrame.Position)
                            local Position4 = Vector2.new(Position3.X, Position3.Y)
                            local Magnitude2 = (MouseLocation - Position4).Magnitude
                            --
                            if Position4 and Visible2 then
                                if ((not Disabled) and not (Magnitude2 <= SelfAimAssistFOV)) then continue end
                                if (WallCheck and not Osiris:RayCast(Part, Osiris:GetOrigin(Origin), {Osiris:GetCharacter(LocalPlayer), Osiris:GetIgnore(true)})) then continue end
                                --
                                if Magnitude2 <= ClosestMagnitude then
                                    ClosestPart = Part
                                    ClosestVector = Position4
                                    ClosestMagnitude = Magnitude2
                                end
                            end
                            --
                        end
                        --
                        if ClosestPart and ClosestVector and ClosestMagnitude then
                            Target = {
                                Player = Player,
                                Object = Object,
                                Part = ClosestPart,
                                Vector = ClosestVector,
                                Distance = Distance,
                                Multiplier = SelfMultiplier,
                                Magnitude = ClosestMagnitude
                            }
                        end
                    end
                end
            end
        end
        --
        if Target.Player and Target.Object and Target.Part and Target.Vector and Target.Magnitude then
            PossibleTarget = {
                Player = Target.Player,
                Object = Target.Object,
                Distance = Target.Distance,
                Multiplier = Target.Multiplier,
                Magnitude = Target.Magnitude
            }
            --
            Osiris.Locals.Target = Target
        else
            Osiris.Locals.Target = nil
        end
        --
        if PossibleTarget and PossibleTarget.Distance and PossibleTarget.Multiplier then
            Osiris.Locals.PossibleTarget = PossibleTarget
        else
            Osiris.Locals.PossibleTarget = nil
        end
    end
    --
    function Osiris:AimAssist()
        if Osiris.Locals.Target and Osiris.Locals.Target.Part and Osiris.Locals.Target.Vector then
            local Stutter = tonumber(Flags["LegitAimAssist_Stutter"]:Get())
            local Deadzone = (Flags["LegitAimAssist_Deadzone"]:Get() == false)
            local Multiplier = Osiris.Locals.Target.Multiplier
            --
            local Tick = tick()
            --
            if ((Tick - Osiris.Locals.LastStutter) >= (Stutter / 1000)) and not ((not Deadzone) and not (Osiris.Locals.Target.Magnitude >= ((Osiris.Locals.DeadzoneFOV * Multiplier) / 2))) then
                Osiris.Locals.LastStutter = Tick
                --
                local MouseLocation = Osiris:MousePosition(true)
                local MoveVector = (Osiris.Locals.Target.Vector - MouseLocation)
                --
                local SmoothingX = (Flags["LegitAimAssist_HorizontalSmoothing"]:Get() / 10)
                local SmoothingY = (Flags["LegitAimAssist_VerticalSmoothing"]:Get() / 10)
                --
                local Smoothness = Vector2.new(SmoothingX, SmoothingY)
                --
                local FinalVector = Math:RoundVector(Vector2.new(MoveVector.X / Smoothness.X, MoveVector.Y / Smoothness.Y))
                --
                mousemoverel(FinalVector.X, FinalVector.Y)
            end
        end
    end
    --
    function Osiris:GetTriggerBotTarGet()
        local Targets = {}
        --
        local MouseLocation = Osiris:MousePosition(true)
        --
        local Hitboxes = Flags["LegitTriggerbot_Hitbox"]:Get()
        local Origin = Flags["LegitTriggerbot_WallCheckOrigin"]:Get()
        --
        local Checks = Flags["LegitTriggetbot_Checks"]:Get()
        --
        local TeamCheck = Find(Checks, "Team")
        local WallCheck = Find(Checks, "Wall")
        local VisibleCheck = Find(Checks, "Visible")
        local ForceFieldCheck = Find(Checks, "Forcefield")
        local AliveCheck = Find(Checks, "Alive")
        --
        for Index, Player in pairs(Players:GetPlayers()) do
            if Player ~= Client then
                if (TeamCheck and not Osiris:CheckTeam(Client, Player)) then continue end
                --
                local Object, Humanoid, RootPart = Osiris:ValidateClient(Player)
                --
                if (Object and Humanoid and RootPart) then
                    if (ForceFieldCheck and Object:FindFirstChildOfClass("ForceField")) then continue end
                    if (AliveCheck and not Osiris:ClientAlive(Player, Character, Humanoid)) then continue end
                    --
                    for Index2, Part in pairs(Osiris:GetBodyParts(Object, RootPart, false, Hitboxes)) do
                        if (VisibleCheck and not (Part.Transparency ~= 1)) then continue end
                        if (WallCheck and not Osiris:RayCast(Part, Osiris:GetOrigin(Origin), {Osiris:GetCharacter(LocalPlayer), Osiris:GetIgnore(true)})) then continue end
                        --
                        Targets[#Targets + 1] = Part
                    end
                end
            end
        end
        --
        local PointRay = Workspace.CurrentCamera:ViewportPointToRay(MouseLocation.X, MouseLocation.Y, 0)
        local Hit, Position, Normal, Material = Workspace:FindPartOnRayWithWhitelist(Ray.new(PointRay.Origin, PointRay.Direction * 1000), Targets, false, false)
        --
        if Hit then
            Osiris.Locals.TriggerTarget = {
                Part = Hit,
                Position = Position,
                Material = Material
            }
        else
            Osiris.Locals.TriggerTarget = nil
        end
    end
    --
    function Osiris:TriggerBot()
        if Osiris.Locals.TriggerTarget then
            local Tick = tick()
            --
            local TriggerDelay = tonumber(Flags["LegitTriggerbot_Delay"]:Get())
            local Interval = tonumber(Flags["LegitTriggerbot_Interval"]:Get())
            --
            if ((Tick - Osiris.Locals.TriggerTick) >= (Interval / 1000)) then
                Osiris.Locals.TriggerTick = Tick
                --
                if TriggerDelay ~= 0 then
                    Delay(TriggerDelay / 1000, function()
                        mouse1press()
                        task.wait(0.05)
                        mouse1release()
                    end)
                else
                    mouse1press()
                    task.wait(0.05)
                    mouse1release()
                end
            end
        end
    end
    --
    function Osiris:Unload()
        for Index, Connection in pairs(Osiris.Connections) do
            Connection:Disconnect()
        end
        --
        for Index, Player in pairs(Players:GetPlayers()) do
            if Visuals.Drawings[Player] then
                for Index2, Drawing in pairs(Visuals.Drawings[Player]) do
                    if Drawing then
                        DestroyRenderObject(Drawing)
                    end
                end
                Clear(Visuals.Drawings[Player])
            end
        end
        --
        DestroyRenderObject(Visuals.AimAssistCircle)
        DestroyRenderObject(Visuals.AimAssistOutline)
        --
        DestroyRenderObject(Visuals.DeadzoneCircle)
        DestroyRenderObject(Visuals.DeadzoneOutline)
        --
        Clear(Osiris)
    end
end
--
do -- // Visuals
    function Visuals:Add(Player)
        if not Visuals.Drawings[Player] then
            Visuals.Drawings[Player] = {
                Name = CreateRenderObject("Text"),
                --
                BoxFill = CreateRenderObject("Square"),
                BoxOutline = CreateRenderObject("Square"),
                Box = CreateRenderObject("Square"),
                --BoxFill = CreateRenderObject("Square"),
                --
                HealthBarOutline = CreateRenderObject("Line"),
                HealthBar = CreateRenderObject("Line"),
                HealthNumber = CreateRenderObject("Text"),
                --
                --HeadDotOutline = CreateRenderObject("Circle"),
                --HeadDot = CreateRenderObject("Circle"),
                --
                Weapon = CreateRenderObject("Text"),
                --
                Distance = CreateRenderObject("Text"),
                --
                Flag = CreateRenderObject("Text")
            } -- this is so shit
            SetRenderProperty(Visuals.Drawings[Player].Name, "Center", true)
            SetRenderProperty(Visuals.Drawings[Player].Name, "Size", 13)
            SetRenderProperty(Visuals.Drawings[Player].Name, "Font", Drawing.Fonts.Plex) 
            SetRenderProperty(Visuals.Drawings[Player].Name, "Outline", true)
            --
            SetRenderProperty(Visuals.Drawings[Player].Box, "Thickness", 1)
            SetRenderProperty(Visuals.Drawings[Player].BoxOutline, "Thickness", 3)
            SetRenderProperty(Visuals.Drawings[Player].BoxOutline, "Color", Color3.fromRGB(0, 0, 0))
            SetRenderProperty(Visuals.Drawings[Player].BoxFill, "Filled", true)
            --
            SetRenderProperty(Visuals.Drawings[Player].HealthBarOutline, "Thickness", 3)
            SetRenderProperty(Visuals.Drawings[Player].HealthBarOutline, "Color", Color3.fromRGB(0, 0, 0))
            --
            SetRenderProperty(Visuals.Drawings[Player].HealthNumber, "Center", true)
            SetRenderProperty(Visuals.Drawings[Player].HealthNumber, "Size", 13)
            SetRenderProperty(Visuals.Drawings[Player].HealthNumber, "Outline", true)
            SetRenderProperty(Visuals.Drawings[Player].HealthNumber, "Font", Drawing.Fonts.Plex)
            --
            SetRenderProperty(Visuals.Drawings[Player].Weapon, "Center", true)
            SetRenderProperty(Visuals.Drawings[Player].Weapon, "Size", 13)
            SetRenderProperty(Visuals.Drawings[Player].Weapon, "Font", Drawing.Fonts.Plex)
            SetRenderProperty(Visuals.Drawings[Player].Weapon, "Outline", true)
            --
            SetRenderProperty(Visuals.Drawings[Player].Distance, "Center", true)
            SetRenderProperty(Visuals.Drawings[Player].Distance, "Size", 13)
            SetRenderProperty(Visuals.Drawings[Player].Distance, "Font", Drawing.Fonts.Plex)
            SetRenderProperty(Visuals.Drawings[Player].Distance, "Outline", true)
            --
            SetRenderProperty(Visuals.Drawings[Player].Flag, "Center", true)
            SetRenderProperty(Visuals.Drawings[Player].Flag, "Size", 13)
            SetRenderProperty(Visuals.Drawings[Player].Flag, "Font", Drawing.Fonts.Plex)
            SetRenderProperty(Visuals.Drawings[Player].Flag, "Outline", true)
        end
    end
    --
    function Visuals:Remove(Player)
        if Visuals.Drawings[Player] then
            for Index, Drawing in next, Visuals.Drawings[Player] do
                DestroyRenderObject(Drawing)
            end
        end
    end
    --
    function Visuals:FormatString(String)
        local Case = Flags["PlayerESP_Text_Case"]:Get()
        local Length = Flags["PlayerESP_Max_Text_Length"]:Get()

        if Case == "lowercase" then
           return Lower(Sub(String, 1, Length))
        elseif Case == "UPPERCASE" then
            return Upper(Sub(String, 1, Length))
        else
            return Sub(String, 1, Length)
        end
    end
    --
    function Visuals:UpdateEsp()
        for Index, Player in pairs(Players:GetPlayers()) do
            if Visuals.Drawings[Player] then
                --
                for i, v in pairs(Visuals.Drawings[Player]) do
                    if (GetRenderProperty(v, "Visible") == true) then
                        SetRenderProperty(v, "Visible", false)
                    end
                end
                --
                if (Flags["PlayerESP_Enabled"]:Get() and Flags["PlayerESP_Key"]:Active() and not Osiris.Locals.Window.isVisible) then
                    if (Flags["PlayerESP_Team_Check"]:Get() and not Osiris:CheckTeam(LocalPlayer, Player)) then continue end
                    local Object, Humanoid, RootPart = Osiris:ValidateClient(Player)
                    --
                    if (Object and Humanoid and RootPart) then
                        local MaxDistance = Flags["PlayerESP_MaxDistance"]:Get()
                        --
                        local DistanceToPlayer = (Workspace.CurrentCamera.CFrame.Position - RootPart.CFrame.Position).Magnitude
                        --
                        if MaxDistance >= DistanceToPlayer then
                            local Position, Visible = Workspace.CurrentCamera:WorldToViewportPoint(RootPart.Position)
                            --
                            if Visible then
                                local Size = (Workspace.CurrentCamera:WorldToViewportPoint(RootPart.Position - Vector3.new(0, 3, 0)).Y - Workspace.CurrentCamera:WorldToViewportPoint(RootPart.Position + Vector3.new(0, 2.6, 0)).Y) / 2
                                local BoxSize = Vector2.new(Floor(Size * 1.5), Floor(Size * 1.9))
                                local BoxPos = Vector2.new(Floor(Position.X - Size * 1.5 / 2), Floor(Position.Y - Size * 1.6 / 2))
                                --
                                if Flags["PlayerESP_Name"]:Get() then
                                    local Name = Visuals.Drawings[Player].Name
                                    --
                                    local NameColor, NameTransparency = Flags["PlayerESP_Name_Color"]:Get().Color, Flags["PlayerESP_Name_Color"]:Get().Transparency
                                    --
                                    SetRenderProperty(Name, "Text", Visuals:FormatString(Player.Name))
                                    SetRenderProperty(Name, "Position",  Vector2.new(BoxSize.X / 2 + BoxPos.X, BoxPos.Y - 16))
                                    SetRenderProperty(Name, "Color", NameColor)
                                    SetRenderProperty(Name, "Transparency", (1 - NameTransparency))
                                    SetRenderProperty(Name, "Visible", true)
                                end
                                --
                                if Flags["PlayerESP_Box"]:Get() then
                                    local Box = Visuals.Drawings[Player].Box
                                    local BoxOutline = Visuals.Drawings[Player].BoxOutline
                                    --
                                    local BoxColor1, BoxTransparency1 = Flags["PlayerESP_Box_Color1"]:Get().Color, Flags["PlayerESP_Box_Color1"]:Get().Transparency
                                    local BoxColor2, BoxTransparency2 = Flags["PlayerESP_Box_Color2"]:Get().Color, Flags["PlayerESP_Box_Color2"]:Get().Transparency
                                    --
                                    SetRenderProperty(Box, "Size", BoxSize)
                                    SetRenderProperty(Box, "Position", BoxPos)
                                    SetRenderProperty(Box, "Color", BoxColor1)
                                    SetRenderProperty(Box, "Transparency", (1 - BoxTransparency1))
                                    SetRenderProperty(Box, "Visible", true)
                                    --
                                    SetRenderProperty(BoxOutline, "Size", BoxSize)
                                    SetRenderProperty(BoxOutline, "Position", BoxPos)
                                    SetRenderProperty(BoxOutline, "Color", BoxColor2)
                                    SetRenderProperty(BoxOutline, "Transparency", (1 - BoxTransparency2))
                                    SetRenderProperty(BoxOutline, "Visible", true)
                                    --
                                    if Flags["PlayerESP_BoxFill"]:Get() then
                                        local BoxFill = Visuals.Drawings[Player].BoxFill
                                        --
                                        local BoxFillColor, BoxFillTransparency = Flags["PlayerESP_BoxFill_Color"]:Get().Color, Flags["PlayerESP_BoxFill_Color"]:Get().Transparency
                                        --
                                        SetRenderProperty(BoxFill, "Size", BoxSize)
                                        SetRenderProperty(BoxFill, "Position", BoxPos)
                                        SetRenderProperty(BoxFill, "Color", BoxFillColor)
                                        SetRenderProperty(BoxFill, "Transparency", (1 - BoxFillTransparency))
                                        SetRenderProperty(BoxFill, "Visible", true)
                                    end
                                end
                                --
                                if Flags["PlayerESP_HealthBar"]:Get() then
                                    local HealthBar = Visuals.Drawings[Player].HealthBar
                                    local HealthBarOutline = Visuals.Drawings[Player].HealthBarOutline
                                    --
                                    local HealthLow, HealthHigh, HealthBarOutlineColor = Flags["PlayerESP_HealthBar_Color_Low"]:Get().Color, Flags["PlayerESP_HealthBar_Color_High"]:Get().Color, Flags["PlayerESP_HealthBar_Color_Outline"]:Get().Color
                                    local HealthBarTransparency, HealthBarOutlineTransparency = Flags["PlayerESP_HealthBar_Color_High"]:Get().Transparency, Flags["PlayerESP_HealthBar_Color_Outline"]:Get().Transparency
                                    --
                                    local Color = Color:Lerp(Humanoid.Health / Humanoid.MaxHealth, HealthHigh, HealthLow)
                                    --
                                    SetRenderProperty(HealthBar, "From", Vector2.new((BoxPos.X - 3), BoxPos.Y + BoxSize.Y))
                                    Temp = GetRenderProperty(HealthBar, "From")
                                    SetRenderProperty(HealthBar, "To", Vector2.new(Temp.X, Temp.Y - (Humanoid.Health / Humanoid.MaxHealth) * BoxSize.Y))
                                    SetRenderProperty(HealthBar, "Color", Color)
                                    SetRenderProperty(HealthBar, "Transparency", (1 - HealthBarTransparency))
                                    SetRenderProperty(HealthBar, "Visible", true)
                                    --
                                    SetRenderProperty(HealthBarOutline, "From", Vector2.new(Temp.X, BoxPos.Y + BoxSize.Y + 1))
                                    SetRenderProperty(HealthBarOutline, "To", Vector2.new(Temp.X, (Temp.Y - 1 * BoxSize.Y) -1))
                                    SetRenderProperty(HealthBarOutline, "Color", HealthBarOutlineColor)
                                    SetRenderProperty(HealthBarOutline, "Transparency", (1 - HealthBarTransparency))
                                    SetRenderProperty(HealthBarOutline, "Visible", true)
                                    --
                                    if Flags["PlayerESP_HealthNumber"]:Get() and Humanoid.Health <= Flags["PlayerESP_Min_Health_Visibility_Cap"]:Get() then
                                        local HealthNumber = Visuals.Drawings[Player].HealthNumber
                                        --
                                        local HealthNumberColorLow, HealthNumberColorHigh = Flags["PlayerESP_HealthNumber_Color_Low"]:Get().Color, Flags["PlayerESP_HealthNumber_Color_High"]:Get().Color
                                        local HealthNumberTransparency = Flags["PlayerESP_HealthNumber_Color_High"]:Get().Transparency
                                        --
                                        local HealthNumberPosition = Vector2.new((BoxPos.X + 1), BoxPos.Y + BoxSize.Y)
                                        --
                                        SetRenderProperty(HealthNumber, "Text", Floor(Humanoid.Health))
                                        SetRenderProperty(HealthNumber, "Position", Vector2.new(HealthNumberPosition.X - 18, HealthNumberPosition.Y - (Humanoid.Health / Humanoid.MaxHealth) * BoxSize.Y)) -- this sucks, 18 for normal text
                                        SetRenderProperty(HealthNumber, "Color", HealthNumberColorLow:Lerp(HealthNumberColorHigh, Humanoid.Health / Humanoid.MaxHealth))
                                        SetRenderProperty(HealthNumber, "Transparency", (1 - HealthNumberTransparency))
                                        SetRenderProperty(HealthNumber, "Visible", true)
                                    end
                                end
                                --
                                if Flags["PlayerESP_Weapon"]:Get() and Object:FindFirstChildOfClass("Tool") then
                                    local Weapon = Visuals.Drawings[Player].Weapon
                                    --
                                    local WeaponColor, WeaponTransparency = Flags["PlayerESP_Weapon_Color"]:Get().Color, Flags["PlayerESP_Weapon_Color"]:Get().Transparency
                                    --
                                    SetRenderProperty(Weapon, "Text", (Visuals:FormatString(Object:FindFirstChildOfClass("Tool").Name)))
                                    SetRenderProperty(Weapon, "Position", BoxPosition + Vector2.new(BoxSize.X / 2, (BoxSize.Y + 4 + (false and 13 or 0)))) --Vector2.new(BoxSize.X / 2 + BoxPos.X, BottomOffset))
                                    SetRenderProperty(Weapon, "Color", WeaponColor)
                                    SetRenderProperty(Weapon, "Transparency", (1 - WeaponTransparency))
                                    SetRenderProperty(Weapon, "Visible", true)
                                end

                                if Library.Relations[Player.UserId] then -- this is bad lol
                                    if (Flags["PlayerESP_Highlight_Friend"]:Get() and Library.Relations[Player.UserId] == "Friend") then -- unoptimized
                                        local FriendColor = Flags["PlayerESP_Highlight_Friend_Color"]:Get().Color
                                        --
                                        --if GetRenderProperty(Visuals.Drawings[Player].Name, "Color") ~= FriendColor then
                                            SetRenderProperty(Visuals.Drawings[Player].Name, "Color", FriendColor)
                                            SetRenderProperty(Visuals.Drawings[Player].Box, "Color", FriendColor)
                                            SetRenderProperty(Visuals.Drawings[Player].BoxFill, "Color", FriendColor)
                                            SetRenderProperty(Visuals.Drawings[Player].Weapon, "Color", FriendColor)
                                            SetRenderProperty(Visuals.Drawings[Player].Distance, "Color", FriendColor)
                                        --end
                                    elseif (Flags["PlayerESP_Highlight_Enemy"]:Get() and Library.Relations[Player.UserId] == "Enemy") then
                                        local EnemyColor = Flags["PlayerESP_Highlight_Enemy_Color"]:Get().Color
                                        --
                                        --if GetRenderProperty(Visuals.Drawings[Player].Name, "Color") ~= EnemyColor then
                                            SetRenderProperty(Visuals.Drawings[Player].Name, "Color", EnemyColor)
                                            SetRenderProperty(Visuals.Drawings[Player].Box, "Color", EnemyColor)
                                            SetRenderProperty(Visuals.Drawings[Player].BoxFill, "Color", EnemyColor)
                                            SetRenderProperty(Visuals.Drawings[Player].Weapon, "Color", EnemyColor)
                                            SetRenderProperty(Visuals.Drawings[Player].Distance, "Color", EnemyColor)
                                        --end
                                    elseif (Flags["PlayerESP_Highlight_Priority"]:Get() and Library.Relations[Player.UserId] == "Priority") then
                                        local PriorityColor = Flags["PlayerESP_Highlight_Priority_Color"]:Get().Color
                                        --
                                        --if GetRenderProperty(Visuals.Drawings[Player].Name, "Color") ~= PriorityColor then
                                            SetRenderProperty(Visuals.Drawings[Player].Name, "Color", PriorityColor)
                                            SetRenderProperty(Visuals.Drawings[Player].Box, "Color", PriorityColor)
                                            SetRenderProperty(Visuals.Drawings[Player].BoxFill, "Color", PriorityColor)
                                            SetRenderProperty(Visuals.Drawings[Player].Weapon, "Color", PriorityColor)
                                            SetRenderProperty(Visuals.Drawings[Player].Distance, "Color", PriorityColor) 
                                        --end
                                    end
                                end
                            end
                        end
                    end
                end
            end 
        end
    end
    --
    function Visuals:Update()
        local MouseLocation = Osiris:MousePosition(true)
        --
        if (Flags["VisualsFOV_AimAssist"]:Get() == true) and (Flags["LegitAimAssist_Enabled"]:Get() == true) then
            local AimAssistColor1, AimAssistTransparency1 = Flags["VisualsFOV_AimAssist_Color"]:Get().Color, Flags["VisualsFOV_AimAssist_Color"]:Get().Transparency or Color3.fromHex("#38afa3"), 0.65
            local AimAssistColor2, AimAssistTransparency2 = Flags["VisualsFOV_AimAssist_Outline_Color"]:Get().Color, Flags["VisualsFOV_AimAssist_Outline_Color"]:Get().Transparency or Color3.fromHex("#38c8c8"), 0.75
            local FieldOfView = Osiris.Locals.VisualAimAssistFOV / 2
            --
            SetRenderProperty(Visuals.AimAssistCircle, "Position", MouseLocation)
            SetRenderProperty(Visuals.AimAssistCircle, "Color", AimAssistColor1)
            SetRenderProperty(Visuals.AimAssistCircle, "Transparency", 1 - AimAssistTransparency1)
            SetRenderProperty(Visuals.AimAssistCircle, "Radius", FieldOfView)
            SetRenderProperty(Visuals.AimAssistCircle, "NumSides", 60)
            SetRenderProperty(Visuals.AimAssistCircle, "Visible", true)
            --
            SetRenderProperty(Visuals.AimAssistOutline, "Position", MouseLocation)
            SetRenderProperty(Visuals.AimAssistOutline, "Color", AimAssistColor2)
            SetRenderProperty(Visuals.AimAssistOutline, "Transparency", 1 - AimAssistTransparency2)
            SetRenderProperty(Visuals.AimAssistOutline, "Radius", FieldOfView)
            SetRenderProperty(Visuals.AimAssistOutline, "NumSides", 60)
            SetRenderProperty(Visuals.AimAssistOutline, "Visible", true)
        else
            SetRenderProperty(Visuals.AimAssistCircle, "Visible", false)
            SetRenderProperty(Visuals.AimAssistOutline, "Visible", false)
        end
        --
        if (Flags["VisualsFOV_Deadzone"]:Get() == true) and (Flags["LegitAimAssist_Enabled"]:Get() == true) and (Flags["LegitAimAssist_Deadzone"]:Get() == true) then
            local DeadzoneColor1, DeadzoneTransparency1 = Flags["VisualsFOV_Deadzone_Color"]:Get().Color, Flags["VisualsFOV_Deadzone_Color"]:Get().Transparency or Color3.fromHex("#050c0f"), 0.65  
            local DeadzoneColor2, DeadzoneTransparency2 = Flags["VisualsFOV_Deadzone_Outline_Color"]:Get().Color, Flags["VisualsFOV_Deadzone_Outline_Color"]:Get().Transparency or Color3.fromHex("#0a0f14"), 0.75
            local FieldOfView = Osiris.Locals.VisualDeadzoneFOV / 2
            --
            SetRenderProperty(Visuals.DeadzoneCircle, "Position", MouseLocation)
            SetRenderProperty(Visuals.DeadzoneCircle, "Color", DeadzoneColor1)
            SetRenderProperty(Visuals.DeadzoneCircle, "Transparency", 1 - DeadzoneTransparency1)
            SetRenderProperty(Visuals.DeadzoneCircle, "Radius", FieldOfView)
            SetRenderProperty(Visuals.DeadzoneCircle, "NumSides", 60)
            SetRenderProperty(Visuals.DeadzoneCircle, "Visible", true)
            --
            SetRenderProperty(Visuals.DeadzoneOutline, "Position", MouseLocation)
            SetRenderProperty(Visuals.DeadzoneOutline, "Color", DeadzoneColor2)
            SetRenderProperty(Visuals.DeadzoneOutline, "Transparency", 1 - DeadzoneTransparency2)
            SetRenderProperty(Visuals.DeadzoneOutline, "Radius", FieldOfView)
            SetRenderProperty(Visuals.DeadzoneOutline, "NumSides", 60)
            SetRenderProperty(Visuals.DeadzoneOutline, "Visible", true)
        else
            SetRenderProperty(Visuals.DeadzoneCircle, "Visible", false)
            SetRenderProperty(Visuals.DeadzoneOutline, "Visible", false)
        end
        --
        if (Flags["VisualsWorld_Master"]:Get() == true) then
            if (Flags["VisualsWorld_Ambient"]:Get() == true) then
                if Lighting.Ambient ~= Flags["VisualsWorld_Ambient_Indoor_Color"]:Get().Color then
                    Lighting.Ambient = Flags["VisualsWorld_Ambient_Indoor_Color"]:Get().Color
                end
                if Lighting.OutdoorAmbient ~= Flags["VisualsWorld_Ambient_Outdoor_Color"]:Get().Color then
                    Lighting.OutdoorAmbient = Flags["VisualsWorld_Ambient_Outdoor_Color"]:Get().Color
                end
            end
            --
            if (Flags["VisualsWorld_CShift"]:Get() == true) then
                if Lighting.ColorShift_Bottom ~= Flags["VisualsWorld_CShift_Bottom_Color"]:Get().Color then
                    Lighting.ColorShift_Bottom = Flags["VisualsWorld_CShift_Bottom_Color"]:Get().Color
                end
                if Lighting.ColorShift_Bottom ~= Flags["VisualsWorld_CShift_Top_Color"]:Get().Color then
                    Lighting.ColorShift_Bottom = Flags["VisualsWorld_CShift_Top_Color"]:Get().Color
                end
            end
            --
            if (Flags["VisualsWorld_ForceTime"]:Get() == true) then
                if Lighting.ClockTime ~= Flags["VisualsWorld_ForceTimeHr"]:Get() then
                    Lighting.ClockTime = Flags["VisualsWorld_ForceTimeHr"]:Get()
                end
            end
            --
            if (Flags["VisualsWorld_Saturation"]:Get() == true) then
                if Saturation then
                    if Saturation.Saturation ~= (Flags["VisualsWorld_SaturationAA"]:Get() / 50) then
                        Saturation.Saturation = (Flags["VisualsWorld_SaturationAA"]:Get() / 50)
                    end
                    if Saturation.TintColor ~= Flags["VisualsWorld_SaturationA"]:Get().Color then
                        Saturation.TintColor = Flags["VisualsWorld_SaturationA"]:Get().Color
                    end
                end
            end
        end
    end
end
--
do -- // UI Init
    local Themes = {
        ['Default'] = {
            accent = Color3.fromRGB(55, 175, 225),
            lightcontrast = Color3.fromRGB(30, 30, 30),
            darkcontrast = Color3.fromRGB(20, 20, 20),
            outline = Color3.fromRGB(0, 0, 0),
            inline = Color3.fromRGB(50, 50, 50),
            textcolor = Color3.fromRGB(255, 255, 255),
            textdark = Color3.fromRGB(175, 175, 175),
            textborder = Color3.fromRGB(0, 0, 0),
            cursoroutline = Color3.fromRGB(10, 10, 10),
        },
        ["Nebula"] = {
            Accent = Color3.fromRGB(192, 76, 255),
            lightcontrast = Color3.fromRGB(17,19,23),
            darkcontrast = Color3.fromRGB(15,17,19),
            outline = Color3.fromRGB(31,29,29),
            inline = Color3.fromRGB(0, 0, 0),
            textcolor = Color3.fromRGB(192, 192, 192),
            textdark = Color3.fromRGB(175, 175, 175),
            textborder = Color3.fromRGB(0, 0, 0),
            cursoroutline = Color3.fromRGB(10, 10, 10)
        };
        ["Neko"] = {
            Accent = Color3.fromRGB(226, 30, 112),
            lightcontrast = Color3.fromRGB(18,18,18),
            darkcontrast = Color3.fromRGB(15,15,15),
            outline = Color3.fromRGB(0, 0, 0),
            inline = Color3.fromRGB(50, 50, 50),
            textcolor = Color3.fromRGB(255, 255, 255),
            textdark = Color3.fromRGB(175, 175, 175),
            textborder = Color3.fromRGB(0, 0, 0),
            riskytext = Color3.new(1, 1, 0.5),
            cursoroutline = Color3.fromRGB(10, 10, 10)
        };
        ["Spotify"] = {
            Accent = Color3.fromRGB(77, 255, 138),
            lightcontrast = Color3.fromRGB(18,18,18),
            darkcontrast = Color3.fromRGB(15,15,15),
            outline = Color3.fromRGB(0, 0, 0),
            inline = Color3.fromRGB(50, 50, 50),
            textcolor = Color3.fromRGB(255, 255, 255),
            textdark = Color3.fromRGB(175, 175, 175),
            textborder = Color3.fromRGB(0, 0, 0),
            riskytext = Color3.new(1, 1, 0.5),
            cursoroutline = Color3.fromRGB(10, 10, 10)
        };
        ["Fatality"] = {
            Accent = Color3.fromRGB(197, 7, 84),
            lightcontrast = Color3.fromRGB(30,24,66),
            darkcontrast = Color3.fromRGB(25, 19, 53),
            outline = Color3.fromRGB(0,0,0),
            inline = Color3.fromRGB(60, 53, 93),
            textcolor = Color3.fromRGB(255, 255, 255),
            textdark = Color3.fromRGB(175, 175, 175),
            textborder = Color3.fromRGB(0, 0, 0),
            riskytext = Color3.new(1, 1, 0.5),
            cursoroutline = Color3.fromRGB(10, 10, 10)
        };
        ["Tokyo Night"] = {
            Accent = Color3.fromRGB(103, 89, 179),
            lightcontrast = Color3.fromRGB(25, 25, 37),
            darkcontrast = Color3.fromRGB(22, 22, 31),
            outline = Color3.fromRGB(0,0,0),
            inline = Color3.fromRGB(50, 50, 50),
            textcolor = Color3.fromRGB(255, 255, 255),
            textdark = Color3.fromRGB(175, 175, 175),
            textborder = Color3.fromRGB(0, 0, 0),
            riskytext = Color3.new(1, 1, 0.5),
            cursoroutline = Color3.fromRGB(10, 10, 10)
        };
        ["Kiriot Hub"] = {
            Accent = Color3.fromRGB(255, 170, 0),
            lightcontrast = Color3.fromRGB(48, 51, 59),
            darkcontrast = Color3.fromRGB(26, 28, 32),
            outline = Color3.fromRGB(40, 40, 40),
            inline = Color3.fromRGB(0, 0, 0),
            textcolor = Color3.fromRGB(255, 255, 255),
            textdark = Color3.fromRGB(175, 175, 175),
            textborder = Color3.fromRGB(0, 0, 0),
            riskytext = Color3.new(1, 1, 0.5),
            cursoroutline = Color3.fromRGB(10, 10, 10)
        };
        ["Jester"] = {
            Accent = Color3.fromRGB(219, 68, 103),
            lightcontrast = Color3.fromRGB(36, 36, 36),
            darkcontrast = Color3.fromRGB(28, 28, 28),
            outline = Color3.fromRGB(0,0,0),
            inline = Color3.fromRGB(55, 55, 55),
            textcolor = Color3.fromRGB(255, 255, 255),
            textdark = Color3.fromRGB(175, 175, 175),
            textborder = Color3.fromRGB(0, 0, 0),
            riskytext = Color3.new(1, 1, 0.5),
            cursoroutline = Color3.fromRGB(10, 10, 10)
        };
        ["Entrophy"] = {
            Accent = Color3.fromRGB(143,181,214),
            lightcontrast = Color3.fromRGB(45,44,50),
            darkcontrast = Color3.fromRGB(37,37,42),
            outline = Color3.fromRGB(16,16,20),
            inline = Color3.fromRGB(68,67,76),
            textcolor = Color3.fromRGB(255, 255, 255),
            textdark = Color3.fromRGB(175, 175, 175),
            textborder = Color3.fromRGB(0, 0, 0),
            riskytext = Color3.new(1, 1, 0.5),
            cursoroutline = Color3.fromRGB(10, 10, 10)
        };
        ["Interwebz"] = {
            Accent = Color3.fromRGB(247, 123, 101),
            lightcontrast = Color3.fromRGB(32,25,43),
            darkcontrast = Color3.fromRGB(25,18,34),
            outline = Color3.fromRGB(26,20,36),
            inline = Color3.fromRGB(48,42,57),
            textcolor = Color3.fromRGB(255, 255, 255),
            textdark = Color3.fromRGB(175, 175, 175),
            textborder = Color3.fromRGB(0, 0, 0),
            riskytext = Color3.new(1, 1, 0.5),
            cursoroutline = Color3.fromRGB(10, 10, 10)
        };
        ["Aimware"] = {
            Accent = Color3.fromRGB(240, 72, 78),
            lightcontrast = Color3.fromRGB(31,31,31),
            darkcontrast = Color3.fromRGB(19,19,19),
            outline = Color3.fromRGB(0,0,0),
            inline = Color3.fromRGB(52,51,55),
            textcolor = Color3.fromRGB(255, 255, 255),
            textdark = Color3.fromRGB(175, 175, 175),
            textborder = Color3.fromRGB(0, 0, 0),
            riskytext = Color3.new(1, 1, 0.5),
            cursoroutline = Color3.fromRGB(10, 10, 10)
        };
        ["Dark Lagoon"] = {
            Accent = Color3.fromRGB(41, 92, 168),
            lightcontrast = Color3.fromRGB(38, 43, 60),
            darkcontrast = Color3.fromRGB(32,35,51),
            outline = Color3.fromRGB(0,0,0),
            inline = Color3.fromRGB(44, 54, 90),
            textcolor = Color3.fromRGB(255, 255, 255),
            textdark = Color3.fromRGB(175, 175, 175),
            textborder = Color3.fromRGB(0, 0, 0),
            riskytext = Color3.new(1, 1, 0.5),
            cursoroutline = Color3.fromRGB(10, 10, 10)
        };
        ["Onetap"] = {
            Accent = Color3.fromRGB(255,153,54),
            lightcontrast = Color3.fromRGB(46,46,46),
            darkcontrast = Color3.fromRGB(30,30,30),
            outline = Color3.fromRGB(0,0,0),
            inline = Color3.fromRGB(67,67,67),
            textcolor = Color3.fromRGB(255, 255, 255),
            textdark = Color3.fromRGB(175, 175, 175),
            textborder = Color3.fromRGB(0, 0, 0),
            riskytext = Color3.new(1, 1, 0.5),
            cursoroutline = Color3.fromRGB(10, 10, 10)
        };
        ["Abyss"] = {
            Accent = Color3.fromRGB(122,130,241),
            lightcontrast = Color3.fromRGB(32,32,32),
            darkcontrast = Color3.fromRGB(25,25,25),
            outline = Color3.fromRGB(0,0,0),
            inline = Color3.fromRGB(45,45,45),
            textcolor = Color3.fromRGB(255, 255, 255),
            textdark = Color3.fromRGB(175, 175, 175),
            textborder = Color3.fromRGB(0, 0, 0),
            riskytext = Color3.new(1, 1, 0.5),
            cursoroutline = Color3.fromRGB(10, 10, 10)
        };
        ["Vape"] = {
            Accent = Color3.fromRGB(32,110,87),
            lightcontrast = Color3.fromRGB(32,32,32),
            darkcontrast = Color3.fromRGB(25,25,25),
            outline = Color3.fromRGB(0,0,0),
            inline = Color3.fromRGB(45,45,45),
            textcolor = Color3.fromRGB(255, 255, 255),
            textdark = Color3.fromRGB(175, 175, 175),
            textborder = Color3.fromRGB(0, 0, 0),
            riskytext = Color3.new(1, 1, 0.5),
            cursoroutline = Color3.fromRGB(10, 10, 10)
        };
        ["Gamesense"] = {
            Accent = Color3.fromRGB(140,181,67),
            lightcontrast = Color3.fromRGB(23,23,23),
            darkcontrast = Color3.fromRGB(12,12,12),
            outline = Color3.fromRGB(0,0,0),
            inline = Color3.fromRGB(58,60,65),
            textcolor = Color3.fromRGB(255, 255, 255),
            textdark = Color3.fromRGB(175, 175, 175),
            textborder = Color3.fromRGB(0, 0, 0),
            riskytext = Color3.new(1, 1, 0.5),
            cursoroutline = Color3.fromRGB(10, 10, 10)
        };
        ["Neverlose"] = {
            Accent = Color3.fromRGB(83,198,131),
            lightcontrast = Color3.fromRGB(0,15,30),
            darkcontrast = Color3.fromRGB(3,4,16),
            outline = Color3.fromRGB(0,0,0),
            inline = Color3.fromRGB(13,24,37),
            textcolor = Color3.fromRGB(255, 255, 255),
            textdark = Color3.fromRGB(175, 175, 175),
            textborder = Color3.fromRGB(0, 0, 0),
            riskytext = Color3.new(1, 1, 0.5),
            cursoroutline = Color3.fromRGB(10, 10, 10)
        };
        ["Primordial"] = {
            Accent = Color3.fromRGB(194,155,165),
            lightcontrast = Color3.fromRGB(21,21,21),
            darkcontrast = Color3.fromRGB(31,31,31),
            outline = Color3.fromRGB(0,0,0),
            inline = Color3.fromRGB(67,67,67),
            textcolor = Color3.fromRGB(255, 255, 255),
            textdark = Color3.fromRGB(175, 175, 175),
            textborder = Color3.fromRGB(0, 0, 0),
            riskytext = Color3.new(1, 1, 0.5),
            cursoroutline = Color3.fromRGB(10, 10, 10)
        };
    }
    --
    function Library:LoadTheme(Theme) -- this is so shit lmaoo

    end
    --
    local Window = Library:New({Name = ("Osiris - %s - %s - (%s)"):format(Osiris.Account.Game, Osiris.Account.Username, game.PlaceId), PageAmmount = 6, Style = 1, Size = Vector2.new(550, 610)}) do
        local LegitPage = Window:Page({Name = "Legit"}) do 
            local AimAssistSection = LegitPage:Section({Name = "Aim Assist", Side = "Left"}) do
                AimAssistSection:Toggle({Name = "Enabled", Default = false, Pointer = "LegitAimAssist_Enabled"}):Keybind({Default = nil, Mode = "Toggle", KeybindName = "Aim Assist", Pointer = "LegitAimAssist_EnabledKey"})
                --
                AimAssistSection:Toggle({Name = "Readjustment", Default = false, Pointer = "LegitAimAssist_Readjustment"}):Keybind({Default = Enum.UserInputType.MouseButton1, Mode = "On Hold", KeybindName = "Readjustment", Pointer = "LegitAimAssist_Readjustment_Key"})
                --
                --AimAssistSection:Toggle({Name = "Aim Only With Weapon", Default = false, Pointer = "LegitAimAssist_AimIfWeapon"})
                --
                AimAssistSection:Slider({Name = "Field Of View", Default = 15, Minimum = 0, Maximum = 100, Prefix = "%", Decimals = 0.01, Pointer = "LegitAimAssist_FieldOfView"})
                --
                AimAssistSection:Dropdown({ Options = {"Static", "Dynamic"}, Max = 2, Default = "Static", Pointer = "LegitAimAssist_FOVType"})
                --
                AimAssistSection:Toggle({Name = "Deadzone", Default = false, Pointer = "LegitAimAssist_Deadzone"})
                --
                AimAssistSection:Slider({Name = "Deadzone Field Of View", Default = 10, Minimum = 0, Maximum = 50, Prefix = "%", Decimals = 0.01, Pointer = "LegitAimAssist_DeadzoneAmmount"})
                --
                AimAssistSection:Multibox({Name = "Aim Assist Checks", Options = {"Wall", "Visible", "Alive", "Forcefield", "Distance","Team"}, Default = {"Wall", "Visible", "Alive", "Forcefield", "Distance","Team"}, Minimum = 0, Pointer = "LegitAimAssist_Checks"})
                --
                AimAssistSection:Dropdown({Name = "Wall Check Origin", Options = {"Camera", "Head", "Torso"}, Max = 3, Default = "Camera", Pointer = "LegitAimAssist_WallCheckOrigin"})
                --
                AimAssistSection:Slider({Name = "Max Targetting Distance", Default = 1000, Minimum = 0, Maximum = 2500, Prefix = "m", Decimals = 1, Pointer = "LegitAimAssist_Distance"})
                --
                AimAssistSection:Slider({Name = "Horizontal Smoothing", Default = 13, Minimum = 0, Maximum = 100, Prefix = "%", Decimals = 1, Pointer = "LegitAimAssist_HorizontalSmoothing"})
                --
                AimAssistSection:Slider({Name = "Vertical Smoothing", Default = 13, Minimum = 0, Maximum = 100, Prefix = "%", Decimals = 1, Pointer = "LegitAimAssist_VerticalSmoothing"})
                --
                AimAssistSection:Dropdown({Name = "Hitscan Priority", Options = {"Head", "Torso"}, Max = 2, Default = "Head", Pointer = "LegitAimAssist_HitboxPriority"})
                --
                AimAssistSection:Multibox({Name = "Hitscan Points", Options = {"Head", "Torso", "Arms", "Legs"}, Default = {"Head", "Torso"}, Minimum = 1, Pointer = "LegitAimAssist_Hitbox"})
                --
                AimAssistSection:Slider({Name = "Stutter", Default = 0, Minimum = 0, Maximum = 50, Prefix = "ms", Decimals = 0.01, Pointer = "LegitAimAssist_Stutter"})
            end
            --
            local TriggerBotSection = LegitPage:Section({Name = "Trigger Bot", Side = "Right"}) do
                TriggerBotSection:Toggle({Name = "Enabled", Default = false, Pointer = "LegitTriggerbot_Enabled"}):Keybind({Default = Enum.KeyCode.N, Mode = "Toggle", KeybindName = "Trigger Bot", Pointer = "LegitTriggerbot_ReadjustmentKey"})
                --
                TriggerBotSection:Multibox({Name = "Hitscan Points", Options = {"Head", "Torso", "Arms", "Legs"}, Default = {"Head"}, Minimum = 1, Pointer = "LegitTriggerbot_Hitbox"})
                --
                TriggerBotSection:Multibox({Name = "Trigger Bot Checks", Options = {"Wall", "Visible", "Alive", "Forcefield"}, Default = {"Wall", "Visible", "Alive", "Forcefield"}, Minimum = 1, Pointer = "LegitTriggetbot_Checks"})
                --
                TriggerBotSection:Dropdown({Name = "Wall Check Origin", Options = {"Camera", "Head", "Torso"}, Max = 3, Default = "Camera", Pointer = "LegitTriggerbot_WallCheckOrigin"})
                --
                TriggerBotSection:Slider({Name = "Delay", Default = 10, Minimum = 0, Maximum = 1000, Prefix = "ms", Decimals = 0.01, Pointer = "LegitTriggerbot_Delay"})
                --
                TriggerBotSection:Slider({Name = "Interval", Default = 10, Minimum = 0, Maximum = 1000, Prefix = "%", Decimals = 0.01, Pointer = "LegitTriggerbot_Interval"})
            end
            --
            local MiscSection = LegitPage:Section({Name = "Miscellaneous", Side = "Right"}) do
                MiscSection:Toggle({Name = "Cursor Offset", Default = false, Pointer = "LegitMisc_CursorOffset"})
                --
                MiscSection:Slider({Name = "Cursor Offset X", Default = 0, Minimum = -150, Maximum = 150, Prefix = "%", Decimals = 0.01, Pointer = "LegitMisc_CursorOffsetX"})
                --
                MiscSection:Slider({Name = "Cursor Offset Y", Default = 0, Minimum = -150, Maximum = 150, Prefix = "%", Decimals = 0.01, Pointer = "LegitMisc_CursorOffsetY"})
            end
        end
        --
        local EspPage = Window:Page({Name = "ESP"}) do 
            local EspSection = EspPage:Section({Name = "Player ESP", Side = "Left"}) do
                EspSection:Toggle({Name = "Enabled", Default = false, Pointer = "PlayerESP_Enabled"}):Keybind({Default = Enum.KeyCode.F1, Mode = "Toggle", KeybindName = "Player ESP", Pointer = "PlayerESP_Key"})
                --
                EspSection:Slider({Name = "Max Draw Distance", Default = 2500, Minimum = 0, Maximum = 2500, Prefix = "m", Decimals = 0.01, Pointer = "PlayerESP_MaxDistance"})
                --
                EspSection:Toggle({Name = "Name", Default = false, Pointer = "PlayerESP_Name", callback = function(State) Window.VisualPreview.Components.Title["Text"].Visible = State end}):Colorpicker({Info = "Name Color", Default = Color3.fromRGB(255, 255, 255), Alpha = 0, Pointer = "PlayerESP_Name_Color"})
                --
                Temp = EspSection:Toggle({Name = "Bounding Box", Default = false, Pointer = "PlayerESP_Box", callback = function(State) Window.VisualPreview.Components.Box["Box"].Visible = State end})
                Temp:Colorpicker({Info = "Box Outer Color", Default = Color3.fromRGB(0, 0, 0), Alpha = 0, Pointer = "PlayerESP_Box_Color2"})
                Temp:Colorpicker({Info = "Box Inner Color", Default = Color3.fromRGB(255, 0, 0), Alpha = 0, Pointer = "PlayerESP_Box_Color1"})
                --
                EspSection:Toggle({Name = "Bounding Box Fill", Default = false, Pointer = "PlayerESP_BoxFill", callback = function(State) Window.VisualPreview.Components.Box["Fill"].Visible = State end}):Colorpicker({Info = "Box Fill Color", Default = Color3.fromRGB(255, 0, 0), Alpha = 0.92, Pointer = "PlayerESP_BoxFill_Color"})
                --
                Temp = EspSection:Toggle({Name = "Health Bar", Default = false, Pointer = "PlayerESP_HealthBar", callback = function(State) Window.VisualPreview.Components.HealthBar["Box"].Visible = State end})
                Temp:Colorpicker({Info = "Health Bar Outer Color", Default = Color3.fromRGB(0, 0, 0), Alpha = 0, Pointer = "PlayerESP_HealthBar_Color_Outline"})
                Temp:Colorpicker({Info = "Health Bar Low Color", Default = Color3.fromRGB(255, 0, 0), Pointer = "PlayerESP_HealthBar_Color_Low"})
                Temp:Colorpicker({Info = "Health Bar High Color", Default = Color3.fromRGB(0, 255, 0), Alpha = 0, Pointer = "PlayerESP_HealthBar_Color_High"})
                --
                Temp = EspSection:Toggle({Name = "Health Number", Default = false, Pointer = "PlayerESP_HealthNumber", callback = function(State) Window.VisualPreview.Components.HealthBar["Value"].Visible = State end})
                Temp:Colorpicker({Info = "Health Number Low Color", Default = Color3.fromRGB(255, 0, 0), Pointer = "PlayerESP_HealthNumber_Color_Low"})
                Temp:Colorpicker({Info = "Health Number High Color", Default = Color3.fromRGB(0, 255, 0), Alpha = 0, Pointer = "PlayerESP_HealthNumber_Color_High"})
                --
                EspSection:Toggle({Name = "Weapon", Default = false, Pointer = "PlayerESP_Weapon", callback = function(State) Window.VisualPreview.Components.Tool["Text"].Visible = State end}):Colorpicker({Info = "Weapon Color", Default = Color3.fromRGB(255, 255, 255), Alpha = 0, Pointer = "PlayerESP_Weapon_Color"})
                --
                EspSection:Toggle({Name = "Distance", Default = false, Pointer = "PlayerESP_Distance", callback = function(State) Window.VisualPreview.Components.Distance["Text"].Visible = State end})
                --
                EspSection:Toggle({Name = "Flags", Default = false, Pointer = "PlayerESP_Flag", callback = function(State) Window.VisualPreview.Components.Flags["Text"].Visible = State end})
            end
            --
            local CfgSection = EspPage:Section({Name = "Player ESP Configuration", Side = "Left"}) do
                --
                CfgSection:Slider({Name = "Minimum HP Visibility", Default = 95, Minimum = 0, Maximum = 115, Prefix = " HP", Decimals = 1, Pointer = "PlayerESP_Min_Health_Visibility_Cap"})
                --
                CfgSection:Toggle({Name = "Team Check", Default = false, Pointer = "PlayerESP_Team_Check"})
                --
                CfgSection:Dropdown({Name = "Text Case", Options = {"lowercase", "Normal", "UPPERCASE"}, Max = 3, Default = "Normal", Pointer = "PlayerESP_Text_Case"})
                --
                CfgSection:Slider({Name = "Max Text Length", Default = 36, Minimum = 0, Maximum = 36, Prefix = "", Decimals = 1, Pointer = "PlayerESP_Max_Text_Length"})
                --
                Temp = CfgSection:Toggle({Name = "Highlight Friend", Default = true, Pointer = "PlayerESP_Highlight_Friend"})
                Temp:Colorpicker({Info = "Highlight Friend Color", Default = Color3.fromRGB(0, 255, 0), Pointer = "PlayerESP_Highlight_Friend_Color"})
                --
                Temp = CfgSection:Toggle({Name = "Highlight Enemy", Default = true, Pointer = "PlayerESP_Highlight_Enemy"})
                Temp:Colorpicker({Info = "Highlight Enemy Color", Default = Color3.fromRGB(255, 0, 0), Pointer = "PlayerESP_Highlight_Enemy_Color"})
                --
                Temp = CfgSection:Toggle({Name = "Highlight Priority", Default = true, Pointer = "PlayerESP_Highlight_Priority"})
                Temp:Colorpicker({Info = "Highlight Priority Color", Default = Color3.fromRGB(255, 210, 0), Pointer = "PlayerESP_Highlight_Priority_Color"})
            end
        end
        --
        local VisualsPage = Window:Page({Name = "Visuals"}) do 
            local WorldSection = VisualsPage:Section({Name = "World", Side = "Left"}) do
                WorldSection:Toggle({Name = "Master Switch", Default = false, Pointer = "VisualsWorld_Master"})
                --
                Temp = WorldSection:Toggle({Name = "Custom Ambient", Default = false, Pointer = "VisualsWorld_Ambient"})
                Temp:Colorpicker({Info = "Outdoor Ambient", Default = Color3.fromRGB(127, 72, 163), Pointer = "VisualsWorld_Ambient_Outdoor_Color"})
                Temp:Colorpicker({Info = "Indoor Ambient", Default = Color3.fromRGB(127, 72, 163), Pointer = "VisualsWorld_Ambient_Indoor_Color"})
                --
                Temp = WorldSection:Toggle({Name = "Custom Color Shift", Default = false, Pointer = "VisualsWorld_CShift"})
                Temp:Colorpicker({Info = "Color Shift Bottom", Default = Color3.fromRGB(117, 76, 236), Pointer = "VisualsWorld_CShift_Bottom_Color"})
                Temp:Colorpicker({Info = "Color Shift Top", Default = Color3.fromRGB(117, 76, 236), Pointer = "VisualsWorld_CShift_Top_Color"})
                --
                WorldSection:Toggle({Name = "Force Time", Default = false, Pointer = "VisualsWorld_ForceTime"})
                --
                WorldSection:Slider({Name = "Time", Default = 12, Minimum = 0, Maximum = 24, Prefix = "hr", Decimals = 0.01, Pointer = "VisualsWorld_ForceTimeHr"})
                --
                WorldSection:Toggle({Name = "Custom Saturation", Default = false, Pointer = "VisualsWorld_Saturation"}):Colorpicker({Info = "Saturation Color", Default = Color3.fromRGB(117, 76, 236), Pointer = "VisualsWorld_SaturationA"})
                --
                WorldSection:Slider({Name = "Saturation", Default = 50, Minimum = 0, Maximum = 100, Prefix = "%", Decimals = 0.01, Pointer = "VisualsWorld_SaturationAA"})
            end
            --
            local CameraSection = VisualsPage:Section({Name = "Camera", Side = "Left"}) do
                --
                CameraSection:Toggle({Name = "Custom FOV", Default = false, Pointer = "VisualsCamera_FOV_Enabled"})
                --
                CameraSection:Slider({Name = "Field Of View:", Default = 90, Minimum = 0, Maximum = 120, Prefix = "°", Decimals = 0.01, Pointer = "VisualsCamera_FOV_FOV"})
                --[[--
                CameraSection:Button({Name = "No Blood-Screen", Pointer = "VisualsCamera_BloodScreen", Callback = function()
                end})
                --
                CameraSection:Button({Name = "No Helmet Overlay", Pointer = "VisualsCamera_HelmetOverlay", Callback = function()
                    LocalPlayer.PlayerGui:FindFirstChild("HelmetOverlayGUI").Enabled = false
                end})]]
            end
            --
            local RendersSection = VisualsPage:Section({Name = "Renders", Side = "Right"}) do
                --
                Temp = RendersSection:Toggle({Name = "Aim Assist", Default = true, Pointer = "VisualsFOV_AimAssist"})
                Temp:Colorpicker({Info = "Aim Assist FOV Outline", Default = Color3.fromRGB(56, 200, 200), Alpha = 0.75, Pointer = "VisualsFOV_AimAssist_Outline_Color"})
                Temp:Colorpicker({Info = "Aim Assist FOV", Default = Color3.fromRGB(55, 175, 165), Alpha = 0.65, Pointer = "VisualsFOV_AimAssist_Color"})
                --
                Temp = RendersSection:Toggle({Name = "Aim Assist Deadzone", Default = true, Pointer = "VisualsFOV_Deadzone"})
                Temp:Colorpicker({Info = "Aim Assist FOV Outline", Default = Color3.fromRGB(10, 15, 20), Alpha = 0.75, Pointer = "VisualsFOV_Deadzone_Outline_Color"})
                Temp:Colorpicker({Info = "Aim Assist FOV", Default = Color3.fromRGB(5, 12, 15), Alpha = 0.65, Pointer = "VisualsFOV_Deadzone_Color"})
            end
        end
        --
        local MiscPage = Window:Page({Name = "Misc"}) do 
            --
            local CharacterSection = MiscPage:Section({Name = "Local Character", Side = "Left"}) do
                CharacterSection:Toggle({Name = "Custom Walk Speed", Default = false, Pointer = "MiscCharacter_Ws_Enabled"}):Keybind({Default = nil, Mode = "Toggle", KeybindName = "Walkspeed", Pointer = "MiscCharacter_Ws_Key"})
                --
                CharacterSection:Slider({Default = 100, Minimum = 0, Maximum = 100, Prefix = "", Decimals = 0.01, Pointer = "MiscCharacter_Ws_Ws"})
                --
                CharacterSection:Dropdown({Options = {"Velocity", "Walkspeed"}, Max = 2, Default = "Velocity", Pointer = "MiscCharacter_Ws_Method"})
                --
                CharacterSection:Toggle({Name = "Custom Jump Power", Default = false, Pointer = "bitch"})
                --
                CharacterSection:Slider({Default = 50, Minimum = 0, Maximum = 100, Prefix = "", Decimals = 0.01, Pointer = "bitch1"})
            end
            --
            local MiscSection = MiscPage:Section({Name = "Miscellaneous", Side = "Right"}) do
                MiscSection:Toggle({Name = "Headless", Callback = function(State) loadfile("Utility/Headless.lua")({On = State}) end}):Keybind({Default = nil, Mode = "Toggle", KeybindName = "Headless", Pointer = "MiscHeadless_Key", Callback = function(State, State2) loadfile("Utility/Headless.lua")({On = State2}) end})
            end
        end
        --
        local PlayersPage = Window:Page({Name = "Players"}) do
            local PlayerList = PlayersPage:PlayerList({}) 
            --
            local SelectedSection = PlayersPage:Section({Name = "Selected Player", Side = "Left"}) do
                --
                SelectedSection:Button({Name = "Spectate / View", Pointer = "PlayerListSelectedPlayerView", Callback = function() 
                    if PlayerList:GetSelection()[1] ~= nil then
                        Workspace.Camera.CameraSubject = Players[tostring(PlayerList:GetSelection()[1])].Character:FindFirstChildOfClass("Humanoid")
                    end
                end})   
                --
                SelectedSection:Button({Name = "Unspectate / Unview", Pointer = "PlayerListSelectedPlayerUnview", Callback = function()
                    Workspace.Camera.CameraSubject = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                end})
            end
        end
        --
        local SettingsPage = Window:Page({Name = "Settings"}) do

            local ConfigsSection = SettingsPage:Section({Name = "Configs", side = "Left"}) do
                local current_list = {}
                -- 
                local function update_config_list()
                    local list = {}
                    for idx, file in ipairs(listfiles("Osiris/Configs")) do
                        local file_name = file:gsub("Osiris/Configs\\", ""):gsub(".txt", "")
                        list[#list + 1] = file_name
                    end
    
                    local is_new = #list ~= #current_list
                    if not is_new then
                        for idx, file in ipairs(list) do
                            if file ~= current_list[idx] then
                                is_new = true
                                break
                            end
                        end
                    end
    
                    if is_new then
                        current_list = list
                        Flags["settings/configuration/list"]:UpdateList(list, false, true)
                    end
                end
                --
                ConfigsSection:Listbox({pointer = "settings/configuration/list"})
                --
                ConfigsSection:TextBox({pointer = "settings/configuration/name", placeholder = "Config Name", text = "", middle = true})
                --
                ConfigsSection:Button({name = "Create", confirmation = true, callback = function()
                    local config_name = Flags["settings/configuration/name"]:Get()
                    if config_name == "" or isfile("Osiris/Configs/" .. config_name .. ".txt") then
                        return
                    end
                    writefile("Osiris/Configs/" .. config_name .. ".txt", "")
                    update_config_list()
                end})
                --
                ConfigsSection:Button({name = "Load", confirmation = true, callback = function()
                    local selected_config = Flags["settings/configuration/list"]:Get()[1][1]
                    if selected_config then
                        Window:LoadConfig(readfile("Osiris/Configs/" .. selected_config .. ".txt"))
                    end
                end})
                --
                ConfigsSection:Button({name = "Save", confirmation = true, callback = function()
                    local selected_config = Flags["settings/configuration/list"]:Get()[1][1]
                    print(Window:GetConfig())
                    writefile("Osiris/Configs/" .. selected_config .. ".txt", Window:GetConfig())
                end})
                --
                ConfigsSection:Button({name = "Delete", confirmation = true, callback = function()
                    local selected_config = Flags["settings/configuration/list"]:Get()[1][1]
                    if selected_config then
                        delfile("Osiris/Configs/" .. selected_config .. ".txt")
                        update_config_list()
                    end
                end})
                --
                ConfigsSection:Button({Name = "Unload", Callback = function() Window:Fade() task.wait(0.5) Window:Unload() Osiris:Unload() end})
            end
            --
            local ConfigSection = SettingsPage:Section({Name = "Configuration", side = "Left"}) do
                ConfigSection:Toggle({Pointer = "Safe", Default = Osiris.Safe, Name = "Safe Mode", Callback = function(State) Osiris.Safe = State end})

                ConfigSection:Toggle({Name = "Custom Menu Name", Flag = "ConfigMenu_CustomName", Default = false, Callback = function(State)
                    if State and Flags.ConfigMenu_Name and Flags["ConfigMenu_Name"]:Get() then
                        Window:SetName(("%s - %s - %s - (%s)"):format(Flags["ConfigMenu_Name"]:Get(), Osiris.Account.Game, Osiris.Account.Username, game.PlaceId)) 
                    else
                        Window:SetName(("%s - %s - %s - (%s)"):format("Osiris", Osiris.Account.Game, Osiris.Account.Username, game.PlaceId))
                    end
                end})
                ConfigSection:TextBox({Flag = "ConfigMenu_Name", Default = "Osiris", Max = 50, PlaceHolder = "Menu Name", Callback = function(State)
                    if Flags["ConfigMenu_CustomName"]:Get() then
                        Window:SetName(("%s - %s - %s - (%s)"):format(State, Osiris.Account.Game, Osiris.Account.Username, game.PlaceId))
                    end
                end})
            end
            --
            local MenuSection = SettingsPage:Section({Name = "Menu", Side = "Left"}) do
                --
                MenuSection:Keybind({Pointer = "Menu_Key", Name = "Toggle UI", KeybindName = "Toggle UI", Mode = "Toggle", Default = Enum.KeyCode.End, Callback = function(State) Window.uibind = State end})
                --
                MenuSection:Toggle({Pointer = "Menu_Watermark", Default = false, Name = "Watermark", Callback = function(State) Window.watermark:Update("Visible", State) end})
                --
                MenuSection:Toggle({Pointer = "Menu_KeybindList", Default = false, Name = "Keybind List", Callback = function(State) Window.keybindslist:Update("Visible", State) end})
                --
            end
            --
            local ThemeSection = SettingsPage:Section({Name = "Theme", Side = "Right"}) do
                ThemeSection:Dropdown({Name = "Theme", Flag = "Osiris_Theme", Default = "Default", Max = 8, Options = Osiris:GetTableIndexes(Themes, true)})
                ThemeSection:Button({Name = "Load", Callback = function() Library:LoadTheme(Flags["Osiris_Theme"]:Get()) end})
                ThemeSection:Colorpicker({Name = "Accent", Flag = "ConfigTheme_Accent", Default = Color3.fromRGB(93, 62, 152), Callback = function(Color) Library:UpdateColor("Accent", Color) end})
                ThemeSection:Colorpicker({Name = "Light Contrast", Flag = "ConfigTheme_LightContrast", Default = Color3.fromRGB(30, 30, 30), Callback = function(Color) Library:UpdateColor("LightContrast", Color) end})
                ThemeSection:Colorpicker({Name = "Dark Contrast", Flag = "ConfigTheme_DarkContrast", Default = Color3.fromRGB(20, 20, 20), Callback = function(Color) Library:UpdateColor("DarkContrast", Color) end})
                ThemeSection:Colorpicker({Name = "Outline", Flag = "ConfigTheme_Outline", Default = Color3.fromRGB(0, 0, 0), Callback = function(Color) Library:UpdateColor("Outline", Color) end})
                ThemeSection:Colorpicker({Name = "Inline", Flag = "ConfigTheme_Inline", Default = Color3.fromRGB(50, 50, 50), Callback = function(Color) Library:UpdateColor("Inline", Color) end})
                ThemeSection:Colorpicker({Name = "Light Text", Flag = "ConfigTheme_LightText", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) Library:UpdateColor("TextColor", Color) end})
                ThemeSection:Colorpicker({Name = "Dark Text", Flag = "ConfigTheme_DarkText", Default = Color3.fromRGB(175, 175, 175), Callback = function(Color) Library:UpdateColor("TextDark", Color) end})
                ThemeSection:Colorpicker({Name = "Text Outline", Flag = "ConfigTheme_TextBorder", Default = Color3.fromRGB(0, 0, 0), Callback = function(Color) Library:UpdateColor("TextBorder", Color) end})
                ThemeSection:Colorpicker({Name = "Cursor Outline", Flag = "ConfigTheme_CursorOutline", Default = Color3.fromRGB(10, 10, 10), Callback = function(Color) Library:UpdateColor("CursorOutline", Color) end})
                --ThemeSection:Dropdown({Name = "Accent Effect", Flag = "ConfigTheme_AccentEffect", Default = "None", Options = {"None", "Rainbow", "Shift", "Reverse Shift"}, Callback = function(State) if State == "None" then Library:UpdateColor("Accent", Flags["ConfigTheme_Accent"]:Get()) end end})
                --ThemeSection:Slider({Name = "Effect Length", Flag = "ConfigTheme_EffectLength", Default = 40, Maximum = 360, Minimum = 1, Decimals = 1})
            end
            --
            local ServerSection = SettingsPage:Section({Name = "Server", Side = "Right"}) do
                --
                ServerSection:Button({Name = "Rejoin", Callback = function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId) end})
                --
                ServerSection:Button({Name = "Copy JobId", Callback = function() setclipboard(game.JobId) end})
                --
                ServerSection:Button({Name = "Copy PlaceId", Callback = function() setclipboard(game.PlaceId) end})
                --
                ServerSection:Button({Name = "Copy Join Script", Callback = function() setclipboard(([[game:GetService("TeleportService"):TeleportToPlaceInstance(%s, "%s")]]):format(game.PlaceId, game.JobId)) end})
                --
            end
            --
        end
    end
    --
    Temp = nil
    --
    Window.wminfo = ("[%s]  -  [Account = $ACC [$UID],  Build = $BUILD,  Ping = $PING,  FPS = $FPS]"):format("Osiris"):gsub("$BUILD", "Developer"):gsub("$ACC", Osiris.Account.Username):gsub("$UID", Osiris.Account.UserID)
    --
    Window.uibind = Enum.KeyCode.End
    Window:Initialize()
    --
    Window.VisualPreview:SetPreviewState(false)
    --
    Library:LoadTheme((StartUpArguments.Theme or "Default"))
    --
    Osiris.Locals.Window = Window
end
--
do -- // Connections
    Osiris:Connection(RunService.RenderStepped, function()
        local AimAssist = (Flags["LegitAimAssist_Enabled"]:Get() == true)
        --
        if ((AimAssist and Flags["LegitAimAssist_EnabledKey"]:Active()) and (Flags["LegitAimAssist_Readjustment"]:Get() and Flags["LegitAimAssist_Readjustment_Key"]:Active()) and not Osiris.Locals.Window.isVisible) then
            Osiris:ThreadFunction(Osiris.GetAimAssistTarget, "1x01")
            Osiris:ThreadFunction(Osiris.AimAssist, "1x02")
        else
            Osiris.Locals.PossibleTarget = nil
            Osiris.Locals.Target = nil
        end
        --
        if (AimAssist and Flags["LegitAimAssist_EnabledKey"]:Active()) then
            Osiris:ThreadFunction(Osiris.UpdateFieldOfView, "1x03")
        end
        --
        if (Flags["LegitTriggerbot_Enabled"]:Get() and Flags["LegitTriggerbot_ReadjustmentKey"]:Active() and not Osiris.Locals.Window.isVisible) then
            Osiris:ThreadFunction(Osiris.GetTriggerBotTarget, "1x04")
            Osiris:ThreadFunction(Osiris.TriggerBot, "1x05")
        else
            Osiris.Locals.TriggerTarget = nil
        end
        --
        Osiris:ThreadFunction(Visuals.UpdateEsp, "2x01") 
        --
        Osiris:ThreadFunction(Visuals.Update, "3x01") 
    end)
    --
    Osiris:Connection(Players.PlayerAdded, function(Player)
        Visuals:Add(Player)
    end)
    --
    Osiris:Connection(Players.PlayerRemoving, function(Player) -- i hate niggers
        Visuals:Remove(Player)
    end)
    --
    for Index, Player in pairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer then
            Visuals:Add(Player)
        end
    end
end
--
do -- // Hooks
    local OldNewIndex; OldNewIndex = hookmetamethod(game, "__newindex", function(self, Key, Value) 
        local SelfName = tostring(self)
        --
        if not checkcaller() then
            if Key == "Ambient" and Flags["VisualsWorld_Ambient"]:Get() then
                Value = Flags["VisualsWorld_Ambient_Indoor_Color"]:Get().Color
            end
            if Key == "OutdoorAmbient" and Flags["VisualsWorld_Ambient"]:Get() then
                Value = Flags["VisualsWorld_Ambient_Outdoor_Color"]:Get().Color
            end
            if Key == "ClockTime" and Flags["visuals_world_force"] then
                Value = Flags["VisualsWorld_ForceTimeHr"]:Get().Color
            end
            --[[if Key == "FieldOfView" and Flags["visual_fov"] then
                Value = Flags["visual_fov_fov"]
            end]]
        end
        --
        return OldNewIndex(self, Key, Value)
    end)
end