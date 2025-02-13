--!Type(Client)

local UtilsModule = require("UtilsModule")
local SaveModule = require("SaveModule")

--!SerializeField
local shopScript:Shop = nil

function self:OnTriggerEnter(collider: Collider)
    local playerCharacter = collider.gameObject:GetComponent(Character)
    if UtilsModule.CheckIfLocalPlayer(playerCharacter.player) ~= true then return end

    if(playerCharacter.player ~= shopScript.assignedPlayer) then return end

    SaveModule.LeaveToysAtShop(playerCharacter.player)

    print(playerCharacter.player.name, "left toys at the shop")

    shopScript.UpdateTables()
end