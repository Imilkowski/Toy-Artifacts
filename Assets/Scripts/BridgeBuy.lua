--!Type(Client)

local UIManagerModule = require("UIManagerModule")
local UtilsModule = require("UtilsModule")
local SaveModule = require("SaveModule")

--!SerializeField
local repairCost: number = 0

--!SerializeField
local middlePart: GameObject = nil
--!SerializeField
local blocker: GameObject = nil
--!SerializeField
local sign: GameObject = nil

function self:OnTriggerEnter(collider: Collider)
    local playerCharacter = collider.gameObject:GetComponent(Character)
    if UtilsModule.CheckIfLocalPlayer(playerCharacter.player) ~= true then return end

    UIManagerModule.SwitchBridgePopUp(self, repairCost)
end

function RepairBridge()
    middlePart:SetActive(true)
    blocker:SetActive(false)
    sign:SetActive(false)
end