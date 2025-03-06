--!Type(Module)

local SaveModule = require("SaveModule")
local UtilsModule = require("UtilsModule")

--!SerializeField
local upgradeIcons: { Texture } = {}

--!SerializeField
local teleportsManager: TeleportsManager = nil

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
local b_teleports = {}

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
    table.insert(es_diggingPoints, Upgrade.new("es-dp", 5, "Digging points number (6 -> 7)", 7, 1, 2025))
    table.insert(es_diggingPoints, Upgrade.new("es-dp", 6, "Digging points number (7 -> 8)", 8, 1, 4050))

    upgradesValues["es-psi"] = 100000
    table.insert(es_passiveItems, Upgrade.new("es-psi", 1, "Passively collected toys over 10s (0 -> 1)", 10, 2, 25))
    table.insert(es_passiveItems, Upgrade.new("es-psi", 2, "Passively collected toys over 10s (1 -> 2)", 5, 2, 75))
    table.insert(es_passiveItems, Upgrade.new("es-psi", 3, "Passively collected toys over 10s (2 -> 3)", 3.33, 2, 225))
    table.insert(es_passiveItems, Upgrade.new("es-psi", 4, "Passively collected toys over 10s (3 -> 4)", 2.5, 2, 675))
    table.insert(es_passiveItems, Upgrade.new("es-psi", 5, "Passively collected toys over 10s (4 -> 5)", 2, 2, 2025))
    table.insert(es_passiveItems, Upgrade.new("es-psi", 6, "Passively collected toys over 10s (5 -> 6)", 1.66, 2, 3040))
    table.insert(es_passiveItems, Upgrade.new("es-psi", 7, "Passively collected toys over 10s (6 -> 7)", 1.43, 2, 4560))
    table.insert(es_passiveItems, Upgrade.new("es-psi", 8, "Passively collected toys over 10s (7 -> 8)", 1.25, 2, 6840))

    upgradesValues["es-dc"] = 1.75
    table.insert(es_diggingChance, Upgrade.new("es-dc", 1, "Finding rare toys chance (+0% -> +100%)", 2.5, 3, 75))
    table.insert(es_diggingChance, Upgrade.new("es-dc", 2, "Finding rare toys chance (+100% -> +200%)", 3, 3, 225))
    table.insert(es_diggingChance, Upgrade.new("es-dc", 3, "Finding rare toys chance (+200% -> +300%)", 4, 3, 675))
    table.insert(es_diggingChance, Upgrade.new("es-dc", 4, "Finding rare toys chance (+300% -> +400%)", 5, 3, 2025))
    table.insert(es_diggingChance, Upgrade.new("es-dc", 5, "Finding rare toys chance (+400% -> +500%)", 6, 3, 3040))
    table.insert(es_diggingChance, Upgrade.new("es-dc", 6, "Finding rare toys chance (+500% -> +600%)", 7, 3, 4560))
    --table.insert(es_diggingChance, Upgrade.new("es-dc", 7, "Finding rare toys chance (+500% -> +600%)", 8, 3, 6840))

    --Business
    upgradesValues["b-ssr"] = 3
    table.insert(b_shopSellingRate, Upgrade.new("b-ssr", 1, "Shop selling rate (0.33/s -> 0.5/s)", 2, 4, 50))
    table.insert(b_shopSellingRate, Upgrade.new("b-ssr", 2, "Shop selling rate (0.5/s -> 0.8/s)", 1.25, 4, 150))
    table.insert(b_shopSellingRate, Upgrade.new("b-ssr", 3, "Shop selling rate (0.8/s -> 1.0/s)", 1, 4, 450))
    table.insert(b_shopSellingRate, Upgrade.new("b-ssr", 4, "Shop selling rate (1.0/s -> 1.66/s)", 0.6, 4, 1350))
    table.insert(b_shopSellingRate, Upgrade.new("b-ssr", 5, "Shop selling rate (1.66/s -> 3/s)", 0.33, 4, 2700))

    upgradesValues["b-t"] = false
    table.insert(b_teleports, Upgrade.new("b-t", 1, "Unlock teleports on islands", true, 5, 1000))
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
        local t_Level = playerUpgrades["b-t"]

        if(ssr_Level == nil) then ssr_Level = 0 end
        if(t_Level == nil) then t_Level = 0 end

        for i, v in ipairs(b_shopSellingRate) do
            if(v.level == ssr_Level + 1) then
                table.insert(upgradesList, v)
            end
        end

        for i, v in ipairs(b_teleports) do
            if(v.level == t_Level + 1) then
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

        if(upgradeId == "b-t") then
            BoughtTeleportsUpgrade()
        end
    else 
        print("Not enough coins")
    end
end

function BoughtTeleportsUpgrade()
    teleportsManager.ActivateTeleports(true)
end

function UpdateUpgradeLevel(player:Player, upgradeId, upgradeLevel)
    if UtilsModule.CheckIfLocalPlayer(player) ~= true then return end

    local level = upgradeLevel

    --Excavation sites
    if(upgradeId == "es-dp") then
        while(level > 0) do
            if(es_diggingPoints[level] ~= nil) then
                upgradesValues[upgradeId] = es_diggingPoints[level].value
                return
            end

            level -= 1
        end

        return
    end

    if(upgradeId == "es-psi") then
        while(level > 0) do
            if(es_passiveItems[level] ~= nil) then
                upgradesValues[upgradeId] = es_passiveItems[level].value
                return
            end

            level -= 1
        end

        return
    end

    if(upgradeId == "es-dc") then
        while(level > 0) do
            if(es_diggingChance[level] ~= nil) then
                upgradesValues[upgradeId] = es_diggingChance[level].value
                return
            end

            level -= 1
        end

        return
    end

    --Business
    if(upgradeId == "b-ssr") then
        while(level > 0) do
            if(b_shopSellingRate[level] ~= nil) then
                upgradesValues[upgradeId] = b_shopSellingRate[level].value
                return
            end

            level -= 1
        end

        return
    end

    if(upgradeId == "b-t") then
        while(level > 0) do
            if(b_teleports[level] ~= nil) then
                upgradesValues[upgradeId] = b_teleports[level].value
                return
            end

            level -= 1
        end

        return
    end
end

function GetUpgradeValue(upgradeId:string)
    return upgradesValues[upgradeId]
end