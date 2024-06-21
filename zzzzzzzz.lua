-- Made by jLn0n

-- services
local coreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
-- objects
local camera = workspace.CurrentCamera
local drawingUI = Instance.new("ScreenGui")
drawingUI.Name = "Drawing3"
drawingUI.IgnoreGuiInset = true
drawingUI.DisplayOrder = 0x7fffffff
drawingUI.Parent = coreGui
-- variables
local drawingIndex = 0
local uiStrokes = table.create(0)
local baseDrawingObj = setmetatable({
	Visible = true,
	ZIndex = 0,
	Transparency = 1,
	Color = Color3.new(),
	Remove = function(self)
		setmetatable(self, nil)
	end
}, {
	__add = function(t1, t2)
		local result = table.clone(t1)

		for index, value in t2 do
			result[index] = value
		end
		return result
	end
})

if not isfile("Proggy.ttf") then
	writefile("Proggy.ttf", base64_decode(game:HttpGet("https://raw.githubusercontent.com/OxygenClub/Random-LUAS/main/Proggy.txt")))
end

if not isfile("Proggy.json") then
	local Proggy = {
		name = "Proggy",
		faces = { 
			{
				name = "Regular",
				weight = 400,
				style = "normal",
				assetId = getcustomasset("Proggy.ttf")
			} 
		}
	}

	writefile("Proggy.json", HttpService:JSONEncode(Proggy))
end

if not isfile("Minecraftia.ttf") then
	writefile("Minecraftia.ttf", base64_decode(game:HttpGet("https://raw.githubusercontent.com/OxygenClub/Random-LUAS/main/Minecraftia.txt")))
end

if not isfile("Minecraftia.json") then
	local Minecraftia = {
		name = "Minecraftia",
		faces = { 
			{
				name = "Regular",
				weight = 400,
				style = "normal",
				assetId = getcustomasset("Minecraftia.ttf")
			} 
		}
	}

	writefile("Minecraftia.json", HttpService:JSONEncode(Minecraftia))
end

if not isfile("SmallestPixel7.ttf") then
	writefile("SmallestPixel7.ttf", base64_decode(game:HttpGet("https://raw.githubusercontent.com/OxygenClub/Random-LUAS/main/Smallest%20Pixel.txt")))
end

if not isfile("SmallestPixel7.json") then
	local SmallestPixel7 = {
		name = "SmallestPixel7",
		faces = { 
			{
				name = "Regular",
				weight = 400,
				style = "normal",
				assetId = getcustomasset("SmallestPixel7.ttf")
			} 
		}
	}

	writefile("SmallestPixel7.json", HttpService:JSONEncode(SmallestPixel7))
end

if not isfile("Verdana.ttf") then
	writefile("Verdana.ttf", base64_decode(game:HttpGet("https://raw.githubusercontent.com/OxygenClub/Random-LUAS/main/Verdana.txt")))
end

if not isfile("Verdana.json") then
	local Verdana = {
		name = "Verdana",
		faces = { 
			{
				name = "Regular",
				weight = 400,
				style = "normal",
				assetId = getcustomasset("Verdana.ttf")
			} 
		}
	}

	writefile("Verdana.json", HttpService:JSONEncode(Verdana))
end

if not isfile("VerdanaBold.ttf") then
	writefile("VerdanaBold.ttf", base64_decode(game:HttpGet("https://raw.githubusercontent.com/OxygenClub/Random-LUAS/main/Verdana%20Bold.txt")))
end

if not isfile("VerdanaBold.json") then
	local VerdanaBold = {
		name = "VerdanaBold",
		faces = { 
			{
				name = "Regular",
				weight = 400,
				style = "normal",
				assetId = getcustomasset("VerdanaBold.ttf")
			} 
		}
	}

	writefile("VerdanaBold.json", HttpService:JSONEncode(VerdanaBold))
end

if not isfile("Tahoma.ttf") then
	writefile("Tahoma.ttf", base64_decode(game:HttpGet("https://raw.githubusercontent.com/OxygenClub/Random-LUAS/main/Tahoma.txt")))
end

if not isfile("Tahoma.json") then
	local Tahoma = {
		name = "Tahoma",
		faces = { 
			{
				name = "Regular",
				weight = 400,
				style = "normal",
				assetId = getcustomasset("Tahoma.ttf")
			} 
		}
	}

	writefile("Tahoma.json", HttpService:JSONEncode(Tahoma))
end

if not isfile("TahomaBold.ttf") then
	writefile("TahomaBold.ttf", base64_decode(game:HttpGet("https://raw.githubusercontent.com/OxygenClub/Random-LUAS/main/Tahoma%20Bold.txt")))
end

if not isfile("TahomaBold.json") then
	local TahomaBold = {
		name = "TahomaBold",
		faces = { 
			{
				name = "Regular",
				weight = 400,
				style = "normal",
				assetId = getcustomasset("TahomaBold.ttf")
			} 
		}
	}

	writefile("TahomaBold.json", HttpService:JSONEncode(TahomaBold))
end


local drawingFontsEnum = {
	[0] = Font.new(getcustomasset("Verdana.json"), Enum.FontWeight.Regular),
	[1] = Font.new(getcustomasset("SmallestPixel7.json"), Enum.FontWeight.Regular),
	[2] = Font.new(getcustomasset("Proggy.json"), Enum.FontWeight.Regular),
	[3] = Font.new(getcustomasset("Minecraftia.json"), Enum.FontWeight.Regular),
	[4] = Font.new(getcustomasset("VerdanaBold.json"), Enum.FontWeight.Regular),
	[5] = Font.new(getcustomasset("Tahoma.json"), Enum.FontWeight.Regular),
	[6] = Font.new(getcustomasset("TahomaBold.json"), Enum.FontWeight.Regular),

}
-- function
local function getFontFromIndex(fontIndex: number): Font
	return drawingFontsEnum[fontIndex]
end

local function convertTransparency(transparency: number): number
	return math.clamp(1 - transparency, 0, 1)
end
-- main
local DrawingLib = {}
DrawingLib.Fonts = {
	["UI"] = 0,
	["System"] = 1,
	["Flex"] = 2,
	["Monospace"] = 3
}

function DrawingLib.new(drawingType)
	drawingIndex += 1
	if drawingType == "Line" then
		local lineObj = ({
			From = Vector2.zero,
			To = Vector2.zero,
			Thickness = 1
		} + baseDrawingObj)

		local lineFrame = Instance.new("Frame")
		lineFrame.Name = drawingIndex
		lineFrame.AnchorPoint = (Vector2.one * .5)
		lineFrame.BorderSizePixel = 0

		lineFrame.BackgroundColor3 = lineObj.Color
		lineFrame.Visible = lineObj.Visible
		lineFrame.ZIndex = lineObj.ZIndex
		lineFrame.BackgroundTransparency = convertTransparency(lineObj.Transparency)

		lineFrame.Size = UDim2.new()

		lineFrame.Parent = drawingUI
		return setmetatable(table.create(0), {
			__newindex = function(_, index, value)
				if typeof(lineObj[index]) == "nil" then return end

				if index == "From" then
					local direction = (lineObj.To - value)
					local center = (lineObj.To + value) / 2
					local distance = direction.Magnitude
					local theta = math.deg(math.atan2(direction.Y, direction.X))

					lineFrame.Position = UDim2.fromOffset(center.X, center.Y)
					lineFrame.Rotation = theta
					lineFrame.Size = UDim2.fromOffset(distance, lineObj.Thickness)
				elseif index == "To" then
					local direction = (value - lineObj.From)
					local center = (value + lineObj.From) / 2
					local distance = direction.Magnitude
					local theta = math.deg(math.atan2(direction.Y, direction.X))

					lineFrame.Position = UDim2.fromOffset(center.X, center.Y)
					lineFrame.Rotation = theta
					lineFrame.Size = UDim2.fromOffset(distance, lineObj.Thickness)
				elseif index == "Thickness" then
					local distance = (lineObj.To - lineObj.From).Magnitude

					lineFrame.Size = UDim2.fromOffset(distance, value)
				elseif index == "Visible" then
					lineFrame.Visible = value
				elseif index == "ZIndex" then
					lineFrame.ZIndex = value
				elseif index == "Transparency" then
					lineFrame.BackgroundTransparency = convertTransparency(value)
				elseif index == "Color" then
					lineFrame.BackgroundColor3 = value
				end
				lineObj[index] = value
			end,
			__index = function(self, index)
				if index == "Remove" then
					return function()
						lineFrame:Destroy()
						lineObj.Remove(self)
						return lineObj:Remove()
					end
				end
				return lineObj[index]
			end,
		    __call = function(self, method)
				return lineFrame
			end
		})
	elseif drawingType == "Text" then
		local textObj = ({
			Text = "",
			Font = DrawingLib.Fonts.UI,
			Size = 0,
			Position = Vector2.zero,
			Center = false,
			Outline = false,
			OutlineColor = Color3.new()
		} + baseDrawingObj)

		local textLabel = Instance.new("TextLabel")
		textLabel.Name = drawingIndex
		textLabel.AnchorPoint = (Vector2.one * .5)
		textLabel.BorderSizePixel = 0
		textLabel.BackgroundTransparency = 1
        textLabel.RichText = true

		textLabel.Visible = textObj.Visible
		textLabel.TextColor3 = textObj.Color
		textLabel.TextTransparency = convertTransparency(textObj.Transparency)
		textLabel.ZIndex = textObj.ZIndex

		textLabel.FontFace = getFontFromIndex(textObj.Font)
		textLabel.TextSize = textObj.Size

		textLabel:GetPropertyChangedSignal("TextBounds"):Connect(function()
			local textBounds = textLabel.TextBounds
			local offset = textBounds / 2

			textLabel.Size = UDim2.fromOffset(textBounds.X, textBounds.Y)
			textLabel.Position = UDim2.fromOffset(textObj.Position.X + (if not textObj.Center then offset.X else 0), textObj.Position.Y + offset.Y)
		end)

        textLabel.TextStrokeTransparency = 1

		textLabel.Parent = drawingUI
		return setmetatable(table.create(0), {
			__newindex = function(_, index, value)
				if typeof(textObj[index]) == "nil" then return end

				if index == "Text" then
					textLabel.Text = value
				elseif index == "Font" then
					value = math.clamp(value, 0, 3)
					textLabel.FontFace = getFontFromIndex(value)
				elseif index == "Size" then
					textLabel.TextSize = value
				elseif index == "Position" then
					local offset = textLabel.TextBounds / 2

					textLabel.Position = UDim2.fromOffset(value.X + (if not textObj.Center then offset.X else 0), value.Y + offset.Y)
				elseif index == "Center" then
					local position = (
						if value then
							camera.ViewportSize / 2
						else
							textObj.Position
					)

					textLabel.Position = UDim2.fromOffset(position.X, position.Y)
				elseif index == "Outline" then
					--uiStroke.Enabled = value
                    textLabel.TextStrokeTransparency = value and 0 or 1
				elseif index == "OutlineColor" then
					--uiStroke.Color = value
				elseif index == "Visible" then
					textLabel.Visible = value
				elseif index == "ZIndex" then
					textLabel.ZIndex = value
				elseif index == "Transparency" then
					local transparency = convertTransparency(value)

					textLabel.TextTransparency = transparency
					--uiStroke.Transparency = transparency
				elseif index == "Color" then
					textLabel.TextColor3 = value
				end
				textObj[index] = value
			end,
			__index = function(self, index)
				if index == "Remove" then
					return function()
						textLabel:Destroy()
						textObj.Remove(self)
						return textObj:Remove()
					end
				elseif index == "TextBounds" then
					return textLabel.TextBounds
				end
				return textObj[index]
			end,
			__namecall = function(self, index)
				if index == "Get" then  
					return textLabel
				end 
				return 
			end
		})
	elseif drawingType == "Circle" then
		local circleObj = ({
			Radius = 150,
			Position = Vector2.zero,
			Thickness = .7,
			Filled = false
		} + baseDrawingObj)

		local circleFrame, uiCorner, uiStroke = Instance.new("Frame"), Instance.new("UICorner"), Instance.new("UIStroke")
		circleFrame.Name = drawingIndex
		circleFrame.AnchorPoint = (Vector2.one * .5)
		circleFrame.BorderSizePixel = 0

		circleFrame.BackgroundTransparency = (if circleObj.Filled then convertTransparency(circleObj.Transparency) else 1)
		circleFrame.BackgroundColor3 = circleObj.Color
		circleFrame.Visible = circleObj.Visible
		circleFrame.ZIndex = circleObj.ZIndex

		uiCorner.CornerRadius = UDim.new(1, 0)
		circleFrame.Size = UDim2.fromOffset(circleObj.Radius, circleObj.Radius)

		uiStroke.Thickness = circleObj.Thickness
		uiStroke.Enabled = not circleObj.Filled
		uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

		circleFrame.Parent, uiCorner.Parent, uiStroke.Parent = drawingUI, circleFrame, circleFrame
		return setmetatable(table.create(0), {
			__newindex = function(_, index, value)
				if typeof(circleObj[index]) == "nil" then return end

				if index == "Radius" then
					local radius = value * 2
					circleFrame.Size = UDim2.fromOffset(radius, radius)
				elseif index == "Position" then
					circleFrame.Position = UDim2.fromOffset(value.X, value.Y)
				elseif index == "Thickness" then
					value = math.clamp(value, .6, 0x7fffffff)
					uiStroke.Thickness = value
				elseif index == "Filled" then
					circleFrame.BackgroundTransparency = (if value then convertTransparency(circleObj.Transparency) else 1)
					uiStroke.Enabled = not value
				elseif index == "Visible" then
					circleFrame.Visible = value
				elseif index == "ZIndex" then
					circleFrame.ZIndex = value
				elseif index == "Transparency" then
					local transparency = convertTransparency(value)

					circleFrame.BackgroundTransparency = (if circleObj.Filled then transparency else 1)
					uiStroke.Transparency = transparency
				elseif index == "Color" then
					circleFrame.BackgroundColor3 = value
					uiStroke.Color = value
				end
				circleObj[index] = value
			end,
			__index = function(self, index)
				if index == "Remove" then
					return function()
						circleFrame:Destroy()
						circleObj.Remove(self)
						return circleObj:Remove()
					end
				end
				return circleObj[index]
			end,
		    __call = function(self, method)
				return circleFrame
			end
		})
	elseif drawingType == "Square" then
		local squareObj = ({
			Size = Vector2.zero,
			Position = Vector2.zero,
			Thickness = .7,
			Filled = false
		} + baseDrawingObj)

		local squareFrame, uiStroke = Instance.new("Frame"), Instance.new("UIStroke")
		squareFrame.Name = drawingIndex
		squareFrame.BorderSizePixel = 0

		squareFrame.BackgroundTransparency = (if squareObj.Filled then convertTransparency(squareObj.Transparency) else 1)
		squareFrame.ZIndex = squareObj.ZIndex
		squareFrame.BackgroundColor3 = squareObj.Color
		squareFrame.Visible = squareObj.Visible

		uiStroke.Thickness = squareObj.Thickness
		uiStroke.Enabled = not squareObj.Filled
		uiStroke.LineJoinMode = Enum.LineJoinMode.Miter

		squareFrame.Parent, uiStroke.Parent = drawingUI, squareFrame
		return setmetatable(table.create(0), {
			__newindex = function(_, index, value)
				if typeof(squareObj[index]) == "nil" then return end

				if index == "Size" then
					squareFrame.Size = UDim2.fromOffset(value.X, value.Y)
				elseif index == "Position" then
					squareFrame.Position = UDim2.fromOffset(value.X, value.Y)
				elseif index == "Thickness" then
					value = math.clamp(value, 0.6, 0x7fffffff)
					uiStroke.Thickness = value
				elseif index == "Filled" then
					squareFrame.BackgroundTransparency = (if value then convertTransparency(squareObj.Transparency) else 1)
					uiStroke.Enabled = not value
				elseif index == "Visible" then
					squareFrame.Visible = value
				elseif index == "ZIndex" then
					squareFrame.ZIndex = value
				elseif index == "Transparency" then
					local transparency = convertTransparency(value)

					squareFrame.BackgroundTransparency = (if squareObj.Filled then transparency else 1)
					uiStroke.Transparency = transparency
				elseif index == "Color" then
					uiStroke.Color = value
					squareFrame.BackgroundColor3 = value
				end
				squareObj[index] = value
			end,
			__index = function(self, index)
				if index == "Remove" then
					return function()
						squareFrame:Destroy()
						squareObj.Remove(self)
						return squareObj:Remove()
					end
				end
				return squareObj[index]
			end,
		    __call = function(self, method)
				return squareFrame
			end
		})
	elseif drawingType == "Image" then
		local imageObj = ({
			Data = "",
			DataURL = "rbxassetid://0",
			Size = Vector2.zero,
			Position = Vector2.zero
		} + baseDrawingObj)

		local imageFrame = Instance.new("ImageLabel")
		imageFrame.Name = drawingIndex
		imageFrame.BorderSizePixel = 0
		imageFrame.ScaleType = Enum.ScaleType.Stretch
		imageFrame.BackgroundTransparency = 1

		imageFrame.Visible = imageObj.Visible
		imageFrame.ZIndex = imageObj.ZIndex
		imageFrame.ImageTransparency = convertTransparency(imageObj.Transparency)
		imageFrame.ImageColor3 = imageObj.Color

		imageFrame.Parent = drawingUI
		return setmetatable(table.create(0), {
			__newindex = function(_, index, value)
				if typeof(imageObj[index]) == "nil" then return end

				if index == "Data" then
					-- later
				elseif index == "DataURL" then -- temporary property
					imageFrame.Image = value
				elseif index == "Size" then
					imageFrame.Size = UDim2.fromOffset(value.X, value.Y)
				elseif index == "Position" then
					imageFrame.Position = UDim2.fromOffset(value.X, value.Y)
				elseif index == "Visible" then
					imageFrame.Visible = value
				elseif index == "ZIndex" then
					imageFrame.ZIndex = value
				elseif index == "Transparency" then
					imageFrame.ImageTransparency = convertTransparency(value)
				elseif index == "Color" then
					imageFrame.ImageColor3 = value
				end
				imageObj[index] = value
			end,
			__index = function(self, index)
				if index == "Remove" then
					return function()
						imageFrame:Destroy()
						imageObj.Remove(self)
						return imageObj:Remove()
					end
				elseif index == "Data" then
					return nil -- TODO: add error here
				end
				return imageObj[index]
			end,
		    __call = function(self, method)
				return imageFrame
			end
		})
	elseif drawingType == "Quad" then
		local quadObj = ({
			PointA = Vector2.zero,
			PointB = Vector2.zero,
			PointC = Vector2.zero,
			PointD = Vector3.zero,
			Thickness = 1,
			Filled = false
		} + baseDrawingObj)

		local _linePoints = table.create(0)
		_linePoints.A = DrawingLib.new("Line")
		_linePoints.B = DrawingLib.new("Line")
		_linePoints.C = DrawingLib.new("Line")
		_linePoints.D = DrawingLib.new("Line")
		return setmetatable(table.create(0), {
			__newindex = function(_, index, value)
				if typeof(quadObj[index]) == "nil" then return end

				if index == "PointA" then
					_linePoints.A.From = value
					_linePoints.B.To = value
				elseif index == "PointB" then
					_linePoints.B.From = value
					_linePoints.C.To = value
				elseif index == "PointC" then
					_linePoints.C.From = value
					_linePoints.D.To = value
				elseif index == "PointD" then
					_linePoints.D.From = value
					_linePoints.A.To = value
				elseif (index == "Thickness" or index == "Visible" or index == "Color" or index == "ZIndex") then
					for _, linePoint in _linePoints do
						linePoint[index] = value
					end
				elseif index == "Filled" then
					-- later
				end
				quadObj[index] = value
			end,
			__index = function(self, index)
				if index == "Remove" then
					return function()
						for _, linePoint in _linePoints do
							linePoint:Remove()
						end

						quadObj.Remove(self)
						return quadObj:Remove()
					end
				end
				return quadObj[index]
			end
		})
	elseif drawingType == "Triangle" then
		local triangleObj = ({
			PointA = Vector2.zero,
			PointB = Vector2.zero,
			PointC = Vector2.zero,
			Thickness = 1,
			Filled = false
		} + baseDrawingObj)

		local _linePoints = table.create(0)
		_linePoints.A = DrawingLib.new("Line")
		_linePoints.B = DrawingLib.new("Line")
		_linePoints.C = DrawingLib.new("Line")
		return setmetatable(table.create(0), {
			__newindex = function(_, index, value)
				if typeof(triangleObj[index]) == "nil" then return end

				if index == "PointA" then
					_linePoints.A.From = value
					_linePoints.B.To = value
				elseif index == "PointB" then
					_linePoints.B.From = value
					_linePoints.C.To = value
				elseif index == "PointC" then
					_linePoints.C.From = value
					_linePoints.A.To = value
				elseif (index == "Thickness" or index == "Visible" or index == "Color" or index == "ZIndex") then
					for _, linePoint in _linePoints do
						linePoint[index] = value
					end
				elseif index == "Filled" then
					-- later
				end
				triangleObj[index] = value
			end,
			__index = function(self, index)
				if index == "Remove" then
					return function()
						for _, linePoint in _linePoints do
							linePoint:Remove()
						end

						triangleObj.Remove(self)
						return triangleObj:Remove()
					end
				end
				return triangleObj[index]
			end
		})
	end
end

-- if getgenv().Test then getgenv().Test:Remove(); getgenv().Test = nil end

-- local Test = DrawingLib.new("Text")

-- Test.Position = Vector2.new(600, 600)
-- Test.Visible = true
-- Test.Outline = true
-- Test.Font = 5
-- Test.Size = 14
-- Test.Color = Color3.fromRGB(255, 255, 255)

-- getgenv().Test = Test

return DrawingLib
