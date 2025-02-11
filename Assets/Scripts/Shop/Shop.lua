--!Type(Client)

local SaveModule = require("SaveModule")
local UpgradesModule = require("UpgradesModule")
local ToysModule = require("ToysModule")

--!SerializeField
local tablesParent:Transform = nil

assignedPlayer = nil
local sellTimePassed = 0.0
local collectToyTimePassed = 0.0

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

    sellTimePassed += Time.deltaTime
    collectToyTimePassed += Time.deltaTime

    if(sellTimePassed >= UpgradesModule.GetUpgradeValue("b-ssr")) then
        sellTimePassed = 0
        SellAToy()
    end

    if(collectToyTimePassed >= UpgradesModule.GetUpgradeValue("es-psi")) then
        collectToyTimePassed = 0
        CollectAToyPassively()
    end
end

function SellAToy()
    SaveModule.SellRandomToy(assignedPlayer)
end

function CollectAToyPassively()
    local tierNum = 1

    if(SaveModule.GetPlayerUpgradeLevel(client.localPlayer, "bridge-IV") == 1) then
        tierNum = 4
    elseif(SaveModule.GetPlayerUpgradeLevel(client.localPlayer, "bridge-III") == 1) then
        tierNum = 3
    elseif(SaveModule.GetPlayerUpgradeLevel(client.localPlayer, "bridge-II") == 1) then
        tierNum = 2
    end

    local toy = ToysModule.DrawAToy(tierNum, client.localPlayer.character, true)
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