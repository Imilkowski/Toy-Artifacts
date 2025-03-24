--!Type(Module)

local localShop: Shop = nil

local inOwnShop: boolean = false

function CheckIfLocalPlayer(player:Player)
    if client.localPlayer ~= player then return false end
    
    return true
end

function RemoveByValue(t, value)
    for i, v in ipairs(t) do
        if v == value then
            table.remove(t, i)
            return true
        end
    end
    return false
end

function RoundNumber(number)
    return math.round(number*100)/100
end

function StringToVector2(str)
    local x, y = str:match("([^,]+),([^,]+)")
    local vector = Vector2.new(tonumber(x) or 0, tonumber(y) or 0)
    print("Vector2:", vector.x, vector.y)
    return vector
end

function Vector2ToString(vector)
    local str = vector.x .. "," .. vector.y
    return str
end