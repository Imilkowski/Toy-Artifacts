--!Type(Client)

--!SerializeField
local cullObject: GameObject = nil

function self:OnTriggerEnter(collider: Collider)
    local playerCharacter = collider.gameObject:GetComponent(Character)
    
    if CheckIfLocalPlayer(playerCharacter) ~= true then return end

    cullObject.SetActive(cullObject, false)
end

function self:OnTriggerExit(collider: Collider)
    local playerCharacter = collider.gameObject:GetComponent(Character)

    if CheckIfLocalPlayer(playerCharacter) ~= true then return end

    cullObject.SetActive(cullObject, true)
end

function CheckIfLocalPlayer(playerCharacter: Character)
    if playerCharacter == nil then return false end

    local player = playerCharacter.player
    if client.localPlayer ~= player then return false end

    return true
end