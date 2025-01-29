--!Type(Client)

local UtilsModule = require("UtilsModule")

--!SerializeField
local cullObjects: { GameObject } = {}

function self:OnTriggerEnter(collider: Collider)
    local playerCharacter = collider.gameObject:GetComponent(Character)
    if UtilsModule.CheckIfLocalPlayer(playerCharacter.player) ~= true then return end

    for i, cullObject in ipairs(cullObjects) do
        cullObject.SetActive(cullObject, false)
    end
end

function self:OnTriggerExit(collider: Collider)
    local playerCharacter = collider.gameObject:GetComponent(Character)
    if UtilsModule.CheckIfLocalPlayer(playerCharacter.player) ~= true then return end

    for i, cullObject in ipairs(cullObjects) do
        cullObject.SetActive(cullObject, true)
    end
end