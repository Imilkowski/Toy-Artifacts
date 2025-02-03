--!Type(Client)

local UtilsModule = require("UtilsModule")
local ToysModule = require("ToysModule")
local SaveModule = require("SaveModule")
local UpgradesModule = require("UpgradesModule")

--!SerializeField
local tier:number = 0
local activePointsIndexes = {}

local points: { GameObject } = {}

function self:Start()
    for i = 0, self.transform.childCount - 1 do
        local point = self.transform:GetChild(i)
        
        local diggingPoint = point:GetComponent(DiggingPoint)
        diggingPoint.diggingPoints = self
        diggingPoint.index = i + 1
        table.insert(points, point.gameObject)
        point.gameObject.SetActive(point.gameObject, false)
    end

    SetupActivePoints()
end

function SetupActivePoints()
    local targetActivePoints = UpgradesModule.GetUpgradeValue("es-dp")
    
    if(#activePointsIndexes == targetActivePoints) then return end

    --populate a table with random indexes
    while #activePointsIndexes < targetActivePoints do
        local index = math.random(1, #points)

        local duplicate = false
        for id, value in ipairs(activePointsIndexes) do
            if value == index then
                duplicate = true
            end
        end

        if(duplicate) then
            continue
        end
        
        table.insert(activePointsIndexes, index)
    end

    --set the digging points active
    for id, value in ipairs(activePointsIndexes) do
        points[value].SetActive(points[value], true)
    end
end

function self:FixedUpdate()
    SetupActivePoints()
end

function Dig(diggingPoint:DiggingPoint, playerCharacter:Character, diggingPosition)
    diggingPoint.gameObject.SetActive(diggingPoint.gameObject, false)
    UtilsModule.RemoveByValue(activePointsIndexes, diggingPoint.index);

    SetupActivePoints()
    local toy = ToysModule.DrawAToy(tier, playerCharacter, false)

    SaveModule.AddToyToRegister(playerCharacter.player, toy.name)

    local spawnedToy = Object.Instantiate(toy).gameObject
    spawnedToy:GetComponent(Toy).DigUp(diggingPosition)
end