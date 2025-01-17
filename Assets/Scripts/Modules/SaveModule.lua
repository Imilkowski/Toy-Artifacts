--!Type(Module)

localPlayersStorage = {}

function TrackPlayers(game)
    game.PlayerConnected:Connect(function(player)
        localPlayersStorage[player] = {
          player = player,
          coins = 0,
          toysCollected = {},
          toysInShop = {}
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
    if(localPlayersStorage[player].toysCollected[index] == nil) then
        localPlayersStorage[player].toysCollected[index] = 1
    else
        localPlayersStorage[player].toysCollected[index] += 1
    end
    
    print("Toys collected:")
    for i, v in ipairs(localPlayersStorage[player].toysCollected) do
        print(i, v)
    end
end