--!Type(Module)

local SaveModule = require("SaveModule")
local UtilsModule = require("UtilsModule")

--!SerializeField
local upgradeIcons: { Texture } = {}

Upgrade = {}
Upgrade.__index = Upgrade

function Upgrade.new(upgradeId, level, description, value, iconId, price)
    local myClass = setmetatable({}, Upgrade)

    myClass.upgradeId = upgradeId
    myClass.level = level
	myClass.description = description
    myClass.value = value
    myClass.iconId = iconId
    myClass.price = price
	
	return myClass
end

local upgradesValues = {}

--Excavation sites
local es_diggingPoints = {}
local es_passiveItems = {}
local es_diggingChance = {}

--Business
local b_shopSellingRate = {}

function self:Awake()
    local status, result = pcall(function()
        InitializeUpgradesTables()
    end)
    
    if not status then end
end

function InitializeUpgradesTables()
    --Excavation sites
    upgradesValues["es-dp"] = 2
    table.insert(es_diggingPoints, Upgrade.new("es-dp", 1, "Digging points number (2 -> 3)", 3, 1, 25))
    table.insert(es_diggingPoints, Upgrade.new("es-dp", 2, "Digging points number (3 -> 4)", 4, 1, 75))
    table.insert(es_diggingPoints, Upgrade.new("es-dp", 3, "Digging points number (4 -> 5)", 5, 1, 225))
    table.insert(es_diggingPoints, Upgrade.new("es-dp", 4, "Digging points number (5 -> 6)", 6, 1, 675))
    table.insert(es_diggingPoints, Upgrade.new("es-dp", 5, "Digging points number (6 -> 7)", 7, 1, 1350))

    upgradesValues["es-psi"] = 100000
    table.insert(es_passiveItems, Upgrade.new("es-psi", 1, "Passively collected toys over 10s (0 -> 1)", 10, 2, 25))
    table.insert(es_passiveItems, Upgrade.new("es-psi", 2, "Passively collected toys over 10s (1 -> 2)", 5, 2, 75))
    table.insert(es_passiveItems, Upgrade.new("es-psi", 3, "Passively collected toys over 10s (2 -> 3)", 3.33, 2, 225))
    table.insert(es_passiveItems, Upgrade.new("es-psi", 4, "Passively collected toys over 10s (3 -> 4)", 2.5, 2, 675))
    table.insert(es_passiveItems, Upgrade.new("es-psi", 5, "Passively collected toys over 10s (4 -> 5)", 2, 2, 1350))
    table.insert(es_passiveItems, Upgrade.new("es-psi", 6, "Passively collected toys over 10s (5 -> 6)", 1.66, 2, 2700))
    table.insert(es_passiveItems, Upgrade.new("es-psi", 7, "Passively collected toys over 10s (6 -> 8)", 1.25, 2, 5400))

    upgradesValues["es-dc"] = 0
    table.insert(es_diggingChance, Upgrade.new("es-dc", 1, "Finding rare toys chance (+0% -> +50%)", 1.5, 3, 75))
    table.insert(es_diggingChance, Upgrade.new("es-dc", 2, "Finding rare toys chance (+50% -> +100%)", 2, 3, 225))
    table.insert(es_diggingChance, Upgrade.new("es-dc", 3, "Finding rare toys chance (+100% -> +150%)", 2.5, 3, 675))
    table.insert(es_diggingChance, Upgrade.new("es-dc", 4, "Finding rare toys chance (+150% -> +200%)", 3, 3, 1350))
    table.insert(es_diggingChance, Upgrade.new("es-dc", 5, "Finding rare toys chance (+200% -> +300%)", 4, 3, 2700))
    table.insert(es_diggingChance, Upgrade.new("es-dc", 6, "Finding rare toys chance (+300% -> +400%)", 5, 3, 5400))

    --Business
    upgradesValues["b-ssr"] = 3
    table.insert(b_shopSellingRate, Upgrade.new("b-ssr", 1, "Shop selling rate (0.33/s -> 0.5/s)", 2, 4, 50))
    table.insert(b_shopSellingRate, Upgrade.new("b-ssr", 2, "Shop selling rate (0.5/s -> 0.8/s)", 1.25, 4, 150))
    table.insert(b_shopSellingRate, Upgrade.new("b-ssr", 3, "Shop selling rate (0.8/s -> 1.0/s)", 1, 4, 450))
    table.insert(b_shopSellingRate, Upgrade.new("b-ssr", 4, "Shop selling rate (1.0/s -> 1.66/s)", 0.6, 4, 1350))
    table.insert(b_shopSellingRate, Upgrade.new("b-ssr", 5, "Shop selling rate (1.66/s -> 3/s)", 0.33, 4, 2700))
end

function GetUpgrades(player:Player, upgradeType)
    local playerUpgrades = SaveModule.GetPlayerUpgrades(player)
    local upgradesList = {}

    --Excavation sites
    if(upgradeType == "Excavation Sites") then
        local dp_Level = playerUpgrades["es-dp"]
        local psi_Level = playerUpgrades["es-psi"]
        local dc_Level = playerUpgrades["es-dc"]

        if(dp_Level == nil) then dp_Level = 0 end
        if(psi_Level == nil) then psi_Level = 0 end
        if(dc_Level == nil) then dc_Level = 0 end

        for i, v in ipairs(es_diggingPoints) do
            if(v.level == dp_Level + 1) then
                table.insert(upgradesList, v)
            end
        end

        for i, v in ipairs(es_passiveItems) do
            if(v.level == psi_Level + 1) then
                table.insert(upgradesList, v)
            end
        end

        for i, v in ipairs(es_diggingChance) do
            if(v.level == dc_Level + 1) then
                table.insert(upgradesList, v)
            end
        end
    end

    --Business
    if(upgradeType == "Business") then
        local ssr_Level = playerUpgrades["b-ssr"]

        if(ssr_Level == nil) then ssr_Level = 0 end

        for i, v in ipairs(b_shopSellingRate) do
            if(v.level == ssr_Level + 1) then
                table.insert(upgradesList, v)
            end
        end
    end

    return upgradesList
end

function GetUpgradeIcon(upgradeId)
    return upgradeIcons[upgradeId]
end

function BuyAnUpgrade(player:Player, upgradeType, upgradeId, price)
    local coinsCollected = SaveModule.GetPlayerCoins(player)

    if(coinsCollected >= price) then
        print("Buy an upgrade", upgradeType, upgradeId)
        
        SaveModule.UpdateCoins(player, -price)
        SaveModule.IncreasePlayerUpgradeLevel(player, upgradeId)
    else 
        print("Not enough coins")
    end
end

function UpdateUpgradeLevel(player:Player, upgradeId, upgradeLevel)
    if UtilsModule.CheckIfLocalPlayer(player) ~= true then return end

    --Excavation sites
    if(upgradeId == "es-dp") then
        upgradesValues[upgradeId] = es_diggingPoints[upgradeLevel].value
        return
    end

    if(upgradeId == "es-psi") then
        upgradesValues[upgradeId] = es_passiveItems[upgradeLevel].value
        return
    end

    if(upgradeId == "es-dc") then
        upgradesValues[upgradeId] = es_diggingChance[upgradeLevel].value
        return
    end

    --Business
    if(upgradeId == "b-ssr") then
        upgradesValues[upgradeId] = b_shopSellingRate[upgradeLevel].value
        return
    end
end

function GetUpgradeValue(upgradeId:string)
    return upgradesValues[upgradeId]
end