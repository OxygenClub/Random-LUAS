local Tween = {}
local Huge, Pi, Clamp, Round, Abs, Floor, Random, Sin, Cos, Rad, Halfpi = math.huge, math.pi, math.clamp, math.round, math.abs, math.floor, math.random, math.sin, math.cos, math.rad, math.pi/2
Tween.EasingStyle = {
    ["Enum.EasingStyle.Linear"] = {
        ["In"] = function(Delta)
            return Delta
        end,

        ["Out"] = function(Delta)
            return Delta
        end,

        ["InOut"] = function(Delta)
            return Delta
        end
    },
    ["Enum.EasingStyle.Cubic"] = {
        ["In"] = function(Delta)
            return Delta^3
        end,

        ["Out"] = function(Delta)
            return (Delta - 1)^3 + 1
        end,

        ["InOut"] = function(Delta)
            if Delta <= 0.5 then
                return (4 * Delta)^3
            else
                return (4 * (Delta - 1))^3 + 1
            end
        end
    },
    ["Enum.EasingStyle.Quad"] = {
        ["In"] = function(Delta)
            return Delta^2
        end,

        ["Out"] = function(Delta)
            return -(Delta - 1)^2 + 1
        end,

        ["InOut"] = function(Delta)
            if Delta <= 0.5 then
                return (2 * Delta)^2
            else
                return (-2 * (Delta - 1))^2 + 1
            end
        end
    },
    ["Enum.EasingStyle.Quart"] = {
        ["In"] = function(Delta)
            return Delta^4
        end,

        ["Out"] = function(Delta)
            return -(Delta - 1)^4 + 1
        end,

        ["InOut"] = function(Delta)
            if Delta <= 0.5 then
                return (8 * Delta)^4
            else
                return (-8 * (Delta - 1))^4 + 1
            end
        end
    },
    ["Enum.EasingStyle.Quint"] = {
        ["In"] = function(Delta)
            return Delta^5
        end,
        ["Out"] = function(Delta)
            return (Delta - 1)^5 + 1
        end,
        ["InOut"] = function(Delta)
            if Delta <= 0.5 then
                return (16 * Delta)^5
            else
                return (16 * (Delta - 1))^5 + 1
            end
        end
    },
    ["Enum.EasingStyle.Sine"] = {
        ["In"] = function(Delta)
            return Sin(Halfpi * Delta - Halfpi)
        end,

        ["Out"] = function(Delta)
            return Sin(Halfpi * Delta)
        end,

        ["InOut"] = function(Delta)
            return 0.5 * Sin(Pi * Delta - Halfpi) + 0.5
        end
    },
    ["Enum.EasingStyle.Exponential"] = {
        ["In"] = function(Delta)
            return 2^(10 * Delta - 10) - 0.001
        end,
        ["Out"] = function(Delta)
            return 1.001 * -2^(-10 * Delta) + 1
        end,
        ["InOut"] = function(Delta)
            if Delta <= 0.5 then
                return 0.5 * 2^(20 * Delta - 10) - 0.0005
            else
                return 0.50025 * -2^(-20 * Delta + 10) + 1
            end
        end
    },
    ["Enum.EasingStyle.Back"] = {
        ["In"] = function(Delta)
            return Delta^2 * (Delta * (1.70158 + 1) - 1.70158)
        end,
        ["Out"] = function(Delta)
            return (Delta - 1)^2 * ((Delta - 1) * (1.70158 + 1) + 1.70158) + 1
        end,
        ["InOut"] = function(Delta)
            if Delta <= 0.5 then
                return (2 * Delta * Delta) * ((2 * Delta) * (2.5949095 + 1) - 2.5949095)
            else
                return 0.5 * ((Delta * 2) - 2)^2 * ((Delta * 2 - 2) * (2.5949095 + 1) + 2.5949095) + 1
            end
        end
    },
    ["Enum.EasingStyle.Bounce"] = {
        ["In"] = function(Delta)
            if Delta <= 0.25 / 2.75 then
                return -7.5625 * (1 - Delta - 2.625 / 2.75)^2 + 0.015625
            elseif Delta <= 0.75 / 2.75 then
                return -7.5625 * (1 - Delta - 2.25 / 2.75)^2 + 0.0625
            elseif Delta <= 1.75 / 2.75 then
                return -7.5625 * (1 - Delta - 1.5 / 2.75)^2 + 0.25
            else
                return 1 - 7.5625 * (1 - Delta)^2
            end
        end,
        ["Out"] = function(Delta)
            if Delta <= 1 / 2.75 then
                return 7.5625 * (Delta * Delta)
            elseif Delta <= 2 / 2.75 then
                return 7.5625 * (Delta - 1.5 / 2.75)^2 + 0.75
            elseif Delta <= 2.5 / 2.75 then
                return 7.5625 * (Delta - 2.25 / 2.75)^2 + 0.9375
            else
                return 7.5625 * (Delta - 2.625 / 2.75)^2 + 0.984375
            end
        end,
        ["InOut"] = function(Delta)
            if Delta <= 0.125 / 2.75 then
                return 0.5 * (-7.5625 * (1 - Delta * 2 - 2.625 / 2.75)^2 + 0.015625)
            elseif Delta <= 0.375 / 2.75 then
                return 0.5 * (-7.5625 * (1 - Delta * 2 - 2.25 / 2.75)^2 + 0.0625)
            elseif Delta <= 0.875 / 2.75 then
                return 0.5 * (-7.5625 * (1 - Delta * 2 - 1.5 / 2.75)^2 + 0.25)
            elseif Delta <= 0.5 then
                return 0.5 * (1 - 7.5625 * (1 - Delta * 2)^2)
            elseif Delta <= 1.875 / 2.75 then
                return 0.5 + 3.78125 * (2 * Delta - 1)^2
            elseif Delta <= 2.375 / 2.75 then
                return 3.78125 * (2 * Delta - 4.25 / 2.75)^2 + 0.875
            elseif Delta <= 2.625 / 2.75 then
                return 3.78125 * (2 * Delta - 5 / 2.75)^2 + 0.96875
            else
                return 3.78125 * (2 * Delta - 5.375 / 2.75)^2 + 0.9921875
            end
        end
    },
    ["Enum.EasingStyle.Elastic"] = {
        ["In"] = function(Delta)
            return -2^(10 * (Delta - 1)) * Sin(Pi * 2 * (Delta - 1 - 0.3 / 4) / 0.3)
        end,

        ["Out"] = function(Delta)
            return 2^(-10 * Delta) * Sin(Pi * 2 * (Delta - 0.3 / 4) / 0.3) + 1
        end,

        ["InOut"] = function(Delta)
            if Delta <= 0.5 then
                return -0.5 * 2^(20 * Delta - 10) * Sin(Pi * 2 * (Delta * 2 - 1.1125) / 0.45)
            else
                return 0.5 * 2^(-20 * Delta + 10) * Sin(Pi * 2 * (Delta * 2 - 1.1125) / 0.45) + 1
            end
        end
    },
    ["Enum.EasingStyle.Circular"] = {
        ["In"] = function(Delta)
            return -Sqrt(1 - Delta^2) + 1
        end,

        ["Out"] = function(Delta)
            return Sqrt(-(Delta - 1)^2 + 1)
        end,

        ["InOut"] = function(Delta)
            if Delta <= 0.5 then
                return -Sqrt(-Delta^2 + 0.25) + 0.5
            else
                return Sqrt(-(Delta - 1)^2 + 0.25) + 0.5
            end
        end
    };
};

return Tween.EasingStyle