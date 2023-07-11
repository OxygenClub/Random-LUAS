local UIS                   = game:GetService("UserInputService")
local Tween                 = game:GetService("TweenService")
local Run                   = game:GetService("RunService")
local Lighting              = game:GetService("Lighting")
local ReplicatedStorage     = game:GetService("ReplicatedStorage")
local LocalPlayer           = game.Players.LocalPlayer 
local Camera                = game.Workspace.CurrentCamera
local floor,rad,sin,abs     = math.floor,math.rad,math.sin,math.abs
local Players               = game.Players
local mouse                 = LocalPlayer:GetMouse() 
local CC                    = game.Workspace.CurrentCamera
local LocalMouse = game.Players.LocalPlayer:GetMouse()

getgenv().client = {
    connections = {
    } 
}

local PlayerDrawings = {}
local Utility        = {}
Utility.Settings = {
    Line = {
        Thickness = 1,
        Color = Color3.fromRGB(0, 255, 0)
    },
    Text = {
    
        Size = 13,
        Center = true,
        Outline = true,
        Font = Drawing.Fonts.Plex,
        Color = Color3.fromRGB(255, 255, 255)
    
    },
    Square = {
        Thickness = 1,
        Color = Color3.fromRGB(255, 255, 255),
        Filled = false,
    },
    Triangle = {
        Color = Color3.fromRGB(255, 255, 255),
        Filled = true,
        Visible = false,
        Thickness = 1,
    },
}
function Utility.New(Type, Outline, Name, Filled)
    local drawing = Drawing.new(Type)
    for i, v in pairs(Utility.Settings[Type]) do
        drawing[i] = v
    end
    if Outline then
        drawing.Color = Color3.new(0,0,0)
        drawing.Thickness = 3
    end
    if Filled then 
        drawing.Filled = true 
    end 
    return drawing
end



function Utility.Add(Player)
    if not PlayerDrawings[Player] then
        PlayerDrawings[Player] = {
            Name = Utility.New("Text", nil, "Name",false),
            Tool = Utility.New("Text", nil, "Tool",false),
            BoxOutline = Utility.New("Square", true, "BoxOutline",false),
            Box = Utility.New("Square", nil, "Box",false),
            HealthOutline = Utility.New("Line", true, "HealthOutline",false),
            Health = Utility.New("Line", nil, "Health",false),
            HealthText = Utility.New("Text",nil,"HealthText",false),
            Tracers = Utility.New("Line", nil, "Tracers",false),
            BoxFill = Utility.New("Square", nil, "BoxFill",true),
            Distance = Utility.New("Text", nil, "Distance",false),
            ArmorBar = Utility.New("Line", nil, "ArmorBar", false),
            Angle = Utility.New("Line", nil, "Angle", false),
            ArrowOutline = Utility.New("Triangle", false, "ArrowOutline", false),
            Arrow = Utility.New("Triangle", nil, "Arrow", false),
            ArrowDistance = Utility.New("Text", nil, "ArrowDistance", false),
            ArrowHealth = Utility.New("Text", nil, "ArrowHealth", false),
        }
    end
end

function Utility.Misc(Path)
    MiscDrawings[Option] = {
        MiscName = Utility.New("Text", nil, "Name",false),
        MiscDistance = Utility.New("Text", nil, "Distance",false),
    }
end 

for _,Player in pairs(Players:GetPlayers()) do
    if Player ~= LocalPlayer then
        Utility.Add(Player)
    end
end

Players.PlayerAdded:Connect(Utility.Add)
Players.PlayerRemoving:Connect(function(Player)
    if PlayerDrawings[Player] then
        for i,v in pairs(PlayerDrawings[Player]) do
            if v then 
                v:Remove()
            end 
        end 
        PlayerDrawings[Player] = nil
    end
end)

client.connections.esp = Run:BindToRenderStep("ESP", 1, function()
    for _,Player in pairs (game.Players:GetPlayers()) do
        local PlayerDrawing = PlayerDrawings[Player]
        if not PlayerDrawing then continue end

        for _,Drawing in pairs(PlayerDrawing) do
            Drawing.Visible = false
        end

        local Character = Player.Character
        local RootPart, Humanoid, Head = Character and Character:FindFirstChild("HumanoidRootPart"), Character and Character:FindFirstChildOfClass("Humanoid"), Character and Character:FindFirstChild("Head")

        if not Character or not RootPart or not Humanoid then continue end

        local DistanceFromCharacter = (Camera.CFrame.Position - RootPart.Position).Magnitude
        local MaxDistance = library.pointers["settings/menu/esp_maxdistance"]:get() or 25000 
        local Hightlight_Target = false --or pointers and library.pointers["settings/menu/esp_hightlight_target"]:get()

        local Pos, OnScreen = Camera:WorldToViewportPoint(RootPart.Position)
        if MaxDistance < DistanceFromCharacter then continue end 
        if not OnScreen then

            if library.pointers["settings/menu/esp_enabled"]:get() and library.pointers["settings/menu/esp_arrow"]:get() then
                local Arrow = PlayerDrawing.Arrow
                local ArrowDistance = PlayerDrawing.ArrowDistance
                local ArrowOutline = PlayerDrawing.ArrowOutline
                local ArrowHealth = PlayerDrawing.ArrowHealth
                local viewportSize = Camera.ViewportSize

                local screenCenter = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
                local objectSpacePoint = (CFrame.new().PointToObjectSpace(Camera.CFrame, RootPart.Position) * Vector3.new(1, 0, 1)).Unit
                local crossVector = Vector3.new().Cross(objectSpacePoint, Vector3.new(0, 1, 1))
                local rightVector = Vector2.new(crossVector.X, crossVector.Z) 

                local arrowRadius, arrowSize = library.pointers["settings/menu/esp_arrow_position"]:get(), library.pointers["settings/menu/esp_arrow_size"]:get()
                local arrowPosition = screenCenter + Vector2.new(objectSpacePoint.X, objectSpacePoint.Z) * arrowRadius
                local arrowDirection = (arrowPosition - screenCenter).Unit

                local pointA, pointB, pointC = arrowPosition, screenCenter + arrowDirection * (arrowRadius - arrowSize) + rightVector * arrowSize, screenCenter + arrowDirection * (arrowRadius - arrowSize) + -rightVector * arrowSize

                Arrow.PointA = pointA 
                ArrowOutline.PointA = pointA 
                Arrow.PointB = pointB
                ArrowOutline.PointB = pointB 
                Arrow.PointC = pointC 
                ArrowOutline.PointC = pointC 
                Arrow.Color = library.pointers["settings/menu/esp_arrow_color"]:get().Color
                ArrowOutline.Color = library.pointers["settings/menu/esp_arrow_color_outline"]:get().Color


                Arrow.Filled = true
                ArrowOutline.Filled = false

                if library.pointers["settings/menu/esp_arrow_pulse"]:get() then
                    local speed = library.pointers["settings/menu/esp_arrow_pulse_speed"]:get()
                    Arrow.Transparency = (sin(tick() * speed) + 1) / 2
                    ArrowOutline.Transparency = (sin(tick() * speed) + 1) / 2
                else
                    Arrow.Transparency = 1 - library.pointers["settings/menu/esp_arrow_color"]:get().Transparency
                    ArrowOutline.Transparency = 1 - library.pointers["settings/menu/esp_arrow_color_outline"]:get().Transparency
                end

                if table.find(library.pointers["settings/menu/esp_arrow_flag_type"]:get(), "Distance") and library.pointers["settings/menu/esp_arrow"]:get() then
                    ArrowDistance.Visible = true
                    ArrowDistance.Position = pointA + Vector2.new(0,20,0)--screenCenter + Vector2.new(objectSpacePoint.X, objectSpacePoint.Z) * arrowRadius--arrowPosition + Vector2.new(0,15,15)--pointC * 0.98 --screenCenter + Vector2.new(objectSpacePoint.X, objectSpacePoint.Z) * arrowRadius * 0.94;
                    ArrowDistance.Text = ""..floor(DistanceFromCharacter).."m"
                    ArrowDistance.Transparency = Arrow.Transparency
                    ArrowDistance.Color = library.pointers["settings/menu/esp_distance_color"]:get().Color
                    ArrowDistance.Center = false
                end

                if table.find(library.pointers["settings/menu/esp_arrow_flag_type"]:get(), "Health") and library.pointers["settings/menu/esp_arrow"]:get() then
                    ArrowHealth.Visible = true
                    if ArrowDistance.Visible then 
                        ArrowHealth.Position = pointA + Vector2.new(0,30,0)--screenCenter + Vector2.new(objectSpacePoint.X, objectSpacePoint.Z) * arrowRadius--arrowPosition + Vector2.new(0,15,15)--pointC * 0.98 --screenCenter + Vector2.new(objectSpacePoint.X, objectSpacePoint.Z) * arrowRadius * 0.94;
                    else 
                        ArrowHealth.Position = pointA + Vector2.new(0,20,0)
                    end 
                    local health1 = library.pointers["settings/menu/esp_healthbar_color1"]:get().Color
                    local health2 = library.pointers["settings/menu/esp_healthbar_color2"]:get().Color

                    ArrowHealth.Text = ""..floor(Humanoid.Health).."%"
                    ArrowHealth.Transparency = Arrow.Transparency
                    ArrowHealth.Color = health2:Lerp(health1, Humanoid.Health / Humanoid.MaxHealth)
                    ArrowHealth.Center = false
                end

                Arrow.Visible = true
                ArrowOutline.Visible = true
            end
        else
            local Size           = (Camera:WorldToViewportPoint(RootPart.Position - Vector3.new(0, 3, 0)).Y - Camera:WorldToViewportPoint(RootPart.Position + Vector3.new(0, 2.6, 0)).Y) / 2
            local BoxSize        = Vector2.new(floor(Size * 1.5), floor(Size * 1.9))
            local BoxPos         = Vector2.new(floor(Pos.X - Size * 1.5 / 2), floor(Pos.Y - Size * 1.6 / 2))
    
            local Name           = PlayerDrawing.Name
            local Tool           = PlayerDrawing.Tool
            local Box            = PlayerDrawing.Box
            local BoxOutline     = PlayerDrawing.BoxOutline
            local Health         = PlayerDrawing.Health
            local HealthOutline  = PlayerDrawing.HealthOutline
            local HealthText     = PlayerDrawing.HealthText
            local Tracers        = PlayerDrawing.Tracers 
            local BoxFill        = PlayerDrawing.BoxFill 
            local Distance       = PlayerDrawing.Distance
            local Arrow          = PlayerDrawing.Arrow
            local ArrowOutline   = PlayerDrawing.ArrowOutline


            if library.pointers["settings/menu/esp_enabled"]:get() and library.pointers["settings/menu/esp_box"]:get() then

                Box.Size = BoxSize
                Box.Position = BoxPos
                Box.Visible = true
                Box.Color = library.pointers["settings/menu/esp_box_color1"]:get().Color
                Box.Transparency = 1 - library.pointers["settings/menu/esp_box_color1"]:get().Transparency
                BoxOutline.Size = BoxSize
                BoxOutline.Color = library.pointers["settings/menu/esp_box_color2"]:get().Color
                BoxOutline.Transparency = 1 - library.pointers["settings/menu/esp_box_color2"]:get().Transparency
                BoxOutline.Position = BoxPos
                BoxOutline.Visible = true


                if library.pointers["settings/menu/esp_highlight_target"]:get() then 
                    if Player == getgenv().Target then  
                        Box.Color = library.pointers["settings/menu/esp_hightlight_target_color"]:get().Color
                    end 
                end 

            end

            if library.pointers["settings/menu/esp_enabled"]:get() and library.pointers["settings/menu/esp_name"]:get() then

                Name.Text = ""..Player.Name..""
                Name.Position = Vector2.new(BoxSize.X / 2 + BoxPos.X, BoxPos.Y - 16)
                Name.Color = library.pointers["settings/menu/esp_name_color"]:get().Color
                Name.Transparency = 1 - library.pointers["settings/menu/esp_name_color"]:get().Transparency
                Name.Visible = true


                if library.pointers["settings/menu/esp_highlight_target"]:get() then 
                    if Player == getgenv().Target then  
                        Name.Color = library.pointers["settings/menu/esp_hightlight_target_color"]:get().Color
                    end 
                end 

            end
    
            if library.pointers["settings/menu/esp_enabled"]:get() and library.pointers["settings/menu/esp_healthbar"]:get() then

                local health1 = library.pointers["settings/menu/esp_healthbar_color1"]:get().Color
                local health2 = library.pointers["settings/menu/esp_healthbar_color2"]:get().Color
                Health.From = Vector2.new((BoxPos.X - 4), BoxPos.Y + BoxSize.Y)
                Health.To = Vector2.new(Health.From.X, Health.From.Y - (Humanoid.Health / Humanoid.MaxHealth) * BoxSize.Y)
                Health.Color = health2:Lerp(health1, Humanoid.Health / Humanoid.MaxHealth)
                Health.Visible = true
                Health.Transparency = 1 - library.pointers["settings/menu/esp_healthbar_color1"]:get().Transparency

    
                HealthOutline.From = Vector2.new(Health.From.X, BoxPos.Y + BoxSize.Y + 1)
                HealthOutline.To = Vector2.new(Health.From.X, (Health.From.Y - 1 * BoxSize.Y) -1)
                HealthOutline.Visible = true 
                HealthOutline.Transparency = 1 - library.pointers["settings/menu/esp_healthbar_color2"]:get().Transparency

            end
    
            if library.pointers["settings/menu/esp_enabled"]:get() and library.pointers["settings/menu/esp_weapon"]:get() then

                local BottomOffset = BoxSize.Y + BoxPos.Y + 1
                local Equipped = Player.Character:FindFirstChildOfClass("Tool") and Player.Character:FindFirstChildOfClass("Tool").Name or ""
                Tool.Text = ""..Equipped..""
                Tool.Position = Vector2.new(BoxSize.X / 2 + BoxPos.X, BottomOffset)
                Tool.Color = library.pointers["settings/menu/esp_weapon_color"]:get().Color
                Tool.Transparency = 1 - library.pointers["settings/menu/esp_weapon_color"]:get().Transparency
                Tool.Visible = true
                BottomOffset = BottomOffset + 15

                if library.pointers["settings/menu/esp_highlight_target"]:get() then 
                    if Player == getgenv().Target then  
                        Tool.Color = library.pointers["settings/menu/esp_hightlight_target_color"]:get().Color
                    end 
                end 

            end

            if library.pointers["settings/menu/esp_enabled"]:get() and library.pointers["settings/menu/esp_healthtext"]:get() then

                local health1 = library.pointers["settings/menu/esp_healthtext_color1"]:get().Color
                local health2 = library.pointers["settings/menu/esp_healthtext_color2"]:get().Color
                HealthText.Text = "".. floor(Humanoid.Health) .. ""
                HealthText.Color = health2:Lerp(health1, Humanoid.Health / Humanoid.MaxHealth)
                HealthText.Transparency = 1 - library.pointers["settings/menu/esp_healthtext_color1"]:get().Transparency


                HealthText.Visible = true
                local HealthNumberPos = Vector2.new((BoxPos.X + 1), BoxPos.Y + BoxSize.Y)
                HealthText.Position = Vector2.new(HealthNumberPos.X - 18 , HealthNumberPos.Y - (Humanoid.Health / Humanoid.MaxHealth) * BoxSize.Y)

            end 

            if library.pointers["settings/menu/esp_enabled"]:get() and library.pointers["settings/menu/esp_tracer"]:get() then
                local origin = library.pointers["settings/menu/esp_tracer_origin"]:get()

                if origin == "Mouse" then
                    Tracers.From = Vector2.new(mouse.X, mouse.Y + 36)
                elseif origin == "Top" then
                    Tracers.From = Vector2.new(Camera.ViewportSize.X * 0.5, 0)
                else 
                    Tracers.From = Vector2.new(Camera.ViewportSize.X * 0.5, Camera.ViewportSize.Y);
                end
     
                Tracers.To = Vector2.new(Pos.X, Pos.Y)
                Tracers.Color = library.pointers["settings/menu/esp_tracer_color"]:get().Color
                Tracers.Transparency = 1 - library.pointers["settings/menu/esp_tracer_color"]:get().Transparency
                Tracers.Visible = true

                if library.pointers["settings/menu/esp_highlight_target"]:get() then 
                    if Player == getgenv().Target then  
                        Tracers.Color = library.pointers["settings/menu/esp_hightlight_target_color"]:get().Color
                    end 
                end 

            end 

            if library.pointers["settings/menu/esp_enabled"]:get() and library.pointers["settings/menu/esp_boxfill"]:get() then 

                BoxFill.Size = BoxSize - Vector2.new(4.5, 4.5, 0)
                BoxFill.Position = BoxPos + Vector2.new(2.25, 2.25, 0)
                BoxFill.Visible = true
                BoxFill.Color = library.pointers["settings/menu/esp_boxfill_color"]:get().Color
                BoxFill.Transparency = 1 - library.pointers["settings/menu/esp_boxfill_color"]:get().Transparency
                
                if library.pointers["settings/menu/esp_highlight_target"]:get() then 
                    if Player == getgenv().Target then  
                        BoxFill.Color = library.pointers["settings/menu/esp_hightlight_target_color"]:get().Color
                    end 
                end 

            end 

            if library.pointers["settings/menu/esp_enabled"]:get() and library.pointers["settings/menu/esp_distance"]:get() then

                local BottomOffset = BoxSize.Y + BoxPos.Y + 1
                Distance.Text = ""..floor(DistanceFromCharacter).."m"
                if library.pointers["settings/menu/esp_weapon"]:get() and Tool.Text ~= "" then 
                    Distance.Position = Vector2.new(BoxSize.X / 2 + BoxPos.X, BottomOffset + 10)
                else 
                    Distance.Position = Vector2.new(BoxSize.X / 2 + BoxPos.X, BottomOffset)
                end 
                Distance.Color = library.pointers["settings/menu/esp_distance_color"]:get().Color
                Distance.Transparency = 1 - library.pointers["settings/menu/esp_distance_color"]:get().Transparency
                Distance.Visible = true
                BottomOffset = BottomOffset + 15

                if library.pointers["settings/menu/esp_highlight_target"]:get() then 
                    if Player == getgenv().Target then  
                        Distance.Color = library.pointers["settings/menu/esp_hightlight_target_color"]:get().Color
                    end
                end 
            end
        end
    end
end)
