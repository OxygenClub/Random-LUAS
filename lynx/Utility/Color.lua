local Color = {}
do -- // Color
    function Color:Multiply(Color, Multiplier)
        return Color3.new(Color.R * Multiplier, Color.G * Multiplier, Color.B * Multiplier)
    end
    --
    function Color:Add(Color, Addition)
        return Color3.new(Color.R + Addition, Color.G + Addition, Color.B + Addition)
    end
    --
    function Color:Lerp(Value, MinColor, MaxColor)
        if Value <= 0 then return MaxColor end
        if Value >= 100 then return MinColor end
        --
        return Color3.new(
            MaxColor.R + (MinColor.R - MaxColor.R) * Value,
            MaxColor.G + (MinColor.G - MaxColor.G) * Value,
            MaxColor.B + (MinColor.B - MaxColor.B) * Value
        )
    end
end
--
return Color