--!Type(Module)

local localShop: Shop = nil

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