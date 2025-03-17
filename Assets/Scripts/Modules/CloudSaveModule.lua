--!Type(Module)

local SaveModule = require("SaveModule")

local saveCoinsEvent = Event.new("Coins Save")
local saveToysCollectedEvent = Event.new("Toys Collected Save")
local saveToysInShopEvent = Event.new("Toys In Shop Save")
local saveToysRegisterEvent = Event.new("Toys Register Save")
local saveUpgradesEvent = Event.new("Upgrades Save")
local saveTutorialShownEvent = Event.new("Tutorial Shown Save")
local saveDecorationsOwnedEvent = Event.new("Decorations Owned Save")
local saveDecorationsPlacedEvent = Event.new("Decorations Placed Save")

local loadDataEvent = Event.new("Data Load")

local loadCoinsEvent = Event.new("Coins Load")
local loadToysCollectedEvent = Event.new("Toys Collected Load")
local loadToysInShopEvent = Event.new("Toys In Shop Load")
local loadToysRegisterEvent = Event.new("Toys Register Load")
local loadUpgradesEvent = Event.new("Upgrades Load")
local loadTutorialShownEvent = Event.new("Tutorial Shown Load")
local loadDecorationsOwnedEvent = Event.new("Decorations Owned Load")
local loadDecorationsPlacedEvent = Event.new("Decorations Placed Load")

-- Server Side

function self:ServerAwake()
    --Saving
    saveCoinsEvent:Connect(function(player: Player, coins:number)
        --print(player.name .. " saved Coins to cloud")

        Storage.SetPlayerValue(player, "Coins", coins, function(errorCode)
            if(errorCode == not nil) then
                print(`The error code was {StorageError[errorCode]}`)
            end
        end)
    end)

    saveToysCollectedEvent:Connect(function(player: Player, toysCollected)
        --print(player.name .. " saved Toys Collected to cloud")

        Storage.SetPlayerValue(player, "Toys Collected", toysCollected, function(errorCode)
            if(errorCode == not nil) then
                print(`The error code was {StorageError[errorCode]}`)
            end
        end)
    end)

    saveToysInShopEvent:Connect(function(player: Player, toysInShop)
        --print(player.name .. " saved Toys In Shop to cloud")

        Storage.SetPlayerValue(player, "Toys In Shop", toysInShop, function(errorCode)
            if(errorCode == not nil) then
                print(`The error code was {StorageError[errorCode]}`)
            end
        end)
    end)

    saveToysRegisterEvent:Connect(function(player: Player, toysRegister)
        --print(player.name .. " saved Toys Register to cloud")

        Storage.SetPlayerValue(player, "Toys Register", toysRegister, function(errorCode)
            if(errorCode == not nil) then
                print(`The error code was {StorageError[errorCode]}`)
            end
        end)
    end)

    saveUpgradesEvent:Connect(function(player: Player, upgrades)
        --print(player.name .. " saved Upgrades to cloud")

        Storage.SetPlayerValue(player, "Upgrades", upgrades, function(errorCode)
            if(errorCode == not nil) then
                print(`The error code was {StorageError[errorCode]}`)
            end
        end)
    end)

    saveTutorialShownEvent:Connect(function(player: Player, tutorialShowed)
        --print(player.name .. " saved Tutorial Shown to cloud")

        Storage.SetPlayerValue(player, "Tutorial Shown", tutorialShowed, function(errorCode)
            if(errorCode == not nil) then
                print(`The error code was {StorageError[errorCode]}`)
            end
        end)
    end)

    saveDecorationsOwnedEvent:Connect(function(player: Player, decorationsOwned)
        --print(player.name .. " saved Tutorial Shown to cloud")

        Storage.SetPlayerValue(player, "Decorations Owned", decorationsOwned, function(errorCode)
            if(errorCode == not nil) then
                print(`The error code was {StorageError[errorCode]}`)
            end
        end)
    end)

    saveDecorationsPlacedEvent:Connect(function(player: Player, decorationsPlaced)
        --print(player.name .. " saved Tutorial Shown to cloud")

        Storage.SetPlayerValue(player, "Decorations Placed", decorationsPlaced, function(errorCode)
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

        Storage.GetPlayerValue(player, "Tutorial Shown", function(tutorialShown)
            loadTutorialShownEvent:FireClient(player, tutorialShown)
        end)

        Storage.GetPlayerValue(player, "Decorations Owned", function(decorationsOwned)
            loadDecorationsOwnedEvent:FireClient(player, decorationsOwned)
        end)

        Storage.GetPlayerValue(player, "Decorations Placed", function(decorationsPlaced)
            loadDecorationsPlacedEvent:FireClient(player, decorationsPlaced)
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

    loadTutorialShownEvent:Connect(function(tutorialShown)
        SaveModule.LoadValue(client.localPlayer, "tutorialShown", tutorialShown)
    end)

    loadDecorationsOwnedEvent:Connect(function(decorationsOwned)
        SaveModule.LoadValue(client.localPlayer, "decorationsOwned", decorationsOwned)
    end)

    loadDecorationsPlacedEvent:Connect(function(decorationsPlaced)
        SaveModule.LoadValue(client.localPlayer, "decorationsPlaced", decorationsPlaced)
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

function SaveTutorialShownToCloud(tutorialShown)
    saveTutorialShownEvent:FireServer(tutorialShown)
end

function SaveDecorationsOwnedToCloud(decorationsOwned)
    saveDecorationsOwnedEvent:FireServer(decorationsOwned)
end

function SaveDecorationsPlacedToCloud(decorationsPlaced)
    saveDecorationsPlacedEvent:FireServer(decorationsPlaced)
end

--Loading

function LoadDataFromCloud()
    loadDataEvent:FireServer()
end