--!Type(Module)

--Tier I
    --Common
        --Toy 1
        --Toy 2
        --...
    --Rare
        --Toy 1
        --Toy 2
        --...
--Tier II
    --...

local SaveModule = require("SaveModule")
local UpgradesModule = require("UpgradesModule")

ToyRarity = {}
ToyRarity.__index = ToyRarity

function ToyRarity.new(rarity, toysTable)
    local myClass = setmetatable({}, ToyRarity)

	myClass.rarity = rarity
    myClass.toys = toysTable
	
	return myClass
end

local tiers = {}

--!SerializeField
local toyModels: { GameObject } = {}
local _toyModels = {}

--!SerializeField
local toysIcons: { Texture } = {}
--!SerializeField
local toysIconsUndiscovered: { Texture } = {}

--!SerializeField
local toyPrices: { number } = {}

function self:Awake()
    local status, result = pcall(function()
        InitializeToyTables()
    end)
    
    if not status then end
end

function InitializeToyTables()
    -- Toy Models
    for i, v in ipairs(toyModels) do
        _toyModels[v.name] = v
    end

    -- -- Toy Icons
    -- for i, v in ipairs(toyIcons) do
    --     _toyIcons[v.name] = v
    -- end

    -- Tier I
    local tierI = {}
    table.insert(tierI, ToyRarity.new("Common", {"Dolphin", "Cat", "Goose"}))
    table.insert(tierI, ToyRarity.new("Rare", {"Shark", "Teddy Bear", "Doll"}))
    table.insert(tierI, ToyRarity.new("Epic", {"Dinosaur", "Unicorn", "Rubber Duck"}))
    table.insert(tiers, tierI)

    -- Tier II
    local tierII = {}
    table.insert(tierII, ToyRarity.new("Common", {"Car", "Ship", "Traktor"}))
    table.insert(tierII, ToyRarity.new("Rare", {"Truck", "Airplane", "Submarine"}))
    table.insert(tierII, ToyRarity.new("Epic", {"Police Car", "Rocket", "Tank"}))
    table.insert(tiers, tierII)

    -- for n, tier in ipairs(tiers) do
    --     print("Tier", n)
    --     for i, r in ipairs(tier) do
    --         print("Rarity:", r.rarity)
    --         for j, t in ipairs(r.toys) do
    --             print(t)
    --         end
    --     end
    -- end
end

function DrawAToy(tier, playerCharacter:Character, passive)
    local rarity = GetRandomRarity()
    local toysTable = tiers[tier][rarity].toys
    local toyIndex = math.random(1, #toysTable)
    local toy = toysTable[toyIndex]

    --print("Tier:", tier, "Rarity:", rarity, "-", toy)
    
    if(passive) then 
        SaveModule.CollectAToyPassively(playerCharacter.player, tier, rarity, toy)
    else
        SaveModule.CollectAToy(playerCharacter.player, tier, rarity, toy)
    end

    return _toyModels[toy], toy, rarity
end

function GetRandomRarity()
    local rarityIndex = 1
    local chance = Random.Range(0, 1)
    local upgradeModifier = UpgradesModule.GetUpgradeValue("es-dc")

    if(chance <= 0.01 * upgradeModifier) then return 3
    elseif(chance <= 0.1 * upgradeModifier) then return 2
    else return 1 end
end

function GetToyPrice(toyTypeKey)
    return toyPrices[toyTypeKey]
end

function GetToyIcons()
    return toysIcons
end

function GetToyIcon(toyName)
    for i, v in ipairs(toysIcons) do
        if(v.name == toyName) then
            return v
        end
    end
end

function GetToyIconsUndiscovered()
    return toysIconsUndiscovered
end

function GetNumberOfTiers()
    return #tiers
end