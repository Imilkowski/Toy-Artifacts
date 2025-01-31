--!Type(Module)

--!SerializeField
local upgradeIcons: { Texture } = {}

Upgrade = {}
Upgrade.__index = Upgrade

function Upgrade.new(description, iconId, price)
    local myClass = setmetatable({}, Upgrade)

	myClass.description = description
    myClass.iconId = iconId
    myClass.price = price
	
	return myClass
end

local upgrades = {}

function self:Awake()
    local status, result = pcall(function()
        InitializeUpgradesTables()
    end)
    
    if not status then end
end

function InitializeUpgradesTables()
    table.insert(upgrades, Upgrade.new("Upgrade 1", 1, 50))
    table.insert(upgrades, Upgrade.new("Upgrade 2", 2, 100))
    table.insert(upgrades, Upgrade.new("Upgrade 3", 3, 200))
end

function GetUpgrades()
    return upgrades
end

function GetUpgradeIcon(upgradeId)
    return upgradeIcons[upgradeId]
end