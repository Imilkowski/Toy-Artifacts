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

local saveModule = require("SaveModule")

ToyRarity = {}
ToyRarity.__index = ToyRarity

function ToyRarity.new(rarity, toysTable)
    local myClass = setmetatable({}, ToyRarity)

	myClass.rarity = rarity
    myClass.toys = toysTable
	
	return myClass
end

local tiers = {}

function self:Awake()
    InitializeToyTables()
end

function InitializeToyTables()
    -- Tier I
    local tierI = {}
    table.insert(tierI, ToyRarity.new("Common", {"Toy IC1", "Toy IC2", "Toy IC3"}))
    table.insert(tierI, ToyRarity.new("Rare", {"Toy IR1", "Toy IR2", "Toy IR3"}))
    table.insert(tierI, ToyRarity.new("Epic", {"Toy IE1", "Toy IE2", "Toy IE3"}))
    table.insert(tiers, tierI)

    -- Tier II
    local tierII = {}
    table.insert(tierII, ToyRarity.new("Common", {"Toy IIC1", "Toy IIC2", "Toy IIC3"}))
    table.insert(tierII, ToyRarity.new("Rare", {"Toy IIR1", "Toy IIR2", "Toy IIR3"}))
    table.insert(tierII, ToyRarity.new("Epic", {"Toy IIE1", "Toy IIE2", "Toy IIE3"}))
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

function DrawAToy(tier, playerCharacter:Character)
    print("Drawing a random toy from tier " .. tier)

    --local rarityIndex = math.random(1, #tiers[tier])
    local rarityIndex = GetRandomRarity()
    local toyIndex = math.random(1, #tiers[tier][rarityIndex].toys)

    local toyName = tiers[tier][rarityIndex].toys[toyIndex]
    print(toyName)
    
    --adding a Test Item
    saveModule.CollectAToy(playerCharacter.player, toyName)
end

function GetRandomRarity()
    local rarityIndex = 1
    local chance = Random.Range(0, 1)

    if(chance < 0.6) then return 1
    elseif(chance < 0.9) then return 2
    else return 3 end

end