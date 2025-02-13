--!Type(Module)

local SaveModule = require("SaveModule")

local assignPlayerToShopEvent = Event.new("Assign Player to a Shop") --Server
local returnShopAssignmentsEvent = Event.new("Return Shop Assignments") --Client

local shopsAssigned = {false, false, false, false, false, false} --Server
local shopsPlayers = {} --Server

--!SerializeField
local shops : {Shop} = {} --Client

-- Server Side

function self:ServerAwake()
    server.PlayerConnected:Connect(function(player)
        print(player.name .. " connected to the server")
    end)

    server.PlayerDisconnected:Connect(function(player)
        print(player.name .. " disconnected from the server")

        UnAssignPlayer(player)
    end)

    assignPlayerToShopEvent:Connect(function(player: Player)
        for i, v in ipairs(shopsAssigned) do
            if(v == false) then
                shopsAssigned[i] = true
                shopsPlayers[i] = player

                returnShopAssignmentsEvent:FireAllClients(shopsPlayers)
                return
            end
        end

        print("Couldn't find a free shop for a player " .. player.name)
        returnShopAssignmentsEvent:FireAllClients(shopsPlayers)
    end)
end

function UnAssignPlayer(player: Player)
    for k, p in pairs(shopsPlayers) do
        if(p == player) then
            shopsAssigned[k] = false
            shopsPlayers[k] = nil

            returnShopAssignmentsEvent:FireAllClients(shopsPlayers)
            return
        end
    end
end

-- Client Side

function self:ClientStart()
    returnShopAssignmentsEvent:Connect(function(shopsPlayers)
        for i, shop in ipairs(shops) do
            shop.AssignPlayer(shopsPlayers[i])
        end
    end)

    assignPlayerToShopEvent:FireServer()
end