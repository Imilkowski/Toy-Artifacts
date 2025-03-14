--!Type(Client)

local UtilsModule = require("UtilsModule")

diggingPoints = nil
index = 0

function self:OnTriggerEnter(collider: Collider)
    local playerCharacter = collider.gameObject:GetComponent(Character)
    if UtilsModule.CheckIfLocalPlayer(playerCharacter.player) ~= true then return end

    diggingPoints.Dig(self, playerCharacter, self.transform.position)
end