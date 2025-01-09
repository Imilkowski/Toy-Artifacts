--!Type(Client)

--!SerializeField
local cullObjects: { GameObject } = {}

function self:OnTriggerEnter(collider: Collider)
    local playerCharacter = collider.gameObject:GetComponent(Character)
    
    if CheckIfLocalPlayer(playerCharacter) ~= true then return end

    for i, cullObject in ipairs(cullObjects) do
        cullObject.SetActive(cullObject, false)
    end
end

function self:OnTriggerExit(collider: Collider)
    local playerCharacter = collider.gameObject:GetComponent(Character)

    if CheckIfLocalPlayer(playerCharacter) ~= true then return end

    for i, cullObject in ipairs(cullObjects) do
        cullObject.SetActive(cullObject, true)
    end
end

function CheckIfLocalPlayer(playerCharacter: Character)
    if playerCharacter == nil then return false end

    local player = playerCharacter.player
    if client.localPlayer ~= player then return false end

    return true
end