local NewVector2, NewVector3, Random, Round, Acos, Cos = Vector2.new, Vector3.new, math.random, math.round, math.acos, math.cos
local Math = {}
do -- // Math
    function Math:RoundVector(Vector)
        return NewVector2(Round(Vector.X), Round(Vector.Y))
    end
    --
    function Math:Shift(Number)
        return Acos(Cos(Number * Pi)) / Pi
    end
    --
    function Math:Random(Number)
        return Random(-Number, Number)
    end
    --
    function Math:RandomVec3(X, Y, Z)
        return NewVector3(Math:Random(X), Math:Random(Y), Math:Random(Z))
    end
end
--
return Math