local NotifyLibrary = loadstring(game:HttpGet("https://pastebin.com/raw/zg2UfGDN"))()
local Notify = NotifyLibrary.Notify



local AnimationModule = {
    Astronaut = {
        "rbxassetid://891621366",
        "rbxassetid://891633237",
        "rbxassetid://891667138",
        "rbxassetid://891636393",
        "rbxassetid://891627522",
        "rbxassetid://891609353",
        "rbxassetid://891617961"
    },
    Bubbly = {
        "rbxassetid://910004836",
        "rbxassetid://910009958",
        "rbxassetid://910034870",
        "rbxassetid://910025107",
        "rbxassetid://910016857",
        "rbxassetid://910001910",
        "rbxassetid://910030921",
        "rbxassetid://910028158"
    },
    Cartoony = {
        "rbxassetid://742637544",
        "rbxassetid://742638445",
        "rbxassetid://742640026",
        "rbxassetid://742638842",
        "rbxassetid://742637942",
        "rbxassetid://742636889",
        "rbxassetid://742637151"
    },
    Confindent = {
        "rbxassetid://1069977950",
        "rbxassetid://1069987858",
        "rbxassetid://1070017263",
        "rbxassetid://1070001516",
        "rbxassetid://1069984524",
        "rbxassetid://1069946257",
        "rbxassetid://1069973677"
    },
    Cowboy = {
        "rbxassetid://1014390418",
        "rbxassetid://1014398616",
        "rbxassetid://1014421541",
        "rbxassetid://1014401683",
        "rbxassetid://1014394726",
        "rbxassetid://1014380606",
        "rbxassetid://1014384571"
    },
    Default = {
        "http://www.roblox.com/asset/?id=507766666",
        "http://www.roblox.com/asset/?id=507766951",
        "http://www.roblox.com/asset/?id=507777826",
        "http://www.roblox.com/asset/?id=507767714",
        "http://www.roblox.com/asset/?id=507765000",
        "http://www.roblox.com/asset/?id=507765644",
        "http://www.roblox.com/asset/?id=507767968"
    },
    Elder = {
        "rbxassetid://845397899",
        "rbxassetid://845400520",
        "rbxassetid://845403856",
        "rbxassetid://845386501",
        "rbxassetid://845398858",
        "rbxassetid://845392038",
        "rbxassetid://845396048" 
    },
    Ghost = {
        "rbxassetid://616006778",
        "rbxassetid://616008087",
        "rbxassetid://616013216",
        "rbxassetid://616013216",
        "rbxassetid://616008936",
        "rbxassetid://616005863",
        "rbxassetid://616012453",
        "rbxassetid://616011509"
    },
    Knight = {
        "rbxassetid://657595757",
        "rbxassetid://657568135",
        "rbxassetid://657552124",
        "rbxassetid://657564596",
        "rbxassetid://658409194",
        "rbxassetid://658360781",
        "rbxassetid://657600338"
    },
    Levitation = {
        "rbxassetid://616006778",
        "rbxassetid://616008087",
        "rbxassetid://616013216",
        "rbxassetid://616010382",
        "rbxassetid://616008936",
        "rbxassetid://616003713",
        "rbxassetid://616005863"
    },
    Mage = {
        "rbxassetid://707742142",
        "rbxassetid://707855907",
        "rbxassetid://707897309",
        "rbxassetid://707861613",
        "rbxassetid://707853694",
        "rbxassetid://707826056",
        "rbxassetid://707829716"
    },
    Ninja = {
        "rbxassetid://656117400",
        "rbxassetid://656118341",
        "rbxassetid://656121766",
        "rbxassetid://656118852",
        "rbxassetid://656117878",
        "rbxassetid://656114359",
        "rbxassetid://656115606"
    },
    OldSchool = {
        "rbxassetid://5319828216",
        "rbxassetid://5319831086",
        "rbxassetid://5319847204",
        "rbxassetid://5319844329",
        "rbxassetid://5319841935",
        "rbxassetid://5319839762",
        "rbxassetid://5319852613",
        "rbxassetid://5319850266"
    },
    Patrol = {
        "rbxassetid://1149612882",
        "rbxassetid://1150842221",
        "rbxassetid://1151231493",
        "rbxassetid://1150967949",
        "rbxassetid://1148811837",
        "rbxassetid://1148811837",
        "rbxassetid://1148863382"
    },
    Pirtate = {
        "rbxassetid://750781874",
        "rbxassetid://750782770",
        "rbxassetid://750785693",
        "rbxassetid://750783738",
        "rbxassetid://750782230",
        "rbxassetid://750779899",
        "rbxassetid://750780242"
    },
    Popstar = {
        "rbxassetid://1212900985",
        "rbxassetid://1150842221",
        "rbxassetid://1212980338",
        "rbxassetid://1212980348",
        "rbxassetid://1212954642",
        "rbxassetid://1213044953",
        "rbxassetid://1212900995"
    },
    Princess = {
        "rbxassetid://941003647",
        "rbxassetid://941013098",
        "rbxassetid://941028902",
        "rbxassetid://941015281",
        "rbxassetid://941008832",
        "rbxassetid://940996062",
        "rbxassetid://941000007"
    },
    Robot = {
        "rbxassetid://616088211",
        "rbxassetid://616089559",
        "rbxassetid://616095330",
        "rbxassetid://616091570",
        "rbxassetid://616090535",
        "rbxassetid://616086039",
        "rbxassetid://616087089"
    },
    Rthro = {
        "rbxassetid://2510196951",
        "rbxassetid://2510197257",
        "rbxassetid://2510202577",
        "rbxassetid://2510198475",
        "rbxassetid://2510197830",
        "rbxassetid://2510195892",
        "rbxassetid://02510201162",
        "rbxassetid://2510199791",
        "rbxassetid://2510192778"
    },
    Sneaky = {
        "rbxassetid://1132473842",
        "rbxassetid://1132477671",
        "rbxassetid://1132510133",
        "rbxassetid://1132494274",
        "rbxassetid://1132489853",
        "rbxassetid://1132461372",
        "rbxassetid://1132469004"
    },
    Stylish = {
        "rbxassetid://616136790",
        "rbxassetid://616138447",
        "rbxassetid://616146177",
        "rbxassetid://616140816",
        "rbxassetid://616139451",
        "rbxassetid://616133594",
        "rbxassetid://616134815"
    },
    Superhero = {
        "rbxassetid://782841498",
        "rbxassetid://782845736",
        "rbxassetid://782843345",
        "rbxassetid://782842708",
        "rbxassetid://782847020",
        "rbxassetid://782843869",
        "rbxassetid://782846423"
    },
    Toy = {
        "rbxassetid://782841498",
        "rbxassetid://782845736",
        "rbxassetid://782843345",
        "rbxassetid://782842708",
        "rbxassetid://782847020",
        "rbxassetid://782843869",
        "rbxassetid://782846423"
    },
    Vampire = {
        "rbxassetid://1083445855",
        "rbxassetid://1083450166",
        "rbxassetid://1083473930",
        "rbxassetid://1083462077",
        "rbxassetid://1083455352",
        "rbxassetid://1083439238",
        "rbxassetid://1083443587"
    },
    Werewolf = {
        "rbxassetid://1083195517",
        "rbxassetid://1083214717",
        "rbxassetid://1083178339",
        "rbxassetid://1083216690",
        "rbxassetid://1083218792",
        "rbxassetid://1083182000",
        "rbxassetid://1083189019"
    },
    Zombie = {
        "rbxassetid://616158929",
        "rbxassetid://616160636",
        "rbxassetid://616168032",
        "rbxassetid://616163682",
        "rbxassetid://616161997",
        "rbxassetid://616156119",
        "rbxassetid://616157476"
    }
}

local AnimationsName = {
    "Astronaut",
    "Bubbly",
    "Cartoony",
    "Confindent",
    "Cowboy",
    "Default",
    "Elder",
    "Ghost",
    "Knight",
    "Levitation",
    "Mage",
    "Ninja",
    "OldSchool",
    "Patrol",
    "Pirate",
    "Popstar",
    "Princess",
    "Robot",
    "Rthro",
    'Sneaky',
    "Stylish",
    "Superhero",
    "Toy",
    "Vampire",
    "Werewolf",
    "Zombie"
}

local AnimationState = {
    Idle = "Default",
    Walk = "Default",
    Run = "Default",
    Jump = "Default",
    Climb = "Default",
    Fall = "Default",
}

loadstring(game:HttpGet("https://pastebin.com/raw/b7cr3FPZ"))()


local CWatermark = Instance.new("ScreenGui")
local Background = Instance.new("Frame")
local UIPadding = Instance.new("UIPadding")
local UIListLayout = Instance.new("UIListLayout")
local TopColor = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")
local Text = Instance.new("TextLabel")
local UIListLayout_2 = Instance.new("UIListLayout")

--Properties:

CWatermark.Name = "CWatermark"
CWatermark.Parent = game.CoreGui
CWatermark.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
CWatermark.ResetOnSpawn = false

Background.Name = "Background"
Background.Parent = CWatermark
Background.AnchorPoint = Vector2.new(0, 1)
Background.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
Background.BorderColor3 = Color3.fromRGB(60, 60, 60)
Background.BorderSizePixel = 2
Background.Position = UDim2.new(0, 22, 0, 22)
Background.Size = UDim2.new(0, 410, 0, 24)
Background.Active = true
Background.Draggable = true

UIPadding.Parent = Background

UIListLayout.Parent = Background
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

TopColor.Name = "TopColor"
TopColor.Parent = Background
TopColor.AnchorPoint = Vector2.new(0, 1)
TopColor.BackgroundColor3 = Color3.fromRGB(170, 0, 255)
TopColor.BorderColor3 = Color3.fromRGB(60, 60, 60)
TopColor.BorderSizePixel = 0
TopColor.Position = UDim2.new(-0.0109756095, 0, 0.0833333358, 0)
TopColor.Size = UDim2.new(0, 410, 0, 2)

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.25), NumberSequenceKeypoint.new(0.50, 0.76), NumberSequenceKeypoint.new(1.00, 0.24)}
UIGradient.Parent = TopColor

Text.Name = "Text"
Text.Parent = TopColor
Text.AnchorPoint = Vector2.new(0, 1)
Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text.BackgroundTransparency = 1.000
Text.Position = UDim2.new(0.0109756095, 0, 11, 0)
Text.Size = UDim2.new(0, 405, 0, 22)
Text.Font = Enum.Font.Code
Text.Text = "Loading! | This may take long due to http errors"
Text.TextColor3 = Color3.fromRGB(255, 255, 255)
Text.TextScaled = true
Text.TextSize = 14.000
Text.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
Text.TextWrapped = true

UIListLayout_2.Parent = TopColor
UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

-- Scripts:

local function NKXPFO_fake_script() -- Text.LocalScript 
	local script = Instance.new('LocalScript', Text)

	game:GetService("RunService").RenderStepped:Connect(function(fpsmath) 
		script.Parent.Text = ("Crimskid | " ..game.Players.LocalPlayer.Name.. " | " ..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name.. " | FPS: " .. math.floor(1/fpsmath))
	end)
end
coroutine.wrap(NKXPFO_fake_script)()


_G.Prediction =   ( .18  )

_G.FOV =   600 

_G.AimKey =  "q"


--[[
    TripleKill#6957
]]

local SilentAim = false
local LocalPlayer = game:GetService("Players").LocalPlayer
local Players = game:GetService("Players")
local Mouse = LocalPlayer:GetMouse()
local Camera = game:GetService("Workspace").CurrentCamera
hookmetamethod = hookmetamethod
Drawing = Drawing

local FOV_CIRCLE = Drawing.new("Circle")
_G.Circle = FOV_CIRCLE _G.Circle.Visible = true
FOV_CIRCLE.Visible = false
FOV_CIRCLE.Filled = false
FOV_CIRCLE.Thickness = 1
FOV_CIRCLE.Transparency = 1
FOV_CIRCLE.Color = Color3.new(1, 1, 1)
FOV_CIRCLE.Radius = _G.FOV
FOV_CIRCLE.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

Options = {
    Torso = "HumanoidRootPart";
    Head = "Head";
}

local function MoveFovCircle()
    pcall(function()
        local DoIt = true
        spawn(function()
            while DoIt do task.wait()
                FOV_CIRCLE.Position = Vector2.new(Mouse.X, (Mouse.Y + 36))
            end
        end)
    end)
end coroutine.wrap(MoveFovCircle)()

Mouse.KeyDown:Connect(function(KeyPressed)
    if KeyPressed == (_G.AimKey:lower()) then
        if SilentAim == false then
             
            game:GetService("StarterGui"):SetCore("SendNotification",{     

                Title = "Crimskid",     
                
                Text = "Silent : On",
                
                Duration = 3
                
                })
            SilentAim = true
        elseif SilentAim == true then
            game:GetService("StarterGui"):SetCore("SendNotification",{     

                Title = "Crimskid",     
                
                Text = "Silent : Off",
                
                Duration = 3
                
                })
            SilentAim = false
        end
    end
end)

local oldIndex = nil 
oldIndex = hookmetamethod(game, "__index", function(self, Index)
    if self == Mouse and (Index == "Hit") then 
        local Distance = 9e9
        local Targete = nil
        if SilentAim then
            
            for _, v in pairs(Players:GetPlayers()) do 
                if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("Humanoid").Health > 0 then
                    local Enemy = v.Character    
                    local CastingFrom = CFrame.new(Camera.CFrame.Position, Enemy[Options.Torso].CFrame.Position) * CFrame.new(0, 0, -4)
                    local RayCast = Ray.new(CastingFrom.Position, CastingFrom.LookVector * 9000)
                    local World, ToSpace = workspace:FindPartOnRayWithIgnoreList(RayCast, {LocalPlayer.Character:FindFirstChild("Head")})
                    local RootWorld = (Enemy[Options.Torso].CFrame.Position - ToSpace).magnitude
                    if RootWorld < 4 then
                        local RootPartPosition, Visible = Camera:WorldToScreenPoint(Enemy[Options.Torso].Position)
                        if Visible then
                            local Real_Magnitude = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(RootPartPosition.X, RootPartPosition.Y)).Magnitude
                            if Real_Magnitude < Distance and Real_Magnitude < FOV_CIRCLE.Radius then
                                Distance = Real_Magnitude
                                Targete = Enemy
                            end
                        end
                    end
                end
            end
        end
        
        if Targete ~= nil and Targete[Options.Torso] and Targete:FindFirstChild("Humanoid").Health > 0 then
            if SilentAim then
                local ShootThis = Targete[Options.Head] -- or Options.Head
                local Predicted_Position = ShootThis.CFrame + (ShootThis.Velocity * _G.Prediction + Vector3.new(0,_G.positionforsilent,0)) --  (-1) = Less blatant
                return ((Index == "Hit" and Predicted_Position))
            end
        end
        
    end
    return oldIndex(self, Index)

end) 

getgenv().runService = game:GetService"RunService"
getgenv().textService = game:GetService"TextService"
getgenv().inputService = game:GetService"UserInputService"
getgenv().tweenService = game:GetService"TweenService"

local runService = runService
local textService = textService
local inputService = inputService
local tweenService = tweenService

if getgenv().library then
getgenv().library:Unload()
end

-- [UI Library Settings]
local library = {
tabs = {},
draggable = true,
flags = {},
title = "crimskid",
open = false,
mousestate = inputService.MouseIconEnabled,
popup = nil,
instances = {},
connections = {},
options = {},
notifications = {},
tabSize = 0,
theme = {},
foldername = "crimskid configs",
fileext = ".crimskid"
}

getgenv().library = library

local dragging, dragInput, dragStart, startPos, dragObject
local blacklistedKeys = { 
Enum.KeyCode.Unknown,
Enum.KeyCode.W,
Enum.KeyCode.A,
Enum.KeyCode.S,
Enum.KeyCode.D,
Enum.KeyCode.Slash,
Enum.KeyCode.Tab,
Enum.KeyCode.Escape
}
local whitelistedMouseinputs = { 
Enum.UserInputType.MouseButton1,
Enum.UserInputType.MouseButton2,
Enum.UserInputType.MouseButton3
}

library.round = function(num, bracket)
bracket = bracket or 1
local a
if typeof(num) == "Vector2" then
    a = Vector2.new(library.round(num.X), library.round(num.Y))
elseif typeof(num) == "Color3" then
    return library.round(num.r * 255), library.round(num.g * 255), library.round(num.b * 255)
else
    a = math.floor(num / bracket + (math.sign(num) * 0.5)) * bracket
    if a < 0 then
        a = a + bracket
    end
    return a
end
return a
end

local chromaColor
spawn(function()
while library and wait() do
    chromaColor = Color3.fromHSV(tick() % 6 / 6, 1, 1)
end
end)

function library:Create(class, properties)
properties = properties or {}
if not class then
    return
end
local a = class == "Square" or class == "Line" or class == "Text" or class == "Quad" or class == "Circle" or class == "Triangle"
local t = a and Drawing or Instance
local inst = t.new(class)
for property, value in next, properties do
    inst[property] = value
end
table.insert(self.instances, {
    object = inst,
    method = a
})
return inst
end

function library:AddConnection(connection, name, callback)
callback = type(name) == "function" and name or callback
connection = connection:connect(callback)
if name ~= callback then
    self.connections[name] = connection
else
    table.insert(self.connections, connection)
end
return connection
end

function library:Unload()
inputService.MouseIconEnabled = self.mousestate
for _, c in next, self.connections do
    c:Disconnect()
end
for _, i in next, self.instances do
    if i.method then
        pcall(function()
            i.object:Remove()
        end)
    else
        i.object:Destroy()
    end
end
for _, o in next, self.options do
    if o.type == "toggle" then
        pcall(function()
            o:SetState()
        end)
    end
end
library = nil
getgenv().library = nil
end

function library:LoadConfig(config)
if table.find(self:GetConfigs(), config) then
    local Read, Config = pcall(function()
        return game:GetService"HttpService":JSONDecode(readfile(self.foldername .. "/" .. config .. self.fileext))
    end)
    Config = Read and Config or {}
    for _, option in next, self.options do
        if option.hasInit then
            if option.type ~= "button" and option.flag and not option.skipflag then
                if option.type == "toggle" then
                    spawn(function()
                        option:SetState(Config[option.flag] == 1)
                    end)
                elseif option.type == "color" then
                    if Config[option.flag] then
                        spawn(function()
                            option:SetColor(Config[option.flag])
                        end)
                        if option.trans then
                            spawn(function()
                                option:SetTrans(Config[option.flag .. " Transparency"])
                            end)
                        end
                    end
                elseif option.type == "bind" then
                    spawn(function()
                        option:SetKey(Config[option.flag])
                    end)
                else
                    spawn(function()
                        option:SetValue(Config[option.flag])
                    end)
                end
            end
        end
    end
end
end

function library:SaveConfig(config)
local Config = {}
if table.find(self:GetConfigs(), config) then
    Config = game:GetService"HttpService":JSONDecode(readfile(self.foldername .. "/" .. config .. self.fileext))
end
for _, option in next, self.options do
    if option.type ~= "button" and option.flag and not option.skipflag then
        if option.type == "toggle" then
            Config[option.flag] = option.state and 1 or 0
        elseif option.type == "color" then
            Config[option.flag] = {
                option.color.r,
                option.color.g,
                option.color.b
            }
            if option.trans then
                Config[option.flag .. " Transparency"] = option.trans
            end
        elseif option.type == "bind" then
            Config[option.flag] = option.key
        elseif option.type == "list" then
            Config[option.flag] = option.value
        else
            Config[option.flag] = option.value
        end
    end
end
writefile(self.foldername .. "/" .. config .. self.fileext, game:GetService"HttpService":JSONEncode(Config))
end

function library:GetConfigs()
if not isfolder(self.foldername) then
    makefolder(self.foldername)
    return {}
end
local files = {}
local a = 0
for i, v in next, listfiles(self.foldername) do
    if v:sub(#v - #self.fileext + 1, #v) == self.fileext then
        a = a + 1
        v = v:gsub(self.foldername .. "\\", "")
        v = v:gsub(self.fileext, "")
        table.insert(files, a, v)
    end
end
return files
end

local function createLabel(option, parent)
option.main = library:Create("TextLabel", {
    LayoutOrder = option.position,
    Position = UDim2.new(0, 6, 0, 0),
    Size = UDim2.new(1, -12, 0, 24),
    BackgroundTransparency = 1,
    TextSize = 15,
    Font = Enum.Font.Code,
    TextColor3 = Color3.new(1, 1, 1),
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    TextWrapped = true,
    Parent = parent
})
setmetatable(option, {
    __newindex = function(t, i, v)
        if i == "Text" then
            option.main.Text = tostring(v)
            option.main.Size = UDim2.new(1, -12, 0, textService:GetTextSize(option.main.Text, 15, Enum.Font.Code, Vector2.new(option.main.AbsoluteSize.X, 9e9)).Y + 6)
        end
    end
})
option.Text = option.text
end

local function createDivider(option, parent)
option.hasInit = true
option.main = library:Create("Frame", {
    LayoutOrder = option.position,
    Size = UDim2.new(1, 0, 0, 18),
    BackgroundTransparency = 1,
    Parent = parent
})
library:Create("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(1, -24, 0, 1),
    BackgroundColor3 = Color3.fromRGB(71, 69, 71),
    BorderColor3 = Color3.new(),
    Parent = option.main
})
option.title = library:Create("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    BorderSizePixel = 0,
    TextColor3 =  Color3.new(1, 1, 1),
    TextSize = 15,
    Font = Enum.Font.Code,
    TextXAlignment = Enum.TextXAlignment.Center,
    Parent = option.main
})
setmetatable(option, {
    __newindex = function(t, i, v)
        if i == "Text" then
            if v then
                option.title.Text = tostring(v)
                option.title.Size = UDim2.new(0, textService:GetTextSize(option.title.Text, 15, Enum.Font.Code, Vector2.new(9e9, 9e9)).X + 12, 0, 20)
                option.main.Size = UDim2.new(1, 0, 0, 18)
            else
                option.title.Text = ""
                option.title.Size = UDim2.new()
                option.main.Size = UDim2.new(1, 0, 0, 6)
            end
        end
    end
})
option.Text = option.text
end

local function createToggle(option, parent)
option.hasInit = true
option.main = library:Create("Frame", {
    LayoutOrder = option.position,
    Size = UDim2.new(1, 0, 0, 20),
    BackgroundTransparency = 1,
    Parent = parent
})
local tickbox
local tickboxOverlay
if option.style then
    tickbox = library:Create("ImageLabel", {
        Position = UDim2.new(0, 6, 0, 4),
        Size = UDim2.new(0, 12, 0, 12),
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageColor3 = Color3.new(),
        Parent = option.main
    })
    library:Create("ImageLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, -2, 1, -2),
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageColor3 = Color3.fromRGB(60, 60, 60),
        Parent = tickbox
    })
    library:Create("ImageLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, -6, 1, -6),
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageColor3 = Color3.fromRGB(40, 40, 40),
        Parent = tickbox
    })
    tickboxOverlay = library:Create("ImageLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, -6, 1, -6),
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageColor3 = library.flags["Menu Accent Color"],
        Visible = option.state,
        Parent = tickbox
    })
    library:Create("ImageLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Image = "rbxassetid://5941353943",
        ImageTransparency = 0.6,
        Parent = tickbox
    })
    table.insert(library.theme, tickboxOverlay)
else
    tickbox = library:Create("Frame", {
        Position = UDim2.new(0, 6, 0, 4),
        Size = UDim2.new(0, 12, 0, 12),
        BackgroundColor3 = library.flags["Menu Accent Color"],
        BorderColor3 = Color3.new(),
        Parent = option.main
    })
    tickboxOverlay = library:Create("ImageLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = option.state and 1 or 0,
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        BorderColor3 = Color3.new(),
        Image = "rbxassetid://4155801252",
        ImageTransparency = 0.6,
        ImageColor3 = Color3.new(),
        Parent = tickbox
    })
    library:Create("ImageLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Image = "rbxassetid://2592362371",
        ImageColor3 = Color3.fromRGB(60, 60, 60),
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(2, 2, 62, 62),
        Parent = tickbox
    })
    library:Create("ImageLabel", {
        Size = UDim2.new(1, -2, 1, -2),
        Position = UDim2.new(0, 1, 0, 1),
        BackgroundTransparency = 1,
        Image = "rbxassetid://2592362371",
        ImageColor3 = Color3.new(),
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(2, 2, 62, 62),
        Parent = tickbox
    })
    table.insert(library.theme, tickbox)
end
option.interest = library:Create("Frame", {
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(1, 0, 0, 20),
    BackgroundTransparency = 1,
    Parent = option.main
})
option.title = library:Create("TextLabel", {
    Position = UDim2.new(0, 24, 0, 0),
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Text = option.text,
    TextColor3 =  option.state and Color3.fromRGB(210, 210, 210) or Color3.fromRGB(180, 180, 180),
    TextSize = 15,
    Font = Enum.Font.Code,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = option.interest
})
option.interest.InputBegan:connect(function(input)
    if input.UserInputType.Name == "MouseButton1" then
        option:SetState(not option.state)
    end
    if input.UserInputType.Name == "MouseMovement" then
        if not library.warning and not library.slider then
            if option.style then
                tickbox.ImageColor3 = library.flags["Menu Accent Color"]
            else
                tickbox.BorderColor3 = library.flags["Menu Accent Color"]
                tickboxOverlay.BorderColor3 = library.flags["Menu Accent Color"]
            end
        end
        if option.tip then
            library.tooltip.Text = option.tip
            library.tooltip.Size = UDim2.new(0, textService:GetTextSize(option.tip, 15, Enum.Font.Code, Vector2.new(9e9, 9e9)).X, 0, 20)
        end
    end
end)
option.interest.InputChanged:connect(function(input)
    if input.UserInputType.Name == "MouseMovement" then
        if option.tip then
            library.tooltip.Position = UDim2.new(0, input.Position.X + 26, 0, input.Position.Y + 36)
        end
    end
end)
option.interest.InputEnded:connect(function(input)
    if input.UserInputType.Name == "MouseMovement" then
        if option.style then
            tickbox.ImageColor3 = Color3.new()
        else
            tickbox.BorderColor3 = Color3.new()
            tickboxOverlay.BorderColor3 = Color3.new()
        end
        library.tooltip.Position = UDim2.new(2)
    end
end)

function option:SetState(state, nocallback)
    state = typeof(state) == "boolean" and state
    state = state or false
    library.flags[self.flag] = state
    self.state = state
    option.title.TextColor3 = state and Color3.fromRGB(210, 210, 210) or Color3.fromRGB(160, 160, 160)
    if option.style then
        tickboxOverlay.Visible = state
    else
        tickboxOverlay.BackgroundTransparency = state and 1 or 0
    end
    if not nocallback then
        self.callback(state)
    end
end
if option.state then
    delay(1, function()
        if library then
            option.callback(true)
        end
    end)
end
setmetatable(option, {
    __newindex = function(t, i, v)
        if i == "Text" then
            option.title.Text = tostring(v)
        end
    end
})
end

local function createButton(option, parent)
option.hasInit = true
option.main = library:Create("Frame", {
    LayoutOrder = option.position,
    Size = UDim2.new(1, 0, 0, 26),
    BackgroundTransparency = 1,
    Parent = parent
})
option.title = library:Create("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 1),
    Position = UDim2.new(0.5, 0, 1, -5),
    Size = UDim2.new(1, -12, 0, 18),
    BackgroundColor3 = Color3.fromRGB(50, 50, 50),
    BorderColor3 = Color3.new(),
    Text = option.text,
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 15,
    Font = Enum.Font.Code,
    Parent = option.main
})
library:Create("ImageLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2592362371",
    ImageColor3 = Color3.fromRGB(60, 60, 60),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(2, 2, 62, 62),
    Parent = option.title
})
library:Create("ImageLabel", {
    Size = UDim2.new(1, -2, 1, -2),
    Position = UDim2.new(0, 1, 0, 1),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2592362371",
    ImageColor3 = Color3.new(),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(2, 2, 62, 62),
    Parent = option.title
})
library:Create("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 180, 180)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(253, 253, 253)),
    }),
    Rotation = -90,
    Parent = option.title
})
option.title.InputBegan:connect(function(input)
    if input.UserInputType.Name == "MouseButton1" then
        option.callback()
        if library then
            library.flags[option.flag] = true
        end
        if option.tip then
            library.tooltip.Text = option.tip
            library.tooltip.Size = UDim2.new(0, textService:GetTextSize(option.tip, 15, Enum.Font.Code, Vector2.new(9e9, 9e9)).X, 0, 20)
        end
    end
    if input.UserInputType.Name == "MouseMovement" then
        if not library.warning and not library.slider then
            option.title.BorderColor3 = library.flags["Menu Accent Color"]
        end
    end
end)
option.title.InputChanged:connect(function(input)
    if input.UserInputType.Name == "MouseMovement" then
        if option.tip then
            library.tooltip.Position = UDim2.new(0, input.Position.X + 26, 0, input.Position.Y + 36)
        end
    end
end)
option.title.InputEnded:connect(function(input)
    if input.UserInputType.Name == "MouseMovement" then
        option.title.BorderColor3 = Color3.new()
        library.tooltip.Position = UDim2.new(2)
    end
end)
end

local function createBind(option, parent)
option.hasInit = true
local binding
local holding
local Loop
if option.sub then
    option.main = option:getMain()
else
    option.main = option.main or library:Create("Frame", {
        LayoutOrder = option.position,
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Parent = parent
    })
    library:Create("TextLabel", {
        Position = UDim2.new(0, 6, 0, 0),
        Size = UDim2.new(1, -12, 1, 0),
        BackgroundTransparency = 1,
        Text = option.text,
        TextSize = 15,
        Font = Enum.Font.Code,
        TextColor3 = Color3.fromRGB(210, 210, 210),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = option.main
    })
end

local bindinput = library:Create(option.sub and "TextButton" or "TextLabel", {
    Position = UDim2.new(1, -6 - (option.subpos or 0), 0, option.sub and 2 or 3),
    SizeConstraint = Enum.SizeConstraint.RelativeYY,
    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    BorderSizePixel = 0,
    TextSize = 15,
    Font = Enum.Font.Code,
    TextColor3 = Color3.fromRGB(160, 160, 160),
    TextXAlignment = Enum.TextXAlignment.Right,
    Parent = option.main
})

if option.sub then
    bindinput.AutoButtonColor = false
end

local interest = option.sub and bindinput or option.main
local inContact
interest.InputEnded:connect(function(input)
    if input.UserInputType.Name == "MouseButton1" then
        binding = true
        bindinput.Text = "[...]"
        bindinput.Size = UDim2.new(0, -textService:GetTextSize(bindinput.Text, 16, Enum.Font.Code, Vector2.new(9e9, 9e9)).X, 0, 16)
        bindinput.TextColor3 = library.flags["Menu Accent Color"]
    end
end)

library:AddConnection(inputService.InputBegan, function(input)
    if inputService:GetFocusedTextBox() then
        return
    end
    if binding then
        local key = (table.find(whitelistedMouseinputs, input.UserInputType) and not option.nomouse) and input.UserInputType
        option:SetKey(key or (not table.find(blacklistedKeys, input.KeyCode)) and input.KeyCode)
    else
        if (input.KeyCode.Name == option.key or input.UserInputType.Name == option.key) and not binding then
            if option.mode == "toggle" then
                library.flags[option.flag] = not library.flags[option.flag]
                option.callback(library.flags[option.flag], 0)
            else
                library.flags[option.flag] = true
                if Loop then
                    Loop:Disconnect()
                    option.callback(true, 0)
                end
                Loop = library:AddConnection(runService.RenderStepped, function(step)
                    if not inputService:GetFocusedTextBox() then
                        option.callback(nil, step)
                    end
                end)
            end
        end
    end
end)
library:AddConnection(inputService.InputEnded, function(input)
    if option.key ~= "none" then
        if input.KeyCode.Name == option.key or input.UserInputType.Name == option.key then
            if Loop then
                Loop:Disconnect()
                library.flags[option.flag] = false
                option.callback(true, 0)
            end
        end
    end
end)

function option:SetKey(key)
    binding = false
    bindinput.TextColor3 = Color3.fromRGB(160, 160, 160)
    if Loop then
        Loop:Disconnect()
        library.flags[option.flag] = false
        option.callback(true, 0)
    end
    self.key = (key and key.Name) or key or self.key
    if self.key == "Backspace" then
        self.key = "none"
        bindinput.Text = "[NONE]"
    else
        local a = self.key
        if self.key:match"Mouse" then
            a = self.key:gsub("Button", ""):gsub("Mouse", "M")
        elseif self.key:match"Shift" or self.key:match"Alt" or self.key:match"Control" then
            a = self.key:gsub("Left", "L"):gsub("Right", "R")
        end
        bindinput.Text = "[" .. a:gsub("Control", "CTRL"):upper() .. "]"
    end
    bindinput.Size = UDim2.new(0, -textService:GetTextSize(bindinput.Text, 16, Enum.Font.Code, Vector2.new(9e9, 9e9)).X, 0, 16)
end
option:SetKey()
end

local function createSlider(option, parent)
option.hasInit = true
if option.sub then
    option.main = option:getMain()
    option.main.Size = UDim2.new(1, 0, 0, 42)
else
    option.main = library:Create("Frame", {
        LayoutOrder = option.position,
        Size = UDim2.new(1, 0, 0, option.textpos and 24 or 40),
        BackgroundTransparency = 1,
        Parent = parent
    })
end
option.slider = library:Create("Frame", {
    Position = UDim2.new(0, 6, 0, (option.sub and 22 or option.textpos and 4 or 20)),
    Size = UDim2.new(1, -12, 0, 16),
    BackgroundColor3 = Color3.fromRGB(50, 50, 50),
    BorderColor3 = Color3.new(),
    Parent = option.main
})
library:Create("ImageLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2454009026",
    ImageColor3 = Color3.new(),
    ImageTransparency = 0.8,
    Parent = option.slider
})
option.fill = library:Create("Frame", {
    BackgroundColor3 = library.flags["Menu Accent Color"],
    BorderSizePixel = 0,
    Parent = option.slider
})
library:Create("ImageLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2592362371",
    ImageColor3 = Color3.fromRGB(60, 60, 60),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(2, 2, 62, 62),
    Parent = option.slider
})
library:Create("ImageLabel", {
    Size = UDim2.new(1, -2, 1, -2),
    Position = UDim2.new(0, 1, 0, 1),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2592362371",
    ImageColor3 = Color3.new(),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(2, 2, 62, 62),
    Parent = option.slider
})
option.title = library:Create("TextBox", {
    Position = UDim2.new((option.sub or option.textpos) and 0.5 or 0, (option.sub or option.textpos) and 0 or 6, 0, 0),
    Size = UDim2.new(0, 0, 0, (option.sub or option.textpos) and 14 or 18),
    BackgroundTransparency = 1,
    Text = (option.text == "nil" and "" or option.text .. ": ") .. option.value .. option.suffix,
    TextSize = (option.sub or option.textpos) and 14 or 15,
    Font = Enum.Font.Code,
    TextColor3 = Color3.fromRGB(210, 210, 210),
    TextXAlignment = Enum.TextXAlignment[(option.sub or option.textpos) and "Center" or "Left"],
    Parent = (option.sub or option.textpos) and option.slider or option.main
})
table.insert(library.theme, option.fill)
library:Create("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(115, 115, 115)),
        ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)),
    }),
    Rotation = -90,
    Parent = option.fill
})
if option.min >= 0 then
    option.fill.Size = UDim2.new((option.value - option.min) / (option.max - option.min), 0, 1, 0)
else
    option.fill.Position = UDim2.new((0 - option.min) / (option.max - option.min), 0, 0, 0)
    option.fill.Size = UDim2.new(option.value / (option.max - option.min), 0, 1, 0)
end
local manualInput
option.title.Focused:connect(function()
    if not manualInput then
        option.title:ReleaseFocus()
        option.title.Text = (option.text == "nil" and "" or option.text .. ": ") .. option.value .. option.suffix
    end
end)
option.title.FocusLost:connect(function()
    option.slider.BorderColor3 = Color3.new()
    if manualInput then
        if tonumber(option.title.Text) then
            option:SetValue(tonumber(option.title.Text))
        else
            option.title.Text = (option.text == "nil" and "" or option.text .. ": ") .. option.value .. option.suffix
        end
    end
    manualInput = false
end)
local interest = (option.sub or option.textpos) and option.slider or option.main
interest.InputBegan:connect(function(input)
    if input.UserInputType.Name == "MouseButton1" then
        if inputService:IsKeyDown(Enum.KeyCode.LeftControl) or inputService:IsKeyDown(Enum.KeyCode.RightControl) then
            manualInput = true
            option.title:CaptureFocus()
        else
            library.slider = option
            option.slider.BorderColor3 = library.flags["Menu Accent Color"]
            option:SetValue(option.min + ((input.Position.X - option.slider.AbsolutePosition.X) / option.slider.AbsoluteSize.X) * (option.max - option.min))
        end
    end
    if input.UserInputType.Name == "MouseMovement" then
        if not library.warning and not library.slider then
            option.slider.BorderColor3 = library.flags["Menu Accent Color"]
        end
        if option.tip then
            library.tooltip.Text = option.tip
            library.tooltip.Size = UDim2.new(0, textService:GetTextSize(option.tip, 15, Enum.Font.Code, Vector2.new(9e9, 9e9)).X, 0, 20)
        end
    end
end)
interest.InputChanged:connect(function(input)
    if input.UserInputType.Name == "MouseMovement" then
        if option.tip then
            library.tooltip.Position = UDim2.new(0, input.Position.X + 26, 0, input.Position.Y + 36)
        end
    end
end)
interest.InputEnded:connect(function(input)
    if input.UserInputType.Name == "MouseMovement" then
        library.tooltip.Position = UDim2.new(2)
        if option ~= library.slider then
            option.slider.BorderColor3 = Color3.new()
        end
    end
end)

function option:SetValue(value, nocallback)
    if typeof(value) ~= "number" then
        value = 0
    end
    value = library.round(value, option.float)
    value = math.clamp(value, self.min, self.max)
    if self.min >= 0 then
        option.fill:TweenSize(UDim2.new((value - self.min) / (self.max - self.min), 0, 1, 0), "Out", "Quad", 0.05, true)
    else
        option.fill:TweenPosition(UDim2.new((0 - self.min) / (self.max - self.min), 0, 0, 0), "Out", "Quad", 0.05, true)
        option.fill:TweenSize(UDim2.new(value / (self.max - self.min), 0, 1, 0), "Out", "Quad", 0.1, true)
    end
    library.flags[self.flag] = value
    self.value = value
    option.title.Text = (option.text == "nil" and "" or option.text .. ": ") .. option.value .. option.suffix
    if not nocallback then
        self.callback(value)
    end
end
delay(1, function()
    if library then
        option:SetValue(option.value)
    end
end)
end

local function createList(option, parent)
option.hasInit = true
if option.sub then
    option.main = option:getMain()
    option.main.Size = UDim2.new(1, 0, 0, 48)
else
    option.main = library:Create("Frame", {
        LayoutOrder = option.position,
        Size = UDim2.new(1, 0, 0, option.text == "nil" and 30 or 48),
        BackgroundTransparency = 1,
        Parent = parent
    })
    if option.text ~= "nil" then
        library:Create("TextLabel", {
            Position = UDim2.new(0, 6, 0, 0),
            Size = UDim2.new(1, -12, 0, 18),
            BackgroundTransparency = 1,
            Text = option.text,
            TextSize = 15,
            Font = Enum.Font.Code,
            TextColor3 = Color3.fromRGB(210, 210, 210),
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = option.main
        })
    end
end

local function getMultiText()
    local s = ""
    for _, value in next, option.values do
        s = s .. (option.value[value] and (tostring(value) .. ", ") or "")
    end
    return string.sub(s, 1, #s - 2)
end
option.listvalue = library:Create("TextLabel", {
    Position = UDim2.new(0, 6, 0, (option.text == "nil" and not option.sub) and 4 or 22),
    Size = UDim2.new(1, -12, 0, 22),
    BackgroundColor3 = Color3.fromRGB(50, 50, 50),
    BorderColor3 = Color3.new(),
    Text = " " .. (typeof(option.value) == "string" and option.value or getMultiText()),
    TextSize = 15,
    Font = Enum.Font.Code,
    TextColor3 = Color3.new(1, 1, 1),
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd,
    Parent = option.main
})
library:Create("ImageLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2454009026",
    ImageColor3 = Color3.new(),
    ImageTransparency = 0.8,
    Parent = option.listvalue
})
library:Create("ImageLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2592362371",
    ImageColor3 = Color3.fromRGB(60, 60, 60),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(2, 2, 62, 62),
    Parent = option.listvalue
})
library:Create("ImageLabel", {
    Size = UDim2.new(1, -2, 1, -2),
    Position = UDim2.new(0, 1, 0, 1),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2592362371",
    ImageColor3 = Color3.new(),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(2, 2, 62, 62),
    Parent = option.listvalue
})
option.arrow = library:Create("ImageLabel", {
    Position = UDim2.new(1, -16, 0, 7),
    Size = UDim2.new(0, 8, 0, 8),
    Rotation = 90,
    BackgroundTransparency = 1,
    Image = "rbxassetid://4918373417",
    ImageColor3 = Color3.new(1, 1, 1),
    ScaleType = Enum.ScaleType.Fit,
    ImageTransparency = 0.4,
    Parent = option.listvalue
})
option.holder = library:Create("TextButton", {
    ZIndex = 4,
    BackgroundColor3 = Color3.fromRGB(40, 40, 40),
    BorderColor3 = Color3.new(),
    Text = "",
    AutoButtonColor = false,
    Visible = false,
    Parent = library.base
})
option.content = library:Create("ScrollingFrame", {
    ZIndex = 4,
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarImageColor3 = Color3.new(),
    ScrollBarThickness = 3,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    VerticalScrollBarInset = Enum.ScrollBarInset.Always,
    TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
    BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
    Parent = option.holder
})
library:Create("ImageLabel", {
    ZIndex = 4,
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2592362371",
    ImageColor3 = Color3.fromRGB(60, 60, 60),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(2, 2, 62, 62),
    Parent = option.holder
})
library:Create("ImageLabel", {
    ZIndex = 4,
    Size = UDim2.new(1, -2, 1, -2),
    Position = UDim2.new(0, 1, 0, 1),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2592362371",
    ImageColor3 = Color3.new(),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(2, 2, 62, 62),
    Parent = option.holder
})
local layout = library:Create("UIListLayout", {
    Padding = UDim.new(0, 2),
    Parent = option.content
})
library:Create("UIPadding", {
    PaddingTop = UDim.new(0, 4),
    PaddingLeft = UDim.new(0, 4),
    Parent = option.content
})
local valueCount = 0
layout.Changed:connect(function()
    option.holder.Size = UDim2.new(0, option.listvalue.AbsoluteSize.X, 0, 8 + (valueCount > option.max and (-2 + (option.max * 22)) or layout.AbsoluteContentSize.Y))
    option.content.CanvasSize = UDim2.new(0, 0, 0, 8 + layout.AbsoluteContentSize.Y)
end)
local interest = option.sub and option.listvalue or option.main
option.listvalue.InputBegan:connect(function(input)
    if input.UserInputType.Name == "MouseButton1" then
        if library.popup == option then
            library.popup:Close()
            return
        end
        if library.popup then
            library.popup:Close()
        end
        option.arrow.Rotation = -90
        option.open = true
        option.holder.Visible = true
        local pos = option.main.AbsolutePosition
        option.holder.Position = UDim2.new(0, pos.X + 6, 0, pos.Y + ((option.text == "nil" and not option.sub) and 66 or 84))
        library.popup = option
        option.listvalue.BorderColor3 = library.flags["Menu Accent Color"]
    end
    if input.UserInputType.Name == "MouseMovement" then
        if not library.warning and not library.slider then
            option.listvalue.BorderColor3 = library.flags["Menu Accent Color"]
        end
    end
end)
option.listvalue.InputEnded:connect(function(input)
    if input.UserInputType.Name == "MouseMovement" then
        if not option.open then
            option.listvalue.BorderColor3 = Color3.new()
        end
    end
end)
interest.InputBegan:connect(function(input)
    if input.UserInputType.Name == "MouseMovement" then
        if option.tip then
            library.tooltip.Text = option.tip
            library.tooltip.Size = UDim2.new(0, textService:GetTextSize(option.tip, 15, Enum.Font.Code, Vector2.new(9e9, 9e9)).X, 0, 20)
        end
    end
end)
interest.InputChanged:connect(function(input)
    if input.UserInputType.Name == "MouseMovement" then
        if option.tip then
            library.tooltip.Position = UDim2.new(0, input.Position.X + 26, 0, input.Position.Y + 36)
        end
    end
end)
interest.InputEnded:connect(function(input)
    if input.UserInputType.Name == "MouseMovement" then
        library.tooltip.Position = UDim2.new(2)
    end
end)

local selected
function option:AddValue(value, state)
    if self.labels[value] then
        return
    end
    valueCount = valueCount + 1
    if self.multiselect then
        self.values[value] = state
    else
        if not table.find(self.values, value) then
            table.insert(self.values, value)
        end
    end
    local label = library:Create("TextLabel", {
        ZIndex = 4,
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Text = value,
        TextSize = 15,
        Font = Enum.Font.Code,
        TextTransparency = self.multiselect and (self.value[value] and 1 or 0) or self.value == value and 1 or 0,
        TextColor3 = Color3.fromRGB(210, 210, 210),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = option.content
    })
    self.labels[value] = label
    local labelOverlay = library:Create("TextLabel", {
        ZIndex = 4,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 0.8,
        Text = " " .. value,
        TextSize = 15,
        Font = Enum.Font.Code,
        TextColor3 = library.flags["Menu Accent Color"],
        TextXAlignment = Enum.TextXAlignment.Left,
        Visible = self.multiselect and self.value[value] or self.value == value,
        Parent = label
    })
    selected = selected or self.value == value and labelOverlay
    table.insert(library.theme, labelOverlay)
    label.InputBegan:connect(function(input)
        if input.UserInputType.Name == "MouseButton1" then
            if self.multiselect then
                self.value[value] = not self.value[value]
                self:SetValue(self.value)
            else
                self:SetValue(value)
                self:Close()
            end
        end
    end)
end
for i, value in next, option.values do
    option:AddValue(tostring(typeof(i) == "number" and value or i))
end

function option:RemoveValue(value)
    local label = self.labels[value]
    if label then
        label:Destroy()
        self.labels[value] = nil
        valueCount = valueCount - 1
        if self.multiselect then
            self.values[value] = nil
            self:SetValue(self.value)
        else
            table.remove(self.values, table.find(self.values, value))
            if self.value == value then
                selected = nil
                self:SetValue(self.values[1] or "")
            end
        end
    end
end

function option:SetValue(value, nocallback)
    if self.multiselect and typeof(value) ~= "table" then
        value = {}
        for i, v in next, self.values do
            value[v] = false
        end
    end
    self.value = typeof(value) == "table" and value or tostring(table.find(self.values, value) and value or self.values[1])
    library.flags[self.flag] = self.value
    option.listvalue.Text = " " .. (self.multiselect and getMultiText() or self.value)
    if self.multiselect then
        for name, label in next, self.labels do
            label.TextTransparency = self.value[name] and 1 or 0
            if label:FindFirstChild"TextLabel" then
                label.TextLabel.Visible = self.value[name]
            end
        end
    else
        if selected then
            selected.TextTransparency = 0
            if selected:FindFirstChild"TextLabel" then
                selected.TextLabel.Visible = false
            end
        end
        if self.labels[self.value] then
            selected = self.labels[self.value]
            selected.TextTransparency = 1
            if selected:FindFirstChild"TextLabel" then
                selected.TextLabel.Visible = true
            end
        end
    end
    if not nocallback then
        self.callback(self.value)
    end
end
delay(1, function()
    if library then
        option:SetValue(option.value)
    end
end)

function option:Close()
    library.popup = nil
    option.arrow.Rotation = 90
    self.open = false
    option.holder.Visible = false
    option.listvalue.BorderColor3 = Color3.new()
end
return option
end

local function createBox(option, parent)
option.hasInit = true
option.main = library:Create("Frame", {
    LayoutOrder = option.position,
    Size = UDim2.new(1, 0, 0, option.text == "nil" and 28 or 44),
    BackgroundTransparency = 1,
    Parent = parent
})
if option.text ~= "nil" then
    option.title = library:Create("TextLabel", {
        Position = UDim2.new(0, 6, 0, 0),
        Size = UDim2.new(1, -12, 0, 18),
        BackgroundTransparency = 1,
        Text = option.text,
        TextSize = 15,
        Font = Enum.Font.Code,
        TextColor3 = Color3.fromRGB(210, 210, 210),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = option.main
    })
end
option.holder = library:Create("Frame", {
    Position = UDim2.new(0, 6, 0, option.text == "nil" and 4 or 20),
    Size = UDim2.new(1, -12, 0, 20),
    BackgroundColor3 = Color3.fromRGB(50, 50, 50),
    BorderColor3 = Color3.new(),
    Parent = option.main
})
library:Create("ImageLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2454009026",
    ImageColor3 = Color3.new(),
    ImageTransparency = 0.8,
    Parent = option.holder
})
library:Create("ImageLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2592362371",
    ImageColor3 = Color3.fromRGB(60, 60, 60),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(2, 2, 62, 62),
    Parent = option.holder
})
library:Create("ImageLabel", {
    Size = UDim2.new(1, -2, 1, -2),
    Position = UDim2.new(0, 1, 0, 1),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2592362371",
    ImageColor3 = Color3.new(),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(2, 2, 62, 62),
    Parent = option.holder
})
local inputvalue = library:Create("TextBox", {
    Position = UDim2.new(0, 4, 0, 0),
    Size = UDim2.new(1, -4, 1, 0),
    BackgroundTransparency = 1,
    Text = "  " .. option.value,
    TextSize = 15,
    Font = Enum.Font.Code,
    TextColor3 = Color3.new(1, 1, 1),
    TextXAlignment = Enum.TextXAlignment.Left,
    TextWrapped = true,
    ClearTextOnFocus = false,
    Parent = option.holder
})
inputvalue.FocusLost:connect(function(enter)
    option.holder.BorderColor3 = Color3.new()
    option:SetValue(inputvalue.Text, enter)
end)
inputvalue.Focused:connect(function()
    option.holder.BorderColor3 = library.flags["Menu Accent Color"]
end)
inputvalue.InputBegan:connect(function(input)
    if input.UserInputType.Name == "MouseButton1" then
        inputvalue.Text = ""
    end
    if input.UserInputType.Name == "MouseMovement" then
        if not library.warning and not library.slider then
            option.holder.BorderColor3 = library.flags["Menu Accent Color"]
        end
        if option.tip then
            library.tooltip.Text = option.tip
            library.tooltip.Size = UDim2.new(0, textService:GetTextSize(option.tip, 15, Enum.Font.Code, Vector2.new(9e9, 9e9)).X, 0, 20)
        end
    end
end)
inputvalue.InputChanged:connect(function(input)
    if input.UserInputType.Name == "MouseMovement" then
        if option.tip then
            library.tooltip.Position = UDim2.new(0, input.Position.X + 26, 0, input.Position.Y + 36)
        end
    end
end)
inputvalue.InputEnded:connect(function(input)
    if input.UserInputType.Name == "MouseMovement" then
        if not inputvalue:IsFocused() then
            option.holder.BorderColor3 = Color3.new()
        end
        library.tooltip.Position = UDim2.new(2)
    end
end)

function option:SetValue(value, enter)
    if tostring(value) == "" then
        inputvalue.Text = self.value
    else
        library.flags[self.flag] = tostring(value)
        self.value = tostring(value)
        inputvalue.Text = self.value
        self.callback(value, enter)
    end
end
delay(1, function()
    if library then
        option:SetValue(option.value)
    end
end)
end

local function createColorPickerWindow(option)
option.mainHolder = library:Create("TextButton", {
    ZIndex = 4,
    Size = UDim2.new(0, option.trans and 200 or 184, 0, 200),
    BackgroundColor3 = Color3.fromRGB(40, 40, 40),
    BorderColor3 = Color3.new(),
    AutoButtonColor = false,
    Visible = false,
    Parent = library.base
})
library:Create("ImageLabel", {
    ZIndex = 4,
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2592362371",
    ImageColor3 = Color3.fromRGB(60, 60, 60),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(2, 2, 62, 62),
    Parent = option.mainHolder
})
library:Create("ImageLabel", {
    ZIndex = 4,
    Size = UDim2.new(1, -2, 1, -2),
    Position = UDim2.new(0, 1, 0, 1),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2592362371",
    ImageColor3 = Color3.new(),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(2, 2, 62, 62),
    Parent = option.mainHolder
})
local hue, sat, val = Color3.toHSV(option.color)
hue, sat, val = hue == 0 and 1 or hue, sat + 0.005, val - 0.005
local editinghue
local editingsatval
local editingtrans
local transMain
if option.trans then
    transMain = library:Create("ImageLabel", {
        ZIndex = 5,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Image = "rbxassetid://2454009026",
        ImageColor3 = Color3.fromHSV(hue, 1, 1),
        Rotation = 180,
        Parent = library:Create("ImageLabel", {
            ZIndex = 4,
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, -6, 0, 6),
            Size = UDim2.new(0, 10, 1, -12),
            BorderColor3 = Color3.new(),
            Image = "rbxassetid://4632082392",
            ScaleType = Enum.ScaleType.Tile,
            TileSize = UDim2.new(0, 5, 0, 5),
            Parent = option.mainHolder
        })
    })
    option.transSlider = library:Create("Frame", {
        ZIndex = 5,
        Position = UDim2.new(0, 0, option.trans, 0),
        Size = UDim2.new(1, 0, 0, 2),
        BackgroundColor3 = Color3.fromRGB(38, 41, 65),
        BorderColor3 = Color3.fromRGB(255, 255, 255),
        Parent = transMain
    })
    transMain.InputBegan:connect(function(Input)
        if Input.UserInputType.Name == "MouseButton1" then
            editingtrans = true
            option:SetTrans(1 - ((Input.Position.Y - transMain.AbsolutePosition.Y) / transMain.AbsoluteSize.Y))
        end
    end)
    transMain.InputEnded:connect(function(Input)
        if Input.UserInputType.Name == "MouseButton1" then
            editingtrans = false
        end
    end)
end

local hueMain = library:Create("Frame", {
    ZIndex = 4,
    AnchorPoint = Vector2.new(0, 1),
    Position = UDim2.new(0, 6, 1, -6),
    Size = UDim2.new(1, option.trans and -28 or -12, 0, 10),
    BackgroundColor3 = Color3.new(1, 1, 1),
    BorderColor3 = Color3.new(),
    Parent = option.mainHolder
})

local Gradient = library:Create("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
    }),
    Parent = hueMain
})

local hueSlider = library:Create("Frame", {
    ZIndex = 4,
    Position = UDim2.new(1 - hue, 0, 0, 0),
    Size = UDim2.new(0, 2, 1, 0),
    BackgroundColor3 = Color3.fromRGB(38, 41, 65),
    BorderColor3 = Color3.fromRGB(255, 255, 255),
    Parent = hueMain
})
hueMain.InputBegan:connect(function(Input)
    if Input.UserInputType.Name == "MouseButton1" then
        editinghue = true
        X = (hueMain.AbsolutePosition.X + hueMain.AbsoluteSize.X) - hueMain.AbsolutePosition.X
        X = math.clamp((Input.Position.X - hueMain.AbsolutePosition.X) / X, 0, 0.995)
        option:SetColor(Color3.fromHSV(1 - X, sat, val))
    end
end)
hueMain.InputEnded:connect(function(Input)
    if Input.UserInputType.Name == "MouseButton1" then
        editinghue = false
    end
end)

local satval = library:Create("ImageLabel", {
    ZIndex = 4,
    Position = UDim2.new(0, 6, 0, 6),
    Size = UDim2.new(1, option.trans and -28 or -12, 1, -28),
    BackgroundColor3 = Color3.fromHSV(hue, 1, 1),
    BorderColor3 = Color3.new(),
    Image = "rbxassetid://4155801252",
    ClipsDescendants = true,
    Parent = option.mainHolder
})

local satvalSlider = library:Create("Frame", {
    ZIndex = 4,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(sat, 0, 1 - val, 0),
    Size = UDim2.new(0, 4, 0, 4),
    Rotation = 45,
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    Parent = satval
})
satval.InputBegan:connect(function(Input)
    if Input.UserInputType.Name == "MouseButton1" then
        editingsatval = true
        X = (satval.AbsolutePosition.X + satval.AbsoluteSize.X) - satval.AbsolutePosition.X
        Y = (satval.AbsolutePosition.Y + satval.AbsoluteSize.Y) - satval.AbsolutePosition.Y
        X = math.clamp((Input.Position.X - satval.AbsolutePosition.X) / X, 0.005, 1)
        Y = math.clamp((Input.Position.Y - satval.AbsolutePosition.Y) / Y, 0, 0.995)
        option:SetColor(Color3.fromHSV(hue, X, 1 - Y))
    end
end)
library:AddConnection(inputService.InputChanged, function(Input)
    if Input.UserInputType.Name == "MouseMovement" then
        if editingsatval then
            X = (satval.AbsolutePosition.X + satval.AbsoluteSize.X) - satval.AbsolutePosition.X
            Y = (satval.AbsolutePosition.Y + satval.AbsoluteSize.Y) - satval.AbsolutePosition.Y
            X = math.clamp((Input.Position.X - satval.AbsolutePosition.X) / X, 0.005, 1)
            Y = math.clamp((Input.Position.Y - satval.AbsolutePosition.Y) / Y, 0, 0.995)
            option:SetColor(Color3.fromHSV(hue, X, 1 - Y))
        elseif editinghue then
            X = (hueMain.AbsolutePosition.X + hueMain.AbsoluteSize.X) - hueMain.AbsolutePosition.X
            X = math.clamp((Input.Position.X - hueMain.AbsolutePosition.X) / X, 0, 0.995)
            option:SetColor(Color3.fromHSV(1 - X, sat, val))
        elseif editingtrans then
            option:SetTrans(1 - ((Input.Position.Y - transMain.AbsolutePosition.Y) / transMain.AbsoluteSize.Y))
        end
    end
end)
satval.InputEnded:connect(function(Input)
    if Input.UserInputType.Name == "MouseButton1" then
        editingsatval = false
    end
end)
function option:updateVisuals(Color)
    hue, sat, val = Color3.toHSV(Color)
    hue = hue == 0 and 1 or hue
    satval.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
    if option.trans then
        transMain.ImageColor3 = Color3.fromHSV(hue, 1, 1)
    end
    hueSlider.Position = UDim2.new(1 - hue, 0, 0, 0)
    satvalSlider.Position = UDim2.new(sat, 0, 1 - val, 0)
end
return option
end

local function createColor(option, parent)
option.hasInit = true
if option.sub then
    option.main = option:getMain()
else
    option.main = library:Create("Frame", {
        LayoutOrder = option.position,
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Parent = parent
    })
    option.title = library:Create("TextLabel", {
        Position = UDim2.new(0, 6, 0, 0),
        Size = UDim2.new(1, -12, 1, 0),
        BackgroundTransparency = 1,
        Text = option.text,
        TextSize = 15,
        Font = Enum.Font.Code,
        TextColor3 = Color3.fromRGB(210, 210, 210),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = option.main
    })
end
option.visualize = library:Create(option.sub and "TextButton" or "Frame", {
    Position = UDim2.new(1, -(option.subpos or 0) - 24, 0, 4),
    Size = UDim2.new(0, 18, 0, 12),
    SizeConstraint = Enum.SizeConstraint.RelativeYY,
    BackgroundColor3 = option.color,
    BorderColor3 = Color3.new(),
    Parent = option.main
})
library:Create("ImageLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2454009026",
    ImageColor3 = Color3.new(),
    ImageTransparency = 0.6,
    Parent = option.visualize
})
library:Create("ImageLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2592362371",
    ImageColor3 = Color3.fromRGB(60, 60, 60),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(2, 2, 62, 62),
    Parent = option.visualize
})
library:Create("ImageLabel", {
    Size = UDim2.new(1, -2, 1, -2),
    Position = UDim2.new(0, 1, 0, 1),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2592362371",
    ImageColor3 = Color3.new(),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(2, 2, 62, 62),
    Parent = option.visualize
})
local interest = option.sub and option.visualize or option.main
if option.sub then
    option.visualize.Text = ""
    option.visualize.AutoButtonColor = false
end
interest.InputBegan:connect(function(input)
    if input.UserInputType.Name == "MouseButton1" then
        if not option.mainHolder then
            createColorPickerWindow(option)
        end
        if library.popup == option then
            library.popup:Close()
            return
        end
        if library.popup then
            library.popup:Close()
        end
        option.open = true
        local pos = option.main.AbsolutePosition
        option.mainHolder.Position = UDim2.new(0, pos.X + 36 + (option.trans and -16 or 0), 0, pos.Y + 56)
        option.mainHolder.Visible = true
        library.popup = option
        option.visualize.BorderColor3 = library.flags["Menu Accent Color"]
    end
    if input.UserInputType.Name == "MouseMovement" then
        if not library.warning and not library.slider then
            option.visualize.BorderColor3 = library.flags["Menu Accent Color"]
        end
        if option.tip then
            library.tooltip.Text = option.tip
            library.tooltip.Size = UDim2.new(0, textService:GetTextSize(option.tip, 15, Enum.Font.Code, Vector2.new(9e9, 9e9)).X, 0, 20)
        end
    end
end)
interest.InputChanged:connect(function(input)
    if input.UserInputType.Name == "MouseMovement" then
        if option.tip then
            library.tooltip.Position = UDim2.new(0, input.Position.X + 26, 0, input.Position.Y + 36)
        end
    end
end)
interest.InputEnded:connect(function(input)
    if input.UserInputType.Name == "MouseMovement" then
        if not option.open then
            option.visualize.BorderColor3 = Color3.new()
        end
        library.tooltip.Position = UDim2.new(2)
    end
end)
function option:SetColor(newColor, nocallback)
    if typeof(newColor) == "table" then
        newColor = Color3.new(newColor[1], newColor[2], newColor[3])
    end
    newColor = newColor or Color3.new(1, 1, 1)
    if self.mainHolder then
        self:updateVisuals(newColor)
    end
    option.visualize.BackgroundColor3 = newColor
    library.flags[self.flag] = newColor
    self.color = newColor
    if not nocallback then
        self.callback(newColor)
    end
end
if option.trans then
    function option:SetTrans(value, manual)
        value = math.clamp(tonumber(value) or 0, 0, 1)
        if self.transSlider then
            self.transSlider.Position = UDim2.new(0, 0, value, 0)
        end
        self.trans = value
        library.flags[self.flag .. " Transparency"] = 1 - value
        self.calltrans(value)
    end
    option:SetTrans(option.trans)
end
delay(1, function()
    if library then
        option:SetColor(option.color)
    end
end)

function option:Close()
    library.popup = nil
    self.open = false
    self.mainHolder.Visible = false
    option.visualize.BorderColor3 = Color3.new()
end
end

function library:AddTab(title, pos)
local tab = {
    canInit = true,
    columns = {},
    title = tostring(title)
}
table.insert(self.tabs, pos or #self.tabs + 1, tab)

function tab:AddColumn()
    local column = {
        sections = {},
        position = #self.columns,
        canInit = true,
        tab = self
    }
    table.insert(self.columns, column)

    function column:AddSection(title)
        local section = {
            title = tostring(title),
            options = {},
            canInit = true,
            column = self
        }
        table.insert(self.sections, section)
    
        function section:AddLabel(text)
            local option = {
                text = text
            }
            option.section = self
            option.type = "label"
            option.position = #self.options
            option.canInit = true
            table.insert(self.options, option)
            if library.hasInit and self.hasInit then
                createLabel(option, self.content)
            else
                option.Init = createLabel
            end
            return option
        end

        function section:AddDivider(text)
            local option = {
                text = text
            }
            option.section = self
            option.type = "divider"
            option.position = #self.options
            option.canInit = true
            table.insert(self.options, option)
            if library.hasInit and self.hasInit then
                createDivider(option, self.content)
            else
                option.Init = createDivider
            end
            return option
        end

        function section:AddToggle(option)
            option = typeof(option) == "table" and option or {}
            option.section = self
            option.text = tostring(option.text)
            option.state = typeof(option.state) == "boolean" and option.state or false
            option.callback = typeof(option.callback) == "function" and option.callback or function()
            end
            option.type = "toggle"
            option.position = #self.options
            option.flag = (library.flagprefix and library.flagprefix .. " " or "") .. (option.flag or option.text)
            option.subcount = 0
            option.canInit = (option.canInit ~= nil and option.canInit) or true
            option.tip = option.tip and tostring(option.tip)
            option.style = option.style == 2
            library.flags[option.flag] = option.state
            table.insert(self.options, option)
            library.options[option.flag] = option

            function option:AddColor(subOption)
                subOption = typeof(subOption) == "table" and subOption or {}
                subOption.sub = true
                subOption.subpos = self.subcount * 24
                function subOption:getMain()
                    return option.main
                end
                self.subcount = self.subcount + 1
                return section:AddColor(subOption)
            end

            function option:AddBind(subOption)
                subOption = typeof(subOption) == "table" and subOption or {}
                subOption.sub = true
                subOption.subpos = self.subcount * 24
                function subOption:getMain()
                    return option.main
                end
                self.subcount = self.subcount + 1
                return section:AddBind(subOption)
            end

            function option:AddList(subOption)
                subOption = typeof(subOption) == "table" and subOption or {}
                subOption.sub = true
                function subOption:getMain()
                    return option.main
                end
                self.subcount = self.subcount + 1
                return section:AddList(subOption)
            end

            function option:AddSlider(subOption)
                subOption = typeof(subOption) == "table" and subOption or {}
                subOption.sub = true
                function subOption:getMain()
                    return option.main
                end
                self.subcount = self.subcount + 1
                return section:AddSlider(subOption)
            end
            if library.hasInit and self.hasInit then
                createToggle(option, self.content)
            else
                option.Init = createToggle
            end
            return option
        end

        function section:AddButton(option)
            option = typeof(option) == "table" and option or {}
            option.section = self
            option.text = tostring(option.text)
            option.callback = typeof(option.callback) == "function" and option.callback or function()
            end
            option.type = "button"
            option.position = #self.options
            option.flag = (library.flagprefix and library.flagprefix .. " " or "") .. (option.flag or option.text)
            option.subcount = 0
            option.canInit = (option.canInit ~= nil and option.canInit) or true
            option.tip = option.tip and tostring(option.tip)
            table.insert(self.options, option)
            library.options[option.flag] = option

            function option:AddBind(subOption)
                subOption = typeof(subOption) == "table" and subOption or {}
                subOption.sub = true
                subOption.subpos = self.subcount * 24
                function subOption:getMain()
                    option.main.Size = UDim2.new(1, 0, 0, 40)
                    return option.main
                end
                self.subcount = self.subcount + 1
                return section:AddBind(subOption)
            end

            function option:AddColor(subOption)
                subOption = typeof(subOption) == "table" and subOption or {}
                subOption.sub = true
                subOption.subpos = self.subcount * 24
                function subOption:getMain()
                    option.main.Size = UDim2.new(1, 0, 0, 40)
                    return option.main
                end
                self.subcount = self.subcount + 1
                return section:AddColor(subOption)
            end
            if library.hasInit and self.hasInit then
                createButton(option, self.content)
            else
                option.Init = createButton
            end
            return option
        end

        function section:AddBind(option)
            option = typeof(option) == "table" and option or {}
            option.section = self
            option.text = tostring(option.text)
            option.key = (option.key and option.key.Name) or option.key or "none"
            option.nomouse = typeof(option.nomouse) == "boolean" and option.nomouse or false
            option.mode = typeof(option.mode) == "string" and (option.mode == "toggle" or option.mode == "hold" and option.mode) or "toggle"
            option.callback = typeof(option.callback) == "function" and option.callback or function()
            end
            option.type = "bind"
            option.position = #self.options
            option.flag = (library.flagprefix and library.flagprefix .. " " or "") .. (option.flag or option.text)
            option.canInit = (option.canInit ~= nil and option.canInit) or true
            option.tip = option.tip and tostring(option.tip)
            table.insert(self.options, option)
            library.options[option.flag] = option
            if library.hasInit and self.hasInit then
                createBind(option, self.content)
            else
                option.Init = createBind
            end
            return option
        end

        function section:AddSlider(option)
            option = typeof(option) == "table" and option or {}
            option.section = self
            option.text = tostring(option.text)
            option.min = typeof(option.min) == "number" and option.min or 0
            option.max = typeof(option.max) == "number" and option.max or 0
            option.value = option.min < 0 and 0 or math.clamp(typeof(option.value) == "number" and option.value or option.min, option.min, option.max)
            option.callback = typeof(option.callback) == "function" and option.callback or function()
            end
            option.float = typeof(option.value) == "number" and option.float or 1
            option.suffix = option.suffix and tostring(option.suffix) or ""
            option.textpos = option.textpos == 2
            option.type = "slider"
            option.position = #self.options
            option.flag = (library.flagprefix and library.flagprefix .. " " or "") .. (option.flag or option.text)
            option.subcount = 0
            option.canInit = (option.canInit ~= nil and option.canInit) or true
            option.tip = option.tip and tostring(option.tip)
            library.flags[option.flag] = option.value
            table.insert(self.options, option)
            library.options[option.flag] = option
            function option:AddColor(subOption)
                subOption = typeof(subOption) == "table" and subOption or {}
                subOption.sub = true
                subOption.subpos = self.subcount * 24
                function subOption:getMain()
                    return option.main
                end
                self.subcount = self.subcount + 1
                return section:AddColor(subOption)
            end

            function option:AddBind(subOption)
                subOption = typeof(subOption) == "table" and subOption or {}
                subOption.sub = true
                subOption.subpos = self.subcount * 24
                function subOption:getMain()
                    return option.main
                end
                self.subcount = self.subcount + 1
                return section:AddBind(subOption)
            end
            if library.hasInit and self.hasInit then
                createSlider(option, self.content)
            else
                option.Init = createSlider
            end
            return option
        end

        function section:AddList(option)
            option = typeof(option) == "table" and option or {}
            option.section = self
            option.text = tostring(option.text)
            option.values = typeof(option.values) == "table" and option.values or {}
            option.callback = typeof(option.callback) == "function" and option.callback or function()
            end
            option.multiselect = typeof(option.multiselect) == "boolean" and option.multiselect or false
            option.value = option.multiselect and (typeof(option.value) == "table" and option.value or {}) or tostring(option.value or option.values[1] or "")
            if option.multiselect then
                for i, v in next, option.values do
                    option.value[v] = false
                end
            end
            option.max = option.max or 4
            option.open = false
            option.type = "list"
            option.position = #self.options
            option.labels = {}
            option.flag = (library.flagprefix and library.flagprefix .. " " or "") .. (option.flag or option.text)
            option.subcount = 0
            option.canInit = (option.canInit ~= nil and option.canInit) or true
            option.tip = option.tip and tostring(option.tip)
            library.flags[option.flag] = option.value
            table.insert(self.options, option)
            library.options[option.flag] = option

            function option:AddValue(value, state)
                if self.multiselect then
                    self.values[value] = state
                else
                    table.insert(self.values, value)
                end
            end

            function option:AddColor(subOption)
                subOption = typeof(subOption) == "table" and subOption or {}
                subOption.sub = true
                subOption.subpos = self.subcount * 24
                function subOption:getMain()
                    return option.main
                end
                self.subcount = self.subcount + 1
                return section:AddColor(subOption)
            end

            function option:AddBind(subOption)
                subOption = typeof(subOption) == "table" and subOption or {}
                subOption.sub = true
                subOption.subpos = self.subcount * 24
                function subOption:getMain()
                    return option.main
                end
                self.subcount = self.subcount + 1
                return section:AddBind(subOption)
            end
            if library.hasInit and self.hasInit then
                createList(option, self.content)
            else
                option.Init = createList
            end
            return option
        end

        function section:AddBox(option)
            option = typeof(option) == "table" and option or {}
            option.section = self
            option.text = tostring(option.text)
            option.value = tostring(option.value or "")
            option.callback = typeof(option.callback) == "function" and option.callback or function()
            end
            option.type = "box"
            option.position = #self.options
            option.flag = (library.flagprefix and library.flagprefix .. " " or "") .. (option.flag or option.text)
            option.canInit = (option.canInit ~= nil and option.canInit) or true
            option.tip = option.tip and tostring(option.tip)
            library.flags[option.flag] = option.value
            table.insert(self.options, option)
            library.options[option.flag] = option
            if library.hasInit and self.hasInit then
                createBox(option, self.content)
            else
                option.Init = createBox
            end
            return option
        end

        function section:AddColor(option)
            option = typeof(option) == "table" and option or {}
            option.section = self
            option.text = tostring(option.text)
            option.color = typeof(option.color) == "table" and Color3.new(option.color[1], option.color[2], option.color[3]) or option.color or Color3.new(1, 1, 1)
            option.callback = typeof(option.callback) == "function" and option.callback or function()
            end
            option.calltrans = typeof(option.calltrans) == "function" and option.calltrans or (option.calltrans == 1 and option.callback) or function()
            end
            option.open = false
            option.trans = tonumber(option.trans)
            option.subcount = 1
            option.type = "color"
            option.position = #self.options
            option.flag = (library.flagprefix and library.flagprefix .. " " or "") .. (option.flag or option.text)
            option.canInit = (option.canInit ~= nil and option.canInit) or true
            option.tip = option.tip and tostring(option.tip)
            library.flags[option.flag] = option.color
            table.insert(self.options, option)
            library.options[option.flag] = option
            function option:AddColor(subOption)
                subOption = typeof(subOption) == "table" and subOption or {}
                subOption.sub = true
                subOption.subpos = self.subcount * 24
                function subOption:getMain()
                    return option.main
                end
                self.subcount = self.subcount + 1
                return section:AddColor(subOption)
            end
            if option.trans then
                library.flags[option.flag .. " Transparency"] = option.trans
            end
            if library.hasInit and self.hasInit then
                createColor(option, self.content)
            else
                option.Init = createColor
            end
            return option
        end

        function section:SetTitle(newTitle)
            self.title = tostring(newTitle)
            if self.titleText then
                self.titleText.Text = tostring(newTitle)
                self.titleText.Size = UDim2.new(0, textService:GetTextSize(self.title, 15, Enum.Font.Code, Vector2.new(9e9, 9e9)).X + 10, 0, 3)
            end
        end

        function section:Init()
            if self.hasInit then
                return
            end
            self.hasInit = true
            self.main = library:Create("Frame", {
                BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                BorderColor3 = Color3.new(),
                Parent = column.main
            })
            self.content = library:Create("Frame", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                BorderColor3 = Color3.fromRGB(60, 60, 60),
                BorderMode = Enum.BorderMode.Inset,
                Parent = self.main
            })
            library:Create("ImageLabel", {
                Size = UDim2.new(1, -2, 1, -2),
                Position = UDim2.new(0, 1, 0, 1),
                BackgroundTransparency = 1,
                Image = "rbxassetid://2592362371",
                ImageColor3 = Color3.new(),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(2, 2, 62, 62),
                Parent = self.main
            })
            table.insert(library.theme, library:Create("Frame", {
                Size = UDim2.new(1, 0, 0, 1),
                BackgroundColor3 = library.flags["Menu Accent Color"],
                BorderSizePixel = 0,
                BorderMode = Enum.BorderMode.Inset,
                Parent = self.main
            }))
            local layout = library:Create("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 2),
                Parent = self.content
            })
            library:Create("UIPadding", {
                PaddingTop = UDim.new(0, 12),
                Parent = self.content
            })
            self.titleText = library:Create("TextLabel", {
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new(0, 12, 0, 0),
                Size = UDim2.new(0, textService:GetTextSize(self.title, 15, Enum.Font.Code, Vector2.new(9e9, 9e9)).X + 10, 0, 3),
                BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                BorderSizePixel = 0,
                Text = self.title,
                TextSize = 15,
                Font = Enum.Font.Code,
                TextColor3 = Color3.new(1, 1, 1),
                Parent = self.main
            })
            layout.Changed:connect(function()
                self.main.Size = UDim2.new(1, 0, 0, layout.AbsoluteContentSize.Y + 16)
            end)
            for _, option in next, self.options do
                if option.canInit then
                    option.Init(option, self.content)
                end
            end
        end
        if library.hasInit and self.hasInit then
            section:Init()
        end
        return section
    end

    function column:Init()
        if self.hasInit then
            return
        end
        self.hasInit = true
        self.main = library:Create("ScrollingFrame", {
            ZIndex = 2,
            Position = UDim2.new(0, 6 + (self.position * 239), 0, 2),
            Size = UDim2.new(0, 233, 1, -4),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarImageColor3 = Color3.fromRGB(),
            ScrollBarThickness = 4,
            VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            Visible = false,
            Parent = library.columnHolder
        })
        local layout = library:Create("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 12),
            Parent = self.main
        })
        library:Create("UIPadding", {
            PaddingTop = UDim.new(0, 8),
            PaddingLeft = UDim.new(0, 2),
            PaddingRight = UDim.new(0, 2),
            Parent = self.main
        })
        layout.Changed:connect(function()
            self.main.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 14)
        end)
        for _, section in next, self.sections do
            if section.canInit and #section.options > 0 then
                section:Init()
            end
        end
    end
    if library.hasInit and self.hasInit then
        column:Init()
    end
    return column
end

function tab:Init()
    if self.hasInit then
        return
    end
    self.hasInit = true
    local size = textService:GetTextSize(self.title, 18, Enum.Font.Code, Vector2.new(9e9, 9e9)).X + 10
    self.button = library:Create("TextLabel", {
        Position = UDim2.new(0, library.tabSize, 0, 22),
        Size = UDim2.new(0, size, 0, 30),
        BackgroundTransparency = 1,
        Text = self.title,
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 15,
        Font = Enum.Font.Code,
        TextWrapped = true,
        ClipsDescendants = true,
        Parent = library.main
    })
    library.tabSize = library.tabSize + size
    self.button.InputBegan:connect(function(input)
        if input.UserInputType.Name == "MouseButton1" then
            library:selectTab(self)
        end
    end)
    for _, column in next, self.columns do
        if column.canInit then
            column:Init()
        end
    end
end
if self.hasInit then
    tab:Init()
end
return tab
end

function library:AddWarning(warning)
warning = typeof(warning) == "table" and warning or {}
warning.text = tostring(warning.text)
warning.type = warning.type == "confirm" and "confirm" or ""
local answer
function warning:Show()
    library.warning = warning
    if warning.main and warning.type == "" then
        return
    end
    if library.popup then
        library.popup:Close()
    end
    if not warning.main then
        warning.main = library:Create("TextButton", {
            ZIndex = 2,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 0.6,
            BackgroundColor3 = Color3.new(),
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
            Parent = library.main
        })
        warning.message = library:Create("TextLabel", {
            ZIndex = 2,
            Position = UDim2.new(0, 20, 0.5, -60),
            Size = UDim2.new(1, -40, 0, 40),
            BackgroundTransparency = 1,
            TextSize = 16,
            Font = Enum.Font.Code,
            TextColor3 = Color3.new(1, 1, 1),
            TextWrapped = true,
            RichText = true,
            Parent = warning.main
        })
        if warning.type == "confirm" then
            local button = library:Create("TextLabel", {
                ZIndex = 2,
                Position = UDim2.new(0.5, -105, 0.5, -10),
                Size = UDim2.new(0, 100, 0, 20),
                BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                BorderColor3 = Color3.new(),
                Text = "Yes",
                TextSize = 16,
                Font = Enum.Font.Code,
                TextColor3 = Color3.new(1, 1, 1),
                Parent = warning.main
            })
            library:Create("ImageLabel", {
                ZIndex = 2,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Image = "rbxassetid://2454009026",
                ImageColor3 = Color3.new(),
                ImageTransparency = 0.8,
                Parent = button
            })
            library:Create("ImageLabel", {
                ZIndex = 2,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Image = "rbxassetid://2592362371",
                ImageColor3 = Color3.fromRGB(60, 60, 60),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(2, 2, 62, 62),
                Parent = button
            })
            local button1 = library:Create("TextLabel", {
                ZIndex = 2,
                Position = UDim2.new(0.5, 5, 0.5, -10),
                Size = UDim2.new(0, 100, 0, 20),
                BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                BorderColor3 = Color3.new(),
                Text = "No",
                TextSize = 16,
                Font = Enum.Font.Code,
                TextColor3 = Color3.new(1, 1, 1),
                Parent = warning.main
            })
            library:Create("ImageLabel", {
                ZIndex = 2,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Image = "rbxassetid://2454009026",
                ImageColor3 = Color3.new(),
                ImageTransparency = 0.8,
                Parent = button1
            })
            library:Create("ImageLabel", {
                ZIndex = 2,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Image = "rbxassetid://2592362371",
                ImageColor3 = Color3.fromRGB(60, 60, 60),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(2, 2, 62, 62),
                Parent = button1
            })
            button.InputBegan:connect(function(input)
                if input.UserInputType.Name == "MouseButton1" then
                    answer = true
                end
            end)
            button1.InputBegan:connect(function(input)
                if input.UserInputType.Name == "MouseButton1" then
                    answer = false
                end
            end)
        else
            local button = library:Create("TextLabel", {
                ZIndex = 2,
                Position = UDim2.new(0.5, -50, 0.5, -10),
                Size = UDim2.new(0, 100, 0, 20),
                BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                BorderColor3 = Color3.new(),
                Text = "OK",
                TextSize = 16,
                Font = Enum.Font.Code,
                TextColor3 = Color3.new(1, 1, 1),
                Parent = warning.main
            })
            library:Create("ImageLabel", {
                ZIndex = 2,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Image = "rbxassetid://2454009026",
                ImageColor3 = Color3.new(),
                ImageTransparency = 0.8,
                Parent = button
            })
            library:Create("ImageLabel", {
                ZIndex = 2,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Size = UDim2.new(1, -2, 1, -2),
                BackgroundTransparency = 1,
                Image = "rbxassetid://3570695787",
                ImageColor3 = Color3.fromRGB(50, 50, 50),
                Parent = button
            })
            button.InputBegan:connect(function(input)
                if input.UserInputType.Name == "MouseButton1" then
                    answer = true
                end
            end)
        end
    end
    warning.main.Visible = true
    warning.message.Text = warning.text
    repeat
        wait()
    until answer ~= nil
    spawn(warning.Close)
    library.warning = nil
    return answer
end

function warning:Close()
    answer = nil
    if not warning.main then
        return
    end
    warning.main.Visible = false
end
return warning
end

function library:Close()
self.open = not self.open
if self.open then
    inputService.MouseIconEnabled = false
else
    inputService.MouseIconEnabled = self.mousestate
end
if self.main then
    if self.popup then
        self.popup:Close()
    end
    self.main.Visible = self.open
    self.cursor.Visible  = self.open
    self.cursor1.Visible  = self.open
end
end

function library:Init()
if self.hasInit then
    return
end
self.hasInit = true
self.base = library:Create("ScreenGui", {
    IgnoreGuiInset = true
})
if runService:IsStudio() then
    self.base.Parent = script.Parent.Parent
elseif syn then
    syn.protect_gui(self.base)
    self.base.Parent = game:GetService"CoreGui"
end
self.main = self:Create("ImageButton", {
    AutoButtonColor = false,
    Position = UDim2.new(0, 100, 0, 46),
    Size = UDim2.new(0, 90, 0, 90), --500, 600
    BackgroundColor3 = Color3.fromRGB(20, 20, 20),
    BorderColor3 = Color3.new(),
    ScaleType = Enum.ScaleType.Tile,
    Modal = true,
    Visible = false,
    Parent = self.base
})
local top = self:Create("Frame", {
    Size = UDim2.new(1, 0, 0, 50),
    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    BorderColor3 = Color3.new(),
    Parent = self.main
})
self:Create("TextLabel", {
    Position = UDim2.new(0, 6, 0, -1),
    Size = UDim2.new(0, 0, 0, 20),
    BackgroundTransparency = 1,
    Text = tostring(self.title),
    Font = Enum.Font.Code,
    TextSize = 18,
    TextColor3 = Color3.new(1, 1, 1),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = self.main
})
table.insert(library.theme, self:Create("Frame", {
    Size = UDim2.new(1, 0, 0, 1),
    Position = UDim2.new(0, 0, 0, 24),
    BackgroundColor3 = library.flags["Menu Accent Color"],
    BorderSizePixel = 0,
    Parent = self.main
}))
library:Create("ImageLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    ImageColor3 = Color3.new(),
    ImageTransparency = 0.4,
    Parent = top
})
self.tabHighlight = self:Create("Frame", {
    BackgroundColor3 = library.flags["Menu Accent Color"],
    BorderSizePixel = 0,
    Parent = self.main
})
table.insert(library.theme, self.tabHighlight)
self.columnHolder = self:Create("Frame", {
    Position = UDim2.new(0, 5, 0, 55),
    Size = UDim2.new(1, -10, 1, -60),
    BackgroundTransparency = 1,
    Parent = self.main
})
self.cursor = self:Create("Triangle", {
    Color = Color3.fromRGB(180, 180, 180),
    Transparency = 0.6,
})
self.cursor1 = self:Create("Triangle", {
    Color = Color3.fromRGB(240, 240, 240),
    Transparency = 0.6,
})
self.tooltip = self:Create("TextLabel", {
    ZIndex = 2,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    TextSize = 15,
    Font = Enum.Font.Code,
    TextColor3 = Color3.new(1, 1, 1),
    Visible = true,
    Parent = self.base
})
self:Create("Frame", {
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.new(0.5, 0, 0, 0),
    Size = UDim2.new(1, 10, 1, 0),
    Style = Enum.FrameStyle.RobloxRound,
    Parent = self.tooltip
})
self:Create("ImageLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2592362371",
    ImageColor3 = Color3.fromRGB(60, 60, 60),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(2, 2, 62, 62),
    Parent = self.main
})
self:Create("ImageLabel", {
    Size = UDim2.new(1, -2, 1, -2),
    Position = UDim2.new(0, 1, 0, 1),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2592362371",
    ImageColor3 = Color3.new(),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(2, 2, 62, 62),
    Parent = self.main
})
top.InputBegan:connect(function(input)
    if input.UserInputType.Name == "MouseButton1" then
        dragObject = self.main
        dragging = true
        dragStart = input.Position
        startPos = dragObject.Position
        if library.popup then
            library.popup:Close()
        end
    end
end)
top.InputChanged:connect(function(input)
    if dragging and input.UserInputType.Name == "MouseMovement" then
        dragInput = input
    end
end)
top.InputEnded:connect(function(input)
    if input.UserInputType.Name == "MouseButton1" then
        dragging = false
    end
end)
function self:selectTab(tab)
    if self.currentTab == tab then
        return
    end
    if library.popup then
        library.popup:Close()
    end
    if self.currentTab then
        self.currentTab.button.TextColor3 = Color3.fromRGB(255, 255, 255)
        for _, column in next, self.currentTab.columns do
            column.main.Visible = false
        end
    end
    self.main.Size = UDim2.new(0, 16 + ((#tab.columns < 2 and 2 or #tab.columns) * 239), 0, 600)
    self.currentTab = tab
    tab.button.TextColor3 = library.flags["Menu Accent Color"]
    self.tabHighlight:TweenPosition(UDim2.new(0, tab.button.Position.X.Offset, 0, 50), "Out", "Quad", 0.2, true)
    self.tabHighlight:TweenSize(UDim2.new(0, tab.button.AbsoluteSize.X, 0, -1), "Out", "Quad", 0.1, true)
    for _, column in next, tab.columns do
        column.main.Visible = true
    end
end
spawn(function()
    while library do
        wait(1)
        local Configs = self:GetConfigs()
        for _, config in next, Configs do
            if not table.find(self.options["Config List"].values, config) then
                self.options["Config List"]:AddValue(config)
            end
        end
        for i, config in next, self.options["Config List"].values do
            if not table.find(Configs, config) then
                self.options["Config List"]:RemoveValue(config)
            end
        end
    end
end)
for _, tab in next, self.tabs do
    if tab.canInit then
        tab:Init()
        self:selectTab(tab)
    end
end
self:AddConnection(inputService.InputEnded, function(input)
    if input.UserInputType.Name == "MouseButton1" and self.slider then
        self.slider.slider.BorderColor3 = Color3.new()
        self.slider = nil
    end
end)
self:AddConnection(inputService.InputChanged, function(input)
    if self.open then
        if input.UserInputType.Name == "MouseMovement" then
            if self.cursor then
                local mouse = inputService:GetMouseLocation()
                local MousePos = Vector2.new(mouse.X, mouse.Y)
                self.cursor.PointA = MousePos
                self.cursor.PointB = MousePos + Vector2.new(12, 12)
                self.cursor.PointC = MousePos + Vector2.new(12, 12)
                self.cursor1.PointA = MousePos
                self.cursor1.PointB = MousePos + Vector2.new(11, 11)
                self.cursor1.PointC = MousePos + Vector2.new(11, 11)
            end
            if self.slider then
                self.slider:SetValue(self.slider.min + ((input.Position.X - self.slider.slider.AbsolutePosition.X) / self.slider.slider.AbsoluteSize.X) * (self.slider.max - self.slider.min))
            end
        end
        if input == dragInput and dragging and library.draggable then
            local delta = input.Position - dragStart
            local yPos = (startPos.Y.Offset + delta.Y) < -36 and -36 or startPos.Y.Offset + delta.Y
            dragObject:TweenPosition(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, yPos), "Out", "Quint", 0.1, true)
        end
    end
end)

local Meta = getrawmetatable(game)
local Old_index = Meta.__index
local Old_new = Meta.__newindex
setreadonly(Meta, false)
Meta.__index = newcclosure(function(t, i)
    if checkcaller() then
        return Old_index(t, i)
    end
    if library and i == "MouseIconEnabled" then
        return library.mousestate
    end
    return Old_index(t, i)
end)
Meta.__newindex = newcclosure(function(t, i, v)
    if checkcaller() then
        return Old_new(t, i, v)
    end
    if library and i == "MouseIconEnabled" then
        library.mousestate = v
        if library.open then
            return
        end
    end
    return Old_new(t, i, v)
end)
setreadonly(Meta, true)
if not getgenv().silent then
    delay(1, function()
        self:Close()
    end)
end
end
-- Aiming Tab
local MainTab = library:AddTab("Tab");
local one = MainTab:AddColumn(); 
local two = MainTab:AddColumn(); 


local onesection = one:AddSection("Aiming"); 
local twosection = two:AddSection("Movement"); 
local threesectionsection = one:AddSection("Target Aim"); 
local foursectionn = two:AddSection("Bot"); 

onesection:AddToggle({text = "Silent Aim", callback = function(state)
    game:GetService("StarterGui"):SetCore("SendNotification",{     

        Title = "Crimskid",     
        
        Text = "Q to toggle",
        
        Duration = 3
        
        })
end}) 

onesection:AddList({text = "Body Part", max = 2, flag = "BodyPart", values = {"Head", "HRP",}, value = "Head", callback = function(v)
    if v == Head then
        _G.positionforsilent = 0.5
    end 

    if v == HRP then
        _G.positionforsilent = 0.25
    end 
    
    end});

onesection:AddToggle({text = "Draw FOV", callback = function(state)
    _G.Circle.Visible = state
    end}) 

onesection:AddSlider({text = "FOV Size", min = 50, max = 1000, value = 50, callback = function(size)
    FOV_CIRCLE.Radius = _G.FOV
    _G.FOV = size  
end});

onesection:AddColor({text = "Accent Color", callback = function(color)
_G.Circle.Color = color 
end}) 

onesection:AddToggle({text = "Rainbow", callback = function(state)
    if state == true then
        _G.Circle.Color = chromaColor
    end 

    if state == false then 

        _G.Circle.Color = Color3.new(1, 1, 1)
    end 
    end}) 

    onesection:AddToggle({text = "Filled", callback = function(state)
        _G.Circle.Filled = state 
    end}) 

    onesection:AddSlider({text = "Transparency", min = 1, max = 5, value = 5, callback = function(pjklswork)
        _G.Circle.Transparency = pjklswork* 0.20
end});


onesection:AddBind({text = "FOV", key = "", callback = function(state)
        _G.Circle.Visible = state 
end});


-- [Target Aim Section Start] -----------------------------------------------------------------------------------------------------------------------------------------------------

threesectionsection:AddButton({text = "Target Aim", callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/T31qHHup"))()
    game:GetService("StarterGui"):SetCore("SendNotification",{     

        Title = "Crimskid",     
        
        Text = "Sorry I couldnt toggle it but luraph wouldnt let me it broke the target aim.",
        
        Duration = 5
        
        })
end}) 

threesectionsection:AddToggle({text = "Chat Mode", callback = function(state)
    getgenv().ChatMode = state
end}) 

threesectionsection:AddToggle({text = "Notification Mode", callback = function(state)
    getgenv().NotifMode = state
end}) 

threesectionsection:AddToggle({text = "Ping Based Prediction", callback = function(state)
    getgenv().AutoPrediction = state
end}) 

threesectionsection:AddBox({text = "Prediction", value = 0.151, callback = function(awdawdawd)
    getgenv().Prediction = awdawdawd
end}) 

threesectionsection:AddButton({text = "Set Normal Prediction", callback = function()
    getgenv().Prediction = 0.151
end}) 

threesectionsection:AddList({text = "BodyPart", max = 4, flag = "", values = {"Head", "HumanoidRootPart"}, value = "HumanoidRootPart", callback = function(v)
    getgenv().Partz = v
end})

-- [Target Aim Section End] -----------------------------------------------------------------------------------------------------------------------------------------------------




-- [Movement Section Start] -----------------------------------------------------------------------------------------------------------------------------------------------------


twosection:AddBind({text = "Speed", key = "Y", callback = function(state)
    toggle = state 

    if toggle == true then
    repeat
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + game.Players.LocalPlayer.Character.Humanoid.MoveDirection * getfenv().Speed
        game:GetService("RunService").Stepped:wait()
    until toggle == false
    end
end});

twosection:AddSlider({text = "CFrame Speed", min = 0, max = 18, value = 5, callback = function(speed)
getfenv().Speed = speed * 0.40
end});

twosection:AddBind({text = "Spin-Bot", key = "Y", callback = function(state)
    spintoggle = state 
    getgenv().urspeed = 500
    if spintoggle == true then
        repeat
       
           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(urspeed), 0)           
            game:GetService("RunService").Stepped:wait()
        until spintoggle == false
    end
    
end});

twosection:AddSlider({text = "Spin Speed", min = 1, max = 100, value = 100, callback = function(speed)
        getgenv().urspeed = speed *5
end})
        
twosection:AddButton({text = "Fly (X)", callback = function()
            local plr = game.Players.LocalPlayer
            local mouse = plr:GetMouse()
            
            localplayer = plr
            
            if workspace:FindFirstChild("Core") then
            workspace.Core:Destroy()
            end
            
            local Core = Instance.new("Part")
            Core.Name = "Core"
            Core.Size = Vector3.new(0.05, 0.05, 0.05)
            
            spawn(function()
            Core.Parent = workspace
            local Weld = Instance.new("Weld", Core)
            Weld.Part0 = Core
            Weld.Part1 = localplayer.Character.LowerTorso
            Weld.C0 = CFrame.new(0, 0, 0)
            end)
            
            workspace:WaitForChild("Core")
            
            local torso = workspace.Core
            flying = true
            local speed= _G.flyspeedbaka 
            local keys={a=false,d=false,w=false,s=false}
            local e1
            local e2
            local function start()
            local pos = Instance.new("BodyPosition",torso)
            local gyro = Instance.new("BodyGyro",torso)
            pos.Name="EPIXPOS"
            pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
            pos.position = torso.Position
            gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            gyro.cframe = torso.CFrame
            repeat
            wait()
            localplayer.Character.Humanoid.PlatformStand=true
            local new=gyro.cframe - gyro.cframe.p + pos.position
            if not keys.w and not keys.s and not keys.a and not keys.d then
            speed=5
            end
            if keys.w then
            new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
            speed=speed+0
            end
            if keys.s then
            new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
            speed=speed+0
            end
            if keys.d then
            new = new * CFrame.new(speed,0,0)
            speed=speed+0
            end
            if keys.a then
            new = new * CFrame.new(-speed,0,0)
            speed=speed+0
            end
            speed= _G.flyspeedbaka
            pos.position=new.p
            if keys.w then
            gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
            elseif keys.s then
            gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
            else
            gyro.cframe = workspace.CurrentCamera.CoordinateFrame
            end
            until flying == false
            if gyro then gyro:Destroy() end
            if pos then pos:Destroy() end
            flying=false
            localplayer.Character.Humanoid.PlatformStand=false
            speed=10
            end
            e1=mouse.KeyDown:connect(function(key)
            if not torso or not torso.Parent then flying=false e1:disconnect() e2:disconnect() return end
            if key=="w" then
            keys.w=true
            elseif key=="s" then
            keys.s=true
            elseif key=="a" then
            keys.a=true
            elseif key=="d" then
            keys.d=true
            elseif key=="x" then
            if flying==true then
            flying=false
            else
            flying=true
            start()
            end
            end
            end)
            e2=mouse.KeyUp:connect(function(key)
            if key=="w" then
            keys.w=false
            elseif key=="s" then
            keys.s=false
            elseif key=="a" then
            keys.a=false
            elseif key=="d" then
            keys.d=false
            end
            end)
            start()
end}) 

twosection:AddSlider({text = "Fly Speed", min = 1, max = 30, value = 5, callback = function(speed)
    _G.flyspeedbaka = speed
end})

twosection:AddButton({text = "> Click this <", callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/vDWJq6Wa"))()
end})

twosection:AddSlider({text = "HipHeight", min = 2 , max = 120, value = 2, callback = function(speed)
     
    _G.hipheight = speed
    game.Players.LocalPlayer.Character.Humanoid.HipHeight = _G.hipheight
end}) 

twosection:AddBind({text = "HipHeight Bind", key = "", callback = function(state)
if state == true then
    game.Players.LocalPlayer.Character.Humanoid.HipHeight = 2
end

if state == false then
    game.Players.LocalPlayer.Character.Humanoid.HipHeight = _G.hipheight
end
end}) 


twosection:AddBind({text = "Jitter-Bot", key = "Y", callback = function(state)
    local Angle = 180

    _G.jitter = state         

    while _G.jitter == true do 
    wait(_G.delayswitch)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0,-math.rad(Angle),0)
    end 
end}) 

twosection:AddSlider({text = "Jitter-Bot Speed", min = 1, max = 100, value = 100, callback = function(speed)
    _G.delayswitch = speed *0.0010
end})

twosection:AddBind({text = "Noclip", key = "", callback = function(state)
    _G.nocliptoggle = state   

    while _G.nocliptoggle == true do 
        wait()
    game:GetService("Players").LocalPlayer.Character.Head.Touched:connect(function(obj)
    if obj ~= workspace.Terrain and _G.nocliptoggle == true  then 
    obj.CanCollide = false
    wait(1)
    obj.CanCollide = true
    end
    end) 
end

end}) 

twosection:AddToggle({text = "Infinite Jump", callback = function(state)
    local Player = game:GetService'Players'.LocalPlayer;
    local UIS = game:GetService'UserInputService';
     
    _G.JumpHeight = 50;
     _G.infinitejump = state    
    function Action(Object, Function) if Object ~= nil then Function(Object); end end
     
    UIS.InputBegan:connect(function(UserInput)
        if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space and _G.infinitejump == true  then
            Action(Player.Character.Humanoid, function(self)
                if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
                    Action(self.Parent.HumanoidRootPart, function(self)
                        self.Velocity = Vector3.new(0, _G.JumpHeight, 0);
                    end)
                end
            end)
        end
    end)
end}) 

twosection:AddSlider({text = "Infinite Jump Velocity", min = 1, max = 500, value = 50, callback = function(speed)
    _G.JumpHeight = speed
end})


-- [Movement Section End] -----------------------------------------------------------------------------------------------------------------------------------------------------




-- [Bot Section Start] -----------------------------------------------------------------------------------------------------------------------------------------------------



foursectionn:AddToggle({text = "Bot", callback = function(state)
   
     _G.bot = state
    local Radius = 35
    local lplr = game:GetService("Players").LocalPlayer
    
     
    game:GetService("RunService").Stepped:Connect(function() 
    for _,q in pairs (game:GetService("Players"):GetPlayers()) do 
        if q  ~= lplr then
            local Magnitude = (lplr.Character.HumanoidRootPart.Position - q.Character.HumanoidRootPart.Position).Magnitude
            if Radius > Magnitude then 
                if game.Players[q.Name].Information.KO.Value == false and _G.bot == true then 
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[q.Name].Character.HumanoidRootPart.CFrame * CFrame.new(_G.sideways ,_G.up ,_G.distance)
           if _G.underground == true then 
            game.Players.LocalPlayer.Character.Humanoid.HipHeight = -10
            _G.nocliptoggle = true   

            while _G.nocliptoggle == true do 
                wait()
        game:GetService("Players").LocalPlayer.Character.Head.Touched:connect(function(obj)
        if obj ~= workspace.Terrain and _G.nocliptoggle == true  then 
        obj.CanCollide = false
        wait(1)
        obj.CanCollide = true
        end
        end) 
        end
           end 
           if _G.underground == false then 
            game.Players.LocalPlayer.Character.Humanoid.HipHeight = 2
           end 
      end
    end
 
    end
    end 
    end)      
end})

foursectionn:AddBind({text = "Bind", key = "", callback = function(state)
    _G.bot = state
    local Radius = 35
    local lplr = game:GetService("Players").LocalPlayer
    
     
    game:GetService("RunService").Stepped:Connect(function() 
    for _,q in pairs (game:GetService("Players"):GetPlayers()) do 
        if q  ~= lplr then
            local Magnitude = (lplr.Character.HumanoidRootPart.Position - q.Character.HumanoidRootPart.Position).Magnitude
            if Radius > Magnitude then 
                if game.Players[q.Name].Information.KO.Value == false and _G.bot == true then 
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[q.Name].Character.HumanoidRootPart.CFrame * CFrame.new(_G.sideways ,_G.up ,_G.distance)
           if _G.underground == true then 
            game.Players.LocalPlayer.Character.Humanoid.HipHeight = -10

           end 
           if _G.underground == false then 
            game.Players.LocalPlayer.Character.Humanoid.HipHeight = 2
           end 
      end
    end
 
    end
    end 
    end)  
end}) 


foursectionn:AddButton({text = "Reach", callback = function()
    for i,v in pairs(game:GetService'Players'.LocalPlayer.Character:GetChildren())do
        if v:isA("Tool") then
           local Reach = Instance.new("SelectionBox",v.Handle)
           Reach.Adornee = v.Handle
           v.Handle.Size = Vector3.new(25, 25, 25)
           v.Handle.Transparency = 1
        end
   end 
end}) 


foursectionn:AddToggle({text = "Underground", callback = function(state)
    _G.undergroundtoggle = state
    if _G.undergroundtoggle == true then 
        game.Players.LocalPlayer.Character.Humanoid.HipHeight = -10
        _G.nocliptoggle = state   

        while _G.nocliptoggle == true do 
            wait()
    game:GetService("Players").LocalPlayer.Character.Head.Touched:connect(function(obj)
    if obj ~= workspace.Terrain and _G.nocliptoggle == true  then 
    obj.CanCollide = false
    wait(1)
    obj.CanCollide = true
    end
    end) 
    end
    end 

    if _G.undergroundtoggle == false then 
        game.Players.LocalPlayer.Character.Humanoid.HipHeight = 2
        _G.nocliptoggle = false 
    end 
end}) 

foursectionn:AddSlider({text = "Up", min = -50, max = 50, value = 0, callback = function(speed)
    _G.up = speed
end})

foursectionn:AddSlider({text = "Sideways", min = -50, max = 50, value = 0, callback = function(speed)
    _G.sideways = speed
end})

foursectionn:AddSlider({text = "Backwards", min = -50, max = 50, value = 5, callback = function(speed)
    _G.distance = speed
end})

-- [Bot Section End ] -----------------------------------------------------------------------------------------------------------------------------------------------------





-- [Tab Two Info] -----------------------------------------------------------------------------------------------------------------------------------------------------

local MainTabTwo = library:AddTab("Misc");

local three = MainTabTwo:AddColumn(); 
local four = MainTabTwo:AddColumn(); 

local threesection = three:AddSection("Visuals"); 
local threesectionn = three:AddSection("Misc"); 
local foursection = four:AddSection("Teleports"); 
local fivesection = four:AddSection("Autofarms"); 
local esp = four:AddSection("ESP"); 
local gripposweaponsection = four:AddSection("Grip-Pos"); 

local sixsection = three:AddSection("Animations"); 

-- [Tab Two Info End] -----------------------------------------------------------------------------------------------------------------------------------------------------









-- [Visual Section Start] -----------------------------------------------------------------------------------------------------------------------------------------------------

threesection:AddButton({text = "FF Body", callback = function()
    game.Players.LocalPlayer.Character.RightHand.Material = Enum.Material.ForceField 
    game.Players.LocalPlayer.Character.RightLowerArm.Material = Enum.Material.ForceField 
    game.Players.LocalPlayer.Character.RightUpperArm.Material = Enum.Material.ForceField 
    game.Players.LocalPlayer.Character.Head.Material = Enum.Material.ForceField 
    game.Players.LocalPlayer.Character.LeftHand.Material = Enum.Material.ForceField 
    game.Players.LocalPlayer.Character.LeftLowerArm.Material = Enum.Material.ForceField 
    game.Players.LocalPlayer.Character.LeftUpperArm.Material = Enum.Material.ForceField
    game.Players.LocalPlayer.Character.LowerTorso.Material = Enum.Material.ForceField 
    game.Players.LocalPlayer.Character.UpperTorso.Material = Enum.Material.ForceField 
    game.Players.LocalPlayer.Character.LeftFoot.Material = Enum.Material.ForceField 
    game.Players.LocalPlayer.Character.LeftLowerLeg.Material = Enum.Material.ForceField 
    game.Players.LocalPlayer.Character.LeftUpperLeg.Material = Enum.Material.ForceField 
    game.Players.LocalPlayer.Character.RightFoot.Material = Enum.Material.ForceField 
    game.Players.LocalPlayer.Character.RightLowerLeg.Material = Enum.Material.ForceField 
    game.Players.LocalPlayer.Character.RightUpperLeg.Material = Enum.Material.ForceField 
end})   

threesection:AddColor({text = "FF Color", callback = function(colorpick)
    game.Players.LocalPlayer.Character.RightHand.Color = colorpick
    game.Players.LocalPlayer.Character.RightLowerArm.Color = colorpick
    game.Players.LocalPlayer.Character.RightUpperArm.Color = colorpick
    game.Players.LocalPlayer.Character.Head.Color = colorpick
    game.Players.LocalPlayer.Character.LeftHand.Color = colorpick
    game.Players.LocalPlayer.Character.LeftLowerArm.Color = colorpick
    game.Players.LocalPlayer.Character.LeftUpperArm.Color = colorpick
    game.Players.LocalPlayer.Character.LowerTorso.Color = colorpick
    game.Players.LocalPlayer.Character.UpperTorso.Color = colorpick
    game.Players.LocalPlayer.Character.LeftFoot.Color = colorpick
    game.Players.LocalPlayer.Character.LeftLowerLeg.Color = colorpick
    game.Players.LocalPlayer.Character.LeftUpperLeg.Color = colorpick
    game.Players.LocalPlayer.Character.RightFoot.Color = colorpick
    game.Players.LocalPlayer.Character.RightLowerLeg.Color = colorpick
    game.Players.LocalPlayer.Character.RightUpperLeg.Color = colorpick 
end}) 



threesection:AddButton({text = "FF Gun", callback = function()
    for i,v in pairs(game:GetService'Players'.LocalPlayer.Character:GetChildren())do
        if v:isA("Tool") then
           v.Handle.Material = Enum.Material.ForceField 
   end 
end 
end}) 

threesection:AddColor({text = "FF Gun Color", callback = function(colorpick)
    for i,v in pairs(game:GetService'Players'.LocalPlayer.Character:GetChildren())do
        if v:isA("Tool") then
           v.Handle.Color = colorpick
    end 
    end 
end}) 

threesection:AddButton({text = "FF Radio On Back", callback = function()
    game.Players.LocalPlayer.Character.Radio.Material = Enum.Material.ForceField
end}) 

threesection:AddColor({text = "FF Radio Colour", callback = function(colorpick)
        game.Players.LocalPlayer.Character.Radio.Color = colorpick
end}) 

threesection:AddToggle({text = "Chroma Body", callback = function(state)
    _G.chromaff = state
     
    while _G.chromaff == true do 
        wait()
        game.Players.LocalPlayer.Character.RightHand.Color = chromaColor
        game.Players.LocalPlayer.Character.RightLowerArm.Color = chromaColor
        game.Players.LocalPlayer.Character.RightUpperArm.Color = chromaColor
        game.Players.LocalPlayer.Character.Head.Color = chromaColor
        game.Players.LocalPlayer.Character.LeftHand.Color = chromaColor
        game.Players.LocalPlayer.Character.LeftLowerArm.Color = chromaColor
        game.Players.LocalPlayer.Character.LeftUpperArm.Color = chromaColor
        game.Players.LocalPlayer.Character.LowerTorso.Color = chromaColor
        game.Players.LocalPlayer.Character.UpperTorso.Color = chromaColor
        game.Players.LocalPlayer.Character.LeftFoot.Color = chromaColor
        game.Players.LocalPlayer.Character.LeftLowerLeg.Color = chromaColor
        game.Players.LocalPlayer.Character.LeftUpperLeg.Color = chromaColor
        game.Players.LocalPlayer.Character.RightFoot.Color = chromaColor
        game.Players.LocalPlayer.Character.RightLowerLeg.Color = chromaColor
        game.Players.LocalPlayer.Character.RightUpperLeg.Color = chromaColor 
    end
end}) 


threesection:AddButton({text = "Remove Radio", callback = function()
    game.Players.LocalPlayer.Character.Radio:Destroy()
end}) 

threesection:AddColor({text = "Ambient", color = Color3.new(0.470081627368927,0.4685755670070648,0.47093021869659426) , callback = function(colorpick)
    game:GetService("Lighting").OutdoorAmbient = colorpick
end})


threesection:AddColor({text = "Fog Color", color = Color3.fromRGB(100, 87, 72) , callback = function(colorpick)
    game:GetService("Lighting").FogColor = colorpick
end})

threesection:AddColor({text = "Tint", color = Color3.new(1,1,1) , callback = function(colorpick)
    game:GetService("Lighting").ColorCorrection.TintColor = colorpick
end})

threesection:AddButton({text = "No animation", callback = function()
    local c = game.Players.LocalPlayer.Character
    c.Parent = nil
    c.Animate:Destroy()
    c.Parent = game.workspace
end}) 

threesection:AddButton({text = "Remove Hats", callback = function()
    local client = game:GetService("Players").LocalPlayer
    local char = client.Character

    for _,delete in pairs(char:GetChildren()) do
    if delete:IsA('Accessory') then
        delete:Destroy()
    end
    end
end}) 

-- [Visual Section End] -----------------------------------------------------------------------------------------------------------------------------------------------------





-- [Remote Spam Section Start] -----------------------------------------------------------------------------------------------------------------------------------------------------


threesectionn:AddToggle({text = "Anti Stomp", callback = function(state)
    _G.antistomptoggle = state 
    
    game:GetService("RunService").Stepped:Connect(function() 
        if game.Players.LocalPlayer.Character.Humanoid.Health <= 10 and _G.antistomptoggle == true then
            game.Players.LocalPlayer.Character.I_LOADED_I:Destroy()
            wait(7)
            game.Players.LocalPlayer.Character.Humanoid.RigType = Enum.HumanoidRigType.R6
            wait(3)
            for I, V in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if V:IsA("BasePart") and not V.Anchored then
                    V.Anchored = true
                end
            end
            game.Players.LocalPlayer.Character.Head:ClearAllChildren()
        end
        end) 
end})

threesectionn:AddToggle({text = "Auto Stomp", callback = function(state)
    _G.autostomp =  state
    while _G.autostomp == true do
        wait()
    local args = {
        [1] = "Stomp"
    }
    
    game:GetService("ReplicatedStorage").MainRemote:FireServer(unpack(args))
    end
end})

threesectionn:AddToggle({text = "Anti-Grab", callback = function(state)
    _G.antigrab = state
    while _G.antigrab == true do    
    wait() 
        local GC = game.Players.LocalPlayer.Character:FindFirstChild("WELD_GRAB")
                        if GC then
                            GC:Destroy()
                            wait(0.02)
                            game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid').Sit = true
                        end
                        end
end})


threesectionn:AddToggle({text = "Kill Anyone Carrying You", callback = function(state)
    _G.killcarry = state

    while _G.killcarry == true do 
        wait()
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("I_LOADED_I") and game.Players.LocalPlayer.Character:FindFirstChild("I_LOADED_I")['K.O'].Value == true and game.Players.LocalPlayer.Character:FindFirstChild("WELD_GRAB") then
            game.Players.LocalPlayer.Character.Head.NeckRigAttachment:Destroy()
      game.Players.LocalPlayer.Character.Head.FaceFrontAttachment:Destroy()
      game.Players.LocalPlayer.Character.Head.HatAttachment:Destroy()
      game.Players.LocalPlayer.Character.Head.HairAttachment:Destroy()
      game.Players.LocalPlayer.Character.Head.FaceCenterAttachment:Destroy()
      game.Players.LocalPlayer.Character.Head.Neck:Destroy()
      game.Players.LocalPlayer.Character.Head.Head:Destroy()
      game.Players.LocalPlayer.Character.Head.OriginalSize:Destroy()
   end
end 
     
end}) 


threesectionn:AddToggle({text = "Disable all seats", callback = function(state)
    if state == true then
        for i,v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("Seat") then
                v.Disabled = true
            end
        end 
    end 
   

    if state == false then 
        for i,v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("Seat") then
                v.Disabled = true
            end
        end 
    end 
end})

-- [Remote Spam Section End] -----------------------------------------------------------------------------------------------------------------------------------------------------







-- [Teleport Section Start] -----------------------------------------------------------------------------------------------------------------------------------------------------


foursection:AddButton({text = "Revolver", callback = function()

    local plr = game:service"Players".LocalPlayer;
    local tween_s = game:service"TweenService";
    local info = TweenInfo.new(10,Enum.EasingStyle.Quad);
    function tp(...)
       local tic_k = tick();
       local params = {...};
       local cframe = CFrame.new(params[1],params[2],params[3]);
       local tween,err = pcall(function()
           local tween = tween_s:Create(plr.Character["HumanoidRootPart"],info,{CFrame=cframe});
           tween:Play();
       end)
       if not tween then return err end
    end
    tp(-2569.17627, 399.490173, -778.763, 1, 0, 0, 0, 1, 0, 0, 0, 1);
end})

foursection:AddButton({text = "DB", callback = function() 
    local plr = game:service"Players".LocalPlayer;
    local tween_s = game:service"TweenService";
    local info = TweenInfo.new(10,Enum.EasingStyle.Quad);
    function tp(...)
       local tic_k = tick();
       local params = {...};
       local cframe = CFrame.new(params[1],params[2],params[3]);
       local tween,err = pcall(function()
           local tween = tween_s:Create(plr.Character["HumanoidRootPart"],info,{CFrame=cframe});
           tween:Play();
       end)
       if not tween then return err end
    end
    tp(-2963.12939, 399.49704, -915.95636, 1, 0, 0, 0, 1, 0, 0, 0, 1);
end})

foursection:AddButton({text = "Mid Shield", callback = function() 
    local plr = game:service"Players".LocalPlayer;
    local tween_s = game:service"TweenService";
    local info = TweenInfo.new(10,Enum.EasingStyle.Quad);
    function tp(...)
       local tic_k = tick();
       local params = {...};
       local cframe = CFrame.new(params[1],params[2],params[3]);
       local tween,err = pcall(function()
           local tween = tween_s:Create(plr.Character["HumanoidRootPart"],info,{CFrame=cframe});
           tween:Play();
       end)
       if not tween then return err end
    end
    tp(-2860.01416, 352.475708, -82.1079102, 1, 0, 0, 0, 1, 0, 0, 0, 1);
end})

foursection:AddButton({text = "Golden AK", callback = function()  
	local saveposition = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	local plr = game:service"Players".LocalPlayer;
    local tween_s = game:service"TweenService";
    local info = TweenInfo.new(7,Enum.EasingStyle.Quad);
    function tp(...)
       local tic_k = tick();
       local params = {...};
       local cframe = CFrame.new(params[1],params[2],params[3]);
       local tween,err = pcall(function()
           local tween = tween_s:Create(plr.Character["HumanoidRootPart"],info,{CFrame=cframe});
           tween:Play();
       end)
       if not tween then return err end
    end
    tp(-1981.39966, 319.040283, -498.780762, 0, 0, 1, 0, 1, -0, -1, 0, 0);
	wait(8)

	fireclickdetector(game:GetService("Workspace").Shop.Guns["[Golden AK-47] - $5250"].ClickDetector)

        
  
end})

foursection:AddButton({text = "Casino", callback = function() 
    local plr = game:service"Players".LocalPlayer;
    local tween_s = game:service"TweenService";
    local info = TweenInfo.new(7,Enum.EasingStyle.Quad);
    function tp(...)
       local tic_k = tick();
       local params = {...};
       local cframe = CFrame.new(params[1],params[2],params[3]);
       local tween,err = pcall(function()
           local tween = tween_s:Create(plr.Character["HumanoidRootPart"],info,{CFrame=cframe});
           tween:Play();
       end)
       if not tween then return err end
    end
    tp(-2853.83398, 414.996246, -791.431885, 0, 0, 1, 0, 1, -0, -1, 0, 0);
end})

foursection:AddButton({text = "Bank", callback = function() 
    local plr = game:service"Players".LocalPlayer;
    local tween_s = game:service"TweenService";
    local info = TweenInfo.new(7,Enum.EasingStyle.Quad);
    function tp(...)
       local tic_k = tick();
       local params = {...};
       local cframe = CFrame.new(params[1],params[2],params[3]);
       local tween,err = pcall(function()
           local tween = tween_s:Create(plr.Character["HumanoidRootPart"],info,{CFrame=cframe});
           tween:Play();
       end)
       if not tween then return err end
    end
    tp(-2352.12842, 420.337708, -944.30481, -1.54972076e-06, 0.0025636307, 0.999996722, 1.97906047e-09, 0.999996722, -0.0025636307, -1, -1.97906047e-09, -1.54972076e-06);
end})

foursection:AddButton({text = "Lettuce", callback = function() 
    local plr = game:service"Players".LocalPlayer;
    local tween_s = game:service"TweenService";
    local info = TweenInfo.new(7,Enum.EasingStyle.Quad);
    function tp(...)
       local tic_k = tick();
       local params = {...};
       local cframe = CFrame.new(params[1],params[2],params[3]);
       local tween,err = pcall(function()
           local tween = tween_s:Create(plr.Character["HumanoidRootPart"],info,{CFrame=cframe});
           tween:Play();
       end)
       if not tween then return err end
    end
    tp(-2010.52, 403.19, -1296.71);
end})

foursection:AddButton({text = "Safe Place", callback = function() 
    local plr = game:service"Players".LocalPlayer;
    local tween_s = game:service"TweenService";
    local info = TweenInfo.new(10,Enum.EasingStyle.Quad);
    function tp(...)
       local tic_k = tick();
       local params = {...};
       local cframe = CFrame.new(params[1],params[2],params[3]);
       local tween,err = pcall(function()
           local tween = tween_s:Create(plr.Character["HumanoidRootPart"],info,{CFrame=cframe});
           tween:Play();
       end)
       if not tween then return err end
    end
    tp(-1112.40674, 487.291077, -1181.98279, 0.977096617, -3.27662626e-08, -0.212796226, 4.80707172e-08, 1, 6.67468285e-08, 0.212796226, -7.54473675e-08, 0.977096617);
end})

-- [Teleport Section End] -----------------------------------------------------------------------------------------------------------------------------------------------------








-- [AutoFarm Section Start] -----------------------------------------------------------------------------------------------------------------------------------------------------


fivesection:AddToggle({text = "Lettuce Farm", callback = function(state)
   
    _G.lettucefarm = state 

    

    while _G.lettucefarm == true do 
    wait(0.5)
    fireclickdetector(game:GetService("Workspace").Shop.Others["[Lettuce] - $7"].ClickDetector)
    wait(1)
    game.Players.LocalPlayer.Backpack["[Lettuce]"].Parent = game.Players.LocalPlayer.Character
        game.Players.LocalPlayer.Character["[Lettuce]"]:Activate()
         if game:GetService("Players").LocalPlayer.Information.Muscle == 0 then
             _G.lettucefarm = false 
             
    end
    end
end}) 

fivesection:AddToggle({text = "Weight Farm", callback = function(state)
    _G.weightfarm = state 


    while _G.weightfarm == true do 
        
        wait(1)
        game.Players.LocalPlayer.Character["[HeavyWeights]"]:Activate()
    end
end})

-- [Autofarm Section End] -----------------------------------------------------------------------------------------------------------------------------------------------------










-- [Kiriot ESP Section Start] -----------------------------------------------------------------------------------------------------------------------------------------------------


local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
ESP:Toggle(true)

ESP.Color = Color3.fromRGB(255, 170, 0)
ESP.Tracers = false
ESP.Names = false
ESP.Boxes = false

esp:AddToggle({text = "Boxes", callback = function(state)
    ESP.Boxes = state 
end}) 

esp:AddToggle({text = "Names", callback = function(state)
    ESP.Names = state 
end}) 

esp:AddToggle({text = "Tracers", callback = function(state)
    ESP.Tracers = state 
end}) 

esp:AddColor({text = "Esp Colour", flag = "", callback = function(color)
    ESP.Color = color 
end}) 

esp:AddToggle({text = "Chroma", callback = function(state)
    while state == true do
        task.wait()

    ESP.Color = chromaColor
    end

    while state == false do 
        task.wait()
     ESP.Color = Color3.fromRGB(255, 170, 0)
    end 
end})

-- [Kiriot ESP Section End] -----------------------------------------------------------------------------------------------------------------------------------------------------






-- [Grip Position Section Start] -----------------------------------------------------------------------------------------------------------------------------------------------------

gripposweaponsection:AddToggle({text = "Grip-Pos", callback = function(state)
    local player = Game.Players.LocalPlayer
	if player.Character:FindFirstChildWhichIsA('Tool') then
		player.Character:FindFirstChildWhichIsA('Tool').Grip = CFrame.new(_G.grippossideways, _G.gripposupwards, _G.gripposforwards)
	
    end
end}) 

gripposweaponsection:AddSlider({text = "Forwards", min = -50, max = 50, value = 5, callback = function(speed)
    
    _G.gripposforwards = speed

end}) 

gripposweaponsection:AddSlider({text = "Upwards", min = -50, max = 50, value = 5, callback = function(speed)
    
    _G.gripposupwards = speed

end})

gripposweaponsection:AddSlider({text = "Sideways", min = -50, max = 50, value = 5, callback = function(speed)
    
    _G.grippossideways = speed

end})

-- [Grip Position End] -----------------------------------------------------------------------------------------------------------------------------------------------------








-- [Animation Section Start] -----------------------------------------------------------------------------------------------------------------------------------------------------

sixsection:AddList({text = "Idle", max = 10, flag = "", values = {"Default", "Astronaut","Bubbly","Cartoony","Confindent","Cowboy","Zombie",
    "Elder","Ghost","Knight","Levitation","Mage","Astronaut","Ninja","OldSchool","Patrol","Pirate","Popstar","Princess","Robot",
    "Rthro","Stylish","Superhero","Toy","Vampire","Werewolf",}, 
    value = "Default", callback = function(State)
    LocalPlayer.Character.Animate.idle.Animation1.AnimationId = AnimationModule[State][1]
    LocalPlayer.Character.Animate.idle.Animation2.AnimationId = AnimationModule[State][2]
end}) 

sixsection:AddList({text = "Run", max = 10, flag = "", values = {"Default", "Astronaut","Bubbly","Cartoony","Confindent","Cowboy","Zombie",
    "Elder","Ghost","Knight","Levitation","Mage","Astronaut","Ninja","OldSchool","Patrol","Pirate","Popstar","Princess","Robot",
    "Rthro","Stylish","Superhero","Toy","Vampire","Werewolf",}, 
    value = "Default", callback = function(State)
    LocalPlayer.Character.Animate.run.RunAnim.AnimationId = AnimationModule[State][4]
end}) 

sixsection:AddList({text = "Walk", max = 10, flag = "", values = {"Default", "Astronaut","Bubbly","Cartoony","Confindent","Cowboy","Zombie",
    "Elder","Ghost","Knight","Levitation","Mage","Astronaut","Ninja","OldSchool","Patrol","Pirate","Popstar","Princess","Robot",
    "Rthro","Stylish","Superhero","Toy","Vampire","Werewolf",}, 
    value = "Default", callback = function(State)
    LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId = AnimationModule[State][3]
end}) 

sixsection:AddList({text = "Climb", max = 10, flag = "", values = {"Default", "Astronaut","Bubbly","Cartoony","Confindent","Cowboy","Zombie",
    "Elder","Ghost","Knight","Levitation","Mage","Astronaut","Ninja","OldSchool","Patrol","Pirate","Popstar","Princess","Robot",
    "Rthro","Stylish","Superhero","Toy","Vampire","Werewolf",}, 
    value = "Default", callback = function(State)
    LocalPlayer.Character.Animate.climb.ClimbAnim.AnimationId = AnimationModule[State][6]
end}) 

sixsection:AddList({text = "Fall", max = 10, flag = "", values = {"Default", "Astronaut","Bubbly","Cartoony","Confindent","Cowboy","Zombie",
    "Elder","Ghost","Knight","Levitation","Mage","Astronaut","Ninja","OldSchool","Patrol","Pirate","Popstar","Princess","Robot",
    "Rthro","Stylish","Superhero","Toy","Vampire","Werewolf",}, 
    value = "Default", callback = function(State)
    LocalPlayer.Character.Animate.fall.FallAnim.AnimationId = AnimationModule[State][7]
end}) 

sixsection:AddList({text = "Jump", max = 10, flag = "", values = {"Default", "Astronaut","Bubbly","Cartoony","Confindent","Cowboy","Zombie",
    "Elder","Ghost","Knight","Levitation","Mage","Astronaut","Ninja","OldSchool","Patrol","Pirate","Popstar","Princess","Robot",
    "Rthro","Stylish","Superhero","Toy","Vampire","Werewolf",}, 
    value = "Default", callback = function(State)
    LocalPlayer.Character.Animate.jump.JumpAnim.AnimationId = AnimationModule[State][5]
end}) 

-- [Animation Section End] -----------------------------------------------------------------------------------------------------------------------------------------------------







-- [Library Settings UI] -----------------------------------------------------------------------------------------------------------------------------------------------------
local SettingsTab = library:AddTab("Settings"); 
local SettingsColumn = SettingsTab:AddColumn(); 
local SettingsColumn2 = SettingsTab:AddColumn(); 
local SettingSection = SettingsColumn:AddSection("Menu"); 
local ConfigSection = SettingsColumn2:AddSection("Configs");
local ServerSection = SettingsColumn:AddSection("Server");

local Warning = library:AddWarning({type = "confirm"});

SettingSection:AddBind({text = "Open / Close", flag = "UI Toggle", nomouse = true, key = "Insert", callback = function()
library:Close();
end});


SettingSection:AddColor({text = "Accent Color", flag = "Menu Accent Color", color = Color3.new(0.6395349502563477,0,1), value = Color3.new(0.6395349502563477,0,1), callback = function(color)
if library.currentTab then
    library.currentTab.button.TextColor3 = color;
end
for i,v in pairs(library.theme) do
    v[(v.ClassName == "TextLabel" and "TextColor3") or (v.ClassName == "ImageLabel" and "ImageColor3") or "BackgroundColor3"] = color;
end
end});

-- [Background List]
local backgroundlist = {
Floral = "rbxassetid://5553946656",
Flowers = "rbxassetid://6071575925",
Circles = "rbxassetid://6071579801",
Hearts = "rbxassetid://6073763717"
};

-- [Background List]
local back = SettingSection:AddList({text = "Background", max = 4, flag = "background", values = {"Floral", "Flowers", "Circles", "Hearts"}, value = "Floral", callback = function(v)
if library.main then
    library.main.Image = backgroundlist[v];
end
end});

-- [Background Color Picker]
back:AddColor({flag = "backgroundcolor", color = Color3.new(), callback = function(color)
if library.main then
    library.main.ImageColor3 = color;
end
end, trans = 1, calltrans = function(trans)
if library.main then
    library.main.ImageTransparency = 1 - trans;
end
end});

-- [Tile Size Slider]
SettingSection:AddSlider({text = "Tile Size", min = 50, max = 500, value = 50, callback = function(size)
if library.main then
    library.main.TileSize = UDim2.new(0, size, 0, size);
end
end});


-- [Config Box]
ConfigSection:AddBox({text = "Config Name", skipflag = true});

-- [Config List]
ConfigSection:AddList({text = "Configs", skipflag = true, value = "", flag = "Config List", values = library:GetConfigs()});

-- [Create Button]
ConfigSection:AddButton({text = "Create", callback = function()
library:GetConfigs();
writefile(library.foldername .. "/" .. library.flags["Config Name"] .. library.fileext, "{}");
library.options["Config List"]:AddValue(library.flags["Config Name"]);
end});

-- [Save Button]
ConfigSection:AddButton({text = "Save", callback = function()
local r, g, b = library.round(library.flags["Menu Accent Color"]);
Warning.text = "Are you sure you want to save the current settings to config <font color='rgb(" .. r .. "," .. g .. "," .. b .. ")'>" .. library.flags["Config List"] .. "</font>?";
if Warning:Show() then
    library:SaveConfig(library.flags["Config List"]);
end
end});

-- [Load Button]
ConfigSection:AddButton({text = "Load", callback = function()
local r, g, b = library.round(library.flags["Menu Accent Color"]);
Warning.text = "Are you sure you want to load config <font color='rgb(" .. r .. "," .. g .. "," .. b .. ")'>" .. library.flags["Config List"] .. "</font>?";
if Warning:Show() then
    library:LoadConfig(library.flags["Config List"]);
end
end});

ConfigSection:AddToggle({text = "Chroma Gui" ,callback = function(state)
    _G.chromaguiitself = state 

    game:GetService("RunService").RenderStepped:Connect(function() 
    if _G.chromaguiitself == true then 
    if library.currentTab then
        library.currentTab.button.TextColor3 = chromaColor;
    end
    for i,v in pairs(library.theme) do
        v[(v.ClassName == "TextLabel" and "TextColor3") or (v.ClassName == "ImageLabel" and "ImageColor3") or "BackgroundColor3"] = chromaColor;
    end
end 
end) 
end}) 

ConfigSection:AddToggle({text = "Watermark" ,callback = function(state)
    game:GetService("CoreGui").CWatermark.Enabled = state 
end}) 


ConfigSection:AddColor({text = "Watermark Colour", flag = "", color = Color3.new(0.6395349502563477,0,1), value = Color3.new(0.6395349502563477,0,1), callback = function(color)
    game:GetService("CoreGui").CWatermark.Background.TopColor.BackgroundColor3 = color
end}) 


ConfigSection:AddToggle({text = "Chroma Watermark" ,callback = function(state)

_G.chromawatermark = state 
    while _G.chromawatermark == true do  
    wait() 
    game:GetService("CoreGui").CWatermark.Background.TopColor.BackgroundColor3 = chromaColor
end

if state == false then 
    game:GetService("CoreGui").CWatermark.Background.TopColor.BackgroundColor3 = color
end
end}) 



-- [Delete Button]
ConfigSection:AddButton({text = "Delete", callback = function()
local r, g, b = library.round(library.flags["Menu Accent Color"]);
Warning.text = "Are you sure you want to delete config <font color='rgb(" .. r .. "," .. g .. "," .. b .. ")'>" .. library.flags["Config List"] .. "</font>?";
if Warning:Show() then
    local config = library.flags["Config List"];
    if table.find(library:GetConfigs(), config) and isfile(library.foldername .. "/" .. config .. library.fileext) then
        library.options["Config List"]:RemoveValue(config);
        delfile(library.foldername .. "/" .. config .. library.fileext);
    end
end
end});

ServerSection:AddButton({text = "Rejoin", callback = function()
    game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
end}) 

ServerSection:AddButton({text = "Server-Hop", callback = function()
    local x = {}
	for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
		if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
			x[#x + 1] = v.id
		end
	end
	if #x > 0 then
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
		end 
end}) 

ServerSection:AddToggle({text = "Rejoin On Kick" ,callback = function(state)
if state == true then
    getgenv().rejoin = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
        if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
            game:GetService("TeleportService"):Teleport(game.PlaceId)
        end
    end)
end
if state == false then
    getgenv().rejoin:Disconnect() 
end
end}) 



-- [Init] --------------------------------------------------------------------------------------------------------------------------------------------------------------------
library:Init();
library:selectTab(library.tabs[1]);



local words = {
    '.gg/crimskid <-- best script for dhm',
    'imagine obfuscating ur scripts with a loadstring softvortex 😂😂',
    'Not using ur brain 🧠🧠 use crimskid',
    'get clapped using crimskid',
    'real chads use crimskid😎😀😋',
    'Oblivion is cool ngl 💀💀',
    'crimskid the best gui!!! 😍😎',
}

