--!Type(Module)

local SaveModule = require("SaveModule")

-- Server Side

function self:ServerAwake()
    server.PlayerConnected:Connect(function(player)
        print(player.name .. " connected to the server")
    end)

    server.PlayerDisconnected:Connect(function(player)
        print(player.name .. " disconnected from the server")
    end)
end

-- Client Side

function self:ClientStart()
    AssignPlayerAShop()
end

function AssignPlayerAShop()
    SaveModule.SetPlayerShopId(client.localPlayer, 1)
end