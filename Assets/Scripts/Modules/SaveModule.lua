--!Type(Module)

local CloudSaveModule = require("CloudSaveModule")
local UtilsModule = require("UtilsModule")
local ToysModule = require("ToysModule")
local UIManagerModule = require("UIManagerModule")
local UpgradesModule = require("UpgradesModule")

localPlayerStorage = {}

function TrackPlayers(game)
    game.PlayerConnected:Connect(function(player)
        localPlayerStorage[player] = {
          player = player,
          coins = 0,
          toysCollected = {},
          toysInShop = {},
          toysRegister = {},
          upgrades = {},
          decorations = {},

          valueChanges = {
            coins = false,
            toysCollected = false,
            toysInShop = false,
            toysRegister = false,
            upgrades = false,
            decorations = false
          }
        }
    end)
end

function self:ClientAwake()
    TrackPlayers(client)

    Timer.Every(2.1, function()
        if(localPlayerStorage[client.localPlayer].valueChanges["toysCollected"]) then
            CloudSaveModule.SaveToysCollectedToCloud(localPlayerStorage[client.localPlayer].toysCollected)
            ValueSaved(client.localPlayer, "toysCollected")
        end

        if(localPlayerStorage[client.localPlayer].valueChanges["toysRegister"]) then
            CloudSaveModule.SaveToysRegisterToCloud(localPlayerStorage[client.localPlayer].toysRegister)
            ValueSaved(client.localPlayer, "toysRegister")
        end
    end)

    Timer.Every(6, function()
        if(localPlayerStorage[client.localPlayer].valueChanges["coins"]) then
            CloudSaveModule.SaveCoinsToCloud(localPlayerStorage[client.localPlayer].coins)
            ValueSaved(client.localPlayer, "coins")
        end

        if(localPlayerStorage[client.localPlayer].valueChanges["toysInShop"]) then
            CloudSaveModule.SaveToysInShopToCloud(localPlayerStorage[client.localPlayer].toysInShop)
            ValueSaved(client.localPlayer, "toysInShop")
        end
    end)
end

function self:ClientStart()
    LoadFromCloud()

    for i = 1, 9 do
        localPlayerStorage[client.localPlayer].decorations[i] = 10
    end
end

function LoadFromCloud()
    CloudSaveModule.LoadDataFromCloud()
end

function LoadValue(player:Player, valueKey, value)
    if(valueKey == "tutorialShown") then
        if(value == nil) then
            print("Show tutorial")
            UIManagerModule.SwitchTutorial()
            CloudSaveModule.SaveTutorialShownToCloud(true)
        end
    end

    if(value == nil) then return end

    if(valueKey == "coins") then
        UpdateCoins(player, value)
    end

    if(valueKey == "toysCollected") then
        localPlayerStorage[player].toysCollected = value
    end

    if(valueKey == "toysInShop") then
        localPlayerStorage[player].toysInShop = value
    end

    if(valueKey == "toysRegister") then
        localPlayerStorage[player].toysRegister = value
    end

    if(valueKey == "upgrades") then
        localPlayerStorage[player].upgrades = value
        LoadUpgradeLevels()
    end
end

function ValueUpdated(player:Player, valueKey)
    localPlayerStorage[player].valueChanges[valueKey] = true
end

function ValueSaved(player:Player, valueKey)
    localPlayerStorage[player].valueChanges[valueKey] = false
end

function CollectAToy(player:Player, tier, rarity, toy)
    local index = (tier - 1) * 3 + rarity
    if(localPlayerStorage[player].toysCollected[index] == nil) then
        localPlayerStorage[player].toysCollected[index] = 1
    else
        localPlayerStorage[player].toysCollected[index] += 1
    end

    ValueUpdated(player, "toysCollected")
    
    -- print("Toys collected:")
    -- for k, v in pairs(localPlayerStorage[player].toysCollected) do
    --     print(k, v)
    -- end
end

function LeaveToysAtShop(player:Player)
    for k, v in pairs(localPlayerStorage[player].toysCollected) do
        if(localPlayerStorage[player].toysInShop[k] == nil) then
            localPlayerStorage[player].toysInShop[k] = v
        else
            localPlayerStorage[player].toysInShop[k] += v
        end
    end

    table.clear(localPlayerStorage[player].toysCollected)

    --save to cloud immidiately
    CloudSaveModule.SaveToysInShopToCloud(localPlayerStorage[player].toysInShop)
    CloudSaveModule.SaveToysCollectedToCloud(localPlayerStorage[player].toysCollected)

    if UtilsModule.CheckIfLocalPlayer(player) ~= true then return end
    UIManagerModule.UpdateToysAmount(CountToysInShop(player))
end

function CollectAToyPassively(player:Player, tier, rarity, toy)
    local index = (tier - 1) * 3 + rarity

    if(localPlayerStorage[player].toysInShop[index] == nil) then
        localPlayerStorage[player].toysInShop[index] = 1
    else
        localPlayerStorage[player].toysInShop[index] += 1
    end

    ValueUpdated(player, "toysInShop")

    if UtilsModule.CheckIfLocalPlayer(player) ~= true then return end
    UIManagerModule.UpdateToysAmount(CountToysInShop(player))
end

function SellRandomToy(player:Player)
    local toyTypeKey = GetRandomToyFromShop(player)

    if(toyTypeKey == nil) then return end

    UpdateCoins(player, ToysModule.GetToyPrice(toyTypeKey))
    --print("Sold toy type:", toyTypeKey)

    -- print("Toys in shop:")
    -- for k, v in pairs(localPlayerStorage[player].toysInShop) do
    --     if(v ~= 0) then
    --         print(k, v)
    --     end
    -- end

    if UtilsModule.CheckIfLocalPlayer(player) ~= true then return end
    UIManagerModule.UpdateToysAmount(CountToysInShop(player))
end

function CountToysInShop(player:Player)
    local toysAmount = 0

    for k, v in pairs(localPlayerStorage[player].toysInShop) do
        toysAmount += v
    end

    return toysAmount
end

function GetRandomToyFromShop(player:Player)
    local keys = {}
    for key in pairs(localPlayerStorage[player].toysInShop) do
        if(localPlayerStorage[player].toysInShop[key] > 0) then
            table.insert(keys, key)
        end
    end

    if(#keys > 0) then
        local randomIndex = math.random(1, #keys)
        local chosenKey = keys[randomIndex]

        localPlayerStorage[player].toysInShop[chosenKey] -= 1

        ValueUpdated(player, "toysInShop")

        return chosenKey
    end

    return nil
end

function AddToyToRegister(player:Player, toy:string)
    if(localPlayerStorage[player].toysRegister[toy] == nil) then
        localPlayerStorage[player].toysRegister[toy] = 1
    else
        localPlayerStorage[player].toysRegister[toy] += 1
    end

    ValueUpdated(player, "toysRegister")

    -- print("Toys Register:")
    -- for k, v in pairs(localPlayerStorage[player].toysRegister) do
    --     print(k, v)
    -- end
end

function GetToyFromRegister(player:Player, toy:string)
    return localPlayerStorage[player].toysRegister[toy]
end

function GetToyRegister(player:Player)
    return localPlayerStorage[player].toysRegister
end

function UpdateCoins(player:Player, coinsChange)
    localPlayerStorage[player].coins += coinsChange

    ValueUpdated(player, "coins")

    if UtilsModule.CheckIfLocalPlayer(player) ~= true then return end

    UIManagerModule.UpdateCoinsAmount(localPlayerStorage[player].coins)
end

function GetPlayerCoins(player:Player)
    return localPlayerStorage[player].coins
end

function GetPlayerUpgrades(player:Player)
    return localPlayerStorage[player].upgrades
end

function GetPlayerUpgradeLevel(player:Player, upgradeId)
    return localPlayerStorage[player].upgrades[upgradeId]
end

function IncreasePlayerUpgradeLevel(player:Player, upgradeId)
    if(localPlayerStorage[player].upgrades[upgradeId] == nil) then
        localPlayerStorage[player].upgrades[upgradeId] = 1
    else
        localPlayerStorage[player].upgrades[upgradeId] += 1
    end

    --save to cloud immidiately
    CloudSaveModule.SaveUpgradesToCloud(localPlayerStorage[player].upgrades)
    CloudSaveModule.SaveCoinsToCloud(localPlayerStorage[player].coins)

    UpgradesModule.UpdateUpgradeLevel(player, upgradeId, localPlayerStorage[player].upgrades[upgradeId])
end

function LoadUpgradeLevels()
    player = client.localPlayer
    for k, v in pairs(localPlayerStorage[player].upgrades) do
        UpgradesModule.UpdateUpgradeLevel(player, k, v)
    end
end

function GetDecorationsOwned(player:Player)
    return localPlayerStorage[player].decorations
end

function UpdateDecoration(player:Player, decorationId, valueChange)
    --print("Decoration ID:", decorationId, ", value:", valueChange)

    if(localPlayerStorage[player].decorations[decorationId] == nil) then
        localPlayerStorage[player].decorations[decorationId] = valueChange
    else
        localPlayerStorage[player].decorations[decorationId] += valueChange
    end

    if(localPlayerStorage[player].decorations[decorationId] < 1) then
        localPlayerStorage[player].decorations[decorationId] = nil
    end
end