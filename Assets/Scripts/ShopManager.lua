--!Type(Module)

-- local helloEvent = Event.new("HelloEvent")

-- local playersNumber = 0

-- Server Side

function self:ServerAwake()
    server.PlayerConnected:Connect(function(player)
        print(player.name .. " connected to the server")
    end)

    server.PlayerDisconnected:Connect(function(player)
        print(player.name .. " disconnected from the server")
    end)
end

-- function self:ServerAwake()

--     -- Listen for the event on the server side
--     scene.PlayerJoined:Connect(function(scene, player)
--         playersNumber += 1

--         local message = "Hello from server!"
--         -- Fire the event on the client side and pass the message
--         helloEvent:FireClient(player, message, playersNumber)
--     end)
-- end

-- Client Side

-- function self:ClientAwake()
--     local localPlayer = client.localPlayer

--     -- Fire the event on the server side
--     helloEvent:Connect(function(message, playerNum)
--         print(localPlayer.name .. ", server says: " .. message .. "You're " .. playerNum)
--     end)
-- end