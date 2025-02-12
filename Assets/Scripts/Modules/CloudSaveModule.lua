--!Type(Module)

local saveCoinsEvent = Event.new("Coins Save")
local saveToysCollectedEvent = Event.new("Toys Collected Save")
local saveToysInShopEvent = Event.new("Toys In Shop Save")
local saveToysRegisterEvent = Event.new("Toys Register Save")
local saveUpgradesEvent = Event.new("Upgrades Save")

-- Server Side

function self:ServerAwake()
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
end

-- Client Side


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