--!Type(Client)

local UtilsModule = require("UtilsModule")
local UIManagerModule = require("UIManagerModule")
local SaveModule = require("SaveModule")

--!SerializeField
local shopScript:Shop = nil

function self:OnTriggerEnter(collider: Collider)
    local playerCharacter = collider.gameObject:GetComponent(Character)
    if UtilsModule.CheckIfLocalPlayer(playerCharacter.player) ~= true then return end
    if(playerCharacter.player ~= shopScript.assignedPlayer) then return end

    UIManagerModule.SwitchEditShopButton(true)
end

function self:OnTriggerExit(collider: Collider)
    local playerCharacter = collider.gameObject:GetComponent(Character)
    if UtilsModule.CheckIfLocalPlayer(playerCharacter.player) ~= true then return end
    if(playerCharacter.player ~= shopScript.assignedPlayer) then return end

    UIManagerModule.SwitchEditShopButton(false)
end