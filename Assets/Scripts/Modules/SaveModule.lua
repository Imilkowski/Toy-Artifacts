--!Type(Module)

local UtilsModule = require("UtilsModule")
local ToysModule = require("ToysModule")
local UIManagerModule = require("UIManagerModule")

localPlayerStorage = {}

function TrackPlayers(game)
    game.PlayerConnected:Connect(function(player)
        localPlayerStorage[player] = {
          player = player,
          coins = 100,
          toysCollected = {},
          toysInShop = {},
          toysRegister = {},
          shopSellingRate = 3.0
        }
    end)

    -- scene.PlayerLeft:Connect(function(player)
    --     localPlayersStorage[player] = nil
    --     print(player.name, "has left")
    -- end)
end

function self:ClientAwake()
    TrackPlayers(client)
end

function CollectAToy(player:Player, tier, rarity, toy)
    local index = (tier - 1) * 3 + rarity
    if(localPlayerStorage[player].toysCollected[index] == nil) then
        localPlayerStorage[player].toysCollected[index] = 1
    else
        localPlayerStorage[player].toysCollected[index] += 1
    end
    
    print("Toys collected:")
    for k, v in pairs(localPlayerStorage[player].toysCollected) do
        print(k, v)
    end
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

    if UtilsModule.CheckIfLocalPlayer(player) ~= true then return end
    UIManagerModule.UpdateToysAmount(CountToysInShop(player))
end

function GetShopSellingRate(player:Player)
    return localPlayerStorage[player].shopSellingRate
end

function SellRandomToy(player:Player)
    local toyTypeKey = GetRandomToyFromShop(player)

    if(toyTypeKey == nil) then return end

    UpdateCoins(player, ToysModule.GetToyPrice(toyTypeKey))
    print("Sold toy type:", toyTypeKey)
    print("Coins:", localPlayerStorage[player].coins)

    print("Toys in shop:")
    for k, v in pairs(localPlayerStorage[player].toysInShop) do
        if(v ~= 0) then
            print(k, v)
        end
    end

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

    -- print("Toys Register:")
    -- for k, v in pairs(localPlayerStorage[player].toysRegister) do
    --     print(k, v)
    -- end
end

function GetToyFromRegister(player:Player, toy:string)
    return localPlayerStorage[player].toysRegister[toy]
end

function UpdateCoins(player:Player, coinsChange)
    localPlayerStorage[player].coins += coinsChange

    if UtilsModule.CheckIfLocalPlayer(player) ~= true then return end

    UIManagerModule.UpdateCoinsAmount(localPlayerStorage[player].coins)
end

function GetPlayerCoins(player:Player)
    return localPlayerStorage[player].coins
end