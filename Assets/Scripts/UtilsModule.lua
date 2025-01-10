--!Type(Module)

local InventoryModule = require("InventoryModule")

function CheckIfLocalPlayer(playerCharacter: Character)
    if playerCharacter == nil then return false end

    local player = playerCharacter.player
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

function DrawAToy(tier, playerCharacter:Character)
    print("Drawing a random toy from tier " .. tier)
    --InventoryModule.GivePlayerAnItem(playerCharacter.player, "Test Item", 1)
end