--!Type(Client)

local SaveModule = require("SaveModule")

local loadTimer = nil
local loadTimerCount = 0

function ActivateTeleports(active:boolean)
    for i = 0, self.transform.childCount - 1 do
        local teleport = self.transform:GetChild(i).gameObject
        teleport:SetActive(active)
    end
end

function self:Start()
    ActivateTeleports(false)
    
    loadTimer = Timer.Every(1, function() 
        loadTimerCount +=1
        if(loadTimerCount >= 10) then loadTimer:Stop() end

        local upgradeLevel = SaveModule.GetPlayerUpgradeLevel(client.localPlayer, "b-t")
        if(upgradeLevel == nil) then return end

        if(upgradeLevel > 0) then
            ActivateTeleports(true)
            loadTimer:Stop()
        end
    end)
end