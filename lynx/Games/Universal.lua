--[[
    eternal will rewrite this when electron is back
]]
getgenv().utility = {Cursor = {Lines = {}, Outlines = {}}, Connections = {}}
local library, pointers, Relations = loadfile("lynx/Utility/Library.lua")();
local Functions, Settings, Tween = loadfile("lynx/Utility/Functions.lua")(), loadfile("lynx/Utility/ESP.lua")(), loadfile("lynx/Utility/TweenModule.lua")();
-- Services
local InputService, TeleportService, RunService, Workspace, Lighting, Players, HttpService, StarterGui, ReplicatedStorage, TweenService  = game:GetService("UserInputService"), game:GetService("TeleportService"), game:GetService("RunService"), game:GetService("Workspace"), game:GetService("Lighting"), game:GetService("Players"), game:GetService("HttpService"), game:GetService("StarterGui"), game:GetService("ReplicatedStorage"), game:GetService("TweenService")
-- Decendants 
local LocalPlayer = Players.LocalPlayer
local Mouse, Camera = LocalPlayer:GetMouse(), Workspace.Camera
-- Optimizers
local Find, Clear, Sub, Upper, Lower, Insert = table.find, table.clear, string.sub, string.upper, string.lower, table.insert
local Huge, Pi, Clamp, Round, Abs, Floor, Random, Sin, Cos, Rad, Halfpi = math.huge, math.pi, math.clamp, math.round, math.abs, math.floor, math.random, math.sin, math.cos, math.rad, math.pi/2
local rgb, v3, v2, cf, Instance, White = Color3.fromRGB, Vector3.new, Vector2.new, CFrame.new, Instance.new, Color3.new(1, 1, 1)
local SpinAngle = 0 
local SpinSize = 25
local SpinSpeed = 0
--
for Index = 1, 4 do
    local line = Lynx:newDrawing("Line",{
        Visible =  true,
        Color = White,
        Thickness = 2,
        ZIndex = 2,
        Transparency = 1
    })
    --
    local line_outline = Lynx:newDrawing("Line",{
        Visible =  true,
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 4,
        ZIndex = 1,
        Transparency = 1
    })
    --
    utility.Cursor.Lines[Index] = line
    utility.Cursor.Outlines[Index] = line_outline
end
--
local Middle = Lynx:newDrawing("Square",{
    Visible = true,
    Size = v2(2, 2),
    Color = White,
    Filled = true,
    ZIndex = 1000,
    Transparency = 1
})
--
local MiddleOutline = Lynx:newDrawing("Square",{
    Visible = true,
    Size = v2(4, 4),
    Color = rgb(0, 0, 0),
    Filled = true,
    ZIndex = 999,
    Transparency = 1
})
-- 
if not LPH_OBFUSCATED then 
    LPH_JIT_MAX = function(...) return (...) end;
    LPH_NO_VIRTUALIZE = function(...) return (...) end;
end
-- Pages
local Window = library:New({Name = "Lynx - Universal", Style = 1, Pages = 7, Size = Vector2.new(554, 629)})
--
local Page1 = Window:Page({Name = "Legit"})
local Page2 = Window:Page({Name = "Rage"})
local Page3 = Window:Page({Name = "Renders"})
local Page4 = Window:Page({Name = "Visuals"})
local Page5 = Window:Page({Name = "Misc"})
local Page6 = Window:Page({Name = "Settings"})
local Page7 = Window:Page({Name = "Config"})
--
local Aimbot_Section = Page1:Section({Name = "Aimbot", Fill = true, Side = "Left"})
local ESP_Section = Page3:Section({Name = "ESP", Fill = false, Side = "Left"})
local ESP_Settings = Page3:Section({Name = "ESP Settings", Fill = true, Side = "Left"})
local Lighting_Modulation = Page4:Section({Name = "Lighting Modulation", Fill = false, Side = "Left"})
local Camera_Modulation = Page4:Section({Name = "Camera Modulation", Fill = true, Side = "Left"})
local Cursor_Section = Page4:Section({Name = "Cursor", Fill = true, Side = "Right"})
local Playerlist = Page6:PlayerList({Side = "Left"})
--
local SettingsPage = library:CreateSettings(Page7, Window)
local Notifications = Window:NotificationList({})
-- Aimbot 
do
    Aimbot_Section:Toggle({Name = "Enabled", pointer = "aimbot_enabled"})
    --
    pointers["aimbot_enabled"]:Keybind({pointer = "aimbot_key", name = "Aimbot", mode = "Toggle", default = Enum.KeyCode.V, callback = function(Key)
        if Key and pointers["aimbot_enabled"]:Get() then 
            utility["Target"] = Lynx:GetClosestPlayer()
            print(utility["Target"])
        end 
    end})
    -- 
    Aimbot_Section:Multibox({pointer = "aimbot_part", name = "Hit-Part", default = {"Torso"}, options = {"Head", "Torso", "Arms", "Legs"}})
    -- 
    Aimbot_Section:Slider({Name = "Smoothness", pointer = "aimbot_smoothness", Default = 1.0, Maximum = 100.0, Minimum = 0.1, Decimals = 0.1, Ending = "%"})    
    -- 
    Aimbot_Section:Multibox({pointer = "aimbot_checks", name = "Checks", default = {""}, options = {"Wall", "Team", "Visible", "Alive", "ForceField"}})
    -- 
    Aimbot_Section:Slider({Name = "Distance", pointer = "aimbot_distance", Default = 10000, Maximum = 10000, Minimum = 10, Decimals = 10, Ending = "st"})  
    --  
    Aimbot_Section:Dropdown({pointer = "aimbot_raycast_origin", name = "Origin", default = "Camera", options = {"Head", "Torso", "Camera"}})
    --
    Aimbot_Section:Toggle({Name = "Prediction", pointer = "aimbot_prediction"})
    -- 
    Aimbot_Section:Textbox({pointer = "aimbot_prediction_amount", placeholder = "Prediction...", text = "", middle = false, reset_on_focus = false})
end
-- ESP Customization
do 
    ESP_Section:Toggle({Name = "Enabled", pointer = "esp_enabled", callback = function(v)
        Window.VisualPreview:SetComponentSelfProperty("Box", 'Box', 'Visible', v)
        Window.VisualPreview:SetComponentSelfProperty("Box", 'Outline', 'Visible', v)
        Settings.Enabled = v 
    end})
    --
    ESP_Section:Toggle({Name = "Bounding Box", pointer = "box_enabled", callback = function(v)
        Window.VisualPreview:SetComponentSelfProperty("Box", 'Box', 'Visible', v)
        Window.VisualPreview:SetComponentSelfProperty("Box", 'Outline', 'Visible', v)
        Settings.Box[1] = v 
    end})
    -- 
    ESP_Section:Dropdown({pointer = "box_type", name = "Type", default = "Corner", options = {"Corner", "Box"}, callback = function(Option)
        Settings.Box[2] = Option 
    end})
    -- 
    pointers['box_enabled']:Colorpicker({pointer = "box_color",name = "Box Color", callback = function(v)
        Window.VisualPreview:SetComponentSelfProperty("Box", 'Box', 'Color', v)
        Settings.Box[3] = v 
    end})
    -- 
    pointers['box_enabled']:Colorpicker({pointer = "box_color2",name = "Box Outline Color",default = Color3.fromRGB(0,0,0), callback = function(v)
        Window.VisualPreview:SetComponentSelfProperty("Box", 'Outline', 'Color', v)
        Settings.Box[4] = v 
    end})
    -- 
    ESP_Section:Toggle({Name = "Title", pointer = "title_enabled", callback = function(v)
        Window.VisualPreview:SetComponentSelfProperty("Title", 'Text', 'Visible', v)
        Settings["Name"][1] = v
    end})
    -- 
    pointers['title_enabled']:Colorpicker({pointer = "title_color",name = "Title Color", callback = function(v)
        Window.VisualPreview:SetComponentSelfProperty("Title", 'Text', 'Color', v)
        Settings["Name"][2] = v
    end})
    -- 
    ESP_Section:Toggle({Name = "Distance", pointer = "distance_enabled", callback = function(v)
        Window.VisualPreview:SetComponentSelfProperty("Distance", 'Text', 'Visible', v)
        Settings["Distance"][1] = v
    end})
    -- 
    pointers['distance_enabled']:Colorpicker({pointer = "distance_color",name = "Distnace Color", callback = function(v)
        Window.VisualPreview:SetComponentSelfProperty("Distance", 'Text', 'Color', v)
        Settings["Distance"][2] = v
    end})
    -- 
    ESP_Section:Toggle({Name = "Weapon", pointer = "weapon_enabled", callback = function(v)
        Window.VisualPreview:SetComponentSelfProperty("Tool", 'Text', 'Visible', v)
        Settings["Weapon"][1] = v
    end})
    -- 
    pointers['weapon_enabled']:Colorpicker({pointer = "tool_color",name = "Tool Color", callback = function(v)
        Window.VisualPreview:SetComponentSelfProperty("Tool", 'Text', 'Color', v)
        Settings["Weapon"][2] = v
    end})
    -- 
    ESP_Section:Toggle({Name = "Flags", pointer = "flags_enabled", callback = function(v)
        Window.VisualPreview:SetComponentSelfProperty("Flags", 'Text', 'Visible', v)
        Settings["Flag"][1] = v
    end})
    -- 
    pointers['flags_enabled']:Colorpicker({pointer = "flag_color",name = "Flag Color", callback = function(v)
        Window.VisualPreview:SetComponentSelfProperty("Flags", 'Text', 'Color', v)
        Settings["Flag"][2] = v
    end})
    -- 
    ESP_Section:Toggle({Name = "Health Bar", pointer = "healthbar_enabled", callback = function(v)
        Window.VisualPreview:SetComponentSelfProperty("HealthBar", 'Box', 'Visible', v)
        Window.VisualPreview:SetComponentSelfProperty("HealthBar", 'Outline', 'Visible', v)
        Settings["HealthBar"][1] = v
    end})
    -- 
    pointers['healthbar_enabled']:Colorpicker({pointer = "healthbar_1",name = "Health Bar", callback = function(v)
        Window.VisualPreview:SetComponentSelfProperty("HealthBar", 'Box', 'Visible', v)
        Window.VisualPreview:SetComponentSelfProperty("HealthBar", 'Outline', 'Visible', v)
        Settings["HealthBar"][1] = v
    end})
    -- 
    pointers['healthbar_enabled']:Colorpicker({pointer = "healthbar_2",name = "Health Outline Bar", callback = function(v)
        Window.VisualPreview:SetComponentSelfProperty("HealthBar", 'Box', 'Visible', v)
        Window.VisualPreview:SetComponentSelfProperty("HealthBar", 'Outline', 'Visible', v)
        Settings["HealthBar"][1] = v
    end})
    -- 
    ESP_Section:Toggle({Name = "Health Text", pointer = "healthtext_enabled", callback = function(v)
        Window.VisualPreview:SetComponentSelfProperty("HealthBar", 'Value', 'Visible', v)
        Settings["HealthNumber"][1] = v
    end})
    -- 
    ESP_Section:Toggle({Name = "Boxfill", pointer = "boxfill_enabled", callback = function(v)
        Window.VisualPreview:SetComponentSelfProperty("Box", 'Fill', 'Visible', v)
        Settings["BoxFill"][1] = v
    end})
    -- 
    pointers['boxfill_enabled']:Colorpicker({pointer = "boxfill_color",name = "Box Fill Color", callback = function(v)
        Settings["BoxFill"][2] = v
    end})
    -- 
    ESP_Section:Slider({Name = "Box Fill Transparency", pointer = "box_fill_transparency", Default = 0.2, Maximum = 1, Minimum = 0, Decimals = 0.1, Ending = "%", callback = function(v)
        Settings["BoxFill"][3] = v
    end})
    -- 
    Window.VisualPreview:SetComponentSelfProperty("HealthBar", 'Value', 'Visible', false)
    Window.VisualPreview:SetComponentSelfProperty("HealthBar", 'Box', 'Visible', false)
    Window.VisualPreview:SetComponentSelfProperty("HealthBar", 'Outline', 'Visible', false)
    Window.VisualPreview:SetComponentSelfProperty("Box", 'Box', 'Visible', false)
    Window.VisualPreview:SetComponentSelfProperty("Box", 'Outline', 'Visible', false)
    Window.VisualPreview:SetComponentSelfProperty("Title", 'Text', 'Visible', false)
    Window.VisualPreview:SetComponentSelfProperty("Distance", 'Text', 'Visible', false)
    Window.VisualPreview:SetComponentSelfProperty("Tool", 'Text', 'Visible', false)
    Window.VisualPreview:SetComponentSelfProperty("Flags", 'Text', 'Visible', false)
    Window.VisualPreview:SetComponentSelfProperty("Box", 'Fill', 'Visible',false)
    --
    for i, _ in pairs(Window.VisualPreview.Components.Skeleton) do
        Window.VisualPreview:SetComponentSelfProperty('Skeleton', i , 'Visible', false,1)
        Window.VisualPreview:SetComponentSelfProperty('Skeleton', i , 'Visible', false,2)
    end
    --
    for i, _ in pairs(Window.VisualPreview.Components.Chams) do
        Window.VisualPreview:SetComponentSelfProperty('Chams', i , 'Visible', false,1)
        Window.VisualPreview:SetComponentSelfProperty('Chams', i , 'Visible', false,2)
    end
end 
-- ESP Settings 
do 
    ESP_Settings:Slider({Name = "Max Distance", pointer = "max_distance", Default = 750, Maximum = 7500, Minimum = 0, Decimals = 10, Ending = "st", callback = function(v)
        Settings["MaxDistance"] = v
    end})
    -- 
    ESP_Settings:Slider({Name = "Fade Time", pointer = "fade_time", Default = 2.0, Maximum = 10.0, Minimum = 0.1, Decimals = 0.1, Ending = "s", callback = function(v)
        Settings["FadeTime"] = v
    end})
    -- 
    ESP_Settings:Dropdown({pointer = "text_case", name = "Text Case", default = "Normal", options = {"Normal", "UPPERCASE", "lowercase"}, callback = function(Option)
        Settings.TextCase = Option 
    end})
    -- 
    ESP_Settings:Slider({Name = "Text Length", pointer = "text_length", Default = 20, Maximum = 20, Minimum = 3, Decimals = 1, Ending = "", callback = function(v)
        Settings["TextLength"] = v
    end})
end 
-- World Visuals
do 
    Lighting_Modulation:Toggle({Name = "Ambient", pointer = "lighting_ambient"})
    --
    pointers['lighting_ambient']:Colorpicker({pointer = "lighting_ambient1",name = "Ambient"})
    --
    pointers['lighting_ambient']:Colorpicker({pointer = "lighting_ambient2",name = "Ambient"})
    --
    Lighting_Modulation:Toggle({Name = "Ambient Color Shift", pointer = "lighting_ambientcolorshift"})
    --
    pointers['lighting_ambientcolorshift']:Colorpicker({pointer = "lighting_ambientcolorshift1",name = "Ambient Color Shift"})
    --
    pointers['lighting_ambientcolorshift']:Colorpicker({pointer = "lighting_ambientcolorshift2",name = "Ambient Color Shift"})
    --
    Lighting_Modulation:Toggle({Name = "Brightness", pointer = "lighting_brightness"})
    --
    Lighting_Modulation:Slider({Name = "Brightness Amount", pointer = "lighting_brightness_slider", Default = 0, Maximum = 25, Minimum = 1, Decimals = 1, Ending = ""})
    --
    Lighting_Modulation:Toggle({Name = "Clock Time", pointer = "lighting_clocktime"})
    --
    Lighting_Modulation:Slider({Name = "Clock Time Amount", pointer = "lighting_clocktime_slider", Default = 0, Maximum = 24, Minimum = 1, Decimals = 1, Ending = "hr"})
    --
    Lighting_Modulation:Toggle({Name = "Exposure", pointer = "lighting_exposure"})
    --
    Lighting_Modulation:Slider({Name = "Exposure Amount", pointer = "lighting_exposure_slider", Default = 0, Maximum = 3, Minimum = 1, Decimals = 1, Ending = ""})
    --
    Lighting_Modulation:Toggle({Name = "Fog", pointer = "lighting_fog"})
    --
    pointers['lighting_fog']:Colorpicker({pointer = "lighting_fog1",name = "Fog"})
    --
    pointers['lighting_fog']:Colorpicker({pointer = "lighting_fog2",name = "Fog"})
    --
    Lighting_Modulation:Slider({Name = "Fog End", pointer = "lighting_fog_end", Default = 0, Maximum = 5000, Minimum = 1, Decimals = 1, Ending = ""})
    --
    Lighting_Modulation:Slider({Name = "Fog Start", pointer = "lighting_fog_start", Default = 0, Maximum = 5000, Minimum = 1, Decimals = 1, Ending = ""})
end 
-- Camera Visuals
do 
    Camera_Modulation:Toggle({Name = "Aspect Ratio", pointer = "compress_screen"})
    --
    Camera_Modulation:Slider({Name = "Compress Vertically", pointer = "compress_vertically", Default = 100, Maximum = 100, Minimum = 1, Decimals = 1, Ending = "%"})
    --
    Camera_Modulation:Slider({Name = "Compress Horizontally", pointer = "compress_horizontally", Default = 100, Maximum = 100, Minimum = 1, Decimals = 1, Ending = "%"})
    --
    Camera_Modulation:Toggle({Name = "Extended Field Of View", pointer = "express_camera"})
    --
    Camera_Modulation:Slider({Name = "Amount", pointer = "express_fov", Default = 100, Maximum = 100, Minimum = 1, Decimals = 1, Ending = "%"})
end 
-- Spinning Cursor
do 
    Cursor_Section:Toggle({Name = "Enabled", pointer = "cursor", callback = function(Bool)
        for _, Line in next, utility.Cursor.Lines do 
            Line.Visible = Bool
        end 
        -- 
        for _, Outline in next, utility.Cursor.Outlines do 
            Outline.Visible = Bool
        end 
        --
        InputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceShow
    end})
    --
    pointers['cursor']:Colorpicker({pointer = "cursor_color",name = "Cursor Color", callback = function()
        for i,v in next, utility.Cursor.Lines do 
            v.Color = pointers["cursor_color"]:Get()
        end 
    end})
    -- 
    Cursor_Section:Toggle({Name = "Dot", pointer = "dot", callback = function(Bool)
        Middle.Visible = Bool 
        MiddleOutline.Visible = Bool 
    end})
    --
    pointers['dot']:Colorpicker({pointer = "dot_color",name = "Cursor Color", callback = function(Color)
        Middle.Color = Color
    end})
    --
    Cursor_Section:Slider({Name = "Gap", pointer = "cursor_gap", Default = 0, Maximum = 100, Minimum = 1, Decimals = 1, Ending = "%"})
    --
    Cursor_Section:Slider({Name = "Radius", pointer = "cursor_radius", Default = 16, Maximum = 100, Minimum = 1, Decimals = 1})
    --
    Cursor_Section:Slider({Name = "Thickness", pointer = "cursor_thickness", Default = 1, Maximum = 5, Minimum = 0.50, Decimals = 0.01, callback = function(int)
        for i,v in next, utility.Cursor.Outlines do 
            v.Thickness = int + 2
        end 
        --
        for i,v in next, utility.Cursor.Lines do 
            v.Thickness = int
        end 
    end})
    --
    Cursor_Section:Toggle({Name = "Spin", pointer = "cursor_spin"})
    --
    Cursor_Section:Slider({Name = "Speed", pointer = "cursor_spin_speed", Default = 90.0, Maximum = 360, Minimum = 0.1, Decimals = 0.1})
    --
    Cursor_Section:Toggle({Name = "Gap Tween", pointer = "tween_gap"})
    -- 
    Cursor_Section:Slider({Name = "Speed", pointer = "gap_tween_spin_speed", Default = 1.25, Maximum = 5.00, Minimum = 0.10, Decimals = 0.01})
end 
-- 
utility["Connections"]["Input"] = InputService.InputChanged:Connect(function(input, typing)
    if pointers["cursor"]:Get() then 
        if not pointers["cursor_spin"]:Get() then 
            InputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide
            --
            if pointers['dot']:Get() then 
                Middle.Position = v2(Mouse.X - 1, Mouse.Y + 36 - 1)
                MiddleOutline.Position = v2(Mouse.X - 2, Mouse.Y + 36 - 2)
            end 
            -- 
            utility.Cursor.Lines[1].From = v2(Mouse.X + pointers["cursor_gap"]:Get() * 5, Mouse.Y + 36)
            utility.Cursor.Lines[1].To = v2(Mouse.X + pointers["cursor_radius"]:Get() * 5, Mouse.Y + 36)
            utility.Cursor.Outlines[1].From = v2(Mouse.X + pointers["cursor_gap"]:Get() * 5, Mouse.Y + 36)
            utility.Cursor.Outlines[1].To = v2(Mouse.X + pointers["cursor_radius"]:Get() * 5, Mouse.Y + 36)
            --
            utility.Cursor.Lines[2].From = v2(Mouse.X - pointers["cursor_gap"]:Get() * 5, Mouse.Y + 36)
            utility.Cursor.Lines[2].To = v2(Mouse.X - pointers["cursor_radius"]:Get() * 5, Mouse.Y + 36)
            utility.Cursor.Outlines[2].From = v2(Mouse.X - pointers["cursor_gap"]:Get() * 5, Mouse.Y + 36)
            utility.Cursor.Outlines[2].To = v2(Mouse.X - pointers["cursor_radius"]:Get() * 5, Mouse.Y + 36)
            --
            utility.Cursor.Lines[3].From = v2(Mouse.X, Mouse.Y - pointers["cursor_gap"]:Get() * 5 + 36)
            utility.Cursor.Lines[3].To = v2(Mouse.X, Mouse.Y - pointers["cursor_radius"]:Get() * 5 + 36)
            utility.Cursor.Outlines[3].From = v2(Mouse.X, Mouse.Y - pointers["cursor_gap"]:Get() * 5 + 36)
            utility.Cursor.Outlines[3].To = v2(Mouse.X, Mouse.Y - pointers["cursor_radius"]:Get() * 5 + 36)
            --
            utility.Cursor.Lines[4].From = v2(Mouse.X, Mouse.Y + pointers["cursor_gap"]:Get() * 5 + 36)
            utility.Cursor.Lines[4].To = v2(Mouse.X, Mouse.Y + pointers["cursor_radius"]:Get() * 5 + 36)
            utility.Cursor.Outlines[4].From = v2(Mouse.X, Mouse.Y + pointers["cursor_gap"]:Get() * 5 + 36)
            utility.Cursor.Outlines[4].To = v2(Mouse.X, Mouse.Y + pointers["cursor_radius"]:Get() * 5 + 36)
        end 
    end
end)
--
Lynx:Connection(RunService.RenderStepped, LPH_NO_VIRTUALIZE(function(Frame)
    -- Spinning Cursor
    if pointers["cursor"]:Get() and pointers["cursor_spin"]:Get() then 
        InputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide
        --
        local MousePosition = v2(Mouse.X, Mouse.Y + 36)
        -- 
        local SpinSize = pointers["tween_gap"]:Get() and (Abs(Sin(tick() * pointers["gap_tween_spin_speed"]:Get())) * pointers["cursor_gap"]:Get() / 4) + (pointers['dot']:Get() and 5 or 1) or pointers["cursor_gap"]:Get() / 4
        local SpinSpeed = pointers["cursor_spin_speed"]:Get() / 5
        local Radius = pointers["cursor_radius"]:Get() / 4
        -- 
        SpinAngle = SpinAngle + Rad((SpinSpeed * 10) * Frame);
        -- 
        if pointers['dot']:Get() then 
            Middle.Position = v2(MousePosition.X - 1, MousePosition.Y - 1)
            MiddleOutline.Position = v2(MousePosition.X - 2, MousePosition.Y - 2)
        end 
        --
        do -- // Inlines
            utility.Cursor.Lines[1].From = (MousePosition + (v2(Cos(SpinAngle), Sin(SpinAngle))* (SpinSize + 1)))
            utility.Cursor.Lines[1].To = (utility.Cursor.Lines[1].From + (v2(Cos(SpinAngle), Sin(SpinAngle)) * (Radius * 5)))
            --
            utility.Cursor.Lines[2].From = (MousePosition + (v2(Cos(SpinAngle + Pi), Sin(SpinAngle + Pi))* (SpinSize + 1)))
            utility.Cursor.Lines[2].To = (utility.Cursor.Lines[2].From + (v2(Cos(SpinAngle + Pi), Sin(SpinAngle + Pi)) * (Radius * 5)))
            --
            utility.Cursor.Lines[3].From = (MousePosition + (v2(Cos(SpinAngle + Halfpi), Sin(SpinAngle + Halfpi))* (SpinSize + 1)))
            utility.Cursor.Lines[3].To = (utility.Cursor.Lines[3].From + (v2(Cos(SpinAngle + Halfpi), Sin(SpinAngle + Halfpi)) * (Radius * 5)))
            --
            utility.Cursor.Lines[4].From = (MousePosition + (v2(Cos(SpinAngle + Halfpi * 3), Sin(SpinAngle + Halfpi * 3)) * (SpinSize + 1)))
            utility.Cursor.Lines[4].To = (utility.Cursor.Lines[4].From + (v2(Cos(SpinAngle + Halfpi * 3), Sin(SpinAngle + Halfpi * 3)) * (Radius * 5)))
        end
        --
        do -- // Outlines 
            utility.Cursor.Outlines[1].From = (MousePosition + (v2(Cos(SpinAngle), Sin(SpinAngle)) * (SpinSize + 1)))
            utility.Cursor.Outlines[1].To = (utility.Cursor.Outlines[1].From + (v2(Cos(SpinAngle), Sin(SpinAngle)) * ((Radius * 5) + 0.05)))
            --
            utility.Cursor.Outlines[2].From = (MousePosition + (v2(Cos(SpinAngle + Pi), Sin(SpinAngle + Pi))* (SpinSize + 1)))
            utility.Cursor.Outlines[2].To = (utility.Cursor.Outlines[2].From + (v2(Cos(SpinAngle + Pi), Sin(SpinAngle + Pi)) * ((Radius * 5) + 0.05)))
            --
            utility.Cursor.Outlines[3].From = (MousePosition + (v2(Cos(SpinAngle + Halfpi), Sin(SpinAngle + Halfpi))* (SpinSize + 1)))
            utility.Cursor.Outlines[3].To = (utility.Cursor.Outlines[3].From + (v2(Cos(SpinAngle + Halfpi), Sin(SpinAngle + Halfpi)) * ((Radius * 5) + 0.05)))
            --
            utility.Cursor.Outlines[4].From = (MousePosition + (v2(Cos(SpinAngle + Halfpi * 3), Sin(SpinAngle + Halfpi * 3)) * (SpinSize + 1)))
            utility.Cursor.Outlines[4].To = (utility.Cursor.Outlines[4].From + (v2(Cos(SpinAngle + Halfpi * 3), Sin(SpinAngle + Halfpi * 3)) * ((Radius * 5) + 0.05)))
        end
    end     
    -- Aspect Ratio Stuff
    if pointers['compress_screen']:Get() then 
        local X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = Camera.CFrame:GetComponents()
        Camera.CFrame = CFrame.new(X, Y, Z, R00, R01 * pointers['compress_vertically']:Get()/100, R02, R10, R11 * pointers['compress_vertically']:Get()/100, R12, R20, R21 * pointers['compress_vertically']:Get()/100, R22)
    end 
    --
    if pointers['compress_screen']:Get() then 
        local X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = Camera.CFrame:GetComponents()
        Camera.CFrame = CFrame.new(X, Y, Z, R00  * pointers['compress_horizontally']:Get()/100, R01, R02, R10, R11, R12, R20 * pointers['compress_horizontally']:Get()/100, R21, R22)
    end 
    --
    if pointers['express_camera']:Get() then 
        local X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = Camera.CFrame:GetComponents()
        Camera.CFrame = CFrame.new(X, Y, Z, R00  * pointers['express_fov']:Get()/100, R01 * pointers['express_fov']:Get()/100, R02, R10, R11 * pointers['express_fov']:Get()/100, R12, R20  * pointers['express_fov']:Get()/100, R21 * pointers['express_fov']:Get()/100, R22)
    end 
    --
    if pointers["aimbot_enabled"]:Get() and pointers["aimbot_key"]:Is_Active() and Lynx:GetPlayerStatus(utility["Target"]) then 
        -- Define Target
        local Char, Humanoid, RootPart = Lynx:ValidateClient(utility["Target"])
        if Char and Humanoid and RootPart then 
            local Parts = Lynx:GetBodyParts(Char, RootPart, false, pointers["aimbot_part"]:Get())
            local HitPart = Lynx:GetClosestPart(utility["Target"], Parts).Name
            -- Check Toggles
            local WallCheck = (Find(pointers["aimbot_checks"]:Get(), "Wall"))
            local Visible = (Find(pointers["aimbot_checks"]:Get(), "Visible"))
            local Alive = (Find(pointers["aimbot_checks"]:Get(), "Alive"))
            local Team = (Find(pointers["aimbot_checks"]:Get(), "Team"))
            -- Checks
            if (WallCheck and not Lynx:RayCast(Char[HitPart], Lynx:GetOrigin(pointers["aimbot_raycast_origin"]:Get()), {Lynx:GetCharacter(LocalPlayer), Lynx:GetIgnore(true)})) then return end
            if (Visible and not (RootPart.Transparency ~= 1)) then return end 
            if (Alive and not Lynx:ClientAlive(utility["Target"], Char, Humanoid)) then return end
            if (Team and not (Lynx:CheckTeam(LocalPlayer, utility["Target"]))) then return end
            if (not ((Camera.CFrame.Position - RootPart.Position).Magnitude <= pointers["aimbot_distance"]:Get())) then return end
            

            -- Calculating Position
            local EndPoint = CFrame.new(Camera.CFrame.p, Char[HitPart].Position + (pointers["aimbot_prediction"]:Get() and (Char.HumanoidRootPart.Velocity * pointers["aimbot_prediction_amount"]:Get())) or Vector3.new(0, 0, 0))
            Camera.CFrame = Camera.CFrame:Lerp(EndPoint, (100 - pointers["aimbot_smoothness"]:Get()) / 100)
        end
    end 
end))
-- ESP Preview Healthbar
spawn(LPH_NO_VIRTUALIZE(function()
    while task.wait(0.02) do
        Window.VisualPreview:UpdateHealthBar()
    end
end))
--
Window.notificationlist:SortNotifications()
Window:Initialize()
