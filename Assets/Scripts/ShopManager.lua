--!Type(Module)

local SaveModule = require("SaveModule")

local assignPlayerToShopEvent = Event.new("Assign Player to a Shop") --Server
local returnShopAssignmentsEvent = Event.new("Return Shop Assignments") --Client
local updateAllToyRegistersEvent = Event.new("Update All Toy Registers") --Server
local updateToyRegistersEvent = Event.new("Update Toy Registers") --Client
local requestPlayerShopUpdateEvent = Event.new("Request Player Shop Update") --Server

local shopsAssigned = {false, false, false, false, false, false} --Server
local shopsPlayers = {} --Server
local playersToyRegisters = {} --Server

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

    assignPlayerToShopEvent:Connect(function(player: Player, toysRegister)
        playersToyRegisters[player] = toysRegister

        for i, v in ipairs(shopsAssigned) do
            if(v == false) then
                shopsAssigned[i] = true
                shopsPlayers[i] = player

                returnShopAssignmentsEvent:FireAllClients(shopsPlayers, player, toysRegister)
                return
            end
        end

        print("Couldn't find a free shop for a player " .. player.name)
        returnShopAssignmentsEvent:FireAllClients(shopsPlayers, player, toysRegister)
    end)

    updateAllToyRegistersEvent:Connect(function(player: Player, toysRegister)
        playersToyRegisters[player] = toysRegister

        updateToyRegistersEvent:FireAllClients(player, toysRegister)
    end)

    requestPlayerShopUpdateEvent:Connect(function(player: Player, requestedPlayer: Player)
        updateToyRegistersEvent:FireClient(player, requestedPlayer, playersToyRegisters[requestedPlayer])
    end)
end

function UnAssignPlayer(player: Player)
    for k, p in pairs(shopsPlayers) do
        if(p == player) then
            shopsAssigned[k] = false
            shopsPlayers[k] = nil

            returnShopAssignmentsEvent:FireAllClients(shopsPlayers, nil, nil)
            return
        end
    end
end

-- Client Side

function self:ClientStart()
    returnShopAssignmentsEvent:Connect(function(shopsPlayers, playerToUpdate, playerToyRegister)
        for i, shop in ipairs(shops) do
            if(playerToUpdate == shopsPlayers[i]) then
                shop.AssignPlayer(shopsPlayers[i], playerToyRegister)
            else
                shop.AssignPlayer(shopsPlayers[i], nil)
            end
        end
    end)

    updateToyRegistersEvent:Connect(function(player: Player, toysRegister)
        print("Updated shop " .. player.name)
        for i, shop in ipairs(shops) do
            if(shop.assignedPlayer == player) then
                shop.UpdateTables(toysRegister)
                return
            end
        end
    end)

    Timer.After(0.5, function() 
        assignPlayerToShopEvent:FireServer(SaveModule.GetToyRegister(client.localPlayer))
    end)
end

function OnToysLeftAtShop(toysRegister)
    print(client.localPlayer.name, "left toys at the shop")

    updateAllToyRegistersEvent:FireServer(toysRegister)
end

function UpdatePlayerShop(requestedPlayer: Player)
    requestPlayerShopUpdateEvent:FireServer(requestedPlayer)
end