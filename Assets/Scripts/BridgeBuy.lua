--!Type(Client)

local UIManagerModule = require("UIManagerModule")
local UtilsModule = require("UtilsModule")

function self:OnTriggerEnter(collider: Collider)
    local playerCharacter = collider.gameObject:GetComponent(Character)
    if UtilsModule.CheckIfLocalPlayer(playerCharacter.player) ~= true then return end

    UIManagerModule.SwitchBridgePopUp()
end