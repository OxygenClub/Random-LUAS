local function DaHood() 
    if not LPH_OBFUSCATED then 
        LPH_JIT_MAX = function(...) return (...) end;
        LPH_NO_VIRTUALIZE = function(...) return (...) end;
    end

    local UIS                                           = game:GetService("UserInputService")
    local TweenService                                  = game:GetService("TweenService")
    local Run                                           = game:GetService("RunService")
    local Lighting                                      = game:GetService("Lighting")
    local ReplicatedStorage                             = game:GetService("ReplicatedStorage")
    local Players                                       = game:GetService("Players")
    local ws                                            = game.Workspace 
    local Camera                                        = ws.CurrentCamera
    local CC                                            = ws.CurrentCamera
    local floor,rad,sin,abs,cos,pi,tan,halfpi,random    = math.floor,math.rad,math.sin,math.abs,math.cos,math.pi,math.tan,math.pi/2,math.random
    local lp                                            = Players.LocalPlayer
    local Mouse                                         = lp:GetMouse() 
    local rgb = Color3.fromRGB
    local v2 = Vector2.new
    local Wanted = lp:WaitForChild("DataFolder").Information.Wanted
    local OldWanted = Wanted.Value
    local Remote = ReplicatedStorage.MainEvent
    getgenv().AimViewer = nil
    Angle = 0 
    SpinAngle = 0
    local GetUpvalue = debug.getupvalue
    local CreateRenderObject = GetUpvalue(Drawing.new, 1)
    local DestroyRenderObject = GetUpvalue(GetUpvalue(Drawing.new, 7).__index, 3)
    local SetRenderProperty = GetUpvalue(GetUpvalue(Drawing.new, 7).__newindex, 4)
    local GetRenderProperty = GetUpvalue(GetUpvalue(Drawing.new, 7).__index, 4)
    local drawingPool = {} 
    local sfxnames = {}
    local ThemeNames = {} 
    local bodyParts = {}
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

    local oldLighting = {
        Ambient = Lighting.Ambient,
        FogColor = Lighting.FogColor,
        FogEnd = Lighting.FogEnd,
        FogStart = Lighting.FogStart,
        Brightness = Lighting.Brightness,
        ShadowSoftness = Lighting.ShadowSoftness,
        ShadowColor = Lighting.ShadowColor,
        ColorShift_Bottom = Lighting.ColorShift_Bottom,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        ColorShift_Top = Lighting.ColorShift_Top,
    }

    local GunBuys = {
        "[Flamethrower] - $25750",
        "[Double-Barrel SG] - $1442",
        "[SMG] - $773",
        "[RPG] - $6180",
        "[P90] - $1030",
        "[Revolver] - $1339",
        "[High-Medium Armor] - $2163",
        "[LMG] - $3863",
        "[Key] - $129" 
    }

    local AmmoBuys = {
        "140 [Flamethrower Ammo] - $1597",
        "18 [Double-Barrel SG Ammo] - $52",
        "80 [SMG Ammo] - $62",
        "[5 [RPG Ammo] - $1030]",
        "120 [P90 Ammo] - $62",
        "12 [Revolver Ammo] - $77",
        "200 [LMG Ammo] - $309",
    }

    local FoodBuys = {
        "[Pizza] - $5",
        "[Taco] - $2",
        "[Chicken] - $7",
        "[Cranberry] - $3",
        "[Popcorn] - $7",
        "[Hamburger] - $5",
        "[HotDog] - $8",
    }

    for i,v in pairs(lp.Character:GetChildren()) do 
        if v:IsA("BasePart") then 
            table.insert(bodyParts,v.Name)
        end 
    end 

    local client = {
        ["shit talk"] = {
            ["Osiris"] = {
                "sorry guys 😭 I pasted stormy 😔",
                "Injecting ChatGPT.Hook!",
                "Blah Blah Blah 😭😭😭😭",
                "Clipped! -🤓",
                "Sorry guys 🥺 Im using 0 prediction resolver😢",
                "farthook ontop!!!!",
                "Osiris 💳💥💳💥💳💥💳💥",
                "Farthook Successfully Injected!",
                "Guys Im using jjsploit!!!",
                "bwootooth dwevice rwaeady to pwear 🤖🤖🤖",
                "Yun is the best script -🤖",
                "Buy the script at gg/osr",
                "🍑👅❓",
                "mafafaka 😡",
                "stormy.solutions is the best da hood script!!!",
                "Bluetooth bullets: Enabled 🤖",
            },
            ["Yun"] = {
                "YUN RUNS YOU"
            },
            ["Specter"] = {
                "specter.lua > u",
                "sonned?",
                "sad life",
                "u shall quit"
            },
            ["Anti Aim"] = {
                "Cant resolve me!? Cant resolve me!? Cant resolve me!? Cant resolve me!? Cant resolve me!?"
            },
            ["Advertisement"] = {
                "OSIRIS THE BEST BUY OSIRIS AT GG/OSR",
                "GOOGOO GAH GAH NO OSIRIS 😭😭"
            },
            ["Scottish"] = {
                "You Grandma Still Wears Shin Pads To Work 🤣🤣",
                "Melon Head",
                "Your Ma Is A Bin Man 🤣🤣",
                "Your Da Sells Osiris 🤣🤣",
                "Even Osiris Is Better Than You XD",
                "Taped You Like I Did To Your Ma",
                "Fore Headed Mong",
                "Such A Fruit",
                "YoUr A BoOt",
                "keep Trying You Jobby",
            }
        },
        ["sfx"] = {
            ["Bameware"] = "3124331820",
            ["Skeet"] = "4753603610",
            ["Bonk"] = "3765689841",
            ["Lazer Beam"] = "130791043",
            ["Windows XP Error"] = "160715357",
            ["TF2 Hitsound"] = "3455144981",
            ["TF2 Critical"] = "296102734",
            ["TF2 Bat"] = "3333907347",
            ['Bow Hit'] = "1053296915",
            ['Bow'] = "3442683707",
            ['OSU'] = "7147454322",
            ['Minecraft Hit'] = "4018616850",
            ['Steve'] = "5869422451",
            ['1nn'] = "7349055654",
            ['Rust'] = "3744371091",
            ["TF2 Pan"] = "3431749479",
            ["Neverlose"] = "8679627751",
            ["Mario"] = "5709456554",
        },
        ["Themes"] = {
            ['Default'] = {
                Accent = Color3.fromRGB(255,22,22),
                lightcontrast = Color3.fromRGB(30,30,30),
                darkcontrast = Color3.fromRGB(25,25,25),
                outline = Color3.fromRGB(0, 0, 0),
                inline = Color3.fromRGB(50, 50, 50),
                textcolor = Color3.fromRGB(255, 255, 255),
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
        },
        ["SkyBoxes"] = {
            ["Normal"] = {600886090,600830446,600831635,600832720,600833862,600835177},
            ["DoomSpire"] = {6050649245,6050664592,6050648475,6050644331,6050649718,6050650083},
            ["CatGirl"] = {444167615,444167615,444167615,444167615,444167615,444167615},
            ["Vibe"] = {1417494402,1417494030,1417494146,1417494253,1417494499,1417494643},
            ["Blue Aurora"] = {12063984,12064107,12064152,12064121,12064115,12064131},
            ["Purple Clouds"] = {151165191,151165214,151165197,151165224,151165206,151165227},
            ["Purple Nebula"] = {159454286,159454299,159454296,159454293,159454300,159454288},
            ["Twighlight"] = {264909758,264908339,264907909,264909420,264908886,264907379},
            ["Vivid Skies"] = {271042310,271042516,271077243,271042556,271042467,271077958},
            ["Purple and Blue"] = {149397684,149397692,149397686,149397697,149397688,149397702},
        },
        ["TracerTextures"] = {
            ["1"] = 7136858729,
            ["2"] = 6333823534,
            ["3"] = 5864341017,
            ["4"] = 446111271,
            ["5"] = 2950987173,
            ["6"] = 7151778302,  
            ["7"] = 11226108137,
            ["8"] = 6511613786
        },
        ["PingPredictionSets"] = {
            p20_30 = 0.115,
            p30_40 = 0.127,
            p40_50 = 0.135,
            p50_60 = 0.165,
            p60_70 = 0.167,
            p70_80 = 0.167,
            p80_90  = 0.178,
            p90_100 = 0.1300,
            p100_110 = 0.1315,
            p110_120 = 0.1344,
            p120_130 = 0.1411,
            p130_140 = 0.1500,
            p140_150 = 0.1555,
            p150_160 = 0.1545,
            p160_170 = 0.1567,
            p170_180 = 0.1672,
            p180_190 = 0.1746,
            p190_200 = 0.1746,
        },
        loaded = false, 
        ["connections"] = {} 
    }


    for i,v in next, client.Themes do 
        table.insert(ThemeNames,i)
    end 

    for i,v in next, client.sfx do 
        table.insert(sfxnames,i)
    end 
    

--// Functions 
    local m_thread = task do
        setreadonly(m_thread, false)
        function m_thread.spawn_loop(p_time, p_callback)
            m_thread.spawn(function()
                while Run.RenderStepped:Wait() do
                    p_callback()
                    m_thread.wait(p_time)
                end
            end)
        end
        setreadonly(m_thread, true)
    end
    --
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
    --
    local function SafeHTTP(url)
        local request = (syn and syn.request) or (http and http.request) or http_request
        return request(
        {
            Url = url,  
            Method = "GET",
            Headers = {
                ["Content-Type"] = "application/json"
            },  
        }
    ).Body
    end
    --
    local function SafeLoad(code)
        return loadstring(code)()
    end
    --
    local function getClosestPlayerToCursor(Radius)
        local shortestDistance = Radius

        local closestPlayer
        for i, v in pairs(Players:GetPlayers()) do
            if v ~= lp and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("Head") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
                local pos,OnScreen = CC:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                    local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude
                        if magnitude < shortestDistance and OnScreen then
                            closestPlayer = v
                            shortestDistance = magnitude
                        end
                    end
                end 
        return closestPlayer
    end
    --
    local function Highlight(player,fillcolour,filltrans,outlinecolour,outlinetrans)
        Highlight = Instance.new("Highlight")
        Highlight.Enabled = true
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        Highlight.FillColor = fillcolour
        Highlight.OutlineColor = outlinecolour
        Highlight.Adornee = player
        Highlight.OutlineTransparency = outlinetrans
        Highlight.FillTransparency = filltrans
        Highlight.Parent = game.CoreGui
    end 
    --
    local function RemoveHighlight(player)
        if player and player.Character and player.Character:FindFirstChild("Highlight") then 
            player.Character:FindFirstChild("Highlight"):Destroy()
        end 
    end
    --
    function get_calculated_tab_size()
        return 522/5
    end 
    --
    local function ClosestPart(Player,List)
        local shortestDistance = math.huge
        local closestPart
        if Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character:FindFirstChild("Head") and Player.Character.Humanoid.Health ~= 0 and Player.Character:FindFirstChild("HumanoidRootPart") then
            for i, v in pairs(Player.Character:GetChildren()) do
                if v:IsA("BasePart") then 
                    local pos = CC:WorldToViewportPoint(v.Position)
                    local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y+36)).magnitude
                        if magnitude < shortestDistance and table.find(List,v.Name) then
                            closestPart = v
                            shortestDistance = magnitude
                        end
                    end
                end 
            return closestPart
        end
    end 
    --
    function FOVCHECK(Player) 
        if GetRenderProperty(Lock, "Visible") == false then return true end 

        local FOVCheck = GetRenderProperty(Lock, "Radius")

        if Player ~= lp and Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health ~= 0 and Player.Character:FindFirstChild("LowerTorso") then
        local pos = Camera:WorldToViewportPoint(Player.Character.PrimaryPart.Position)
        local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude
            if magnitude < FOVCheck then
                FOVCheck = magnitude 
                return true 
            else 
                return false 
            end
        end
    end 
    --
    local function tool() 
        if lp.Character and lp.Character:FindFirstChildWhichIsA("Tool") then 
            return lp.Character:FindFirstChildWhichIsA("Tool") 
        end 
    end 
    --
    local function Chance(percentage)
        local Chance = percentage 

        if math.random(1,100) <= percentage then 
            return true 
        else 
            return false
        end 
    end 
    --
    function Clone(Player,Color,Material,Transparency)
        for i,v in pairs(Player.Character:GetChildren()) do 
            if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then 
                local ClonedPart = Instance.new("Part")
                ClonedPart.Anchored = true 
                ClonedPart.CanCollide = false 
                ClonedPart.Position = v.Position
                ClonedPart.Parent = ws.Terrain 
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
    local function Explode(VictimChar)
        spawn(function()
            local Explosion = game:GetObjects("rbxassetid://12843483581")[1]
            Explosion.Position = VictimChar.UpperTorso.Position
            for i,v in pairs(Explosion:GetChildren()) do
                if v:IsA('Part') then
                    local RandomOffsets = {
                        [3] = {
                            [1] = CFrame.new(0, 0, 0, 0.291951358, -0.454637647, 0.841468394, 0.837198734, -0.303921342, -0.454675913, 0.462452948, 0.837219477, 0.291891754),
                            [2] = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                            [3] = CFrame.new(0, 0, 0, 0.980090559, 0.139680177, 0.141109571, -0.159390777, 0.977284014, 0.139680177, -0.118393585, -0.159390777, 0.980090559),
                            [4] = CFrame.new(0, 0, 0, 0.173127294, 0.378437281, 0.909292102, -0.722461104, -0.578677535, 0.378394246, 0.669385433, -0.722438574, 0.17322135),
                            [5] = CFrame.new(0, 0, 0, 0.427273333, 0.494663626, 0.756799459, -0.869062901, -0.00613296032, 0.494663626, 0.249333531, -0.869062901, 0.427273333)
                        },
                        [4] = {
                            [1] = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                            [2] = CFrame.new(0, 0, 0, 0.291951358, 0.454619884, -0.841477931, -0.0720763057, 0.887764454, 0.454619884, 0.953713477, -0.0720763057, 0.291951358),
                            [3] = CFrame.new(0, 0, 0, 0.17322135, -0.378349423, -0.909310758, 0.0343255848, 0.925026178, -0.378349423, 0.98428458, 0.0343255848, 0.17322135),
                            [4] = CFrame.new(0, 0, 0, 0.980090559, -0.13969931, -0.141090572, 0.11998871, 0.982897162, -0.13969931, 0.158193409, 0.11998871, 0.980090559),
                            [5] = CFrame.new(0, 0, 0, 0.427273333, -0.494724542, -0.756759584, 0.120325297, 0.860679626, -0.494724542, 0.896079957, 0.120325297, 0.427273333)
                        },
                        [5] = {
                            [1] = CFrame.new(0, 0, 0, 0.291951358, 0.454619884, -0.841477931, -0.0720763057, 0.887764454, 0.454619884, 0.953713477, -0.0720763057, 0.291951358),
                            [2] = CFrame.new(0, 0, 0, 0.17322135, -0.378349423, -0.909310758, 0.0343255848, 0.925026178, -0.378349423, 0.98428458, 0.0343255848, 0.17322135),
                            [3] = CFrame.new(0, 0, 0, 0.980090559, -0.13969931, -0.141090572, 0.11998871, 0.982897162, -0.13969931, 0.158193409, 0.11998871, 0.980090559),
                            [4] = CFrame.new(0, 0, 0, 0.427273333, 0.494663626, 0.756799459, -0.869062901, -0.00613296032, 0.494663626, 0.249333531, -0.869062901, 0.427273333)
                        }
                    }
                    v.CFrame = Explosion.CFrame * RandomOffsets[i][math.random(1, #RandomOffsets[i])]
                end
            end
            Explosion.Parent = workspace.Ignored
            Explosion.Explosion:Play()
            spawn(function()
                local Tween1 = TweenService:Create(Explosion.Mesh, TweenInfo.new(5, Enum.EasingStyle.Circular), {Scale = Vector3.new(27.5, 27.5, 27.5)})
                Tween1:Play()
                for i,v in pairs(Explosion:GetChildren()) do
                    if v:FindFirstChild('Mesh') then
                        spawn(function()
                            local Tween1 = TweenService:Create(v.Mesh, TweenInfo.new(0.1125, Enum.EasingStyle.Circular), {Scale = Vector3.new(12.5, 12.5, 12.5)})
                            local Tween2 = TweenService:Create(v.Mesh, TweenInfo.new(1.5875, Enum.EasingStyle.Circular), {Scale = Vector3.new(13.75, 13.75, 13.75)})
                            local Tween3 = TweenService:Create(v, TweenInfo.new(0.165), {Transparency = 0.35})
                            local Tween4 = TweenService:Create(v, TweenInfo.new(0.9), {Transparency = 1})
                            Tween1:Play()
                            Tween3:Play()
                            Tween1.Completed:Connect(function()
                                Tween2:Play()
                            end)
                            delay(1.425, function()
                                Tween4:Play()
                            end)
                        end)
                    end
                end
                local Tween2 = TweenService:Create(Explosion, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {Transparency = 1})
                wait(0.8)
                Tween2:Play()
            end)
            game:GetService('Debris'):AddItem(Explosion, 5)
        end)
    end
    --
    local function AirStrike(VictimChar)
        spawn(function()
            local Radio = Instance.new("Sound", VictimChar.UpperTorso)
            Radio.SoundId = "http://www.roblox.com/asset/?id=88858815"
            Radio.PlaybackSpeed = 1.5
            Radio.Volume = 1
            Radio:Play()
            local Jet = game:GetObjects("rbxassetid://12868291219")[1]
            Jet.Parent = workspace.Ignored
            Jet.Position = VictimChar.UpperTorso.CFrame.Position + Vector3.new(0, 200, -2000)
            Jet.Sound:Play()
            local function AddExplosion()
                local ExplosionSound = Instance.new("Sound", VictimChar.UpperTorso)
                ExplosionSound.SoundId = "rbxassetid://3802269741"
                local Explosion = Instance.new("Explosion", Jet)
                Explosion.DestroyJointRadiusPercent = 0
                Explosion.BlastPressure = 10000
                Explosion.Position = VictimChar.UpperTorso.Position + Vector3.new(math.random(0,50) * 0.1, 0, math.random(0,50) * 0.1)
                ExplosionSound:Play()
            end
            task.spawn(function()
                task.wait(2.78333333333)
                for i = 1,4 do
                    AddExplosion()
                    wait(math.random(0, 100) * 0.001)
                end
            end)
            local Tween = TweenService:Create(Jet, TweenInfo.new(5.566666666666666, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Position = Jet.go.WorldPosition
            })
            Tween:Play()
            Tween.Completed:Wait()
            Jet:Destroy()
        end)
    end
    --
    local function Heart(VictimChar)
        spawn(function()
            local Table = {}
            local Heart = game:GetObjects("rbxassetid://12868779018")[1]
            Heart.Parent = workspace.Ignored
            Heart.PartOne.Position = VictimChar.UpperTorso.Position + Vector3.new(0,7,0)
            Heart.PartOne.Anchored = true
            Heart.Part.Position = VictimChar.UpperTorso.Position
            Heart.Part.Anchored = true
            for i,v in pairs(Heart.PartOne:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    table.insert(Table, v)
                end
            end
            for i, v in pairs(Heart.Part:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    table.insert(Table, v);
                end;
            end;
            for i, v in pairs(Table) do
                if v:GetAttribute("EmitDelay") then
                    task.delay(v:GetAttribute("EmitDelay"), function()
                        v:Emit(v:GetAttribute("EmitCount"));
                    end);
                else
                    v:Emit(v:GetAttribute("EmitCount"));
                end;
            end;
            local Sound = Instance.new("Sound", Heart.PartOne)
            Sound.Volume = 1
            Sound.SoundId = "rbxassetid://1840977366"
            Sound.PlayOnRemove = true
            Sound:Destroy()
            task.wait(0.35)
            for i,v in pairs(VictimChar:GetDescendants()) do
                if v:IsA("BasePart") then
                    TweenService:Create(v, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
                        Transparency = 1
                    }):Play()
                end
            end
            game.Debris:AddItem(Heart, 10)
        end)
    end
    --
    local function UFO(VictimChar)
        spawn(function()
            local UFO = game:GetObjects("rbxassetid://12876678129")[1]
            UFO.Parent = workspace.Ignored

            local Sound = Instance.new("Sound", VictimChar.UpperTorso)
            Sound.SoundId = "rbxassetid://138207483"
            Sound:Play()
            game.Debris:AddItem(Sound, 5)
            local Effect = UFO.Effect
            Effect.CFrame = CFrame.new(VictimChar.UpperTorso.Position.X, VictimChar.UpperTorso.Position.Y + 35, VictimChar.UpperTorso.Position.Z)
            TweenService:Create(Effect, TweenInfo.new(0.5), {
                Transparency = 0
            }):Play()
            game.Debris:AddItem(Effect, 5)
            task.wait(0.5)
            local Main = UFO.Main
            Main.CFrame = CFrame.new(VictimChar.UpperTorso.Position.X, VictimChar.UpperTorso.Position.Y - 1, VictimChar.UpperTorso.Position.Z)
            game.Debris:AddItem(Main, 4)
            TweenService:Create(Main, TweenInfo.new(4), {
                CFrame = CFrame.new(Main.Position.X, Main.Position.Y + 20, Main.Position.Z)
            }):Play()
            TweenService:Create(Effect, TweenInfo.new(4), {
                CFrame = CFrame.new(Effect.Position.X, Effect.Position.Y + 20, Effect.Position.Z)
            }):Play()
            for i,v in pairs(VictimChar:GetDescendants()) do
                if not (not v:IsA("BasePart")) or not (not v:IsA("MEshPart")) or v:IsA("Decal") then
                    TweenService:Create(v, TweenInfo.new(4), {
                        Transparency = 1
                    }):Play()
                end
            end
            task.delay(4, function()
                TweenService:Create(Effect, TweenInfo.new(4), {
                    Transparency = 1
                }):Play()
            end)
        end)
    end
    --
    local function Glitch(VictimChar)
        spawn(function()
            local Glitch = game:GetObjects("rbxassetid://12886574483")[1]
            Glitch.Parent = workspace.Ignored
            Glitch.CFrame = VictimChar.UpperTorso.CFrame + Vector3.new(0, -0.5, 0)
            Glitch.Orientation = VictimChar.UpperTorso.Orientation
            for i,v in pairs(VictimChar:GetDescendants()) do
                if not (not v:IsA("BasePart")) or not (not v:IsA("MEshPart")) or v:IsA("Decal") then
                    TweenService:Create(v, TweenInfo.new(4), {
                        Transparency = 1
                    }):Play()
                end
            end	
            game.Debris:AddItem(Glitch, 4.5)
            for i,v in pairs(Glitch:GetChildren()) do
                if v:IsA("ParticleEmitter") then
                    TweenService:Create(v, TweenInfo.new(4), {
                        Rate = 0
                    }):Play()
                end
            end
            local Sound = Instance.new("Sound", VictimChar.UpperTorso)
            Sound.SoundId = "rbxassetid://8880764455"
            Sound:Play()
        end)
    end
    --
    local function CosmicSlash(VictimChar)
        spawn(function()
            local Tween = game:GetObjects("rbxassetid://12888729215")[1]
            local XSlash = game:GetObjects("rbxassetid://12888745636")[1]
            local Folder = Instance.new("Folder", workspace.Ignored)
            if isfile("Slash.mp3") then
                if readfile("Slash.mp3") ~= game:HttpGet("https://drive.google.com/u/0/uc?id=1BDiq04mmacjNXH4IgmZHn4D8ASp0730R&export=download") then
                    writefile("Slash.mp3", game:HttpGet("https://drive.google.com/u/0/uc?id=1BDiq04mmacjNXH4IgmZHn4D8ASp0730R&export=download"))
                end
            else
                writefile("Slash.mp3", game:HttpGet("https://drive.google.com/u/0/uc?id=1BDiq04mmacjNXH4IgmZHn4D8ASp0730R&export=download"))
            end
            local Slash = getsynasset("Slash.mp3")
            local sucess, err = pcall(function()
                for i,v in pairs(VictimChar:GetDescendants()) do
                    if not (not v:IsA("BasePart")) or not (not v:IsA("MEshPart")) or v:IsA("Decal") then
                        TweenService:Create(v, TweenInfo.new(4), {
                            Transparency = 1
                        }):Play()
                    end
                end
                local Part = Instance.new("Part")
                local HRP = VictimChar:FindFirstChild("HumanoidRootPart")
                Part.CFrame = CFrame.new(VictimChar.UpperTorso.CFrame.p) * CFrame.new(0,2.2,0)
                local Particles = XSlash.particles
                local Particles2 = XSlash.particles2
                local Beams = XSlash.Beams
                local Main = XSlash.Main
                Main.CFrame = Part.CFrame * CFrame.new(0, -2.7, 0)
                Main.Parent = Folder
                game.Debris:AddItem(Main, 3)
                local Sound = Instance.new("Sound", Main)
                Sound.SoundId = Slash
                Sound.Volume = 3
                Sound:Play()
                game.Debris:AddItem(Sound, 3)
                Particles2.CFrame = Part.CFrame * CFrame.Angles(0, -2.3935096295999836, 0)
                Particles2.Parent = Folder
                game.Debris:AddItem(Particles2, 3)
                Particles.CFrame = Part.CFrame * CFrame.Angles(0, -0.8226958495125671, 0)
                Particles.Parent = Folder
                game.Debris:AddItem(Particles, 3)
                Main.Attachment.OUT3:Emit(6)
                Main.Attachment.OUT2:Emit(6)
                Main.Attachment.OUT:Emit(4)
                Main.Attachment.ParticleEmitter:Emit(2)
                TweenService:Create(Main.PointLight, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0), {
                    Brightness = 5
                }):Play()
                wait(0.06)
                Main.Attachment.IN:Emit(4)
                wait(0.1)
                Main.Attachment2.ParticleEmitter:Emit(39)
                wait(0.28)
                Main.Attachment.OUTFX:Emit(4)
                Main.Attachment.OUTFX2:Emit(4)
                Main.Attachment2.ParticleEmitterOUT:Emit(39)
                for i,v in pairs(Particles:GetChildren()) do
                    v:Emit(v:GetAttribute("EmitCount"))
                end
                for i,v in pairs(Particles2:GetChildren()) do
                    v:Emit(v:GetAttribute("EmitCount"))
                end
                spawn(function()
                    Tween.Parent = game.Lighting
                    game.TweenService:Create(Tween, TweenInfo.new(0.2), {
                        TintColor = Color3.fromRGB(172, 78, 255), 
                        Brightness = 0.5, 
                        Contrast = 1, 
                        Saturation = -1
                    }):Play();
                    wait(0.2);
                    game.TweenService:Create(Tween, TweenInfo.new(0.3), {
                        TintColor = Color3.fromRGB(255, 255, 255), 
                        Brightness = 0, 
                        Contrast = 0, 
                        Saturation = 0
                    }):Play();
                    game.Debris:AddItem(Tween, 0.3);
                end)
                local PrimartyPart = Beams.PrimaryPart
                spawn(function()
                    PrimartyPart.CFrame = Part.CFrame * CFrame.new(0, -2.7, 0)
                    Beams.Parent = Folder
                    for i = 0, 1, 0.1 do
                        Beams:FindFirstChild("Part1").BEAM.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part1").BEAM1.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part1").BEAM2.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part1").BEAM3.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part1").BEAM4.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part1").BEAM5.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part1").BEAM6.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part1").BEAM7.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part2").BEAM.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part2").BEAM1.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part2").BEAM2.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part2").BEAM3.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part2").BEAM4.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part2").BEAM5.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part2").BEAM6.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part2").BEAM7.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part3").BEAM.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part3").BEAM1.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part3").BEAM2.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part3").BEAM3.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part3").BEAM4.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part3").BEAM5.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part3").BEAM6.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part3").BEAM7.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part4").BEAM.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part4").BEAM1.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part4").BEAM2.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part4").BEAM3.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part4").BEAM4.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part4").BEAM5.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part4").BEAM6.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part4").BEAM7.Transparency = NumberSequence.new(i);
                        wait(0.001);
                    end
                end)
                wait(0.4)
                TweenService:Create(Main.PointLight, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0), {
                    Brightness = 0
                }):Play();
        end)
            if sucess then
                task.delay(25, function()
                    Folder:Destroy()
                end)
                return
            end
            Folder:Destroy()
            Tween:Destroy()
        end)
    end
    --
    local function get_calculated_velocity(obj)
        if obj.Character and obj.Character:FindFirstChild("HumanoidRootPart") then
            local root = obj.Character.HumanoidRootPart
            local character = obj.Character 

            local currentPosition = root.Position
            local currentTime = tick() 

            task.wait()

            local newPosition = root.Position
            local newTime = tick()
            
            local distanceTraveled = (newPosition - currentPosition) 

            local timeInterval = newTime - currentTime
            local velocity = distanceTraveled / timeInterval
            currentPosition = newPosition
            currentTime = newTime
            return velocity
        end
    end
    --
    local function newDrawing(type, prop)
        local obj = Drawing.new(type)
        if prop then
            for i,v in next, prop do
                obj[i] = v
            end
        end
        return obj  
    end
    --
    function GetSubPrefix(str)
        local str = tostring(str):gsub(" ","")
        local var = ""
        --
        if #str == 2 then
            local sec = string.sub(str,#str,#str+1)
            var = sec == "1" and "st" or sec == "2" and "nd" or sec == "3" and "rd" or "th"
        end
        --
        return var
    end

    
--// Target Stats 
    local Options = {
       "Health",
    }

    local Sliders = {}
    local Instances = {} 
    --
    local Outline = Drawing.new("Square")
    Outline.Size = Vector2.new(300, (49 + (1 * 20)))
    Outline.Position = Vector2.new(806, 831)
    Outline.Color = Color3.fromRGB(0, 0, 0)
    Outline.Filled = true
    Outline.Visible = true
    --
    local Inline = Drawing.new("Square")
    Inline.Size = Vector2.new(Outline.Size.X - 2, Outline.Size.Y - 2)
    Inline.Position = Vector2.new(Outline.Position.X + 1, Outline.Position.Y + 1)
    Inline.Color = Color3.fromRGB(0, 0, 0)
    Inline.Filled = true
    Inline.Visible = true
    --
    local Frame = Drawing.new("Square")
    Frame.Size = Vector2.new(Inline.Size.X - 1, Inline.Size.Y - 1)
    Frame.Position = Vector2.new(Inline.Position.X, Inline.Position.Y)
    Frame.Color = Color3.fromRGB(20, 20, 20)
    Frame.Filled = true
    Frame.Visible = true
    --
    local Accent = Drawing.new("Square")
    Accent.Size = Vector2.new(Frame.Size.X, 2)
    Accent.Position = Vector2.new(Frame.Position.X, Frame.Position.Y)
    Accent.Color = Color3.fromRGB(112, 41, 99)
    Accent.Filled = true
    Accent.Visible = true
    -- 
    local Accent_Gradient = Drawing.new("Image")
    Accent_Gradient.Size = Vector2.new(Frame.Size.X, 2)
    Accent_Gradient.Position = Vector2.new(Frame.Position.X, Frame.Position.Y)
    Accent_Gradient.Data = game:HttpGet("https://raw.githubusercontent.com/portallol/luna/main/Gradient180.png")
    Accent_Gradient.Visible = true
    --
    for Index, Value in pairs(Options) do
        local Slider = {}
        --
        getgenv().Value_Outline = Drawing.new("Square")
        Value_Outline.Size = Vector2.new(Frame.Size.X - 100, 20)
        Value_Outline.Position = Vector2.new(Frame.Position.X + 80, Frame.Position.Y + 18 + ((Index - 1) * 30))
        Value_Outline.Color = Color3.fromRGB(0, 0, 0)
        Value_Outline.Filled = true
        Value_Outline.Visible = false
        --
        getgenv().Value_Inline = Drawing.new("Square")
        Value_Inline.Size = Vector2.new(Value_Outline.Size.X - 2, Value_Outline.Size.Y - 2)
        Value_Inline.Position = Vector2.new(Value_Outline.Position.X + 1, Value_Outline.Position.Y + 1)
        Value_Inline.Color = Color3.fromRGB(50, 50, 50)
        Value_Inline.Filled = true
        Value_Inline.Visible = false
        --
        getgenv().Value_Frame = Drawing.new("Square")
        Value_Frame.Size = Vector2.new(Value_Inline.Size.X - 2, Value_Inline.Size.Y - 2)
        Value_Frame.Position = Vector2.new(Value_Inline.Position.X + 1, Value_Inline.Position.Y + 1)
        Value_Frame.Color = Color3.fromRGB(30, 30, 30)
        Value_Frame.Filled = true
        Value_Frame.Visible = true
        --
        getgenv().Value_Slider = Drawing.new("Square")
        Value_Slider.Size = Vector2.new(0, Value_Frame.Size.Y)
        Value_Slider.Position = Vector2.new(Value_Frame.Position.X, Value_Frame.Position.Y)
        Value_Slider.Color = Color3.fromRGB(112, 41, 99)
        Value_Slider.Filled = true
        Value_Slider.Visible = true
        --  
        getgenv().Value_Slider_Gradient = Drawing.new("Image")
        Value_Slider_Gradient.Size = Vector2.new(0, Value_Frame.Size.Y)
        Value_Slider_Gradient.Position = Vector2.new(Value_Frame.Position.X, Value_Frame.Position.Y)
        Value_Slider_Gradient.Data = game:HttpGet("https://raw.githubusercontent.com/portallol/luna/main/Gradient180.png")
        Value_Slider_Gradient.Visible = true
        --  
        local pImageData = game:GetService("HttpService"):JSONDecode(game:HttpGet(("https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=%s&size=352x352&format=Png&isCircular=false"):format(lp.UserId)))
        local imagedata  = game:HttpGet((pImageData["data"][1]["imageUrl"]))
        getgenv().TargetDrawing = Drawing.new("Image")
        TargetDrawing.Size = Vector2.new(60,60)
        TargetDrawing.Position = Vector2.new(Value_Inline.Position.X - 72, Frame.Position.Y + 5)
        TargetDrawing.Data = imagedata
        TargetDrawing.Visible = true
        TargetDrawing.ZIndex = 1
        --
        getgenv().Title = Drawing.new("Text")
        Title.Position = Vector2.new(Value_Slider.Position.X, Frame.Position.Y + 4)
        Title.Size = 13
        Title.Font = 2
        Title.Text = "".. lp.Name .." [" .. lp.DisplayName .."]"
        Title.Color = Color3.fromRGB(255, 255, 255)
        Title.Outline = true
        Title.Visible = true
        --
        function Slider:Set(Percentage, Text)
            Value_Slider.Size = Vector2.new(Value_Frame.Size.X * Percentage, Value_Frame.Size.Y)
            Value_Slider_Gradient.Size = Vector2.new(Value_Frame.Size.X * Percentage, Value_Frame.Size.Y)
        end
        
        function Slider:SetVisible(Bool)
            Outline.Visible = Bool
            Inline.Visible = Bool
            Frame.Visible = Bool
            Accent.Visible = Bool
            Accent_Gradient.Visible = Bool
            Value_Outline.Visible = Bool
            Value_Inline.Visible = Bool
            Value_Frame.Visible = Bool
            Value_Slider.Visible = Bool
            Value_Slider_Gradient.Visible = Bool
            TargetDrawing.Visible = Bool
            Title.Visible = Bool
        end 
        
        function Slider:Destroy()
            TargetDrawing:Remove()
            Value_Slider_Gradient:Remove()
            Value_Slider:Remove()
            Value_Frame:Remove()
            Value_Inline:Remove()
            Value_Outline:Remove()
            Accent_Gradient:Remove() 
            Accent:Remove() 
            Frame:Remove() 
            Inline:Remove() 
            Outline:Remove() 
            getgenv().Title:Remove() 
        end 
        --
        Sliders[Value] = Slider
    end
    
    Sliders["Health"]:SetVisible(false)

--// Cursor
    local function newDrawing(type, prop)
        local obj = Drawing.new(type)
        if prop then
            for i,v in next, prop do
                obj[i] = v
            end
        end
        return obj  
    end

    local Cursor = {
        Line1 = newDrawing("Line", { -- shitty ass func
        Color = White,
        Visible = false,
        Thickness = 1.5,
        From = Vector2.new(Camera.ViewportSize.X/2 + 60, Camera.ViewportSize.Y/2),
        To = Vector2.new(Camera.ViewportSize.X/2 + 20, Camera.ViewportSize.Y/2),
        ZIndex = 9e9,
    }),
        Line2 = newDrawing("Line", {
        Color = White,
        Visible = false,
        Thickness = 1.5,
        From = Vector2.new(Camera.ViewportSize.X/2 - 60, Camera.ViewportSize.Y/2),
        To = Vector2.new(Camera.ViewportSize.X/2 - 20 , Camera.ViewportSize.Y/2),
        ZIndex = 9e9,
    }),
        Line3 = newDrawing("Line", {
        Color = White,
        Visible = false,
        Thickness = 1.5,
        From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2 - 60),
        To = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2 - 20),
        ZIndex = 9e9,
    }),
        Line4 = newDrawing("Line", {
        Color = White,
        Visible = false,
        Thickness = 1.5,
        From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2 + 60),
        To = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2 + 20),
        ZIndex = 9e9,
    }),
    }
    
    local Outlines = {
        OutlineLine1 = newDrawing("Line", {
        Color = Color3.fromRGB(0, 0, 0),
        Visible = false,
        Thickness = 1.5,
        From = Vector2.new(Camera.ViewportSize.X/2 + 60, Camera.ViewportSize.Y/2),
        To = Vector2.new(Camera.ViewportSize.X/2 + 20, Camera.ViewportSize.Y/2),
    
    }),
        OutlineLine2 = newDrawing("Line", {
        Color = Color3.fromRGB(0, 0, 0),
        Visible = false,
        Thickness = 1.5,
        From = Vector2.new(Camera.ViewportSize.X/2 - 60, Camera.ViewportSize.Y/2),
        To = Vector2.new(Camera.ViewportSize.X/2 - 20 , Camera.ViewportSize.Y/2),
    }),
        OutlineLine3 = newDrawing("Line", {
        Color = Color3.fromRGB(0, 0, 0),
        Visible = false,
        Thickness = 1.5,
        From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2 - 60),
        To = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2 - 20),
    }),
        OutlineLine4 = newDrawing("Line", {
        Color = Color3.fromRGB(0, 0, 0),
        Visible = false,
        Thickness = 1.5,
        From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2 + 60),
        To = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2 + 20),
    }),
    }

    Outlines.OutlineLine1.ZIndex = 1
    Outlines.OutlineLine2.ZIndex = 1
    Outlines.OutlineLine3.ZIndex = 1
    Outlines.OutlineLine4.ZIndex = 1
    
    Cursor.Line1.ZIndex = 2
    Cursor.Line2.ZIndex = 2
    Cursor.Line3.ZIndex = 2
    Cursor.Line4.ZIndex = 2

--// Tracer,Folder,Part,FOVs 
    getgenv().Lock = CreateRenderObject("Circle")
    SetRenderProperty(Lock, "Radius", 100)
    SetRenderProperty(Lock, "Position", v2(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2))
    SetRenderProperty(Lock, "Visible", false)
    SetRenderProperty(Lock, "Thickness", 1)
    SetRenderProperty(Lock, "Color", rgb(255,255,255))
    SetRenderProperty(Lock, "ZIndex", 2)
    
    getgenv().LockOutline = Drawing.new("Circle")
    LockOutline.Radius = 100 
    LockOutline.Position = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)
    LockOutline.Visible = false 
    LockOutline.Thickness = 3.5
    LockOutline.Color = Color3.fromRGB(0,0,0)
    LockOutline.ZIndex = 1

    getgenv().BeamPart = Instance.new("Part", workspace)
    BeamPart.Name = "BeamPart"
    BeamPart.Transparency = 1

    getgenv().AimviewerPart = Instance.new("Part", workspace)
    AimviewerPart.Name = "AimViewer"
    AimviewerPart.Transparency = 1

    getgenv().FolderMain = Instance.new("Folder")
    FolderMain.Name = "hi"
    FolderMain.Parent = ws

    getgenv().HitChams = Instance.new("Folder")
    HitChams.Parent = ws
    
    getgenv().TargetPart = Instance.new("Part")
    TargetPart.Anchored = false 
    TargetPart.CanCollide = false 
    TargetPart.CFrame = CFrame.new(9999,9999,9999)
    TargetPart.Parent = game.Workspace
    TargetPart.Material = Enum.Material.Neon
    TargetPart.Shape = Enum.PartType.Block 
    TargetPart.Transparency = 0.8
    TargetPart.Color = Color3.fromRGB(255,255,255)

    getgenv().Tracer = Drawing.new("Line")
    Tracer.Visible = false 
    Tracer.Color = Color3.fromRGB(255,0,0)
    Tracer.Thickness = 1 

    --// Library
    local library, pointers = SafeLoad(SafeHTTP("https://gist.githubusercontent.com/f1nobe7650/a11075206e13bfad841c8de338b2d702/raw/de33dd00c902a6a4240a09e44912727e4d3d017d/gamesneeze"))
    local window = library:New({name = os.date("Osiris PRO | %A, %B", os.time())..os.date(" %d", os.time())..GetSubPrefix(os.date(" %d", os.time()))..os.date(", %Y.", os.time()), size = Vector2.new(554, 629), Accent = Color3.fromRGB(255,22,22)})
    window:NotificationList({})

    local combat_page = window:Page({name = "Aiming", size = get_calculated_tab_size()})
    local visuals_page = window:Page({name = "Visuals", size = get_calculated_tab_size()})
    local misc_page = window:Page({name = "Misc", size = get_calculated_tab_size()})
    local players_page = window:Page({name = "Players", size = get_calculated_tab_size()})
    local settings_page = window:Page({name = "Settings", size = get_calculated_tab_size()})

    --// Combat 
    do
        local lock,aim_assist,aimbot_settings                               = combat_page:MultiSection({sections = {"Lock","Aim Assist","Settings"}, side = "Left", Size = 450,fill = true})
        local Part_Section,Drawing_Section                                  = combat_page:MultiSection({sections = {"Part","Drawing"}, side = "Right", Size = 335,fill = true})
        --// Lock 
        do                 
            lock:Toggle({name = "Enabled", pointer = 'lock_enabled'}):Keybind({name = "Locking", pointer = 'lock_key', mode = "Toggle",callback = function(a) 
                if pointers["lock_enabled"]:get() and pointers["lock_type"]:get() == "Lock" and not Holding then 
                    if pointers["lock_key"]:is_active() then 
                        getgenv().Target = getClosestPlayerToCursor(math.huge) 
                        local currentHealth = Target.Character:WaitForChild("Humanoid").Health
                        window.notificationlist:AddNotification({text = "Locked onto:" .. getgenv().Target.Name .."!",lifetime = 2})

                        if pointers["view_target"]:get() then 
                            CC.CameraSubject = getgenv().Target.Character.Humanoid
                        end 

                        if pointers["part_chams"]:get() then 
                            Clone(Target,pointers["part_chams_color"]:get().Color,pointers["part_chams_material"]:get(),pointers["part_chams_color"]:get().Transparency)
                        end

                        if pointers["highlight"]:get() then 
                            Highlight(Target,pointers["Fill"]:get().Color,pointers["Fill"]:get().Transparency,pointers["Outline"]:get().Color,pointers["Outline"]:get().Transparency)
                        end 
                
                        getgenv().TargetHealthLoop = Target.Character:WaitForChild("Humanoid").HealthChanged:Connect(function(newHealth)
                            if newHealth < currentHealth then 
                                if pointers["hit_chams"]:get() and Target ~= nil then 
                                    for i,v in pairs(Target.Character:GetChildren()) do 
                                        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then 
                                            local ClonedPart = Instance.new("Part")
                                            ClonedPart.Anchored = true 
                                            ClonedPart.CanCollide = false 
                                            ClonedPart.Position = v.Position
                                            ClonedPart.Parent = HitChams 
                                            ClonedPart.Material = Enum.Material[pointers["hit_chams_material"]:get()]
                                            ClonedPart.Shape = Enum.PartType.Block 
                                            ClonedPart.Transparency = pointers["hit_chams_color"]:get().Transparency
                                            ClonedPart.Color = pointers["hit_chams_color"]:get().Color
                                            ClonedPart.Size = v.Size + Vector3.new(0.01,0.01,0.01)
                                            ClonedPart.Name = v.Name
                                            ClonedPart.Rotation = v.Rotation
                                        end 
                                    end
                                    delay(pointers["hit_chams_lifetime"]:get(),function()
                                        HitChams:ClearAllChildren()
                                    end)
                                end
                                if pointers["hit_logs"]:get() then 
                                    window.notificationlist:AddNotification({text = "Hit "..Target.Name.." For ".. floor(abs(newHealth-currentHealth)) .." Damage!",lifetime = 2})
                                end 
                            end
                            currentHealth = newHealth
                        end)

                        if Target ~= nil and pointers["lock_enabled"]:get() and pointers["lock_key"]:is_active() and Target and Target.Character and Target.Character.Humanoid and Target.Character.Humanoid.Health > 0 and pointers["target_stats"]:get() then 
                            local pImageData = game:GetService("HttpService"):JSONDecode(game:HttpGet(("https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=%s&size=352x352&format=Png&isCircular=false"):format(Target.UserId)))
                            local imagedata  = game:HttpGet((pImageData["data"][1]["imageUrl"]))
                            Sliders["Health"]:SetVisible(true)
                            TargetDrawing.Data = imagedata
                            Title.Text = "".. Target.DisplayName .." [" .. Target.Name .."]"
                        end 
                    else 
                        window.notificationlist:AddNotification({text = "Unlocked!",lifetime = 2})
                        if TargetHealthLoop then 
                            TargetHealthLoop:Disconnect()
                        end 
                        Sliders["Health"]:SetVisible(false)
                        lp.Character.Humanoid.AutoRotate = true 
                        TargetPart.CFrame = CFrame.new(9999,9999,9999)
                        CC.CameraSubject = lp.Character.Humanoid
                        ws.Terrain:ClearAllChildren() 
                        getgenv().Target = nil 
                        Tracer.Visible = false  
                        RemoveHighlight(Target)
                    end 
                end 
            end}) 
            lock:Dropdown({name = "Type", pointer = 'lock_type', options = {"Lock","Silent Aim"},default = "Lock"})
            lock:Textbox({placeholder = "Prediction", middle = true, pointer = 'lock_prediction',default = "0.1413"})
            lock:Multibox({name = "Hitpart", pointer = 'hitpart', options = bodyParts,min = 1,max = 10})
            lock:Toggle({name = "Target Stats", pointer = 'target_stats'})
            lock:Toggle({name = "Hit Logs", pointer = 'hit_logs'})
            lock:Slider({pointer = "hit_chance", name = "Hit Chance", min = 0, max = 100, default = 100, decimals = 1})
            lock:Slider({pointer = "jump_offset", name = "Jump Offset", min = -1, max = 1, default = -0.46, decimals = 0.01})
            lock:Toggle({name = "Resolver", pointer = 'resolver'}):Keybind({name = "Lock Resolver", pointer = 'resolver_keybind', mode = "Toggle"})
            lock:Toggle({name = "Aim Viewer Bypass", pointer = 'aim_viewer_bypass'})
            lock:Toggle({name = "Look-At", pointer = 'look_at'})
            lock:Toggle({name = "View Target", pointer = 'view_target'})
            lock:Toggle({name = "Target Strafe", pointer ='target_strafe'})
            lock:Slider({name = "Speed", pointer ='strafe_speed', min = 0, max = 100, default = 10, decimals = 1})
            lock:Slider({name = "Radius", pointer ='strafe_radius', min = 1, max = 50, default = 10, decimals = 1})
            lock:Slider({name = "Height", pointer ='strafe_height', min = 0, max = 20, default = 0, decimals = 1})
        end  

        --// Aim Assist
        do 
            aim_assist:Toggle({name = "Enabled", pointer ='aim_assist_enabled'}):Keybind({name = "Aim Assist", keybind_name = "Aim Assist", pointer ='aim_assist_key', mode = "Toggle",callback = function(a)
                if pointers["aim_assist_enabled"]:get() and pointers["aim_assist_key"]:is_active() then 
                    getgenv().CTarget = getClosestPlayerToCursor(math.huge)
                else 
                    getgenv().CTarget = nil 
                end 
            end})
            aim_assist:Textbox({name = "Prediction", middle = true, pointer ='aim_assist_prediction',placeholder = "0.1413"})
            aim_assist:Slider({name = "Horizontal Smoothing", pointer ='x_smoothing', min = 0, max = 100, default = 5, callback = function(a)
            end})
            aim_assist:Slider({name = "Vertical Smoothing", pointer ='y_smoothing', min = 0, max = 100, default = 5, decimals = 0.1})
            aim_assist:Dropdown({name = "Hitpart", pointer ='aim_assist_hitbox', options = bodyParts, default = 'HumanoidRootPart',max = 10})
            aim_assist:Toggle({name = "Aim Assist Resolver", pointer ='aim_assist_resolver'}):Keybind({name = "Aim Assist Resolver", pointer ='aim_assist_resolver_keybind', mode = "Toggle"})
        end 
        
        
        --// Settings
        do 
            aimbot_settings:Multibox({name = "Checks", pointer = "checks", options = {"Wall Check", "Knock Check"}, default = {},min = 0,callback = function()
            end})
            --
            function WallCheck(head)
                if not table.find(pointers["checks"]:get(), "Wall Check") then 
                    return false 
                end 
    
                if v == lp then 
                    return false 
                end
    
                local castPoints = {lp.Character.Head.Position, head.Position}
                local ignoreList = {lp.Character,head.Parent,ws.Terrain}
                a = Camera:GetPartsObscuringTarget(castPoints, ignoreList)
    
                if #a == 0 then 
                    return false 
                end
    
                return true
            end 
            --
            function KnockCheck(head)
                if not table.find(pointers["checks"]:get(), "Knock Check") then return true end 
                if head:FindFirstChild("Humanoid") and head.BodyEffects["K.O"].Value == true then 
                    return false 
                else
                    return true
                end 
            end
            -- 
            aimbot_settings:Toggle({name = "Render Field Of View", pointer = 'lock_render_field_of_view',callback = function(Bool)
                SetRenderProperty(Lock, "Visible", Bool)
            end}):Colorpicker({pointer = 'lock_fov_color', default = Color3.fromRGB(255,255,255),Transparency = 0,callback = function(a)
                SetRenderProperty(Lock, "Color", pointers["lock_fov_color"]:get().Color)
                SetRenderProperty(Lock, "Transparency",1 - pointers["lock_fov_color"]:get().Transparency)
            end})
            aimbot_settings:Toggle({name = "Render Outline", pointer = 'lock_render_outline',callback = function(a)
                LockOutline.Visible = pointers["lock_render_outline"]:get()
            end}):Colorpicker({pointer = 'lock_outline_color', default = Color3.fromRGB(0,0,0),Transparency = 0,callback = function(a)
                LockOutline.Color = pointers["lock_outline_color"]:get().Color
                LockOutline.Transparency = 1 - pointers["lock_outline_color"]:get().Transparency
            end})
            aimbot_settings:Toggle({name = "Filled", pointer = 'lock_render_fill',callback = function(Bool)
                SetRenderProperty(Lock, "Filled", Bool)
            end})
            aimbot_settings:Slider({name = "Radius (°)", pointer = 'lock_radius', min = 0, max = 1000, default = 100, decimals = 1,callback = function(a)
                SetRenderProperty(Lock, "Radius", a)
                LockOutline.Radius = a
            end})
            aimbot_settings:Slider({name = "Sides", pointer = 'lock_fov_sides', min = 0, max = 20, default = 0, decimals = 1,callback = function(a)
                SetRenderProperty(Lock, "NumSides", a)
                LockOutline.NumSides = a
            end})
        end 
        
        --// Visualization
        do 
            Part_Section:Toggle({name = "Enabled", pointer ='part_enabled'}):Colorpicker({pointer ='part_color',Transparency = 0,default = Color3.fromRGB(255,0,0),callback = function(a)
                TargetPart.Color = pointers["part_color"]:get().Color
                TargetPart.Transparency = (pointers["part_color"]:get().Transparency)
            end})
            --
            Part_Section:Dropdown({name = "configs", pointer = 'part_configs', options = {'custom','hitbox',"bubble"}, default = 'custom',callback = function(a)
                if pointers["part_configs"]:get() == "hitbox" then 
                    TargetPart.Size = Vector3.new(lp.Character.HumanoidRootPart.Size.X * 3 ,5,lp.Character.HumanoidRootPart.Size.X * 3)
                elseif pointers["part_configs"]:get() == "bubble" then 
                    TargetPart.Shape = Enum.PartType.Ball
                    TargetPart.Material = Enum.Material.ForceField
                elseif pointers["part_configs"]:get() == "custom" then 
                    TargetPart.Size = Vector3.new(pointers["part_size"]:get(),pointers["part_size"]:get(),pointers["part_size"]:get())
                    TargetPart.Material = Enum.Material[pointers["part_material"]:get()]
                    TargetPart.Color = pointers["part_color"]:get().Color
                    TargetPart.Transparency = (pointers["part_color"]:get().Transparency)
                end 
            end})
            --
            Part_Section:Dropdown({name = "Material", pointer ='part_material', options = {'ForceField','Neon',"Plastic"}, default = 'ForceField',callback = function(a)
                TargetPart.Material = Enum.Material[pointers["part_material"]:get()]
            end})
            --
            Part_Section:Toggle({name = "Visualize Velocity", pointer ='part_velocity_enabled'})
            --  
            Part_Section:Slider({name = "Size", pointer ="part_size", min = 0, max = 100, default = 100, decimal = 1,callback = function(a)
                if pointers["part_configs"]:get() == "custom" then 
                    TargetPart.Size = Vector3.new(a,a,a)
                end 
            end})
            --
            Part_Section:Toggle({name = "Chams", pointer = 'part_chams',callback = function(a)
            end}):Colorpicker({pointer ='part_chams_color', default = Color3.fromRGB(255,0,0),transparency = 0})
            --
            Part_Section:Dropdown({name = "Material", pointer ='part_chams_material', options = {'ForceField','Neon',"Plastic"}, default = 'ForceField'})
            --
            Part_Section:Toggle({name = "Hit Chams", pointer = 'hit_chams'}):Colorpicker({pointer = 'hit_chams_color', default = Color3.fromRGB(255,255,255),Transparency = 0})
            --
            Part_Section:Slider({pointer = "hit_chams_lifetime", name = "Life Time", min = 0, max = 10, default = 5, decimals = 1})
            --
            Part_Section:Dropdown({name = "Material", pointer ='hit_chams_material', options = {'ForceField','Neon',"Plastic"}, default = 'ForceField'})
            --
            Drawing_Section:Toggle({name = "Snap-Line", pointer = "snap_line",callback = function()
            end}):Colorpicker({pointer ='tracer_color',transparency = 0, default = Color3.fromRGB(255,0,0),callback = function(a)
                Tracer.Color = pointers["tracer_color"]:get().Color
                Tracer.Transparency = (1 -pointers["tracer_color"]:get().Transparency)
            end})
            --
            Drawing_Section:Slider({name = "Thickness", pointer ='tracer_thickness', min = 0, max = 3, default = 1, decimals = 0.01,callback = function(a)
                Tracer.Thickness = a
            end})
            --
            local HighlightToggle = Drawing_Section:Toggle({name = "Highlight", pointer = "highlight",callback = function()
            end})
            HighlightToggle:Colorpicker({pointer ='Fill',transparency = 0.5, default = Color3.fromRGB(255,0,0)})
            HighlightToggle:Colorpicker({pointer ='Outline',transparency = 0, default = Color3.fromRGB(255,0,0)})
        end
    end 
    getgenv().Stats[1].Text = "Velocity:"
    getgenv().Stats[2].Text = "Position:"
    getgenv().Stats[3].Text = "Rotation:"
    --// Visuals
    do
        local player_esp_section,setting_esp_section                        = visuals_page:MultiSection({sections = {"ESP","Settings"}, side = "Left", Size = 295})
        local world_section,camera_section,cursor_section                   = visuals_page:MultiSection({sections = {"World","Camera","Cursor"}, side = "Right", Size = 450}) 
        --// ESP , Settings
        do 
            player_esp_section:Toggle({pointer = "settings/menu/esp_enabled", name = "ESP Enabled", def = false})
            -- 
            player_esp_section:Slider({pointer = "settings/menu/esp_maxdistance", name = "ESP Max Distance", def = 7500, min = 0, max = 7500, decimals = 0.01})
            player_esp_section:Toggle({pointer = "settings/menu/esp_name", name = "Name", def= false})
            :Colorpicker({pointer = "settings/menu/esp_name_color", name = "Esp Name Colour",transparency = 0, default = Color3.fromRGB(255,255,255)})
            --
            local box = player_esp_section:Toggle({pointer = "settings/menu/esp_box", name = "Box", def = false})
            box:Colorpicker({pointer = "settings/menu/esp_box_color1", name = "Esp Box Color 1", transparency = 0,default = Color3.fromRGB(0,0,0)})
            box:Colorpicker({pointer = "settings/menu/esp_box_color2", name = "Esp Box Color 2",transparency = 0, default = Color3.fromRGB(192,0,2)})
            --
            player_esp_section:Toggle({pointer = "settings/menu/esp_boxfill", name = "Box Fill", def = false})
            :Colorpicker({pointer = "settings/menu/esp_boxfill_color", name = "Box Fill Color", transparency = 0.5, default = Color3.fromRGB(255,255,255)})
            --
            healthbar = player_esp_section:Toggle({pointer = "settings/menu/esp_healthbar", name = "Health Bar", def = false})
            healthbar:Colorpicker({pointer = "settings/menu/esp_healthbar_color1", name = "Show Inventory Accent", transparency = 0, default = Color3.fromRGB(33,251,24)})
            healthbar:Colorpicker({pointer = "settings/menu/esp_healthbar_color2", name = "Show Inventory Accent", transparency = 0, default = Color3.fromRGB(190,0,2)})
            --
            local Health_Number = player_esp_section:Toggle({pointer = "settings/menu/esp_healthtext", name = "Health Number", def = false})
            Health_Number:Colorpicker({pointer = "settings/menu/esp_healthtext_color1", name = "color1", transparency = 0, default = Color3.fromRGB(33,251,24)})
            Health_Number:Colorpicker({pointer = "settings/menu/esp_healthtext_color2", name = "color2", transparency = 0, default = Color3.fromRGB(190,0,2)})
            --
            local OffScreen_Arrows = player_esp_section:Toggle({pointer = "settings/menu/esp_arrow", name = "Offscreen Arrows", def = false})
            OffScreen_Arrows:Colorpicker({pointer = "settings/menu/esp_arrow_color", name = "Arrow Color", transparency = 0, default = Color3.fromRGB(255,255,255)})
            OffScreen_Arrows:Colorpicker({pointer = "settings/menu/esp_arrow_color_outline", name = "Arrow Outline Color", transparency = 0, default = Color3.fromRGB(0,0,0)})
            --
            setting_esp_section:Toggle({pointer = "settings/menu/esp_arrow_pulse", name = "Arrow Pulse", def = false})
            --
            setting_esp_section:Slider({pointer = "settings/menu/esp_arrow_size", name = "Arrow Size", def = 12, min = 0, max = 35, decimals = 0.01})
            --
            setting_esp_section:Slider({pointer = "settings/menu/esp_arrow_position", name = "Arrow Radius", def = 0, min = 200, max = 800, decimals = 0.01})
            --
            setting_esp_section:Slider({pointer = "settings/menu/esp_arrow_pulse_speed", name = "Arrow Pulse Speed", def = 5, min = 0, max = 15, decimals = 0.01})
            --
            player_esp_section:Multibox({Name = "Arrow Flags", Minimum = 0, Options = {"Distance", "Health"}, Pointer = "settings/menu/esp_arrow_flag_type"})
            --
            player_esp_section:Toggle({pointer = "settings/menu/esp_weapon", name = "Weapon", def = false})
            :Colorpicker({pointer = "settings/menu/esp_weapon_color", name = "Weapon Color", default = Color3.fromRGB(255, 255, 255)})
            --
            player_esp_section:Toggle({pointer = "settings/menu/esp_distance", name = "Distance", def = false})
            :Colorpicker({pointer = "settings/menu/esp_distance_color", name = "Distance Color", default = Color3.fromRGB(255, 255, 255)})
            --
            player_esp_section:Toggle({pointer = "settings/menu/esp_tracer", name = "Tracer", def = false})
            :Colorpicker({pointer = "settings/menu/esp_tracer_color", name = "Tracer Color",transparency = 0, default = Color3.fromRGB(255, 255, 255)})
            -- 
            setting_esp_section:Dropdown({name = "Tracer Origin",options = {"Top","Mouse","Bottom"}, pointer = "settings/menu/esp_tracer_origin"})
            --
            setting_esp_section:Toggle({pointer = "settings/menu/esp_highlight_target", name = "Highlight Target", def = false}):Colorpicker({pointer = "settings/menu/esp_hightlight_target_color", name = "Enemy Color", default = Color3.fromRGB(200, 55, 55)})
            --
            setting_esp_section:Dropdown({name = "ESP Font",options = {"UI","Plex","Monospace","System"}, pointer = "settings/menu/font",default = "Plex"})
            --
            setting_esp_section:Slider({pointer = "settings/menu/font_size", name = "Font Size", def = 13, min = 0, max = 50, decimals = 1})
            --pointers["settings/menu/font_size"]:set(13)
            --
            loadstring(game:HttpGet("https://hvh.wtf/p/raw/osiris/ca2w6qvj0v"))()
        end 

        --// World , Camera , Cursor
        do 
            local Ambient = world_section:Toggle({pointer = "settings/menu/visuals_custom_ambient",name = "Custom Ambient", def = false})
            Ambient:Colorpicker({pointer = "settings/menu/visuals_ambient",name = "Ambient Color",default = Color3.fromRGB(255,255,255)}) 
            Ambient:Colorpicker({pointer = "settings/menu/visuals_outdoor_ambient",name = "Ambient Color",default = Color3.fromRGB(255,255,255)}) 
            --
            world_section:Toggle({pointer = "settings/menu/visuals_custom_color_shift", name = "Custom Color Shift", def = false }):Colorpicker({pointer = "settings/menu/visuals_custom_color_shift_top",name = "Ambient Color",default = Color3.fromRGB(255,255,255)}) 
            --
            world_section:Toggle({pointer = "settings/menu/visuals_custom_shadows", name = "Global Shadows", def = true }):Colorpicker({pointer = "settings/menu/visuals_custom_shadows_color",name = "Shadows Color",default = Color3.fromRGB(170,170,170)})
            world_section:Slider({pointer = "settings/menu/visuals_custom_shadows_softness", name = "Shadow Softness: ", def = 0.65,min = 0, max = 1, prefix = "%",decimals = 0.01})
            --
            world_section:Toggle({pointer = "settings/menu/visuals_custom_brightness", name = "Custom Brightness", def = false })
            world_section:Slider({pointer = "settings/menu/visuals_custom_brightness_number", name = "Brightness: ", def = 1,min = 0, max = 5, decimals = 0.1})
            --
            world_section:Toggle({pointer = "settings/menu/visuals_custom_exposure", name = "Custom Exposure", def = false })
            world_section:Slider({pointer = "settings/menu/visuals_custom_exposure_number", name = "Exposure: ", def = 1, min = -5, max = 5, decimals = 0.01})
            --
            world_section:Toggle({pointer = "settings/menu/visuals_custom_clock_time", name = "Custom Clock Time", def = false })
            world_section:Slider({pointer = "settings/menu/visuals_custom_clock_time_number", name = "Clock Time: ", def = 0, min = 0.1, max = 24, prefix = "hr",decimals = 0.1})
            world_section:Dropdown({pointer = "settings/menu/visuals_custom_technology",name = "Custom Technology",options = {"Future", "ShadowMap", "Compatibility", "Voxel"},def = "Voxel",callback = function(s) sethiddenproperty(Lighting, "Technology", s) end})
            --
            world_section:Toggle({pointer = "settings/menu/visuals_fog", name = "Fog", def = false }):Colorpicker({pointer = "settings/menu/visuals_fog_color",name = "Fog Color",default = Color3.fromRGB(255,255,255)})
            world_section:Slider({pointer = "settings/menu/visuals_fog_start", name = "Fog Start: ", def = 750, min = 0, max = 5000, decimals = 0.1,suffix = "st"})
            world_section:Slider({pointer = "settings/menu/visuals_fog_end", name = "Fog End: ", def = 750, min = 0, max = 5000, decimals = 0.1,suffix = "st"})
            --
            world_section:Toggle({pointer = "settings/menu/disable_rendering", name = "Disable Rendering", def = false,function()
                Run:Set3dRenderingEnabled(not pointers["settings/menu/disable_rendering"]:get())
            end})
            --
            world_section:Button({name = "Reset", confirmation = true, callback = function()
                for i,v in pairs(oldLighting) do 
                    Lighting[i] = v 
                end 
            end})

            camera_section:Toggle({pointer = "settings/menu/visuals_custom_fov", name = "Custom Field Of View",def = false,callback = function(Bool)
                if not Bool then 
                    CC.FieldOfView = 70
                end 
            end})
            --
            camera_section:Slider({pointer = "settings/menu/visuals_custom_fov_number", name = "Field Of View: ", def = 90, min = 0, max = 120, decimals = 0.1})
            --        
            camera_section:Toggle({pointer = "settings/menu/visuals_aspect", name = "Aspect Ratio", def = false})
            --
            camera_section:Slider({pointer = "settings/menu/visuals_aspect_ratio_x", name = "Amount:", def = 50, min = 0, max = 100, decimals = 0.1,suffix = "%"})
            
            local other_visuals = visuals_page:Section({name = "Other", side = "Left",Size = 295,Fill = true})
            --
            local BT = other_visuals:Toggle({pointer = "bullet_tracers", name = "Bullet Tracers", def = false})
            BT:Colorpicker({pointer = "bullet_tracers_color",name = "Bullet Tracers Color",default = Color3.fromRGB(255,255,255),callback = function()
                getgenv().Beam1 = pointers["bullet_tracers_color"]:get().Color
            end}) 
            BT:Colorpicker({pointer = "bullet_tracers_color_2",name = "Bullet Tracers Color 2",default = Color3.fromRGB(255,255,255),callback = function()
                getgenv().Beam2 = pointers["bullet_tracers_color_2"]:get().Color
            end}) 
            --
            other_visuals:Dropdown({name = "Textures", pointer ='bullet_tracer_texture', options = {"1","2","3","4","5","6","7","8"}, default = '1',callback = function(Option)
                _G.Beam = pointers["bullet_tracer_texture"]:get()
            end})
            _G.Beam = pointers["bullet_tracer_texture"]:get()
            --
            other_visuals:Toggle({pointer = "body_enabled", name = "Body Material", def = false}):Colorpicker({pointer = "body_color",name = "Body Color",default = Color3.fromRGB(255,255,255)}) 
            -- 
            other_visuals:Toggle({pointer = "gun_enabled", name = "Gun Material", def = false}):Colorpicker({pointer = "gun_color",name = "Gun Color",default = Color3.fromRGB(255,255,255)}) 
            --
            other_visuals:Toggle({pointer = "custom_gun_sfx", name = "Custom Gun Sounds", def = false})
            --
            other_visuals:Dropdown({name = "Sound", pointer ='Sound',max = 5, options = sfxnames, default = 'Bonk'})
            --
            function createBeam(v1, v2)
                local Part = Instance.new("Part", BeamPart)
                Part.Size = Vector3.new(1, 1, 1)
                Part.Transparency = 1
                Part.CanCollide = false
                Part.CFrame = CFrame.new(v1)
                Part.Anchored = true
                local Attachment = Instance.new("Attachment", Part)
                local Part2 = Instance.new("Part", BeamPart)
                Part2.Size = Vector3.new(1, 1, 1)
                Part2.Transparency = 1
                Part2.CanCollide = false
                Part2.CFrame = CFrame.new(v2)
                Part2.Anchored = true
                Part2.Color = Color3.fromRGB(255, 255, 255)
                local Attachment2 = Instance.new("Attachment", Part2)
                local Beam = Instance.new("Beam", Part)
                Beam.FaceCamera = true
                Beam.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00 ,pointers["bullet_tracers_color"]:get().Color),
                    ColorSequenceKeypoint.new(1 ,pointers["bullet_tracers_color_2"]:get().Color),
                }
                Beam.Attachment0 = Attachment
                Beam.Attachment1 = Attachment2
                Beam.LightEmission = 6
                Beam.LightInfluence = 1
                Beam.Width0 = 1
                Beam.Width1 = 0.6
                Beam.Texture = "rbxassetid://" .. client.TracerTextures[_G.Beam]..""
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
                end)
            end
            --

            do 
                for _,v in next, Cursor do 
                    v.Thickness = 2
                end 

                for _,v in next, Outlines do 
                    v.Thickness = 4.5
                end 

                for _,v in next, Outlines do 
                    v.Color = Color3.new(0,0,0)
                end 

                local CustomCursor = cursor_section:Toggle({name = "Enabled", pointer ='custom_cursor',callback = function()
                    for i,v in pairs(Cursor) do 
                        v.Visible = pointers["custom_cursor"]:get()
                    end

                    game:GetService("UserInputService").OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceShow

                    for i,v in pairs(Outlines) do 
                        v.Visible = pointers["custom_cursor"]:get()
                    end
                    
                end})
                CustomCursor:Colorpicker({name = "Cursor Color",pointer ='custom_cursor_color', default = Color3.fromRGB(255,255,255),callback = function()
                    for _,v in next, Cursor do 
                        v.Color = pointers["custom_cursor_color"]:get().Color
                    end 
                end})        


                cursor_section:Slider({name = "Size", max = 25, min = 0, default = 10, pointer ='cursor_size', decimals = 1}); -- pointers["cursor_size"]
                cursor_section:Slider({name = "Gap", max = 25, min = 0, default = 1, pointer ='cursor_gap', decimals = 1});
                cursor_section:Slider({name = "Thickness", max = 5, min = 0.01, default = 1.5, pointer ='cursor thickness', decimals = 0.01,callback = function(int)
                    for i,v in next, Cursor do 
                        v.Thickness = int
                    end 

                    for i,v in next, Outlines do 
                        v.Thickness = int * 2.5
                    end 
                end});
                cursor_section:Toggle({name = "Spin", pointer ='spinning_cursor'})
                cursor_section:Slider({name = "Speed", max = 360, min = 0, default = 45, pointer ='spin_speed', decimals = 1});
                cursor_section:Toggle({name = "Dynamic Spin", pointer ='dynamic_spin'})
                cursor_section:Toggle({name = "Dynamic Gap", pointer ='sine_animation'})
                cursor_section:Slider({name = "Speed", max = 2, min = 0, default = 1, pointer ='sine_animation_speed', decimals = 0.01});
                cursor_section:Slider({name = "Offset", max = 2, min = -2, default = 0, pointer ='sine_animation_offset', decimals = 0.01});
            end
        end 
    end

    --// Misc
    do 
        local movement_section,disablers_section,autobuys_section           = misc_page:MultiSection({sections = {"Movement","Disablers","Auto Buys"}, side = "Left", Size = 240,fill = false})
        local velocity_section,network_section               = misc_page:MultiSection({sections = {"Anti-Lock","Network"}, side = "Right", Size = 450,fill = true}) 
        local shit_talk                                                     = misc_page:Section({name = "Shit Talk", side = "Left",Size = 295,Fill = true})
        local stomp_changer                                                 = misc_page:Section({name = "Stomp Effect Changer", side = "Left",Size = 295,Fill = true})
        --// Movement, Disablers, Auto-Buys
        do 
            movement_section:Toggle({pointer = "speed", name = "CFrame Speed", def = false}):Keybind({name = "Speed", pointer = 'speed_key', mode = "Toggle"})
            movement_section:Slider({pointer = "speed_power", name = "Speed: ", def = 30, min = 0, max = 100, decimals = 1,suffix = "%"})
            movement_section:Toggle({pointer = "auto_jump", name = "Auto Jump", def = false})
            movement_section:Toggle({pointer = "fly", name = "Fly", def = false,callback = function()
                lp.Character.HumanoidRootPart.Anchored = false 
            end}):Keybind({name = "Fly", pointer = 'fly_key', mode = "Toggle",callback = function()
                lp.Character.HumanoidRootPart.Anchored = false 
            end})
            movement_section:Slider({pointer = "fly_speed", name = "Fly Speed: ", def = 100, min = 0, max = 200, decimals = 1,suffix = "%"})
            movement_section:Toggle({pointer = "spin", name = "Spin", def = false,callback = function()
                lp.Character.Humanoid.AutoRotate = true 
            end}):Keybind({name = "Spin", pointer = 'spin_key', mode = "Toggle",callback = function()
                lp.Character.Humanoid.AutoRotate = true 
            end})
            movement_section:Slider({pointer = "spin_power", name = "Spin Power: ", def = 2, min = 0, max = 20, decimals = 0.1,suffix = "%"})
            movement_section:Toggle({pointer = "jitter", name = "Jitter", def = false,callback = function()
                lp.Character.Humanoid.AutoRotate = true 
            end}):Keybind({name = "Jitter", pointer = 'jitter_key', mode = "Toggle",callback = function()
                lp.Character.Humanoid.AutoRotate = true 
            end})

            movement_section:Toggle({pointer = "macro_toggle", name = "Macro", def = false,callback = function()
            end}):Keybind({name = "Macro", pointer = 'macro_key', mode = "Hold",callback = function()
            end})

            spawn(function()
                while true do  
                    Run.Heartbeat:wait()
                    if pointers["macro_toggle"]:get() == true and pointers["macro_key"]:is_active() == true and not getgenv().Holding then 
                        keypress(0x49)
                        Run.Heartbeat:wait()
                        keypress(0x4F)
                        Run.Heartbeat:wait()
                        keyrelease(0x49)
                        Run.Heartbeat:wait()
                        keyrelease(0x4F)
                        Run.Heartbeat:wait()
                    end 

                    if pointers["st"]:get() then 
                        delay(pointers["st_delay"],function()
                            local RandomChat = math.random(1,#client["shit talk"][tostring(pointers["st_type"]:get())])
                            ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(client["shit talk"][tostring(pointers["st_type"]:get())][RandomChat],"All")
                        end)
                    end 
                end 
            end)

            disablers_section:Toggle({pointer = "anti_stomp", name = "Anti Stomp", def = false})
            disablers_section:Toggle({pointer = "auto_pick_up_money", name = "Auto Pick Up Money", def = false})
            disablers_section:Toggle({pointer = "auto_reload", name = "Auto Reload", def = false})
            disablers_section:Toggle({pointer = "auto_stomp", name = "Auto Stomp", def = false})
            disablers_section:Toggle({pointer = "anti_slow_down", name = "Remove Slowdown", def = false})
            disablers_section:Toggle({pointer = "anti_jump_cooldown", name = "Remove Jump Cooldown", def = false})
            disablers_section:Toggle({pointer = "remove_chairs", name = "Remove Chairs", def = false,callback = function()
                for i,v in pairs(ws:GetDescendants()) do 
                    if v:IsA("Seat") then 
                        v.Disabled = pointers["remove_chairs"]:get() 
                    end 
                end 
            end})
            disablers_section:Toggle({pointer = "remove_zoom_limit", name = "Remove Zoom Limit", def = false,callback = function()
                if pointers["remove_zoom_limit"]:get() then 
                    lp.CameraMaxZoomDistance = math.huge
                else 
                    lp.CameraMaxZoomDistance = 25
                end 
            end})

            autobuys_section:Dropdown({name = "Buy Gun", pointer ='Auto-Buy', options = GunBuys,default = ""})
            autobuys_section:Dropdown({name = "Buy Ammo", pointer ='Auto-Ammo',default = "",options = AmmoBuys})
            autobuys_section:Slider({name = "Amount: ", max = 10, min = 0, default = 0, pointer ='Ammo_Buy_Amount', decimal = 1}) 
            autobuys_section:Dropdown({name = "Buy Food", pointer ='Auto-Food', options = FoodBuys})

            autobuys_section:ButtonHolder({Buttons = 
            {{"Buy Gun", function() 
                if pointers["Auto-Buy"]:get() then 
                    local OldPosition = lp.Character.HumanoidRootPart.CFrame
                    lp.Character.HumanoidRootPart.CFrame = ws.Ignored.Shop[pointers["Auto-Buy"]:get()].Head.CFrame
                    wait(0.20)
                    fireclickdetector(ws.Ignored.Shop[pointers["Auto-Buy"]:get()].ClickDetector)
                    fireclickdetector(ws.Ignored.Shop[pointers["Auto-Buy"]:get()].ClickDetector)
                    fireclickdetector(ws.Ignored.Shop[pointers["Auto-Buy"]:get()].ClickDetector)
                    fireclickdetector(ws.Ignored.Shop[pointers["Auto-Buy"]:get()].ClickDetector)
                    fireclickdetector(ws.Ignored.Shop[pointers["Auto-Buy"]:get()].ClickDetector)
                    fireclickdetector(ws.Ignored.Shop[pointers["Auto-Buy"]:get()].ClickDetector)
                    wait(0.20)
                    lp.Character.HumanoidRootPart.CFrame = OldPosition
                end
            end}
            , {"Buy Ammo", function() 
                for i = pointers["Ammo_Buy_Amount"]:get(),0,-1 do 
                    task.wait(0.25)
                    if pointers["Auto-Ammo"]:get() then 
                        local OldPosition = lp.Character.HumanoidRootPart.CFrame
                        lp.Character.HumanoidRootPart.CFrame = ws.Ignored.Shop[pointers["Auto-Ammo"]:get()].Head.CFrame
                        wait(0.25)
                        fireclickdetector(ws.Ignored.Shop[pointers["Auto-Ammo"]:get()].ClickDetector)
                        fireclickdetector(ws.Ignored.Shop[pointers["Auto-Ammo"]:get()].ClickDetector)
                        fireclickdetector(ws.Ignored.Shop[pointers["Auto-Ammo"]:get()].ClickDetector)
                        fireclickdetector(ws.Ignored.Shop[pointers["Auto-Ammo"]:get()].ClickDetector)
                        fireclickdetector(ws.Ignored.Shop[pointers["Auto-Ammo"]:get()].ClickDetector)
                        fireclickdetector(ws.Ignored.Shop[pointers["Auto-Ammo"]:get()].ClickDetector)
                        wait(0.25)
                        lp.Character.HumanoidRootPart.CFrame = OldPosition
                    end
                end 
            end}}})

            autobuys_section:ButtonHolder({Buttons = 
            {{"Buy Food", function() 
                if pointers["Auto-Food"]:get() then 
                    local OldPosition = lp.Character.HumanoidRootPart.CFrame
                    lp.Character.HumanoidRootPart.CFrame = ws.Ignored.Shop[pointers["Auto-Food"]:get()].Head.CFrame
                    wait(0.5)
                    fireclickdetector(ws.Ignored.Shop[pointers["Auto-Food"]:get()].ClickDetector)
                    fireclickdetector(ws.Ignored.Shop[pointers["Auto-Food"]:get()].ClickDetector)
                    fireclickdetector(ws.Ignored.Shop[pointers["Auto-Food"]:get()].ClickDetector)
                    fireclickdetector(ws.Ignored.Shop[pointers["Auto-Food"]:get()].ClickDetector)
                    fireclickdetector(ws.Ignored.Shop[pointers["Auto-Food"]:get()].ClickDetector)
                    fireclickdetector(ws.Ignored.Shop[pointers["Auto-Food"]:get()].ClickDetector)
                    wait(0.5)
                    lp.Character.HumanoidRootPart.CFrame = OldPosition
                end
            end}
            , {"Buy Armor", function() 
                    local OldPosition = lp.Character.HumanoidRootPart.CFrame
                    lp.Character.HumanoidRootPart.CFrame = ws.Ignored.Shop["[High-Medium Armor] - $2163"].Head.CFrame
                    wait(0.5)
                    fireclickdetector(ws.Ignored.Shop["[High-Medium Armor] - $2163"].ClickDetector)
                    fireclickdetector(ws.Ignored.Shop["[High-Medium Armor] - $2163"].ClickDetector)
                    fireclickdetector(ws.Ignored.Shop["[High-Medium Armor] - $2163"].ClickDetector)
                    fireclickdetector(ws.Ignored.Shop["[High-Medium Armor] - $2163"].ClickDetector)
                    fireclickdetector(ws.Ignored.Shop["[High-Medium Armor] - $2163"].ClickDetector)
                    fireclickdetector(ws.Ignored.Shop["[High-Medium Armor] - $2163"].ClickDetector)
                    wait(0.5)
                    lp.Character.HumanoidRootPart.CFrame = OldPosition
            end}}})
        end 

        --// Client,Anti-Lock,Network
        do 
            getgenv().Visualizevelocity = game:GetObjects("rbxassetid://8246626421")[1]
            Visualizevelocity.Humanoid:Destroy()
            Visualizevelocity.Head.Face:Destroy()
            Visualizevelocity.Parent = game.Workspace
            Visualizevelocity.HumanoidRootPart.Velocity = Vector3.new()
            Visualizevelocity.HumanoidRootPart.CFrame = CFrame.new(9999,9999,9999)
            Visualizevelocity.HumanoidRootPart.Transparency = 1 
    
            for i,v in pairs(Visualizevelocity:GetChildren()) do 
                if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then 
                    v.CanCollide = false 
                    v.Transparency = 0.8
                end 
            end 
    
            local function VisualizerColorVelocity(Color,Transparency)
                for i,v in next, Visualizevelocity:GetChildren() do 
                    if v.Name ~= "HumanoidRootPart" and v:IsA("BasePart") then 
                        v.Color = Color
                        v.Transparency = Transparency
                    end 
                end
            end 
    
            
            for i,v in pairs(Visualizevelocity:GetChildren()) do 
                if v:IsA("BasePart") then 
                    v.CanCollide = false 
                end 
            end 
            
            Visualizevelocity.HumanoidRootPart.Transparency = 1 
            getgenv().VisualizeTransparency = 0 
            getgenv().VisualizeColor  = Color3.fromRGB(255,255,255)
            getgenv().VisualizeDesync = false 

            --VisualizerColorVelocity(getgenv().VisualizeColor, getgenv().VisualizeTransparency) 
            velocity_section:Toggle({name = "Enabled", pointer = 'velocity_desync',callback = function(a)
                if getgenv().VisualizeDesync and pointers["velocity_desync"]:get() then 
                    for i,v in next, Visualizevelocity:GetChildren() do 
                        if v.Name ~= "HumanoidRootPart" and v:IsA("BasePart") then 
                            v.Color = getgenv().VisualizeColor
                            v.Transparency = getgenv().VisualizeTransparency
                        end 
                    end    
                else 
                    for i,v in next, Visualizevelocity:GetChildren() do 
                        if v.Name ~= "HumanoidRootPart" and v:IsA("BasePart") then 
                            v.Color = getgenv().VisualizeColor
                            v.Transparency = 1
                        end 
                    end    
                    Visualizevelocity.HumanoidRootPart.Transparency = 1 
                end 

                if getgenv().OldVelocity then 
                    lp.Character.HumanoidRootPart.Velocity = getgenv().OldVelocity
                end 
                lp.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)

            end}):Keybind({name = "Velocity Desync Keybind", pointer = 'velocity_desync_key', mode = "Toggle", ignore = false,keybind_name = "Anti Lock",default = Enum.KeyCode.X, callback = function()
                if pointers["visualize_velocity"]:get() and pointers["velocity_desync"]:get() and pointers["velocity_desync_key"]:is_active()  then 
                    for i,v in next, Visualizevelocity:GetChildren() do 
                        if v.Name ~= "HumanoidRootPart" and v:IsA("BasePart") then 
                            v.Color = getgenv().VisualizeColor
                            v.Transparency = getgenv().VisualizeTransparency
                        end 
                    end    
                else 
                    for i,v in next, Visualizevelocity:GetChildren() do 
                        if v.Name ~= "HumanoidRootPart" and v:IsA("BasePart") then 
                            v.Color = getgenv().VisualizeColor
                            v.Transparency = 1
                        end 
                    end    
                    Visualizevelocity.HumanoidRootPart.Transparency = 1 
                end 
                

                if getgenv().OldVelocity then 
                    lp.Character.HumanoidRootPart.Velocity = getgenv().OldVelocity
                end 
                
            end})


            velocity_section:Toggle({name = "Visualize", pointer = 'visualize_velocity',callback = function(a)
                getgenv().VisualizeDesync = pointers["visualize_velocity"]:get()
                if a then 
                    for i,v in next, Visualizevelocity:GetChildren() do 
                        if v.Name ~= "HumanoidRootPart" and v:IsA("BasePart") then 
                            v.Color = getgenv().VisualizeColor
                            v.Transparency = getgenv().VisualizeTransparency
                        end 
                    end   
                else 
                    for i,v in next, Visualizevelocity:GetChildren() do 
                        if v.Name ~= "HumanoidRootPart" and v:IsA("BasePart") then 
                            v.Color = getgenv().VisualizeColor
                            v.Transparency = 1
                        end 
                    end   
                    Visualizevelocity.HumanoidRootPart.CFrame = CFrame.new(999,999,999)
                end 
            end}):Colorpicker({pointer = 'visualize_velocity_color', default = Color3.new(1,1,1), Transparency = 0,callback = function(a)
                getgenv().VisualizeColor = pointers["visualize_velocity_color"]:get().Color
                getgenv().VisualizeTransparency = pointers["visualize_velocity_color"]:get().Transparency
                if pointers["visualize_velocity"]:get()  then 
                    for i,v in next, Visualizevelocity:GetChildren() do 
                        if v.Name ~= "HumanoidRootPart" and v:IsA("BasePart") then 
                            v.Color = getgenv().VisualizeColor
                            v.Transparency = getgenv().VisualizeTransparency
                        end 
                    end    
                end 
            end}); 
            velocity_section:Dropdown({name = "material", pointer = 'visualize_velocity_material', options = {'ForceField','Neon',"Plastic"}, default = 'ForceField',callback = function(a)
                for i,v in pairs(Visualizevelocity:GetChildren()) do 
                    if v:IsA("BasePart") then 
                        v.Material = Enum.Material[a] 
                        v.Transparency = getgenv().VisualizeTransparency
                    end 
                end 
            end})
            velocity_section:Dropdown({name = "Type", pointer = 'velocity_type', options = {"Manual", "Disable Prediction","Prediction Multiplier","Unhittable","Follow Camera"}, default = 'Manual'})
            velocity_section:Slider({name = "X", max = 50, min = -50, default = 0, pointer = 'Velocity_X', decimals = 1}) 
            velocity_section:Slider({name = "Y", max = 50, min = -50, default = 0, pointer = 'Velocity_Y', decimals = 1}) 
            velocity_section:Slider({name = "Z", max = 50, min = -50, default = 0, pointer = 'Velocity_Z', decimals = 1}) 
            velocity_section:Slider({name = "Unhittable Power", max = 14, min = 0, default = 14, pointer = 'unhittable_power', decimals = 0.1}) 
            velocity_section:Slider({name = "Follow Camera Power", max = 20, min = 0, default = 10, pointer = 'follow_camera_power', decimals = 0.1}) 
            velocity_section:Slider({name = "Prediction Multiplier Power", max = 20, min = 0, default = 2, pointer = 'prediction_multiplier_power', decimals = 0.1}) 
        
            network_section:Toggle({name = "Physic Bug", pointer = 'senderrate',callback = function(a)
                if pointers["senderrate"]:get() then 
                    setfflag("S2PhysicsSenderRate", pointers["physic_delay"]:get())
                else 
                    setfflag("S2PhysicsSenderRate", 15)
                end 
            end});
            network_section:Slider({name = "Delay", max = 15, min = 0, default = 15, pointer = 'physic_delay', decimals = 0.1,callback = function(a)
                if pointers["senderrate"]:get() then 
                    setfflag("S2PhysicsSenderRate", pointers["physic_delay"]:get())
                end 
            end}) 
        end

        --// Shit Talk Section
        do 
            shit_talk:Toggle({name = "Enabled", pointer ='st'})
            shit_talk:Slider({name = "Delay", max = 10, min = 0, default = 1, pointer ='st_delay', decimals = 1});
            shit_talk:Dropdown({name = "Type", pointer ='st_type', options = {"Osiris","Yun","Specter","Anti Aim","Advertisement","Scottish"}, default = 'Osiris'})
        end 

        --// Stomp Changer
        do  
            stomp_changer:Toggle({name = "Enabled", pointer ='stomp_changer'})
            stomp_changer:Dropdown({name = "Type", pointer ='stomp_selection', options = {"Cosmic Slash","Glitch","Explosion","Airstrike","Heart","UFO"}, default = 'Cosmic Slash'})
        end 
    end 

    --// Player List
    do 

        getgenv().Player_List = players_page:PlayerList({})
        do
            local Player_List_Left = players_page:Section({name = "Target", side = "Left"})

            Player_List_Left:Button({name = "Teleport To", confirmation = false, callback = function()
                lp.Character.HumanoidRootPart.CFrame = game.Players[tostring(Player_List:GetSelection()[1])].Character.HumanoidRootPart.CFrame 
            end})
            -- 
            Player_List_Left:Toggle({pointer = "view_player_selection", name = "View", def = false,callback = function()
                if pointers["view_player_selection"]:get() then 
                    CC.CameraSubject = game.Players[tostring(Player_List:GetSelection()[1])].Character.Humanoid
                else 
                    CC.CameraSubject = lp.Character.Humanoid
                end 
            end})
            --
            Player_List_Left:Toggle({pointer = "fling_player", name = "Fling Player", def = false})
            --[[
                1 - User
                2 - User
                3 - Priority Stuff
                4 - Selected Boolean
            ]]
            --
            Player_List_Left:Button({name = "Fix Camera", confirmation = false, callback = function()
                CC.CameraSubject = lp.Character.Humanoid
            end})
        end 
    end 

    --// Settings
    do
        local config_section = settings_page:Section({name = "Configuration", side = "Left"})
        local menu_section = settings_page:Section({name = "Menu"}) 
        local other_section = settings_page:Section({name = "Other", side = "Right"}) 
        local themes_section = settings_page:Section({name = "Themes", side = "Right"}) 

        --// Configs 
        do
            local current_list = {}
            local function update_config_list()
                local list = {}
                for idx, file in ipairs(listfiles("OsirisPro/configs")) do
                    local file_name = file:gsub("OsirisPro/configs\\", ""):gsub(".txt", "")
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
                    pointers["settings/configuration/list"]:UpdateList(list, false, true)
                end
            end

            config_section:Listbox({pointer = "settings/configuration/list"})
            config_section:Textbox({pointer = "settings/configuration/name", placeholder = "Config Name", text = "", middle = true, reset_on_focus = false})
            config_section:Button({name = "Create", confirmation = true, callback = function()
                    local config_name = pointers["settings/configuration/name"]:get()
                    if config_name == "" or isfile("OsirisPro/configs/" .. config_name .. ".txt") then
                        return
                    end
    
                    writefile("OsirisPro/configs/" .. config_name .. ".txt", "")
                    update_config_list()

                end})
            config_section:Button({name = "Load", confirmation = true, callback = function()
                    local selected_config = pointers["settings/configuration/list"]:get()[1][1]
                    if selected_config then
                        window:LoadConfig(readfile("OsirisPro/configs/" .. selected_config .. ".txt"))
                    end
                end})
            config_section:Button({name = "Save", confirmation = true, callback = function()
                    local selected_config = pointers["settings/configuration/list"]:get()[1][1]
                    writefile("OsirisPro/configs/" .. selected_config .. ".txt", window:GetConfig())
                end})
            config_section:Button({name = "Delete", confirmation = true, callback = function()
                    local selected_config = pointers["settings/configuration/list"]:get()[1][1]
                    if selected_config then
                        delfile("OsirisPro/configs/" .. selected_config .. ".txt")
                        update_config_list()
                    end
                end})

            m_thread.spawn_loop(3, update_config_list)
        end
        --// Menu 
        do
            --
            menu_section:Keybind({pointer = "settings/menu/bind", name = "Bind", default = Enum.KeyCode.Home, callback = function(p_state)
                window.uibind = p_state
            end})
            --
            menu_section:Toggle({pointer = "settings/menu/watermark", name = "Watermark", callback = function(p_state)
                window.watermark:Update("Visible", p_state)
            end})
            --
            menu_section:Textbox({placeholder = "Text", middle = true, pointer = 'watermarktext',text = "Osiris PRO | {fps} | {game} | {name} | {ping} | {date}",callback = function()
                library.watermarktext = pointers["watermarktext"]:get()
            end})
            --
            menu_section:Toggle({pointer = "settings/menu/keybind_list", name = "Keybind List", callback = function(p_state)
                window.keybindslist:Update("Visible", p_state)
            end})
            --
            menu_section:Toggle({pointer = "settings/menu/serversided_stats", name = "ServerSided Stats", callback = function(p_state)
                window.VisualPreview:SetPreviewState(p_state)
            end})
            window.VisualPreview:SetPreviewState(false)
            --
        end 
        --// Other
        do
            other_section:Button({name = "Copy JobId", callback = function()
                setclipboard(game.JobId)
            end})
            --
            other_section:Button({name = "Copy GameID", callback = function()
                setclipboard(game.GameId)
            end})
            --
            other_section:Button({name = "Copy Game Invite", callback = function()
                setclipboard('Roblox.GameLauncher.joinGameInstance('..game.PlaceId..',"'..game.JobId..'")')
            end})
            --
            other_section:Button({name = "Rejoin", confirmation = true, callback = function()
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
            end})
        end
        --// Themes
        do
            getgenv().AccentTheme = themes_section:Colorpicker({pointer = "themes/menu/accent", name = "Accent", default = Color3.fromRGB(210, 4, 45), callback = function(p_state)
                library:UpdateColor("Accent", p_state)
                Value_Slider.Color = p_state
                Accent.Color = p_state
                
            end})
            themes_section:Colorpicker({pointer = "settings/menu/lightcontrast", name = "Light Contrast", default = Color3.fromRGB(30, 30, 30), callback = function(p_state)
                library:UpdateColor("lightcontrast", p_state)
                Frame.Color = p_state
            end})   
            themes_section:Colorpicker({pointer = "settings/menu/darkcontrast", name = "Dark Constrast", default = Color3.fromRGB(25, 25, 25), callback = function(p_state)
                library:UpdateColor("darkcontrast", p_state)
            end})
            themes_section:Colorpicker({pointer = "settings/menu/outline", name = "Outline", default = Color3.fromRGB(0, 0, 0), callback = function(p_state)
                library:UpdateColor("outline", p_state)
            end})
            themes_section:Colorpicker({pointer = "settings/menu/inline", name = "Inline", default = Color3.fromRGB(50, 50, 50), callback = function(p_state)
                library:UpdateColor("inline", p_state)
            end})   
            themes_section:Colorpicker({pointer = "settings/menu/textcolor", name = "Text Color", default = Color3.fromRGB(255, 255, 255), callback = function(p_state)
                library:UpdateColor("textcolor", p_state)
            end})
            themes_section:Colorpicker({pointer = "settings/menu/textborder", name = "Text Border", default = Color3.fromRGB(0, 0, 0), callback = function(p_state)
                library:UpdateColor("textborder", p_state)
            end})
            themes_section:Colorpicker({pointer = "settings/menu/cursoroutline", name = "Cursor Outline", default = Color3.fromRGB(10, 10, 10), callback = function(p_state)
                library:UpdateColor("cursoroutline", p_state)
            end})   
            -- 
            themes_section:Dropdown({name = "Themes",options = ThemeNames, pointer = "Theme",max = 5})
            --
            themes_section:Button({name = "Load", confirmation = true, callback = function(callback)
                pointers["themes/menu/accent"]:set(client.Themes[pointers["Theme"]:get()].Accent, 0)
                pointers["settings/menu/lightcontrast"]:set(client.Themes[pointers["Theme"]:get()].lightcontrast, 0)
                pointers["settings/menu/darkcontrast"]:set(client.Themes[pointers["Theme"]:get()].darkcontrast, 0)
                pointers["settings/menu/outline"]:set(client.Themes[pointers["Theme"]:get()].outline, 0)
                pointers["settings/menu/inline"]:set(client.Themes[pointers["Theme"]:get()].inline, 0)
                pointers["settings/menu/textcolor"]:set(client.Themes[pointers["Theme"]:get()].textcolor, 0)
                pointers["settings/menu/textborder"]:set(client.Themes[pointers["Theme"]:get()].textborder, 0)
            end})
            --
            themes_section:Toggle({pointer = "Rainbow Accent", name = "Rainbow Accent"})
            --
            themes_section:Slider({name = "Rainbow Speed", def = 10, min = 1, max = 4, sub = "", decimals = 0.01, pointer = "Rainbow Speed"})
        end
    end

    window.uibind = Enum.KeyCode.RightControl
--// Code
    task.spawn(LPH_NO_VIRTUALIZE(function()
        while Run.RenderStepped:Wait() do 

            if pointers["settings/menu/visuals_aspect"]:get() then 
                Camera.CFrame = Camera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, pointers["settings/menu/visuals_aspect_ratio_x"]:get()/100, 0, 0, 0, 1)
            end 
                
            if lp.Character:FindFirstChildWhichIsA("Tool") ~= nil and lp.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Handle") ~= nil and pointers["custom_gun_sfx"]:get() then 
                for _,v in pairs(lp.Character:FindFirstChildWhichIsA("Tool").Handle:GetChildren()) do 
                    if v:IsA("Sound") and v.Name ~= "NoAmmo" then 
                        v.SoundId = "rbxassetid://" .. client.sfx[pointers["Sound"]:get()]
                    end 
                end 
            end 
            --//
            

            if lp.Character ~= nil then
                delay(3,function()
                    if getgenv().Loop then 
                        getgenv().Loop:Disconnect()
                    end 
    
                    if tool() and pointers["bullet_tracers"]:get() and tool():FindFirstChild("Ammo") then  
                        getgenv().Loop = tool().Ammo.Changed:Connect(function()
                            if tool().Ammo.Value ~= tool().MaxAmmo.Value then 
                                createBeam(tool().Handle.Position, lp.Character.BodyEffects.MousePos.Value) 
                                Run.RenderStepped:Wait()
                                for i,v in pairs(ws.Ignored:GetChildren()) do 
                                    if v:IsA("Part") and v.Name == "BULLET_RAYS" then 
                                        v:Destroy()
                                    end 
                                end 
                            end 
                        end)
                    end 
                end) 
            end 
        end
    end))

    local function anti_aim_viewer()
        if pointers["aim_viewer_bypass"]:get() or pointers["lock_type"]:get() == "Silent Aim" then 
            print("0")
            if pointers["lock_type"]:get() == "Silent Aim" then 
                getgenv().Target = getClosestPlayerToCursor(math.huge)
            end 
            print("1")

            getgenv().HitPart = ClosestPart(Target,pointers["hitpart"]:get()).Name
            getgenv().BehindWall = WallCheck(Target.Character.Head)
            getgenv().Knocked = KnockCheck(Target) 
            getgenv().InFOVRange = FOVCHECK(Target) 
            print("2")

            if Target ~= nil and pointers["lock_enabled"]:get() and Target.Character and not getgenv().BehindWall and getgenv().InFOVRange then
                if pointers["resolver"]:get() and pointers["resolver_keybind"]:is_active() then 
                    local endpoint = Target.Character[HitPart].Position + (ResolverPrediction * pointers["lock_prediction"]:get()) + Vector3.new(0.1,jump_offset,0.1)
                    Remote:FireServer("UpdateMousePos", endpoint) 
                    print("3")
                else 
                    local endpoint = Target.Character[HitPart].Position + (Target.Character.HumanoidRootPart.Velocity *  pointers["lock_prediction"]:get()) + Vector3.new(0.1,jump_offset,0.1)
                    Remote:FireServer("UpdateMousePos", endpoint) 
                    print("3")
                end 
            end
        end 
    end

    client.connections["anti aim viewer"] = {} 

    for _,v in pairs(lp.Backpack:GetChildren()) do
        if v:IsA("Tool") and not client.connections["anti aim viewer"][v] then
            client.connections["anti aim viewer"][v] = v.Activated:Connect(anti_aim_viewer)
        end
    end
    for _,v in pairs(lp.Character:GetChildren()) do
        if v:IsA("Tool") and not client.connections["anti aim viewer"][v] then
            client.connections["anti aim viewer"][v] = v.Activated:Connect(anti_aim_viewer)
        end
    end
    lp.Character.ChildAdded:connect(function(v)
        if v:IsA("Tool") and not client.connections["anti aim viewer"][v] then
            client.connections["anti aim viewer"][v] = v.Activated:Connect(anti_aim_viewer)
        end
    end)
    lp.CharacterAdded:connect(function(v)
        for i = 1, #client.connections["anti aim viewer"], 1 do
            client.connections["anti aim viewer"][i]:Disconnect()
            client.connections["anti aim viewer"][i] = nil
        end
        v.ChildAdded:connect(function(v)
            if v:IsA("Tool") and not client.connections["anti aim viewer"][v] then
                client.connections["anti aim viewer"][v] = v.Activated:Connect(anti_aim_viewer)
            end
        end)
    end)

    Run:BindToRenderStep("ESP", 1, LPH_NO_VIRTUALIZE(function()
        if library.pointers["settings/menu/esp_enabled"]:get() then 
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
        end 
    end))

    local TargetCheck
    Run:BindToRenderStep("Main", 1, LPH_NO_VIRTUALIZE(function(FPS)
        if pointers["custom_cursor"]:get() then 
            UIS.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide
            if pointers["spinning_cursor"]:get() then 
                getgenv().SpinSize = pointers["cursor_gap"]:get()

                if pointers["dynamic_spin"]:get() then 
                    Speed = abs(sin(tick() * 1))
                    SpinAngle += rad(Speed*pointers["spin_speed"]:get()*5*FPS) 
                end 
    
                if not pointers["dynamic_spin"]:get() then 
                    SpinAngle += rad(pointers["spin_speed"]:get()*FPS)
                end 

                if pointers["sine_animation"]:get() then 
                    getgenv().SpinSize = ((pointers["cursor_gap"]:get() * (abs(sin(tick() * pointers["sine_animation_speed"]:get()) + pointers["sine_animation_offset"]:get())))) 
                end     

                Cursor.Line1.From = Vector2.new(Mouse.X,Mouse.Y + 36) + (Vector2.new(cos(SpinAngle), sin(SpinAngle))*(SpinSize * 5));
                Cursor.Line1.To = Cursor.Line1.From + (Vector2.new(cos(SpinAngle), sin(SpinAngle))*(pointers["cursor_size"]:get()*5));
                Cursor.Line2.From = Vector2.new(Mouse.X,Mouse.Y + 36)  + (Vector2.new(cos(SpinAngle + pi/2), sin(SpinAngle + pi/2))*(SpinSize * 5));
                Cursor.Line2.To = Cursor.Line2.From + (Vector2.new(cos(SpinAngle + pi/2), sin(SpinAngle + pi/2))*(pointers["cursor_size"]:get()*5));
                Cursor.Line3.From = Vector2.new(Mouse.X,Mouse.Y + 36)  + (Vector2.new(cos(SpinAngle + pi), sin(SpinAngle + pi))*(SpinSize * 5));
                Cursor.Line3.To = Cursor.Line3.From + (Vector2.new(cos(SpinAngle + pi), sin(SpinAngle + pi))*(pointers["cursor_size"]:get()*5));
                Cursor.Line4.From = Vector2.new(Mouse.X,Mouse.Y + 36)  + (Vector2.new(cos(SpinAngle + pi/2*3), sin(SpinAngle + pi/2*3))*(SpinSize * 5));
                Cursor.Line4.To = Cursor.Line4.From + (Vector2.new(cos(SpinAngle + pi/2*3), sin(SpinAngle + pi/2*3))*(pointers["cursor_size"]:get()*5));

                Outlines.OutlineLine1.From = Vector2.new(Mouse.X,Mouse.Y + 36) + (Vector2.new(cos(SpinAngle), sin(SpinAngle))*(SpinSize * 5));
                Outlines.OutlineLine1.To = Cursor.Line1.From + (Vector2.new(cos(SpinAngle), sin(SpinAngle))*(pointers["cursor_size"]:get()*5));
                Outlines.OutlineLine2.From = Vector2.new(Mouse.X,Mouse.Y + 36)  + (Vector2.new(cos(SpinAngle + pi/2), sin(SpinAngle + pi/2))*(SpinSize * 5));
                Outlines.OutlineLine2.To = Cursor.Line2.From + (Vector2.new(cos(SpinAngle + pi/2), sin(SpinAngle + pi/2))*(pointers["cursor_size"]:get()*5));
                Outlines.OutlineLine3.From = Vector2.new(Mouse.X,Mouse.Y + 36)  + (Vector2.new(cos(SpinAngle + pi), sin(SpinAngle + pi))*(SpinSize * 5));
                Outlines.OutlineLine3.To = Cursor.Line3.From + (Vector2.new(cos(SpinAngle + pi), sin(SpinAngle + pi))*(pointers["cursor_size"]:get()*5));
                Outlines.OutlineLine4.From = Vector2.new(Mouse.X,Mouse.Y + 36)  + (Vector2.new(cos(SpinAngle + pi/2*3), sin(SpinAngle + pi/2*3))*(SpinSize * 5));
                Outlines.OutlineLine4.To = Cursor.Line4.From + (Vector2.new(cos(SpinAngle + pi/2*3), sin(SpinAngle + pi/2*3))*(pointers["cursor_size"]:get()*5));
            end 
            
            if not pointers["spinning_cursor"]:get() then 
                Cursor.Line1.From = Vector2.new(Mouse.X + pointers["cursor_gap"]:get() * 5 , Mouse.Y + 36)
                Cursor.Line1.To = Vector2.new(Mouse.X + pointers["cursor_size"]:get() * 5, Mouse.Y+ 36)
                Cursor.Line2.From = Vector2.new(Mouse.X - pointers["cursor_gap"]:get() * 5, Mouse.Y+ 36)
                Cursor.Line2.To = Vector2.new(Mouse.X - pointers["cursor_size"]:get() * 5 , Mouse.Y+ 36)
                Cursor.Line3.From = Vector2.new(Mouse.X, Mouse.Y - pointers["cursor_gap"]:get() * 5 + 36)
                Cursor.Line3.To = Vector2.new(Mouse.X, Mouse.Y - pointers["cursor_size"]:get() * 5+ 36)
                Cursor.Line4.From = Vector2.new(Mouse.X, Mouse.Y + pointers["cursor_gap"]:get() * 5+ 36)
                Cursor.Line4.To = Vector2.new(Mouse.X, Mouse.Y + pointers["cursor_size"]:get() * 5+ 36)
                
                Outlines.OutlineLine1.From = Vector2.new(Mouse.X + pointers["cursor_gap"]:get() * 5, Mouse.Y + 36)
                Outlines.OutlineLine1.To = Vector2.new(Mouse.X + pointers["cursor_size"]:get() * 5, Mouse.Y+ 36)
                Outlines.OutlineLine2.From = Vector2.new(Mouse.X - pointers["cursor_gap"]:get() * 5, Mouse.Y+ 36)
                Outlines.OutlineLine2.To = Vector2.new(Mouse.X - pointers["cursor_size"]:get() * 5 , Mouse.Y+ 36)
                Outlines.OutlineLine3.From = Vector2.new(Mouse.X, Mouse.Y - pointers["cursor_gap"]:get() * 5 + 36)
                Outlines.OutlineLine3.To = Vector2.new(Mouse.X, Mouse.Y - pointers["cursor_size"]:get() * 5+ 36)
                Outlines.OutlineLine4.From = Vector2.new(Mouse.X, Mouse.Y + pointers["cursor_gap"]:get() * 5+ 36)
                Outlines.OutlineLine4.To = Vector2.new(Mouse.X, Mouse.Y + pointers["cursor_size"]:get()* 5+ 36)
            end 
        end 
        --
        if pointers["fling_player"]:get() then 
            local OldVelocityFling = lp.Character.HumanoidRootPart.Velocity
            lp.Character.HumanoidRootPart.CFrame = game.Players[tostring(Player_List:GetSelection()[1])].Character.HumanoidRootPart.CFrame 
            lp.Character.HumanoidRootPart.Velocity = Vector3.new(0,1,0) * -16384
            Run.RenderStepped:Wait() 
            lp.Character.HumanoidRootPart.Velocity = OldVelocityFling
            lp.Character.HumanoidRootPart.CFrame = game.Players[tostring(Player_List:GetSelection()[1])].Character.HumanoidRootPart.CFrame 
        end 
        --
        if pointers["aim_assist_enabled"]:get() and pointers["aim_assist_key"]:is_active() then 
            if GetRenderProperty(Lock, "Visible") then -- GetRenderProperty(Name, "Text") then 
                getgenv().InFOVRangeAimAssist = FOVCHECK(CTarget) 
            else 
                getgenv().InFOVRangeAimAssist = true 
            end 

            if pointers["aim_assist_resolver"]:get() and pointers["aim_assist_resolver_keybind"]:is_active() then 
                getgenv().Main = CC:WorldToScreenPoint(CTarget.Character[pointers["aim_assist_hitbox"]:get()].Position + (get_calculated_velocity(CTarget) * pointers["aim_assist_prediction"]:get()))
            else 
                getgenv().Main = CC:WorldToScreenPoint(CTarget.Character[pointers["aim_assist_hitbox"]:get()].Position + (CTarget.Character.HumanoidRootPart.Velocity * pointers["aim_assist_prediction"]:get()))
            end 

            if InFOVRangeAimAssist then 
                mousemoverel(Vector2.new(Main.X - Mouse.X,Main.Y - Mouse.Y).X / (pointers["x_smoothing"]:get() + 1), Vector2.new(Main.X - Mouse.X,Main.Y - Mouse.Y).Y / (pointers["y_smoothing"]:get() + 1))
            end 
        end 
        --
        if pointers["velocity_desync"]:get() and lp.Character then   
            local DesyncVelocitys = {
                ["Manual"] = Vector3.new(pointers["Velocity_X"]:get()/2500,pointers["Velocity_Y"]:get()/2500,pointers["Velocity_Z"]:get()/2500) * 16384,
                ["Disable Prediction"] = Vector3.new(0,0,0),
                ["Follow Camera"] = (Mouse.hit.p - lp.Character.HumanoidRootPart.Position).Unit * (pointers["follow_camera_power"]:get()*5) + Camera.CFrame.LookVector * (pointers["follow_camera_power"]:get()*5),
                ["Prediction Multiplier"] = lp.Character.HumanoidRootPart.Velocity * pointers["prediction_multiplier_power"]:get(),
                ["Unhittable"] = Vector3.new(1,1,1) * -(2^pointers["unhittable_power"]:get()),      
            }
            getgenv().OldVelocity = lp.Character.HumanoidRootPart.Velocity
            if pointers["velocity_desync_key"]:is_active() then 
                lp.Character.HumanoidRootPart.Velocity = DesyncVelocitys[pointers["velocity_type"]:get()]
                lp.Character.HumanoidRootPart.CFrame = lp.Character.HumanoidRootPart.CFrame * CFrame.Angles(0,rad(0.001),0)                    
                getgenv().Visualizer = lp.Character.HumanoidRootPart.Velocity
                if pointers["visualize_velocity"]:get() then 
                    if getgenv().Visualizer ~= nil then 
                        Visualizevelocity.HumanoidRootPart.CFrame = CFrame.new(lp.Character.HumanoidRootPart.Position + getgenv().Visualizer * 0.1413)
                    end 
                end 

                if pointers["settings/menu/serversided_stats"]:get() then 
                    getgenv().Stats[1].Text = "Velocity: " .. tostring(floor(lp.Character.HumanoidRootPart.Velocity.X)..", "..floor(lp.Character.HumanoidRootPart.Velocity.Y) ..", "..floor(lp.Character.HumanoidRootPart.Velocity.Z))
                end 
                
                Run.RenderStepped:Wait()
                lp.Character.HumanoidRootPart.Velocity = getgenv().OldVelocity
            end 
        end
        --
        if pointers["anti_slow_down"]:get() and lp.Character then 
            if lp.Character.BodyEffects.Reload.Value then
                lp.Character.BodyEffects.Reload.Value = false
            end
            local Slowdowns = lp.Character.BodyEffects.Movement:FindFirstChild('NoJumping') or lp.Character.BodyEffects.Movement:FindFirstChild('NoWalkSpeed') or lp.Character.BodyEffects.Movement:FindFirstChild('ReduceWalk')
            if Slowdowns then
                Slowdowns:Destroy()
            end
        end 
        --
        if pointers["anti_jump_cooldown"]:get() and lp.Character then 
            lp.Character.Humanoid.UseJumpPower = false
        end 
        --
        if pointers["auto_pick_up_money"]:get() then 
            for i,v in pairs(ws.Ignored.Drop:GetChildren()) do 
                if v.Name == "MoneyDrop" then 
                    if (v.Position - lp.Character.HumanoidRootPart.Position).Magnitude < 25 then 
                        fireclickdetector(v.ClickDetector)
                    end 
                end 
            end 
        end 
        --
        if pointers["auto_stomp"]:get() then 
            ReplicatedStorage.MainEvent:FireServer("Stomp")
        end 
        --
        if pointers["auto_reload"]:get() then 
            if lp.Character:FindFirstChildWhichIsA("Tool") ~= nil then
                if lp.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo") then
                    if lp.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo").Value <= 0 and lp.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo").Value == 0  then
                        ReplicatedStorage.MainEvent:FireServer("Reload",lp.Character:FindFirstChildWhichIsA("Tool"))
                    end
                end
            end
        end 
        --  
        if pointers["speed"]:get() and pointers["speed_key"]:is_active() and lp.Character and not Holding then 
            lp.Character.HumanoidRootPart.CFrame = lp.Character.HumanoidRootPart.CFrame + lp.Character.Humanoid.MoveDirection * (pointers["speed_power"]:get()/25)
            if pointers["auto_jump"]:get() and lp.Character.Humanoid.FloorMaterial ~= Enum.Material.Air then 
                lp.Character.Humanoid:ChangeState("Jumping")
                lp.Character.Humanoid.UseJumpPower = false
            end     
        end 
        --
        if pointers["spin"]:get() and pointers["spin_key"]:is_active() then 
            lp.Character.HumanoidRootPart.CFrame = lp.Character.HumanoidRootPart.CFrame * CFrame.Angles(0,rad(pointers["spin_power"]:get()),0)
            lp.Character.Humanoid.AutoRotate = false
        end 
        --  
        if pointers["fly"]:get() and pointers["fly_key"]:is_active() and not Holding then 
            local FlyPosition = Vector3.new(0,0,0)
            local CCV = Camera.CFrame.lookVector
        
            if UIS:IsKeyDown(Enum.KeyCode.W) then
                FlyPosition = FlyPosition + CCV
            end
        
            if UIS:IsKeyDown(Enum.KeyCode.S) then
                FlyPosition = FlyPosition - CCV
            end
        
            if UIS:IsKeyDown(Enum.KeyCode.D) then
                FlyPosition = FlyPosition + Vector3.new(-CCV.Z, 0, CCV.X)
            end
        
            if UIS:IsKeyDown(Enum.KeyCode.A) then
                FlyPosition = FlyPosition + Vector3.new(CCV.Z, 0, -CCV.x)
            end
            
            if UIS:IsKeyDown(Enum.KeyCode.Space) then
                FlyPosition = FlyPosition + Vector3.new(0, 1, 0)
            end
            
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
                FlyPosition = FlyPosition - Vector3.new(0, 1, 0)
            end
            
            if FlyPosition.Unit.y == FlyPosition.Unit.y then
                lp.Character.HumanoidRootPart.Anchored = false 
                lp.Character.HumanoidRootPart.Velocity = FlyPosition.Unit * pointers["fly_speed"]:get()
            else 
                lp.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                lp.Character.HumanoidRootPart.Anchored = true
            end 
        end 
        --
        if pointers["jitter"]:get() and pointers["jitter_key"]:is_active() then 
            local RandomJit = random(1, 180)
            lp.Character.Humanoid.AutoRotate = false
            lp.Character.HumanoidRootPart.CFrame = CFrame.new(lp.Character.HumanoidRootPart.CFrame.Position) * CFrame.Angles(0, rad(RandomJit) + rad((random(1, 2) == 1 and RandomJit or -RandomJit)), 0) 
        end 
        --
        if Target ~= nil and pointers["lock_enabled"]:get() and pointers["lock_key"]:is_active() and Target.Character and Target.Character.Humanoid and KnockCheck(Target) then 
            getgenv().HitPart = ClosestPart(Target,pointers["hitpart"]:get()).Name
            getgenv().BehindWall = WallCheck(Target.Character.Head)
            getgenv().Knocked = KnockCheck(Target) 
            getgenv().InFOVRange = FOVCHECK(Target) 
            getgenv().Prediction = pointers["lock_prediction"]:get()
            ResolverPrediction = get_calculated_velocity(Target)

            if pointers["snap_line"]:get() and Target ~= nil then 
                local ScreenPosition = CC:WorldToScreenPoint(Target.Character[getgenv().HitPart].Position)
                Tracer.Visible = true 
                Tracer.From = Vector2.new(Mouse.X,Mouse.Y+36)
                Tracer.To = Vector2.new(ScreenPosition.X,ScreenPosition.Y+36)
            end 

            if Target.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then 
                getgenv().jump_offset = pointers["jump_offset"]:get()
            else 
                getgenv().jump_offset = 0
            end 
        
            if pointers["target_strafe"]:get() then 
                Angle += pointers["strafe_speed"]:get()
                lp.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, rad(Angle), 0) * CFrame.new(0, pointers["strafe_height"]:get(), pointers["strafe_radius"]:get())
            end 

            if pointers["look_at"]:get() and lp.Character then 
                lp.Character.Humanoid.AutoRotate = false 
                local OldCframe = lp.Character.PrimaryPart
                local NearestRoot = Target.Character.HumanoidRootPart
                local NearestPos = CFrame.new(lp.Character.PrimaryPart.Position, Vector3.new(NearestRoot.Position.X, OldCframe.Position.Y, NearestRoot.Position.Z))
                lp.Character:SetPrimaryPartCFrame(NearestPos)
            end 
            
            if pointers["part_enabled"]:get() then 
                if pointers["part_velocity_enabled"]:get() then 
                    TargetPart.CFrame = Target.Character[HitPart].CFrame + (Target.Character.HumanoidRootPart.Velocity * Prediction)
                else 
                    TargetPart.CFrame = Target.Character[HitPart].CFrame
                end 
            end 

            if pointers["part_chams"]:get() then 
                for Index,Value in pairs(game.Workspace.Terrain:GetChildren()) do 
                    if Value:IsA("BasePart") then 
                        Value.Position = Target.Character[Value.Name].Position + Target.Character.HumanoidRootPart.Velocity * 0.1413
                        Value.Rotation = Target.Character[Value.Name].Rotation
                    end     
                end 
            end 
        end 
        --
        if pointers["settings/menu/visuals_custom_ambient"]:get() then
            Lighting.Ambient = pointers["settings/menu/visuals_ambient"]:get().Color
            Lighting.OutdoorAmbient = pointers["settings/menu/visuals_outdoor_ambient"]:get().Color
        end
        --
        if pointers["settings/menu/visuals_custom_color_shift"]:get() then
            Lighting.ColorShift_Top = pointers["settings/menu/visuals_custom_color_shift_top"]:get().Color
            Lighting.ColorShift_Bottom = pointers["settings/menu/visuals_custom_color_shift_bottom"]:get().Color
        end
        --
        if pointers["settings/menu/visuals_custom_brightness"]:get() then
            Lighting.Brightness = pointers["settings/menu/visuals_custom_brightness_number"]:get()
        end
        --
        if pointers["settings/menu/visuals_custom_exposure"]:get() then
            Lighting.ExposureCompensation = pointers["settings/menu/visuals_custom_exposure_number"]:get()
        end
        --
        if pointers["settings/menu/visuals_custom_clock_time"]:get() then
            Lighting.ClockTime = pointers["settings/menu/visuals_custom_clock_time_number"]:get()
        end
        --
        if pointers["settings/menu/visuals_fog"]:get() then
            Lighting.FogStart = pointers["settings/menu/visuals_fog_start"]:get()
            Lighting.FogEnd = pointers["settings/menu/visuals_fog_end"]:get()
            Lighting.FogColor = pointers["settings/menu/visuals_fog_color"]:get().Color
        end
        --
        if pointers["settings/menu/visuals_custom_fov"]:get() then
            Camera.FieldOfView = pointers["settings/menu/visuals_custom_fov_number"]:get()
        end
        --
        if pointers["Rainbow Accent"]:get() then 
            local Color = Color3.fromHSV(abs(sin(tick()) / (5 - pointers["Rainbow Speed"]:get())),1,1)
            library:UpdateColor("Accent", Color)
            Value_Slider.Color = Color
            Accent.Color = Color
        end 
        --// Anti Cheat bypass
        for _, v in pairs(lp.Character:GetChildren()) do
            if v:IsA("Script") and v.Name ~= "Health" and v.Name ~= "Sound" and v:FindFirstChild("LocalScript") then
                v:Destroy()
            end
        end
        --// Target Stats Health Updater
        if Target ~= nil and pointers["lock_enabled"]:get() and pointers["lock_key"]:is_active() and Target and Target.Character and Target.Character.Humanoid ~= nil and pointers["target_stats"]:get() then 
            Sliders["Health"]:Set(floor(Target.Character.Humanoid.MaxHealth) / 100, (floor(floor(Target.Character.Humanoid.Health) / 0.01) * 0.01) .. "")
        end 
    end))
    
    Wanted:GetPropertyChangedSignal("Value"):Connect(function()
        if pointers["stomp_changer"]:get() then 
            if tonumber(Wanted.Value) == tonumber(OldWanted + 50) then
                task.spawn(function()
                    if Stomping == true then
                        local Part = workspace:FindPartOnRayWithIgnoreList(Ray.new(lp.Character.LowerTorso.Position, Vector3.new(0, -lp.Character.UpperTorso.Size.y * 4.5, 0)), { lp.Character, unpack(require(game.ReplicatedStorage.MainModule).Ignored) })
                        if Part and Part:IsDescendantOf(workspace.Players) then
                            task.spawn(function()
                                pcall(function()
                                    if Part.Name == "HumanoidRootPart" then
                                        Part = Part.Parent.UpperTorso
                                    end
                                end)
                            end)
                            local Humanoid
                            pcall(function()
                                if Part.Parent:FindFirstChildOfClass('Humanoid') then
                                    Humanoid = Part.Parent:FindFirstChildOfClass('Humanoid')
                                elseif Part.Parent.Parent:FindFirstChildOfClass('Humanoid') then
                                    Humanoid = Part.Parent.Parent:FindFirstChildOfClass('Humanoid')
                                elseif Part.Parent.Parent.Parent:FindFirstChildOfClass('Humanoid') then
                                    Humanoid = Part.Parent.Parent.Parent:FindFirstChildOfClass('Humanoid')
                                elseif Part.Parent.Parent.Parent.Parent:FindFirstChildOfClass('Humanoid') then
                                    Humanoid = Part.Parent.Parent.Parent.Parent:FindFirstChildOfClass('Humanoid')
                                elseif Part.Parent.Parent.Parent.Parent.Parent:FindFirstChildOfClass('Humanoid') then
                                    Humanoid = Part.Parent.Parent.Parent.Parent.Parent:FindFirstChildOfClass('Humanoid')
                                elseif Part.Parent.Parent.Parent.Parent.Parent.Parent:FindFirstChildOfClass('Humanoid') then
                                    Humanoid = Part.Parent.Parent.Parent.Parent.Parent.Parent:FindFirstChildOfClass('Humanoid')
                                end
                            end)
                            if Humanoid and Humanoid.Parent.BodyEffects["K.O"].Value == true then
                                if Humanoid.Parent:FindFirstChild("GRABBING_CONSTRAINT") then
                                    return
                                end
                                local vCharacter = Humanoid.Parent
                                local vPlayer = Players:GetPlayerFromCharacter(vCharacter)
                                if pointers["stomp_selection"]:get() == "Explosion" then
                                    Explode(vCharacter)
                                end 

                                if pointers["stomp_selection"]:get() == "Airstrike" then
                                    AirStrike(vCharacter)
                                end
                                if pointers["stomp_selection"]:get() == "Heart" then
                                    Heart(vCharacter)
                                end
                                if pointers["stomp_selection"]:get() == "UFO" then
                                    UFO(vCharacter)
                                end
                                if pointers["stomp_selection"]:get() == "Glitch" then
                                    Glitch(vCharacter)
                                end
                                if pointers["stomp_selection"]:get() == "Cosmic Slash" then
                                    CosmicSlash(vCharacter)
                                end
                            end
                        end
                    end
                end)
            end
            OldWanted = Wanted.Value
        end 
    end)

    local Old; Old = hookmetamethod(game, "__namecall", LPH_NO_VIRTUALIZE(function(self,...)
        if tostring(self.Name) == "MainEvent" then 
            local args = {...}

            if pointers["stomp_changer"]:get() and tostring(args[1]) == "Stomp" then 
                Stomping = true
                delay(0.8,function()
                    Stomping = false 
                end)
            end 

            if pointers["aim_viewer_bypass"]:get() == false and getnamecallmethod() == "FireServer" and args[1] == "UpdateMousePos" and Target ~= nil and pointers["lock_enabled"]:get() and Target.Character and not getgenv().BehindWall and getgenv().InFOVRange then
                if pointers["resolver"]:get() and pointers["resolver_keybind"]:is_active() then 
                    args[2] = Target.Character[HitPart].Position + (ResolverPrediction * pointers["lock_prediction"]:get()) + Vector3.new(0.1,jump_offset,0.1)
                else 
                    args[2] = Target.Character[HitPart].Position + (Target.Character.HumanoidRootPart.Velocity *  pointers["lock_prediction"]:get()) + Vector3.new(0.1,jump_offset,0.1)
                end 
                return Old(self, unpack(args))
            end
        end  
        return Old(self, ...)
    end))

    window:Initialize()

    UIS.InputChanged:Connect(function(input,typing)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            SetRenderProperty(Lock, "Position", v2(Mouse.X,Mouse.Y + 36))
            LockOutline.Position = Vector2.new(Mouse.X,Mouse.Y + 36)
        end

        if typing and input.UserInputType ~= Enum.UserInputType.MouseMovement then 
            getgenv().Holding = typing
        else 
            getgenv().Holding = false
        end 
    end)
end 



if game.Players.LocalPlayer.Character:FindFirstChild("BodyEffects") then 
    DaHood()
elseif game.Players.LocalPlayer.Character:FindFirstChild("I_LOADED_I") then 
    DaHoodModded()
else
    print("Universal")
end 