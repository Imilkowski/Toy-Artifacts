--!Type(Client)

local SaveModule = require("SaveModule")
local UpgradesModule = require("UpgradesModule")

--!SerializeField
local tablesParent:Transform = nil

assignedPlayer = nil
local timePassed = 0.0

--TEMP
function SetPlayer(player:Player)
    assignedPlayer = player
    print("Assigned player set to", player.name, "- TESTING")
end

function self:Start()
    UpdateTables()
end

function self:Update()
    if(assignedPlayer == nil) then return end

    timePassed += Time.deltaTime

    if(timePassed >= UpgradesModule.GetUpgradeValue("b-ssr")) then
        timePassed = 0
        SellAToy()
    end
end

function SellAToy()
    SaveModule.SellRandomToy(assignedPlayer)
end


function UpdateTables()
    local toysRegister

    if(assignedPlayer == nil) then
        ClearTables()
        return
    end

    toysRegister = SaveModule.localPlayerStorage[assignedPlayer].toysRegister

    for i = 0, tablesParent.childCount - 1 do
        local tableToys = tablesParent:GetChild(i):GetChild(0)

        for j = 0, tableToys.childCount - 1 do
            local toy = tableToys:GetChild(j)
            
            for k, v in pairs(toysRegister) do
                print(toy.name, k)
                if(toy.name == k) then
                    toy.gameObject.SetActive(toy.gameObject, true)
                    break
                else
                    toy.gameObject.SetActive(toy.gameObject, false)
                end
            end
        end
    end
end

function ClearTables()
    for i = 0, tablesParent.childCount - 1 do
        local tableToys = tablesParent:GetChild(i):GetChild(0)

        for j = 0, tableToys.childCount - 1 do
            local toy = tableToys:GetChild(j)
            
            toy.gameObject.SetActive(toy.gameObject, false)
        end
    end
end