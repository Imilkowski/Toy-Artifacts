--!Type(Module)

localPlayersStorage = {}

function TrackPlayers(game)
    game.PlayerConnected:Connect(function(player)
        localPlayersStorage[player] = {
          player = player,
          coins = 0
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

function CollectAToy(player:Player, toyName)
    --add a toy
    localPlayersStorage[player].coins += 1
    print(localPlayersStorage[player].player.name, localPlayersStorage[player].coins)
end