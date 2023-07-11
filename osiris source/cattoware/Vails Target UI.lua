-- GUI to Lua 
-- Version: 0.0.3

-- Instances:

local TargetUI = Instance.new("ScreenGui")
local MainBackground_1 = Instance.new("Frame")
local pp_1 = Instance.new("UICorner")
local oo_1 = Instance.new("UIStroke")
local mm_1 = Instance.new("UIGradient")
local outlinethingy_1 = Instance.new("Frame")
local dd_1 = Instance.new("UICorner")
local cc_1 = Instance.new("UIStroke")
local bb_1 = Instance.new("UIGradient")
local Username_1 = Instance.new("TextLabel")
local Profile_1 = Instance.new("ImageLabel")
local aa_1 = Instance.new("UICorner")
local Health_1 = Instance.new("Frame")
local hh_1 = Instance.new("UICorner")
local HealthImage_1 = Instance.new("ImageButton")
local ee_1 = Instance.new("UIGradient")
local HealthBar_1 = Instance.new("Frame")
local ff_1 = Instance.new("UIGradient")
local gg_1 = Instance.new("UICorner")
local Armor_1 = Instance.new("Frame")
local ll_1 = Instance.new("UICorner")
local ArmorImage_1 = Instance.new("ImageButton")
local ii_1 = Instance.new("UIGradient")
local ArmorBar_1 = Instance.new("Frame")
local jj_1 = Instance.new("UIGradient")
local kk_1 = Instance.new("UICorner")

-- Properties:
TargetUI.Name = "Target UI"
TargetUI.Parent = game.CoreGui
TargetUI.ZIndexBehavior = Enum.ZIndexBehavior.Global
TargetUI.Enabled = false 


MainBackground_1.Name = "Main Background"
MainBackground_1.Parent = TargetUI
MainBackground_1.BackgroundColor3 = Color3.fromRGB(11,11,11)
MainBackground_1.BackgroundTransparency = 0.17000000178813934
MainBackground_1.BorderColor3 = Color3.fromRGB(27,42,53)
MainBackground_1.Position = UDim2.new(0.418965966, 0,0.733151376, 0)
MainBackground_1.Size = UDim2.new(0, 255,0, 75)

pp_1.Name = "pp"
pp_1.Parent = MainBackground_1
pp_1.CornerRadius = UDim.new(0,7)

oo_1.Name = "oo"
oo_1.Parent = MainBackground_1
oo_1.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
oo_1.Color = Color3.fromRGB(255,255,255)
oo_1.Thickness = 4.300000190734863

mm_1.Name = "mm"
mm_1.Parent = oo_1
mm_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(131, 11, 42)), ColorSequenceKeypoint.new(0.525, Color3.fromRGB(157, 2, 21)), ColorSequenceKeypoint.new(1, Color3.fromRGB(111, 0, 32))}

outlinethingy_1.Name = "outline thingy"
outlinethingy_1.Parent = MainBackground_1
outlinethingy_1.BackgroundColor3 = Color3.fromRGB(11,11,11)
outlinethingy_1.BackgroundTransparency = 1
outlinethingy_1.BorderColor3 = Color3.fromRGB(27,42,53)
outlinethingy_1.Position = UDim2.new(0.0446600243, 0,0.0933333337, 0)
outlinethingy_1.Size = UDim2.new(0, 60,0, 60)

dd_1.Name = "dd"
dd_1.Parent = outlinethingy_1
dd_1.CornerRadius = UDim.new(0,3)

cc_1.Name = "cc"
cc_1.Parent = outlinethingy_1
cc_1.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
cc_1.Color = Color3.fromRGB(255,255,255)
cc_1.Thickness = 3

bb_1.Name = "bb"
bb_1.Parent = cc_1
bb_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(131, 11, 42)), ColorSequenceKeypoint.new(0.525, Color3.fromRGB(157, 2, 21)), ColorSequenceKeypoint.new(1, Color3.fromRGB(111, 0, 32))}

Username_1.Name = "Username"
Username_1.Parent = MainBackground_1
Username_1.BackgroundColor3 = Color3.fromRGB(0,0,0)
Username_1.BackgroundTransparency = 1
Username_1.BorderColor3 = Color3.fromRGB(27,42,53)
Username_1.Position = UDim2.new(0.278, 0,0, 0)
Username_1.Size = UDim2.new(0, 181,0, 20)
Username_1.Font = Enum.Font.GothamBold
Username_1.Text = "Username"
Username_1.TextColor3 = Color3.fromRGB(253,255,255)
Username_1.TextSize = 15
Username_1.TextScaled = true


Profile_1.Name = "Profile"
Profile_1.Parent = MainBackground_1
Profile_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
Profile_1.BackgroundTransparency = 1
Profile_1.BorderColor3 = Color3.fromRGB(27,42,53)
Profile_1.Position = UDim2.new(0.0392156877, 0,0.100000024, 0)
Profile_1.Size = UDim2.new(0, 60,0, 60)
Profile_1.Image = "http://www.roblox.com/asset/?id=10335424092"

aa_1.Name = "aa"
aa_1.Parent = Profile_1
aa_1.CornerRadius = UDim.new(0,3)

Health_1.Name = "Health"
Health_1.Parent = MainBackground_1
Health_1.BackgroundColor3 = Color3.fromRGB(11,11,11)
Health_1.BackgroundTransparency = 0.12999999523162842
Health_1.BorderColor3 = Color3.fromRGB(27,42,53)
Health_1.BorderSizePixel = 0
Health_1.Position = UDim2.new(0.388000011, 0,0.349999994, 0)
Health_1.Size = UDim2.new(0, 146,0, 12)

hh_1.Name = "hh"
hh_1.Parent = Health_1
hh_1.CornerRadius = UDim.new(0,14)

HealthImage_1.Name = "HealthImage"
HealthImage_1.Parent = Health_1
HealthImage_1.Active = true
HealthImage_1.BackgroundColor3 = Color3.fromRGB(163,162,165)
HealthImage_1.BackgroundTransparency = 1
HealthImage_1.BorderColor3 = Color3.fromRGB(27,42,53)
HealthImage_1.LayoutOrder = 8
HealthImage_1.Position = UDim2.new(-0.174657524, 0,-0.541999996, 0)
HealthImage_1.Size = UDim2.new(0, 25,0, 25)
HealthImage_1.ZIndex = 2
HealthImage_1.Image = "rbxassetid://3926305904"
HealthImage_1.ImageRectOffset = Vector2.new(964, 444)
HealthImage_1.ImageRectSize = Vector2.new(36, 36)

ee_1.Name = "ee"
ee_1.Parent = HealthImage_1
ee_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(131, 11, 42)), ColorSequenceKeypoint.new(0.525, Color3.fromRGB(157, 2, 21)), ColorSequenceKeypoint.new(1, Color3.fromRGB(111, 0, 32))}

HealthBar_1.Name = "HealthBar"
HealthBar_1.Parent = Health_1
HealthBar_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
HealthBar_1.BorderColor3 = Color3.fromRGB(27,42,53)
HealthBar_1.BorderSizePixel = 0
HealthBar_1.Position = UDim2.new(-0.00363033754, 0,0.0200004578, 0)
HealthBar_1.Size = UDim2.new(0, 146,0, 12)

ff_1.Name = "ff"
ff_1.Parent = HealthBar_1
ff_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(131, 11, 42)), ColorSequenceKeypoint.new(0.525, Color3.fromRGB(157, 2, 21)), ColorSequenceKeypoint.new(1, Color3.fromRGB(111, 0, 32))}

gg_1.Name = "gg"
gg_1.Parent = HealthBar_1
gg_1.CornerRadius = UDim.new(0,14)

Armor_1.Name = "Armor"
Armor_1.Parent = MainBackground_1
Armor_1.BackgroundColor3 = Color3.fromRGB(11,11,11)
Armor_1.BackgroundTransparency = 0.12999999523162842
Armor_1.BorderColor3 = Color3.fromRGB(27,42,53)
Armor_1.BorderSizePixel = 0
Armor_1.Position = UDim2.new(0.39199999, 0,0.680000007, 0)
Armor_1.Size = UDim2.new(0, 146,0, 12)

ll_1.Name = "ll"
ll_1.Parent = Armor_1
ll_1.CornerRadius = UDim.new(0,14)

ArmorImage_1.Name = "ArmorImage"
ArmorImage_1.Parent = Armor_1
ArmorImage_1.Active = true
ArmorImage_1.BackgroundColor3 = Color3.fromRGB(163,162,165)
ArmorImage_1.BackgroundTransparency = 1
ArmorImage_1.BorderColor3 = Color3.fromRGB(27,42,53)
ArmorImage_1.LayoutOrder = 7
ArmorImage_1.Position = UDim2.new(-0.181849316, 0,-0.541999996, 0)
ArmorImage_1.Size = UDim2.new(0, 25,0, 25)
ArmorImage_1.ZIndex = 2
ArmorImage_1.Image = "rbxassetid://3926307971"
ArmorImage_1.ImageRectOffset = Vector2.new(164, 284)
ArmorImage_1.ImageRectSize = Vector2.new(36, 36)

ii_1.Name = "ii"
ii_1.Parent = ArmorImage_1
ii_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(131, 11, 42)), ColorSequenceKeypoint.new(0.525, Color3.fromRGB(157, 2, 21)), ColorSequenceKeypoint.new(1, Color3.fromRGB(111, 0, 32))}

ArmorBar_1.Name = "ArmorBar"
ArmorBar_1.Parent = Armor_1
ArmorBar_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
ArmorBar_1.BorderColor3 = Color3.fromRGB(27,42,53)
ArmorBar_1.BorderSizePixel = 0
ArmorBar_1.Position = UDim2.new(-0.00400000019, 0,-0.0219999999, 0)
ArmorBar_1.Size = UDim2.new(0, 147,0, 12)

jj_1.Name = "jj"
jj_1.Parent = ArmorBar_1
jj_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(131, 11, 42)), ColorSequenceKeypoint.new(0.525, Color3.fromRGB(157, 2, 21)), ColorSequenceKeypoint.new(1, Color3.fromRGB(111, 0, 32))}

kk_1.Name = "kk"
kk_1.Parent = ArmorBar_1
kk_1.CornerRadius = UDim.new(0,14)


--[[	local script = Instance.new('LocalScript', MainBackground_1)

	
	
	local Run = game:GetService("RunService")
	local localplayer = game.Players.LocalPlayer
	
	Run.RenderStepped:Connect(function()
		HealthBar_1:TweenSize(UDim2.new(0, math.floor(localplayer.Character.Humanoid.Health) * 1.4746 , 0, 12), "Out", "Linear", 0.5)
		ArmorBar_1:TweenSize(UDim2.new(0, math.floor(localplayer.Information.Armor.Value) * 1.4746 , 0, 12), "Out", "Linear", 0.5)
		Profile_1.Image = "rbxthumb://type=AvatarHeadShot&id=" ..localplayer.UserId.. "&w=420&h=420"
		Username_1.Text = localplayer.Name
	end)]]