--!Type(Client)

local UIManagerModule = require("UIManagerModule")
local UtilsModule = require("UtilsModule")
local SaveModule = require("SaveModule")

--!SerializeField
local repairCost: number = 0
--!SerializeField
local upgradeId: string = ""

--!SerializeField
local middlePart: GameObject = nil
--!SerializeField
local blocker: GameObject = nil
--!SerializeField
local sign: GameObject = nil

local loadTimer = nil
local loadTimerCount = 0

function self:OnTriggerEnter(collider: Collider)
    local playerCharacter = collider.gameObject:GetComponent(Character)
    if UtilsModule.CheckIfLocalPlayer(playerCharacter.player) ~= true then return end

    UIManagerModule.SwitchBridgePopUp(self, repairCost)
end

function RepairBridge(player:Player)
    SaveModule.IncreasePlayerUpgradeLevel(player, upgradeId)

    Repair()
end

function Repair()
    middlePart:SetActive(true)
    blocker:SetActive(false)
    sign:SetActive(false)
end

function self:Start()
    loadTimer = Timer.Every(1, function() 
        loadTimerCount +=1
        if(loadTimerCount >= 10) then loadTimer:Stop() end

        local upgradeLevel = SaveModule.GetPlayerUpgradeLevel(client.localPlayer, upgradeId)
        if(upgradeLevel == nil) then return end

        if(upgradeLevel > 0) then
            Repair()
            loadTimer:Stop()
        end
    end)
end