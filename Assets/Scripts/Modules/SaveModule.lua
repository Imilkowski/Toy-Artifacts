--!Type(Module)

localPlayerStorage = {}

function TrackPlayers(game)
    game.PlayerConnected:Connect(function(player)
        localPlayerStorage[player] = {
          player = player,
          coins = 0,
          toysCollected = {},
          toysInShop = {},
          shopSellingRate = 2.0
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
end

function GetShopSellingRate(player:Player)
    return localPlayerStorage[player].shopSellingRate
end

function SellRandomToy(player:Player)
    print("Toys in shop:")
    for k, v in pairs(localPlayerStorage[player].toysInShop) do
        print(k, v)
    end
end