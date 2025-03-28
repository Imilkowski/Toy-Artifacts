--!Type(Client)

local UtilsModule = require("UtilsModule")
local SaveModule = require("SaveModule")
local UpgradesModule = require("UpgradesModule")
local ToysModule = require("ToysModule")

--!SerializeField
local shopId:number = 0
--!SerializeField
local tablesParent:Transform = nil
--!SerializeField
local playerIndicator:GameObject = nil
--!SerializeField
local editShopScript:EditShop = nil
--!SerializeField
local nameTag:NameTag_UI = nil

assignedPlayer = nil
local sellTimePassed = 0.0
local collectToyTimePassed = 0.0

function self:Start()
    UpdateTables(nil)
end

function AssignPlayer(playerToAssign:Player, toysRegister, decorationsPlaced, decorationsPlacedRotations)
    if(playerToAssign == nil) then
        self.gameObject:SetActive(false)
        return
    end

    self.gameObject:SetActive(true)
    
    if(playerToAssign == client.localPlayer) then
        playerIndicator:SetActive(true)
        nameTag.SetText("")
    else
        playerIndicator:SetActive(false)
        nameTag.SetText(playerToAssign.name)
    end

    SetPlayer(playerToAssign)
    
    Timer.After(1, function() 
        UpdateTables(toysRegister)
        UpdateDecorations(decorationsPlaced, decorationsPlacedRotations)
    end)

    Timer.Every(0.05, function() sellTimePassed += 0.05 end)
    Timer.Every(0.05, function() collectToyTimePassed += 0.05 end)
end

function self:Update()
    if(assignedPlayer == nil) then return end

    -- sellTimePassed += Time.deltaTime
    -- collectToyTimePassed += Time.deltaTime

    if(sellTimePassed >= UpgradesModule.GetUpgradeValue("b-ssr")) then
        sellTimePassed = 0
        SellAToy()
    end

    if(collectToyTimePassed >= UpgradesModule.GetUpgradeValue("es-psi")) then
        collectToyTimePassed = 0
        CollectAToyPassively()
    end
end

function SetPlayer(player:Player)
    assignedPlayer = player

    if(player == client.localPlayer) then
        UtilsModule.localShop = self
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

    local toy = ToysModule.DrawAToyPassively(tierNum, client.localPlayer.character)
end

function UpdateShop(toysRegister, decorationsPlaced, decorationsPlacedRotations)
    UpdateTables(toysRegister)
    UpdateDecorations(decorationsPlaced, decorationsPlacedRotations)
end

function UpdateTables(toysRegister)
    ClearTables()
    
    if(assignedPlayer == nil) then
        return
    end

    if(toysRegister == nil) then 
        toysRegister = SaveModule.localPlayerStorage[assignedPlayer].toysRegister
    end

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

function UpdateDecorations(decorationsPlaced, decorationsPlacedRotations)
    if decorationsPlaced == nil then
        return
    end
    
    editShopScript.LoadDecorations(decorationsPlaced, decorationsPlacedRotations)
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

function GetShopId()
    return shopId
end

function GetEditShopScript()
    return editShopScript
end