--!Type(Module)

local SaveModule = require("SaveModule")

--!SerializeField
local upgradeIcons: { Texture } = {}

Upgrade = {}
Upgrade.__index = Upgrade

function Upgrade.new(upgradeId, level, description, iconId, price)
    local myClass = setmetatable({}, Upgrade)

    myClass.upgradeId = upgradeId
    myClass.level = level
	myClass.description = description
    myClass.iconId = iconId
    myClass.price = price
	
	return myClass
end

--Excavation sites
local es_diggingPoints = {}
local es_passiveItems = {}

function self:Awake()
    local status, result = pcall(function()
        InitializeUpgradesTables()
    end)
    
    if not status then end
end

function InitializeUpgradesTables()
    --Excavation sites
    table.insert(es_diggingPoints, Upgrade.new("es-dp", 1, "Digging points number (2 -> 3)", 1, 25))
    table.insert(es_diggingPoints, Upgrade.new("es-dp", 2, "Digging points number (3 -> 4)", 1, 50))
    table.insert(es_diggingPoints, Upgrade.new("es-dp", 3, "Digging points number (4 -> 5)", 1, 100))
    table.insert(es_diggingPoints, Upgrade.new("es-dp", 4, "Digging points number (4 -> 5)", 1, 200))

    table.insert(es_passiveItems, Upgrade.new("es-psi", 1, "Passively collected items over 10s (0 -> 1)", 2, 75))
    table.insert(es_passiveItems, Upgrade.new("es-psi", 2, "Passively collected items over 10s (1 -> 2)", 2, 150))
    table.insert(es_passiveItems, Upgrade.new("es-psi", 3, "Passively collected items over 10s (2 -> 3)", 2, 300))
    table.insert(es_passiveItems, Upgrade.new("es-psi", 4, "Passively collected items over 10s (3 -> 4)", 2, 600))
end

function GetUpgrades(player:Player, upgradeType)
    local playerUpgrades = SaveModule.GetPlayerUpgrades(player)
    local upgradesList = {}

    --Excavation sites
    if(upgradeType == "Excavation Sites") then
        local dp_Level = playerUpgrades["es-dp"]
        local psi_Level = playerUpgrades["es-psi"]

        if(dp_Level == nil) then dp_Level = 0 end
        if(psi_Level == nil) then psi_Level = 0 end

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
    end

    return upgradesList
end

function GetUpgradeIcon(upgradeId)
    return upgradeIcons[upgradeId]
end

function BuyAnUpgrade(player:Player, upgradeType, upgradeId)
    print("Buy an upgrade", upgradeType, upgradeId)

    
end