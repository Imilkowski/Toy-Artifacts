--!Type(Client)

local SaveModule = require("SaveModule")

assignedPlayer = nil
local timePassed = 0.0

--TEMP
function SetPlayer(player:Player)
    assignedPlayer = player
    print("Assigned player set to", player.name, "- TESTING")
end

function UpdateCollectedToys()

end

function self:Update()
    if(assignedPlayer == nil) then return end

    timePassed += Time.deltaTime

    if(timePassed >= SaveModule.GetShopSellingRate(assignedPlayer)) then
        timePassed = 0
        SellAToy()
    end
end

function SellAToy()
    SaveModule.SellRandomToy(assignedPlayer)
end