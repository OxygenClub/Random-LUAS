-- nigga
--rconsolename'i love memz'
local teckosaweg = tick()
local esp = loadstring(game:HttpGet(('https://pastebin.com/raw/E8d9GpCm'), true))();
local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'

--
local httpService = game:GetService('HttpService')
local ThemeManager = {} do
	ThemeManager.Folder = 'LinoriaLibSettings'
	-- if not isfolder(ThemeManager.Folder) then makefolder(ThemeManager.Folder) end

	ThemeManager.Library = nil
	ThemeManager.BuiltInThemes = {
		['Default'] 		= { 1, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1c1c1c","AccentColor":"0055ff","BackgroundColor":"141414","OutlineColor":"323232"}') },
		['BBot'] 			= { 2, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1e1e1e","AccentColor":"7e48a3","BackgroundColor":"232323","OutlineColor":"141414"}') },
		['Fatality']		= { 3, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1e1842","AccentColor":"c50754","BackgroundColor":"191335","OutlineColor":"3c355d"}') },
		['Jester'] 			= { 4, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"242424","AccentColor":"db4467","BackgroundColor":"1c1c1c","OutlineColor":"373737"}') },
		['Mint'] 			= { 5, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"242424","AccentColor":"3db488","BackgroundColor":"1c1c1c","OutlineColor":"373737"}') },
		['Tokyo Night'] 	= { 6, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"191925","AccentColor":"6759b3","BackgroundColor":"16161f","OutlineColor":"323232"}') },
		['Ubuntu'] 			= { 7, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"3e3e3e","AccentColor":"e2581e","BackgroundColor":"323232","OutlineColor":"191919"}') },
		['Quartz'] 			= { 8, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"232330","AccentColor":"426e87","BackgroundColor":"1d1b26","OutlineColor":"27232f"}') },
	}

	function ThemeManager:ApplyTheme(theme)
		local customThemeData = self:GetCustomTheme(theme)
		local data = customThemeData or self.BuiltInThemes[theme]

		if not data then return end

		-- custom themes are just regular dictionaries instead of an array with { index, dictionary }

		local scheme = data[2]
		for idx, col in next, customThemeData or scheme do
			self.Library[idx] = Color3.fromHex(col)
			
			if Options[idx] then
				Options[idx]:SetValueRGB(Color3.fromHex(col))
			end
		end

		self:ThemeUpdate()
	end

	function ThemeManager:ThemeUpdate()
		-- This allows us to force apply themes without loading the themes tab :)
		local options = { "FontColor", "MainColor", "AccentColor", "ImageColor", "BackgroundColor", "OutlineColor" }
		for i, field in next, options do
			if Options and Options[field] then
				self.Library[field] = Options[field].Value
			end
		end

		self.Library.AccentColorDark = self.Library:GetDarkerColor(self.Library.AccentColor);
		self.Library:UpdateColorsUsingRegistry()
	end

	function ThemeManager:LoadDefault()		
		local theme = 'Default'
		local content = isfile(self.Folder .. '/themes/default.txt') and readfile(self.Folder .. '/themes/default.txt')

		local isDefault = true
		if content then
			if self.BuiltInThemes[content] then
				theme = content
			elseif self:GetCustomTheme(content) then
				theme = content
				isDefault = false;
			end
		elseif self.BuiltInThemes[self.DefaultTheme] then
		 	theme = self.DefaultTheme
		end

		if isDefault then
			Options.ThemeManager_ThemeList:SetValue(theme)
		else
			self:ApplyTheme(theme)
		end
	end

	function ThemeManager:SaveDefault(theme)
		writefile(self.Folder .. '/themes/default.txt', theme)
	end

	function ThemeManager:CreateThemeManager(groupbox)
		groupbox:AddLabel('Background color'):AddColorPicker('BackgroundColor', { Default = self.Library.BackgroundColor });
		groupbox:AddLabel('Main color')	:AddColorPicker('MainColor', { Default = self.Library.MainColor });
		groupbox:AddLabel('Accent color'):AddColorPicker('AccentColor', { Default = self.Library.AccentColor });
        groupbox:AddLabel('Image color'):AddColorPicker('ImageColor', { Default = self.Library.ImageColor });
		groupbox:AddLabel('Outline color'):AddColorPicker('OutlineColor', { Default = self.Library.OutlineColor });
		groupbox:AddLabel('Font color')	:AddColorPicker('FontColor', { Default = self.Library.FontColor });

		local ThemesArray = {}
		for Name, Theme in next, self.BuiltInThemes do
			table.insert(ThemesArray, Name)
		end

		table.sort(ThemesArray, function(a, b) return self.BuiltInThemes[a][1] < self.BuiltInThemes[b][1] end)

		groupbox:AddLine()
		groupbox:AddDropdown('ThemeManager_ThemeList', { Text = 'Theme list', Values = ThemesArray, Default = 1 })

		groupbox:AddButton('Set as default', function()
			self:SaveDefault(Options.ThemeManager_ThemeList.Value)
			self.Library:Notify(string.format('Set default theme to %q', Options.ThemeManager_ThemeList.Value))
		end)

		Options.ThemeManager_ThemeList:OnChanged(function()
			self:ApplyTheme(Options.ThemeManager_ThemeList.Value)
		end)

		groupbox:AddLine()
		groupbox:AddInput('ThemeManager_CustomThemeName', { Text = 'Custom theme name' })
		groupbox:AddDropdown('ThemeManager_CustomThemeList', { Text = 'Custom themes', Values = self:ReloadCustomThemes(), AllowNull = true, Default = 1 })
		groupbox:AddLine()
		
		groupbox:AddButton('Save theme', function() 
			self:SaveCustomTheme(Options.ThemeManager_CustomThemeName.Value)

			Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
			Options.ThemeManager_CustomThemeList:SetValue(nil)
		end):AddButton('Load theme', function() 
			self:ApplyTheme(Options.ThemeManager_CustomThemeList.Value) 
		end)

		groupbox:AddButton('Refresh list', function()
			Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
			Options.ThemeManager_CustomThemeList:SetValue(nil)
		end)

		groupbox:AddButton('Set as default', function()
			if Options.ThemeManager_CustomThemeList.Value ~= nil and Options.ThemeManager_CustomThemeList.Value ~= '' then
				self:SaveDefault(Options.ThemeManager_CustomThemeList.Value)
				self.Library:Notify(string.format('Set default theme to %q', Options.ThemeManager_CustomThemeList.Value))
			end
		end)

		ThemeManager:LoadDefault()

		local function UpdateTheme()
			self:ThemeUpdate()
		end

		Options.BackgroundColor:OnChanged(UpdateTheme)
		Options.MainColor:OnChanged(UpdateTheme)
        Options.ImageColor:OnChanged(UpdateTheme)
		Options.AccentColor:OnChanged(UpdateTheme)
		Options.OutlineColor:OnChanged(UpdateTheme)
		Options.FontColor:OnChanged(UpdateTheme)
	end

	function ThemeManager:GetCustomTheme(file)
		local path = self.Folder .. '/themes/' .. file
		if not isfile(path) then
			return nil
		end

		local data = readfile(path)
		local success, decoded = pcall(httpService.JSONDecode, httpService, data)
		
		if not success then
			return nil
		end

		return decoded
	end

	function ThemeManager:SaveCustomTheme(file)
		if file:gsub(' ', '') == '' then
			return self.Library:Notify('Invalid file name for theme (empty)', 3)
		end

		local theme = {}
		local fields = { "FontColor", "MainColor", "AccentColor", "ImageColor","BackgroundColor", "OutlineColor" }

		for _, field in next, fields do
			theme[field] = Options[field].Value:ToHex()
		end

		writefile(self.Folder .. '/themes/' .. file .. '.json', httpService:JSONEncode(theme))
	end

	function ThemeManager:ReloadCustomThemes()
		local list = listfiles(self.Folder .. '/themes')

		local out = {}
		for i = 1, #list do
			local file = list[i]
			if file:sub(-5) == '.json' then
				-- i hate this but it has to be done ...

				local pos = file:find('.json', 1, true)
				local char = file:sub(pos, pos)

				while char ~= '/' and char ~= '\\' and char ~= '' do
					pos = pos - 1
					char = file:sub(pos, pos)
				end

				if char == '/' or char == '\\' then
					table.insert(out, file:sub(pos + 1))
				end
			end
		end

		return out
	end

	function ThemeManager:SetLibrary(lib)
		self.Library = lib
	end

	function ThemeManager:BuildFolderTree()
		local paths = {}

		-- build the entire tree if a path is like some-hub/phantom-forces
		-- makefolder builds the entire tree on Synapse X but not other exploits

		local parts = self.Folder:split('/')
		for idx = 1, #parts do
			paths[#paths + 1] = table.concat(parts, '/', 1, idx)
		end

		table.insert(paths, self.Folder .. '/themes')
		table.insert(paths, self.Folder .. '/settings')

		for i = 1, #paths do
			local str = paths[i]
			if not isfolder(str) then
				makefolder(str)
			end
		end
	end

	function ThemeManager:SetFolder(folder)
		self.Folder = folder
		self:BuildFolderTree()
	end

	function ThemeManager:CreateGroupBox(tab)
		assert(self.Library, 'Must set ThemeManager.Library first!')
		return tab:AddLeftGroupbox('Themes')
	end

	function ThemeManager:ApplyToTab(tab)
		assert(self.Library, 'Must set ThemeManager.Library first!')
		local groupbox = self:CreateGroupBox(tab)
		self:CreateThemeManager(groupbox)
	end

	function ThemeManager:ApplyToGroupbox(groupbox)
		assert(self.Library, 'Must set ThemeManager.Library first!')
		self:CreateThemeManager(groupbox)
	end

	ThemeManager:BuildFolderTree()
end


local SaveManager = {} do
	SaveManager.Folder = 'LinoriaLibSettings'
	SaveManager.Ignore = {}
	SaveManager.Parser = {
		Toggle = {
			Save = function(idx, object) 
				return { type = 'Toggle', idx = idx, value = object.Value } 
			end,
			Load = function(idx, data)
				if Toggles[idx] then 
					Toggles[idx]:SetValue(data.value)
				end
			end,
		},
		Slider = {
			Save = function(idx, object)
				return { type = 'Slider', idx = idx, value = tostring(object.Value) }
			end,
			Load = function(idx, data)
				if Options[idx] then 
					Options[idx]:SetValue(data.value)
				end
			end,
		},
		Dropdown = {
			Save = function(idx, object)
				return { type = 'Dropdown', idx = idx, value = object.Value, mutli = object.Multi }
			end,
			Load = function(idx, data)
				if Options[idx] then 
					Options[idx]:SetValue(data.value)
				end
			end,
		},
		ColorPicker = {
			Save = function(idx, object)
				return { type = 'ColorPicker', idx = idx, value = object.Value:ToHex(), transparency = object.Transparency }
			end,
			Load = function(idx, data)
				if Options[idx] then 
					Options[idx]:SetValueRGB(Color3.fromHex(data.value), data.transparency)
				end
			end,
		},
		KeyPicker = {
			Save = function(idx, object)
				return { type = 'KeyPicker', idx = idx, mode = object.Mode, key = object.Value }
			end,
			Load = function(idx, data)
				if Options[idx] then 
					Options[idx]:SetValue({ data.key, data.mode })
				end
			end,
		},

		Input = {
			Save = function(idx, object)
				return { type = 'Input', idx = idx, text = object.Value }
			end,
			Load = function(idx, data)
				if Options[idx] and type(data.text) == 'string' then
					Options[idx]:SetValue(data.text)
				end
			end,
		},
	}

	function SaveManager:SetIgnoreIndexes(list)
		for _, key in next, list do
			self.Ignore[key] = true
		end
	end

	function SaveManager:SetFolder(folder)
		self.Folder = folder;
		self:BuildFolderTree()
	end

	function SaveManager:Save(name)
		if (not name) then
			return false, 'no config file is selected'
		end

		local fullPath = self.Folder .. '/settings/' .. name .. '.json'

		local data = {
			objects = {}
		}

		for idx, toggle in next, Toggles do
			if self.Ignore[idx] then continue end

			table.insert(data.objects, self.Parser[toggle.Type].Save(idx, toggle))
		end

		for idx, option in next, Options do
			if not self.Parser[option.Type] then continue end
			if self.Ignore[idx] then continue end

			table.insert(data.objects, self.Parser[option.Type].Save(idx, option))
		end	

		local success, encoded = pcall(httpService.JSONEncode, httpService, data)
		if not success then
			return false, 'failed to encode data'
		end

		writefile(fullPath, encoded)
		return true
	end

	function SaveManager:Load(name)
		if (not name) then
			return false, 'no config file is selected'
		end
		
		local file = self.Folder .. '/settings/' .. name .. '.json'
		if not isfile(file) then return false, 'invalid file' end

		local success, decoded = pcall(httpService.JSONDecode, httpService, readfile(file))
		if not success then return false, 'decode error' end

		for _, option in next, decoded.objects do
			if self.Parser[option.type] then
				self.Parser[option.type].Load(option.idx, option)
			end
		end

		return true
	end

	function SaveManager:IgnoreThemeSettings()
		self:SetIgnoreIndexes({ 
			"BackgroundColor", "MainColor", "AccentColor", "OutlineColor", "FontColor", -- themes
			"ThemeManager_ThemeList", 'ThemeManager_CustomThemeList', 'ThemeManager_CustomThemeName', -- themes
		})
	end

	function SaveManager:BuildFolderTree()
		local paths = {
			self.Folder,
			self.Folder .. '/themes',
			self.Folder .. '/settings'
		}

		for i = 1, #paths do
			local str = paths[i]
			if not isfolder(str) then
				makefolder(str)
			end
		end
	end

	function SaveManager:RefreshConfigList()
		local list = listfiles(self.Folder .. '/settings')

		local out = {}
		for i = 1, #list do
			local file = list[i]
			if file:sub(-5) == '.json' then
				-- i hate this but it has to be done ...

				local pos = file:find('.json', 1, true)
				local start = pos

				local char = file:sub(pos, pos)
				while char ~= '/' and char ~= '\\' and char ~= '' do
					pos = pos - 1
					char = file:sub(pos, pos)
				end

				if char == '/' or char == '\\' then
					table.insert(out, file:sub(pos + 1, start - 1))
				end
			end
		end
		
		return out
	end

	function SaveManager:SetLibrary(library)
		self.Library = library
	end

	function SaveManager:LoadAutoloadConfig()
		if isfile(self.Folder .. '/settings/autoload.txt') then
			local name = readfile(self.Folder .. '/settings/autoload.txt')

			local success, err = self:Load(name)
			if not success then
				return self.Library:Notify('Failed to load autoload config: ' .. err)
			end

			self.Library:Notify(string.format('Auto loaded config %q', name))
		end
	end


	function SaveManager:BuildConfigSection(tab)
		assert(self.Library, 'Must set SaveManager.Library')

		local section = tab:AddRightGroupbox('Configuration')

		section:AddInput('SaveManager_ConfigName',    { Text = 'Config name' })
		section:AddDropdown('SaveManager_ConfigList', { Text = 'Config list', Values = self:RefreshConfigList(), AllowNull = true })


		section:AddButton('Create config', function()
			local name = Options.SaveManager_ConfigName.Value

			if name:gsub(' ', '') == '' then 
				return self.Library:Notify('Invalid config name (empty)', 2)
			end

			local success, err = self:Save(name)
			if not success then
				return self.Library:Notify('Failed to save config: ' .. err)
			end

			self.Library:Notify(string.format('Created config %q', name))

			Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
			Options.SaveManager_ConfigList:SetValue(nil)
		end):AddButton('Load config', function()
			local name = Options.SaveManager_ConfigList.Value

			local success, err = self:Load(name)
			if not success then
				return self.Library:Notify('Failed to load config: ' .. err)
			end

			self.Library:Notify(string.format('Loaded config %q', name))
		end)

		section:AddButton('Overwrite config', function()
			local name = Options.SaveManager_ConfigList.Value

			local success, err = self:Save(name)
			if not success then
				return self.Library:Notify('Failed to overwrite config: ' .. err)
			end

			self.Library:Notify(string.format('Overwrote config %q', name))
		end)

		section:AddButton('Refresh list', function()
			Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
			Options.SaveManager_ConfigList:SetValue(nil)
		end)

		section:AddButton('Set as autoload', function()
			local name = Options.SaveManager_ConfigList.Value
			writefile(self.Folder .. '/settings/autoload.txt', name)
			SaveManager.AutoloadLabel:SetText('Current autoload config: ' .. name)
			self.Library:Notify(string.format('Set %q to auto load', name))
		end)

		SaveManager.AutoloadLabel = section:AddLabel('Current autoload config: none', true)

		if isfile(self.Folder .. '/settings/autoload.txt') then
			local name = readfile(self.Folder .. '/settings/autoload.txt')
			SaveManager.AutoloadLabel:SetText('Current autoload config: ' .. name)
		end

		SaveManager:SetIgnoreIndexes({ 'SaveManager_ConfigList', 'SaveManager_ConfigName' })
	end

	SaveManager:BuildFolderTree()
end

local ping = game.Stats.PerformanceStats.Ping:GetValue()

local InputService = game:GetService('UserInputService');
local TextService = game:GetService('TextService');
local CoreGui = game:GetService('CoreGui');
local Teams = game:GetService('Teams');
local Players = game:GetService('Players');
local RunService = game:GetService('RunService')
local TweenService = game:GetService('TweenService');
local RenderStepped = RunService.RenderStepped;
local LocalPlayer = Players.LocalPlayer;
local Mouse = LocalPlayer:GetMouse();

local ProtectGui = protectgui or (syn and syn.protect_gui) or (function() end);

local ScreenGui = Instance.new('ScreenGui');
ProtectGui(ScreenGui);

ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global;
ScreenGui.Parent = CoreGui;

local Toggles = {};
local Options = {};

getgenv().Toggles = Toggles;
getgenv().Options = Options;

local Library = {
    Registry = {};
    RegistryMap = {};

    HudRegistry = {};

    FontColor = Color3.fromRGB(255, 255, 255);
    MainColor = Color3.fromRGB(28, 28, 28);
    BackgroundColor = Color3.fromRGB(20, 20, 20);
    AccentColor = Color3.fromRGB(48, 2, 113);
    OutlineColor = Color3.fromRGB(50, 50, 50);
    RiskColor = Color3.fromRGB(255, 50, 50),
    ImageColor = Color3.fromRGB(41, 20, 92);


    Black = Color3.new(0, 0, 0);
    Font = Enum.Font.Code,

    OpenedFrames = {};
    DependencyBoxes = {};

    Signals = {};
    ScreenGui = ScreenGui;
};
local ui_utility = {
    image_color = {},
    tab_trans = {},
    group_trans = {},
    keybinds_trans = {},
    watermark_trans = {}
}

local change_transa = 0
local RainbowStep = 0
local Hue = 0

table.insert(Library.Signals, RenderStepped:Connect(function(Delta)
    RainbowStep = RainbowStep + Delta

    if RainbowStep >= (1 / 60) then
        RainbowStep = 0

        Hue = Hue + (1 / 400);

        if Hue > 1 then
            Hue = 0;
        end;

        Library.CurrentRainbowHue = Hue;
        Library.CurrentRainbowColor = Color3.fromHSV(Hue, 0.8, 1);
    end
end))

local function GetPlayersString()
    local PlayerList = Players:GetPlayers();

    for i = 1, #PlayerList do
        PlayerList[i] = PlayerList[i].Name;
    end;

    table.sort(PlayerList, function(str1, str2) return str1 < str2 end);

    return PlayerList;
end;

local function GetTeamsString()
    local TeamList = Teams:GetTeams();

    for i = 1, #TeamList do
        TeamList[i] = TeamList[i].Name;
    end;

    table.sort(TeamList, function(str1, str2) return str1 < str2 end);
    
    return TeamList;
end;

function Library:SafeCallback(f, ...)
    if (not f) then
        return;
    end;

    if not Library.NotifyOnError then
        return f(...);
    end;

    local success, event = pcall(f, ...);

    if not success then
        local _, i = event:find(":%d+: ");

        if not i then
            return Library:Notify(event);
        end;

        return Library:Notify(event:sub(i + 1), 3);
    end;
end;

function Library:AttemptSave()
    if Library.SaveManager then
        Library.SaveManager:Save();
    end;
end;

function Library:Create(Class, Properties)
    local _Instance = Class;

    if type(Class) == 'string' then
        _Instance = Instance.new(Class);
    end;

    for Property, Value in next, Properties do
        _Instance[Property] = Value;
    end;

    return _Instance;
end;

function Library:ApplyTextStroke(Inst)
    Inst.TextStrokeTransparency = 1;

    Library:Create('UIStroke', {
        Color = Color3.new(0, 0, 0);
        Thickness = 1;
        LineJoinMode = Enum.LineJoinMode.Miter;
        Parent = Inst;
    });
end;

function Library:CreateLabel(Properties, IsHud)
    local _Instance = Library:Create('TextLabel', {
        BackgroundTransparency = 1;
        Font = Library.Font;
        TextColor3 = Library.FontColor;
        TextSize = 16;
        TextStrokeTransparency = 0;
    });

    Library:ApplyTextStroke(_Instance);

    Library:AddToRegistry(_Instance, {
        TextColor3 = 'FontColor';
    }, IsHud);

    return Library:Create(_Instance, Properties);
end;

function Library:MakeDraggable(Instance, Cutoff)
    Instance.Active = true;

    Instance.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            local ObjPos = Vector2.new(
                Mouse.X - Instance.AbsolutePosition.X,
                Mouse.Y - Instance.AbsolutePosition.Y
            );

            if ObjPos.Y > (Cutoff or 40) then
                return;
            end;

            while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                Instance.Position = UDim2.new(
                    0,
                    Mouse.X - ObjPos.X + (Instance.Size.X.Offset * Instance.AnchorPoint.X),
                    0,
                    Mouse.Y - ObjPos.Y + (Instance.Size.Y.Offset * Instance.AnchorPoint.Y)
                );

                RenderStepped:Wait();
            end;
        end;
    end)
end;

function Library:AddToolTip(InfoStr, HoverInstance)
    local X, Y = Library:GetTextBounds(InfoStr, Library.Font, 14);
    local Tooltip = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor,
        BorderColor3 = Library.OutlineColor,

        Size = UDim2.fromOffset(X + 5, Y + 4),
        ZIndex = 100,
        Parent = Library.ScreenGui,

        Visible = false,
    })

    local Label = Library:CreateLabel({
        Position = UDim2.fromOffset(3, 1),
        Size = UDim2.fromOffset(X, Y);
        TextSize = 14;
        Text = InfoStr,
        TextColor3 = Library.FontColor,
        TextXAlignment = Enum.TextXAlignment.Left;
        ZIndex = Tooltip.ZIndex + 1,

        Parent = Tooltip;
    });

    Library:AddToRegistry(Tooltip, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    });

    Library:AddToRegistry(Label, {
        TextColor3 = 'FontColor',
    });

    local IsHovering = false

    HoverInstance.MouseEnter:Connect(function()
        if Library:MouseIsOverOpenedFrame() then
            return
        end

        IsHovering = true

        Tooltip.Position = UDim2.fromOffset(Mouse.X + 15, Mouse.Y + 12)
        Tooltip.Visible = true

        while IsHovering do
            RunService.Heartbeat:Wait()
            Tooltip.Position = UDim2.fromOffset(Mouse.X + 15, Mouse.Y + 12)
        end
    end)

    HoverInstance.MouseLeave:Connect(function()
        IsHovering = false
        Tooltip.Visible = false
    end)
end

function Library:OnHighlight(HighlightInstance, Instance, Properties, PropertiesDefault)
    HighlightInstance.MouseEnter:Connect(function()
        local Reg = Library.RegistryMap[Instance];

        for Property, ColorIdx in next, Properties do
            Instance[Property] = Library[ColorIdx] or ColorIdx;

            if Reg and Reg.Properties[Property] then
                Reg.Properties[Property] = ColorIdx;
            end;
        end;
    end)

    HighlightInstance.MouseLeave:Connect(function()
        local Reg = Library.RegistryMap[Instance];

        for Property, ColorIdx in next, PropertiesDefault do
            Instance[Property] = Library[ColorIdx] or ColorIdx;

            if Reg and Reg.Properties[Property] then
                Reg.Properties[Property] = ColorIdx;
            end;
        end;
    end)
end;

function Library:MouseIsOverOpenedFrame()
    for Frame, _ in next, Library.OpenedFrames do
        local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize;

        if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X
            and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then

            return true;
        end;
    end;
end;

function Library:IsMouseOverFrame(Frame)
    local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize;

    if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X
        and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then

        return true;
    end;
end;

function Library:UpdateDependencyBoxes()
    for _, Depbox in next, Library.DependencyBoxes do
        Depbox:Update();
    end;
end;

function Library:MapValue(Value, MinA, MaxA, MinB, MaxB)
    return (1 - ((Value - MinA) / (MaxA - MinA))) * MinB + ((Value - MinA) / (MaxA - MinA)) * MaxB;
end;

function Library:GetTextBounds(Text, Font, Size, Resolution)
    local Bounds = TextService:GetTextSize(Text, Size, Font, Resolution or Vector2.new(1920, 1080))
    return Bounds.X, Bounds.Y
end;

function Library:GetDarkerColor(Color)
    local H, S, V = Color3.toHSV(Color);
    return Color3.fromHSV(H, S, V / 1.5);
end;
Library.AccentColorDark = Library:GetDarkerColor(Library.AccentColor);

function Library:AddToRegistry(Instance, Properties, IsHud)
    local Idx = #Library.Registry + 1;
    local Data = {
        Instance = Instance;
        Properties = Properties;
        Idx = Idx;
    };

    table.insert(Library.Registry, Data);
    Library.RegistryMap[Instance] = Data;

    if IsHud then
        table.insert(Library.HudRegistry, Data);
    end;
end;

function Library:RemoveFromRegistry(Instance)
    local Data = Library.RegistryMap[Instance];

    if Data then
        for Idx = #Library.Registry, 1, -1 do
            if Library.Registry[Idx] == Data then
                table.remove(Library.Registry, Idx);
            end;
        end;

        for Idx = #Library.HudRegistry, 1, -1 do
            if Library.HudRegistry[Idx] == Data then
                table.remove(Library.HudRegistry, Idx);
            end;
        end;

        Library.RegistryMap[Instance] = nil;
    end;
end;

function Library:UpdateColorsUsingRegistry()
    -- TODO: Could have an 'active' list of objects
    -- where the active list only contains Visible objects.

    -- IMPL: Could setup .Changed events on the AddToRegistry function
    -- that listens for the 'Visible' propert being changed.
    -- Visible: true => Add to active list, and call UpdateColors function
    -- Visible: false => Remove from active list.

    -- The above would be especially efficient for a rainbow menu color or live color-changing.

    for Idx, Object in next, Library.Registry do
        for Property, ColorIdx in next, Object.Properties do
            if type(ColorIdx) == 'string' then
                Object.Instance[Property] = Library[ColorIdx];
            elseif type(ColorIdx) == 'function' then
                Object.Instance[Property] = ColorIdx()
            end
        end;
    end;
end;

function Library:GiveSignal(Signal)
    -- Only used for signals not attached to library instances, as those should be cleaned up on object destruction by Roblox
    table.insert(Library.Signals, Signal)
end

function Library:Unload()
    -- Unload all of the signals
    for Idx = #Library.Signals, 1, -1 do
        local Connection = table.remove(Library.Signals, Idx)
        Connection:Disconnect()
    end

     -- Call our unload callback, maybe to undo some hooks etc
    if Library.OnUnload then
        Library.OnUnload()
    end

    ScreenGui:Destroy()
end

function Library:OnUnload(Callback)
    Library.OnUnload = Callback
end

Library:GiveSignal(ScreenGui.DescendantRemoving:Connect(function(Instance)
    if Library.RegistryMap[Instance] then
        Library:RemoveFromRegistry(Instance);
    end;
end))

local BaseAddons = {};

do
    local Funcs = {};

    function Funcs:AddColorPicker(Idx, Info)
        local ToggleLabel = self.TextLabel;
        -- local Container = self.Container;

        assert(Info.Default, 'AddColorPicker: Missing default value.');

        local ColorPicker = {
            Value = Info.Default;
            Transparency = Info.Transparency or 0;
            Type = 'ColorPicker';
            Title = type(Info.Title) == 'string' and Info.Title or 'Color picker',
            Callback = Info.Callback or function(Color) end;
        };

        function ColorPicker:SetHSVFromRGB(Color)
            local H, S, V = Color3.toHSV(Color);

            ColorPicker.Hue = H;
            ColorPicker.Sat = S;
            ColorPicker.Vib = V;
        end;

        ColorPicker:SetHSVFromRGB(ColorPicker.Value);

        local DisplayFrame = Library:Create('Frame', {
            BackgroundColor3 = ColorPicker.Value;
            BorderColor3 = Library:GetDarkerColor(ColorPicker.Value);
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(0, 28, 0, 14);
            ZIndex = 6;
            Parent = ToggleLabel;
        });

        -- Transparency image taken from https://github.com/matas3535/SplixPrivateDrawingLibrary/blob/main/Library.lua cus i'm lazy
        local CheckerFrame = Library:Create('ImageLabel', {
            BorderSizePixel = 0;
            Size = UDim2.new(0, 27, 0, 13);
            ZIndex = 5;
            Image = 'http://www.roblox.com/asset/?id=12977615774';
            Visible = not not Info.Transparency;
            Parent = DisplayFrame;
        });

        -- 1/16/23
        -- Rewrote this to be placed inside the Library ScreenGui
        -- There was some issue which caused RelativeOffset to be way off
        -- Thus the color picker would never show

        local PickerFrameOuter = Library:Create('Frame', {
            Name = 'Color';
            BackgroundColor3 = Color3.new(1, 1, 1);
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.fromOffset(DisplayFrame.AbsolutePosition.X, DisplayFrame.AbsolutePosition.Y + 18),
            Size = UDim2.fromOffset(230, Info.Transparency and 271 or 253);
            Visible = false;
            ZIndex = 15;
            Parent = ScreenGui,
        });

        DisplayFrame:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
            PickerFrameOuter.Position = UDim2.fromOffset(DisplayFrame.AbsolutePosition.X, DisplayFrame.AbsolutePosition.Y + 18);
        end)

        local PickerFrameInner = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 16;
            Parent = PickerFrameOuter;
        });

        local Highlight = Library:Create('Frame', {
            BackgroundColor3 = Color3.fromRGB(0,0,0);
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 0, 2);
            ZIndex = 17;
            Parent = PickerFrameInner;
        });

        local SatVibMapOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.new(0, 4, 0, 25);
            Size = UDim2.new(0, 200, 0, 200);
            ZIndex = 17;
            Parent = PickerFrameInner;
        });

        local SatVibMapInner = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 18;
            Parent = SatVibMapOuter;
        });

        local SatVibMap = Library:Create('ImageLabel', {
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 18;
            Image = 'rbxassetid://4155801252';
            Parent = SatVibMapInner;
        });

        local CursorOuter = Library:Create('ImageLabel', {
            AnchorPoint = Vector2.new(0.5, 0.5);
            Size = UDim2.new(0, 6, 0, 6);
            BackgroundTransparency = 1;
            Image = 'http://www.roblox.com/asset/?id=9619665977';
            ImageColor3 = Color3.new(0, 0, 0);
            ZIndex = 19;
            Parent = SatVibMap;
        });

        local CursorInner = Library:Create('ImageLabel', {
            Size = UDim2.new(0, CursorOuter.Size.X.Offset - 2, 0, CursorOuter.Size.Y.Offset - 2);
            Position = UDim2.new(0, 1, 0, 1);
            BackgroundTransparency = 1;
            Image = 'http://www.roblox.com/asset/?id=9619665977';
            ZIndex = 20;
            Parent = CursorOuter;
        })

        local HueSelectorOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.new(0, 208, 0, 25);
            Size = UDim2.new(0, 15, 0, 200);
            ZIndex = 17;
            Parent = PickerFrameInner;
        });

        local HueSelectorInner = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(1, 1, 1);
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 18;
            Parent = HueSelectorOuter;
        });

        local HueCursor = Library:Create('Frame', { 
            BackgroundColor3 = Color3.new(1, 1, 1);
            AnchorPoint = Vector2.new(0, 0.5);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, 0, 0, 1);
            ZIndex = 18;
            Parent = HueSelectorInner;
        });

        local HueBoxOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.fromOffset(4, 228),
            Size = UDim2.new(0.5, -6, 0, 20),
            ZIndex = 18,
            Parent = PickerFrameInner;
        });

        local HueBoxInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 18,
            Parent = HueBoxOuter;
        });

        Library:Create('UIGradient', {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
            });
            Rotation = 90;
            Parent = HueBoxInner;
        });

        local HueBox = Library:Create('TextBox', {
            BackgroundTransparency = 1;
            Position = UDim2.new(0, 5, 0, 0);
            Size = UDim2.new(1, -5, 1, 0);
            Font = Library.Font;
            PlaceholderColor3 = Color3.fromRGB(190, 190, 190);
            PlaceholderText = 'Hex color',
            Text = '#FFFFFF',
            TextColor3 = Library.FontColor;
            TextSize = 14;
            TextStrokeTransparency = 0;
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = 20,
            Parent = HueBoxInner;
        });

        Library:ApplyTextStroke(HueBox);

        local RgbBoxBase = Library:Create(HueBoxOuter:Clone(), {
            Position = UDim2.new(0.5, 2, 0, 228),
            Size = UDim2.new(0.5, -6, 0, 20),
            Parent = PickerFrameInner
        });

        local RgbBox = Library:Create(RgbBoxBase.Frame:FindFirstChild('TextBox'), {
            Text = '255, 255, 255',
            PlaceholderText = 'RGB color',
            TextColor3 = Library.FontColor
        });

        local TransparencyBoxOuter, TransparencyBoxInner, TransparencyCursor;
        
        if Info.Transparency then 
            TransparencyBoxOuter = Library:Create('Frame', {
                BorderColor3 = Color3.new(0, 0, 0);
                Position = UDim2.fromOffset(4, 251);
                Size = UDim2.new(1, -8, 0, 15);
                ZIndex = 19;
                Parent = PickerFrameInner;
            });

            TransparencyBoxInner = Library:Create('Frame', {
                BackgroundColor3 = ColorPicker.Value;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, 0, 1, 0);
                ZIndex = 19;
                Parent = TransparencyBoxOuter;
            });

            Library:AddToRegistry(TransparencyBoxInner, { BorderColor3 = 'OutlineColor' });

            Library:Create('ImageLabel', {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                Image = 'http://www.roblox.com/asset/?id=12978095818';
                ZIndex = 20;
                Parent = TransparencyBoxInner;
            });

            TransparencyCursor = Library:Create('Frame', { 
                BackgroundColor3 = Color3.new(1, 1, 1);
                AnchorPoint = Vector2.new(0.5, 0);
                BorderColor3 = Color3.new(0, 0, 0);
                Size = UDim2.new(0, 1, 1, 0);
                ZIndex = 21;
                Parent = TransparencyBoxInner;
            });
        end;

        local DisplayLabel = Library:CreateLabel({
            Size = UDim2.new(1, 0, 0, 14);
            Position = UDim2.fromOffset(5, 5);
            TextXAlignment = Enum.TextXAlignment.Left;
            TextSize = 14;
            Text = ColorPicker.Title,--Info.Default;
            TextWrapped = false;
            ZIndex = 16;
            Parent = PickerFrameInner;
        });


        local ContextMenu = {}
        do
            ContextMenu.Options = {}
            ContextMenu.Container = Library:Create('Frame', {
                BorderColor3 = Color3.new(),
                ZIndex = 14,

                Visible = false,
                Parent = ScreenGui
            })

            ContextMenu.Inner = Library:Create('Frame', {
                BackgroundTransparency = 1;
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.fromScale(1, 1);
                ZIndex = 15;
                Parent = ContextMenu.Container;
            });

            Library:Create('UIListLayout', {
                Name = 'Layout',
                FillDirection = Enum.FillDirection.Vertical;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Parent = ContextMenu.Inner;
            });

            Library:Create('UIPadding', {
                Name = 'Padding',
                PaddingLeft = UDim.new(0, 4),
                Parent = ContextMenu.Inner,
            });

            local function updateMenuPosition()
                ContextMenu.Container.Position = UDim2.fromOffset(
                    (DisplayFrame.AbsolutePosition.X + DisplayFrame.Absoluimage.pngteSize.X) + 4,
                    DisplayFrame.AbsolutePosition.Y + 1
                )
            end

            local function updateMenuSize()
                local menuWidth = 60
                for i, label in next, ContextMenu.Inner:GetChildren() do
                    if label:IsA('TextLabel') then
                        menuWidth = math.max(menuWidth, label.TextBounds.X)
                    end
                end

                ContextMenu.Container.Size = UDim2.fromOffset(
                    menuWidth + 8,
                    ContextMenu.Inner.Layout.AbsoluteContentSize.Y + 4
                )
            end

            DisplayFrame:GetPropertyChangedSignal('AbsolutePosition'):Connect(updateMenuPosition)
            ContextMenu.Inner.Layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(updateMenuSize)

            task.spawn(updateMenuPosition)
            task.spawn(updateMenuSize)

            Library:AddToRegistry(ContextMenu.Inner, {
                BackgroundColor3 = 'BackgroundColor';
                BorderColor3 = 'OutlineColor';
            });

            function ContextMenu:Show()
                self.Container.Visible = true
            end

            function ContextMenu:Hide()
                self.Container.Visible = false
            end

            function ContextMenu:AddOption(Str, Callback)
                if type(Callback) ~= 'function' then
                    Callback = function() end
                end

                local Button = Library:CreateLabel({
                    Active = false;
                    Size = UDim2.new(1, 0, 0, 15);
                    TextSize = 13;
                    Text = Str;
                    ZIndex = 16;
                    Parent = self.Inner;
                    TextXAlignment = Enum.TextXAlignment.Left,
                });

                Library:OnHighlight(Button, Button, 
                    { TextColor3 = 'AccentColor' },
                    { TextColor3 = 'FontColor' }
                );

                Button.InputBegan:Connect(function(Input)
                    if Input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                        return
                    end

                    Callback()
                end)
            end

            ContextMenu:AddOption('Copy color', function()
                Library.ColorClipboard = ColorPicker.Value
                Library:Notify('Copied color!', 2)
            end)

            ContextMenu:AddOption('Paste color', function()
                if not Library.ColorClipboard then
                    return Library:Notify('You have not copied a color!', 2)
                end
                ColorPicker:SetValueRGB(Library.ColorClipboard)
            end)


            ContextMenu:AddOption('Copy HEX', function()
                pcall(setclipboard, ColorPicker.Value:ToHex())
                Library:Notify('Copied hex code to clipboard!', 2)
            end)

            ContextMenu:AddOption('Copy RGB', function()
                pcall(setclipboard, table.concat({ math.floor(ColorPicker.Value.R * 255), math.floor(ColorPicker.Value.G * 255), math.floor(ColorPicker.Value.B * 255) }, ', '))
                Library:Notify('Copied RGB values to clipboard!', 2)
            end)

        end

        Library:AddToRegistry(PickerFrameInner, { BackgroundColor3 = 'BackgroundColor'; BorderColor3 = 'OutlineColor'; });
        Library:AddToRegistry(Highlight, { BackgroundColor3 = 'AccentColor'; });
        Library:AddToRegistry(SatVibMapInner, { BackgroundColor3 = 'BackgroundColor'; BorderColor3 = 'OutlineColor'; });

        Library:AddToRegistry(HueBoxInner, { BackgroundColor3 = 'MainColor'; BorderColor3 = 'OutlineColor'; });
        Library:AddToRegistry(RgbBoxBase.Frame, { BackgroundColor3 = 'MainColor'; BorderColor3 = 'OutlineColor'; });
        Library:AddToRegistry(RgbBox, { TextColor3 = 'FontColor', });
        Library:AddToRegistry(HueBox, { TextColor3 = 'FontColor', });

        local SequenceTable = {};

        for Hue = 0, 1, 0.1 do
            table.insert(SequenceTable, ColorSequenceKeypoint.new(Hue, Color3.fromHSV(Hue, 1, 1)));
        end;

        local HueSelectorGradient = Library:Create('UIGradient', {
            Color = ColorSequence.new(SequenceTable);
            Rotation = 90;
            Parent = HueSelectorInner;
        });

        HueBox.FocusLost:Connect(function(enter)
            if enter then
                local success, result = pcall(Color3.fromHex, HueBox.Text)
                if success and typeof(result) == 'Color3' then
                    ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib = Color3.toHSV(result)
                end
            end

            ColorPicker:Display()
        end)

        RgbBox.FocusLost:Connect(function(enter)
            if enter then
                local r, g, b = RgbBox.Text:match('(%d+),%s*(%d+),%s*(%d+)')
                if r and g and b then
                    ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib = Color3.toHSV(Color3.fromRGB(r, g, b))
                end
            end

            ColorPicker:Display()
        end)

        function ColorPicker:Display()
            ColorPicker.Value = Color3.fromHSV(ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib);
            SatVibMap.BackgroundColor3 = Color3.fromHSV(ColorPicker.Hue, 1, 1);

            Library:Create(DisplayFrame, {
                BackgroundColor3 = ColorPicker.Value;
                BackgroundTransparency = ColorPicker.Transparency;
                BorderColor3 = Library:GetDarkerColor(ColorPicker.Value);
            });

            if TransparencyBoxInner then
                TransparencyBoxInner.BackgroundColor3 = ColorPicker.Value;
                TransparencyCursor.Position = UDim2.new(1 - ColorPicker.Transparency, 0, 0, 0);
            end;

            CursorOuter.Position = UDim2.new(ColorPicker.Sat, 0, 1 - ColorPicker.Vib, 0);
            HueCursor.Position = UDim2.new(0, 0, ColorPicker.Hue, 0);

            HueBox.Text = '#' .. ColorPicker.Value:ToHex()
            RgbBox.Text = table.concat({ math.floor(ColorPicker.Value.R * 255), math.floor(ColorPicker.Value.G * 255), math.floor(ColorPicker.Value.B * 255) }, ', ')

            Library:SafeCallback(ColorPicker.Callback, ColorPicker.Value);
            Library:SafeCallback(ColorPicker.Changed, ColorPicker.Value);
        end;

        function ColorPicker:OnChanged(Func)
            ColorPicker.Changed = Func;
            Func(ColorPicker.Value)
        end;

        function ColorPicker:Show()
            for Frame, Val in next, Library.OpenedFrames do
                if Frame.Name == 'Color' then
                    Frame.Visible = false;
                    Library.OpenedFrames[Frame] = nil;
                end;
            end;

            PickerFrameOuter.Visible = true;
            Library.OpenedFrames[PickerFrameOuter] = true;
        end;

        function ColorPicker:Hide()
            PickerFrameOuter.Visible = false;
            Library.OpenedFrames[PickerFrameOuter] = nil;
        end;

        function ColorPicker:SetValue(HSV, Transparency)
            local Color = Color3.fromHSV(HSV[1], HSV[2], HSV[3]);

            ColorPicker.Transparency = Transparency or 0;
            ColorPicker:SetHSVFromRGB(Color);
            ColorPicker:Display();
        end;

        function ColorPicker:SetValueRGB(Color, Transparency)
            ColorPicker.Transparency = Transparency or 0;
            ColorPicker:SetHSVFromRGB(Color);
            ColorPicker:Display();
        end;

        SatVibMap.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                    local MinX = SatVibMap.AbsolutePosition.X;
                    local MaxX = MinX + SatVibMap.AbsoluteSize.X;
                    local MouseX = math.clamp(Mouse.X, MinX, MaxX);

                    local MinY = SatVibMap.AbsolutePosition.Y;
                    local MaxY = MinY + SatVibMap.AbsoluteSize.Y;
                    local MouseY = math.clamp(Mouse.Y, MinY, MaxY);

                    ColorPicker.Sat = (MouseX - MinX) / (MaxX - MinX);
                    ColorPicker.Vib = 1 - ((MouseY - MinY) / (MaxY - MinY));
                    ColorPicker:Display();

                    RenderStepped:Wait();
                end;

                Library:AttemptSave();
            end;
        end);

        HueSelectorInner.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                    local MinY = HueSelectorInner.AbsolutePosition.Y;
                    local MaxY = MinY + HueSelectorInner.AbsoluteSize.Y;
                    local MouseY = math.clamp(Mouse.Y, MinY, MaxY);

                    ColorPicker.Hue = ((MouseY - MinY) / (MaxY - MinY));
                    ColorPicker:Display();

                    RenderStepped:Wait();
                end;

                Library:AttemptSave();
            end;
        end);

        DisplayFrame.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                if PickerFrameOuter.Visible then
                    ColorPicker:Hide()
                else
                    ContextMenu:Hide()
                    ColorPicker:Show()
                end;
            elseif Input.UserInputType == Enum.UserInputType.MouseButton2 and not Library:MouseIsOverOpenedFrame() then
                ContextMenu:Show()
                ColorPicker:Hide()
            end
        end);

        if TransparencyBoxInner then
            TransparencyBoxInner.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                        local MinX = TransparencyBoxInner.AbsolutePosition.X;
                        local MaxX = MinX + TransparencyBoxInner.AbsoluteSize.X;
                        local MouseX = math.clamp(Mouse.X, MinX, MaxX);

                        ColorPicker.Transparency = 1 - ((MouseX - MinX) / (MaxX - MinX));

                        ColorPicker:Display();

                        RenderStepped:Wait();
                    end;

                    Library:AttemptSave();
                end;
            end);
        end;

        Library:GiveSignal(InputService.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                local AbsPos, AbsSize = PickerFrameOuter.AbsolutePosition, PickerFrameOuter.AbsoluteSize;

                if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X
                    or Mouse.Y < (AbsPos.Y - 20 - 1) or Mouse.Y > AbsPos.Y + AbsSize.Y then

                    ColorPicker:Hide();
                end;

                if not Library:IsMouseOverFrame(ContextMenu.Container) then
                    ContextMenu:Hide()
                end
            end;

            if Input.UserInputType == Enum.UserInputType.MouseButton2 and ContextMenu.Container.Visible then
                if not Library:IsMouseOverFrame(ContextMenu.Container) and not Library:IsMouseOverFrame(DisplayFrame) then
                    ContextMenu:Hide()
                end
            end
        end))

        ColorPicker:Display();
        ColorPicker.DisplayFrame = DisplayFrame

        Options[Idx] = ColorPicker;

        return self;
    end;

    function Funcs:AddKeyPicker(Idx, Info)
        local ParentObj = self;
        local ToggleLabel = self.TextLabel;
        local Container = self.Container;

        assert(Info.Default, 'AddKeyPicker: Missing default value.');

        local KeyPicker = {
            Value = Info.Default;
            Toggled = false;
            Mode = Info.Mode or 'Toggle'; -- Always, Toggle, Hold
            Type = 'KeyPicker';
            Callback = Info.Callback or function(Value) end;
            ChangedCallback = Info.ChangedCallback or function(New) end;

            SyncToggleState = Info.SyncToggleState or false;
        };

        if KeyPicker.SyncToggleState then
            Info.Modes = { 'Toggle' }
            Info.Mode = 'Toggle'
        end

        local PickOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(0, 28, 0, 15);
            ZIndex = 6;
            Parent = ToggleLabel;
        });

        local PickInner = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 7;
            Parent = PickOuter;
        });

        Library:AddToRegistry(PickInner, {
            BackgroundColor3 = 'BackgroundColor';
            BorderColor3 = 'OutlineColor';
        });

        local DisplayLabel = Library:CreateLabel({
            Size = UDim2.new(1, 0, 1, 0);
            TextSize = 13;
            Text = Info.Default;
            TextWrapped = true;
            ZIndex = 8;
            Parent = PickInner;
        });

        local ModeSelectOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.fromOffset(ToggleLabel.AbsolutePosition.X + ToggleLabel.AbsoluteSize.X + 4, ToggleLabel.AbsolutePosition.Y + 1);
            Size = UDim2.new(0, 60, 0, 45 + 2);
            Visible = false;
            ZIndex = 14;
            Parent = ScreenGui;
        });

        ToggleLabel:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
            ModeSelectOuter.Position = UDim2.fromOffset(ToggleLabel.AbsolutePosition.X + ToggleLabel.AbsoluteSize.X + 4, ToggleLabel.AbsolutePosition.Y + 1);
        end);

        local ModeSelectInner = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 15;
            Parent = ModeSelectOuter;
        });

        Library:AddToRegistry(ModeSelectInner, {
            BackgroundColor3 = 'BackgroundColor';
            BorderColor3 = 'OutlineColor';
        });

        Library:Create('UIListLayout', {
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = ModeSelectInner;
        });

        local ContainerLabel = Library:CreateLabel({
            TextXAlignment = Enum.TextXAlignment.Left;
            Size = UDim2.new(1, 0, 0, 18);
            TextSize = 13;
            Visible = false;
            ZIndex = 110;
            Parent = Library.KeybindContainer;
        },  true);

        local Modes = Info.Modes or { 'Always', 'Toggle', 'Hold' };
        local ModeButtons = {};

        for Idx, Mode in next, Modes do
            local ModeButton = {};

            local Label = Library:CreateLabel({
                Active = false;
                Size = UDim2.new(1, 0, 0, 15);
                TextSize = 13;
                Text = Mode;
                ZIndex = 16;
                Parent = ModeSelectInner;
            });

            function ModeButton:Select()
                for _, Button in next, ModeButtons do
                    Button:Deselect();
                end;

                KeyPicker.Mode = Mode;

                Label.TextColor3 = Library.AccentColor;
                Library.RegistryMap[Label].Properties.TextColor3 = 'AccentColor';

                ModeSelectOuter.Visible = false;
            end;

            function ModeButton:Deselect()
                KeyPicker.Mode = nil;

                Label.TextColor3 = Library.FontColor;
                Library.RegistryMap[Label].Properties.TextColor3 = 'FontColor';
            end;

            Label.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    ModeButton:Select();
                    Library:AttemptSave();
                end;
            end);

            if Mode == KeyPicker.Mode then
                ModeButton:Select();
            end;

            ModeButtons[Mode] = ModeButton;
        end;

        function KeyPicker:Update()
            if Info.NoUI then
                return;
            end;

            local State = KeyPicker:GetState();

            ContainerLabel.Text = string.format('Key: %s | Module: %s | Mode: %s', KeyPicker.Value, Info.Text, KeyPicker.Mode);

            ContainerLabel.Visible = true;
            ContainerLabel.TextColor3 = State and Library.AccentColor or Library.FontColor;

            Library.RegistryMap[ContainerLabel].Properties.TextColor3 = State and 'AccentColor' or 'FontColor';

            local YSize = 0
            local XSize = 0

            for _, Label in next, Library.KeybindContainer:GetChildren() do
                if Label:IsA('TextLabel') and Label.Visible then
                    YSize = YSize + 18;
                    if (Label.TextBounds.X > XSize) then
                        XSize = Label.TextBounds.X
                    end
                end;
            end;

            Library.KeybindFrame.Size = UDim2.new(0, math.max(XSize + 10, 210), 0, YSize + 23)
        end;

        function KeyPicker:GetState()
            if KeyPicker.Mode == 'Always' then
                return true;
            elseif KeyPicker.Mode == 'Hold' then
                if KeyPicker.Value == 'None' then
                    return false;
                end

                local Key = KeyPicker.Value;

                if Key == 'MB1' or Key == 'MB2' then
                    return Key == 'MB1' and InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
                        or Key == 'MB2' and InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2);
                else
                    return InputService:IsKeyDown(Enum.KeyCode[KeyPicker.Value]);
                end;
            else
                return KeyPicker.Toggled;
            end;
        end;

        function KeyPicker:SetValue(Data)
            local Key, Mode = Data[1], Data[2];
            DisplayLabel.Text = Key;
            KeyPicker.Value = Key;
            ModeButtons[Mode]:Select();
            KeyPicker:Update();
        end;

        function KeyPicker:OnClick(Callback)
            KeyPicker.Clicked = Callback
        end

        function KeyPicker:OnChanged(Callback)
            KeyPicker.Changed = Callback
            Callback(KeyPicker.Value)
        end

        if ParentObj.Addons then
            table.insert(ParentObj.Addons, KeyPicker)
        end

        function KeyPicker:DoClick()
            if ParentObj.Type == 'Toggle' and KeyPicker.SyncToggleState then
                ParentObj:SetValue(not ParentObj.Value)
            end

            Library:SafeCallback(KeyPicker.Callback, KeyPicker.Toggled)
            Library:SafeCallback(KeyPicker.Clicked, KeyPicker.Toggled)
        end

        local Picking = false;

        PickOuter.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                Picking = true;

                DisplayLabel.Text = '';

                local Break;
                local Text = '';

                task.spawn(function()
                    while (not Break) do
                        if Text == '...' then
                            Text = '';
                        end;

                        Text = Text .. '.';
                        DisplayLabel.Text = Text;

                        wait(0.4);
                    end;
                end);

                wait(0.2);

                local Event;
                Event = InputService.InputBegan:Connect(function(Input)
                    local Key;

                    if Input.UserInputType == Enum.UserInputType.Keyboard then
                        Key = Input.KeyCode.Name;
                    elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Key = 'MB1';
                    elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
                        Key = 'MB2';
                    end;

                    Break = true;
                    Picking = false;

                    DisplayLabel.Text = Key;
                    KeyPicker.Value = Key;

                    Library:SafeCallback(KeyPicker.ChangedCallback, Input.KeyCode or Input.UserInputType)
                    Library:SafeCallback(KeyPicker.Changed, Input.KeyCode or Input.UserInputType)

                    Library:AttemptSave();

                    Event:Disconnect();
                end);
            elseif Input.UserInputType == Enum.UserInputType.MouseButton2 and not Library:MouseIsOverOpenedFrame() then
                ModeSelectOuter.Visible = true;
            end;
        end);

        Library:GiveSignal(InputService.InputBegan:Connect(function(Input)
            if (not Picking) then
                if KeyPicker.Mode == 'Toggle' then
                    local Key = KeyPicker.Value;

                    if Key == 'MB1' or Key == 'MB2' then
                        if Key == 'MB1' and Input.UserInputType == Enum.UserInputType.MouseButton1
                        or Key == 'MB2' and Input.UserInputType == Enum.UserInputType.MouseButton2 then
                            KeyPicker.Toggled = not KeyPicker.Toggled
                            KeyPicker:DoClick()
                        end;
                    elseif Input.UserInputType == Enum.UserInputType.Keyboard then
                        if Input.KeyCode.Name == Key then
                            KeyPicker.Toggled = not KeyPicker.Toggled;
                            KeyPicker:DoClick()
                        end;
                    end;
                end;

                KeyPicker:Update();
            end;

            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                local AbsPos, AbsSize = ModeSelectOuter.AbsolutePosition, ModeSelectOuter.AbsoluteSize;

                if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X
                    or Mouse.Y < (AbsPos.Y - 20 - 1) or Mouse.Y > AbsPos.Y + AbsSize.Y then

                    ModeSelectOuter.Visible = false;
                end;
            end;
        end))

        Library:GiveSignal(InputService.InputEnded:Connect(function(Input)
            if (not Picking) then
                KeyPicker:Update();
            end;
        end))

        KeyPicker:Update();

        Options[Idx] = KeyPicker;

        return self;
    end;

    BaseAddons.__index = Funcs;
    BaseAddons.__namecall = function(Table, Key, ...)
        return Funcs[Key](...);
    end;
end;

local BaseGroupbox = {};

do
    local Funcs = {};

    function Funcs:AddBlank(Size)
        local Groupbox = self;
        local Container = Groupbox.Container;

        Library:Create('Frame', {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 0, Size);
            ZIndex = 1;
            Parent = Container;
        });
    end;

    function Funcs:AddLabel(Text, DoesWrap)
        local Label = {};

        local Groupbox = self;
        local Container = Groupbox.Container;

        local TextLabel = Library:CreateLabel({
            Size = UDim2.new(1, -4, 0, 15);
            TextSize = 14;
            Text = Text;
            TextWrapped = DoesWrap or false,
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = 5;
            Parent = Container;
        });

        if DoesWrap then
            local Y = select(2, Library:GetTextBounds(Text, Library.Font, 14, Vector2.new(TextLabel.AbsoluteSize.X, math.huge)))
            TextLabel.Size = UDim2.new(1, -4, 0, Y)
        else
            Library:Create('UIListLayout', {
                Padding = UDim.new(0, 4);
                FillDirection = Enum.FillDirection.Horizontal;
                HorizontalAlignment = Enum.HorizontalAlignment.Right;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Parent = TextLabel;
            });
        end

        Label.TextLabel = TextLabel;
        Label.Container = Container;

        function Label:SetText(Text)
            TextLabel.Text = Text

            if DoesWrap then
                local Y = select(2, Library:GetTextBounds(Text, Library.Font, 14, Vector2.new(TextLabel.AbsoluteSize.X, math.huge)))
                TextLabel.Size = UDim2.new(1, -4, 0, Y)
            end

            Groupbox:Resize();
        end

        if (not DoesWrap) then
            setmetatable(Label, BaseAddons);
        end

        Groupbox:AddBlank(5);
        Groupbox:Resize();

        return Label;
    end;

    function Funcs:AddButton(...)
        -- TODO: Eventually redo this
        local Button = {};
        local function ProcessButtonParams(Class, Obj, ...)
            local Props = select(1, ...)
            if type(Props) == 'table' then
                Obj.Text = Props.Text
                Obj.Func = Props.Func
                Obj.DoubleClick = Props.DoubleClick
                Obj.Tooltip = Props.Tooltip
            else
                Obj.Text = select(1, ...)
                Obj.Func = select(2, ...)
            end

            assert(type(Obj.Func) == 'function', 'AddButton: `Func` callback is missing.');
        end

        ProcessButtonParams('Button', Button, ...)

        local Groupbox = self;
        local Container = Groupbox.Container;

        local function CreateBaseButton(Button)
            local Outer = Library:Create('Frame', {
                BackgroundColor3 = Color3.new(0, 0, 0);
                BorderColor3 = Color3.new(0, 0, 0);
                Size = UDim2.new(1, -4, 0, 20);
                ZIndex = 5;
            });

            local Inner = Library:Create('Frame', {
                BackgroundColor3 = Library.MainColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, 0, 1, 0);
                ZIndex = 6;
                Parent = Outer;
            });

            local Label = Library:CreateLabel({
                Size = UDim2.new(1, 0, 1, 0);
                TextSize = 14;
                Text = Button.Text;
                ZIndex = 6;
                Parent = Inner;
            });

            Library:Create('UIGradient', {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
                });
                Rotation = 90;
                Parent = Inner;
            });

            Library:AddToRegistry(Outer, {
                BorderColor3 = 'Black';
            });

            Library:AddToRegistry(Inner, {
                BackgroundColor3 = 'MainColor';
                BorderColor3 = 'OutlineColor';
            });

            Library:OnHighlight(Outer, Outer,
                { BorderColor3 = 'Black' },
                { BorderColor3 = 'Black' }
            );

            return Outer, Inner, Label
        end

        local function InitEvents(Button)
            local function WaitForEvent(event, timeout, validator)
                local bindable = Instance.new('BindableEvent')
                local connection = event:Once(function(...)

                    if type(validator) == 'function' and validator(...) then
                        bindable:Fire(true)
                    else
                        bindable:Fire(false)
                    end
                end)
                task.delay(timeout, function()
                    connection:disconnect()
                    bindable:Fire(false)
                end)
                return bindable.Event:Wait()
            end

            local function ValidateClick(Input)
                if Library:MouseIsOverOpenedFrame() then
                    return false
                end

                if Input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                    return false
                end

                return true
            end

            Button.Outer.InputBegan:Connect(function(Input)
                if not ValidateClick(Input) then return end
                if Button.Locked then return end

                if Button.DoubleClick then
                    Library:RemoveFromRegistry(Button.Label)
                    Library:AddToRegistry(Button.Label, { TextColor3 = 'AccentColor' })

                    Button.Label.TextColor3 = Library.AccentColor
                    Button.Label.Text = 'Are you sure?'
                    Button.Locked = true

                    local clicked = WaitForEvent(Button.Outer.InputBegan, 0.5, ValidateClick)

                    Library:RemoveFromRegistry(Button.Label)
                    Library:AddToRegistry(Button.Label, { TextColor3 = 'FontColor' })

                    Button.Label.TextColor3 = Library.FontColor
                    Button.Label.Text = Button.Text
                    task.defer(rawset, Button, 'Locked', false)

                    if clicked then
                        Library:SafeCallback(Button.Func)
                    end

                    return
                end

                Library:SafeCallback(Button.Func);
            end)
        end

        Button.Outer, Button.Inner, Button.Label = CreateBaseButton(Button)
        Button.Outer.Parent = Container

        InitEvents(Button)

        function Button:AddTooltip(tooltip)
            if type(tooltip) == 'string' then
                Library:AddToolTip(tooltip, self.Outer)
            end
            return self
        end


        function Button:AddButton(...)
            local SubButton = {}

            ProcessButtonParams('SubButton', SubButton, ...)

            self.Outer.Size = UDim2.new(0.5, -2, 0, 20)

            SubButton.Outer, SubButton.Inner, SubButton.Label = CreateBaseButton(SubButton)

            SubButton.Outer.Position = UDim2.new(1, 3, 0, 0)
            SubButton.Outer.Size = UDim2.fromOffset(self.Outer.AbsoluteSize.X - 2, self.Outer.AbsoluteSize.Y)
            SubButton.Outer.Parent = self.Outer

            function SubButton:AddTooltip(tooltip)
                if type(tooltip) == 'string' then
                    Library:AddToolTip(tooltip, self.Outer)
                end
                return SubButton
            end

            if type(SubButton.Tooltip) == 'string' then
                SubButton:AddTooltip(SubButton.Tooltip)
            end

            InitEvents(SubButton)
            return SubButton
        end

        if type(Button.Tooltip) == 'string' then
            Button:AddTooltip(Button.Tooltip)
        end

        Groupbox:AddBlank(5);
        Groupbox:Resize();

        return Button;
    end;

    function Funcs:AddLine()
        local Groupbox = self;
        local Container = self.Container

        local LineDivider = {
            Type = 'Divider',
        }

        Groupbox:AddBlank(2);
        local LineOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -4, 0, 5);
            ZIndex = 5;
            Parent = Container;
        });

        local LineInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 6;
            Parent = LineOuter;
        });

        Library:AddToRegistry(LineOuter, {
            BorderColor3 = 'Black';
        });

        Library:AddToRegistry(LineInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        Groupbox:AddBlank(9);
        Groupbox:Resize();
    end


function Funcs:AddLeftDivider(text)
        local Groupbox = self;
        local Container = self.Container

        local Divider = {
            Type = 'Divider',
        }

        Groupbox:AddBlank(2);
        local LeftDividerOuter = Library:Create('Frame', {
            BackgroundTransparency = 1;
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -4, 0, 15);
            ZIndex = 5;
            Parent = Container;
        });
        local LeftDividerLabel = Library:CreateLabel({
            Size = UDim2.new(1, -4, 0, 15);
            Position = UDim2.new(0, 0, 0, 0);
            TextSize = 14;
            Text = text or "";
            TextWrapped = DoesWrap or false,
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = 8;
            Parent = LeftDividerOuter;
        });

        


        local LeftDividerInner = Library:Create('Frame', {
            BackgroundTransparency = 1;
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 6;
            Parent = LeftDividerOuter;
        });

        Library:AddToRegistry(LeftDividerOuter, {
            BorderColor3 = 'Black';
            BackgroundTransparency = 1;
        });

        Library:AddToRegistry(LeftDividerInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
            BackgroundTransparency = 1;
        });

        Groupbox:AddBlank(9);
        Groupbox:Resize();
    end


    function Funcs:AddDivider(text)
        local Groupbox = self;
        local Container = self.Container

        local Divider = {
            Type = 'Divider',
        }

        Groupbox:AddBlank(2);
        local DividerOuter = Library:Create('Frame', {
            BackgroundTransparency = 1;
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -4, 0, 15);
            ZIndex = 5;
            Parent = Container;
        });
        local DividerLabel = Library:CreateLabel({
            Size = UDim2.new(1, -4, 0, 15);
            Position = UDim2.new(0, 0, 0, 0);
            TextSize = 14;
            Text = text or "";
            TextWrapped = DoesWrap or false,
            TextXAlignment = Enum.TextXAlignment.Center;
            ZIndex = 8;
            Parent = DividerOuter;
        });

        


        local DividerInner = Library:Create('Frame', {
            BackgroundTransparency = 1;
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 6;
            Parent = DividerOuter;
        });

        Library:AddToRegistry(DividerOuter, {
            BorderColor3 = 'Black';
            BackgroundTransparency = 1;
        });

        Library:AddToRegistry(DividerInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
            BackgroundTransparency = 1;
        });

        Groupbox:AddBlank(9);
        Groupbox:Resize();
    end

    function Funcs:AddInput(Idx, Info)
        assert(Info.Text, 'AddInput: Missing `Text` string.')

        local Textbox = {
            Value = Info.Default or '';
            Numeric = Info.Numeric or false;
            Finished = Info.Finished or false;
            Type = 'Input';
            Callback = Info.Callback or function(Value) end;
        };

        local Groupbox = self;
        local Container = Groupbox.Container;

        local InputLabel = Library:CreateLabel({
            Size = UDim2.new(1, 0, 0, 15);
            TextSize = 14;
            Text = Info.Text;
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = 5;
            Parent = Container;
        });

        Groupbox:AddBlank(1);

        local TextBoxOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -4, 0, 20);
            ZIndex = 5;
            Parent = Container;
        });

        local TextBoxInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 6;
            Parent = TextBoxOuter;
        });

        Library:AddToRegistry(TextBoxInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        Library:OnHighlight(TextBoxOuter, TextBoxOuter,
            { BorderColor3 = 'AccentColor' },
            { BorderColor3 = 'Black' }
        );

        if type(Info.Tooltip) == 'string' then
            Library:AddToolTip(Info.Tooltip, TextBoxOuter)
        end

        Library:Create('UIGradient', {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
            });
            Rotation = 90;
            Parent = TextBoxInner;
        });

        local Container = Library:Create('Frame', {
            BackgroundTransparency = 1;
            ClipsDescendants = true;

            Position = UDim2.new(0, 5, 0, 0);
            Size = UDim2.new(1, -5, 1, 0);

            ZIndex = 7;
            Parent = TextBoxInner;
        })

        local Box = Library:Create('TextBox', {
            BackgroundTransparency = 1;

            Position = UDim2.fromOffset(0, 0),
            Size = UDim2.fromScale(5, 1),

            Font = Library.Font;
            PlaceholderColor3 = Color3.fromRGB(190, 190, 190);
            PlaceholderText = Info.Placeholder or '';

            Text = Info.Default or '';
            TextColor3 = Library.FontColor;
            TextSize = 14;
            TextStrokeTransparency = 0;
            TextXAlignment = Enum.TextXAlignment.Left;

            ZIndex = 7;
            Parent = Container;
        });

        Library:ApplyTextStroke(Box);

        function Textbox:SetValue(Text)
            if Info.MaxLength and #Text > Info.MaxLength then
                Text = Text:sub(1, Info.MaxLength);
            end;

            if Textbox.Numeric then
                if (not tonumber(Text)) and Text:len() > 0 then
                    Text = Textbox.Value
                end
            end

            Textbox.Value = Text;
            Box.Text = Text;

            Library:SafeCallback(Textbox.Callback, Textbox.Value);
            Library:SafeCallback(Textbox.Changed, Textbox.Value);
        end;

        if Textbox.Finished then
            Box.FocusLost:Connect(function(enter)
                if not enter then return end

                Textbox:SetValue(Box.Text);
                Library:AttemptSave();
            end)
        else
            Box:GetPropertyChangedSignal('Text'):Connect(function()
                Textbox:SetValue(Box.Text);
                Library:AttemptSave();
            end);
        end

        -- https://devforum.roblox.com/t/how-to-make-textboxes-follow-current-cursor-position/1368429/6
        -- thank you nicemike40 :)

        local function Update()
            local PADDING = 2
            local reveal = Container.AbsoluteSize.X

            if not Box:IsFocused() or Box.TextBounds.X <= reveal - 2 * PADDING then
                -- we aren't focused, or we fit so be normal
                Box.Position = UDim2.new(0, PADDING, 0, 0)
            else
                -- we are focused and don't fit, so adjust position
                local cursor = Box.CursorPosition
                if cursor ~= -1 then
                    -- calculate pixel width of text from start to cursor
                    local subtext = string.sub(Box.Text, 1, cursor-1)
                    local width = TextService:GetTextSize(subtext, Box.TextSize, Box.Font, Vector2.new(math.huge, math.huge)).X

                    -- check if we're inside the box with the cursor
                    local currentCursorPos = Box.Position.X.Offset + width

                    -- adjust if necessary
                    if currentCursorPos < PADDING then
                        Box.Position = UDim2.fromOffset(PADDING-width, 0)
                    elseif currentCursorPos > reveal - PADDING - 1 then
                        Box.Position = UDim2.fromOffset(reveal-width-PADDING-1, 0)
                    end
                end
            end
        end

        task.spawn(Update)

        Box:GetPropertyChangedSignal('Text'):Connect(Update)
        Box:GetPropertyChangedSignal('CursorPosition'):Connect(Update)
        Box.FocusLost:Connect(Update)
        Box.Focused:Connect(Update)

        Library:AddToRegistry(Box, {
            TextColor3 = 'FontColor';
        });

        function Textbox:OnChanged(Func)
            Textbox.Changed = Func;
            Func(Textbox.Value);
        end;

        Groupbox:AddBlank(5);
        Groupbox:Resize();

        Options[Idx] = Textbox;

        return Textbox;
    end;

    function Funcs:AddToggle(Idx, Info)
        assert(Info.Text, 'AddInput: Missing `Text` string.')

        local Toggle = {
            Value = Info.Default or false;
            Type = 'Toggle';

            Callback = Info.Callback or function(Value) end;
            Addons = {},
            Risky = Info.Risky,
        };

        local Groupbox = self;
        local Container = Groupbox.Container;

        local ToggleOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(0, 13, 0, 13);
            ZIndex = 5;
            Parent = Container;
        });

        Library:AddToRegistry(ToggleOuter, {
            BorderColor3 = 'Black';
        });

        local ToggleInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 6;
            Parent = ToggleOuter;
        });

        Library:AddToRegistry(ToggleInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        local ToggleLabel = Library:CreateLabel({
            Size = UDim2.new(0, 216, 1, 0);
            Position = UDim2.new(1, 6, 0, 0);
            TextSize = 14;
            Text = Info.Text;
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = 6;
            Parent = ToggleInner;
        });

        Library:Create('UIListLayout', {
            Padding = UDim.new(0, 4);
            FillDirection = Enum.FillDirection.Horizontal;
            HorizontalAlignment = Enum.HorizontalAlignment.Right;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = ToggleLabel;
        });

        local ToggleRegion = Library:Create('Frame', {
            BackgroundTransparency = 1;
            Size = UDim2.new(0, 170, 1, 0);
            ZIndex = 8;
            Parent = ToggleOuter;
        });

        Library:OnHighlight(ToggleRegion, ToggleOuter,
            { BorderColor3 = 'AccentColor' },
            { BorderColor3 = 'Black' }
        );

        function Toggle:UpdateColors()
            Toggle:Display();
        end;

        if type(Info.Tooltip) == 'string' then
            Library:AddToolTip(Info.Tooltip, ToggleRegion)
        end

        function Toggle:Display()
            ToggleInner.BackgroundColor3 = Toggle.Value and Library.AccentColor or Library.MainColor;
            ToggleInner.BorderColor3 = Toggle.Value and Library.AccentColorDark or Library.OutlineColor;

            Library.RegistryMap[ToggleInner].Properties.BackgroundColor3 = Toggle.Value and 'AccentColor' or 'MainColor';
            Library.RegistryMap[ToggleInner].Properties.BorderColor3 = Toggle.Value and 'AccentColorDark' or 'OutlineColor';
        end;

        function Toggle:OnChanged(Func)
            Toggle.Changed = Func;
            Func(Toggle.Value);
        end;

        function Toggle:SetValue(Bool)
            Bool = (not not Bool);

            Toggle.Value = Bool;
            Toggle:Display();

            for _, Addon in next, Toggle.Addons do
                if Addon.Type == 'KeyPicker' and Addon.SyncToggleState then
                    Addon.Toggled = Bool
                    Addon:Update()
                end
            end

            Library:SafeCallback(Toggle.Callback, Toggle.Value);
            Library:SafeCallback(Toggle.Changed, Toggle.Value);
            Library:UpdateDependencyBoxes();
        end;

        ToggleRegion.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                Toggle:SetValue(not Toggle.Value) -- Why was it not like this from the start?
                Library:AttemptSave();
            end;
        end);

        if Toggle.Risky then
            Library:RemoveFromRegistry(ToggleLabel)
            ToggleLabel.TextColor3 = Library.RiskColor
            Library:AddToRegistry(ToggleLabel, { TextColor3 = 'RiskColor' })
        end

        Toggle:Display();
        Groupbox:AddBlank(Info.BlankSize or 5 + 2);
        Groupbox:Resize();

        Toggle.TextLabel = ToggleLabel;
        Toggle.Container = Container;
        setmetatable(Toggle, BaseAddons);

        Toggles[Idx] = Toggle;

        Library:UpdateDependencyBoxes();

        return Toggle;
    end;

    function Funcs:AddSlider(Idx, Info)
        assert(Info.Default, 'AddSlider: Missing default value.');
        assert(Info.Text, 'AddSlider: Missing slider text.');
        assert(Info.Min, 'AddSlider: Missing minimum value.');
        assert(Info.Max, 'AddSlider: Missing maximum value.');
        assert(Info.Rounding, 'AddSlider: Missing rounding value.');

        local Slider = {
            Value = Info.Default;
            Min = Info.Min;
            Max = Info.Max;
            Rounding = Info.Rounding;
            MaxSize = 232;
            Type = 'Slider';
            Callback = Info.Callback or function(Value) end;
        };

        local Groupbox = self;
        local Container = Groupbox.Container;

        if not Info.Compact then
            Library:CreateLabel({
                Size = UDim2.new(1, 0, 0, 10);
                TextSize = 14;
                Text = Info.Text;
                TextXAlignment = Enum.TextXAlignment.Left;
                TextYAlignment = Enum.TextYAlignment.Bottom;
                ZIndex = 5;
                Parent = Container;
            });

            Groupbox:AddBlank(3);
        end

        local SliderOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -4, 0, 13);
            ZIndex = 5;
            Parent = Container;
        });

        Library:AddToRegistry(SliderOuter, {
            BorderColor3 = 'Black';
        });

        local SliderInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 6;
            Parent = SliderOuter;
        });

        Library:AddToRegistry(SliderInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        local Fill = Library:Create('Frame', {
            BackgroundColor3 = Library.AccentColor;
            BorderColor3 = Library.AccentColorDark;
            Size = UDim2.new(0, 0, 1, 0);
            ZIndex = 7;
            Parent = SliderInner;
        });

        Library:AddToRegistry(Fill, {
            BackgroundColor3 = 'AccentColor';
            BorderColor3 = 'AccentColorDark';
        });

        local HideBorderRight = Library:Create('Frame', {
            BackgroundColor3 = Library.AccentColor;
            BorderSizePixel = 0;
            Position = UDim2.new(1, 0, 0, 0);
            Size = UDim2.new(0, 1, 1, 0);
            ZIndex = 8;
            Parent = Fill;
        });

        Library:AddToRegistry(HideBorderRight, {
            BackgroundColor3 = 'AccentColor';
        });

        local DisplayLabel = Library:CreateLabel({
            Size = UDim2.new(1, 0, 1, 0);
            TextSize = 14;
            Text = 'Infinite';
            ZIndex = 9;
            Parent = SliderInner;
        });

        Library:OnHighlight(SliderOuter, SliderOuter,
            { BorderColor3 = 'AccentColor' },
            { BorderColor3 = 'Black' }
        );

        if type(Info.Tooltip) == 'string' then
            Library:AddToolTip(Info.Tooltip, SliderOuter)
        end

        function Slider:UpdateColors()
            Fill.BackgroundColor3 = Library.AccentColor;
            Fill.BorderColor3 = Library.AccentColorDark;
        end;

        function Slider:Display()
            local Suffix = Info.Suffix or '';

            if Info.Compact then
                DisplayLabel.Text = Info.Text .. ': ' .. Slider.Value .. Suffix
            elseif Info.HideMax then
                DisplayLabel.Text = string.format('%s', Slider.Value .. Suffix)
            else
                DisplayLabel.Text = string.format('%s/%s', Slider.Value .. Suffix, Slider.Max .. Suffix);
            end

            local X = math.ceil(Library:MapValue(Slider.Value, Slider.Min, Slider.Max, 0, Slider.MaxSize));
            Fill.Size = UDim2.new(0, X, 1, 0);

            HideBorderRight.Visible = not (X == Slider.MaxSize or X == 0);
        end;

        function Slider:OnChanged(Func)
            Slider.Changed = Func;
            Func(Slider.Value);
        end;

        local function Round(Value)
            if Slider.Rounding == 0 then
                return math.floor(Value);
            end;


            return tonumber(string.format('%.' .. Slider.Rounding .. 'f', Value))
        end;

        function Slider:GetValueFromXOffset(X)
            return Round(Library:MapValue(X, 0, Slider.MaxSize, Slider.Min, Slider.Max));
        end;

        function Slider:SetValue(Str)
            local Num = tonumber(Str);

            if (not Num) then
                return;
            end;

            Num = math.clamp(Num, Slider.Min, Slider.Max);

            Slider.Value = Num;
            Slider:Display();

            Library:SafeCallback(Slider.Callback, Slider.Value);
            Library:SafeCallback(Slider.Changed, Slider.Value);
        end;

        SliderInner.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                local mPos = Mouse.X;
                local gPos = Fill.Size.X.Offset;
                local Diff = mPos - (Fill.AbsolutePosition.X + gPos);

                while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                    local nMPos = Mouse.X;
                    local nX = math.clamp(gPos + (nMPos - mPos) + Diff, 0, Slider.MaxSize);

                    local nValue = Slider:GetValueFromXOffset(nX);
                    local OldValue = Slider.Value;
                    Slider.Value = nValue;

                    Slider:Display();

                    if nValue ~= OldValue then
                        Library:SafeCallback(Slider.Callback, Slider.Value);
                        Library:SafeCallback(Slider.Changed, Slider.Value);
                    end;

                    RenderStepped:Wait();
                end;

                Library:AttemptSave();
            end;
        end);

        Slider:Display();
        Groupbox:AddBlank(Info.BlankSize or 6);
        Groupbox:Resize();

        Options[Idx] = Slider;

        return Slider;
    end;

    function Funcs:AddDropdown(Idx, Info)
        if Info.SpecialType == 'Player' then
            Info.Values = GetPlayersString();
            Info.AllowNull = true;
        elseif Info.SpecialType == 'Team' then
            Info.Values = GetTeamsString();
            Info.AllowNull = true;
        end;

        assert(Info.Values, 'AddDropdown: Missing dropdown value list.');
        assert(Info.AllowNull or Info.Default, 'AddDropdown: Missing default value. Pass `AllowNull` as true if this was intentional.')

        if (not Info.Text) then
            Info.Compact = true;
        end;

        local Dropdown = {
            Values = Info.Values;
            Value = Info.Multi and {};
            Multi = Info.Multi;
            Type = 'Dropdown';
            SpecialType = Info.SpecialType; -- can be either 'Player' or 'Team'
            Callback = Info.Callback or function(Value) end;
        };

        local Groupbox = self;
        local Container = Groupbox.Container;

        local RelativeOffset = 0;

        if not Info.Compact then
            local DropdownLabel = Library:CreateLabel({
                Size = UDim2.new(1, 0, 0, 10);
                TextSize = 14;
                Text = Info.Text;
                TextXAlignment = Enum.TextXAlignment.Left;
                TextYAlignment = Enum.TextYAlignment.Bottom;
                ZIndex = 5;
                Parent = Container;
            });

            Groupbox:AddBlank(3);
        end

        for _, Element in next, Container:GetChildren() do
            if not Element:IsA('UIListLayout') then
                RelativeOffset = RelativeOffset + Element.Size.Y.Offset;
            end;
        end;

        local DropdownOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -4, 0, 20);
            ZIndex = 5;
            Parent = Container;
        });

        Library:AddToRegistry(DropdownOuter, {
            BorderColor3 = 'Black';
        });

        local DropdownInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 6;
            Parent = DropdownOuter;
        });

        Library:AddToRegistry(DropdownInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        Library:Create('UIGradient', {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
            });
            Rotation = 90;
            Parent = DropdownInner;
        });

        local DropdownArrow = Library:Create('ImageLabel', {
            AnchorPoint = Vector2.new(0, 0.5);
            BackgroundTransparency = 1;
            Position = UDim2.new(1, -16, 0.5, 0);
            Size = UDim2.new(0, 12, 0, 12);
            Image = 'http://www.roblox.com/asset/?id=6282522798';
            ZIndex = 8;
            Parent = DropdownInner;
        });

        local ItemList = Library:CreateLabel({
            Position = UDim2.new(0, 5, 0, 0);
            Size = UDim2.new(1, -5, 1, 0);
            TextSize = 14;
            Text = '--';
            TextXAlignment = Enum.TextXAlignment.Left;
            TextWrapped = true;
            ZIndex = 7;
            Parent = DropdownInner;
        });

        Library:OnHighlight(DropdownOuter, DropdownOuter,
            { BorderColor3 = 'AccentColor' },
            { BorderColor3 = 'Black' }
        );

        if type(Info.Tooltip) == 'string' then
            Library:AddToolTip(Info.Tooltip, DropdownOuter)
        end

        local MAX_DROPDOWN_ITEMS = 8;

        local ListOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            ZIndex = 20;
            Visible = false;
            Parent = ScreenGui;
        });

        local function RecalculateListPosition()
            ListOuter.Position = UDim2.fromOffset(DropdownOuter.AbsolutePosition.X, DropdownOuter.AbsolutePosition.Y + DropdownOuter.Size.Y.Offset + 1);
        end;

        local function RecalculateListSize(YSize)
            ListOuter.Size = UDim2.fromOffset(DropdownOuter.AbsoluteSize.X, YSize or (MAX_DROPDOWN_ITEMS * 20 + 2))
        end;

        RecalculateListPosition();
        RecalculateListSize();

        DropdownOuter:GetPropertyChangedSignal('AbsolutePosition'):Connect(RecalculateListPosition);

        local ListInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 21;
            Parent = ListOuter;
        });

        Library:AddToRegistry(ListInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        local Scrolling = Library:Create('ScrollingFrame', {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            CanvasSize = UDim2.new(0, 0, 0, 0);
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 21;
            Parent = ListInner;

            TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',
            BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',

            ScrollBarThickness = 3,
            ScrollBarImageColor3 = Library.AccentColor,
        });

        Library:AddToRegistry(Scrolling, {
            ScrollBarImageColor3 = 'AccentColor'
        })

        Library:Create('UIListLayout', {
            Padding = UDim.new(0, 0);
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = Scrolling;
        });

        function Dropdown:Display()
            local Values = Dropdown.Values;
            local Str = '';

            if Info.Multi then
                for Idx, Value in next, Values do
                    if Dropdown.Value[Value] then
                        Str = Str .. Value .. ', ';
                    end;
                end;

                Str = Str:sub(1, #Str - 2);
            else
                Str = Dropdown.Value or '';
            end;

            ItemList.Text = (Str == '' and '--' or Str);
        end;

        function Dropdown:GetActiveValues()
            if Info.Multi then
                local T = {};

                for Value, Bool in next, Dropdown.Value do
                    table.insert(T, Value);
                end;

                return T;
            else
                return Dropdown.Value and 1 or 0;
            end;
        end;

        function Dropdown:BuildDropdownList()
            local Values = Dropdown.Values;
            local Buttons = {};

            for _, Element in next, Scrolling:GetChildren() do
                if not Element:IsA('UIListLayout') then
                    Element:Destroy();
                end;
            end;

            local Count = 0;

            for Idx, Value in next, Values do
                local Table = {};

                Count = Count + 1;

                local Button = Library:Create('Frame', {
                    BackgroundColor3 = Library.MainColor;
                    BorderColor3 = Library.OutlineColor;
                    BorderMode = Enum.BorderMode.Middle;
                    Size = UDim2.new(1, -1, 0, 20);
                    ZIndex = 23;
                    Active = true,
                    Parent = Scrolling;
                });

                Library:AddToRegistry(Button, {
                    BackgroundColor3 = 'MainColor';
                    BorderColor3 = 'OutlineColor';
                });

                local ButtonLabel = Library:CreateLabel({
                    Active = false;
                    Size = UDim2.new(1, -6, 1, 0);
                    Position = UDim2.new(0, 6, 0, 0);
                    TextSize = 14;
                    Text = Value;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    ZIndex = 25;
                    Parent = Button;
                });

                Library:OnHighlight(Button, Button,
                    { BorderColor3 = 'AccentColor', ZIndex = 24 },
                    { BorderColor3 = 'OutlineColor', ZIndex = 23 }
                );

                local Selected;

                if Info.Multi then
                    Selected = Dropdown.Value[Value];
                else
                    Selected = Dropdown.Value == Value;
                end;

                function Table:UpdateButton()
                    if Info.Multi then
                        Selected = Dropdown.Value[Value];
                    else
                        Selected = Dropdown.Value == Value;
                    end;

                    ButtonLabel.TextColor3 = Selected and Library.AccentColor or Library.FontColor;
                    Library.RegistryMap[ButtonLabel].Properties.TextColor3 = Selected and 'AccentColor' or 'FontColor';
                end;

                ButtonLabel.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local Try = not Selected;

                        if Dropdown:GetActiveValues() == 1 and (not Try) and (not Info.AllowNull) then
                        else
                            if Info.Multi then
                                Selected = Try;

                                if Selected then
                                    Dropdown.Value[Value] = true;
                                else
                                    Dropdown.Value[Value] = nil;
                                end;
                            else
                                Selected = Try;

                                if Selected then
                                    Dropdown.Value = Value;
                                else
                                    Dropdown.Value = nil;
                                end;

                                for _, OtherButton in next, Buttons do
                                    OtherButton:UpdateButton();
                                end;
                            end;

                            Table:UpdateButton();
                            Dropdown:Display();

                            Library:SafeCallback(Dropdown.Callback, Dropdown.Value);
                            Library:SafeCallback(Dropdown.Changed, Dropdown.Value);

                            Library:AttemptSave();
                        end;
                    end;
                end);

                Table:UpdateButton();
                Dropdown:Display();

                Buttons[Button] = Table;
            end;

            Scrolling.CanvasSize = UDim2.fromOffset(0, (Count * 20) + 1);

            local Y = math.clamp(Count * 20, 0, MAX_DROPDOWN_ITEMS * 20) + 1;
            RecalculateListSize(Y);
        end;

        function Dropdown:SetValues(NewValues)
            if NewValues then
                Dropdown.Values = NewValues;
            end;

            Dropdown:BuildDropdownList();
        end;

        function Dropdown:OpenDropdown()
            ListOuter.Visible = true;
            Library.OpenedFrames[ListOuter] = true;
            DropdownArrow.Rotation = 180;
        end;

        function Dropdown:CloseDropdown()
            ListOuter.Visible = false;
            Library.OpenedFrames[ListOuter] = nil;
            DropdownArrow.Rotation = 0;
        end;

        function Dropdown:OnChanged(Func)
            Dropdown.Changed = Func;
            Func(Dropdown.Value);
        end;

        function Dropdown:SetValue(Val)
            if Dropdown.Multi then
                local nTable = {};

                for Value, Bool in next, Val do
                    if table.find(Dropdown.Values, Value) then
                        nTable[Value] = true
                    end;
                end;

                Dropdown.Value = nTable;
            else
                if (not Val) then
                    Dropdown.Value = nil;
                elseif table.find(Dropdown.Values, Val) then
                    Dropdown.Value = Val;
                end;
            end;

            Dropdown:BuildDropdownList();

            Library:SafeCallback(Dropdown.Callback, Dropdown.Value);
            Library:SafeCallback(Dropdown.Changed, Dropdown.Value);
        end;

        DropdownOuter.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                if ListOuter.Visible then
                    Dropdown:CloseDropdown();
                else
                    Dropdown:OpenDropdown();
                end;
            end;
        end);

        InputService.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                local AbsPos, AbsSize = ListOuter.AbsolutePosition, ListOuter.AbsoluteSize;

                if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X
                    or Mouse.Y < (AbsPos.Y - 20 - 1) or Mouse.Y > AbsPos.Y + AbsSize.Y then

                    Dropdown:CloseDropdown();
                end;
            end;
        end);

        Dropdown:BuildDropdownList();
        Dropdown:Display();

        local Defaults = {}

        if type(Info.Default) == 'string' then
            local Idx = table.find(Dropdown.Values, Info.Default)
            if Idx then
                table.insert(Defaults, Idx)
            end
        elseif type(Info.Default) == 'table' then
            for _, Value in next, Info.Default do
                local Idx = table.find(Dropdown.Values, Value)
                if Idx then
                    table.insert(Defaults, Idx)
                end
            end
        elseif type(Info.Default) == 'number' and Dropdown.Values[Info.Default] ~= nil then
            table.insert(Defaults, Info.Default)
        end

        if next(Defaults) then
            for i = 1, #Defaults do
                local Index = Defaults[i]
                if Info.Multi then
                    Dropdown.Value[Dropdown.Values[Index]] = true
                else
                    Dropdown.Value = Dropdown.Values[Index];
                end

                if (not Info.Multi) then break end
            end

            Dropdown:BuildDropdownList();
            Dropdown:Display();
        end

        Groupbox:AddBlank(Info.BlankSize or 5);
        Groupbox:Resize();

        Options[Idx] = Dropdown;

        return Dropdown;
    end;

    function Funcs:AddDependencyBox()
        local Depbox = {
            Dependencies = {};
        };
        
        local Groupbox = self;
        local Container = Groupbox.Container;

        local Holder = Library:Create('Frame', {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 0, 0);
            Visible = false;
            Parent = Container;
        });

        local Frame = Library:Create('Frame', {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 1, 0);
            Visible = true;
            Parent = Holder;
        });

        local Layout = Library:Create('UIListLayout', {
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = Frame;
        });

        function Depbox:Resize()
            Holder.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y);
            Groupbox:Resize();
        end;

        Layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
            Depbox:Resize();
        end);

        Holder:GetPropertyChangedSignal('Visible'):Connect(function()
            Depbox:Resize();
        end);

        function Depbox:Update()
            for _, Dependency in next, Depbox.Dependencies do
                local Elem = Dependency[1];
                local Value = Dependency[2];

                if Elem.Type == 'Toggle' and Elem.Value ~= Value then
                    Holder.Visible = false;
                    Depbox:Resize();
                    return;
                end;
            end;

            Holder.Visible = true;
            Depbox:Resize();
        end;

        function Depbox:SetupDependencies(Dependencies)
            for _, Dependency in next, Dependencies do
                assert(type(Dependency) == 'table', 'SetupDependencies: Dependency is not of type `table`.');
                assert(Dependency[1], 'SetupDependencies: Dependency is missing element argument.');
                assert(Dependency[2] ~= nil, 'SetupDependencies: Dependency is missing value argument.');
            end;

            Depbox.Dependencies = Dependencies;
            Depbox:Update();
        end;

        Depbox.Container = Frame;

        setmetatable(Depbox, BaseGroupbox);

        table.insert(Library.DependencyBoxes, Depbox);

        return Depbox;
    end;

    BaseGroupbox.__index = Funcs;
    BaseGroupbox.__namecall = function(Table, Key, ...)
        return Funcs[Key](...);
    end;
end;

-- < Create other UI elements >
do
    Library.NotificationArea = Library:Create('Frame', {
        BackgroundTransparency = 1;
        Position = UDim2.new(0, 0, 0, 40);
        Size = UDim2.new(0, 300, 0, 200);
        ZIndex = 100;
        Parent = ScreenGui;
    });

    Library:Create('UIListLayout', {
        Padding = UDim.new(0, 4);
        FillDirection = Enum.FillDirection.Vertical;
        SortOrder = Enum.SortOrder.LayoutOrder;
        Parent = Library.NotificationArea;
    });

    local WatermarkOuter = Library:Create('Frame', {
        BorderColor3 = Color3.new(0, 0, 0);
        Position = UDim2.new(0, 100, 0, -25);
        Size = UDim2.new(0, 213, 0, 20);
        ZIndex = 200;
        Visible = false;
        Parent = ScreenGui;
    });
    local WatermarkInner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.AccentColor;
        BorderMode = Enum.BorderMode.Inset;
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 201;
        Parent = WatermarkOuter;
    });
    Library:AddToRegistry(WatermarkInner, {
        BorderColor3 = 'AccentColor';
    });

    local InnerFrame = Library:Create('Frame', {
        BackgroundColor3 = Color3.new(1, 1, 1);
        BorderSizePixel = 0;
        Position = UDim2.new(0, 1, 0, 1);
        Size = UDim2.new(1, -2, 1, -2);
        ZIndex = 202;
        Parent = WatermarkInner;
    });
    local Gradient = Library:Create('UIGradient', {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Library:GetDarkerColor(Library.MainColor)),
            ColorSequenceKeypoint.new(1, Library.MainColor),
        });
        Rotation = -90;
        Parent = InnerFrame;
    });

    Library:AddToRegistry(Gradient, {
        Color = function()
            return ColorSequence.new({
                ColorSequenceKeypoint.new(0, Library:GetDarkerColor(Library.MainColor)),
                ColorSequenceKeypoint.new(1, Library.MainColor),
            });
        end
    });

    local WatermarkLabel = Library:CreateLabel({
        Position = UDim2.new(0, 5, 0, 0);
        Size = UDim2.new(1, -4, 1, 0);
        TextSize = 14;
        TextXAlignment = Enum.TextXAlignment.Left;
        ZIndex = 203;
        Parent = InnerFrame;
    });

    task.spawn(function()
		while task.wait() do
			WatermarkLabel.TextColor3 = Color3.fromHSV(math.abs(math.sin(tick() / 2)), 1, 1)
            WatermarkLabel.TextSize = math.random(14, 20)
        end
	end)

    Library.Watermark = WatermarkOuter;
    Library.WatermarkText = WatermarkLabel;
    Library:MakeDraggable(Library.Watermark);



    local KeybindOuter = Library:Create('Frame', {
        BackgroundTransparency = 1;
        AnchorPoint = Vector2.new(0, 0.5);
        BorderColor3 = Color3.new(0, 0, 0);
        Position = UDim2.new(0, 10, 0.5, 0);
        Size = UDim2.new(0, 210, 0, 20);
        Visible = false;
        ZIndex = 100;
        Parent = ScreenGui;
    });

    local KeybindInner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        BorderMode = Enum.BorderMode.Inset;
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 101;
        Parent = KeybindOuter;
    });
    table.insert(ui_utility.keybinds_trans,KeybindInner)

    Library:AddToRegistry(KeybindInner, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    }, true);

    local ColorFrame = Library:Create('Frame', {
        BackgroundColor3 = Library.AccentColor;
        BorderSizePixel = 0;
        Size = UDim2.new(1, 0, 0, 2);
        ZIndex = 102;
        Parent = KeybindInner;
    });

    Library:AddToRegistry(ColorFrame, {
        BackgroundColor3 = 'AccentColor';
    }, true);

    local KeybindLabel = Library:CreateLabel({
        Size = UDim2.new(1, 0, 0, 20);
        Position = UDim2.fromOffset(100, 2),
        TextXAlignment = Enum.TextXAlignment.Left,

        Text = 'Bind List';
        ZIndex = 104;
        Parent = KeybindInner;
    });

    local KeybindContainer = Library:Create('Frame', {
        BackgroundTransparency = 1;
        Size = UDim2.new(1, 0, 1, -20);
        Position = UDim2.new(0, 0, 0, 20);
        ZIndex = 1;
        Parent = KeybindInner;
    });

    Library:Create('UIListLayout', {
        FillDirection = Enum.FillDirection.Vertical;
        SortOrder = Enum.SortOrder.LayoutOrder;
        Parent = KeybindContainer;
    });

    Library:Create('UIPadding', {
        PaddingLeft = UDim.new(0, 5),
        Parent = KeybindContainer,
    })

    Library.KeybindFrame = KeybindOuter;
    Library.KeybindContainer = KeybindContainer;
    Library:MakeDraggable(KeybindOuter);
end;

function Library:SetWatermarkVisibility(Bool)
    Library.Watermark.Visible = Bool;
end;

function Library:SetWatermark(Text)
    local X, Y = Library:GetTextBounds(Text, Library.Font, 14);
    Library.Watermark.Size = UDim2.new(0, X + 15, 0, (Y * 1.5) + 3);
    Library:SetWatermarkVisibility(true)

    Library.WatermarkText.Text = Text;
end;

function Library:Notify(Text, Time)
    local XSize, YSize = Library:GetTextBounds(Text, Library.Font, 14);

    YSize = YSize + 7

    local NotifyOuter = Library:Create('Frame', {
        BorderColor3 = Color3.new(0, 0, 0);
        Position = UDim2.new(0, 100, 0, 10);
        Size = UDim2.new(0, 0, 0, YSize);
        ClipsDescendants = true;
        ZIndex = 100;
        Parent = Library.NotificationArea;
    });

    local NotifyInner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        BorderMode = Enum.BorderMode.Inset;
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 101;
        Parent = NotifyOuter;
    });

    Library:AddToRegistry(NotifyInner, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    }, true);

    local InnerFrame = Library:Create('Frame', {
        BackgroundColor3 = Color3.new(1, 1, 1);
        BorderSizePixel = 0;
        Position = UDim2.new(0, 1, 0, 1);
        Size = UDim2.new(1, -2, 1, -2);
        ZIndex = 102;
        Parent = NotifyInner;
    });

    local Gradient = Library:Create('UIGradient', {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Library:GetDarkerColor(Library.MainColor)),
            ColorSequenceKeypoint.new(1, Library.MainColor),
        });
        Rotation = -90;
        Parent = InnerFrame;
    });

    Library:AddToRegistry(Gradient, {
        Color = function()
            return ColorSequence.new({
                ColorSequenceKeypoint.new(0, Library:GetDarkerColor(Library.MainColor)),
                ColorSequenceKeypoint.new(1, Library.MainColor),
            });
        end
    });

    local NotifyLabel = Library:CreateLabel({
        Position = UDim2.new(0, 4, 0, 0);
        Size = UDim2.new(1, -4, 1, 0);
        Text = Text;
        TextXAlignment = Enum.TextXAlignment.Left;
        TextSize = 14;
        ZIndex = 103;
        Parent = InnerFrame;
    });

    local LeftColor = Library:Create('Frame', {
        BackgroundColor3 = Library.AccentColor;
        BorderSizePixel = 0;
        Position = UDim2.new(0, -1, 0, -1);
        Size = UDim2.new(0, 3, 1, 2);
        ZIndex = 104;
        Parent = NotifyOuter;
    });

    Library:AddToRegistry(LeftColor, {
        BackgroundColor3 = 'AccentColor';
    }, true);

    pcall(NotifyOuter.TweenSize, NotifyOuter, UDim2.new(0, XSize + 8 + 4, 0, YSize), 'Out', 'Quad', 0.4, true);

    task.spawn(function()
        wait(Time or 5);

        pcall(NotifyOuter.TweenSize, NotifyOuter, UDim2.new(0, 0, 0, YSize), 'Out', 'Quad', 0.4, true);

        wait(0.4);

        NotifyOuter:Destroy();
    end);
end;

function Library:CreateWindow(...)
    local Arguments = { ... }
    local Config = { AnchorPoint = Vector2.zero }

    if type(...) == 'table' then
        Config = ...;
    else
        Config.Title = Arguments[1]
        Config.AutoShow = Arguments[2] or false;
    end

    if type(Config.Title) ~= 'string' then Config.Title = 'No title' end
    if type(Config.TabPadding) ~= 'number' then Config.TabPadding = 0 end
    if type(Config.MenuFadeTime) ~= 'number' then Config.MenuFadeTime = 0.2 end

    if typeof(Config.Position) ~= 'UDim2' then Config.Position = UDim2.fromOffset(130, 50) end
    if typeof(Config.Size) ~= 'UDim2' then Config.Size = UDim2.fromOffset(580, 595) end

    if Config.Center then
        Config.AnchorPoint = Vector2.new(0.5, 0.5)
        Config.Position = UDim2.fromScale(0.5, 0.5)
    end

    local Window = {
        Tabs = {};
    };

    local Outer = Library:Create('Frame', {
        BackgroundTransparency = 1;
        AnchorPoint = Config.AnchorPoint,
        BackgroundColor3 = Color3.new(0, 0, 0);
        BorderSizePixel = 0;
        Position = Config.Position,
        Size = Config.Size,
        Visible = false;
        ZIndex = 1;
        Parent = ScreenGui;
    });


 
    Library:MakeDraggable(Outer, 25);

    local Inner = Library:Create('Frame', {
        BackgroundTransparency = 1;
        BackgroundColor3 = Color3.new(0, 0, 0);
        BorderColor3 = Color3.fromRGB(0,0,0);
       -- BorderMode = Enum.BorderMode.Inset;
        Position = UDim2.new(0, 1, 0, 1);
        Size = UDim2.new(1, -2, 1, -2);
        ZIndex = 1;
        Parent = Outer;
    });

    local backimageframe = Library:Create('ImageLabel', {
        AnchorPoint = Config.AnchorPoint;
        Size = Config.Size;
        Position = Config.Position,
        ImageColor3 = Library.ImageColor;
        ZIndex = 0;
        Parent = Outer;
    });
    Library:AddToRegistry(backimageframe, {
        ImageColor3 = "ImageColor";
    });

    table.insert(ui_utility.image_color,backimageframe)

    Library:AddToRegistry(Inner, {
        BackgroundTransparency = 1;
        BorderColor3 = Color3.fromRGB(0,0,0);
    });

    local WindowLabel = Library:CreateLabel({
        Position = UDim2.new(0, 7, 0, 0);
        Size = UDim2.new(0, 0, 0, 25);
        Text = Config.Title or '';
        TextXAlignment = Enum.TextXAlignment.Left;
        ZIndex = 1;
        Parent = Inner;
    });

    local texts = {
        "get pwned by office (legend)",
        "pwned back to sanctions with your cool cola..",
        "ruskiware - shit for shits",
        "office > all",
        "ruskiware - the real failed hit (no prediction)",
    }

    task.spawn(function()
        while wait(2) do
            WindowLabel.Text = texts[math.random(1, #texts)]
        end
    end)

	
	task.spawn(function()
		while task.wait() do
			WindowLabel.TextColor3 = Color3.fromHSV(math.abs(math.sin(tick() / 2)), 1, 1)
		
            Outer.Rotation = math.sin(tick() / 7) * 360
        end
	end)


    local MainSectionOuter = Library:Create('Frame', {
        BackgroundTransparency = 1;
       -- BackgroundColor3 = Library.BackgroundColor;
        BorderColor3 = Library.OutlineColor;
        Position = UDim2.new(0, 8, 0, 25);
        Size = UDim2.new(1, -16, 1, -33);
        ZIndex = 1;
        Parent = Inner;
    });

    Library:AddToRegistry(MainSectionOuter, {
        BackgroundColor3 = 'BackgroundColor';
        BorderColor3 = 'OutlineColor';
    });

    local MainSectionInner = Library:Create('Frame', {
        BackgroundTransparency = 1;
       -- BackgroundColor3 = Library.BackgroundColor;
        BorderColor3 = Color3.new(0, 0, 0);
        BorderMode = Enum.BorderMode.Inset;
        Position = UDim2.new(0, 0, 0, 0);
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 1;
        Parent = MainSectionOuter;
    });

    Library:AddToRegistry(MainSectionInner, {
        BackgroundColor3 = 'BackgroundColor';
    });

    local TabArea = Library:Create('Frame', {
        BackgroundTransparency = 1;
        Position = UDim2.new(0, 110, 0, 8);
        Size = UDim2.new(1, -16, 0, 21);
        ZIndex = 1;
        Parent = MainSectionInner;
    });

    local TabListLayout = Library:Create('UIListLayout', {
        Padding = UDim.new(0, Config.TabPadding);
        FillDirection = Enum.FillDirection.Horizontal;
        SortOrder = Enum.SortOrder.LayoutOrder;
        Parent = TabArea;
    });

    local TabContainer = Library:Create('Frame', {
        BackgroundTransparency = 1;
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        Position = UDim2.new(0, 8, 0, 30);
        Size = UDim2.new(1, -16, 1, -38);
        ZIndex = 2;
        Parent = MainSectionInner;
    });
    

    Library:AddToRegistry(TabContainer, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    });

    function Window:SetWindowTitle(Title)
        WindowLabel.Text = Title;
    end;

    function Window:AddTab(Name)
        local Tab = {
            Groupboxes = {};
            Tabboxes = {};
        };

        local TabButtonWidth = Library:GetTextBounds(Name, Library.Font, 16);

        local TabButton = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Color3.fromRGB(0,0,0);
            Size = UDim2.new(0, TabButtonWidth + 8 + 4, 1, 0);
            ZIndex = 1;
            Parent = TabArea;
        });

        Library:AddToRegistry(TabButton, {
            BackgroundTransparency = 1;
            BackgroundColor3 = 'BackgroundColor';
            BorderColor3 = 'OutlineColor';
        });

        local TabButtonLabel = Library:CreateLabel({
            Position = UDim2.new(0, 0, 0, 0);
            Size = UDim2.new(1, 0, 1, -1);
            Text = Name;
            ZIndex = 1;
            Parent = TabButton;
        });

        local Blocker = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderSizePixel = 0;
            Position = UDim2.new(0, 0, 1, 0);
            Size = UDim2.new(1, 0, 0, 1);
            BackgroundTransparency = 1;
            ZIndex = 3;
            Parent = TabButton;
        });

        Library:AddToRegistry(Blocker, {
            BackgroundColor3 = 'MainColor';
        });

        local TabFrame = Library:Create('Frame', {
            Name = 'TabFrame',
            BackgroundTransparency = 1;
            Position = UDim2.new(0, 0, 0, 0);
            Size = UDim2.new(1, 0, 1, 0);
            Visible = false;
            ZIndex = 2;
            Parent = TabContainer;
        });

        local LeftSide = Library:Create('ScrollingFrame', {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Position = UDim2.new(0, 8 - 1, 0, 8 - 1);
            Size = UDim2.new(0.5, -12 + 2, 0, 507 + 2);
            CanvasSize = UDim2.new(0, 0, 0, 0);
            BottomImage = '';
            TopImage = '';
            ScrollBarThickness = 0;
            ZIndex = 2;
            Parent = TabFrame;
        });

        local RightSide = Library:Create('ScrollingFrame', {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Position = UDim2.new(0.5, 4 + 1, 0, 8 - 1);
            Size = UDim2.new(0.5, -12 + 2, 0, 507 + 2);
            CanvasSize = UDim2.new(0, 0, 0, 0);
            BottomImage = '';
            TopImage = '';
            ScrollBarThickness = 0;
            ZIndex = 2;
            Parent = TabFrame;
        });

        Library:Create('UIListLayout', {
            Padding = UDim.new(0, 8);
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            HorizontalAlignment = Enum.HorizontalAlignment.Center;
            Parent = LeftSide;
        });

        Library:Create('UIListLayout', {
            Padding = UDim.new(0, 8);
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            HorizontalAlignment = Enum.HorizontalAlignment.Center;
            Parent = RightSide;
        });

        for _, Side in next, { LeftSide, RightSide } do
            Side:WaitForChild('UIListLayout'):GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
                Side.CanvasSize = UDim2.fromOffset(0, Side.UIListLayout.AbsoluteContentSize.Y);
            end);
        end;

        function Tab:ShowTab()
            for _, Tab in next, Window.Tabs do
                Tab:HideTab();
            end;

            Blocker.BackgroundTransparency = 0;
            TabButton.BackgroundColor3 = Library.MainColor;
            Library.RegistryMap[TabButton].Properties.BackgroundColor3 = 'MainColor';
            TabFrame.Visible = true;
        end;

        function Tab:HideTab()
            Blocker.BackgroundTransparency = 1;
            TabButton.BackgroundColor3 = Library.BackgroundColor;
            Library.RegistryMap[TabButton].Properties.BackgroundColor3 = 'BackgroundColor';
            TabFrame.Visible = false;
        end;

        function Tab:SetLayoutOrder(Position)
            TabButton.LayoutOrder = Position;
            TabListLayout:ApplyLayout();
        end;

        function Tab:AddGroupbox(Info)
            local Groupbox = {};

            local BoxOuter = Library:Create('Frame', {
                BackgroundTransparency = 1;
               -- BackgroundColor3 = Library.BackgroundColor;
                --BorderColor3 = Library.OutlineColor;
                --BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, 0, 0, 507 + 2);
                ZIndex = 2;
                Parent = Info.Side == 1 and LeftSide or RightSide;
            });

            Library:AddToRegistry(BoxOuter, {
                BackgroundTransparency = 1;
               -- BackgroundColor3 = 'BackgroundColor';
                BorderColor3 = 'OutlineColor';
            });

            local BoxInner = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Color3.new(0, 0, 0);
                -- BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, -2, 1, -2);
                Position = UDim2.new(0, 1, 0, 1);
                ZIndex = 4;
                Parent = BoxOuter;
            });
            table.insert(ui_utility.tab_trans,BoxInner)
            Library:AddToRegistry(BoxInner, {
                BackgroundTransparency = 1;
                BackgroundColor3 = 'BackgroundColor';
            });



            local GroupboxLabel = Library:CreateLabel({
                Size = UDim2.new(1, 0, 0, 18);
                Position = UDim2.new(0, 4, 0, 2);
                TextSize = 14;
                Text = Info.Name;
                TextXAlignment = Enum.TextXAlignment.Left;
                ZIndex = 5;
                Parent = BoxInner;
            });

            local Container = Library:Create('Frame', {
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 4, 0, 20);
                Size = UDim2.new(1, -4, 1, -20);
                ZIndex = 1;
                Parent = BoxInner;
            });

            Library:Create('UIListLayout', {
                FillDirection = Enum.FillDirection.Vertical;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Parent = Container;
            });

            function Groupbox:Resize()
                local Size = 0;

                for _, Element in next, Groupbox.Container:GetChildren() do
                    if (not Element:IsA('UIListLayout')) and Element.Visible then
                        Size = Size + Element.Size.Y.Offset;
                    end;
                end;

                BoxOuter.Size = UDim2.new(1, 0, 0, 20 + Size + 2 + 2);
            end;

            Groupbox.Container = Container;
            setmetatable(Groupbox, BaseGroupbox);

            Groupbox:AddBlank(3);
            Groupbox:Resize();

            Tab.Groupboxes[Info.Name] = Groupbox;

            return Groupbox;
        end;

        function Tab:AddLeftGroupbox(Name)
            return Tab:AddGroupbox({ Side = 1; Name = Name; });
        end;

        function Tab:AddRightGroupbox(Name)
            return Tab:AddGroupbox({ Side = 2; Name = Name; });
        end;

        function Tab:AddTabbox(Info)
            local Tabbox = {
                Tabs = {};
            };

            local BoxOuter = Library:Create('Frame', {
                BackgroundTransparency = 1;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(55, 0, 0, 0);
                ZIndex = 2;
                Parent = Info.Side == 1 and LeftSide or RightSide;
            });

            Library:AddToRegistry(BoxOuter, {
                BackgroundTransparency = 1;
               -- BackgroundColor3 = 'BackgroundColor';
                BorderColor3 = 'OutlineColor';
            });

            local BoxInner = Library:Create('Frame', {
               BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Color3.new(0, 0, 0);
                -- BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, -2, 55, -2);
                Position = UDim2.new(0, 1, 0, 1);
                ZIndex = 4;
                Parent = BoxOuter;
            });
            table.insert(ui_utility.tab_trans,BoxInner)
        --    table.insert(ui_utility.resize, BoxInner)

            Library:AddToRegistry(BoxInner, {
                BackgroundTransparency = 1;
                BackgroundColor3 = 'BackgroundColor';
            });



            local TabboxButtons = Library:Create('Frame', {
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 0, 0, 1);
                Size = UDim2.new(1, 0, 0, 18);
                ZIndex = 5;
                Parent = BoxInner;
            });

            Library:Create('UIListLayout', {
                FillDirection = Enum.FillDirection.Horizontal;
                HorizontalAlignment = Enum.HorizontalAlignment.Left;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Parent = TabboxButtons;
            });

            function Tabbox:AddTab(Name)
                local Tab = {};

                local Button = Library:Create('Frame', {
                    BorderColor3 = Color3.new(0, 0, 0);
                    Size = UDim2.new(0.4, 0, 5, 0);
                    ZIndex = 6;
                    Parent = TabboxButtons;
                });

                Library:AddToRegistry(Button, {
                    BackgroundColor3 = 'MainColor';
                });

                local ButtonLabel = Library:CreateLabel({
                    Size = UDim2.new(1, 0, 1, 0);
                    TextSize = 14;
                    Text = Name;
                    TextXAlignment = Enum.TextXAlignment.Center;
                    ZIndex = 7;
                    Parent = Button;
                });

                local Block = Library:Create('Frame', {
                  --  BackgroundColor3 = Library.BackgroundColor;
                    BorderSizePixel = 0;
                    Position = UDim2.new(0, 0, 1, 0);
                    Size = UDim2.new(1, 0, 0, 1);
                    Visible = false;
                    ZIndex = 9;
                    Parent = Button;
                });

                Library:AddToRegistry(Block, {
                    BackgroundColor3 = 'BackgroundColor';
                });

                local Container = Library:Create('Frame', {
                    BackgroundTransparency = 1;
                    Position = UDim2.new(0, 4, 0, 20);
                    Size = UDim2.new(1, -4, 1, -50);
                    ZIndex = 1;
                    Visible = false;
                    Parent = BoxInner;
                });

                Library:Create('UIListLayout', {
                    FillDirection = Enum.FillDirection.Vertical;
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    Parent = Container;
                });

                function Tab:Show()
                    for _, Tab in next, Tabbox.Tabs do
                        Tab:Hide();
                    end;

                    Container.Visible = true;
                    Block.Visible = true;

                    Button.BackgroundColor3 = Library.BackgroundColor;
                    Library.RegistryMap[Button].Properties.BackgroundColor3 = 'BackgroundColor';

                    Tab:Resize();
                end;

                function Tab:Hide()
                    Container.Visible = false;
                    Block.Visible = false;

                    Button.BackgroundColor3 = Library.MainColor;
                    Library.RegistryMap[Button].Properties.BackgroundColor3 = 'MainColor';
                end;

                function Tab:Resize()
                    local TabCount = 0;

                    for _, Tab in next, Tabbox.Tabs do
                        TabCount = TabCount + 1;
                    end;

                    for _, Button in next, TabboxButtons:GetChildren() do
                        if not Button:IsA('UIListLayout') then
                            Button.Size = UDim2.new(1 / TabCount, 0, 1, 0);
                        end;
                    end;

                    if (not Container.Visible) then
                        return;
                    end;

                    local Size = 0;

                    for _, Element in next, Tab.Container:GetChildren() do
                        if (not Element:IsA('UIListLayout')) and Element.Visible then
                            Size = Size + Element.Size.Y.Offset;
                        end;
                    end;

                    BoxOuter.Size = UDim2.new(1, 0, 0, 20 + Size + 2 + 2);
                end;

                Button.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                        Tab:Show();
                        Tab:Resize();
                    end;
                end);

                Tab.Container = Container;
                Tabbox.Tabs[Name] = Tab;

                setmetatable(Tab, BaseGroupbox);

                Tab:AddBlank(3);
                Tab:Resize();

                -- Show first tab (number is 2 cus of the UIListLayout that also sits in that instance)
                if #TabboxButtons:GetChildren() == 2 then
                    Tab:Show();
                end;

                return Tab;
            end;

            Tab.Tabboxes[Info.Name or ''] = Tabbox;

            return Tabbox;
        end;

        function Tab:AddLeftTabbox(Name)
            return Tab:AddTabbox({ Name = Name, Side = 1; });
        end;

        function Tab:AddRightTabbox(Name)
            return Tab:AddTabbox({ Name = Name, Side = 2; });
        end;

        TabButton.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                Tab:ShowTab();
            end;
        end);

        -- This was the first tab added, so we show it by default.
        if #TabContainer:GetChildren() == 1 then
            Tab:ShowTab();
        end;

        Window.Tabs[Name] = Tab;
        return Tab;
    end;

    local ModalElement = Library:Create('TextButton', {
        BackgroundTransparency = 1;
        Size = UDim2.new(0, 0, 0, 0);
        Visible = true;
        Text = '';
        Modal = false;
        Parent = ScreenGui;
    });

    local TransparencyCache = {};
    local Toggled = false;
    local Fading = false;

    function Library:Toggle()
        if Fading then
            return;
        end;

        local FadeTime = Config.MenuFadeTime;
        Fading = true;
        Toggled = (not Toggled);
        ModalElement.Modal = Toggled;

        if Toggled then
            -- A bit scuffed, but if we're going from not toggled -> toggled we want to show the frame immediately so that the fade is visible.
            Outer.Visible = true;

            task.spawn(function()
                -- TODO: add cursor fade?
                local State = InputService.MouseIconEnabled;

                local Cursor = Drawing.new('Triangle');
                Cursor.Thickness = 1;
                Cursor.Filled = true;
                Cursor.Visible = true;

                local CursorOutline = Drawing.new('Triangle');
                CursorOutline.Thickness = 1;
                CursorOutline.Filled = false;
                CursorOutline.Color = Color3.new(0, 0, 0);
                CursorOutline.Visible = true;

                while Toggled and ScreenGui.Parent do
                    InputService.MouseIconEnabled = false;

                    local mPos = InputService:GetMouseLocation();

                    Cursor.Color = Library.AccentColor;

                    Cursor.PointA = Vector2.new(mPos.X, mPos.Y);
                    Cursor.PointB = Vector2.new(mPos.X + 16, mPos.Y + 6);
                    Cursor.PointC = Vector2.new(mPos.X + 6, mPos.Y + 16);

                    CursorOutline.PointA = Cursor.PointA;
                    CursorOutline.PointB = Cursor.PointB;
                    CursorOutline.PointC = Cursor.PointC;

                    RenderStepped:Wait();
                end;

                InputService.MouseIconEnabled = State;

                Cursor:Remove();
                CursorOutline:Remove();
            end);
        end;

        for _, Desc in next, Outer:GetDescendants() do
            local Properties = {};

            if Desc:IsA('ImageLabel') then
                table.insert(Properties, 'ImageTransparency');
                table.insert(Properties, 'BackgroundTransparency');
            elseif Desc:IsA('TextLabel') or Desc:IsA('TextBox') then
                table.insert(Properties, 'TextTransparency');
            elseif Desc:IsA('Frame') or Desc:IsA('ScrollingFrame') then
                table.insert(Properties, 'BackgroundTransparency');
            elseif Desc:IsA('UIStroke') then
                table.insert(Properties, 'Transparency');
            end;

            local Cache = TransparencyCache[Desc];

            if (not Cache) then
                Cache = {};
                TransparencyCache[Desc] = Cache;
            end;

            for _, Prop in next, Properties do
                if not Cache[Prop] then
                    Cache[Prop] = Desc[Prop];
                end;

                if Cache[Prop] == 1 then
                    continue;
                end;

                TweenService:Create(Desc, TweenInfo.new(FadeTime, Enum.EasingStyle.Linear), { [Prop] = Toggled and Cache[Prop] or 1 }):Play();
            end;
        end;

        task.wait(FadeTime);

        Outer.Visible = Toggled;

        Fading = false;
    end

    Library:GiveSignal(InputService.InputBegan:Connect(function(Input, Processed)
        if type(Library.ToggleKeybind) == 'table' and Library.ToggleKeybind.Type == 'KeyPicker' then
            if Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode.Name == Library.ToggleKeybind.Value then
                task.spawn(Library.Toggle)
            end
        elseif Input.KeyCode == Enum.KeyCode.RightControl or (Input.KeyCode == Enum.KeyCode.RightShift and (not Processed)) then
            task.spawn(Library.Toggle)
        end
    end))

    if Config.AutoShow then task.spawn(Library.Toggle) end

    Window.Holder = Outer;

    return Window;
end;

local function OnPlayerChange()
    local PlayerList = GetPlayersString();

    for _, Value in next, Options do
        if Value.Type == 'Dropdown' and Value.SpecialType == 'Player' then
            Value:SetValues(PlayerList);
        end;
    end;
end;

Players.PlayerAdded:Connect(OnPlayerChange);
Players.PlayerRemoving:Connect(OnPlayerChange);

getgenv().Library = Library



local Window = Library:CreateWindow({
    Title = 'russki ware pwned by office the legend $$$$$$',
    Center = true, 
    AutoShow = true,
})

for i,v in pairs(game.Players.LocalPlayer.PlayerGui.Animate:GetDescendants()) do -- cripwalk exploit no legs walk slide walk esploito
    if v:IsA('Animation') then 
        v.AnimationId = 69696969
    end 
end



--Variables [start

local RageTarget 
local players = game:GetService("Players") 
local localPlayer = players.LocalPlayer 
local Players = game:GetService("Players") 
local LocalPlayer = Players.LocalPlayer 
local Vec2 = Vector2.new
local frames_stuff = {}
local ragebot_target = nil
local ragebot_wallbang = false
local Vec3 = Vector3.new
local CF = CFrame.new
local INST = Instance.new
local COL3RGB = Color3.fromRGB
local FLOOR = math.floor
local RANDOM = math.random
local MIN = math.min
local LEN = string.len
local SUB = string.sub
local RAY = Ray.new
local INSERT = table.insert
local TBLFIND = table.find
local Client = getsenv(game.Players.LocalPlayer.PlayerGui.Client)
local camera = game:GetService("Workspace").CurrentCamera
local CurrentCamera = workspace.CurrentCamera
local worldToViewportPoint = CurrentCamera.worldToViewportPoint
local mouse = game.Players.LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local UserInput = game:GetService("UserInputService")
local fps
local killls
local health
local speed
local localPlayer = game.Players.LocalPlayer
local client = getsenv(localPlayer.PlayerGui.Client)
client.splatterBlood = function() end
local Players = game:service'Players'
local score
local runService = game:service'RunService'
local UserInputService = game:GetService('UserInputService')
local camera = workspace.CurrentCamera
local ClientScript = localPlayer.PlayerGui.Client
local ag = {
		["Head"] = 4,
		["FakeHead"] = 4,
		["HeadHB"] = 4,
		["UpperTorso"] = 1,
		["LowerTorso"] = 1.25,
		["LeftUpperArm"] = 1,
		["LeftLowerArm"] = 1,
		["LeftHand"] = 1,
		["RightUpperArm"] = 1,
		["RightLowerArm"] = 1,
		["RightHand"] = 1,
		["LeftUpperLeg"] = 0.75,
		["LeftLowerLeg"] = 0.75,
		["LeftFoot"] = 0.75,
		["RightUpperLeg"] = 0.75,
		["RightLowerLeg"] = 0.75,
		["RightFoot"] = 0.75
	}

-- оуда я наконец то сделал килл сеи в одну строчку чтобы долго не листать (стикс радуется)
local killsey={"😏made by nixus and xosmane🙄","'mhm stOp PaStiNg StOrmY😡' - J.","xosmane one love😂","😪loving wall",'"у вас скрипт не стреляет, идиоты🤣" - никсус',"pups🤗","ᓚᘏᗢbbot on top","flopawawr(^///^)","moded penಠ_ಠ","1 🥳fps media","roblox hvh😨",'"да ьука хуьисосина ты еьбаньая" - банан','"КОГО ТЫ БЬЛ@ТЬ П@З@ДАНУЛ" - банан','"😎бектрек кривой огузки" - поап','"😚их дядя путин на хвх еьбьать будет" - поап','"молодост🤩ь ь@ять была ахьуеная" - поап','"вот раньше на фейкдаках леон как пиьдарас сидел🪑" - поап','"ты чо не здох💀" - поап','"газпром одобряет🌌" - поап','"ВОТ ТЫ ПьИздьабол ь@ять" - поап','"сосать!" - поап🆘','"бананньегр" - поап','"слоник🥺" - поап','"я ем детей.. 🤡жареными" - лио','"пьизда tebe шлю(☞ﾟヮﾟ)☞а ты еьбьаная" - поап','"пьизьдаблятина" - поап🖤','"щя еьбьать будем" - поап🎧',"🏪я куплю шторми и буду садить леона на кнайф - банан","🌍🌎🌏вот если бы небыло инвадеда и шиппи мы бы уже на другой планете были бы - банан😆","весел😂о","linoria sucks💹","boredddddddddddddddddddddddddddd😪","😏","1'd😭","Ahhh~😍","vru","pep🎞si on top","🧨plug and play or die and pay","Hexago(┬┬﹏┬┬) de carlo","ta🎃ppino","el tappo","papini d😼chki","mamkina mogila tebya shdet💩","pastim pastim🍕","s koreshami v voice➿","stixica j tapnet - banan🧈","just say others im russian🎒","pen fr fr🔏","он ПЕРЕСТАЛ стрелять - никсус👌🏿","бысьрей пленти🛐 пока он не сломал тебе айпи адрес","устал пастить🍝","бед америка | гуд раша🏈","You were 🦵kicked from this experience: Noclipping","👤seere user","🧔🏿beanbot paste fr fr","get real emo📖","i love ©🅿","emo boyyy👨‍👩‍👧‍👦","fr 11️⃣","ccccccccccccccccccccccccccccccccc📸","PON🐎","ME🐎GA PON","NE PON🚫🈵🚫","MEG🐎A NE PON","ULTRA PON🐎","ULTRA NE PON🐎","🈵havai🈵 ","fqfqfqegarehaerghweg🈵🈵🈵🈵🈵🈵","[ruskiware (cracked by office - legend)] - succesfully tapped!👏🏿","❔❓⁉❔❓stix che za pi3da❔❓⁉❔❓"}local nixus={"p100","hitting big p","ez kills","ez wins","1","1'd","u mad??","nn dead","who.ru","UID issue","IQ issue","are you gonna inject??","mad?","did you even execute??","gimmie ur watermelons","a rat with a hdmi port is typing this","It looks like your face caught on fire and someone tried to put it out with a fork.","Don't you love nature, despite what it did to you?","Well, that happend.","OOF","Ouchies.","u mad?","Practice makes perfect.","Did you mean to do that?","Don't do that again.","Bada ba ba ba, I'm lovin' it.","How'd that happen?","SÊ‡od Ê‡Êá´‰sÊ‡á´‰uÆƒ ÊŽonÉ¹ É¥ÇÉpË™","Well, that happend.","yeah ok","Tip : stop made this","Tip : This button doesn't relieve rage, for some reason.","Tip : Don't be rage.","Mada mada.","VCMYXC1RiQVoUHWoKPSROQ==","Hack the game","Error 404 : Rage quit not found.","Sweet rage bro!!","Whos that behind you?","Oh, So close!","Nope.","Undo!","Is that a jojo reference?","AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHH...","Stop screwing around!","useless button rite","?????","That wasn't the plan.","???????????","nice one","whats 4 squared?","you can get everything you want","Don't lose your head.","Stimulate your senses.","Don't clip that.","Kappa.","O Wuts dis?","Try again.","Game over!","Why?","Stop rage quitting","Are you angry yet?","I've got 99 problems, This cheat aint one","Huh? What happend?","Where'd you go?","Don't be rage again.","Did you rage quit again?","Fuck off, fuck off...","Hello, depression","I hear your message","Still don't understand","I know we're hurting","Drugging and doping","Death by our own hands","I'm sorry that I couldn't be the one","The end has come","Hello, my mental","You think I should but","I can't read your mind","Admit we fuck up","Our wounds are healing","Some can't heal with time","Cause we can't run","ur my fan","you cried trying to report me","u has no parents Imaoo","are u having a bad time?","u lost to C0VVID","negro","so trash OMEGALUL","random","i know ur location LOL","LLLLLLLLL","clipped","emo lokin stupid 12yo","u trying to be me so hard","you waant to sjjck my djcick","clip me clipping owning u","ur black","stay mad","You're adopted kid","kill pyourself","special kid","get ratio'ed","i can buy ur life","Ð”ÐµÑ€Ð¶Ð¸ âœˆ Ð¸ Ð»ÐµÑ‚Ð¸ Ð½Ð°Ñ…ÑƒÐ¹ !","Hexagon is the best!","missed shot due to umm i forgor","[gamesense] Missed shot due to ?","game:Shutdown()","pls give me hexadecimal","-ur life","owl hub'ed","LOL 9 Y.O. KID WITH FREE HACKS!11111","get resolver nn boy????????????????????????????????????????????????????","???????????????????????? stop pasting meme????????????????????????????????????????","????????????????  dumpware wining ?????????????????????????????","??????????????????????  whu.ru? whu.ru? whu.ru? whu.ru? whu.ru? whu.ru? ????????????????????????","p1000????????????????????????????????????","????????????????????cuteware really p100 cuteware really p100 cuteware really p100 cuteware really p100????????????????","sit nn dog????????????????????","???????????? can i rec media ???????????????? stop use mega tap rage????????????????","LEON X FEEL =????????????????????????????????????","????????????????????????  stix bad stix bad stix bad stix bad stix bad??????????????????????????????"}local xosmane={"ne95gr2: Я СЕБЕ ШТАНЫ НАМОЧИЛ","XxMonster130xX: ТЫ МЕШАЕШЬ НОРМАЛЬНЫМ ЧЕЛАМ ЖИТЬ","ne95gr2: У НЕГО ЕЩЁ СПИДРАН ВКЛЮЧЁН КИК ЕГО УЖЕ","RASADATOR: аим+навотка",'пхITLER SISTERO??!??!?!&$&"&-;@;@','"у меня не стреляет😭😭" - хосмане','"э кудаа леон на гуро аьа💹ьаьаь" - бананнегр',"moto moto 1120","gameshark.dev","HEY WHATS SCRIPT IS THAT??","ruskiware (cracked by office - legend)","russia on top yessssss","how are you","gameshark.dev join","ахаха лысый поспи","1 бу рашнвар","ты кстати мне co|сешь ща","никсус ван лав❤️",'"хасманя лысый гном" - никсус',"овнед бу рашнвар","SORRY I HURT YOUR ROBLOX EGO BUT LOOK -> 🤏 I DONT CARE","Free Roblox Script Silent Aim Rapid Fire God Mode","Artiljerija! Bosanac sam bekrija.","😴😴😴😴😴😴😴😴😴😴😴😴😴😴😴😴😴😴😴😴😴😴😴😴😴😴😴😴😴😴😴😴😴😴","😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎",'"на на получай черный" - хосмане',"рашнвар беттер!","донт сри май бебе герл","shootware'd","ay look at me","try kick me",'"ВАТАФЬАК АР Ю ДУИНГ😡" - хосмане',"look12space: KICK NEFOR",'"а сам та наьхьуй ебьантяй😏" - банан','"Я тебя агрить буду когда стоять крутить⛳ тебя на вертеле и ржать🤣" - стикс','"Ты меня заеьбпл,🙁" - никсус','"я тебя понял😥" - хосмане','"Da, vse, nahйui vash cb, ya livaem v undertale" - никсус','"ты чо суьчка сам ты петух😡😡" - никсус',"ruskiware (cracked by office - legend)","nachos.codes","m+9 kick hacker","kick him he hacking","stop hacking noob","imagine hacking in roblox","ruskiware (cracked by office - legend) on top","$$$ nachos.codes $$$","1'ed","stop hacking!!!","m+9 kick","$$$$$$$$$$$","ruskiware (cracked by office - legend) was here","oopsie","missclick'ed","how to buy gun","stop hacking!! its against the rules!!","bro cheating to be good","you dont mom","stop this please","поколение пауков моя тима вся в ryodan'e🕷","🔥обожаю playboi carti😎😎✌ и все что с ним связано💓💓","бойцовский клуб редан, задыхаешься цепями⛓","Порву-За-Братву","🥦 Vegan living healthy","Горжусь Z 🥰🇷🇺","ты думаешь что ты шаришь?🤣🤣🤣🤣🤣🤣 ахаха.","Доброе времени суток ! Идёт набор в клан standoff 2 Anime Win Team ","доброе время суток идет набор в клан по игре коунтер блокс","Роблокс игра сиреноголовий💓","комфортный чатик для тебя по роблоксу","Господи, как же хочется украиночку... ","👏👏👍👍👍👍КЛАСС!!!!!😁😁😁","На вечер для вас эта потрясная красотка с клевыми формами 😻","💥💥💥Любители по фигачить клубами пара☁️","Мяу! Я милая кошкодевочка. У меня пушистое меховое пальто насыщенного цвета.","🤯Видео нe для слабонервных!","а здесь дают робуксы?","прицел пропал, как включит?","Стримснайпят  Лагает ✅  Вебка пересвечивает ✅  Начали за T ✅  Не повезло ✅  0 помощи  -98хп ✅  Достал нож не в тайминг ✅  Неудобно сидеть ✅ ","um guys, how do i play this game","which button is it to shoot now","please go easy on me guys, im new to this","if u do not go easy on me, i will report u","M9 bayonet cool knife donater 2000 ultra super","петух доллар доллар петух","п-папочка, я твой котёнок 🥺","пошли в войс чудо в перьях","ROBLOX COUNTER STRIKE GLOBALO BLOX NEW 2024","Ддос - бан навсегда без разбора 💻🚫","Me: A bad and manipulative anime boy who can and will control you","униженный инвалид ты мне в ширинку дышишь","нюхай пэнсел,баклан","не снимай подгузник, просто отодвинь его в сторону","промолчишь?","прилоскал косматого ~(˘▾˘~)","ботик, ты про ruskiware (cracked by office - legend) слыхал чето?","What? ruskiware (cracked by office - legend)? No Im using stormy-fixed","senpai~~~, заовни меня ^^","You Has been RAC Banned","hitpart bans me😣","очередной легитный еьблак","buy ruskiware (cracked by office - legend)","ты сочный за тебя в чат чит пишет","ДА НЕ ПИКАЙ СИДИ НА МЕСТЕ"}local csgo={"что ты сделал","?","найс мув","пьиьздец ты конч","найс подловил","без дт не может","просто +в","на подпике","еле убил","почти хорошо","оправдай мув","ну","gbpltw",",kznm","тупой","МЕНЯ ТПХНУЛО","я стрельнул?","яя в муте?","ну тиммейт федука давит","кердык","что за вонь убила","ты дт отжал?","у меня одново серв лаг?","найс автопик+миндмг","бекшут?","ты с соткой встал?","ну ты зверь","сидит предиктит","онли боди чьурка","не потей","ты с миндамагом пикнул?","у тебя пинк спайк?","как ты дамаг выбил?","ну фристендинг же не сработает","чит делеит","ну нет","сразу видно iq 14к юида","S[DF[F[DF[SDF[SD[FSD[FDS[F[F[F[F","1 dog","1","я сплю","никсвар топ","ребятки sleepcord на никс качаем, топ луашка!","фуууу ботек ИЗИЧКА фууууу","я поспал и хс'аю тебя","не плачь","neverlose user fell to nix|ware with sl|eepcord","что то ты падаешь много","в консоли miss, а в голове пусто","униженный инвалид ты мне в ширинку дышишь"}local china={"武器 esp aimbot 的最佳腳本","損壞修改器崩潰服務器後門專業版roll angle 免費作弊未付費","新的最佳付費腳本破解繞過方法速度","利用飛行模式上帝模式眼鏡未檢測到的軟件","大頭不付費教程 100% 私人 xp hack","工作程序 hack bunny hop 免費不付費 哈哈","hitbox extender源垃圾郵件聊天惡意軟件","武器免費黑客瞄準船和牆壁黑客無限彈藥上帝模式","作弊 ai 模式支付最佳腳本開發者 hack","釋放拖釣作弊瞄準機器人無聲破解無限跳躍","免費作弊利用武器 roblox 遊戲 xray 無剪輯","神速作弊武器 ro blocks 所有槍支解鎖器","bunny hop cheat破解2023方法免費源碼","史萊姆城堡破壞者免費欺騙破解 minecraft 破解","免費作弊模式銅色類別創意破解繞過esp","誰騙你玩不了哈哈喵喵破解版","停止作弊哈哈我是合法的職業球瞄準船牆黑客","免費破解我的專業作弊 aimbot wallhack 不付費變壞","大頭預測漏洞利用方法免費繞過破解","你是怎麼得到這個的請回答 fake lag","印度尼西亞使用 hacking 免費作弊 ","兔子跳自動牆技巧 lifehack 禁令繞過","免費手榴彈繞過作弊工作 roblox aimbot 瞄準無聲目標繞過 2023 工作真正免費下載和使用","你好青蟲我討厭你傻媽媽傻媽媽青蟲","抱著毀滅性的神經沉重的繁榮遊行臉紅青銅類創意案例","此服務器上的開發者請幫助我免費且非常易於使用的手榴彈 2023 繞過","去觸摸草地哈哈遊戲椅哈哈太有趣了我瘋了我笑得太厲害了","踢他請按F1兄弟為什麼你不踢他哈哈去觸摸黑客","垃圾郵件這麼難容易破解免費粘貼 bin 繞過","水晶創意玻璃頭眼睛喵喵貓狗鸚鵡手隨機文字芝士漢堡怎麼做","破解菜單解鎖所有槍支付費方法無限彈藥","擁有最好的作弊容易哭更多沒有名字哈哈","因黑客攻擊而被禁止武器開發者哭得很厲害","讓生活更輕鬆的生活小竅門只需洗碗便便便可獲利","隨機文本是的為什麼你讀這個我是中國人我發誓我沒有使用翻譯器","被最好的騙子控制大聲笑哭我的朋友擁有踢被撞毀","俄羅斯穿頂盤灰色塊兩塊立體聲揚聲器你好隨機文本"}local random={"cheat code hvh anti aim legit hack trickshot maker","no virus mediafire link exploit hitting p debug menu","teleport not paid hack meme all clean","server backdoor cookie logger chams aim bot","big head rapid fire cheat op verified","hitbox extender source spam chat malware","cheat crack tp hack method free esp","no ban bypass download desync not leaked","kill all hacks no leaked silent aim hacks","fly mode script gun hack no clip tutorial","esp no anti-cheat detect for free no linkvertise","exploit hack free damage modifier free btools","undetected full 100% free private hack unlimited wallbang","cb free hack aim boat and wall hack infinite ammo god mode","roblox mod menu with hack super jump fly","god speed cheat cbro roblox all gun unlocker","software free sniper gun hack trolling owns all program","free cheat exploit cb roblox games xray no clip","working program hack esp chams bunny hop xp hack","cheating ai mode paid best script developers hack","bypass anti-cheat fire rate speed cheat","infinite damage for free encrypted cracked roblox","release trolling cheat aim bot silent crack infinite jump","speed cheat troll pause game cb desync","big head not paid tutorial 100% private xp hack"}local facts={"Несмотря на все свое население, в китае используется всего около 200 фамилий.","Существует растение, которое называют цветком смеха. Оно вызывает беспричинный смех на полчаса.","Люди с голубыми глазами лучше видят в темноте.","Среднестатистическая женщина за свою жизнь успевает посидеть на 32 диетах.","Самый старый обнаруженный рецепт супа датируется 6000 годом до нашей эры. Главный ингредиент — мясо бегемота.","Жирафы в целях самозащиты действуют головой как молотком.","В Швейцарии выпустили детские презервативы.","Чихание при взгляде на солнце — это аутосомно-доминантный непроизвольный гелио-глазной синдром взрыва.","Потребление йогурта в мире возросло за последние 12 лет в четыре раза.","На территории Японии 17 действующих вулканов.","В Саудовской Аравии нет ни одной реки.","Как минимум три часа в день мы бездельничаем.","В большинстве реклам время показываемое на часах – 10:10, чтобы не закрывать марку часов.","Имя шейха Хамада написано на Земле километровыми буквами и видно из космоса.","В Албании кивание головой значит «нет», и наоборот.","В Алабаме запрещено водить машину необутым. Закон, однако, позволяет ездить по встречной полосе, если включить фары.","Комары могут летать во время дождя.","У человека меньше мyскyлов, чем y гyсеницы.","Браки, в которых жены плохо спят, имеют гораздо больше шансов развалиться.","При сильной рвоте у человека могут лопнуть сосуды в глазах.","За пол века овощи стали менее полезны.","Япония — последняя страна в мире, формально сохранившая титул Империи.","Бильярд, так же как и шахматы, имеет очень древнее происхождение, а его родиной является Азия.","В Антарктиде банкоматов в 2 раза больше, чем постоянных жителей.","Пизанская башня никогда не была прямой!","Полярная крачка — единственная птица, которая мигрирует с одного полюса на другой.","Самые большие в мире сластены - немцы и швeйцарцы: Cогласно статистике, в год каждый из них съедает по 10-11 кг шоколада.","Каждый американец имеет, в среднем, 7 пар джинсов.","Самая распространенная скальная порода на земле — это базальт.","ДНК человека и банана совпадают на 50%.","При ярком свете человек съедает намного меньше, чем с приглушённым тусклым освещением.","Горькие напитки делают людей критичнее и строже.","Гречка очищает желудок от жвачек.","Лечебные свойства зелёного чая — это миф","Лингвисты утверждают, что в любом языке есть слово, обозначающее подхалима.","Длина самого длинного лимузина в мире — 30,5 метров","На холоде насекомые дрожат, как и человек.","Змея может спать в течение 3 лет.","На Гавайях серфинг включен в школьную программу.","В Швейцарии запрещено смывать воду в туалете после 10 часов вечера.","Стрекозы в буквальном смысле до смерти боятся рыб.","Женские сердца бьются быстрее, чем у мужчин.","Три силовых занятия в неделю дают наибольший эффект.","Каучук – один из ингредиентов жевательной резинки. Благодаря ему мы можем надувать пузыри.","Аисты могут засыпать в полете на 10-15 минут.","По статистике 66% людей закрывают глаза во время поцелуя.","Виадук Мийо - самый высокий мост в мире!","В центре Мадрида есть отель из мусора.","Пчелы никогда не спят. Пчела замирает на соте лишь на несколько секунд в течение суток.","Пожилых людей больше всего в Швеции (24%) и меньше всего в Кувейте (2%).","Булемия - это неукротимый аппетит.","Лысых людей не выгоняют из церкви, потому что гонять лысого - грех.","Чаще всего, самые тихие люди - немые.","Если долго смотреть на огонь, то тебя уволят из МЧС.","Не покупай вентиляторы - это деньги на ветер.","Девушки как кредит, кому-то дают, а кому-то нет.","Что не так с рестораном на Луне? Блюда изысканные, но нет атмосферы.","Горчицу знаешь? Я огорчил.","Когда говоришь, что думаешь , думай что говоришь.","Проблем по жизни будет много, но выбор за нами. Либо ныть, либо попу мыть.","Каждый может кинуть камень в волка , но не каждый может кинуть волка в камень."}
local bbot={"Someone hacked my computer and now it's playing the game for me please help 😭😭😭","OMG OMG OMG SOMEONE VOTEKICK HIMMMM PLLEASE 😂😂😂","Roblox: Empowering innovation through children 👶👶👶","Get a Knife in 2 hours 😱😎😱 gameshark.dev","JOIN HERE TO GET 2000 ROBUX 😱😎😱 gameshark.dev","FREE BROBUX GENERATOR 2023 LATEST NO BAN 😱😎😱 gameshark.dev","Every CB player ever OMG KICK HIM ALREADY WHY ARE YOU TAKING SO LONG 😂😂😂","Oh no are you gonna report me? I am so scared *trying real hard to care rn* 🤦‍♂️🤦‍♀️","   ","Oh no what will I ever do, he's going to report me omg, welp might as well pack my bags 💼🏃‍♂️✈","Meanwhile at the roblox corperation: *snoozing at the desk* 😴🛌🛌","Meanwhile at the roblox corperation: I'm just not gonna take this player's report omega lul 😂","I don't see any hackers you big ape bafoon, ooh ooh ahh ahh 🐒🐒🐒, YOUR A MONKIE","Go ahead and kick me I will just join back off of the thousands of accounts I got 🤣🤣🤣","Join for free kerambit knife 😱😎😱 gameshark.dev","the XP Hack Verified God Mode 弗吉艾尺艾杰开 pro method","I Found the *BEST* Script for CB:RO 😱😎😱 gameshark.dev"}
local serega={"Ведь я талант, ведь я талант, я талант","И я кричу, остановите катку","Лови мут на прощание","Моё тп отменено","Я отменил тп, я отменил тп","Но я не слышу, ведь я крутой","Я на бите, да вам лучше сдаться, я-у","Вам лучше помочь мне, вам лучше помочь мне","Чисто информация — надо пытаться","Вспомни телепорт, загляни под стол","Зацени билд, да, мой билд жёсткий","У меня ВИЧ, мне нужен witch doctor","Эй, это Серёга Бандит, 2-0-1","Я влетаю во врага, на меня летят скиллы","Хард дегенрат, всю катэлу афк","Да я сам для себя сейв, мне сапорты не нужны","Мой сларк, засолит вам катку (Катку, катку)","Я бы хотел, что бы меня называли все талант","Я в замесе жму скиллы, как пулемёт","У врагов тильт по-по-посгорали пердки","Я прикупил огромный байк","Снова сранй федерал, па-па-па, по нём попал","Я влюбился в азарт, если жму по газам","Люди смотрят на меня, все хотят такой же байк","(Ху-у-у) Я не боюсь ошибаться, я делаю, что хочу","Цирком езжу, как трубодур","Сквозь пальцы смотрю на грязь, и мой ритм жизни как казино","Давай, пиши свою чушь, ведь я люблю посмеяться (Ха-ха-ха-ха-ха-ха)","Выкупаю все акции, спасибо за овации"}



local oldSkybox
 
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local ts = game:GetService("TweenService")
local plrs = game:GetService("Players")
local cas = game:GetService("ContextActionService")
local stats = game:GetService("Stats")
local utility = {}
local lplr = game.Players.LocalPlayer
local othershit = Instance.new("Folder", workspace)
local ftfolder = Instance.new("Folder", workspace)
local btfolder = Instance.new("Folder", workspace)

local library = {
    connections = {},
    drawings = {},
    hidden = {},
    pointers = {},
    flags = {},
    preloaded_images = {},
    loaded = false
}

-- Variables end]

-- Functions start[
local function IsAlive(player)
    if player and player.Character and player.Character.FindFirstChild(player.Character, "Humanoid") and player.Character.Humanoid.Health > 0 then
        return true
    end

    return false -- hallo nigger
end
-- // utility
local utility = {}

   properties = properties or {}

    function utility:RoundVector(vector)
        return Vector2.new(math.floor(vector.X), math.floor(vector.Y))
    end
    function utility:Connect(connection, func)
        local con = connection:Connect(func)
        table.insert(library.connections, con)
        return con
    end

    function utility:BindToRenderStep(name, priority, func)
        local fake_connection = {}

        function fake_connection:Disconnect()
            rs:UnbindFromRenderStep(name)
        end

        rs:BindToRenderStep(name, priority, func)

        return fake_connection
    end

    function utility:Combine(t1, t2)
        local t3 = {}
        for i, v in pairs(t1) do
            table.insert(t3, v)
        end
        for i, v in pairs(t2) do
            table.insert(t3, v)
        end
        return t3
    end


    function utility:RemoveItem(tbl, item)
        local newtbl = {}
        for i, v in pairs(tbl) do
            if v ~= item then
                table.insert(newtbl, v)
            end
        end
        return newtbl
    end

local function CreateThread(func, ...) -- pasted from bbot fr
    local thread = coroutine.create(func)
    coroutine.resume(thread, ...)
    return thread
end

local function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end
function scan(ins)
    return {
        ins.Position + (Vector3.new(ins.Size.X, 0, 0) / 2),
        ins.Position - (Vector3.new(ins.Size.X, 0, 0) / 2),
        ins.Position + (Vector3.new(0, ins.Size.Y, 0) / 2),
        ins.Position - (Vector3.new(0, ins.Size.Y, 0) / 2),
        ins.Position + (Vector3.new(0, 0, ins.Size.Z) / 2),
        ins.Position - (Vector3.new(0, 0, ins.Size.Z) / 2),
        ins.Position,
    }
end

function scan_advanced(ins)
    return {
        ins.Position + (Vector3.new(ins.Size.X, 0, 0) / 2),
        ins.Position - (Vector3.new(ins.Size.X, 0, 0) / 2),
        ins.Position + (Vector3.new(0, ins.Size.Y, 0) / 2),
        ins.Position - (Vector3.new(0, ins.Size.Y, 0) / 2),
        ins.Position + (Vector3.new(0, 0, ins.Size.Z) / 2),
        ins.Position - (Vector3.new(0, 0, ins.Size.Z) / 2),
        ins.Position + (Vector3.new(ins.Size.X, ins.Size.Y, 0) / 2),
        ins.Position - (Vector3.new(ins.Size.X, ins.Size.Y, 0) / 2),
        ins.Position + (Vector3.new(0, ins.Size.Y, ins.Size.Z) / 2),
        ins.Position - (Vector3.new(0, ins.Size.Y, ins.Size.Z) / 2),
        ins.Position + (Vector3.new(ins.Size.X, 0, ins.Size.Z) / 2),
        ins.Position - (Vector3.new(ins.Size.X, 0, ins.Size.Z) / 2),
        ins.Position + (Vector3.new(-ins.Size.X, ins.Size.Y, 0) / 2),
        ins.Position + (Vector3.new(ins.Size.X, -ins.Size.Y, 0) / 2),
        ins.Position + (Vector3.new(0, -ins.Size.Y, ins.Size.Z) / 2),
        ins.Position + (Vector3.new(0, ins.Size.Y, -ins.Size.Z) / 2),
        ins.Position + (Vector3.new(-ins.Size.X, 0, ins.Size.Z) / 2),
        ins.Position + (Vector3.new(ins.Size.X, 0, -ins.Size.Z) / 2),
        ins.Position + (Vector3.new(-ins.Size.X, ins.Size.Y, ins.Size.Z) / 2),
        ins.Position + (Vector3.new(ins.Size.X, -ins.Size.Y, ins.Size.Z) / 2),
        ins.Position + (Vector3.new(ins.Size.X, ins.Size.Y, -ins.Size.Z) / 2),
        ins.Position + (Vector3.new(-ins.Size.X, -ins.Size.Y, ins.Size.Z) / 2),
        ins.Position + (Vector3.new(ins.Size.X, -ins.Size.Y, -ins.Size.Z) / 2),
        ins.Position + (Vector3.new(-ins.Size.X, ins.Size.Y, -ins.Size.Z) / 2),
        ins.Position + (ins.Size / 2),
        ins.Position - (ins.Size / 2),
        ins.Position,
    }
end

function getDamageMultiplier(p)
    return p.Name:find("Head") and 4 or (p.Name:find("Leg") or p.Name:find("Foot")) and 0.75 or (p.Name:find("Arm") or p.Name:find("Hand") or p.Name == "LowerTorso") and 1 or p.Name == "UpperTorso" and 1.25 or p.Parent == ftfolder and 4 or p.Parent == btfolder and 4 or p.Parent == othershit and 4 or 0
end

function GetPlayerNames()
    local a = plrs:GetPlayers()
    for i, v in pairs(a) do
        a[i] = tostring(v)
    end
    return a
end

function RandomNumberRange(a)
    return math.random(-a, a)
    
end

function RandomVectorRange(a, b, c)
    return Vector3.new(RandomNumberRange(a), RandomNumberRange(b), RandomNumberRange(c))
end

function isAlive(player)
    if player ~= nil and player.Parent == game.Players and player.Character ~= nil then
        if player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") ~= nil and player.Character.Humanoid.Health > 0 and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("UpperTorso") and player.Character:FindFirstChild("LowerTorso") then
            return true
        end
    end
    return false
end
function indexListing(a)
    local b = {}
    for i, v in pairs(a) do
        table.insert(b, i)
    end
    return b
end

function isTarget(plr, teammates)
    if IsAlive(plr) then
        if not plr.Neutral and not localPlayer.Neutral then
            if teammates == false then
                return plr.Team ~= localPlayer.Team
            elseif teammates == true then
                return plr ~= localPlayer
            end
        else
            return plr ~= localPlayer
        end
    end
end-- pasted fr
-- Functions end]

-- Library functions [start
runService.RenderStepped:Connect(function(step)
    if Library.Watermark.Visible == true then
        fps = math.round(1 / step)
        killls = game.Players.LocalPlayer.Status.Kills.Value
        local kdr = round((killls / game.Players.LocalPlayer.Status.Deaths.Value), 2)
        if IsAlive(localPlayer) then
            health = math.round(game.Players.LocalPlayer.Character.Humanoid.Health)
            speed = math.floor(math.clamp((localPlayer.Character.HumanoidRootPart.Velocity * Vector3.new(1,0,1)).magnitude,0,400))  
            Library:SetWatermark('ruskiware (cracked by office - legend) | fps: ' .. fps .. ' | health: ' .. health .. " | kills: " .. killls .. " | speed: " .. speed .. ' | kd/r:' .. kdr)
        else
            Library:SetWatermark('ruskiware (cracked by office - legend) | fps: ' .. fps .. ' | kills: ' .. killls .. ' | kd/r:' .. kdr) -- if died
        end
    end
end)

Library:OnUnload(function()
    print('Unloaded!')
    Library.Unloaded = true
end)



local skyboxes = {
    ["-"] = {},
	["Galaxy"] = {
		SkyboxBk = "rbxassetid://159454299",
		SkyboxDn = "rbxassetid://159454296",
		SkyboxFt = "rbxassetid://159454293",
		SkyboxLf = "rbxassetid://159454286",
		SkyboxRt = "rbxassetid://159454300",
		SkyboxUp = "rbxassetid://159454288",
	},
	["Purple"] = {
		SkyboxBk = "rbxassetid://570557514",
		SkyboxDn = "rbxassetid://570557775",
		SkyboxFt = "rbxassetid://570557559",
		SkyboxLf = "rbxassetid://570557620",
		SkyboxRt = "rbxassetid://570557672",
		SkyboxUp = "rbxassetid://570557727",
	},
	["chroma"] = {
		SkyboxBk = "rbxassetid://501633538",
		SkyboxDn = "rbxassetid://501633538",
		SkyboxFt = "rbxassetid://501633538",
		SkyboxLf = "rbxassetid://501633538",
		SkyboxRt = "rbxassetid://501633538",
		SkyboxUp = "rbxassetid://501633538",
	},
	
	["Purple Night"] = {
		SkyboxBk = "rbxassetid://296908715",
		SkyboxDn = "rbxassetid://296908724",
		SkyboxFt = "rbxassetid://296908740",
		SkyboxLf = "rbxassetid://296908755",
		SkyboxRt = "rbxassetid://296908764",
		SkyboxUp = "rbxassetid://296908769",
	}
}


local Tabs = {
    Rage = Window:AddTab('Aimbot'),  
    Visual = Window:AddTab('Visual'),
    Misc = Window:AddTab('Miscellaneous'),
    ['Settings'] = Window:AddTab('Settings'),
}
local Tabboxes = {
    RageTabbox = Tabs.Rage:AddLeftTabbox(),
    AATabbox = Tabs.Rage:AddRightTabbox(), -- hm?>
    MiscTabbox = Tabs.Misc:AddLeftTabbox(),
    MiscTabbox1 = Tabs.Misc:AddRightTabbox(),
    VisualTabbox = Tabs.Visual:AddLeftTabbox(),

    VisualTabbox2 = Tabs.Visual:AddRightTabbox(),
}

local Sections = {
    Rage = Tabboxes.RageTabbox:AddTab('Aim'),
    bulshit = Tabboxes.RageTabbox:AddTab('Bullet'),
    fwt = Tabboxes.RageTabbox:AddTab('Fwt'),
    backtr = Tabboxes.RageTabbox:AddTab('Backtrack'),

    Movement = Tabboxes.MiscTabbox:AddTab('Movement'),
    Tweaks = Tabboxes.MiscTabbox:AddTab('Tweaks'),
    Client = Tabboxes.MiscTabbox1:AddTab('Extra'),
    Chat = Tabboxes.MiscTabbox1:AddTab('Chat'),


    Players = Tabboxes.VisualTabbox:AddTab('Players'),
    Settings = Tabboxes.VisualTabbox:AddTab('Settings'),

    World = Tabboxes.VisualTabbox2:AddTab('World'),

    Local = Tabboxes.VisualTabbox2:AddTab('Local'),


    Other = Tabboxes.VisualTabbox2:AddTab('Other'),

    Modifers = Tabboxes.MiscTabbox:AddTab('Modifers'),
    Desyncsec = Tabboxes.AATabbox:AddTab('Desync'),
    Safetysec = Tabboxes.MiscTabbox1:AddTab('Safety')

}
local MenuGroup = Tabs['Settings']:AddRightGroupbox('Menu')

local LeftMenuGroup = Tabs['Settings']:AddLeftGroupbox('Developers')

MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddButton('Stats', function() -- статс фром боуи да 
local startpos = Vector2.new(20, 400)

local values = {}

local lines = {}

local drawings = {}
local cloned = {}

local rs = game:GetService("RunService")
local last_updates = {tick(), 0}

local bold = false

function newLine(props)
    local o = Drawing.new("Line")

    table.insert(lines, o)

    for i, v in pairs(props or {}) do
        o[i] = v
    end

    return o
end

function newDrawing(class, props)
    local o = Drawing.new(class)

    for i, v in pairs(props or {}) do
        o[i] = v
    end

    drawings[o] = {class, props or {}}

    return o
end

function cloneDrawing(object)
    if drawings[object] then
        local obj = Drawing.new(drawings[object][1])

        for i, v in pairs(drawings[object][2]) do
            obj[i] = v
        end

        cloned[obj] = drawings[object]

        return obj
    end
end

local size = 130
local max_val = 1000

local box_1 = newDrawing("Square", {
    Position = startpos,
    Size = Vector2.new(1, size + 6),
    Color = Color3.new(1, 1, 1),
    Thickness = 1,
    Filled = false,
    Visible = true
})

local box_2 = newDrawing("Square", {
    Position = startpos + Vector2.new(0, size + 4),
    Size = Vector2.new(0, 1),
    Color = Color3.new(1, 1, 1),
    Thickness = 1,
    Filled = false,
    Visible = true
})

local avgl = newDrawing("Line", {
    Thickness = 2,
    Color = Color3.new(0, 1, 0),
    Visible = true
})

local avgt = newDrawing("Text", {
    Font = 2,
    Color = Color3.new(1, 1, 1),
    Center = false,
    Outline = true,
    Size = 13,
    Visible = true
})

local pt = newDrawing("Text", {
    Font = 2,
    Color = Color3.new(1, 1, 1),
    Center = false,
    Outline = true,
    Size = 13,
    Position = startpos + Vector2.new(0, size + 10),
    Visible = true
})
local ptc = cloneDrawing(pt)
ptc.Position = pt.Position + Vector2.new(1, 0)
ptc.Outline = false

local nrt = newDrawing("Text", {
    Font = 2,
    Color = Color3.new(1, 1, 1),
    Center = false,
    Outline = true,
    Size = 13,
    Position = pt.Position + Vector2.new(0, 15),
    Visible = true
})
local nrtc = cloneDrawing(nrt)
nrtc.Position = nrt.Position + Vector2.new(1, 0)
nrtc.Outline = false

local nst = newDrawing("Text", {
    Font = 2,
    Color = Color3.new(1, 1, 1),
    Center = false,
    Outline = true,
    Size = 13,
    Position = nrt.Position + Vector2.new(0, 15),
    Visible = true
})
local nstc = cloneDrawing(nst)
nstc.Position = nst.Position + Vector2.new(1, 0)
nstc.Outline = false

local ft = newDrawing("Text", {
    Font = 2,
    Color = Color3.new(1, 1, 1),
    Center = false,
    Outline = true,
    Size = 13,
    Position = nst.Position + Vector2.new(0, 15),
    Visible = true
})
local ftc = cloneDrawing(ft)
ftc.Position = ft.Position + Vector2.new(1, 0)
ftc.Outline = false

local tt = newDrawing("Text", {
    Font = 2,
    Color = Color3.new(1, 1, 1),
    Center = false,
    Outline = true,
    Size = 13,
    Position = ft.Position + Vector2.new(0, 15),
    Visible = true
})
local ttc = cloneDrawing(tt)
ttc.Position = tt.Position + Vector2.new(1, 0)
ttc.Outline = false

for i = 1, 10 do
    values[i] = 0

    newLine({Thickness = 2, Color = Color3.new(1,1,1)})
end

function sum(a)
    local b = 0
    for i, v in pairs(a) do
        b = b + v
    end
    return b
end

local values2 = {}

local offset = 25

local stats = game:GetService("Stats")

local thing = stats.Network.ServerStatsItem["Data Ping"]

for i, v in pairs(values) do

    local line = lines[i]

    v = math.clamp(v, 0, max_val)

    if i ~= #values then
        table.insert(values2, v)
    end

    local avg = sum(values2) / #values2

    avgt.Text = ("Average: %s"):format(tostring(avg))

    local pos = (avg / max_val) * size

    local old = lines[i - 1]

    avgt.Position = startpos + Vector2.new((i - 1) * offset + 10, size - pos - 5)

    if old ~= nil then
        old.To = Vector2.new(startpos.X + ((i - 1) * offset), startpos.Y + size - pos)
    end

    avgl.From = startpos + Vector2.new(0, size - pos)
    avgl.To = startpos + Vector2.new((i - 1) * offset, size - pos)

    line.From = Vector2.new(startpos.X + ((i - 1) * offset), startpos.Y + size - pos)

    box_2.Size = Vector2.new((i - 1) * offset, 1)

    line.Visible = true

    if i == #values then
        line.Visible = false
    end
end

rs.RenderStepped:Connect(function(delta)
    if tick()-last_updates[1] >= 0.5 then

        last_updates[1] = tick()

        table.remove(values, 1)
        table.insert(values, thing:GetValue())

        table.clear(values2)

        local average = 0

        for i, v in pairs(values) do

            local line = lines[i]

            v = math.clamp(v, 0, max_val)

            table.insert(values2, v)

            local avg = sum(values2) / #values2

            avgt.Text = ("Average: %s"):format(tostring(math.round(avg)))

            local pos = (avg / max_val) * size

            local old = lines[i - 1]

            avgt.Position = startpos + Vector2.new(offset * (#values - 1) + 10, size - pos - 5)

            if old ~= nil then
                old.To = Vector2.new(startpos.X + ((i - 1) * offset), startpos.Y + size - pos)
            end

            avgl.From = startpos + Vector2.new(0, size - pos)
            avgl.To = startpos + Vector2.new((i - 1) * offset, size - pos)

            line.From = Vector2.new(startpos.X + ((i - 1) * offset), startpos.Y + size - pos)

            line.Visible = true

            if i == #values then
                line.Visible = false
                average = avg
            end
        end

        if average < 100 then
            avgt.Color = Color3.new(0, 1, 0)
        elseif average < 250 then
            avgt.Color = Color3.fromRGB(151, 214, 56)
        elseif average < 500 then
            avgt.Color = Color3.new(1, 1, 0)
        elseif average < 750 then
            avgt.Color = Color3.fromRGB(255, 150, 0)
        elseif average > 750 then
            avgt.Color = Color3.new(1, 0, 0)
        end
    end

    if tick()-last_updates[2] >= 0.25 then
        last_updates[2] = tick()
        ft.Text = ("FPS: %s"):format(tostring(math.floor(1 / delta)))
        ftc.Text = ft.Text
    end

    pt.Text = ("Ping: %sms"):format(tostring(math.round(thing:GetValue())))
    nrt.Text = ("Receive: %skb/s"):format(tostring(math.round(stats.DataReceiveKbps)))
    nst.Text = ("Send: %skb/s"):format(tostring(math.round(stats.DataSendKbps)))
    tt.Text = ("Tick: %s"):format(tostring(math.floor(tick())))

    --

    ptc.Text = pt.Text
    nrtc.Text = nrt.Text
    nstc.Text = nst.Text
    ttc.Text = tt.Text

    for i, v in pairs(cloned) do
        if i.Visible ~= bold then
            i.Visible = bold
        end
    end
end)
end)
local background_list = {
    ["ZXC Cat"] = "rbxassetid://10300256322",
    ["Pavuk Redan"] = "rbxassetid://12652997937",
    ["Pink Anime Girl"] = "rbxassetid://11696859404",
    ["Dark anime girl"] = "rbxassetid://10341849875",
    ["TokyoGhoul"] = "rbxassetid://14007782187"
};

local tracks = {
    ["Chilled Vibes B"] = "rbxassetid://9041863309",
    ["Papers C"] = "rbxassetid://9043888051",
    ["Forest"] = "rbxassetid://728506251",
    ["Heavy Rain 1"] = "rbxassetid://9112793880",
    ["Heavy Rain 2"] = "rbxassetid://9112794037",
    ["Music"] = "rbxassetid://9048378262"
};

local killsounds = { --хм
    ["Neverlose"] = "229978482",
    ["CS:GO"] = "7269900245",
    ["Ultra Kill"] = "937885646",
    ["Killing Spree"] = "937898383"
};

local hitsounds = { --хм
    ["Minecraft EXP"] = "1053296915",
    ["Skeet"] = "5447626464",
    ["Neverlose"] = "6534948092",
    ["Rust Headshot"] = "5043539486"
};

MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' }) 
MenuGroup:AddToggle('ShowKeybindMenu', {Text = 'Show Keybinds Menu', Default = true}):OnChanged(function(bool) Library.KeybindFrame.Visible = bool end)
MenuGroup:AddToggle('ShowWatermark', {Text = 'Show Watermark', Default = true}):OnChanged(function(bool) Library.Watermark.Visible = bool end)
MenuGroup:AddLine()
MenuGroup:AddDropdown('backgroundimage', {Text = 'Background Image', Values = indexListing(background_list), Default = 1}):OnChanged(function(val) 
    for i, v in pairs(ui_utility.image_color) do 
        v["Image"] = background_list[val];
    end
end)
MenuGroup:AddLine()

MenuGroup:AddSlider('changetransamount', {Text = 'Tabs Transparency' ,Default = 0.49, Min = 0, Max = 1, Rounding = 2, Compact = false}):OnChanged(function(val) 
    for i, v in pairs(ui_utility.tab_trans) do 
        v["BackgroundTransparency"] = val;
    end
end)
MenuGroup:AddSlider('changekeybindlistrans', {Text = 'Keybind List Transparency' ,Default = 0, Min = 0, Max = 1, Rounding = 2, Compact = false}):OnChanged(function(val) 
    for i, v in pairs(ui_utility.keybinds_trans) do 
        v["BackgroundTransparency"] = val;
    end
end)

LeftMenuGroup:AddLeftDivider("stixzz - UI,RAGE,VISUALS")
LeftMenuGroup:AddLeftDivider("nixus - RAGE,VISUALS")
LeftMenuGroup:AddLeftDivider("xosmane - RAGE,VISUALS,MISC")

LeftMenuGroup:AddLeftDivider("banannegr - IDEA MANAGER")
LeftMenuGroup:AddButton('Copy Discord Invite', function()
    setclipboard("https://gameshark.dev/")
end)

-- RageBot [start
Sections.Rage:AddDivider("Aimbotting")

Sections.Rage:AddToggle('rage_enabled', {Text = 'Enable'}):AddKeyPicker('Aimbotkey', {Default = 'E', Text = 'Aimbot', Mode = 'Always'})
Sections.Rage:AddToggle('rage_teammet', {Text = 'Teammates'})
Sections.Rage:AddToggle('rage_autofire', {Text = 'Auto Shoot'})
Sections.Rage:AddToggle('rage_autowall', {Text = 'Auto wall'})
Sections.Rage:AddToggle('Resolver', {Text = 'Resolve Angles'})
Sections.Rage:AddToggle('Camera_Resolve', {Text = 'Resolve Camera'})


Sections.Rage:AddDropdown('rage_hitboxes', {Text = 'Hitboxes', Values = {'Head', 'Torso', 'Arms', 'Legs'}, Default = 1, Multi = true})
Sections.Rage:AddDropdown('Rage_Points', {Text = 'Points', Values = {'Default', 'Normal', 'Multi'}, Default = 1})
Sections.Rage:AddSlider('rage_mod', {Text = 'Penetration modifier' ,Default = 1, Min = 1, Max = 5, Rounding = 1, Compact = false})

Sections.Rage:AddDivider("Hitpart Things")

Sections.Rage:AddToggle('HuiPart', {Text = 'HitPart'})
Sections.Rage:AddToggle('NaN_Predict', {Text = 'NaN Prediction'})
Sections.Rage:AddToggle('Custom_Gun', {Text = 'Custom Kill Gun'})
Sections.Rage:AddDropdown('killgun', {Text = 'Kill Gun', Values = {'Glock', 'USP', 'CZ', 'DesertEagle', "R8", "AK47", "SG" ,"MP9", "P90", "Bizon", "Famas", "Galil", "AUG", "AWP", "Scout", "G3SG1", "CT Knife" ,"T Knife", "Banana", "Bayonet", "Butterfly Knife", "Cleaver", "Crowbar", "Falchion Knife", "Flip Knife", "Gut Knife", "Huntsman Knife", "Karambit", "Sickle"}, Default = 1, Multi = false, Tooltip = "which what gun you killing"})
Sections.Rage:AddToggle('infinity_damage', {Text = 'Inf damage'})
Sections.Rage:AddToggle('wallbang_oh', {Text = 'Wallbang Icon', Default = false, Tooltip = 'showing wallbang icon'})
Sections.Rage:AddToggle('rbm_oh', {Text = 'RBM Hit', Default = false, Tooltip = 'Hitting with right mouse button'})
-- RageBot end]

Sections.fwt:AddToggle('rage_fwt', {Text = 'Forward Track'})
Sections.fwt:AddDropdown('fwt_mode', {Text = 'Method', Values = {'new', 'old'}, Default = 1})

Sections.fwt:AddSlider('rage_fwtAmount', {Text = 'Amount' ,Default = 0, Min = 0, Max = 1, Rounding = 2, Compact = false})
Sections.fwt:AddToggle('rage_fwt_vis', {Text = 'Visualizer'}):AddColorPicker('fwt_vis_color', {Title = 'Color', Default = Color3.new(0,1,0)})

-- //

Sections.backtr:AddToggle('rage_backtracks', {Text = 'Backtrack'})
Sections.backtr:AddSlider('rage_backtrack', {Text = 'Amount' ,Default = 150, Min = 0, Max = 350, Rounding = 0, Compact = false})
Sections.backtr:AddToggle('rage_backtrack_vis', {Text = 'Visualizer'}):AddColorPicker('bt_vis_color', {Title = 'Color', Default = Color3.new(0,1,0)})
-- bullshit
Sections.bulshit:AddToggle('custom_tap', {Text = 'Custom Tap'})
Sections.bulshit:AddSlider('custom_hpr', {Text = 'Amount' ,Default = 2, Min = 2, Max = 15, Rounding = 0, Compact = false})

Sections.bulshit:AddDropdown('awhitscan_met', {Text = 'Auto Wall Scan', Values = {'new', 'old'}, Default = 2})
Sections.bulshit:AddSlider('Speedz', {Text = 'Scan Speed' ,Default = 0, Min = 0, Max = 100, Rounding = 0, Compact = false})
Sections.bulshit:AddSlider('Pointsz', {Text = 'Points amount' ,Default = 0, Min = 0, Max = 100, Rounding = 0, Compact = false})

local awaddpoints = Options.Pointsz.Value
local awspeedscan = Options.Speedz.Value

Sections.bulshit:AddToggle('Hitbox_Expander', {Text = 'Hitbox Expander'})

Sections.bulshit:AddSlider('Hitbox_Expander_X', {Text = 'X' ,Default = 0, Min = 0, Max = 60, Rounding = 0, Compact = false})
Sections.bulshit:AddSlider('Hitbox_Expander_Y', {Text = 'Y' ,Default = 0, Min = 0, Max = 60, Rounding = 0, Compact = false})
Sections.bulshit:AddSlider('Hitbox_Expander_Z', {Text = 'Z' ,Default = 0, Min = 0, Max = 60, Rounding = 0, Compact = false})

-- Misc [start
--//MOVEMENT
Sections.Movement:AddToggle('bunny_enabled', {Text = 'Bunny Hop'})
Sections.Movement:AddToggle('MovementHack', {Text = 'Walk Speed'}):AddKeyPicker('Walk_Bind', {Default = 'C', Text = 'Walk Speed', Mode = 'Toggle'})
Sections.Movement:AddSlider('WalkValue', {Text = 'Walk Speed Amount',Default = 43,Min = 10,Max = 200,Rounding = 0,Compact = false,})
Sections.Movement:AddSlider('SpeedValue', {Text = 'Bunny Hop Amount',Default = 43,Min = 10,Max = 200,Rounding = 0,Compact = false,})
Sections.Movement:AddDropdown('SpeedType', {Text = 'Speed Method', Values = {'Velocity'}, Default = 1, Multi = false})
Sections.Movement:AddToggle('FlyHack', {Text = 'Fly Hax', Tooltip = 'same as Speed hax but with the ability to fly.'}):AddKeyPicker('FlyHackKeypicker', {Default = 'Z', Text = 'Fly Hack', Mode = 'Toggle'})
Sections.Movement:AddSlider('SpeedForFly', {Text = 'Speed for fly',Default = 43,Min = 10,Max = 200,Rounding = 0,Compact = false,})
Sections.Movement:AddToggle('Airstuck', {Text = 'Air Stuck'}):OnChanged(function(val) -- я кста до сих пор не понял как к этой хуйне бинд прелипить
        if IsAlive(lplr) and UserInputService:GetFocusedTextBox() == nil then
            for i,v in pairs(LocalPlayer.Character:GetChildren()) do
                if v:IsA("BasePart") then
                    v.Anchored = val
                end
            end
        end
    end)
--//TWEAKS

Sections.Tweaks:AddToggle('radio_disable', {Text = 'disable radio commands'})
Sections.Tweaks:AddToggle('RemoveDmgFromFire', {Text = 'Remove Burn Damage'})
Sections.Tweaks:AddToggle('RemoveDmgFromFall', {Text = 'Remove Fall Damage'})
Sections.Tweaks:AddToggle('Ping_Spoof', {Text = 'Ping Spoof'})
Sections.Tweaks:AddSlider('Ping_Value', {Text = 'Min Ping Amount',Default = 200,Min = 1,Max = 1000,Rounding = 0,Compact = false,})
Sections.Tweaks:AddSlider('PingValue', {Text = 'Max Ping Amount',Default = 300,Min = 1,Max = 1000,Rounding = 0,Compact = false,})

--//CLIENT
Sections.Client:AddToggle('InfCash', {Text = 'Infinite Cash'})
Sections.Client:AddToggle('KillAll', {Text = 'Kill All', Default = false, Risky = true, Tooltip = 'just kill all'})
Sections.Client:AddToggle('hbbriker', {Text = 'Fuck Seere', Default = false, Risky = true, Tooltip = ''})

Sections.Client:AddDropdown('killAll_type', {Text = 'Kill All Type', Values = {'xosmane\'s', 'test', 'ofc best', 'lio\'s old'}, Multi = false, Default = 'ofc best'})
Sections.Client:AddSlider('killAll_hps', {Text = 'hits amount', Default = 2, Min = 0, Max = 15, Rounding = 0})
Sections.Client:AddToggle('killAll_arg10', {Text = 'Wallbang kill', Default = false, Tooltip = 'killall with wallbang icon'})
Sections.Client:AddToggle('killAll_arg9', {Text = 'RBM kill', Default = true, Tooltip = 'killall will kill with right mouse button'})
Sections.Client:AddToggle('ShopInfTimeAndAnywhere', {Text = 'Shop Infinite Time And Anywhere'})
Sections.Client:AddToggle('KillSound', {Text = 'Kill Sound'})
Sections.Client:AddDropdown('Killsoundflag', {Text = 'Choose Kill Sounds', Values = indexListing(killsounds), Multi = false, Default = 1})
Sections.Client:AddSlider('KillSound_Volume', {Text = 'Volume', Default = 5, Min = 1, Max = 10, Rounding = 1})
Sections.Client:AddToggle('Hitsound', {Text = 'Hit Sound'})
Sections.Client:AddDropdown('hitsoundflag', {Text = 'Choose Hit Sounds', Values = indexListing(hitsounds), Multi = false, Default = 1})
Sections.Client:AddSlider('hitsoundvolume', {Text = 'Volume', Default = 5, Min = 1, Max = 10, Rounding = 1})
    

--//CHAT
Sections.Chat:AddToggle('RemoveFilter', {Text = 'Bypass Chat Filter'})
Sections.Chat:AddToggle('KillSay', {Text = 'Kill Say', Tooltip = "when you kill someone cheat will write in chat random word"})
Sections.Chat:AddDropdown('KillType', {Text = 'Say Type', Values = {'Lio', 'Nixus', 'Xosmane', 'CS:GO HvH', 'China Propaganda', 'Random Words', 'Facts', 'BBot', 'Serega Pirat'}, Default = 1, Multi = false})
Sections.Chat:AddToggle('ChatSpam', {Text = 'Chat Spam'})
Sections.Chat:AddDropdown('SpamType', {Text = 'Spam Type', Values = {'Kill say', 'Advertise', 'Funny'}, Default = 1, Multi = false})



--//GUN MODS
Sections.Modifers:AddToggle('InfAmmo', {Text = 'Infinite Ammo'})
Sections.Modifers:AddToggle('NoRecoil', {Text = 'Remove Recoil'})
Sections.Modifers:AddToggle('FireRate', {Text = 'FireRate', Tooltip = 'less - faster'})
Sections.Modifers:AddSlider('FireRateValue', {Text = 'FireRate',Min = 0, Max = 100, Rounding = 0, Compact = true, Default = 30, Suffix = '%'})

Sections.Modifers:AddToggle('Auto', {Text = 'Force Auto'})
Sections.Modifers:AddToggle('Range', {Text = 'Infinite Range'})

Sections.Desyncsec:AddDivider("Desync Stuff")

Sections.Desyncsec:AddToggle('desync_enabled', {Text = 'Enable'})
Sections.Desyncsec:AddToggle('desync_visualizer', {Text = 'Visualizer'}):AddColorPicker('desync_visualizer', {Title = 'vizcol', Default = Color3.new(.5,0,0), Transparency = .25})
--Sections.Desyncsec:AddToggle('desync_delay', {Text = 'Use Delay'})
Sections.Desyncsec:AddToggle('desync_fling', {Text = 'Use Fling'})

Sections.Desyncsec:AddDivider()

Sections.Desyncsec:AddDropdown('desync_mode', {Text = 'Desync Mode', Values = {'-', 'Offset', 'Random', 'Invisible', "Target"}, Multi = false, Default = 2})
Sections.Desyncsec:AddDropdown('delay_type', {Text = 'Delay Mode', Values = {'Server Pos', 'Offset', 'Random'}, Multi = false, Default = 2})
Sections.Desyncsec:AddDropdown('desync_mode_fling', {Text = 'Fling Mode', Values = {'Positive', 'Negative', 'NaN'}, Multi = false, Default = 2})
Sections.Desyncsec:AddDropdown('targetplrselected', {Text = 'Target Player', Values = GetPlayerNames(), Multi = false, Default = 2})

Sections.Desyncsec:AddDivider("Delay Manipulation")

Sections.Desyncsec:AddSlider('desync_delay_x', {Text = 'Delay Of Desync', Min = 0, Max = 100, Rounding = 0, Default = 1})
Sections.Desyncsec:AddSlider('desync_delay_min', {Text = 'Min Delay Of Desync', Min = 0, Max = 100, Rounding = 0, Default = 1})

Sections.Desyncsec:AddDivider("Target Strafe Manipulation")

Sections.Desyncsec:AddSlider('Target_Offset', {Text = 'Offset', Min = 0, Max = 100, Rounding = 0, Default = 0})
Sections.Desyncsec:AddSlider('Target_Speed', {Text = 'Speed', Min = 0, Max = 100, Rounding = 0, Default = 0})



Sections.Safetysec:AddToggle('Anti_Camera', {Text = 'Anti Camera'})
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Events = ReplicatedStorage.Events

-- Scripts
local cbClient = getsenv(LocalPlayer.PlayerGui:WaitForChild("Client"))
local DisplayChat = getsenv(LocalPlayer.PlayerGui.GUI.Main.Chats.DisplayChat)

-- Game Functions
local createNewMessage = DisplayChat.createNewMessage

-- Events
local function GetSite()
	if (LocalPlayer.Character.HumanoidRootPart.Position - workspace.Map.SpawnPoints.C4Plant.Position).magnitude > (LocalPlayer.Character.HumanoidRootPart.Position - workspace.Map.SpawnPoints.C4Plant2.Position).magnitude then
		return "A"
	else
		return "B"
	end
end
local ThrowGrenade = Events.ThrowGrenade
local PlantC4 = Events.PlantC4
Sections.Safetysec:AddButton('Plant C4', function()
pcall(function()
    if IsAlive(lplr) and workspace.Map.Gamemode.Value == "defusal" and workspace.Status.Preparation.Value == false and not planting then 
        planting = true
        local pos = lplr.Character.HumanoidRootPart.CFrame 
        CurrentCamera.CameraType = "Fixed"
        lplr.Character.HumanoidRootPart.CFrame = workspace.Map.SpawnPoints.C4Plant.CFrame
        wait(0.2)
        PlantC4:FireServer((pos + Vector3.new(math.random(1000,2000), math.random(555,2000), math.random(1000,2000))) * CFrame.Angles(math.rad(99), 0, math.rad(180)), GetSite())
        wait(0.2)
        lplr.Character.HumanoidRootPart.CFrame = pos
        lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
        CurrentCamera.CameraType = "Custom"
        planting = false
    end
end)
end)
Sections.Safetysec:AddToggle('HookNoHead', {Text = 'Anti NoHead', Tooltip = 'makes u able to shoot nohead players in head'})
Sections.Safetysec:AddToggle('AntiFall', {Text = 'Anti Fall', Tooltip = 'Safe you from falling out of the map'})
Sections.Safetysec:AddSlider('AntiFall_dist', {Text = 'Anti Fall Distance', Min = 1, Max = 25, Rounding = 0, Default = 4})
--Exploits end]

local light = game.Lighting
--Visuals [start
Sections.Players:AddToggle('esp_enabled', {Text = 'Enabled'})
Sections.Players:AddToggle('esp_box', {Text = 'Box'}):AddColorPicker('esp_boxColor', {Title = 'Box Color', Default = Color3.new(1,1,1)})
Sections.Players:AddToggle('esp_boxFill', {Text = 'Box Fill'}):AddColorPicker('esp_boxFillColor', {Title = 'Box Fill Color', Default = Color3.new(.5,0,0), Transparency = .25})
Sections.Players:AddToggle('esp_health', {Text = 'Health Bar'}):AddColorPicker('esp_barColor', {Title = 'Health Bar Color', Default = Color3.new(0,1,0)})
Toggles.esp_health:AddColorPicker('esp_barColor2', {Title = 'Health Bar Color 2', Default = Color3.new(1,0,0)})
Sections.Players:AddToggle('esp_chams', {Text = 'Chams'}):AddColorPicker('esp_chamsColor', {Title = 'Chams Color', Default = Color3.new(0,0,1)})
Toggles.esp_chams:AddColorPicker('esp_chamsColor2', {Title = 'Chams Color 2', Default = Color3.new(0,0,0)})
Sections.Players:AddToggle('esp_name', {Text = 'Name'}):AddColorPicker('esp_nameColor', {Title = 'Name Color', Default = Color3.new(1,1,1)})
Sections.Players:AddToggle('esp_dist', {Text = 'Distance'}):AddColorPicker('esp_distColor', {Title = 'Distance Color', Default = Color3.new(1,1,1)})
Sections.Players:AddToggle('esp_healthtext', {Text = 'Health Text'}):AddColorPicker('esp_healthtextColor', {Title = 'Health Text Color', Default = Color3.new(0,1,0)})
Sections.Players:AddToggle('esp_tracer', {Text = 'Tracer'}):AddColorPicker('esp_tracerColor', {Title = 'Tracer Color', Default = Color3.new(1,1,1)})
Sections.Players:AddToggle('esp_viewangle', {Text = 'View Angle'}):AddColorPicker('esp_viewangleColor', {Title = 'Tracer Color', Default = Color3.new(1,1,1)})
Sections.Players:AddToggle('esp_OSA', {Text = 'Off Screen Arrow'}):AddColorPicker('esp_OSAColor', {Title = 'Off Screen Arrow Color', Default = Color3.new(1,1,1)})
Sections.Players:AddToggle('esp_skeleton', {Text = 'Skeleton'}):AddColorPicker('esp_skeletonColor', {Title = 'Tracer Color', Default = Color3.new(1,1,1)})

Sections.Settings:AddToggle('esp_outline', {Text = 'Outline'}):AddColorPicker('esp_outlineColor', {Title = 'Outline Color', Default = Color3.new(0,0,0)})
Sections.Settings:AddToggle('esp_maxdistance', {Text = 'Max Distance'})
Sections.Settings:AddSlider('esp_maxdistanceValue', {Min = 0, Max = 8000, Default = 250, Rounding = 0, Suffix = ' Studs', Text = 'Max Distance', Compact = true})
Sections.Settings:AddDropdown('esp_nametextSide', {Text = 'Name Position', Values = {'top', 'bottom', 'left', 'right'}, Multi = false, Default = 1})
Sections.Settings:AddDropdown('esp_healthtextSide', {Text = 'Health Text Position', Values = {'top', 'bottom', 'left', 'right'}, Multi = false, Default = 3})
Sections.Settings:AddDropdown('esp_healthSide', {Text = 'Health Bar Position', Values = {'top', 'bottom', 'left', 'right'}, Multi = false, Default = 3})
Sections.Settings:AddDropdown('esp_distancetextSide', {Text = 'Distance Position', Values = {'top', 'bottom', 'left', 'right'}, Multi = false, Default = 2})
Sections.Settings:AddSlider('esp_arrowRadius', {Min = 20, Max = 800, Default = 250, Rounding = 0, Text = 'Arrow Radius', Compact = false})
Sections.Settings:AddSlider('esp_arrowSize', {Min = 3, Max = 50, Default = 20, Rounding = 0, Text = 'Arrow Size', Compact = false})
Sections.Settings:AddSlider('esp_arrowTrans', {Min = 0, Max = 100, Default = 50, Rounding = 0, Text = 'Arrow Fill Transparency', Compact = false, Suffix = '%'})
Sections.Settings:AddSlider('esp_textFont', {Min = 1, Max = 4, Default = 2, Rounding = 0, Text = 'Text Font', Compact = false})
Sections.Settings:AddSlider('esp_textSize', {Min = 4, Max = 30, Default = 14, Rounding = 0, Text = 'Text Size', Compact = false})
Sections.Settings:AddToggle('esp_teamcheck', {Text = 'Team Check'})

Sections.Local:AddDivider("Self")
Sections.Local:AddToggle('Third_Person', {Text = 'Third Person'}):AddKeyPicker('Third_Bind', {Default = 'X', Text = 'Third Person', Mode = 'Toggle'})
Sections.Local:AddSlider('Third_Distance', {Text = 'Distance', Min = 1, Max = 15, Rounding = 0, Default = 8})


Sections.Local:AddLine()
Sections.Local:AddToggle('selfchamsz', {Text = 'Chams'}):AddColorPicker('selfchamsz_color', {Title = 'Color', Default = Color3.new(1,1,1)})
Sections.Local:AddDropdown('selfchamsz_material', {Text = 'Material', Values = {'ForceField', 'SmoothPlastic', 'Neon'}, Multi = false, Default = 1})
Sections.Local:AddLine()

Sections.Local:AddToggle('VizSilentAngle', {Text = 'Visualize Silent Angle'})
Sections.Local:AddSlider('Speed_angle', {Text = 'Speed', Min = 0, Max = 10, Rounding = 0, Default = 1})
Sections.Local:AddLine()
Sections.Local:AddDivider("Weapon")

Sections.Local:AddToggle('view_w_enabled', {Text = 'Chams'}):AddColorPicker('view_w_color', {Title = 'Weapon Chams Color', Default = Color3.new(1,1,1)})
Sections.Local:AddDropdown('view_w_material', {Text = 'Weapon Chams Material', Values = {'Plastic', 'Neon', 'ForceField', 'Ghost', 'Glass'}, Default = 1})
Sections.Local:AddSlider('view_w_trans', {Text = 'Transparency', Min = 1, Max = 100, Rounding = 0, Default = 1})
Sections.Local:AddSlider('view_w_ref', {Text = 'Reflectance', Min = 1, Max = 100, Rounding = 0, Default = 1})
Sections.Local:AddSlider('view_w_speed', {Text = 'Speed', Min = 1, Max = 100, Rounding = 0, Default = 10})


Sections.Local:AddDivider("Radio Things")

Sections.Local:AddDropdown('radioflag', {Text = 'Choose Track', Values = indexListing(tracks), Multi = false, Default = 1})
Sections.Local:AddSlider('radiovolume', {Text = 'Volume', Min = 1, Max = 200, Rounding = 0, Default = 150})

Sections.Local:AddButton('Loop', function(state)
    trackloop = state
    for i, v in pairs(game.Workspace:GetChildren()) do
        trackshit.Looped = state
    end
end)
Sections.Local:AddButton('Play', function(playtrack)
    if trackshit then trackshit:Destroy() end
    trackshit = Instance.new("Sound") 
    trackshit.Parent = game.Workspace
    trackshit.SoundId = tracks[Options.radioflag.Value]
    trackshit.Volume = Options.radiovolume.Value
    trackshit.Looped = trackloop
    trackshit:Play()
end)
Sections.Local:AddButton('Pause', function(val)
    for i, v in pairs(game.Workspace:GetChildren()) do
        trackshit:Pause()
    end
end)
Sections.Local:AddButton('Resume', function(val)
    for i, v in pairs(game.Workspace:GetChildren()) do
        trackshit:Resume()
    end
end)
Sections.Local:AddButton('Stop', function()
    for i, v in pairs(game.Workspace:GetChildren()) do
        trackshit:Destroy()
    end
end)

Sections.World:AddToggle('enablebettershadow', {Text = 'Better Shadow'})
Sections.World:AddDropdown('shadowtype', {Text = 'Shadow Technology', Values = {'Shadow Map', 'Future', 'Voxel'}, Default = 3}):OnChanged(function(type)
    if Toggles.enablebettershadow.Value then 
        if type == "Shadow Map" then
            sethiddenproperty(game.Lighting, "Technology", "ShadowMap")
        elseif type == "Future" then
            sethiddenproperty(game.Lighting, "Technology", "Future")
        elseif type == "Voxel" then
            sethiddenproperty(game.Lighting, "Technology", "Voxel")
        end
    end
end)

Sections.World:AddToggle('tmchan', {Text = 'Time Changer'})
Sections.World:AddSlider('timechanger', {Min = 0, Max = 23, Default = 14, Rounding = 0, Text = 'Time', Compact = false}):OnChanged(function(val)
    spawn(function()
        while task.wait(0.1) do
if Toggles.tmchan.Value then
    light.ClockTime  = Options.timechanger.Value
end
end
end)
end)
Sections.World:AddToggle('ambient_world', {Text = 'Ambient'}):AddColorPicker('ambient_color1', {Title = 'Color 1', Default = Color3.new(0,0,0)}):OnChanged(function(val)
spawn(function()
while task.wait(0.1) do
    if Toggles.ambient_world.Value then
            light.Ambient = Options.ambient_color1.Value
            else
            light.Ambient =  Color3.new(1, 1, 1)
            end
        end
    end)
end)
Sections.World:AddToggle('ambient_worlddoor', {Text = 'OutdoorAmbient'}):AddColorPicker('ambient_color2', {Title = 'Color 2', Default = Color3.new(0,0,0)}):OnChanged(function(val)
    spawn(function()
        while task.wait(0.1) do
            if Toggles.ambient_worlddoor.Value then
                light.OutdoorAmbient = Options.ambient_color2.Value
            else
                light.OutdoorAmbient =  Color3.new(1, 1, 1)
            end
        end
    end)
end)
Sections.World:AddDropdown('skyboxtype', {Text = 'Choose Skybox', Values = indexListing(skyboxes), Multi = false, Default = '-'})



Sections.Other:AddToggle('enable_viewmodels', {Text = 'Enable Viewmodels'})
Sections.Other:AddSlider('vm_X', {Text = 'X', Min = -360, Max = 360, Rounding = 0, Default = 0})
Sections.Other:AddSlider('vm_Y', {Text = 'Y', Min = -360, Max = 360, Rounding = 0, Default = 0})
Sections.Other:AddSlider('vm_Z', {Text = 'Z', Min = -360, Max = 360, Rounding = 0, Default = 0})
Sections.Other:AddSlider('vm_roll', {Text = 'Roll', Min = 0, Max = 360, Rounding = 0, Default = 0})
Sections.Other:AddToggle('v_arms', {Text = 'Arms Changer'})
Sections.Other:AddSlider('v_arms_transparency', {Text = 'Arms Transparency', Min = 1, Max = 100, Rounding = 0, Default = 1})
Sections.Other:AddToggle('v_hide_gloves', {Text = 'Hide Gloves'})
Sections.Other:AddToggle('v_hide_sleeves', {Text = 'Hide Sleeves'})
--Visuals end]


-- Misc Code [start
localPlayer.Status.Kills:GetPropertyChangedSignal("Value"):Connect(function(val)
    if val == 0 then return end
    local rbxasset= "rbxassetid://"
    local killsoundtoggle = Toggles.KillSound.Value
    local killsoundid = killsounds[Options.Killsoundflag.Value]
    local soundEmpty = soundid == ""
    local killsoundvolume = Options.KillSound_Volume.Value
    killsoundtoggle = soundEmpty and "rbxassetid://6229978482" or killsoundtoggle
    if killsoundtoggle and val ~= 0 then
        local marker = Instance.new("Sound")
        marker.Parent = game:GetService("SoundService")
        marker.SoundId = ("rbxassetid://" .. killsoundid)
        marker.Volume = (killsoundvolume / 5)
        marker:Play()
    end
    if Toggles and Toggles.KillSay and Toggles.KillSay.Value and val ~= 0 then -- самое уебанское что я делал
        if Options and Options.KillType and Options.KillType.Value == 'Lio' then
        game:GetService("ReplicatedStorage").Events.PlayerChatted:FireServer(killsey[math.random(1, #killsey)], false, false, true)
    elseif Options and Options.KillType and Options.KillType.Value == 'Nixus' then
        game:GetService("ReplicatedStorage").Events.PlayerChatted:FireServer(nixus[math.random(1, #nixus)], false, false, true)
    elseif Options and Options.KillType and Options.KillType.Value == 'Xosmane' then
        game:GetService("ReplicatedStorage").Events.PlayerChatted:FireServer(xosmane[math.random(1, #xosmane)], false, false, true)
    elseif Options and Options.KillType and Options.KillType.Value == 'CS:GO HvH' then
        game:GetService("ReplicatedStorage").Events.PlayerChatted:FireServer(csgo[math.random(1, #csgo)], false, false, true)
    elseif Options and Options.KillType and Options.KillType.Value == 'China Propaganda' then
        game:GetService("ReplicatedStorage").Events.PlayerChatted:FireServer(china[math.random(1, #china)], false, false, true)
    elseif Options and Options.KillType and Options.KillType.Value == 'Random Words' then
        game:GetService("ReplicatedStorage").Events.PlayerChatted:FireServer(random[math.random(1, #random)], false, false, true)
    elseif Options and Options.KillType and Options.KillType.Value == 'Facts' then
        game:GetService("ReplicatedStorage").Events.PlayerChatted:FireServer(facts[math.random(1, #facts)], false, false, true)
    elseif Options and Options.KillType and Options.KillType.Value == 'BBot' then
        game:GetService("ReplicatedStorage").Events.PlayerChatted:FireServer(bbot[math.random(1, #bbot)], false, false, true) -- когда это закончится.... (никогда)
    elseif Options and Options.KillType and Options.KillType.Value == 'Serega Pirat' then
        game:GetService("ReplicatedStorage").Events.PlayerChatted:FireServer(serega[math.random(1, #serega)], false, false, true)
        end
    end
end)


local adss = { --фри мемберы
    "gameshark.dev",
    "hey u should join gameshark.dev",
    'ruskiware (cracked by office - legend)',
    'rusnyaware on top i think',
    "gameshark.dev join",
    "Hey! Join gameshark.dev",
    "скрипт тут gameshark.dev",
    "join for script gameshark.dev",
    "I Found the *BEST* Script for CB:RO 😱😎😱 gameshark.dev",
    "Get a Knife in 2 hours 😱😎😱 gameshark.dev",
    "JOIN HERE TO GET 2000 ROBUX 😱😎😱 gameshark.dev",
    "FREE BROBUX GENERATOR 2023 LATEST NO BAN 😱😎😱 gameshark.dev"
}


local killseyr = ("RАРЕ SЕХY СНILDRЕN СОСK СUNТ"):split(" "); -- thanks neglect,j ! <3

function randomGenerate(words: number)

    local sexz = "";

    for wordCounter = 1, words do
        
        sexz ..= killseyr[math.random(1, #killseyr)] .. " ";

    end

    return sexz;

end

runService.Stepped:Connect(function()
    if  Toggles.ChatSpam and Toggles.ChatSpam.Value then
        if  Options.SpamType and Options.SpamType.Value == 'Kill say' then
            game:GetService("ReplicatedStorage").Events.PlayerChatted:FireServer(xosmane[math.random(1, #xosmane)], false, false, true)
        elseif Options and Options.SpamType and Options.SpamType.Value == 'Advertise' then
            game:GetService("ReplicatedStorage").Events.PlayerChatted:FireServer(adss[math.random(1, #adss)], false, false, true)
            elseif Options.SpamType and Options.SpamType.Value == 'Funny' then
            game:GetService("ReplicatedStorage").Events.PlayerChatted:FireServer(randomGenerate(math.random(4, 15)), false, false, true);
        end
    end
end)

runService.Stepped:Connect(function() 
    if Toggles.selfchamsz.Value then
        local material = Options.selfchamsz_material.Value

        for i, v in pairs(lplr.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.Transparency ~= 1 then
                v.Color = Options.selfchamsz_color.Value

                v.Material = material == "SmoothPlastic" and "SmoothPlastic" or material == "ForceField" and "ForceField" or material == "Neon" and "Neon"

                if v:IsA("UnionOperation") then
                    v.UsePartColor = true
                end

                if v:FindFirstChildOfClass("SpecialMesh") then
                    v:FindFirstChildOfClass("SpecialMesh").TextureId = material == "ForceField" and "rbxassetid://5558971297" or ""
                    v:FindFirstChildOfClass("SpecialMesh").VertexColor = Vector3.new(v.Color.R, v.Color.G, v.Color.B)
                end

                if v:IsA("MeshPart") then
                    v.TextureID = material == "ForceField" and "rbxassetid://5558971297" or ""
                end

                if v:FindFirstChildOfClass("Texture") then
                    v:FindFirstChildOfClass("Texture"):Destroy()
                end
            end
        end
    end


	if Options.skyboxtype.Value ~= "-" then
		local skyopt = Options.skyboxtype.Value
		local skybox = game.Lighting:FindFirstChild("$$$ skybox $$$") or Instance.new("Sky")
		skybox.Parent = game.Lighting
		skybox.Name = "$$$ skybox $$$"

		skybox.SkyboxBk = skyboxes[skyopt].SkyboxBk
		skybox.SkyboxDn = skyboxes[skyopt].SkyboxDn
		skybox.SkyboxFt = skyboxes[skyopt].SkyboxFt
		skybox.SkyboxLf = skyboxes[skyopt].SkyboxLf
		skybox.SkyboxRt = skyboxes[skyopt].SkyboxRt
		skybox.SkyboxUp = skyboxes[skyopt].SkyboxUp
    else
        if game.Lighting:FindFirstChild("$$$ skybox $$$") then
            game.Lighting:FindFirstChild("$$$ skybox $$$"):Destroy()
        end
    end	

local hb_x = Options.Hitbox_Expander_X.Value
local hb_y = Options.Hitbox_Expander_Y.Value
local hb_z = Options.Hitbox_Expander_Z.Value
    for i,v in pairs(game:GetService("Players"):GetPlayers()) do
        if v:IsA("Player") and v ~= game:GetService("Players").LocalPlayer and v.Character and Toggles.Hitbox_Expander.Value then
            v.Character:FindFirstChild("HeadHB").CanCollide = false
            v.Character:FindFirstChild("HeadHB").Transparency = 5
            v.Character:FindFirstChild("HeadHB").Size = Vector3.new(hb_x,hb_y,hb_z)

            v.Character:FindFirstChild("HumanoidRootPart").CanCollide = false
            v.Character:FindFirstChild("HumanoidRootPart").Transparency = 5
            v.Character:FindFirstChild("HumanoidRootPart").Size = Vector3.new(hb_x,hb_y,hb_z)
        end
    end 
end)

localPlayer.Additionals.TotalDamage:GetPropertyChangedSignal("Value"):Connect(function(val)
    if val == 0 then return end
    local coolrbxasset= "rbxassetid://"
    local hitsoundtoggle = Toggles.Hitsound.Value
    local hitsoundid = hitsounds[Options.hitsoundflag.Value]
    local soundEmptyy = soundid == ""
    local hitsoundvolume = Options.hitsoundvolume.Value
    hitsoundtoggle = soundEmptyy and "rbxassetid://6229978482" or hitsoundtoggle
    if hitsoundtoggle and val ~= 0 then
        local marker = Instance.new("Sound")
        marker.Parent = game:GetService("SoundService")
        marker.SoundId = ("rbxassetid://" .. hitsoundid)
        marker.Volume = (hitsoundvolume / 5)
        marker:Play()
    end
end)

local L_61_ = -3846999
local L_62_ = 8532252
local L_63_ = -1162714
local L_64_ = 52
local L_65_ = 4
local L_66_ = 82
function encodePos(L_946_arg0)
	local L_947_, L_948_, L_949_ = L_946_arg0.X * L_64_, L_946_arg0.Y * L_65_, L_946_arg0.Z * L_66_;
	return Vector3.new(L_61_ + L_947_, L_62_ + L_948_, L_63_ + L_949_)
end


local GetPlayers = game:GetService("Players")
local GetRS = game:GetService("ReplicatedStorage")
local Remote = GetRS.Events.HitPart
local GetMe = GetPlayers.LocalPlayer
local GetCamera = workspace.CurrentCamera
local RandomGuns = { "USP", "P2000", "Glock", "DualBerettas", "P250", "FiveSeven", "Tec9", "CZ", "DesertEagle", "R8" ,"MP9", "MAC10", "MP7", "UMP", "P90", "Bizon", "M4A4", "M4A1", "AK47", "Famas", "Galil", "AUG", "SG", "AWP", "Scout", "G3SG1","CT Knife" ,"T Knife", "Banana", "Bayonet", "Bearded Axe", "Butterfly Knife", "Cleaver", "Crowbar", "Falchion Knife", "Flip Knife", "Gut Knife", "Huntsman Knife", "Karambit", "Sickle"}  ---J. u fucking loser
 function FireTest(L_1145_arg0, L_1146_arg1, L_1147_arg2, L_1148_arg3, L_1149_arg4) 
	if GetCamera:FindFirstChild("Arms") and GetMe.Character then
		local L_1150_ = L_1145_arg0.CFrame.p
		Remote:FireServer(L_1145_arg0, L_1149_arg4 or encodePos(L_1145_arg0.Position + Vector3.new(0,0,0)), RandomGuns[math.random(20,#RandomGuns)], -6846846, nil, nil, 698547860949, Toggles.killAll_arg9.Value, Toggles.killAll_arg10.Value, Vector3.new(), -6985865461, Vector3.new(), false, nil, nil, nil, nil)
		end
     end
function fireHitpart(L_1145_arg0, L_1146_arg1, L_1147_arg2, L_1148_arg3, L_1149_arg4)
    Remote:FireServer(L_1145_arg0, L_1149_arg4 or encodePos(L_1145_arg0.Position + Vector3.new()), "Karambit", 0, localPlayer.Character.Gun, nil, 9999*999999999*9999, Toggles.killAll_arg9.Value, Toggles.killAll_arg10.Value, Vector3.new(), 0, Vector3.new(1, 0, 0), false, nil, nil, nil, nil)
end


runService.Heartbeat:Connect(function() -- cuz heartbeat faster!!!
    --CreateThread(function()
        if IsAlive(localPlayer) then
            if Toggles.KillAll.Value and localPlayer.Character:FindFirstChild("Gun") then -- nixus was here
                CreateThread(function()
                    for _, plr in pairs(game.Players:GetChildren()) do
                        if plr.Character and plr.Team ~= localPlayer.Team and IsAlive(plr) then
                            if Options.killAll_type.Value == 'ofc best' then
                            for i = 0,2 do
                                local oh1 = plr.Character.HumanoidRootPart
                                local oh1Position = oh1.Position
                                local oh2 = Vector3.new(oh1Position.X, oh1Position.Y, oh1Position.Z) * Vector3.new(L_64_, L_65_, L_66_) + Vector3.new(L_61_, L_62_, L_63_)
                                local oh3 = 'Karambit'
                                local oh4 = 0
                                local oh5 = nil
                                local oh6 = nil
                                local oh7 = 99999999999
                                local oh8 = Toggles.killAll_arg9.Value
                                local oh9 = Toggles.killAll_arg10.Value
                                local oh10 = Vector3.new()
                                local oh11 = 0
                                local oh12 = Vector3.new()
                                local oh13 = false
                                local oh14 = nil
                                local oh15 = nil
                                local oh16 = nil
                                local oh17 = nil
                                for i = 1,Options.killAll_hps.Value do
                                    game:GetService("ReplicatedStorage").Events.HitPart:FireServer(oh1, oh2, oh3, oh4, oh5, oh6, oh7, oh8, oh9, oh10, oh11, oh12, oh13, oh14, oh15, oh16, oh17)
                                end
                                end
                            elseif Options.killAll_type.Value == 'xosmane\'s' then -- самый лучший килл алл не согласен молчать
                                local oh1 = plr.Character.UpperTorso
                                local oh1Position = oh1.Position
                                local oh2 = Vector3.new(oh1Position.X, oh1Position.Y, oh1Position.Z) * Vector3.new(L_64_, L_65_, L_66_) + Vector3.new(L_61_, L_62_, L_63_)
                                local oh3 = "Crowbar"
                                local oh4 = math.random(72,928)
                                local oh5 = localPlayer.Character.Gun
                                local oh7 = 15
                                local oh8 = Toggles.killAll_arg9.Value
                                local oh9 = Toggles.killAll_arg10.Value
                                local oh10 = Vector3.new()
                                local oh11 = 916868
                                local oh12 = Vector3.new()
                                local oh13 = false
                                local oh14 = nil
                                local oh15 = nil
                                local oh16 = nil
                                local oh17 = nil
                                for i = 1,Options.killAll_hps.Value do
                                    game:GetService("ReplicatedStorage").Events.HitPart:FireServer(oh1, oh2, oh3, oh4, oh5, oh6, oh7, oh8, oh9, oh10, oh11, oh12, oh13, oh14, oh15, oh16, oh17)
                                end
                            elseif Options.killAll_type.Value == 'test' then
                                local oh1 = plr.Character.Head 
                                local oh2 = plr.Character.UpperTorso.CFrame.p + Vector3.new(0,0 / 0,0)
                                local oh3 = RandomGuns[math.random(20,#RandomGuns)] 
                                local oh8 = 9959459459047975683463 
                                local oh10 = Toggles.killAll_arg10.Value
                                for i = 1,Options.killAll_hps.Value, 2 do
                                    FireTest(plr.Character.Head, 5, false, true)
                                end 
                            elseif Options.killAll_type.Value == 'lio\'s old' then
                                local oh1 = plr.Character.Head
                                local oh1Position = oh1.Position
                                local oh2 = Vector3.new(oh1Position.X, oh1Position.Y, oh1Position.Z) * Vector3.new(L_64_, L_65_, L_66_) + Vector3.new(L_61_, L_62_, L_63_)
                                local oh3 = "Karambit"
                                local oh4 = -10 -- local oh4 = -250
                                local oh5 = "Karambit"
                                local oh7 = 100
                                local oh8 = Toggles.killAll_arg9.Value
                                local oh9 = Toggles.killAll_arg10.Value
                                local oh10 = Vector3.new()
                                local oh11 = -500
                                local oh12 = Vector3.new()
                                local oh13 = false
                                local oh14 = nil
                                local oh15 = nil
                                local oh16 = nil
                                local oh17 = nil
                                for i = 1,Options.killAll_hps.Value do
                                    game:GetService("ReplicatedStorage").Events.HitPart:FireServer(oh1, oh2, oh3, oh4, oh5, oh6, oh7, oh8, oh9, oh10, oh11, oh12, oh13, oh14, oh15, oh16, oh17)
                                end
                            end
                        end
                        end
                        end)
                    end
                end
            --end)
        end)
        RunService.RenderStepped:Connect(function(step)     
        if Toggles.hbbriker.Value and LocalPlayer.Character:FindFirstChild("UpperTorso") and LocalPlayer.Character:FindFirstChild("Gun") then  -- stix x infinity ?
            for _,Player in pairs(Players:GetPlayers()) do
                if Player.Character and Player.Team ~= LocalPlayer.Team and Player.Character:FindFirstChild('UpperTorso') then
                    local oh1 = Player.Character.Head
                    local oh2 = encodePos(oh1.Position)
                    local oh3 = 'Glock'
                    local oh4 = 8888
                    local oh5 = LocalPlayer.Character.Gun
                    local oh7 = 77765
                    local oh8 = false
                    local oh9 = true
                    local oh10 = Vector3.new()
                    local oh11 = 1
                    local oh12 = Vector3.new()
                    local oh13 = false
                    local oh14 = nil 
                    local oh15 = nil
                    local oh16 = nil
                    local oh17 = nil
                    game:GetService("ReplicatedStorage").Events.HitPart:FireServer(oh1, oh2, oh3, oh4, oh5, oh6, oh7, oh8, oh9, oh10, oh11, oh12, oh13, oh14, oh15, oh16, oh17)
                end
            end
        end
    end)
    runService.Heartbeat:Connect(function() 
        if Toggles.hbbriker.Value and LocalPlayer.Character:FindFirstChild('Gun') then
            for _,Player in pairs(Players:GetPlayers()) do
                CreateThread(function()
                                    if Player.Character and Player.Team ~= LocalPlayer.Team then
                                        local oh1 = Player.Character.Head
                                        local oh2 = encodePos(oh1.Position)
                                        local oh3 = 'Knives'
                                        local oh4 = 8888
                                        local oh5 = LocalPlayer.Character.Gun
                                        local oh7 = 77765
                                        local oh8 = false
                                        local oh9 = true
                                        local oh10 = Vector3.new()
                                        local oh11 = 1
                                        local oh12 = Vector3.new()
                                        local oh13 = false
                                        local oh14 = nil 
                                        local oh15 = nil
                                        local oh16 = nil
                                        local oh17 = nil
                                        for i = 0,2 do
                                        game:GetService("ReplicatedStorage").Events.HitPart:FireServer(oh1, oh2, oh3, oh4, oh5, oh6, oh7, oh8, oh9, oh10, oh11, oh12, oh13, oh14, oh15, oh16, oh17)
                                    end
                                end
                            end)
                                end
                            end    
                        end)

local TweenService = game:GetService("TweenService")
workspace.CurrentCamera.ChildAdded:Connect(function()    
if workspace.CurrentCamera:FindFirstChild("Arms") and Toggles.view_w_enabled.Value then
        for i, v in pairs(workspace.CurrentCamera.Arms:GetChildren()) do
            spawn(function()
            if v:IsA("BasePart") and not v.Name:find("Arm") and not (v.Name == "Flash") and v.Transparency ~= 1 then
                local transparencyValue = math.clamp(Options.view_w_trans.Value, 0, 99) / 100
                local transparencyStep = 0.01
                local minTransparency = 0
                local maxTransparency = 1
    
                local direction = 1
                local targetTransparency = maxTransparency
    
                if v:IsA("MeshPart") then
                    v.TextureID = Options.view_w_material.Value == "Ghost" and "rbxassetid://8133639623" or ""
                end
    
                if v:FindFirstChildOfClass("SpecialMesh") then
                    v:FindFirstChildOfClass("SpecialMesh").TextureId = Options.view_w_material.Value == "Ghost" and "rbxassetid://8133639623" or ""
                end
    
    
                v.Reflectance = Options.view_w_ref.Value
                v.Color = Options.view_w_color.Value
                v.Material = Options.view_w_material.Value == "Ghost" and "ForceField" or Options.view_w_material.Value
                local tweendb = false
                local tweenspeed = 100/Options.view_w_speed.Value
                repeat 
                    task.wait()
                    tweendb = not tweendb
                    local transparencyTween = TweenService:Create(v, TweenInfo.new(tweenspeed), { Transparency = tweendb and 1 or 0 })
                    transparencyTween:Play()
                    task.wait(tweenspeed - 0.1)
                until not workspace.CurrentCamera:FindFirstChild("Arms") 
            elseif v.Name == "HumanoidRootPart" then
                v.Transparency = 1
            end
        end)
    end
end
end)

ping = math.round(game.Stats.PerformanceStats.Ping:GetValue())
function getDamage(hit, plr, dmgmod)

    if isAlive(lplr) and typeof(hit) == "table" and client.gun ~= nil and client.gun:FindFirstChild("DMG") and getDamageMultiplier(hit[1]) ~= nil then
        local dmg = client.gun.DMG.Value * getDamageMultiplier(hit[1]) * (dmgmod or 1)
        if plr:FindFirstChild("Kevlar") then
            dmg = (dmg * 0.01) * client.gun.ArmorPenetration.Value
        end
        dmg = dmg * (client.gun.RangeModifier.Value * 0.01 ^ ((lplr.Character.HumanoidRootPart.Position - hit[2]).Magnitude*0.002)) * 0.01
        return dmg
    end
    return 0
end

runService.Stepped:Connect(function()
    ragebot_target = nil

    if isAlive(lplr) then

        if Toggles.bunny_enabled.Value and uis:IsKeyDown("Space")then
            if lplr.Character:FindFirstChild("jumpcd") then
                lplr.Character.jumpcd:Destroy()
            end
          --  lplr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)

            local vel = Vector3.zero

            if uis:IsKeyDown("W") then
                vel = vel + workspace.CurrentCamera.CFrame.LookVector
            end
            if uis:IsKeyDown("S") then
                vel = vel - workspace.CurrentCamera.CFrame.LookVector
            end
            if uis:IsKeyDown("A") then
                vel = vel - workspace.CurrentCamera.CFrame.RightVector
            end
            if uis:IsKeyDown("D") then
                vel = vel + workspace.CurrentCamera.CFrame.RightVector
            end

            if vel.Magnitude > 0 then
                vel = Vector3.new(vel.X, 0, vel.Z)
                lplr.Character.HumanoidRootPart.Velocity = (vel.Unit * (Options.SpeedValue.Value * 1.5)) + Vector3.new(0, lplr.Character.HumanoidRootPart.Velocity.Y, 0) -- 1
                lplr.Character.Humanoid.Jump = true
            end
        end
if camera:FindFirstChild("Arms") ~= nil then -- zaebalsya poka "pastil" daaaa
		if Toggles.v_arms.Value then 
			for i, v in pairs(camera.Arms:GetChildren()) do
				if v:IsA("Model") and v:FindFirstChild("Left Arm") and v:FindFirstChild("Right Arm") and Toggles.v_arms.Value then
					local RightArm = v["Right Arm"]
					local LeftArm = v["Left Arm"]
					local RightGlove = RightArm:FindFirstChild("Glove") or RightArm:FindFirstChild("RGlove")
					local LeftGlove = LeftArm:FindFirstChild("Glove") or LeftArm:FindFirstChild("LGlove")
					local RightSleeve = RightArm:FindFirstChild("Sleeve") or nil
					local LeftSleeve = LeftArm:FindFirstChild("Sleeve") or nil
					RightArm.Transparency = Options.v_arms_transparency.Value / 100
					RightArm.Reflectance = 0
                    RightArm.Material = "ForceField"
                    RightArm.Mesh.TextureId = "5830615971" -- or add dropdown of id's
					RightArm.Color = Color3.new(0,0,0)
					LeftArm.Transparency = Options.v_arms_transparency.Value / 100
					LeftArm.Reflectance = 0
                    LeftArm.Material = "ForceField"
                    LeftArm.Mesh.TextureId = "5830615971"
					LeftArm.Color = Color3.new(0,0,0)
					RightGlove.Transparency = Options.v_arms_transparency.Value / 100
					RightGlove.Reflectance = 0
                    RightGlove.Material = "ForceField"
                    RightGlove.Mesh.TextureId = "5830615971"
					RightGlove.Color = Color3.new(0,0,0)
					LeftGlove.Transparency = Options.v_arms_transparency.Value / 100
					LeftGlove.Reflectance = 0
                    LeftGlove.Material = "ForceField"
					LeftGlove.Mesh.TextureId = "5830615971"
					LeftGlove.Color = Color3.new(0,0,0)
					if Toggles.v_hide_gloves.Value then
						RightGlove.Transparency = 1
						LeftGlove.Transparency = 1
					end
					if RightSleeve and LeftSleeve then
						RightSleeve.Transparency = Options.v_arms_transparency.Value / 100
						RightSleeve.Reflectance = 0
                        RightSleeve.Material = "ForceField"
                        RightSleeve.Mesh.TextureId = "5830615971"
						RightSleeve.Color = Color3.new(0,0,0)
						LeftSleeve.Transparency = Options.v_arms_transparency.Value / 100
						LeftSleeve.Reflectance = 0
                        LeftSleeve.Material = "ForceField"
                        LeftSleeve.Mesh.TextureId = "5830615971"
						LeftSleeve.Color = Color3.new(0,0,0)
						if Toggles.v_hide_sleeves.Value then
							RightSleeve.Transparency = 1
							LeftSleeve.Transparency = 1
						end
					end
				end
			end
		end
    end

if Toggles.Third_Person.Value and Options.Third_Bind:GetState() then
            workspace.ThirdPerson.Value = true
            if lplr.CameraMinZoomDistance ~= Options.Third_Distance.Value then
				lplr.CameraMinZoomDistance = Options.Third_Distance.Value
				lplr.CameraMaxZoomDistance = Options.Third_Distance.Value
			end
        else
            workspace.ThirdPerson.Value = false
            if lplr.CameraMinZoomDistance ~= 0 then
				lplr.CameraMinZoomDistance = 0
				lplr.CameraMaxZoomDistance = 0
			end
        end

    for _, plr in pairs(plrs:GetPlayers()) do
            if isAlive(plr) then
                if frames_stuff[plr] == nil then
                    frames_stuff[plr] = {}
                end
                frames_stuff[plr][#frames_stuff[plr] + 1] = plr.Character.HumanoidRootPart.Position
            end

            if Toggles.rage_enabled.Value and Options.Aimbotkey:GetState() and isTarget(plr, Toggles.rage_teammet.Value) and typeof(client.gun) == "Instance" and client.gun:FindFirstChild("Penetration") and not client.DISABLED and not client.gun:FindFirstChild("Melee") and client.gun.Name ~= "C4" then
                local ignore = {workspace.Ray_Ignore, lplr.Character, r6_dummy, workspace.Debris, workspace.CurrentCamera}
                local multipoints = Options.Rage_Points.Value -- 1
                
                local hitboxes = {}
                local ebaniy_hitboksy = {"Head", "Torso"} 
                for i, v in next, (ebaniy_hitboksy) do -- 1
                    if v == "Head" then
                        table.insert(hitboxes, (function(a)
                            return multipoints == "Normal" and {a, scan(a)} or multipoints == "Multi" and {a, scan_advanced(a)} or {a, {a.Position}}
                        end)(plr.Character.Head))
                    elseif v == "Torso" then
                        table.insert(hitboxes, (function(a)
                            return multipoints == "Normal" and {a, scan(a)} or multipoints == "Multi" and {a, scan_advanced(a)} or {a, {a.Position}}
                        end)(plr.Character.UpperTorso))
                        table.insert(hitboxes, (function(a)
                            return multipoints == "Normal" and {a, scan(a)} or multipoints == "Multi" and {a, scan_advanced(a)} or {a, {a.Position}}
                        end)(plr.Character.LowerTorso))
                    elseif v == "Arms" then
                        table.insert(hitboxes, (function(a)
                            return multipoints == "Normal" and {a, scan(a)} or multipoints == "Multi" and {a, scan_advanced(a)} or {a, {a.Position}}
                        end)(plr.Character.LeftUpperArm))
                        table.insert(hitboxes, (function(a)
                            return multipoints == "Normal" and {a, scan(a)} or multipoints == "Multi" and {a, scan_advanced(a)} or {a, {a.Position}}
                        end)(plr.Character.LeftLowerArm))
                        table.insert(hitboxes, (function(a)
                            return multipoints == "Normal" and {a, scan(a)} or multipoints == "Multi" and {a, scan_advanced(a)} or {a, {a.Position}}
                        end)(plr.Character.LeftHand))
                        --
                        table.insert(hitboxes, (function(a)
                            return multipoints == "Normal" and {a, scan(a)} or multipoints == "Multi" and {a, scan_advanced(a)} or {a, {a.Position}}
                        end)(plr.Character.RightUpperArm))
                        table.insert(hitboxes, (function(a)
                            return multipoints == "Normal" and {a, scan(a)} or multipoints == "Multi" and {a, scan_advanced(a)} or {a, {a.Position}}
                        end)(plr.Character.RightLowerArm))
                        table.insert(hitboxes, (function(a)
                            return multipoints == "Normal" and {a, scan(a)} or multipoints == "Multi" and {a, scan_advanced(a)} or {a, {a.Position}}
                        end)(plr.Character.RightHand))
                    elseif v == "Legs" then
                        table.insert(hitboxes, (function(a)
                            return multipoints == "Normal" and {a, scan(a)} or multipoints == "Multi" and {a, scan_advanced(a)} or {a, {a.Position}}
                        end)(plr.Character.LeftUpperLeg))
                        table.insert(hitboxes, (function(a)
                            return multipoints == "Normal" and {a, scan(a)} or multipoints == "Multi" and {a, scan_advanced(a)} or {a, {a.Position}}
                        end)(plr.Character.LeftLowerLeg))
                        table.insert(hitboxes, (function(a)
                            return multipoints == "Normal" and {a, scan(a)} or multipoints == "Multi" and {a, scan_advanced(a)} or {a, {a.Position}}
                        end)(plr.Character.LeftFoot))
                        --
                        table.insert(hitboxes, (function(a)
                            return multipoints == "Normal" and {a, scan(a)} or multipoints == "Multi" and {a, scan_advanced(a)} or {a, {a.Position}}
                        end)(plr.Character.RightUpperLeg))
                        table.insert(hitboxes, (function(a)
                            return multipoints == "Normal" and {a, scan(a)} or multipoints == "Multi" and {a, scan_advanced(a)} or {a, {a.Position}}
                        end)(plr.Character.RightLowerLeg))
                        table.insert(hitboxes, (function(a)
                            return multipoints == "Normal" and {a, scan(a)} or multipoints == "Multi" and {a, scan_advanced(a)} or {a, {a.Position}}
                        end)(plr.Character.RightFoot))
                    end
                end


                if Toggles.rage_fwt.Value and Options.fwt_mode.Value == "old" then -- 1
                    local part = ftfolder:FindFirstChild(plr.Name)
                    if part == nil then
                        part = Instance.new("Part", ftfolder)
                        part.Size = Vector3.new(4, 4, 3)
                        part.CanCollide = false
                        part.Anchored = true
                        part.Name = plr.Name
                        part.Transparency = 0.9
                    end
                    part.CFrame = plr.Character.HumanoidRootPart.CFrame + (plr.Character.HumanoidRootPart.CFrame.LookVector * (Options.rage_fwtAmount.Value *3)) 
                    table.insert(hitboxes, (function(a)
                        return multipoints == "Normal" and {a, scan(a)} or multipoints == "Multi" and {a, scan_advanced(a)} or {a, {a.Position}}
                    end)(part))
                elseif Toggles.rage_fwt.Value and Options.fwt_mode.Value == "new" then
                    local part = ftfolder:FindFirstChild(plr.Name)
                    if part == nil then
                        part = Instance.new("Part", ftfolder)
                        part.Size = Vector3.new(1, 2, 2)
                        part.CanCollide = false
                        part.Anchored = true
                        part.Name = plr.Name
                        part.Transparency = 1
                        local highlight = Instance.new("BoxHandleAdornment")
                        highlight.Name = "Highlight"
                        highlight.Size = part.Size
                        highlight.AlwaysOnTop = true
                        highlight.ZIndex = 10
                        highlight.Adornee = part
                          if Toggles.rage_fwt_vis.Value then
                                highlight.Transparency = 0.3
                            else
                                highlight.Transparency = 1
                            end
                            highlight.Color3 = Options.fwt_vis_color.Value
                            highlight.Parent = part
                           end

                    local fwtam = Options.rage_fwtAmount.Value
                    local playerpos = plr.Character.HumanoidRootPart.Position
                    local playervel = plr.Character.HumanoidRootPart.Velocity
                    local resultspeed = playervel.Magnitude

                    if resultspeed > 0.15 then 
                        local exst_time = fwtam

                        local prepos = playerpos + playervel * exst_time
                        local exst_pos = prepos + playervel * exst_time

                        local raycast_params = RaycastParams.new()
                        raycast_params.FilterDescendantsInstances = {plr.Character}

                        local finish = workspace:Raycast(playerpos, (exst_pos - playerpos).Unit * 2, raycast_params)

                        if finish then 
                            exst_pos = finish.Position
                        end
                        part.CFrame = CFrame.new(exst_pos)

                    end

                    table.insert(hitboxes, (function(a)
                        return multipoints == "Normal" and {a, scan(a)} or multipoints == "Multi" and {a, scan_advanced(a)} or {a, {a.Position}}
                    end)(part))
                end
                if #frames_stuff[plr] >= Options.rage_backtrack.Value then
                    local part = btfolder:FindFirstChild(plr.Name)
                      task.synchronize()
                    if part == nil then
                        part = Instance.new("Part", btfolder)
                        part.Size = Vector3.new(3, 4, 4)
                        part.CanCollide = false
                        part.Anchored = true
                        part.Name = plr.Name
                        part.Transparency = 1

                        local highlight = Instance.new("BoxHandleAdornment")
                        highlight.Name = "Highlight"
                        highlight.Size = Vector3.new(3,2,2)
                        highlight.AlwaysOnTop = true
                        highlight.ZIndex = 10
                        highlight.Adornee = part
                        if Toggles.rage_backtrack_vis.Value then
                            highlight.Transparency = 0.3
                        else
                            highlight.Transparency = 1
                        end
                        highlight.Color3 = Options.bt_vis_color.Value
                        highlight.Parent = part
                       end

                        part.CFrame = CFrame.new(frames_stuff[plr][#frames_stuff[plr] - Options.rage_backtrack.Value])
                        CreateThread(function()
                        table.insert(hitboxes, (function(a)
                            return multipoints == "Normal" and {a, scan(a)} or multipoints == "Multi" and {a, scan_advanced(a)} or {a, {a.Position}}
                        end)(part))
                        end)
                    end


              local origin = lplr.Character.HumanoidRootPart.Position + Vector3.new(0, 2.5, 0)

            for _, v in pairs(hitboxes) do
                    if ragebot_target ~= nil then break end
                    for _, v2 in next, v[2] do
                        if ragebot_target ~= nil then break end
                      local ray = Ray.new(origin, (v2 - origin).Unit * (v2 - origin).Magnitude)
    
                        local raydata = {workspace:FindPartOnRayWithIgnoreList(ray, ignore, false, true)}

                        -- local penetration = client.gun.Penetration.Value / (100 / library.flags["rage_mod"]) -- 1

                        local penetration = client.gun.Penetration.Value * 0.01

                        local dmgmod = nil

                   if raydata[1] and raydata[1].Parent and raydata[1].Parent == plr.Character or raydata[1].Parent == ftfolder or raydata[1].Parent == btfolder then
                            ragebot_wallbang = true
                            ragebot_target = {v[1], v2}
                        else
                            if Toggles.rage_autowall.Value then --1
                                local temphits, newraydata = {}, {}
                                local temphit

                                repeat
                                    newraydata = {workspace:FindPartOnRayWithIgnoreList(ray, ignore, true, faalse)}
                                    if newraydata[1] and newraydata[1].Parent then
                                        if newraydata[1].Parent == plr.Character or newraydata[1].Parent == ftfolder or newraydata[1].Parent == btfolder then
                                            temphit = newraydata[1]
                                        else
                                            table.insert(ignore, newraydata[1])
                                            table.insert(temphits, newraydata)
                                        end
                                    end
                                until temphit ~= nil or #temphits > 0 or newraydata[1] == nil

                                if temphit and getDamageMultiplier(temphit) ~= nil then
                                    local limit = 0
                                    for i, v in pairs(temphits) do
                                        local mod2 = 1

                                        local formod = {
                                           function(p) return string.split(tostring(p.Material), ".")[1] == "DiamondPlate" and -5 end,
                                                function(p) return table.find({"CorrodedMetal", "Metal", "Concrete", "Brick"}, string.split(tostring(p.Material), ".")[1]) ~= nil and -5 end,
                                                function(p) return table.find({"Wood", "WoodPlanks"}, string.split(tostring(p.Material), ".")[1]) or p.Name == "Grate" and -5 end,
                                                 function(p) return p.Name == "nowallbang" and -5 or p:FindFirstChild("PartModifier") and tonumber(p.PartModifier.Value) or 0 end,
                                                 function(p) return p.Transparency == 1 or not p.CanCollide or p.Name == "Glass" or p.Name == "Capboard" and 0 end
                                        }

                                        for _, v2 in pairs(formod) do
                                            mod2 = v2(v[1]) or mod2
                                        end


                                        local dir = (v[1].Position - v[2]).Unit * math.clamp(client.gun.Range.Value, math.huge)
                                        
                                        if Options.awhitscan_met.Value == "new" then 
                                            ray2 = Ray.new(v[2] + Vector3.new(math.cos(tick() * (awspeedscan*10)) * (dir/2 + awaddpoints/100), math.sin(tick() * (awspeedscan*10)) * (dir/2 + awaddpoints/100), math.sin(tick() * (awspeedscan*10)) * (dir/2 + awaddpoints/100)), dir * -2)
                                            else
                                            ray2 = Ray.new(v[2] + dir)
                                        end

                                        local _, temppos = workspace:FindPartOnRayWithWhitelist(ray2, {v[1]}, true)
                                        if temppos then
                                            pcall(function()
                                                limit = math.min(penetration, limit + ((temppos - v[2]).Magnitude * mod2))
                                            end)
                                            dmgmod = 0 - limit / penetration
                                        end
                                    end

                                    ragebot_wallbang = true
                                    ragebot_target = {v[1], v2}
                                    end
                                end
                        end
                        if ragebot_target and getDamage(ragebot_target, plr, dmgmod) >= 1 then
                            if Toggles.rage_autofire.Value then -- 1
                            	if Toggles.custom_tap.Value then 
				                for i = 1, Options.custom_hpr.Value, 1 do
				                   client.firebullet()
				                  end
				                else
				              client.firebullet()
				              end
                            end
                        end
                    end
                end
            end
        end

local dahuya = math.huge
        if Toggles.NoRecoil.Value and IsAlive(localPlayer) then
             local lplr = game.Players.LocalPlayer
             local client = getsenv(lplr.PlayerGui.Client)
             client.accuracy_sd = 0
        else
             client.accuracy_sd = 0.001
        end
    end
end)

runService.PreRender:Connect(function()
    if game.Workspace:WaitForChild("Status"):WaitForChild("RoundOver").Value == true then -- cleaning shes pussy
        ftfolder:ClearAllChildren()
        btfolder:ClearAllChildren()
        othershit:ClearAllChildren()
    end
end)
runService.Heartbeat:Connect(function()
local hackspeed = Options.WalkValue.Value
local enabled = Toggles.MovementHack.Value
    if IsAlive(lplr) then
        if enabled and Options.Walk_Bind:GetState() then
            local angle = -1
            if uis:IsKeyDown("W") then angle = 0 end
            if uis:IsKeyDown("A") then angle = 90 end 
            if uis:IsKeyDown("S") then angle = 180 end 
            if uis:IsKeyDown("D") then angle = 270 end 
            if uis:IsKeyDown("A") and uis:IsKeyDown("W") then angle = 45 end 
            if uis:IsKeyDown("D") and uis:IsKeyDown("W") then angle = 315 end 
            if uis:IsKeyDown("D") and uis:IsKeyDown("S") then angle = 225 end 
            if uis:IsKeyDown("A") and uis:IsKeyDown("S") then angle = 145 end

            if angle > -1 then
                local x, y, z = workspace.CurrentCamera.CFrame:ToOrientation()
                local cam_cf = CFrame.new(workspace.CurrentCamera.CFrame.p) * CFrame.Angles(0, y, z)

                angle = cam_cf * CFrame.Angles(0, math.rad(angle), 0)

                lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + Vector3.new(angle.LookVector.X, 0, angle.LookVector.Z) * (hackspeed / 30)
            end
        end
    end  
end)

runService.Heartbeat:Connect(function()
    if Toggles.InfCash.Value then
        game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Text = 'PutinWare'
        game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Font = 'Code'
        lplr.Cash.Value = 2^33
    end
    if Toggles.InfAmmo.Value then 
        game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Text = 'Russian'
        game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Text = 'Ware'
               for i = 1, 4 do
           setupvalue(client.countammo, 4+i, 878787) -- а у никсуса инф аммо через раз работает (патамушта он россия)
         end
      --  end
        end
        if Toggles.radio_disable.Value then 
            GetMe.PlayerGui.GUI.SuitZoom.Visible = false
        end
        if Toggles.FlyHack.Value and IsAlive(localPlayer)and Options.FlyHackKeypicker:GetState() then
            spawn(function()
                local FlySpeed = Options.SpeedForFly.Value
                local velocity = Vector3.new(0,1,0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    velocity = velocity + (camera.CoordinateFrame.lookVector * FlySpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    velocity = velocity + (camera.CoordinateFrame.rightVector * -FlySpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    velocity = velocity + (camera.CoordinateFrame.lookVector * -FlySpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    velocity = velocity + (camera.CoordinateFrame.rightVector * FlySpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    velocity = velocity + (Vector3.new(0, 0.5 ,0) * FlySpeed)
                end
    
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    velocity = velocity + (Vector3.new(0, -0.5 ,0) * FlySpeed)
                end
    
                localPlayer.Character.HumanoidRootPart.Velocity = velocity
                localPlayer.Character.Humanoid.PlatformStand = true
            end)
        elseif IsAlive(localPlayer) then 
            localPlayer.Character.Humanoid.PlatformStand = false
        end
end)

local r6_dummy = game:GetObjects("rbxassetid://9474737816")[1]
		-- // head settings 
		r6_dummy.Head.Face:Destroy()
		r6_dummy.Head.Size = Vector3.new(2,0.8,1)
		r6_dummy.Head.Transparency = 1
	   
		
		-- // Arms
		r6_dummy:FindFirstChild("Left Arm").Transparency = 1
		r6_dummy:FindFirstChild("Right Arm").Transparency = 1
		
		
		for i, v in pairs(r6_dummy:GetChildren()) do
		   v.Material = "ForceField"
		   v.CanCollide = false
		   v.Anchored = false
		end

local charmanipulation = {
    var1 = false
}

local charmanipulation_stuff2 = {frames = {}, mode = "default"}
   
	   function charmanipulation_stuff2:GetOrigin()
		   return charmanipulation_stuff2["origin"] or CFrame.new()
	   end
   
	   function charmanipulation_stuff2:SetOrigin(new)
		   charmanipulation_stuff2["origin"] = new
	   end 
		   
	   function charmanipulation_stuff2.step(a, origin)
	   frames = charmanipulation_stuff2.frames
   
	   if IsAlive(lplr) then
		   frames[#frames + 1] = origin
   
		   if charmanipulation_stuff2["mode"] == "default" then
			   if frames[#frames - a] ~= nil then
				   charmanipulation_stuff2:SetOrigin(frames[#frames - a])
			   else
				   charmanipulation_stuff2:SetOrigin(frames[#frames])
			   end
		   end
	   end
	   end
	   local exclude = {
		var1 = false
	}
	
	local flingthink = {}
	
	local fake_pos = {frames = {}, mode = "default"}
	   
	function fake_pos:Get_Fake_Pos()
		return fake_pos["origin"] or CFrame.new()
	end
	   
	function fake_pos:Set_Fake_Pos(new)
		fake_pos["origin"] = new
	end 
			   
	function fake_pos.run(a, origin)
		frames = fake_pos.frames
		if IsAlive(lplr) then
			frames[#frames + 1] = origin
			if fake_pos["mode"] == "default" then
				if frames[#frames - a] ~= nil then
						fake_pos:Set_Fake_Pos(frames[#frames - a])
					else
						fake_pos:Set_Fake_Pos(frames[#frames])
					end
				end
			end
		end
		   utility:Connect(rs.Heartbeat, function()
	
			local usedesyncfling = Toggles.desync_fling.Value
			local targetstrafeoffset = Options.Target_Offset.Value
			local targetstrafespeed = Options.Target_Speed.Value
			local selecttarget = Options.targetplrselected.Value
			local flingmodeselect = Options.desync_mode_fling.Value
			local multifling = Toggles.desync_fling_multi_mode
	
	
			if IsAlive(lplr) then
				if Toggles.desync_enabled.Value and not exclude["var1"] then
						exclude[1] = lplr.Character.HumanoidRootPart.CFrame
							local hrpcframeclone 
							if usedesyncfling then
								hrpcframeclone = lplr.Character.HumanoidRootPart.CFrame
							else
								hrpcframeclone = fake_pos:Get_Fake_Pos()
							end
	
							exclude[1] = lplr.Character.HumanoidRootPart.CFrame
							if usedesyncfling then
								exclude[2] = lplr.Character.HumanoidRootPart.Velocity
							end
	
	
						if Options.delay_type.Value == 'Offset' and not usedesyncfling then
							fake_pos.run(Options.desync_delay_x.Value, lplr.Character.HumanoidRootPart.CFrame)
						elseif Options.delay_type.Value == 'Random' and not usedesyncfling then
							fake_pos.run(math.random(Options.desync_delay_x.Value,Options.desync_delay_min.Value), lplr.Character.HumanoidRootPart.CFrame)
						elseif Options.delay_type.Value == 'Server Pos' and not usedesyncfling then
							fake_pos.run(-5, lplr.Character.HumanoidRootPart.CFrame)
						end
	
	
						if Options.desync_mode.Value == "Invisible" then
						hrpcframeclone = CFrame.new()
						end
						if Options.desync_mode.Value == "Random" then
						hrpcframeclone = hrpcframeclone * CFrame.new(math.random(999e999, 9999e9999), math.random(999e999, 9999e9999), math.random(999e999, 9999e9999))
						end
						if Options.desync_mode.Value == "Target" and game.Players:FindFirstChild(selecttarget) and IsAlive(game.Players[selecttarget]) then
							hrpcframeclone = game.Players[selecttarget].Character.HumanoidRootPart.CFrame
						if not exclude[3] then
							exclude[3] = 0
						end
						if exclude[3] > 360 then
							exclude[3] = 0
						end
						hrpcframeclone = hrpcframeclone * CFrame.Angles(0, math.rad(exclude[3]), 0) * CFrame.new(0, 0, targetstrafeoffset)
						exclude[3] = exclude[3] + targetstrafespeed
					end
	
						lplr.Character.HumanoidRootPart.CFrame = hrpcframeclone
						exclude["var1"] = true
						if Toggles.desync_visualizer.Value then
							r6_dummy.Parent = workspace
							r6_dummy:SetPrimaryPartCFrame(hrpcframeclone)
						else
							r6_dummy.Parent = nil
						end
						lplr.Character.HumanoidRootPart.CFrame = hrpcframeclone
						if usedesyncfling then
							if flingmodeselect == "Positive" then
								lplr.Character.HumanoidRootPart.Velocity = Vector3.new(1, 1, 1) * (2^99)
							elseif flingmodeselect == "Negative" then 
								lplr.Character.HumanoidRootPart.Velocity = Vector3.new(1, 1, 1) * (-2^99)
							elseif flingmodeselect == "NaN" then 
								lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0/0, 0/0, 0/0) * (0/0)
							end
						end 
	
						rs.renderStepped:Wait()
	
						lplr.Character.HumanoidRootPart.CFrame = exclude[1]
						if usedesyncfling then
							lplr.Character.HumanoidRootPart.Velocity = exclude[2]
						end
					else
						if r6_dummy.Parent ~= nil then
						r6_dummy.Parent = nil
					end
				end
			end
		end)
		utility:BindToRenderStep("desync_1", 1, function()       
            if exclude[1] and exclude["var1"] and IsAlive(lplr) then                
                lplr.Character.HumanoidRootPart.CFrame = exclude[1]         
                exclude["var1"] = false           
            end    
        end)
	

local oldNamecall

oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
        local method = getnamecallmethod()

        if method == "FindPartOnRayWithIgnoreList" and args[2][1] == workspace.Debris then
            if ragebot_target ~= nil and Toggles.rage_enabled.Value and Options.Aimbotkey:GetState() then
                local origin = lplr.Character.HumanoidRootPart.Position + Vector3.new(0, 2.5, 0)
                if ragebot_target[1].Parent == ftfolder then
                    ragebot_target[2] = plrs[ragebot_target[1].Name].Character.Head.Position
                end
              if ragebot_target[1].Parent == btfolder then
                    ragebot_target[2] = plrs[ragebot_target[1].Name].Character.Head.Position
                end
                if ragebot_target[1].Parent == othershit then
                    ragebot_target[2] = plrs[ragebot_target[1].Name].Character.Head.Position
                end
                table.insert(args[2], workspace.Map)
                args[1] = Ray.new(origin, (ragebot_target[2] - origin).Unit * (ragebot_target[2] - origin).Magnitude)
        end 

    return oldNamecall(self, unpack(args))
end
return oldNamecall(self, ...)
end)

local HitPart = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("HitPart")
local namecall

namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    local method = getnamecallmethod():lower()
    local oh1, oh2, oh3, oh4, oh5, oh6, oh7, oh8, oh9, oh10, oh11, oh12, oh13, oh14, oh15, oh16, oh17 = ...
    if self == HitPart and method == "fireserver" and Toggles.HuiPart.Value then
        oh2 = not Toggles.NaN_Predict.Value and oh2 or oh2 + Vector3.new()
        oh3 = not Toggles.Custom_Gun.Value and Client.gun.Name or Options.killgun.Value
        oh4 = -4000
        oh5 = nil
        oh6 = nil
        oh7 = not Toggles.infinity_damage.Value and 1 or 999e999 -- getgenv().varyshkas
        oh8 = not Toggles.rbm_oh.Value and false or true
        oh9 = not Toggles.wallbang_oh.Value and false or true
        oh10 = Vector3.new()
        oh11 = -85428592
        oh12 = Vector3.new()
        oh13 = false
        oh14 = nil
        oh15 = nil
        oh16 = nil
        oh17 = nil
        return namecall(self, oh1, oh2, oh3, oh4, oh5, oh6, oh7, oh8, oh9, oh10, oh11, oh12, oh13, oh14, oh15, oh16, oh17)
    end
    return namecall(self, ...)
end)

local hook2
hook2 = hookmetamethod(game, "__namecall" ,function(self,...)
    local args = {...}
    local methh = getnamecallmethod()

    if methh == "FireServer" and self.Name == "UpdatePing" then
       if Toggles.Ping_Spoof.Value then 
          args[1] =  math.random(Options.Ping_Value.Value, Options.PingValue.Value) / 1000
       end
       return hook2(self,unpack(args))
    end

    return hook2(self,...)
end)

local hook
hook = hookmetamethod(game, "__namecall" ,function(self,...)
    local args = {...}
    local methh = getnamecallmethod()

    if methh == "FireServer" and self.Name == "ReplicateCamera" then
       if Toggles.Anti_Camera.Value then 
          args[1] =  CFrame.new(math.random(999e999, 9999e9999), math.random(999e999, 9999e9999), math.random(999e999, 9999e9999))
       end
       return hook(self,unpack(args))
    end

    return hook(self,...)
end)


local hookserv
hookserv = hookmetamethod(game, "__namecall", function(self,...)
    local args = {...}
    local hookmethod = getnamecallmethod()   
		if hookmethod == "InvokeServer" then
			if self.Name == "Filter" and Toggles.RemoveFilter.Value then
			return args[1]
		end
		return hookserv(self,unpack(args))
    end
    return hookserv(self,...)
end)

local visualsilentangle
local speed = Options.Speed_angle.Value / 10
local last = tick()
RunService.RenderStepped:Connect(function()
	if ragebot_target then
		visualsilentangle = ragebot_target.Position
		last = tick()
	else
		if tick() - last > speed then
			visualsilentangle = nil
		end
	end
end)

local def 
def = hookmetamethod(game, "__namecall", function(self,...)
    local args = {...}
    local meth = getnamecallmethod()

    if meth == "SetPrimaryPartCFrame" and self.Name == "Arms" then
       if Toggles.Third_Person.Value and Options.Third_Bind:GetState() then 
          args[1] =  CFrame.new(99,99,9e9)
       end
       if Toggles.enable_viewmodels.Value then
        args[1] = args[1] * CFrame.new(math.rad(Options.vm_X.Value), math.rad(Options.vm_Y.Value), math.rad(Options.vm_Z.Value)) * CFrame.Angles(0, 0, math.rad(Options.vm_roll.Value))
    end
       if Toggles.VizSilentAngle.Value and ragebot_target then
        args[1] = CFrame.lookAt(args[1].p, visualsilentangle) 
      end
       return def(self,unpack(args))
    end

    return def(self,...)
end)

local oldIndex
oldIndex = hookfunc(getrawmetatable(game.Players.LocalPlayer.PlayerGui.Client).__index, newcclosure(function(self, idx)
    if idx == "Value" then
        if self.Name == "Auto" and Toggles.Auto.Value then
            return true
        elseif self.Name == "FireRate" and Toggles.FireRate.Value then
            return 0.01 * Options.FireRateValue.Value
        elseif self.Name == "Range" and Toggles.Range.Value then
            return 9999
        elseif self.Name == "RangeModifier" and Toggles.Range.Value then
            return 100
        elseif self.Name == "BuyTime" and Toggles.ShopInfTimeAndAnywhere.Value then
            return 45
        end
    end

    return oldIndex(self, idx)
end))

local oldIndex33
oldIndex33 = hookmetamethod(game, "__index", newcclosure(function(self, key)
        if not checkcaller() then
            if key == "Velocity" and self.Parent == game.Players.LocalPlayer.Character then
                return Vector3.zero
         end
    end
    return oldIndex33(self, key)
end))
-- Misc Code end]

-- Exploits Code [start
--[[ runService.RenderStepped:Connect(function()
    if Toggles.AntiFall.Value then 
    end
end) ]]
-- Exploits Code end]

-- Visuals Code [start
Toggles.desync_enabled:OnChanged(function(val)
    runService.Stepped:Connect(function()
        for i, v in pairs(r6_dummy:GetChildren()) do
            if v:IsA("BasePart") then
                v.Color = Options.desync_visualizer.Value;
            end
        end
    end)
end)
Toggles.esp_enabled:OnChanged(function(val) esp.enabled = val end)
Toggles.esp_box:OnChanged(function(val) esp.box[1] = val end)
Options.esp_boxColor:OnChanged(function(val) esp.box[2] = val end)
Toggles.esp_boxFill:OnChanged(function(val) esp.boxfill[1] = val end)
Options.esp_boxFillColor:OnChanged(function(val) esp.boxfill[2] = val end)
Toggles.esp_health:OnChanged(function(val) esp.barlayout.health.enabled = val end)
Options.esp_barColor:OnChanged(function(val) esp.barlayout.health.color2 = val end)
Options.esp_barColor2:OnChanged(function(val) esp.barlayout.health.color1 = val end)
Toggles.esp_chams:OnChanged(function(val) esp.chams[1] = val end)
Options.esp_chamsColor:OnChanged(function(val) esp.chams[2] = val end)
Options.esp_chamsColor2:OnChanged(function(val) esp.chams[3] = val end)
Toggles.esp_name:OnChanged(function(val) esp.textlayout.name.enabled = val end)
Options.esp_nameColor:OnChanged(function(val) esp.textlayout.name.color = val end)
Toggles.esp_dist:OnChanged(function(val) esp.textlayout.distance.enabled = val end)
Options.esp_distColor:OnChanged(function(val) esp.textlayout.distance.color = val end)
Toggles.esp_healthtext:OnChanged(function(val) esp.textlayout.health.enabled = val end)
Options.esp_healthtextColor:OnChanged(function(val) esp.textlayout.health.color = val end)
Toggles.esp_tracer:OnChanged(function(val) esp.tracer[1] = val end)
Options.esp_tracerColor:OnChanged(function(val) esp.tracer[2] = val end)
Toggles.esp_viewangle:OnChanged(function(val) esp.angle[1] = val end)
Options.esp_viewangleColor:OnChanged(function(val) esp.angle[2] = val end)
Toggles.esp_OSA:OnChanged(function(val) esp.arrow[1] = val end)
Options.esp_OSAColor:OnChanged(function(val) esp.arrow[2] = val end)
Toggles.esp_skeleton:OnChanged(function(val) esp.skeleton[1] = val end)
Options.esp_skeletonColor:OnChanged(function(val) esp.skeleton[2] = val end)

Toggles.esp_outline:OnChanged(function(val) esp.outline[1] = val end)
Options.esp_outlineColor:OnChanged(function(val) esp.outline[2] = val end)
Toggles.esp_maxdistance:OnChanged(function(val) esp.limitdistance = val end)
Options.esp_maxdistanceValue:OnChanged(function(val) esp.maxdistance = val end)
Options.esp_nametextSide:OnChanged(function(val) esp.textlayout.name.pos = val end)
Options.esp_healthtextSide:OnChanged(function(val) esp.textlayout.health.pos = val end)
Options.esp_healthSide:OnChanged(function(val) esp.barlayout.health.pos = val end)
Options.esp_distancetextSide:OnChanged(function(val) esp.textlayout.distance.pos = val end)
Options.esp_arrowRadius:OnChanged(function(val) esp.arrowradius = val end)
Options.esp_arrowSize:OnChanged(function(val) esp.arrowsizemodifier = val end)
Options.esp_arrowTrans:OnChanged(function(val) esp.arrowfilltrans = (val/100) end)
Options.esp_textFont:OnChanged(function(val) esp.textfont = val end)
Options.esp_textSize:OnChanged(function(val) esp.textsize = val end)
Toggles.esp_teamcheck:OnChanged(function(val) esp.teamcheck = val end)


-- Visuals Code end]



Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings() 
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 
ThemeManager:SetFolder('ruskiware (cracked by office - legend)')
SaveManager:SetFolder('ruskiware (cracked by office - legend)/Counter Blox')
SaveManager:BuildConfigSection(Tabs['Settings']) 
ThemeManager:ApplyToTab(Tabs['Settings'])

-- конец хуйни



-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot
-- special package v240 office bot