--!Type(Module)

local DecorationsModule = require("DecorationsModule")

ItemToBuy = {}
ItemToBuy.__index = ItemToBuy

function ItemToBuy.new(itemId, price)
    local myClass = setmetatable({}, ItemToBuy)

    myClass.itemId = itemId
    myClass.price = price
	
	return myClass
end

local decorationItems = {}

function self:Awake()
    local status, result = pcall(function()
        InitializeItemTables()
    end)
    
    if not status then end
end

function InitializeItemTables()
    --Decorations
    table.insert(decorationItems, ItemToBuy.new(1, 250))
    table.insert(decorationItems, ItemToBuy.new(2, 250))
    table.insert(decorationItems, ItemToBuy.new(3, 500))
end

function GetItems(shopType)
    if(shopType == "Decorations") then
        return decorationItems
    end
end

function GetItemIcon(shopType, itemId)
    if(shopType == "Decorations") then
        return DecorationsModule.GetDecorationIcon(itemId)
    end
end