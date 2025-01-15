--!Type(Client)

local UtilsModule = require("UtilsModule")
local ToysModule = require("ToysModule")

diggingPoints = nil
index = 0

function self:OnTriggerEnter(collider: Collider)
    local playerCharacter = collider.gameObject:GetComponent(Character)
    if UtilsModule.CheckIfLocalPlayer(playerCharacter) ~= true then return end

    diggingPoints.Dig(self, playerCharacter)
end