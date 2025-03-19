--!Type(Client)

local UIManagerModule = require("UIManagerModule")
local UtilsModule = require("UtilsModule")
local SaveModule = require("SaveModule")

--!SerializeField
local shopType: string = ""

function self:OnTriggerEnter(collider: Collider)
    local playerCharacter = collider.gameObject:GetComponent(Character)
    if UtilsModule.CheckIfLocalPlayer(playerCharacter.player) ~= true then return end

    UIManagerModule.SwitchItemsShop(shopType)
end