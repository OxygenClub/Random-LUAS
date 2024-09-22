if not isfolder("gamertest") then
    makefolder("gamertest")
end

local PreloadedModules = {} do
    for Key, Module in rawget(getupvalue(getrenv().shared.require, 1), "_cache") do
        PreloadedModules[Key] = Module.module
    end 
end

local INew = Instance.new
local CNew, CAngles, CIdentity = CFrame.new, CFrame.Angles, CFrame.identity
local V2New, V2Zero = Vector2.new, Vector2.zero
local V3New, V3Zero, V3FromNormalId = Vector3.new, Vector3.zero, Vector3.fromNormalId
local RGB, HEX, HSV = Color3.fromRGB, Color3.fromHex, Color3.fromHSV
local TCreate, TFind, TInsert, TRemove, TClear, TUnpack, TSort = table.create, table.find, table.insert, table.remove, table.clear, table.unpack, table.sort
local TSpawn, TCancel = task.spawn, task.cancel
local SFind, SFormat, SLower = string.find, string.format, string.lower
local Rad, Floor, Clamp, Random, Min, Max, Abs = math.rad, math.floor, math.clamp, math.random, math.min, math.max, math.abs

local Debris = game:GetService("Debris")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Memory = {
    TickShift = 0,
    ChokedTicks = 0,
    LastScan = 0,

    Teleporting = false,
    ForceHidden = false,

    WeaponController = nil,
    Weapon = nil,
    MainCamera = nil,
    ClientEntry = nil,

    Entries = {},
    Functions = {},
    Modules = PreloadedModules,
    Tracers = {},
    Properties = {},

    Threads = {},
    Connections = {},
    Drawings = {},
    Ticks = {},

    ESP = {
        Frames = {},
        Chams = {},
        Cache = {},
    },
    
    Replication = {
        Position = V3Zero,
        LookAngles = V3Zero,
        AimPosition = V2Zero,
    },

    TimeUpdates = {
        ["newbullets"] = 3,
        ["equip"] = 2,
        ["spotplayers"] = 2,
        ["updatesight"] = 3,
        ["knifehit"] = 4,
        ["newgrenade"] = 3,
        ["repupdate"] = 3,
        ["bullethit"] = 6,
        ["ping"] = 3,
    },
}

local Menu, Toggles, Options = loadstring(game:HttpGet("https://pastebin.com/raw/UhVM4fwm", true))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/theonlylegacy/Libraries/main/Addons/SaveManager.lua"))()
local Flags = {
    ["Player Select"] = nil,

    ["Auto Wall"] = false,
    ["Origin Scanning"] = false,

    ["Friendly"] = {},
    ["Enemy"] = {},

    ["Hit Boxes"] = {},
    ["Multi Point"] = {},
    ["Point Types"] = {},
    ["Spoof Hit"] = "None",

    ["Scanning Frequency"] = 0,
    ["Origin Offset"] = 0,
    ["Point Offset"] = 1,
    ["Minimum Damage"] = 0,

    ["Auto Reload"] = false,
    ["Auto Chamber"] = false,
    ["Grab Ammo"] = false,
    ["Unlock Auto"] = false,
    ["Fire Rate"] = 0,
    ["Kill Sound"] = "None",

    ["Silent Aim"] = {
        Enabled = false,
        Type = "Blatant",
        Field = 0,
    },

    ["Ragebot"] = {
        Enabled = false,
        Types = {},
    },

    ["ESP"] = {
        Enabled = false,
        Settings = {},
    },

    ["Third Person"] = {
        Enabled = false,
        Zoom = 0,
    },

    ["Camera"] = {
        NoShake = false,
        NoSway = false,
        FieldOfView = 90,
    },

    ["Bullet Tracers"] = {
        Enabled = false,
        LifeTime = 0,
        Color = Menu.AccentColor,
    },

    ["Barrel Crosshair"] = {
        Enabled = false,
        Size = 0,
        Spacing = 0,
        Rotation = 0,
        Color = Menu.AccentColor,
    },

    ["Anti Aim"] = {
        Enabled = false,
        Yaw = "None",
        Pitch = "None",
        Rate = 1,
    },

    ["Fake Lag"] = {
        Enabled = false,
        Break = false,
        Tick = 0,
    },

    ["Speed Hack"] = {
        Enabled = false,
        Bypass = false,
        Velocity = 0,
    },

    ["Chams"] = {
        Weapon = false,
        Arms = false,
        ThirdPerson = false,

        WeaponColor = Menu.AccentColor,
        ArmColor = Menu.AccentColor,
        ThirdPersonColor = Menu.AccentColor,
    },

    ["Ambient"] = {
        Enabled = false,
        Color = Menu.AccentColor,
    },
}

local Sides = {
    Enum.NormalId.Top,
    Enum.NormalId.Front,
    Enum.NormalId.Left,
    Enum.NormalId.Right,
    Enum.NormalId.Back,
    Enum.NormalId.Bottom,
}

local Corners = {
    {1, 1, -1},
    {1, -1, -1},
    {-1, -1, -1},
    {-1, 1, -1},
    {1, 1, 1},
    {1, -1, 1},
    {-1, -1, 1},
    {-1, 1, 1},
}

local Effects = Memory.Modules.Effects
local GameClock = Memory.Modules.GameClock
local PhysicsLib = Memory.Modules.PhysicsLib
local WeaponUtils = Memory.Modules.WeaponUtils
local AudioSystem = Memory.Modules.AudioSystem
local NetworkClient = Memory.Modules.NetworkClient
local DesktopHitBox = Memory.Modules.DesktopHitBox
local TimeSyncClient = Memory.Modules.TimeSyncClient
local PublicSettings = Memory.Modules.PublicSettings
local BulletInterface = Memory.Modules.BulletInterface
local CameraInterface = Memory.Modules.CameraInterface
local ReplicationObject = Memory.Modules.ReplicationObject
local CharacterInterface = Memory.Modules.CharacterInterface
local ActiveLoadoutUtils = Memory.Modules.ActiveLoadoutUtils
local ReplicationInterface = Memory.Modules.ReplicationInterface
local HitDetectionInterface = Memory.Modules.HitDetectionInterface
local HudCrosshairsInterface = Memory.Modules.HudCrosshairsInterface
local PlayerSettingsInterface = Memory.Modules.PlayerSettingsInterface
local WeaponControllerInterface = Memory.Modules.WeaponControllerInterface
local PlayerDataClientInterface = Memory.Modules.PlayerDataClientInterface
local RoundSystemClientInterface = Memory.Modules.RoundSystemClientInterface

local Client = setmetatable({}, {__index = function(_, Key)
    local Player = Players.LocalPlayer
    local CharacterObject = CharacterInterface:getCharacterObject()
    local Entry = Memory.Entries[Player]

    if Key == "Player" then
        return Player
    end

    if Key == "Team" then
        return Player.Team
    end

    if Key == "CharacterObject" then
        return CharacterObject
    end

    if Key == "RootPart" then
        return CharacterObject and CharacterObject._rootPart
    end

    if Key == "Humanoid" then
        return CharacterObject and CharacterObject._humanoid
    end

    if Key == "Entry" then
        return Entry
    end

    if Key == "Thread" then
        return function(_, Key, Function)
            Memory.Threads[Key] = TSpawn(Function)
            return Memory.Threads[Key]
        end
    end

    if Key == "Connect" then
        return function(_, Key, Signal, Function)
            Memory.Connections[Key] = Signal:Connect(Function)
            return Memory.Connections[Key]
        end
    end

    if Key == "Draw" then
        return function(_, Key, Type, Properties)
            Memory.Drawings[Key] = Drawing.new(Type)

            for Property, Value in Properties do
                Memory.Drawings[Key][Property] = Value
            end

            return Memory.Drawings[Key]
        end
    end

    if Key == "Tick" then
        return function(_, Key, Time, Function)
            local CurrentTime = GameClock.getTime()
            
            if Memory.Ticks[Key] then
                if (CurrentTime - Memory.Ticks[Key]) >= Time then
                    Function()
                    Memory.Ticks[Key] = nil
                end
            else
                Function()
            end

            if Memory.Ticks[Key] == nil then
                Memory.Ticks[Key] = CurrentTime
            end
        end
    end
end})

local Solve = clonefunction(getupvalue(PhysicsLib.timehit, 2))
local BulletCheck = clonefunction(Memory.Modules.BulletCheck)
local Dot = V3Zero.Dot
local ToOrientation = CIdentity.ToOrientation
local VectorToWorldSpace = CIdentity.VectorToWorldSpace

local BulletAcceleration = PublicSettings.bulletAcceleration
local BulletLifeTime = PublicSettings.bulletLifeTime
local Inset = GuiService:GetGuiInset().Y
local CurrentCamera = Workspace.CurrentCamera

local ReplicateConnection = getconnections(ReplicatedStorage.UnreliableRemoteEvent.OnClientEvent)[1].Function
local Events = getupvalue(getconnections(ReplicatedStorage.RemoteEvent.OnClientEvent)[1].Function, 1)

local FakePlayer = INew("Player")
local CustomOverlay = INew("ScreenGui") do
    CustomOverlay.Name = "Overlay"
    CustomOverlay.DisplayOrder = 2
    CustomOverlay.Parent = CoreGui 
end

local RaycastParameters = RaycastParams.new() do
    RaycastParameters.FilterType = Enum.RaycastFilterType.Exclude
    RaycastParameters.FilterDescendantsInstances = {CurrentCamera, Workspace.Ignore, Workspace.Players}
end

local function Lerp(Current, Goal, Gain)
    return (1 - Gain) * Current + Gain * Goal
end

local function SolveMovement(Entry)
    if not Entry._smoothReplication or not Entry.step or not Entry.updateReplication then
        return
    end

    if Entry._smoothReplication._maxDelay ~= 0 then
        Entry._smoothReplication._maxDelay = 0
    end

    if Entry._smoothReplication._extrapolationLimit ~= 0 then
        Entry._smoothReplication._extrapolationLimit = 0
    end

    if not isourclosure(Entry._smoothReplication._interpolationFunc) then
        Entry._smoothReplication._interpolationFunc = function(a1, a2, a3, a4, a5)
            return a1
        end
    end

    if not isourclosure(Entry.step) then
        local __step = Entry.step
        Entry.step = function(Data, Replicate)
            if not Replicate then
                Replicate = true
            end

            return __step(Data, Replicate)
        end
    end

    if not isourclosure(Entry.updateReplication) then
        local __updateReplication = Entry.updateReplication
        Entry.updateReplication = function(Data, FrameCount, FrameTime, Position, LookAngles)
            if Entry._player ~= Client.Player then
                FrameTime = GameClock.getTime()
                Entry._smoothReplication:receive(FrameTime, FrameTime, {
                    t = FrameTime,
                    position = Position,
                    velocity = V3Zero,
                    angles = LookAngles,
                    breakcount = Entry._breakcount,
                }, false)

                Entry._updaterecieved = true
                Entry._receivedPosition = Position
                Entry._receivedFrameTime = FrameTime
                Entry._lastPacketTime = FrameTime
                Entry:step(3, true)
                return
            end

            return __updateReplication(Data, FrameCount, FrameTime, Position, LookAngles)
        end
    end
end

local function HideArms(Value)
    Memory.ForceHidden = Value

    for _, Part in CurrentCamera:GetDescendants() do
        if Part:IsA("BasePart") or Part:IsA("Texture") or Part:IsA("Decal") then
            Part.LocalTransparencyModifier = not Value and 0 or 1
        elseif Part:IsA("ImageLabel") then
            Part.Visible = not Value and true or false
        end
    end
end

local function GetPoints(Part, Size, Radius)
    local Size = Size * Radius
    local Points = TCreate(#Sides + #Corners + 1)
    local XDiv = Size.X / 2
    local YDiv = Size.Y / 2
    local ZDiv = Size.Z / 2
    
    if TFind(Flags["Point Types"], "Sides") then
        for Index = 1, #Sides do
            Points[#Points + 1] = {Part = Part, Position = Part.CFrame:PointToWorldSpace(V3FromNormalId(Sides[Index]) * Size)}
        end
    end
    
    if TFind(Flags["Point Types"], "Corners") then
        for _, Vector in Corners do
            Points[#Points + 1] = {Part = Part, Position = Part.CFrame:PointToWorldSpace(V3New(XDiv * Vector[1], YDiv * Vector[2], ZDiv * Vector[3]))}
        end
    end
    
    return Points
end

local function GetOrigins(Origin, Destination, Radius)
    local Origins = {}
    Origins[1] = CNew(Origin, Destination)

    if Flags["Origin Scanning"] then
        for Index = 1, #Sides do
            local Range = V3FromNormalId(Sides[Index]) * Radius
            Origins[#Origins + 1] = Origins[1] + Range
        end
    end
    
    return Origins
end

local function GetBounding(RootPart)
    local UpVector = CurrentCamera.CFrame.UpVector
    local TopScreenPosition, _ = CurrentCamera:WorldToScreenPoint(RootPart.Position + VectorToWorldSpace(RootPart.CFrame, V3New(0, 1.8, 0)) + UpVector)
    local BottomScreenPosition, _ = CurrentCamera:WorldToScreenPoint(RootPart.Position + VectorToWorldSpace(RootPart.CFrame, V3New(0, -2.5, 0)) - UpVector)

    local Width = Max(Abs(TopScreenPosition.X - BottomScreenPosition.X), 3)
    local Height = Max(Abs(BottomScreenPosition.Y - TopScreenPosition.Y), Width / 2, 3)

    local Size = V2New(Floor(Height / 1.5), Floor(Height))
    local Position = V2New(Floor((TopScreenPosition.X + BottomScreenPosition.X) / 2 - Size.X / 2), Floor(Min(TopScreenPosition.Y, BottomScreenPosition.Y)))

    return Position, Size
end

local function GetClientEntry()
    if Memory.ClientEntry then
        return Memory.ClientEntry
    end

    setupvalue(Events.swapweapon, 1, FakePlayer)
    setupvalue(ReplicateConnection, 4, FakePlayer)
    setupvalue(ReplicationObject.new, 3, FakePlayer)

    ReplicationInterface.addEntry(Client.Player)
    setupvalue(ReplicationObject.new, 3, Client.Player)

    local Loadout = ActiveLoadoutUtils.getActiveLoadoutData(PlayerDataClientInterface.getPlayerData())
    local Entry = ReplicationInterface.getEntry(Client.Player)

    Entry:spawn(V3Zero, Loadout)
    RunService:BindToRenderStep("Fast Replication", Enum.RenderPriority.Input.Value, function()
        local CharacterObject = Client .CharacterObject
        local RootPart = Client.RootPart
        local Entry = Memory.ClientEntry
        local ThirdPersonObject = Entry and Entry:getThirdPersonObject()

        if Flags["Fake Lag"].Enabled and Flags["Fake Lag"].Tick > 0 then
            return
        end

        if CharacterObject and RootPart and ThirdPersonObject then
            local Stance = CharacterObject:getMovementMode()
            local Position = RootPart.Position
            local LookAngles = Memory.Replication.LookAngles

            if Position then
                Entry._posspring.t = Position
                Entry._posspring.p = Position 
            end

            if LookAngles then
                Entry._lookangles._p0 = LookAngles
                Entry._lookangles._p1 = LookAngles
            end

            ThirdPersonObject:setStance(string.lower(Stance))
        end
    end)

    local __despawn = Entry.despawn
    Entry.despawn = function(...)
        local ThirdPersonObject = __despawn(...)

        RunService:UnbindFromRenderStep("Fast Replication")

        if ThirdPersonObject then
            local CharacterModel = ThirdPersonObject:popCharacterModel()

            if CharacterModel then
                CharacterModel:Destroy()
                CharacterModel = nil
            end

            ThirdPersonObject:Destroy()
        end

        ReplicationInterface.removeEntry(Client.Player)
        setupvalue(Events.swapweapon, 1, Client.Player)
        setupvalue(ReplicateConnection, 4, Client.Player)

        Memory.ClientEntry = nil
    end

    return Entry
end

local function GetCrosshair()
    if Memory.Crosshair then
        return
    end
    
    local Crosshair = {}
    local SizeX = UDim2.new(0, 10, 0, 2)
    local SizeY = UDim2.new(0, 2, 0, 10)

    local Holder = INew("Frame")
    Holder.Name = "Holder"
    Holder.BackgroundTransparency = 1
    Holder.BorderSizePixel = 0
    Holder.AnchorPoint = V2New(0.5, 0.5)
    Holder.Position = UDim2.new(0.5, 0, 0.5, 0)
    Holder.Size = UDim2.new(0, 125, 0, 125)
    Holder.Parent = CustomOverlay
    Crosshair.Holder = Holder

    local Top = INew("Frame")
    Top.Name = "Top"
    Top.BackgroundColor3 = RGB(255, 255, 255)
    Top.BorderColor3 = RGB(0, 0, 0)
    Top.Size = SizeY
    Top.Position = UDim2.new(0.5, -SizeY.X.Offset / 2, 0.5, -10 - SizeY.Y.Offset)
    Top.Parent = Holder
    Crosshair.Top = Top

    local Bottom = INew("Frame")
    Bottom.Name = "Top"
    Bottom.BackgroundColor3 = RGB(255, 255, 255)
    Bottom.BorderColor3 = RGB(0, 0, 0)
    Bottom.Size = SizeY
    Bottom.Position = UDim2.new(0.5, -SizeY.X.Offset / 2, 0.5, 10)
    Bottom.Parent = Holder
    Crosshair.Bottom = Bottom

    local Left = INew("Frame")
    Left.Name = "Left"
    Left.BackgroundColor3 = RGB(255, 255, 255)
    Left.BorderColor3 = RGB(0, 0, 0)
    Left.Size = SizeX
    Left.Position = UDim2.new(0.5, -10 - SizeX.X.Offset, 0.5, -SizeY.Y.Offset / 2)
    Left.Parent = Holder
    Crosshair.Left = Left

    local Right = INew("Frame")
    Right.Name = "Top"
    Right.BackgroundColor3 = RGB(255, 255, 255)
    Right.BorderColor3 = RGB(0, 0, 0)
    Right.Size = SizeX
    Right.Position = UDim2.new(0.5, 10, 0.5, -SizeX.Y.Offset / 2)
    Right.Parent = Holder
    Crosshair.Right = Right

    return Crosshair
end

local function GetFrame()
    local Frame = INew("Frame")
    Frame.Position = UDim2.new(0.24502401053905487, 0, 0.4430667459964752, 0)
    Frame.Size = UDim2.new(0, 155, 0, 243)
    Frame.BackgroundColor3 = RGB(255, 255, 255)
    Frame.BorderColor3 = RGB(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.BackgroundTransparency = 1
    Frame.Visible = false

    local UIStroke = INew("UIStroke")
    UIStroke.Name = "UIStroke"
    UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
    UIStroke.Thickness = 3
    UIStroke.Parent = Frame

    local Box = INew("Frame")
    Box.Name = "Box"
    Box.Position = UDim2.new(0, -1, 0, -1)
    Box.Size = UDim2.new(1, 2, 1, 2)
    Box.BackgroundColor3 = RGB(255, 255, 255)
    Box.BorderColor3 = RGB(0, 0, 0)
    Box.BorderSizePixel = 0
    Box.BackgroundTransparency = 1
    Box.Parent = Frame

    local UIStroke = INew("UIStroke")
    UIStroke.Name = "UIStroke"
    UIStroke.Color = RGB(255, 255, 255)
    UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
    UIStroke.Parent = Box

    local Fill = INew("ImageLabel")
    Fill.Name = "Fill"
    Fill.Position = UDim2.new(0, 1, 0, 1)
    Fill.Size = UDim2.new(1, -2, 1, -2)
    Fill.BackgroundColor3 = RGB(212, 212, 212)
    Fill.BorderColor3 = RGB(0, 0, 0)
    Fill.BorderSizePixel = 0
    Fill.BackgroundTransparency = 0.5
    Fill.Visible = true
    Fill.Parent = Box

    local HealthOutline = INew("Frame")
    HealthOutline.Name = "HealthOutline"
    HealthOutline.Position = UDim2.new(0, -7, 0, -2)
    HealthOutline.Size = UDim2.new(0, 2, 1, 4)
    HealthOutline.BackgroundColor3 = RGB(0, 0, 0)
    HealthOutline.BorderColor3 = RGB(0, 0, 0)
    HealthOutline.Parent = Frame

    local HealthInline = INew("Frame")
    HealthInline.Name = "HealthInline"
    HealthInline.Size = UDim2.new(0, 2, 1, 0)
    HealthInline.BackgroundColor3 = RGB(34, 227, 50)
    HealthInline.BorderColor3 = RGB(0, 0, 0)
    HealthInline.BorderSizePixel = 0
    HealthInline.Parent = HealthOutline
    
    local HealthText = INew("TextLabel")
    HealthText.Name = "HealthText"
    HealthText.Position = UDim2.new(0, -18, 0, -2)
    HealthText.Size = UDim2.new(0, 20, 0, 13)
    HealthText.BackgroundColor3 = RGB(255, 255, 255)
    HealthText.BorderColor3 = RGB(0, 0, 0)
    HealthText.BorderSizePixel = 0
    HealthText.TextStrokeTransparency = 0.4
    HealthText.BackgroundTransparency = 1
    HealthText.FontFace = Menu.Font
    HealthText.TextColor3 = Menu.AccentColor
    HealthText.TextSize = 8
    HealthText.RichText = true
    HealthText.Text = "100"
    HealthText.TextXAlignment = Enum.TextXAlignment.Right
    HealthText.Parent = HealthInline

    local UIListLayout = INew("UIListLayout")
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    UIListLayout.Parent = HealthOutline

    local NameText = INew("TextLabel")
    NameText.Name = "NameText"
    NameText.Position = UDim2.new(0, -3, 0, -19)
    NameText.Size = UDim2.new(1, 6, 0.006010172888636589, 13)
    NameText.BackgroundColor3 = RGB(255, 255, 255)
    NameText.BorderColor3 = RGB(0, 0, 0)
    NameText.BorderSizePixel = 0
    NameText.TextStrokeTransparency = 0.4
    NameText.BackgroundTransparency = 1
    NameText.FontFace = Menu.Font
    NameText.TextColor3 = RGB(255, 255, 255)
    NameText.TextSize = 8
    NameText.RichText = true
    NameText.Text = ""
    NameText.TextYAlignment = Enum.TextYAlignment.Bottom
    NameText.Parent = Frame

    local WeaponText = INew("TextLabel")
    WeaponText.Name = "WeaponText"
    WeaponText.Position = UDim2.new(0, -3, 1, 3)
    WeaponText.Size = UDim2.new(1, 6, 0.006010172888636589, 13)
    WeaponText.BackgroundColor3 = RGB(255, 255, 255)
    WeaponText.BorderColor3 = RGB(0, 0, 0)
    WeaponText.BorderSizePixel = 0
    WeaponText.TextStrokeTransparency = 0.4
    WeaponText.BackgroundTransparency = 1
    WeaponText.FontFace = Menu.Font
    WeaponText.TextColor3 = RGB(255, 255, 255)
    WeaponText.TextSize = 8
    WeaponText.RichText = true
    WeaponText.Text = ""
    WeaponText.Parent = Frame

    return Frame
end

local function GetTrajectory(Direction, Acceleration, Velocity)
    if not Direction  or not Acceleration or not Velocity then
        return
    end

    local VelocitySquared = Dot(V3Zero, V3Zero)
    local DirectionSquared = Dot(Direction, Direction)
    local Root1, Root2, Root3, Root4 = Solve(Dot(Acceleration, Acceleration) * 0.25, VelocitySquared, DirectionSquared + VelocitySquared - Velocity ^ 2, VelocitySquared * 2, DirectionSquared)
    
    local Time = (Root1 > 0 and Root1) or (Root2 > 0 and Root2) or (Root3 > 0 and Root3) or Root4
    local Bullet = (Direction + V3Zero * Time + 0.5 * Acceleration * Time ^ 2) / Time
    
    return Bullet, Time
end

local function GetIntersectionPoint(Direction, Acceleration, Velocity)
    if not Direction or not Acceleration or not Velocity then
        return
    end

    local Root1, Root2, Root3, Root4 = Solve(Dot(-Acceleration, -Acceleration) / 4, 0, Dot(-Acceleration, Direction) - Velocity * Velocity, 0, Dot(Direction, Direction))
    if Root1 and Root1 > 0 then
        return -Acceleration * Root1 / 2 + Direction / Root1, Root1
    elseif Root2 and Root2 > 0 then
        return -Acceleration * Root2 / 2 + Direction / Root2, Root2
    elseif Root3 and Root3 > 0 then
        return -Acceleration * Root3 / 2 + Direction / Root3, Root3
    elseif Root4 and Root4 > 0 then
        return -Acceleration * Root4 / 2 + Direction / Root4, Root4
    end
end

local function GetDamage(Origin, Destination, Name)
    local WeaponData = Memory.Weapon and Memory.Weapon:getWeaponData()
    if not WeaponData or Memory.Weapon:getWeaponType() ~= "Firearm" then
        return false
    end

    local Damage = WeaponUtils.interpolateDamageGraph(WeaponData["damageGraph"], (Origin - Destination).Magnitude)
    if Name == "Head" then
        Damage *= WeaponData["multhead"] or 1
    elseif Name == "Torso" then
        Damage *= WeaponData["multtorso"] or 1
    end

    return Damage
end

local function CanDamage(Origin, Destination, PenetrationDepth, Velocity)
    local Magnitude, BulletTrajectory = GetIntersectionPoint(Destination - Origin, BulletAcceleration, Velocity)
    if not Magnitude or not BulletTrajectory then
        return false
    end

    return BulletCheck(Origin, Destination, Magnitude.Unit * Velocity, BulletAcceleration, PenetrationDepth)
end

local function Scan(Entry, CharacterHash)
    local WeaponData = Memory.Weapon and Memory.Weapon:getWeaponData()
    if not WeaponData or Memory.Weapon:getWeaponType() ~= "Firearm" or not Entry._alive or not Memory.Replication.Position then
        return false, nil, nil, nil
    end

    if (GameClock.getTime() - Memory.LastScan) < Flags["Scanning Frequency"] then
        return
    end

    local Hitboxes = {}
    local Points = {}

    for Name, Part in CharacterHash do
        if TFind(Flags["Hit Boxes"], Name) then
            TInsert(Hitboxes, {
                Part = Part,
                Name = Name,
                Position = Part.Position,
            })
        end
    end

    for _, Hitbox in Hitboxes do
        if TFind(Flags["Multi Point"], Hitbox.Name) then
            for _, Point in GetPoints(Hitbox.Part, DesktopHitBox[Hitbox.Name].size, Flags["Point Offset"]) do
                Point.Part = Hitbox
                TInsert(Points, Point)
            end
        else
            TInsert(Points, {
                Part = Hitbox,
                Position = Hitbox.Position,
                Side = nil,
            })
        end
    end

    local Valids = TCreate(#Hitboxes * #Sides)
    local Result = false
    local Origin = nil
    local Destination = nil
    local Hitbox = nil

    for _, Point in Points do
        local Penetration = Flags["Auto Wall"] and WeaponData["penetrationdepth"] or 0

        if CanDamage(Memory.Replication.Position, Point.Position, Penetration, WeaponData["bulletspeed"]) then
            TInsert(Valids, Point)

            break
        end

        if Flags["Origin Scanning"] then
            local Origins = GetOrigins(Memory.Replication.Position, Point.Position, Flags["Origin Offset"])

            for _, CFrameOrigin in Origins do
                local OriginPosition = CFrameOrigin.Position
                
                if CanDamage(OriginPosition, Point.Position, Penetration, WeaponData["bulletspeed"]) then
                    Result = true
                    Origin = OriginPosition
                    Destination = Point.Position
                    Hitbox = Point.Part

                    TInsert(Valids, Point)
                    break
                end
            end
        end
    end

    if Result then
        return Result, Origin, Destination, Hitbox
    end

    local CurrentDamage = 0
    local CurrentPoint = nil
    for _, Point in Valids do
        local Damage = GetDamage(Memory.Replication.Position, Point.Position, Flags["Spoof Hit"] ~= "None" and Flags["Spoof Hit"] or Point.Part.Name)

        if Flags["Minimum Damage"] == 0 then
            CurrentDamage = Damage
            CurrentPoint = Point
            break
        end

        if Damage < Flags["Minimum Damage"] or Damage < CurrentDamage then
            continue
        end

        CurrentDamage = Damage
        CurrentPoint = Point
    end

    Result = CurrentPoint and true
    Destination = CurrentPoint and CurrentPoint.Position
    Hitbox = CurrentPoint and CurrentPoint.Part

    return Result, Memory.Replication.Position, Destination, Hitbox
end

local function Shoot(Destination, Origin, FakeShoot, Player, Hitbox)
    if not Memory.Weapon or not Memory.MainCamera or RoundSystemClientInterface.roundLock then
        return
    end

    local FireRound = Memory.Weapon.fireRound
    local WeaponData = Memory.Weapon:getWeaponData()
    local MagCount = Memory.Weapon.getMagCount and Memory.Weapon:getMagCount()
    local IsAiming = Memory.Weapon:isAiming()
    local BarrelPart = Memory.Weapon._barrelPart
    local UniqueId = Memory.Weapon.uniqueId
    if not FireRound or not WeaponData or not MagCount or not BarrelPart or not UniqueId or MagCount <= 0 then
        return
    end

    local Time = GameClock.getTime()
    local PelletCount = WeaponData["pelletcount"] or 1
    local BulletVelocity, LandTime = GetTrajectory(Destination - Origin, -BulletAcceleration, WeaponData["bulletspeed"])
    local Bullets = {}

    for Index = 1, PelletCount do
        local BulletTicket = getupvalue(FireRound, 11) + 1

        setupvalue(FireRound, 11, BulletTicket)
        Bullets[Index] = {BulletVelocity, BulletTicket}
    end

    local ShootData = {
        ["camerapos"] = Memory.MainCamera._baseCFrame.Position,
        ["firepos"] = Origin,
        ["bullets"] = Bullets,
    }

    if FakeShoot then
        Memory.Weapon:decrementMagCount()
        Effects.muzzleflash(BarrelPart, WeaponData["hideflash"], 0.9)

        local UsingGlassHack = PlayerSettingsInterface.getValue("toggleglasshacktracers") and IsAiming and not Memory.Weapon:isBlackScoped() and WeaponData["sightObject"]
        if UsingGlassHack then
            UsingGlassHack = WeaponData["sightObject"]:isApertureVisible()
        end
        
        BulletInterface.newBullet({
            ["position"] = Origin,
            ["velocity"] = WeaponData["bulletspeed"] * BulletVelocity,
            ["acceleration"] = (WeaponData["bulletaccel"] or 0) * BulletVelocity + BulletAcceleration,
            ["color"] = WeaponData["bulletcolor"] or RGB(255, 94, 94),
            ["size"] = 0.2,
            ["bloom"] = 0.005,
            ["brightness"] = WeaponData["bulletbrightness"] or 400,
            ["life"] = BulletLifeTime,
            ["visualorigin"] = Origin,
            ["physicsignore"] = {
                Workspace.Players,
                Workspace.Terrain,
                Workspace.Ignore,
                CurrentCamera,
            },
            ["dt"] = Time - Memory.Weapon._nextShot,
            ["penetrationdepth"] = WeaponData["penetrationdepth"],
            ["tracerless"] = WeaponData["tracerless"],
            ["onplayerhit"] = getupvalue(FireRound, 15),
            ["usingGlassHack"] = UsingGlassHack,
            ["extra"] = {
                ["playersHit"] = {},
                ["bulletTicket"] = getupvalue(FireRound, 11) + 1,
                ["firstHits"] = Bullets,
                ["firearmObject"] = Memory.Weapon,
                ["uniqueId"] = UniqueId
            },
            ["ontouch"] = HitDetectionInterface.hitDetection
        })

        if WeaponData["type"] == "SNIPER" then
            AudioSystem.play("metalshell", 0.1)
        elseif WeaponData["type"] == "SHOTGUN" then
            AudioSystem.play("shotWeaponshell", 0.2)
        elseif WeaponData["type"] == "REVOLVER" and not WeaponData["caselessammo"] then
            AudioSystem.play("metalshell", 0.15, 0.8)
        end

        if not IsAiming then
            HudCrosshairsInterface.fireImpulse(WeaponData["crossexpansion"])
        end

        if WeaponData["sniperbass"] then
            AudioSystem.play("1PsniperBass", 0.75)
            AudioSystem.play("1PsniperEcho", 1)
        end

        AudioSystem.playSoundId(WeaponData["firesoundid"], 2, WeaponData["firevolume"], WeaponData["firepitch"], BarrelPart, nil, 0, 0.05)
    end

    NetworkClient:send("newbullets", UniqueId, ShootData, Time, "CHEAT")
    for Index = 1, #Bullets do
        local Bullet = Bullets[Index]
        local HitData = {
            Player,
            Destination,
            Flags["Spoof Hit"] ~= "None" and Flags["Spoof Hit"] or Hitbox.Name,
            Bullet[2],
            Time,
        }

        NetworkClient:send("bullethit", UniqueId, table.unpack(HitData))
    end
    
    HudCrosshairsInterface.fireHitmarker(Flags["Spoof Hit"] == "Head" or Hitbox.Name == "Head")
end

local function Stab(Player, Name, Position)
    if not Memory.Weapon or RoundSystemClientInterface.roundLock then
        return
    end

    NetworkClient:send("knifehit", Player, Name, Position, GameClock.getTime())
end

local function GetClosestPlayer(Field)
    local CurrentDistance = 9e9
    local CurrentPlayer = nil

    for Player, Entry in Memory.Entries do
        local ThirdPersonObject = Entry:getThirdPersonObject()
        local CharacterHash = ThirdPersonObject and ThirdPersonObject:getCharacterHash()

        if Player == Client.Player or Player.Team == Client.Team or TFind(Flags["Friendly"], Player.UserId) or not CharacterHash then
            continue
        end

        local OnScreenPosition, VisibleOnScreen = CurrentCamera:WorldToScreenPoint(CharacterHash["Torso"].Position)
        if not VisibleOnScreen then
            continue
        end

        local Result, Origin, Destination, Hitbox = Scan(Entry, CharacterHash)
        if not Result then
            continue
        end

        local Distance = (V2New(Memory.Replication.AimPosition.X, Memory.Replication.AimPosition.Y + Inset) - V2New(OnScreenPosition.X, OnScreenPosition.Y)).Magnitude
        if Distance > Field or Distance > CurrentDistance then
            continue
        end

        CurrentDistance = Distance
        CurrentPlayer = {
            Player = Player,
            Entry = Entry,
            ThirdPersonObject = ThirdPersonObject,
            CharacterHash = CharacterHash,
            Result = {
                Origin = Origin,
                Destination = Destination,
                Hitbox = Hitbox,
            },
        }
    end

    return CurrentPlayer
end

Client:Thread("Main", function()
    while true do
        Client:Tick("Task Scheduler", 0.1, function()
            Memory.Entries = getupvalue(ReplicationInterface.getEntry, 1)
            Memory.WeaponController = WeaponControllerInterface:getActiveWeaponController()
            Memory.Weapon = Memory.WeaponController and Memory.WeaponController:getActiveWeapon()
            Memory.MainCamera = Memory.WeaponController and CameraInterface.getActiveCamera("MainCamera")
        end)

        if not Memory.WeaponController then
            Memory.Replication.Position = nil
            Memory.Replication.LookAngles = nil

            TClear(Memory.Functions)
            TClear(Memory.Properties)

            Client:Tick("ESP Deletion", 1, function()
                for Key, Frame in Memory.ESP.Frames do
                    Frame:Destroy()
                    Memory.ESP.Frames[Key] = nil
                end
            end)
            
            Client:Tick("Cham Deletion", 1, function()
                for _, Name in Memory.ESP.Chams do
                    for _, BoxHandleAdornment in Name do
                        BoxHandleAdornment:Destroy()
                    end
                end
            end)

            local Crosshair = Memory.Crosshair
            local Entry = Memory.ClientEntry

            if Crosshair then
                Memory.Crosshair.Holder:Destroy()
                Memory.Crosshair = nil
            end

            if Entry then
                Entry:despawn()
            end
        end

        if Memory.Weapon and Memory.Weapon:getWeaponType() == "Firearm" then
            local BarrelPart = Memory.Weapon._barrelPart
            local ClientEntry = Memory.ClientEntry
            local ThirdPersonObject = ClientEntry and ClientEntry:getThirdPersonObject()
            local Origin = ThirdPersonObject and ThirdPersonObject._weapon.Flame or BarrelPart
            
            local Hit, Position = Workspace:FindPartOnRayWithIgnoreList(Ray.new(Origin.Position, Origin.CFrame.LookVector * 1000), {Workspace.Ignore, CurrentCamera})
            if Hit and Position then
                local OnScreenPosition, VisibleOnScreen = CurrentCamera:WorldToScreenPoint(Position)

                if VisibleOnScreen then
                    Memory.Replication.AimPosition = OnScreenPosition
                else
                    Memory.Replication.AimPosition = V2Zero
                end
            end
        else
            Memory.Replication.AimPosition = V2Zero
        end

        if Flags["Silent Aim"].Enabled and Memory.Replication.AimPosition ~= V2Zero then
            if not Memory["FOV CIRCLE"] then
                Memory["FOV CIRCLE"] = Client:Draw("FOV CIRCLE", "Circle", {
                    Radius = 0,
                    Thickness = 1,
                    Position = V2Zero,
                    Color = RGB(255, 255, 255),
                    Filled = false,
                    Visible = true,
                })
            end

            local Circle = Memory["FOV CIRCLE"]
            Circle.Radius = Flags["Silent Aim"].Field
            Circle.Position = V2New(Memory.Replication.AimPosition.X, Memory.Replication.AimPosition.Y + Inset)
        else
            if Memory["FOV CIRCLE"] then
                Memory["FOV CIRCLE"]:Remove()
                Memory["FOV CIRCLE"] = nil
            end
        end

        if Flags["Barrel Crosshair"].Enabled then
            if Memory.WeaponController and not Memory.Crosshair then
                Memory.Crosshair = GetCrosshair()
            end

            local Crosshair = Memory.Crosshair
            local Holder = Crosshair and Crosshair.Holder
            local Top = Crosshair and Crosshair.Top
            local Bottom = Crosshair and Crosshair.Bottom
            local Left = Crosshair and Crosshair.Left
            local Right = Crosshair and Crosshair.Right

            if Crosshair and Memory.Replication.AimPosition ~= V2Zero then
                local Settings = Flags["Barrel Crosshair"]
                local Color = Settings.Color
                local Size = Settings.Size
                local Spacing = Settings.Spacing
                local Rotation = Settings.Rotation
    
                local SizeX = UDim2.new(0, Size, 0, 2)
                local SizeY = UDim2.new(0, 2, 0, Size)
    
                Top.BackgroundColor3 = Color
                Top.Size = SizeY
                Top.Position = UDim2.new(0.5, -SizeY.X.Offset / 2, 0.5, -Spacing - SizeY.Y.Offset / 2)
    
                Bottom.BackgroundColor3 = Color
                Bottom.Size = SizeY
                Bottom.Position = UDim2.new(0.5, -SizeY.X.Offset / 2, 0.5, Spacing - SizeY.Y.Offset / 2)
                                        
                Left.BackgroundColor3 = Color
                Left.Size = SizeX
                Left.Position = UDim2.new(0.5, -Spacing - SizeX.X.Offset / 2, 0.5, -SizeX.Y.Offset / 2)
    
                Right.BackgroundColor3 = Color
                Right.Size = SizeX
                Right.Position = UDim2.new(0.5, Spacing - SizeX.X.Offset / 2, 0.5, -SizeX.Y.Offset / 2)

                Holder.Visible = true
                Holder.Position = UDim2.new(0, Memory.Replication.AimPosition.X, 0, Memory.Replication.AimPosition.Y)
                Holder.Rotation = Rotation == 0 and 0 or Holder.Rotation + Rotation
            else
                if Holder then
                    Holder.Visible = false
                end
            end
        end

        if Flags["ESP"].Enabled and Memory.WeaponController then
            for Player, Entry in Memory.Entries do
                local Frame = Memory.ESP.Frames[Player.Name]

                if Player == Client.Player or Player.Team == Client.Team then
                    if Memory.ESP.Frames[Player.Name] then
                        Memory.ESP.Frames[Player.Name]:Destroy()
                        Memory.ESP.Frames[Player.Name] = nil
                    end

                    continue
                end

                local ThirdPersonObject = Entry:getThirdPersonObject()
                local CharacterHash = ThirdPersonObject and ThirdPersonObject:getCharacterHash()
                if not CharacterHash then
                    if Memory.ESP.Cache[Frame] then
                        local Torso = Memory.ESP.Cache[Frame]
                        local BoxPosition, BoxSize = GetBounding(Torso)
                        local _, VisibleOnScreen = CurrentCamera:WorldToScreenPoint(Torso.Position)
        
                        Frame.Size = UDim2.fromOffset(BoxSize.X - 2, BoxSize.Y - 2)
                        Frame.Position = UDim2.fromOffset(BoxPosition.X + 1, BoxPosition.Y + 1)
                        Frame.Visible = VisibleOnScreen
                    end
                end

                if not Frame then
                    local Frame = GetFrame()
                    Frame.Name = SFormat("%s-ESP", Player.Name)
                    Frame.Parent = CustomOverlay

                    Memory.ESP.Frames[Player.Name] = Frame
                end
                
                if Frame then
                    local UIStroke = Frame.UIStroke
                    local NameText = Frame.NameText
                    local WeaponText = Frame.WeaponText
                    local HealthOutline = Frame.HealthOutline
                    local HealthInline = HealthOutline.HealthInline
                    local HealthText = HealthInline.HealthText
                    local Box = Frame.Box
                    local BoxStroke = Box.UIStroke
                    local Fill = Box.Fill
                    
                    local Torso = CharacterHash and CharacterHash["Torso"]
                    local Health, MaxHealth = Entry:getHealth()
                    local HealthScale = Health / MaxHealth

                    if not Torso then
                        UIStroke.Transparency = Lerp(UIStroke.Transparency, 1, 0.1)
                        NameText.TextTransparency = Lerp(NameText.TextTransparency, 1, 0.1)
                        WeaponText.TextTransparency = Lerp(WeaponText.TextTransparency, 1, 0.1)
                        HealthOutline.Transparency = Lerp(HealthOutline.Transparency, 1, 0.1)
                        HealthInline.Transparency = Lerp(HealthInline.Transparency, 1, 0.1)
                        HealthText.TextTransparency = Lerp(HealthText.TextTransparency, 1, 0.1)
                        BoxStroke.Transparency = Lerp(BoxStroke.Transparency, 1, 0.1)
                        Fill.BackgroundTransparency = Lerp(Fill.BackgroundTransparency, 1, 0.05)
                    else
                        UIStroke.Transparency = Lerp(UIStroke.Transparency, 0, 0.1)
                        NameText.TextTransparency = Lerp(NameText.TextTransparency, 0, 0.1)
                        WeaponText.TextTransparency = Lerp(WeaponText.TextTransparency, 0, 0.1)
                        HealthOutline.Transparency = Lerp(HealthOutline.Transparency, 0, 0.1)
                        HealthInline.Transparency = Lerp(HealthInline.Transparency, 0, 0.1)
                        HealthText.TextTransparency = Lerp(HealthText.TextTransparency, 0, 0.1)
                        BoxStroke.Transparency = Lerp(BoxStroke.Transparency, 0, 0.1)
                        Fill.BackgroundTransparency = Lerp(Fill.BackgroundTransparency, 0.5, 0.05)
                    end

                    if not Torso then
                        continue
                    end

                    local _, VisibleOnScreen = CurrentCamera:WorldToScreenPoint(Torso.Position)
                    if not VisibleOnScreen then
                        Frame.Visible = false
                        continue
                    end

                    local Color = TFind(Flags["Friendly"], Player.UserId) and {0, 255, 0} or TFind(Flags["Enemy"], Player.UserId) and {255, 0, 0} or {255, 255, 255}
                    local BoxPosition, BoxSize = GetBounding(Torso)
                    Memory.ESP.Cache[Frame] = {
                        ["CFrame"] = Torso.CFrame,
                        ["Position"] = Torso.Position,
                    }
                    
                    Frame.Size = UDim2.fromOffset(BoxSize.X - 2, BoxSize.Y - 2)
                    Frame.Position = UDim2.fromOffset(BoxPosition.X + 1, BoxPosition.Y + 1)
                    Frame.Visible = true
                    
                    if Flags["ESP"].Settings["Distance"] then
                        NameText.Text = SFormat("<font color=\"rgb(%d, %d, %d)\">%s</font> [<font color=\"rgb(255, 255, 255)\">%d</font>]", Color[1], Color[2], Color[3], SLower(Player.Name), Floor((Torso.Position - CurrentCamera.CFrame.Position).Magnitude))
                    else
                        NameText.Text = SFormat("<font color=\"rgb(%d, %d, %d)\">%s</font>", Color[1], Color[2], Color[3], SLower(Player.Name)) 
                    end

                    if Flags["ESP"].Settings["Weapon"] then
                        WeaponText.Text = SFormat("[<font color=\"rgb(255, 255, 255)\">%s</font>]", ThirdPersonObject._weaponname or "None")
                        WeaponText.Visible = true
                    else
                        WeaponText.Visible = false
                    end

                    if Flags["ESP"].Settings["Health"] then
                        if HealthScale < 0 then
                            HealthScale = 0
                        elseif HealthScale > 1 then
                            HealthScale = 1
                        end

                        local LerpedHealth = Lerp(HealthInline.Size.Y.Scale, HealthScale, 0.1)
                        HealthInline.Size = UDim2.new(HealthInline.Size.X.Scale, HealthInline.Size.X.Offset, LerpedHealth, HealthInline.Size.Y.Offset)
                        HealthText.Text = tostring(Floor(Health))
                        
                        HealthOutline.Visible = true
                        HealthText.Visible = false
                    else
                        HealthOutline.Visible = false
                        HealthText.Visible = false
                    end

                    if Flags["ESP"].Settings["Box"] then
                        UIStroke.Transparency = 0
                        BoxStroke.Transparency = 0
                    else
                        UIStroke.Transparency = 1
                        BoxStroke.Transparency = 1
                    end

                    Fill.Visible = Flags["ESP"].Settings["Box Fill"]
                    NameText.TextColor3 = RGB(Color[1], Color[2], Color[3])
                    WeaponText.TextColor3 = RGB(Color[1], Color[2], Color[3])
                    BoxStroke.Color = RGB(Color[1], Color[2], Color[3])
                end
                    
                if Flags["ESP"].Settings["Cham"] and CharacterHash then
                    if not Memory.ESP.Chams[Player.Name] then
                        Memory.ESP.Chams[Player.Name] = {}
                    end
                    
                    for Name, Part in CharacterHash do
                        if not Part:FindFirstChild("BoxHandleAdornment") then
                            local BoxHandleAdornment = INew("BoxHandleAdornment")
                            BoxHandleAdornment.Name = "BoxHandleAdornment"
                            BoxHandleAdornment.AlwaysOnTop = true
                            BoxHandleAdornment.Visible = true
                            BoxHandleAdornment.Adornee = Part
                            BoxHandleAdornment.Color3 = RGB(255, 255, 255)
                            BoxHandleAdornment.Size = DesktopHitBox[Name].size
                            BoxHandleAdornment.ZIndex = 1
                            BoxHandleAdornment.Transparency = 0.2
                            BoxHandleAdornment.Parent = Part

                            TInsert(Memory.ESP.Chams[Player.Name], BoxHandleAdornment)
                        end
                    end
                else
                    Client:Tick("Cham Deletion", 2, function()
                        for _, Name in Memory.ESP.Chams do
                            for _, BoxHandleAdornment in Name do
                                BoxHandleAdornment:Destroy()
                            end
                        end
                    end)
                end
            end
        end

        if Flags["Ragebot"].Enabled and Client.RootPart then
            for Player, Entry in Memory.Entries do
                if Player == Client.Player or Player.Team == Client.Team or TFind(Flags["Friendly"], Player.UserId) or not Entry._alive then
                    continue
                end

                local ThirdPersonObject = Entry:getThirdPersonObject()
                local CharacterHash = ThirdPersonObject and ThirdPersonObject:getCharacterHash()
                if not CharacterHash then
                    continue
                end

                if TFind(Flags["Ragebot"].Types, "Shoot") then
                    local Result, Origin, Destination, Hitbox = Scan(Entry, CharacterHash)
                    if not Result then
                        continue
                    end
    
                    Client:Tick("Ragebot Shoot", 60 / Memory.Weapon:getFirerate(), function()
                        Shoot(Destination, Origin, true, Player, Hitbox)
                    end)
                end

                if TFind(Flags["Ragebot"].Types, "Stab") then
                    local Distance = (CharacterHash["Torso"].Position - Client.RootPart.Position).Magnitude

                    if Distance > 12 then
                        continue
                    end

                    Client:Tick("Ragebot Stab", 0.1, function()
                        Stab(Player, "Head", CharacterHash["Head"].Position)
                    end)
                end
            end
        end

        if Flags["Auto Reload"] and Memory.Weapon and Memory.Weapon:getWeaponType() == "Firearm" then
            local MagCount = Memory.Weapon:getMagCount()

            if MagCount and MagCount <= 1 then
                Memory.Weapon:applyReloadCount(Memory.Weapon:getWeaponData()["magsize"])
            end
        end

        if Flags["Auto Chamber"] and Memory.Weapon and Memory.Weapon:getWeaponType() == "Firearm" then
            local IsChambering = Memory.Weapon:isChambering()

            if IsChambering then
                Memory.Weapon:cancelAnimation()
                Memory.Weapon._bolting = false
                Memory.Weapon._boltOpen = false
                Memory.Weapon._chamberState._currentState = "chambered"
            end
        end

        if Flags["Grab Ammo"] and Memory.Weapon and Client.RootPart then
            Client:Tick("Grab Ammo", 1, function()
                for _, Drop in Workspace.Ignore.GunDrop:GetChildren() do
                    local AmmoType = Drop:FindFirstChild("AmmoType")
                    if not AmmoType or AmmoType.Value ~= Memory.Weapon:getWeaponData()["ammotype"] then
                        continue
                    end

                    local Distance = (Drop.Slot1.Position - Client.RootPart.Position).Magnitude
                    if Distance > 12 then
                        continue
                    end

                    NetworkClient:send("getammo", Drop)
                end
            end)
        end

        if Flags["Unlock Auto"] and Memory.Weapon and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            Memory.Weapon._burst = 1
        end

        if Flags["Fire Rate"] > 0 and Memory.Weapon then
            local WeaponData = Memory.Weapon:getWeaponData()
            if not Memory.Properties[Memory.Weapon] then
                Memory.Properties[Memory.Weapon] = WeaponData["firerate"]
            end

            setreadonly(WeaponData, false)
            if Memory.Properties[Memory.Weapon] then
                WeaponData["firerate"] = Memory.Properties[Memory.Weapon]
            end

            setreadonly(WeaponData, true)
        end

        if Flags["Bullet Tracers"].Enabled then
            Client:Tick("Tracer Animation", 0.05, function()
                for Index, Data in Memory.Tracers do
                    local CurrentTime = GameClock.getTime()
                    local CreateTime = Data.Time
                    local DestroyTime = CreateTime + Data.LifeTime
                    local TimeLeft = DestroyTime - CurrentTime

                    if TimeLeft <= 0.5 then
                        local Beam = Data.Beam
                        Beam.Width0 -= 0.005
                        Beam.Width1 -= 0.005
                    elseif TimeLeft <= 0 then
                        TRemove(Memory.Tracers, TFind(Memory.Tracers, Index))
                    end
                end
            end)
        end

        if Flags["Third Person"].Enabled then
            if Memory.WeaponController and not Memory.ClientEntry then
                Memory.ClientEntry = GetClientEntry()
            end

            HideArms(true)
        else
            HideArms(false)
        end

        if Flags["Camera"].NoShake then
            Client:Tick("Camera Shake", 0.2, function()
                if Memory.MainCamera and Memory.MainCamera.step and not isourclosure(Memory.MainCamera.step) then
                    Memory.Functions["Camera Step"] = Memory.MainCamera.step
                    Memory.MainCamera.step = function(Data, ...)
                        local OldSpeed = Client.CharacterObject._speed

                        Client.CharacterObject._speed = 0
                        Memory.Functions["Camera Step"](Data, ...)
                        Client.CharacterObject._speed = OldSpeed
                        Data._currentCamera.CFrame = Data._baseCFrame
                    end 
                end
            end)
        else
            Client:Tick("Camera Shake", 0.2, function()
                if Memory.MainCamera and Memory.MainCamera.step and isourclosure(Memory.MainCamera.step) then
                    Memory.MainCamera.step = Memory.Functions["Camera Step"]
                    Memory.Functions["Camera Step"] = nil
                end
            end)
        end

        if Flags["Camera"].NoSway then
            Client:Tick("Camera Sway", 0.2, function()
                if Memory.Weapon and Memory.Weapon.computeGunSway and not isourclosure(Memory.Weapon.computeGunSway) then
                    Memory.Functions["Compute Gun Sway"] = Memory.Weapon.computeGunSway
                    Memory.Weapon.computeGunSway = function()
                        return CNew()
                    end
                end

                if Memory.Weapon and Memory.Weapon.computeWalkSway and not isourclosure(Memory.Weapon.computeWalkSway) then
                    Memory.Functions["Compute Walk Sway"] = Memory.Weapon.computeWalkSway
                    Memory.Weapon.computeWalkSway = function()
                        return CNew()
                    end
                end

                if Memory.Weapon and Memory.Weapon.walkSway and not isourclosure(Memory.Weapon.walkSway) then
                    Memory.Functions["Walk Sway"] = Memory.Weapon.walkSway
                    Memory.Weapon.walkSway = function()
                        return CNew()
                    end
                end
    
                if Client.CharacterObject and Client.CharacterObject.sway and Client.CharacterObject.sway.getSwayCFrame and not isourclosure(Client.CharacterObject.sway.getSwayCFrame) then
                    Memory.Functions["Get Sway CFrame"] = Client.CharacterObject.sway.getSwayCFrame
                    Client.CharacterObject.sway.getSwayCFrame = function()
                        return CNew()
                    end
                end
            end)
        else
            Client:Tick("Camera Sway", 0.2, function()
                if Memory.Weapon and Memory.Weapon.computeGunSway and isourclosure(Memory.Weapon.computeGunSway) then
                    Memory.Weapon.computeGunSway = Memory.Functions["Compute Gun Sway"]
                    Memory.Functions["Compute Gun Sway"] = nil
                end

                if Memory.Weapon and Memory.Weapon.computeWalkSway and isourclosure(Memory.Weapon.computeWalkSway) then
                    Memory.Weapon.computeWalkSway = Memory.Functions["Compute Walk Sway"]
                    Memory.Functions["Compute Walk Sway"] = nil
                end

                if Memory.Weapon and Memory.Weapon.walkSway and isourclosure(Memory.Weapon.walkSway) then
                    Memory.Weapon.walkSway = Memory.Functions["Walk Sway"]
                    Memory.Functions["Walk Sway"] = nil
                end
    
                local CharacterObject = Client.CharacterObject
                if CharacterObject and CharacterObject.sway and CharacterObject.sway.getSwayCFrame and isourclosure(CharacterObject.sway.getSwayCFrame) then
                    CharacterObject.sway.getSwayCFrame = Memory.Functions["Get Sway CFrame"]
                    Memory.Functions["Get Sway CFrame"] = nil
                end
            end)
        end

        if Flags["Speed Hack"].Enabled then
            local Humanoid = Client.Humanoid
            local RootPart = Client.RootPart
            local Velocity = Flags["Speed Hack"].Velocity
        
            if Humanoid and Humanoid:GetState() ~= Enum.HumanoidStateType.Climbing and RootPart and not UserInputService:GetFocusedTextBox() then
                local Add = V3Zero
                local LookVector = RootPart.CFrame.LookVector
        
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    Add += V3New(LookVector.X, 0, LookVector.Z)
                end
        
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    Add += V3New(LookVector.Z, 0, -LookVector.X)
                end
        
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    Add -= V3New(LookVector.X, 0, LookVector.Z)
                end
        
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    Add += V3New(-LookVector.Z, 0, LookVector.X)
                end

                local MoveDirection = Add.Unit
                if MoveDirection.X == MoveDirection.X then
                    RootPart.Velocity = V3New(MoveDirection.X * Velocity, RootPart.Velocity.Y, MoveDirection.Z * Velocity)
                end
            end
        end

        if Flags["Speed Hack"].Bypass and Flags["Speed Hack"].Fly then
            local Humanoid = Client.Humanoid
            local RootPart = Client.RootPart
            local Velocity = Flags["Speed Hack"].Velocity
        
            if Humanoid and Humanoid:GetState() ~= Enum.HumanoidStateType.Climbing and RootPart then
                local Add = V3Zero
                local LookVector = CurrentCamera.CFrame.LookVector
        
                if UserInputService:IsKeyDown(Enum.KeyCode.W) and not UserInputService:GetFocusedTextBox() then
                    Add += LookVector
                end
        
                if UserInputService:IsKeyDown(Enum.KeyCode.A) and not UserInputService:GetFocusedTextBox() then
                    Add += V3New(LookVector.Z, 0, -LookVector.X)
                end
        
                if UserInputService:IsKeyDown(Enum.KeyCode.S) and not UserInputService:GetFocusedTextBox() then
                    Add -= LookVector
                end
        
                if UserInputService:IsKeyDown(Enum.KeyCode.D) and not UserInputService:GetFocusedTextBox() then
                    Add += V3New(-LookVector.Z, 0, LookVector.X)
                end

                local MoveDirection = Add.Unit
                if MoveDirection.X == MoveDirection.X then
                    RootPart.Anchored = false
                    RootPart.Velocity = V3New(MoveDirection.X * Velocity, MoveDirection.Y * Velocity, MoveDirection.Z * Velocity)
                else
                    RootPart.Anchored = true
                end
            end
        end

        if Flags["Chams"].Weapon then
            local WeaponModel = Memory.Weapon and Memory.Weapon._weaponModel

            if WeaponModel and not Memory.ForceHidden then
                for _, Part in WeaponModel:GetChildren() do
                    if not Memory.Properties[Part] then
                        Memory.Properties[Part] = {
                            Material = Part.Material,
                            Color = Part.Color,
                        }
                    end

                    Part.Material = Enum.Material.ForceField
                    Part.Color = Flags["Chams"].WeaponColor

                    if Part:FindFirstChildWhichIsA("Texture") then
                        for _, Texture in Part:GetChildren() do
                            if Texture:IsA("Texture") then
                                Texture.LocalTransparencyModifier = 1
                            end
                        end
                    end

                    if Part:FindFirstChildWhichIsA("Decal") then
                        for _, Decal in Part:GetChildren() do
                            if Decal:IsA("Decal") then
                                Decal.LocalTransparencyModifier = 1
                            end
                        end
                    end
                end
            end
        else
            Client:Tick("Memory.Weapon Chams", 0.2, function()
                local WeaponModel = Memory.Weapon and Memory.Weapon._weaponModel

                if WeaponModel then
                    for _, Part in WeaponModel:GetChildren() do
                        local MemoryEntry = Memory.Properties[Part]
                        if MemoryEntry then
                            Part.Material = MemoryEntry.Material
                            Part.Color = MemoryEntry.Color
                            Memory.Properties[Part] = nil
                        end
    
                        if Part:FindFirstChildWhichIsA("Texture") then
                            for _, Texture in Part:GetChildren() do
                                if Texture:IsA("Texture") and not Memory.ForceHidden then
                                    Texture.LocalTransparencyModifier = 0
                                end
                            end
                        end

                        if Part:FindFirstChildWhichIsA("Decal") then
                            for _, Decal in Part:GetChildren() do
                                if Decal:IsA("Decal") and not Memory.ForceHidden then
                                    Decal.LocalTransparencyModifier = 0
                                end
                            end
                        end
                    end
                end
            end)
        end

        if Flags["Chams"].Arms then
            local CharacterObject = Client.CharacterObject
            local LeftArmModel = CharacterObject and CharacterObject._leftArmModel
            local RightArmModel = CharacterObject and CharacterObject._rightArmModel

            if LeftArmModel and RightArmModel and not Memory.ForceHidden then
                for _, Part in LeftArmModel:GetChildren() do
                    if not Memory.Properties[Part] then
                        Memory.Properties[Part] = {
                            Material = Part.Material,
                            Color = Part.Color,
                        }
                    end

                    Part.Material = Enum.Material.ForceField
                    Part.Color = Flags["Chams"].ArmColor

                    if Part:FindFirstChildWhichIsA("Texture") then
                        for _, Texture in Part:GetChildren() do
                            if Texture:IsA("Texture") then
                                Texture.LocalTransparencyModifier = 1
                            end
                        end
                    end

                    if Part:FindFirstChildWhichIsA("Decal") then
                        for _, Decal in Part:GetChildren() do
                            if Decal:IsA("Decal") then
                                Decal.LocalTransparencyModifier = 1
                            end
                        end
                    end
                end

                for _, Part in RightArmModel:GetChildren() do
                    if not Memory.Properties[Part] then
                        Memory.Properties[Part] = {
                            Material = Part.Material,
                            Color = Part.Color,
                        }
                    end

                    Part.Material = Enum.Material.ForceField
                    Part.Color = Flags["Chams"].ArmColor

                    if Part:FindFirstChildWhichIsA("Texture") then
                        for _, Texture in Part:GetChildren() do
                            if Texture:IsA("Texture") then
                                Texture.LocalTransparencyModifier = 1
                            end
                        end
                    end

                    if Part:FindFirstChildWhichIsA("Decal") then
                        for _, Decal in Part:GetChildren() do
                            if Decal:IsA("Decal") then
                                Decal.LocalTransparencyModifier = 1
                            end
                        end
                    end
                end
            end
        else
            local CharacterObject = Client.CharacterObject
            local LeftArmModel = CharacterObject and CharacterObject._leftArmModel
            local RightArmModel = CharacterObject and CharacterObject._rightArmModel

            if LeftArmModel and RightArmModel then
                for _, Part in LeftArmModel:GetChildren() do
                    local MemoryEntry = Memory.Properties[Part]
                    if MemoryEntry then
                        Part.Material = MemoryEntry.Material
                        Part.Color = MemoryEntry.Color
                        Memory.Properties[Part] = nil
                    end

                    if Part:FindFirstChildWhichIsA("Texture") then
                        for _, Texture in Part:GetChildren() do
                            if Texture:IsA("Texture") and not Memory.ForceHidden then
                                Texture.LocalTransparencyModifier = 0
                            end
                        end
                    end

                    if Part:FindFirstChildWhichIsA("Decal") then
                        for _, Decal in Part:GetChildren() do
                            if Decal:IsA("Decal") and not Memory.ForceHidden then
                                Decal.LocalTransparencyModifier = 0
                            end
                        end
                    end
                end

                for _, Part in RightArmModel:GetChildren() do
                    local MemoryEntry = Memory.Properties[Part]
                    if MemoryEntry then
                        Part.Material = MemoryEntry.Material
                        Part.Color = MemoryEntry.Color
                        Memory.Properties[Part] = nil
                    end

                    if Part:FindFirstChildWhichIsA("Texture") then
                        for _, Texture in Part:GetChildren() do
                            if Texture:IsA("Texture") and not Memory.ForceHidden then
                                Texture.LocalTransparencyModifier = 0
                            end
                        end
                    end

                    if Part:FindFirstChildWhichIsA("Decal") then
                        for _, Decal in Part:GetChildren() do
                            if Decal:IsA("Decal") and not Memory.ForceHidden then
                                Decal.LocalTransparencyModifier = 0
                            end
                        end
                    end
                end
            end
        end

        if Flags["Chams"].ThirdPerson then
            Client:Tick("ThirdPerson Chams", 0.2, function()
                local ClientEntry = Memory.ClientEntry
                local ThirdPersonObject  = ClientEntry and ClientEntry:getThirdPersonObject()
                local Character = ThirdPersonObject and ThirdPersonObject._character
                local CharacterHash = ThirdPersonObject and ThirdPersonObject:getCharacterHash()
    
                if CharacterHash then
                    for _, Part in Character:FindFirstChildWhichIsA("Folder"):GetChildren() do
                        if not Memory.Properties[Part] then
                            Memory.Properties[Part] = {
                                Material = Part.Material,
                                Color = Part.Color,
                            }
                        end
    
                        Part.Material = Enum.Material.ForceField
                        Part.Color = Flags["Chams"].ThirdPersonColor
                    end
    
                    for _, Part in Character:GetChildren() do
                        if not Part:IsA("BasePart") then
                            continue
                        end
    
                        if not Memory.Properties[Part] then
                            Memory.Properties[Part] = {
                                Material = Part.Material,
                                Color = Part.Color,
                            }
                        end
    
                        Part.Material = Enum.Material.ForceField
                        Part.Color = Flags["Chams"].ThirdPersonColor
    
                        if Part == CharacterHash["Head"] then
                            Part.LocalTransparencyModifier = 1
                        elseif Part == CharacterHash["Torso"] then    
                            for _, Texture in Part:GetChildren() do
                                if Texture:IsA("Texture") then
                                    Texture.LocalTransparencyModifier = 1
                                end
                            end
                        end
            
                        if Part:FindFirstChildWhichIsA("SpecialMesh") then
                            for _, Mesh in Part:GetChildren() do
                                if not Mesh:IsA("SpecialMesh") then
                                    continue
                                end
    
                                if not Memory.Properties[Mesh] then
                                    Memory.Properties[Mesh] = {
                                        VertexColor = Mesh.VertexColor,
                                    }
                                end

                                Mesh.VertexColor = Vector3.new(Flags["Chams"].ThirdPersonColor.R * 1.2, Flags["Chams"].ThirdPersonColor.G * 1.2, Flags["Chams"].ThirdPersonColor.B * 1.2)
                                if Part == CharacterHash["Torso"] then
                                    Mesh.TextureId = "rbxassetid://5614184106"
                                end
                            end
                        end
                    end
                end
            end)
        else
            Client:Tick("ThirdPerson Chams", 0.2, function()
                local ClientEntry = Memory.ClientEntry
                local ThirdPersonObject  = ClientEntry and ClientEntry:getThirdPersonObject()
                local Character = ThirdPersonObject and ThirdPersonObject._character
                local CharacterHash = ThirdPersonObject and ThirdPersonObject:getCharacterHash()
    
                if CharacterHash then
                    for _, Part in Character:FindFirstChildWhichIsA("Folder"):GetChildren() do
                        local MemoryEntry = Memory.Properties[Part]
                        if MemoryEntry then
                            Part.Material = MemoryEntry.Material
                            Part.Color = MemoryEntry.Color
                            Memory.Properties[Part] = nil
                        end
                    end
    
                    for _, Part in Character:GetChildren() do
                        if not Part:IsA("BasePart") then
                            continue
                        end

                        local MemoryEntry = Memory.Properties[Part]
                        if MemoryEntry then
                            Part.Material = MemoryEntry.Material
                            Part.Color = MemoryEntry.Color
                            Memory.Properties[Part] = nil
                        end
    
                        if Part == CharacterHash["Head"] then
                            Part.LocalTransparencyModifier = 0
                        elseif Part == CharacterHash["Torso"] then    
                            for _, Texture in Part:GetChildren() do
                                if Texture:IsA("Texture") then
                                    Texture.LocalTransparencyModifier = 0
                                end
                            end
                        end
            
                        if Part:FindFirstChildWhichIsA("SpecialMesh") then
                            for _, Mesh in Part:GetChildren() do
                                if not Mesh:IsA("SpecialMesh") then
                                    continue
                                end

                                local MemoryEntry = Memory.Properties[Mesh]
                                if MemoryEntry then
                                    Mesh.VertexColor = MemoryEntry.VertexColor
                                    Memory.Properties[Mesh] = nil
                                end

                                if Part == CharacterHash["Torso"] then
                                    Mesh.TextureId = "rbxassetid://5614184106"
                                end
                            end
                        end
                    end
                end
            end)
        end

        if Flags["Ambient"].Enabled then
            if not Memory.Properties[Lighting] then
                Memory.Properties[Lighting] = {
                    Ambient = Lighting.Ambient,
                    OutdoorAmbient = Lighting.OutdoorAmbient,
                }
            end

            Lighting.Ambient = Color3.new(Flags["Ambient"].Color.R * 1.2, Flags["Ambient"].Color.G * 1.2, Flags["Ambient"].Color.B * 1.2)
            Lighting.OutdoorAmbient = Flags["Ambient"].Color
        else
            local MemoryEntry = Memory.Properties[Lighting]
            if MemoryEntry then
                Lighting.Ambient = MemoryEntry.Ambient
                Lighting.OutdoorAmbient = MemoryEntry.OutdoorAmbient
                Memory.Properties[Lighting] = nil
            end
        end

        task.wait()
    end
end)

Client:Connect("PlayerRemoving", Players.PlayerRemoving, function(Player)
    for Key, Frame in Memory.ESP.Frames do
        Frame:Destroy()
        Memory.ESP.Frames[Key] = nil
    end
end)

local __newindex = nil
__newindex = hookmetamethod(game, "__newindex", function(self, Property, Value)
    if not checkcaller() then
        if self == CurrentCamera then
            local Scoped = Memory.Weapon and Memory.Weapon.fireRound and Memory.Weapon:isAiming() and Memory.Weapon:isBlackScoped()

            if Scoped then
                return __newindex(self, Property, Value)
            end

            if Property == "CFrame" and Flags["Third Person"].Enabled and Memory.WeaponController then
                local Distance = Flags["Third Person"].Zoom / 10
                local Result = Workspace:Raycast(Value.Position, -Value.LookVector * Distance, RaycastParameters)
                if Result and not Result.Instance.CanCollide then
                    return __newindex(self, Property, Value * CNew(1.5, 0, Distance))
                end

                local Magnitude = Result and (Result.Position - Value.Position).Magnitude
                return __newindex(self, Property, Value * CNew(1.5, 0, Magnitude or Distance))
            end

            if Property == "FieldOfView" and Memory.WeaponController then
                return __newindex(self, Property, Flags["Camera"].FieldOfView)
            end
        end
    end

    return __newindex(self, Property, Value)
end)

local LastTick = nil

local __send = NetworkClient.send
NetworkClient.send = function(self, Method, ...)
    local Arguments = {...}

    if Method == "newbullets" and Arguments[4] ~= "CHEAT" and Flags["Silent Aim"].Enabled then
        local ClosestPlayer = GetClosestPlayer(Flags["Silent Aim"].Field)
        local Result = ClosestPlayer and ClosestPlayer.Result

        if Result then
            local WeaponData = Memory.Weapon:getWeaponData()
            local BulletVelocity, LandTime = GetTrajectory(Result.Destination - Result.Origin, -BulletAcceleration, WeaponData["bulletspeed"])

            for Index, Bullet in Arguments[2].bullets do
                Arguments[2].bullets[Index][1] = BulletVelocity
            end
        end
    end

    if Method == "repupdate" then
        if Flags["Anti Aim"].Enabled then
            if Memory.Yaw == nil then
                Memory.Yaw = 0
            end

            if Memory.Pitch == nil then
                Memory.Pitch = 0
            end
            
            if Flags["Anti Aim"].Yaw == "Backward" then
                local OrientationX, OrientationY, OrientationZ = ToOrientation(CNew(CurrentCamera.CFrame.LookVector, CAngles(0, -180, 0).Position))
                Arguments[2] = V3New(Arguments[2].X, OrientationY, Arguments[2].Z)
            elseif Flags["Anti Aim"].Yaw == "Random" then
                Memory.Yaw = Memory.Yaw + Random(-Flags["Anti Aim"].Rate, Flags["Anti Aim"].Rate)
                Arguments[2] = V3New(Arguments[2].X, Rad(Memory.Yaw), Arguments[2].Z)
            elseif Flags["Anti Aim"].Yaw == "Spin" then
                Memory.Yaw = Memory.Yaw + Flags["Anti Aim"].Rate
                Arguments[2] = V3New(Arguments[2].X, Rad(Memory.Yaw), Arguments[2].Z)
            end

            if Flags["Anti Aim"].Pitch == "Up" then
                Memory.Pitch = 90
                Arguments[2] = V3New(Rad(Memory.Pitch), Arguments[2].Y, Arguments[2].Z)
            elseif Flags["Anti Aim"].Pitch == "Down" then
                Memory.Pitch = -90
                Arguments[2] = V3New(Rad(Memory.Pitch), Arguments[2].Y, Arguments[2].Z)
            elseif Flags["Anti Aim"].Pitch == "Cycle" then
                if not Memory.WentUp then
                    Memory.Pitch = Memory.Pitch + Flags["Anti Aim"].Rate
    
                    if Floor(Memory.Pitch) >= 90 then
                        Memory.WentUp = true
                    end
                else
                    Memory.Pitch = Memory.Pitch - Flags["Anti Aim"].Rate
    
                    if Floor(Memory.Pitch) <= -90 then
                        Memory.WentUp = false
                    end
                end
    
                Memory.Pitch = Clamp(Memory.Pitch, -90, 90)
                Arguments[2] = V3New(Rad(Memory.Pitch), Arguments[2].Y, Arguments[2].Z)  
            end
        end

        if Flags["Fake Lag"].Enabled and not Flags["Speed Hack"].Bypass then
            local Release = false
            if Flags["Fake Lag"].Break then
                Release = Memory.ChokedTicks >= 55
            else
                Release = Memory.ChokedTicks >= Flags["Fake Lag"].Tick
            end

            if Release then
                Memory.ChokedTicks = 0
            end

            if not Release then
                Memory.ChokedTicks += 1
                return
            end
        end

        if Flags["Speed Hack"].Bypass then
            local Release = Memory.ChokedTicks >= 14

            if Release then
                Memory.ChokedTicks = 0
            end

            if not Release then
                Memory.ChokedTicks += 1
                return
            end
        end

        if Memory.WeaponController then
            Memory.Replication.Position = Arguments[1]
            Memory.Replication.LookAngles = Arguments[2]
        end
    end

    if Flags["Third Person"].Enabled then
        local Entry = Memory.ClientEntry
        local ThirdPersonObject = Entry and Entry:getThirdPersonObject()

        if ThirdPersonObject then
            if Method == "equip" then
                if Arguments[1] > 2 then
                    ThirdPersonObject:equipMelee()
                else
                    ThirdPersonObject:equip(Arguments[1])
                end
            elseif Method == "aim" then
                ThirdPersonObject:setAim(Arguments[1])
            elseif Method == "sprint" then
                ThirdPersonObject:setSprint(Arguments[1])
            elseif Method == "stab" then
                ThirdPersonObject:stab()
            end
        end
    end

    if Method == "flaguser" or Method == "debug" or Method == "logmessage" then --udtc pf cheating in 2024
        return
    end

    return __send(self, Method, TUnpack(Arguments))
end

local __playSound = AudioSystem.playSound
AudioSystem.playSound = function(...)
    local Arguments = {...}

    if Flags["Third Person"].Enabled then
        local Entry = Memory.ClientEntry
        local ThirdPersonObject = Entry and Entry:getThirdPersonObject()
        local RootPart = ThirdPersonObject and ThirdPersonObject:getRootPart()
    
        if SFind(Arguments[1], "friendly") and RootPart and Arguments[8] == RootPart then
            return
        end
    end

    if Flags["Kill Sound"] == "Fade" then
        if Arguments[1] == "killshot" or Arguments[1] == "headshotkill" then
            return
        end
    end

    return __playSound(...)
end

local __addEntry = ReplicationInterface.addEntry
ReplicationInterface.addEntry = function(Player, ...)
    __addEntry(Player, ...)
    
    local Entry = ReplicationInterface.getEntry(Player)
    SolveMovement(Entry)
end

local __newBullet = BulletInterface.newBullet
BulletInterface.newBullet = function(Data)
    local Extra = Data.extra
    local FirearmObject = Extra and Extra.firearmObject

    if Flags["Silent Aim"].Enabled and Flags["Silent Aim"].Type == "Redirect" and Data.onplayerhit then
        local ClosestPlayer = GetClosestPlayer(Flags["Silent Aim"].Field)
        local Result = ClosestPlayer and ClosestPlayer.Result

        if Result then
            local WeaponData = Memory.Weapon:getWeaponData()
            local BulletVelocity, LandTime = GetTrajectory(Result.Destination - Data.visualorigin, -Data.acceleration, WeaponData["bulletspeed"])

            Data.velocity = WeaponData["bulletspeed"] * BulletVelocity
        end
    end

    if Flags["Bullet Tracers"].Enabled and FirearmObject and Memory.Weapon and FirearmObject == Memory.Weapon then
        local Terrain = Workspace.Terrain
        local Origin = Data.visualorigin
        local Direction = Data.velocity.Unit * 1000
        local Destination = V3Zero
        
        local RaycastParameters = RaycastParams.new()
        RaycastParameters.FilterType = Enum.RaycastFilterType.Exclude
        RaycastParameters.FilterDescendantsInstances = Data.physicsignore
        
        local Result = Workspace:Raycast(Origin, Direction, RaycastParameters)
        if Result then
            Destination = Result.Position
        else
            Destination = Origin + Direction
        end

        local Attachment0 = INew("Attachment")
        Attachment0.Position = Origin
        Attachment0.Parent = Terrain

        local Attachment1 = INew("Attachment")
        Attachment1.Position = Destination
        Attachment1.Parent = Terrain

        local Beam = INew("Beam")
        Beam.TextureSpeed = 8
        Beam.LightEmission = 1
        Beam.LightInfluence = 1
        Beam.CurveSize0 = 0
        Beam.CurveSize1 = 0
        Beam.Width0 = 0.05
        Beam.Width1 = 0.05
        Beam.TextureLength = 1
        Beam.FaceCamera = true
        Beam.Enabled = true
        Beam.ZOffset = -1
        Beam.Transparency = NumberSequence.new(0, 0)
        Beam.Color = ColorSequence.new(Flags["Bullet Tracers"].Color, Color3.new(0, 0, 0))
        Beam.Attachment0 = Attachment0
        Beam.Attachment1 = Attachment1
        Beam.Parent = Workspace

        TInsert(Memory.Tracers, {
            Time = GameClock.getTime(),
            LifeTime = Flags["Bullet Tracers"].LifeTime,
            Beam = Beam,
        })

        Debris:AddItem(Beam, Flags["Bullet Tracers"].LifeTime)
        Debris:AddItem(Attachment0, Flags["Bullet Tracers"].LifeTime)
        Debris:AddItem(Attachment1, Flags["Bullet Tracers"].LifeTime)
    end

    return __newBullet(Data)
end

local __bigAward = Events.bigaward
Events.bigaward = function(Method, Data, Weapon, Points)
    if Method == "kill" then
        Memory.Replication.Offset = V3Zero
        
        if Flags["Kill Sound"] == "Fade" then
            AudioSystem.playSound("ui_smallaward", 4, 0.2)
        end
    end

    return __bigAward(Method, Data, Weapon, Points)
end

local __correctposition = Events.correctposition
Events.correctposition = function(Position)
    if Client.RootPart then
        Client.RootPart.Position = Position
    end
end

local __getCTime = TimeSyncClient._getCTime
TimeSyncClient._getCTime = function(...)
    return __getCTime(...)
end

for _, Entry in Memory.Entries do
    SolveMovement(Entry)
end

local Window = Menu:CreateWindow({
    Title = "<font color=\"rgb(255, 255, 255)\">squidhook</font><font color=\"rgb(255,255,255)\">.xyz 🦑</font>",
    Center = true,
    AutoShow = true,
    TabPadding = 20,
})

SaveManager:SetLibrary(Menu)
SaveManager:SetFolder("gamertest")

local Combat = Window:AddTab("Combat") do
    local Settings = Combat:AddGroupbox({Name = "Settings", Side = "Left"}) do
        Settings:AddToggle("Combat/Settings/AutoWall", {
            Text = "Auto Wall",
            Default = Flags["Auto Wall"],
        })
        
        Settings:AddToggle("Combat/Settings/OriginScanning", {
            Text = "Origin Scanning",
            Default = Flags["Origin Scanning"],
        })

        Settings:AddDropdown("Combat/Settings/HitBoxes", {
            Text = "Hit Boxes",
            Default = Flags["Hit Boxes"],
            Multi = true,
            Values = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"},
        })

        Settings:AddDropdown("Combat/Settings/MultiPoint", {
            Text = "Multi Point",
            Default = Flags["Multi Point"],
            Multi = true,
            Values = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"},
        })

        Settings:AddDropdown("Combat/Settings/PointTypes", {
            Text = "Point Types",
            Default = Flags["Point Types"],
            Multi = true,
            Values = {"Faces", "Corners"},
        })

        Settings:AddDropdown("Combat/Settings/SpoofHit", {
            Text = "Spoof Hit",
            Default = Flags["Spoof Hit"],
            Multi = false,
            Values = {"None", "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"}
        })

        Settings:AddSlider("Combat/Settings/ScanningFrequency", {
            Text = "Scanning Frequency",
            Compact = false,
            Default = Flags["Scanning Frequency"],
            Min = 0,
            Max = 1,
            Rounding = 1,
        })

        Settings:AddSlider("Combat/Settings/OriginOffset", {
            Text = "Origin Offset",
            Compact = false,
            Default = Flags["Origin Offset"],
            Min = 0,
            Max = 10,
            Rounding = 1,
        })

        Settings:AddSlider("Combat/Settings/PointOffset", {
            Text = "Point Offset",
            Compact = false,
            Default = Flags["Point Offset"],
            Min = 0,
            Max = 10,
            Rounding = 1,
        })

        Settings:AddSlider("Combat/Settings/MinimumDamage", {
            Text = "Minimum Damage",
            Compact = false,
            Default = Flags["Minimum Damage"],
            Min = 0,
            Max = 100,
            Rounding = 1,
        })
    end

    local SilentAim = Combat:AddGroupbox({Name = "Silent Aim", Side = "Left"}) do
        SilentAim:AddToggle("Combat/SilentAim/Enabled", {
            Text = "Enabled",
            Default = Flags["Silent Aim"].Enabled,
        }):AddKeyPicker(Menu:GetNextFlag(), {
            Text = "Silent Aim",
            Mode = "Toggle",
            SyncToggleState = true,
        })

        SilentAim:AddDropdown("Combat/SilentAim/Type", {
            Text = "Type",
            Default = Flags["Silent Aim"].Type,
            Multi = false,
            Values = {"Blatant", "Redirect"},
        })

        SilentAim:AddSlider("Combat/SilentAim/Field", {
            Text = "Field",
            Compact = false,
            Default = Flags["Silent Aim"].Field,
            Min = 0,
            Max = 360,
            Rounding = 0,
        })
    end

    local Ragebot = Combat:AddGroupbox({Name = "Ragebot", Side = "Left"}) do
        Ragebot:AddToggle("Combat/Ragebot/Enabled", {
            Text = "Enabled",
            Default = Flags["Ragebot"].Enabled,
        }):AddKeyPicker(Menu:GetNextFlag(), {
            Text = "Ragebot",
            Mode = "Toggle",
            SyncToggleState = true,
        })

        Ragebot:AddDropdown("Combat/Ragebot/Types", {
            Text = "Types",
            Default = Flags["Ragebot"].Types,
            Multi = true,
            Values = {"Shoot", "Stab"},
        })
    end

    local Weapon = Combat:AddGroupbox({Name = "Weapon", Side = "Right"}) do
        Weapon:AddToggle("Combat/Weapon/AutoReload", {
            Text = "Auto Reload",
            Default = Flags["Auto Reload"],
        })

        Weapon:AddToggle("Combat/Weapon/AutoChamber", {
            Text = "Auto Chamber",
            Default = Flags["Auto Chamber"],
        })

        Weapon:AddToggle("Combat/Weapon/GrabAmmo", {
            Text = "Grab Ammo",
            Default = Flags["Grab Ammo"],
        })

        Weapon:AddToggle("Combat/Weapon/UnlockAuto", {
            Text = "Unlock Auto",
            Default = Flags["Unlock Auto"],
        })

        Weapon:AddSlider("Combat/Weapon/FireRate", {
            Text = "Fire Rate",
            Compact = false,
            Default = Flags["Fire Rate"],
            Min = 0,
            Max = 50,
            Rounding = 0,
        })

        Weapon:AddDropdown("Combat/Weapon/KillSound", {
            Text = "Kill Sound",
            Default = Flags["Kill Sound"],
            Multi = false,
            Values = {"None", "Fade"},
        })
    end

    local Players = Combat:AddGroupbox({Name = "Players", Side = "Right"}) do
        Players:AddDropdown("Combat/Players/List", {
            Text = "List",
            SpecialType = "Player",
        })

        Players:AddToggle("Combat/Players/Friendly", {
            Text = "Friendly",
            Default = false,
        })

        Players:AddToggle("Combat/Players/Enemy", {
            Text = "Enemy",
            Default = false,
        })
    end
end

local World = Window:AddTab("World") do
    local ESP = World:AddGroupbox({Name = "ESP", Side = "Left"}) do
        ESP:AddToggle("World/ESP/Enabled", {
            Text = "Enabled",
            Default = Flags["ESP"].Enabled,
        }):AddKeyPicker(Menu:GetNextFlag(), {
            Text = "ESP",
            Mode = "Toggle",
            SyncToggleState = true,
        })

        ESP:AddDropdown("World/ESP/Settings", {
            Text = "Settings",
            Default = Flags["ESP"].Settings,
            Multi = true,
            Values = {"Distance", "Weapon", "Health", "Box", "Box Fill", "Cham"},
        })
    end

    local ThirdPerson = World:AddGroupbox({Name = "Third Person", Side = "Left"}) do
        ThirdPerson:AddToggle("World/ThirdPerson/Enabled", {
            Text = "Enabled",
            Default = Flags["Third Person"].Enabled,
        }):AddKeyPicker(Menu:GetNextFlag(), {
            Text = "Third Person",
            Mode = "Toggle",
            SyncToggleState = true,
        })

        ThirdPerson:AddSlider("World/ThirdPerson/Zoom", {
            Text = "Zoom",
            Compact = false,
            Default = Flags["Third Person"].Zoom,
            Min = 0,
            Max = 120,
            Rounding = 0,
        })
    end

    local Camera = World:AddGroupbox({Name = "Camera", Side = "Left"}) do
        Camera:AddToggle("World/Camera/NoShake", {
            Text = "No Shake",
            Default = Flags["Camera"].NoShake,
        })

        Camera:AddToggle("World/Camera/NoSway", {
            Text = "No Sway",
            Default = Flags["Camera"].NoSway,
        })

        Camera:AddSlider("World/Camera/FieldOfView", {
            Text = "Field of View",
            Compact = false,
            Default = Flags["Camera"].FieldOfView,
            Min = 60,
            Max = 120,
            Rounding = 0,
        })
    end

    local BulletTracers = World:AddGroupbox({Name = "Bullet Tracers", Side = "Left"}) do
        BulletTracers:AddToggle("World/BulletTracers/Enabled", {
            Text = "Enabled",
            Default = Flags["Bullet Tracers"].Enabled,
        }):AddColorPicker("World/BulletTracers/Color", {
            Title = "Tracer Color",
            Default = Flags["Bullet Tracers"].Color,
        })

        BulletTracers:AddSlider("World/BulletTracers/LifeTime", {
            Text = "Life Time",
            Compact = false,
            Default = Flags["Bullet Tracers"].LifeTime,
            Min = 0,
            Max = 5,
            Rounding = 1,
        })
    end

    local BarrelCrosshair = World:AddGroupbox({Name = "Barrel Crosshair", Side = "Left"}) do
        BarrelCrosshair:AddToggle("World/BarrelCrosshair/Enabled", {
            Text = "Enabled",
            Default = Flags["Barrel Crosshair"].Enabled,
        }):AddColorPicker("World/BarrelCrosshair/Color", {
            Title = "Crosshair Color",
            Default = Flags["Barrel Crosshair"].Color,
        })

        BarrelCrosshair:AddSlider("World/BarrelCrosshair/Size", {
            Text = "Size",
            Compact = false,
            Default = Flags["Barrel Crosshair"].Size,
            Min = 0,
            Max = 20,
            Rounding = 0,
        })

        BarrelCrosshair:AddSlider("World/BarrelCrosshair/Spacing", {
            Text = "Spacing",
            Compact = false,
            Default = Flags["Barrel Crosshair"].Spacing,
            Min = 0,
            Max = 20,
            Rounding = 0,
        })

        BarrelCrosshair:AddSlider("World/BarrelCrosshair/Rotation", {
            Text = "Rotation",
            Compact = false,
            Default = Flags["Barrel Crosshair"].Rotation,
            Min = 0,
            Max = 10,
            Rounding = 0,
        })
    end

    local AntiAim = World:AddGroupbox({Name = "Anti Aim", Side = "Right"}) do
        AntiAim:AddToggle("World/AntiAim/Enabled", {
            Text = "Enabled",
            Default = Flags["Anti Aim"].Enabled,
        })

        AntiAim:AddDropdown("World/AntiAim/Yaw", {
            Text = "Yaw",
            Default = Flags["Anti Aim"].Yaw,
            Multi = false,
            Values = {"None", "Backward", "Random", "Spin"},
        })

        AntiAim:AddDropdown("World/AntiAim/Pitch", {
            Text = "Pitch",
            Default = Flags["Anti Aim"].Pitch,
            Multi = false,
            Values = {"None", "Up", "Down", "Cycle"},
        })

        AntiAim:AddSlider("World/AntiAim/Rate", {
            Text = "Rate",
            Compact = false,
            Default = Flags["Anti Aim"].Rate,
            Min = 0,
            Max = 80,
            Rounding = 0,
        })
    end

    local FakeLag = World:AddGroupbox({Name = "Fake Lag", Side = "Right"}) do
        FakeLag:AddToggle("World/FakeLag/Enabled", {
            Text = "Enabled",
            Default = Flags["Fake Lag"].Enabled,
        })

        FakeLag:AddToggle("World/FakeLag/Break", {
            Text = "Break",
            Risky = true,
            Default = Flags["Fake Lag"].Break,
        })

        FakeLag:AddSlider("World/FakeLag/Tick", {
            Text = "Tick",
            Compact = false,
            Default = Flags["Fake Lag"].Tick,
            Min = 0,
            Max = 30,
            Rounding = 0,
        })
    end

    local SpeedHack = World:AddGroupbox({Name = "Speed Hack", Side = "Right"}) do
        SpeedHack:AddToggle("World/SpeedHack/Enabled", {
            Text = "Enabled",
            Default = Flags["Speed Hack"].Enabled,
        }):AddKeyPicker(Menu:GetNextFlag(), {
            Text = "Speed Hack",
            Mode = "Toggle",
            SyncToggleState = true,
        })

        SpeedHack:AddToggle("World/SpeedHack/Bypass", {
            Text = "Bypass",
            Default = Flags["Speed Hack"].Bypass,
        })

        SpeedHack:AddToggle("World/SpeedHack/Fly", {
            Text = "Fly",
            Risky = true,
            Default = Flags["Speed Hack"].Fly,
        }):AddKeyPicker(Menu:GetNextFlag(), {
            Text = "Fly",
            Mode = "Toggle",
            SyncToggleState = true,
        })
        
        SpeedHack:AddSlider("World/SpeedHack/Velocity", {
            Text = "Velocity",
            Compact = false,
            Default = Flags["Speed Hack"].Velocity,
            Min = 0,
            Max = 50,
            Rounding = 0,
        })
    end

    local Chams = World:AddGroupbox({Name = "Chams", Side = "Right"}) do
        Chams:AddToggle("World/Chams/Weapon", {
            Text = "Weapon",
            Default = Flags["Chams"].Weapon,
        }):AddColorPicker("World/Chams/WeaponColor", {
            Title = "Weapon Color",
            Default = Flags["Chams"].WeaponColor,
        })

        Chams:AddToggle("World/Chams/Arms", {
            Text = "Arms",
            Default = Flags["Chams"].Arms,
        }):AddColorPicker("World/Chams/ArmColor", {
            Title = "Arm Color",
            Default = Flags["Chams"].ArmColor,
        })

        Chams:AddToggle("World/Chams/ThirdPerson", {
            Text = "Third Person",
            Default = Flags["Chams"].ThirdPerson,
        }):AddColorPicker("World/Chams/ThirdPersonColor", {
            Title = "Third Person Color",
            Default = Flags["Chams"].ThirdPersonColor,
        })
    end

    local Ambient = World:AddGroupbox({Name = "Ambient", Side = "Right"}) do
        Ambient:AddToggle("World/Ambient/Enabled", {
            Text = "Enabled",
            Default = Flags["Ambient"].Enabled,
        }):AddColorPicker("World/Ambient/Color", {
            Title = "Ambient Color",
            Default = Flags["Ambient"].Color,
        })
    end
end

local Settings = Window:AddTab("Settings") do
    local UserInterface = Settings:AddGroupbox({Name = "User Interface", Side = "Left"}) do
        UserInterface:AddToggle("Settings/UserInterface/Keybinds", {
            Text = "Keybinds",
            Default = false,
        })

        UserInterface:AddLabel("Toggle Keybind"):AddKeyPicker("Settings/UserInterface/Toggle", {
            Mode = "Toggle",
            Default = "End",
            NoUI = true,
        })

        UserInterface:AddButton({
            Text = "Unload",
            DoubleClick = true,
            Func = function()
                for _, Thread in Memory.Threads do
                    TCancel(Thread)
                end
    
                for _, Connection in Memory.Connections do
                    Connection:Disconnect()
                end
    
                for _, Drawing in Memory.Drawings do
                    Drawing:Remove()
                end
    
                TClear(Memory.Threads)
                TClear(Memory.Connections)
                TClear(Memory.Drawings)

                for _, Name in Memory.ESP.Chams do
                    for _, BoxHandleAdornment in Name do
                        BoxHandleAdornment:Destroy()
                    end
                end

                local Entry = Memory.ClientEntry
                if Entry then
                    Entry:despawn()
                end
    
                hookmetamethod(game, "__newindex", __newindex)
                NetworkClient.send = __send
                AudioSystem.playSound = __playSound
                ReplicationInterface.addEntry = __addEntry
                BulletInterface.newBullet = __newBullet
                Events.bigaward = __bigAward
                Events.correctposition = __correctposition
                TimeSyncClient._getCTime = __getCTime
    
                FakePlayer:Destroy()
                CustomOverlay:Destroy()
                Menu:Unload()
            end
        })
    end

    SaveManager:BuildConfigSection(Settings, "Right")
end

do
    --// Combat/Settings
    Toggles["Combat/Settings/AutoWall"]:OnChanged(function(Value)
        Flags["Auto Wall"] = Value
    end)

    Toggles["Combat/Settings/OriginScanning"]:OnChanged(function(Value)
        Flags["Origin Scanning"] = Value
    end)

    Options["Combat/Settings/HitBoxes"]:OnChanged(function(Value)
        local Values = {}

        for k, v in Value do
            TInsert(Values, k)
        end

        Flags["Hit Boxes"] = Values
    end)

    Options["Combat/Settings/MultiPoint"]:OnChanged(function(Value)
        local Values = {}

        for k, v in Value do
            TInsert(Values, k)
        end

        Flags["Multi Point"] = Values
    end)

    Options["Combat/Settings/PointTypes"]:OnChanged(function(Value)
        local Values = {}

        for k, v in Value do
            TInsert(Values, k)
        end

        Flags["Point Types"] = Values
    end)

    Options["Combat/Settings/SpoofHit"]:OnChanged(function(Value)
        Flags["Spoof Hit"] = Value
    end)
    
    Options["Combat/Settings/ScanningFrequency"]:OnChanged(function(Value)
        Flags["Scanning Frequency"] = Value
    end)

    Options["Combat/Settings/OriginOffset"]:OnChanged(function(Value)
        Flags["Origin Offset"] = Value
    end)

    Options["Combat/Settings/PointOffset"]:OnChanged(function(Value)
        Flags["Point Offset"] = Value
    end)

    Options["Combat/Settings/MinimumDamage"]:OnChanged(function(Value)
        Flags["Minimum Damage"] = Value
    end)

    --// Combat/SilentAim
    Toggles["Combat/SilentAim/Enabled"]:OnChanged(function(Value)
        Flags["Silent Aim"].Enabled = Value
    end)

    Options["Combat/SilentAim/Type"]:OnChanged(function(Value)
        Flags["Silent Aim"].Type = Value
    end)

    Options["Combat/SilentAim/Field"]:OnChanged(function(Value)
        Flags["Silent Aim"].Field = Value
    end)

    --// Combat/Ragebot
    Toggles["Combat/Ragebot/Enabled"]:OnChanged(function(Value)
        Flags["Ragebot"].Enabled = Value
    end)

    Options["Combat/Ragebot/Types"]:OnChanged(function(Value)
        local Values = {}

        for k, v in Value do
            TInsert(Values, k)
        end

        Flags["Ragebot"].Types = Values
    end)

    --// Combat/Weapon
    Toggles["Combat/Weapon/AutoReload"]:OnChanged(function(Value)
        Flags["Auto Reload"] = Value
    end)

    Toggles["Combat/Weapon/AutoChamber"]:OnChanged(function(Value)
        Flags["Auto Chamber"] = Value
    end)

    Toggles["Combat/Weapon/GrabAmmo"]:OnChanged(function(Value)
        Flags["Grab Ammo"] = Value
    end)

    Toggles["Combat/Weapon/UnlockAuto"]:OnChanged(function(Value)
        Flags["Unlock Auto"] = Value
    end)

    Options["Combat/Weapon/FireRate"]:OnChanged(function(Value)
        Flags["Fire Rate"] = Value
    end)

    Options["Combat/Weapon/KillSound"]:OnChanged(function(Value)
        Flags["Kill Sound"] = Value
    end)

    --// Combat/Players
    Options["Combat/Players/List"]:OnChanged(function(Value)
        local Friendly = Toggles["Combat/Players/Friendly"]
        local Enemy = Toggles["Combat/Players/Enemy"]

        if Friendly and Enemy and Value then
            Flags["Player Select"] = Players:FindFirstChild(Value)


            if Flags["Player Select"] and TFind(Flags["Friendly"], Flags["Player Select"].UserId) then
                Friendly:SetValue(true)
            else
                Friendly:SetValue(false)
            end
    
            if Flags["Player Select"] and TFind(Flags["Enemy"], Flags["Player Select"].UserId) then
                Enemy:SetValue(true)
            else
                Enemy:SetValue(false)
            end
        end
    end)

    Toggles["Combat/Players/Friendly"]:OnChanged(function(Value)
        local Selected = Flags["Player Select"]

        if Selected then
            local Enemy = Toggles["Combat/Players/Enemy"]
            if Value and Enemy.Value then
                Enemy:SetValue(false)
            end

            if Value and not TFind(Flags["Friendly"], Selected.UserId) then
                TInsert(Flags["Friendly"], Selected.UserId)
            elseif not Value and TFind(Flags["Friendly"], Selected.UserId) then
                TRemove(Flags["Friendly"], TFind(Flags["Friendly"], Selected.UserId))
            end
        end
    end)

    Toggles["Combat/Players/Enemy"]:OnChanged(function(Value)
        local Selected = Flags["Player Select"]

        if Selected then
            local Enemy = Toggles["Combat/Players/Friendly"]
            if Value and Enemy.Value then
                Enemy:SetValue(false)
            end

            if Value and not TFind(Flags["Enemy"], Selected.UserId) then
                TInsert(Flags["Enemy"], Selected.UserId)
            elseif not Value and TFind(Flags["Enemy"], Selected.UserId) then
                TRemove(Flags["Enemy"], TFind(Flags["Enemy"], Selected.UserId))
            end
        end
    end)

    --// World/ESP
    Toggles["World/ESP/Enabled"]:OnChanged(function(Value)
        Flags["ESP"].Enabled = Value

        if not Value then
            for Key, Frame in Memory.ESP.Frames do
                Frame:Destroy()
                Memory.ESP.Frames[Key] = nil
            end

            for _, Name in Memory.ESP.Chams do
                for _, BoxHandleAdornment in Name do
                    BoxHandleAdornment:Destroy()
                end
            end
        end
    end)

    Options["World/ESP/Settings"]:OnChanged(function(Value)
        Flags["ESP"].Settings = Value
    end)

    --// World/ThirdPerson
    Toggles["World/ThirdPerson/Enabled"]:OnChanged(function(Value)
        Flags["Third Person"].Enabled = Value

        if Memory.ClientEntry and not Value then
            Memory.ClientEntry:despawn()
        end
    end)

    Options["World/ThirdPerson/Zoom"]:OnChanged(function(Value)
        Flags["Third Person"].Zoom = Value
    end)

    --// World/Camera
    Toggles["World/Camera/NoShake"]:OnChanged(function(Value)
        Flags["Camera"].NoShake = Value
    end)

    Toggles["World/Camera/NoSway"]:OnChanged(function(Value)
        Flags["Camera"].NoSway = Value
    end)

    Options["World/Camera/FieldOfView"]:OnChanged(function(Value)
        Flags["Camera"].FieldOfView = Value
    end)

    --// World/BulletTracers
    Toggles["World/BulletTracers/Enabled"]:OnChanged(function(Value)
        Flags["Bullet Tracers"].Enabled = Value
    end)

    Options["World/BulletTracers/LifeTime"]:OnChanged(function(Value)
        Flags["Bullet Tracers"].LifeTime = Value
    end)

    Options["World/BulletTracers/Color"]:OnChanged(function(Value)
        Flags["Bullet Tracers"].Color = Value
    end)

    --// World/BarrelCrosshair
    Toggles["World/BarrelCrosshair/Enabled"]:OnChanged(function(Value)
        Flags["Barrel Crosshair"].Enabled = Value

        if Memory.Crosshair and not Value then
            Memory.Crosshair.Holder:Destroy()
            Memory.Crosshair = nil
        end
    end)

    Options["World/BarrelCrosshair/Size"]:OnChanged(function(Value)
        Flags["Barrel Crosshair"].Size = Value
    end)

    Options["World/BarrelCrosshair/Spacing"]:OnChanged(function(Value)
        Flags["Barrel Crosshair"].Spacing = Value
    end)

    Options["World/BarrelCrosshair/Rotation"]:OnChanged(function(Value)
        Flags["Barrel Crosshair"].Rotation = Value
    end)

    Options["World/BarrelCrosshair/Color"]:OnChanged(function(Value)
        Flags["Barrel Crosshair"].Color = Value
    end)

    print("eyes!")

    --// World/AntiAim
    Toggles["World/AntiAim/Enabled"]:OnChanged(function(Value)
        Flags["Anti Aim"].Enabled = Value
    end)

    Options["World/AntiAim/Yaw"]:OnChanged(function(Value)
        Flags["Anti Aim"].Yaw = Value
    end)

    Options["World/AntiAim/Pitch"]:OnChanged(function(Value)
        Flags["Anti Aim"].Pitch = Value
    end)
    
    Options["World/AntiAim/Rate"]:OnChanged(function(Value)
        Flags["Anti Aim"].Rate = Value
    end)

    --// World/FakeLag
    Toggles["World/FakeLag/Enabled"]:OnChanged(function(Value)
        Flags["Fake Lag"].Enabled = Value

        local BreakToggle = Toggles["World/FakeLag/Break"]
        if BreakToggle then
            BreakToggle:SetRisky(not Value)

            if BreakToggle.Value and not Value then
                BreakToggle:SetValue(Value)
            end
        end
    end)

    Toggles["World/FakeLag/Break"]:OnChanged(function(Value)
        Flags["Fake Lag"].Break = Value
    end)
    
    Options["World/FakeLag/Tick"]:OnChanged(function(Value)
        Flags["Fake Lag"].Tick = Value
    end)

    --// World/SpeedHack
    Toggles["World/SpeedHack/Enabled"]:OnChanged(function(Value)
        Flags["Speed Hack"].Enabled = Value
    end)

    Toggles["World/SpeedHack/Bypass"]:OnChanged(function(Value)
        Flags["Speed Hack"].Bypass = Value

        local FlyToggle = Toggles["World/SpeedHack/Fly"]
        local VelocitySlider = Options["World/SpeedHack/Velocity"]

        if FlyToggle then
            FlyToggle:SetRisky(not Value)

            if FlyToggle.Value and not Value then
                FlyToggle:SetValue(Value)
            end
        end

        if VelocitySlider then
            VelocitySlider.Max = Value and 110 or 50

            local Velocity = VelocitySlider.Value
            if Velocity > VelocitySlider.Max then
                Velocity = VelocitySlider.Max
            end

            VelocitySlider:SetValue(Velocity)
        end
    end)

    Toggles["World/SpeedHack/Fly"]:OnChanged(function(Value)
        Flags["Speed Hack"].Fly = Value

        if Client.RootPart and Client.RootPart.Anchored and not Value then
            Client.RootPart.Anchored = false
        end
    end)

    Options["World/SpeedHack/Velocity"]:OnChanged(function(Value)
        Flags["Speed Hack"].Velocity = Value
    end)

    --// World/Chams
    Toggles["World/Chams/Weapon"]:OnChanged(function(Value)
        Flags["Chams"].Weapon = Value
    end)

    Options["World/Chams/WeaponColor"]:OnChanged(function(Value)
        Flags["Chams"].WeaponColor = Value
    end)

    Toggles["World/Chams/Arms"]:OnChanged(function(Value)
        Flags["Chams"].Arms = Value
    end)

    Options["World/Chams/ArmColor"]:OnChanged(function(Value)
        Flags["Chams"].ArmColor = Value
    end)

    Toggles["World/Chams/ThirdPerson"]:OnChanged(function(Value)
        Flags["Chams"].ThirdPerson = Value
    end)

    Options["World/Chams/ThirdPersonColor"]:OnChanged(function(Value)
        Flags["Chams"].ThirdPersonColor = Value
    end)

    --// World/Ambient
    Toggles["World/Ambient/Enabled"]:OnChanged(function(Value)
        Flags["Ambient"].Enabled = Value
    end)

    Options["World/Ambient/Color"]:OnChanged(function(Value)
        Flags["Ambient"].Color = Value
    end)

    --// Settings/UserInterface
    Toggles["Settings/UserInterface/Keybinds"]:OnChanged(function(Value)
        Menu:SetKeybindContainerVisibility(Value)
    end)

    Options["Settings/UserInterface/Toggle"]:OnChanged(function(Value)
        Menu.ToggleBind = Value
    end)
end

Menu:Notify(string.format("Welcome to squidhook!", debug.info(1, "l")), 2)
Menu:Notify(string.format("If you have any bugs please report to Legacy.", debug.info(1, "l")), 2)
