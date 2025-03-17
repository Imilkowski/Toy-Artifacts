--!Type(Module)

local SaveModule = require("SaveModule")

local assignPlayerToShopEvent = Event.new("Assign Player to a Shop") --Server
local returnShopAssignmentsEvent = Event.new("Return Shop Assignments") --Client
local updateAllShopsEvent = Event.new("Update All Shops") --Server
local updateShopsEvent = Event.new("Update Shops") --Client
local requestPlayerShopUpdateEvent = Event.new("Request Player Shop Update") --Server

local shopsAssigned = {false, false, false, false, false, false} --Server
local shopsPlayers = {} --Server
local playersToyRegisters = {} --Server
local playersDecorationsPlaced = {} --Server
local playersDecorationsPlacedRotations = {} --Server

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

    assignPlayerToShopEvent:Connect(function(player: Player, toysRegister, decorationsPlaced, decorationsPlacedRotations)
        playersToyRegisters[player] = toysRegister
        playersDecorationsPlaced[player] = decorationsPlaced
        playersDecorationsPlacedRotations[player] = decorationsPlacedRotations

        for i, v in ipairs(shopsAssigned) do
            if(v == false) then
                shopsAssigned[i] = true
                shopsPlayers[i] = player

                returnShopAssignmentsEvent:FireAllClients(shopsPlayers, player, toysRegister, decorationsPlaced, decorationsPlacedRotations)
                return
            end
        end

        print("Couldn't find a free shop for a player " .. player.name)
        returnShopAssignmentsEvent:FireAllClients(shopsPlayers, player, toysRegister, decorationsPlaced, decorationsPlacedRotations)
    end)

    updateAllShopsEvent:Connect(function(player: Player, toysRegister, decorationsPlaced, decorationsPlacedRotations)
        playersToyRegisters[player] = toysRegister
        playersDecorationsPlaced[player] = decorationsPlaced
        playersDecorationsPlacedRotations[player] = decorationsPlacedRotations

        updateShopsEvent:FireAllClients(player, toysRegister, decorationsPlaced, decorationsPlacedRotations)
    end)

    requestPlayerShopUpdateEvent:Connect(function(player: Player, requestedPlayer: Player)
        updateShopsEvent:FireClient(player, requestedPlayer, playersToyRegisters[requestedPlayer], playersDecorationsPlaced[requestedPlayer], playersDecorationsPlacedRotations[requestedPlayer])
    end)
end

function UnAssignPlayer(player: Player)
    for k, p in pairs(shopsPlayers) do
        if(p == player) then
            shopsAssigned[k] = false
            shopsPlayers[k] = nil

            returnShopAssignmentsEvent:FireAllClients(shopsPlayers, nil, nil, nil, nil)
            return
        end
    end
end

-- Client Side

function self:ClientStart()
    returnShopAssignmentsEvent:Connect(function(shopsPlayers, playerToUpdate, playerToyRegister, playerDecorationsPlaced, playerDecorationsPlacedRotations)
        for i, shop in ipairs(shops) do
            if(playerToUpdate == shopsPlayers[i]) then
                shop.AssignPlayer(shopsPlayers[i], playerToyRegister, playerDecorationsPlaced, playerDecorationsPlacedRotations)
            else
                shop.AssignPlayer(shopsPlayers[i], nil, nil, nil)
            end
        end
    end)

    updateShopsEvent:Connect(function(player: Player, toysRegister, decorationsPlaced, decorationsPlacedRotations)
        print("Updated shop " .. player.name)
        for i, shop in ipairs(shops) do
            if(shop.assignedPlayer == player) then
                shop.UpdateShop(toysRegister, decorationsPlaced, decorationsPlacedRotations)
                return
            end
        end
    end)

    Timer.After(0.5, function() 
        assignPlayerToShopEvent:FireServer(SaveModule.GetToyRegister(client.localPlayer), SaveModule.GetDecorationsPlaced(client.localPlayer), SaveModule.GetDecorationsPlacedRotations(client.localPlayer))
    end)
end

function OnToysLeftAtShop(toysRegister, decorationsPlaced, decorationsPlacedRotations)
    print(client.localPlayer.name, "left toys at the shop")

    updateAllShopsEvent:FireServer(toysRegister, decorationsPlaced, decorationsPlacedRotations)
end

function UpdatePlayerShop(requestedPlayer: Player)
    requestPlayerShopUpdateEvent:FireServer(requestedPlayer)
end