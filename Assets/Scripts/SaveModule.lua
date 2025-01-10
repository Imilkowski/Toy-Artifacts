--!Type(Module)

localPlayersStorage = {}

function TrackPlayers(game)
    game.PlayerConnected:Connect(function(player)
        localPlayersStorage[player.name] = {
          player = player,
          coins = 0
        }
    end)
end

function self:ClientAwake()
    TrackPlayers(client)
end

function CollectAToy(player:Player, toyKey)
    --add a toy
    localPlayersStorage[player.name].coins += 1
    print(localPlayersStorage[player.name].player.name, localPlayersStorage[player.name].coins)
end