--!Type(Module)

local SaveModule = require("SaveModule")

local assignPlayerToShopEvent = Event.new("Assign Player to a Shop") --Server
local returnShopIdEvent = Event.new("Return Shop Id") --Client

local shopsAssigned = {false, false, false, false, false, false} --Server

--!SerializeField
local shops : {Shop} = {} --Client

-- Server Side

function self:ServerAwake()
    server.PlayerConnected:Connect(function(player)
        print(player.name .. " connected to the server")
    end)

    server.PlayerDisconnected:Connect(function(player)
        print(player.name .. " disconnected from the server")
    end)

    assignPlayerToShopEvent:Connect(function(player: Player)
        for i, v in ipairs(shopsAssigned) do
            --print(i, tostring(v))
            if(v == false) then
                shopsAssigned[i] = true
                returnShopIdEvent:FireClient(player, i)
                return
            end
        end

        print("Couldn't find a free shop for a player " .. player.name)
        returnShopIdEvent:FireClient(player, -1)
    end)
end

-- Client Side

function self:ClientStart()
    returnShopIdEvent:Connect(function(shopId)
        print(client.localPlayer.name .. " given a shopId: " .. shopId)
        SaveModule.SetPlayerShopId(client.localPlayer, shopId)
        
        for i, shop in ipairs(shops) do
            shop.AssignPlayer()
        end
    end)

    assignPlayerToShopEvent:FireServer()
end