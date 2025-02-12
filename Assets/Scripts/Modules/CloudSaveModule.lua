--!Type(Module)

local SaveModule = require("SaveModule")

local saveCoinsEvent = Event.new("Coins Save")
local saveToysCollectedEvent = Event.new("Toys Collected Save")
local saveToysInShopEvent = Event.new("Toys In Shop Save")
local saveToysRegisterEvent = Event.new("Toys Register Save")
local saveUpgradesEvent = Event.new("Upgrades Save")

local loadDataEvent = Event.new("Data Load")

local loadCoinsEvent = Event.new("Coins Event")
local loadToysCollectedEvent = Event.new("Toys Collected Event")
local loadToysInShopEvent = Event.new("Toys In Shop Event")
local loadToysRegisterEvent = Event.new("Toys Register Event")
local loadUpgradesEvent = Event.new("Upgrades Event")

-- Server Side

function self:ServerAwake()
    --Saving
    saveCoinsEvent:Connect(function(player: Player, coins:number)
        print(player.name .. " saved Coins to cloud")

        Storage.SetPlayerValue(player, "Coins", coins, function(errorCode)
            if(errorCode == not nil) then
                print(`The error code was {StorageError[errorCode]}`)
            end
        end)
    end)

    saveToysCollectedEvent:Connect(function(player: Player, toysCollected)
        print(player.name .. " saved Toys Collected to cloud")

        Storage.SetPlayerValue(player, "Toys Collected", toysCollected, function(errorCode)
            if(errorCode == not nil) then
                print(`The error code was {StorageError[errorCode]}`)
            end
        end)
    end)

    saveToysInShopEvent:Connect(function(player: Player, toysInShop)
        print(player.name .. " saved Toys In Shop to cloud")

        Storage.SetPlayerValue(player, "Toys In Shop", toysInShop, function(errorCode)
            if(errorCode == not nil) then
                print(`The error code was {StorageError[errorCode]}`)
            end
        end)
    end)

    saveToysRegisterEvent:Connect(function(player: Player, toysRegister)
        print(player.name .. " saved Toys Register to cloud")

        Storage.SetPlayerValue(player, "Toys Register", toysRegister, function(errorCode)
            if(errorCode == not nil) then
                print(`The error code was {StorageError[errorCode]}`)
            end
        end)
    end)

    saveUpgradesEvent:Connect(function(player: Player, upgrades)
        print(player.name .. " saved Upgrades to cloud")

        Storage.SetPlayerValue(player, "Upgrades", upgrades, function(errorCode)
            if(errorCode == not nil) then
                print(`The error code was {StorageError[errorCode]}`)
            end
        end)
    end)

    --Loading
    loadDataEvent:Connect(function(player: Player)
        print(player.name .. " loaded Data from cloud")

        Storage.GetPlayerValue(player, "Coins", function(coins)
            loadCoinsEvent:FireClient(player, coins)
        end)

        Storage.GetPlayerValue(player, "Toys Collected", function(toysCollected)
            loadToysCollectedEvent:FireClient(player, toysCollected)
        end)

        Storage.GetPlayerValue(player, "Toys In Shop", function(toysInShop)
            loadToysInShopEvent:FireClient(player, toysInShop)
        end)

        Storage.GetPlayerValue(player, "Toys Register", function(toysRegister)
            loadToysRegisterEvent:FireClient(player, toysRegister)
        end)

        Storage.GetPlayerValue(player, "Upgrades", function(upgrades)
            loadUpgradesEvent:FireClient(player, upgrades)
        end)
    end)
end

-- Client Side

function self:ClientAwake()
    loadCoinsEvent:Connect(function(coins)
        SaveModule.LoadValue(client.localPlayer, "coins", coins)
    end)

    loadToysCollectedEvent:Connect(function(toysCollected)
        SaveModule.LoadValue(client.localPlayer, "toysCollected", toysCollected)
    end)

    loadToysInShopEvent:Connect(function(toysInShop)
        SaveModule.LoadValue(client.localPlayer, "toysInShop", toysInShop)
    end)

    loadToysRegisterEvent:Connect(function(toysRegister)
        SaveModule.LoadValue(client.localPlayer, "toysRegister", toysRegister)
    end)

    loadUpgradesEvent:Connect(function(upgrades)
        SaveModule.LoadValue(client.localPlayer, "upgrades", upgrades)
    end)
end

--Saving

function SaveCoinsToCloud(coins)
    saveCoinsEvent:FireServer(coins)
end

function SaveToysCollectedToCloud(toysCollected)
    saveToysCollectedEvent:FireServer(toysCollected)
end

function SaveToysInShopToCloud(toysInShop)
    saveToysInShopEvent:FireServer(toysInShop)
end

function SaveToysRegisterToCloud(toysRegister)
    saveToysRegisterEvent:FireServer(toysRegister)
end

function SaveUpgradesToCloud(upgrades)
    saveUpgradesEvent:FireServer(upgrades)
end

--Loading

function LoadDataFromCloud()
    loadDataEvent:FireServer()
end