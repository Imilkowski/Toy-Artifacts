--!Type(Module)

local DecorationsModule = require("DecorationsModule")
local SaveModule = require("SaveModule")

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
    table.insert(decorationItems, ItemToBuy.new(3, 250))
    table.insert(decorationItems, ItemToBuy.new(4, 500))
    table.insert(decorationItems, ItemToBuy.new(5, 500))
    table.insert(decorationItems, ItemToBuy.new(6, 500))
    table.insert(decorationItems, ItemToBuy.new(7, 250))
    table.insert(decorationItems, ItemToBuy.new(8, 250))
    table.insert(decorationItems, ItemToBuy.new(9, 250))
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

function BuyAnItem(player:Player, shopType, itemId)
    local coinsCollected = SaveModule.GetPlayerCoins(player)

    local item
    if(shopType == "Decorations") then
        item = decorationItems[itemId]
    end

    if(coinsCollected >= item.price) then
        SaveModule.UpdateCoins(player, -item.price)
        
        if(shopType == "Decorations") then
            SaveModule.BuyADecoration(player, item.itemId)
        end
    else 
        print("Not enough coins")
    end
end