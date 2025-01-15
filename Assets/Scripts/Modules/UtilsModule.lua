--!Type(Module)

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