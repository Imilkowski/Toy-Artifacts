--!Type(Client)

local UtilsModule = require("UtilsModule")
local SaveModule = require("SaveModule")
local ShopManager = require("ShopManager")

--!SerializeField
local shopScript:Shop = nil

function self:OnTriggerEnter(collider: Collider)
    local playerCharacter = collider.gameObject:GetComponent(Character)
    if UtilsModule.CheckIfLocalPlayer(playerCharacter.player) ~= true then return end

    if(playerCharacter.player ~= shopScript.assignedPlayer) then 
        ShopManager.UpdatePlayerShop(shopScript.assignedPlayer)
        return 
    end

    SaveModule.LeaveToysAtShop(playerCharacter.player)

    Timer.After(0.5, function() 
        ShopManager.OnToysLeftAtShop(SaveModule.GetToyRegister(playerCharacter.player))
    end)

    --shopScript.UpdateTables()
end