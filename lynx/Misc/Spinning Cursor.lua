getgenv().utility = {Cursor = {Lines = {}, Outlines = {}}}
local Tween = loadfile("lynx/Utility/TweenModule.lua")();
local Functions = loadfile("lynx/Utility/Functions.lua")();
local rs = game:GetService("RunService")
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
local floor, rad, sin, abs, cos, pi, tan, halfpi, random = math.floor, math.rad, math.sin, math.abs, math.cos, math.pi, math.tan, math.pi/2, math.random
local Round = math.round
local NewVector2 = Vector2.new
--[[ 
  Hello - Finobe / 16/07/23
]]

local Cursor = {
    Speed = 15,
    Radius = 4, 
    Color = Color3.fromHex("#1A66FF"),
    Thickness = 3,
    Gap = 35,
    Sine = true, 
    SineSpeed = 1.25,
    Animation = "Sine",
    Lines = {},
    Outlines = {}
}
--
for Index = 1, 4 do
    local line = Lynx:newDrawing("Line",{
        Visible =  true,
        Color = Cursor.Color,
        Thickness = Cursor.Thickness,
        ZIndex = 2,
        Transparency = 1
    })
    --
    local line_outline = Lynx:newDrawing("Line",{
        Visible =  true,
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = Cursor.Thickness + 1.5,
        ZIndex = 1,
        Transparency = 1
    })
    --
    Cursor.Lines[Index] = line
    Cursor.Outlines[Index] = line_outline
end
--
local SpinAngle = 0 
local SpinSize = Cursor.Gap
--
local Loop = rs.RenderStepped:Connect(function(Frame)
    local MousePosition = NewVector2(Mouse.X, Mouse.Y + 36)
    --
    if Cursor.Sine then 
        Spin = abs(sin(tick() * Cursor.SineSpeed))
        SpinSize = Tween["Enum.EasingStyle.Sine"].InOut(Spin) * 16
        SpinSpeed = Tween["Enum.EasingStyle.Sine"].InOut(Spin) * 60
        Radius = Tween["Enum.EasingStyle.Sine"].InOut(Spin) * 16
    else 
        Radius = Cursor.Radius
        SpinSize = Cursor.Gap
    end
    --
    SpinAngle = SpinAngle + math.rad((SpinSpeed * 10) * Frame);
    --
    do -- // Inlines
        Cursor.Lines[1].Visible = true
        Cursor.Lines[1].From = (MousePosition + (NewVector2(cos(SpinAngle), sin(SpinAngle))* (SpinSize + 1)))
        Cursor.Lines[1].To = (Cursor.Lines[1].From + (NewVector2(cos(SpinAngle), sin(SpinAngle)) * (Radius * 5)))
        --
        Cursor.Lines[2].Visible = true
        Cursor.Lines[2].From = (MousePosition + (NewVector2(cos(SpinAngle + pi), sin(SpinAngle + pi))* (SpinSize + 1)))
        Cursor.Lines[2].To = (Cursor.Lines[2].From + (NewVector2(cos(SpinAngle + pi), sin(SpinAngle + pi)) * (Radius * 5)))
        --
        Cursor.Lines[3].Visible = true
        Cursor.Lines[3].From = (MousePosition + (NewVector2(cos(SpinAngle + halfpi), sin(SpinAngle + halfpi))* (SpinSize + 1)))
        Cursor.Lines[3].To = (Cursor.Lines[3].From + (NewVector2(cos(SpinAngle + halfpi), sin(SpinAngle + halfpi)) * (Radius * 5)))
        --
        Cursor.Lines[4].Visible = true
        Cursor.Lines[4].From = (MousePosition + (NewVector2(cos(SpinAngle + halfpi * 3), sin(SpinAngle + halfpi * 3)) * (SpinSize + 1)))
        Cursor.Lines[4].To = (Cursor.Lines[4].From + (NewVector2(cos(SpinAngle + halfpi * 3), sin(SpinAngle + halfpi * 3)) * (Radius * 5)))
    end
    --
    do -- // Outlines
        Cursor.Outlines[1].Visible = true
        Cursor.Outlines[1].From = (MousePosition + (NewVector2(cos(SpinAngle), sin(SpinAngle))* (SpinSize + 1)))
        Cursor.Outlines[1].To = (Cursor.Outlines[1].From + (NewVector2(cos(SpinAngle), sin(SpinAngle)) * (Radius * 5)))
        --
        Cursor.Outlines[2].Visible = true
        Cursor.Outlines[2].From = (MousePosition + (NewVector2(cos(SpinAngle + pi), sin(SpinAngle + pi))* (SpinSize + 1)))
        Cursor.Outlines[2].To = (Cursor.Outlines[2].From + (NewVector2(cos(SpinAngle + pi), sin(SpinAngle + pi)) * (Radius * 5)))
        --
        Cursor.Outlines[3].Visible = true
        Cursor.Outlines[3].From = (MousePosition + (NewVector2(cos(SpinAngle + halfpi), sin(SpinAngle + halfpi))* (SpinSize + 1)))
        Cursor.Outlines[3].To = (Cursor.Outlines[3].From + (NewVector2(cos(SpinAngle + halfpi), sin(SpinAngle + halfpi)) * (Radius * 5)))
        --
        Cursor.Outlines[4].Visible = true
        Cursor.Outlines[4].From = (MousePosition + (NewVector2(cos(SpinAngle + halfpi * 3), sin(SpinAngle + halfpi * 3)) * (SpinSize + 1)))
        Cursor.Outlines[4].To = (Cursor.Outlines[4].From + (NewVector2(cos(SpinAngle + halfpi * 3), sin(SpinAngle + halfpi * 3)) * (Radius * 5)))
    end
end)
--
task.wait(5)
--
for i,v in pairs(Cursor.Lines) do
    v:Remove()
end 
--
for i,v in pairs(Cursor.Outlines) do
    v:Remove()
end 
--
Loop:Disconnect()