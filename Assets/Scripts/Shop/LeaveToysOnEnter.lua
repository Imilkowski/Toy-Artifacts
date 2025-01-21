--!Type(Client)

local UtilsModule = require("UtilsModule")
local SaveModule = require("SaveModule")

--!SerializeField
local shopScript:Shop = nil

function self:OnTriggerEnter(collider: Collider)
    local playerCharacter = collider.gameObject:GetComponent(Character)
    if UtilsModule.CheckIfLocalPlayer(playerCharacter) ~= true then return end

    SaveModule.LeaveToysAtShop(playerCharacter.player)

    --TEMP
    shopScript.SetPlayer(playerCharacter.player)
    print(playerCharacter.player.name, "left toys at the shop")

    shopScript.UpdateTables()
end