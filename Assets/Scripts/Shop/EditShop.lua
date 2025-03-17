--!Type(Client)

local UtilsModule = require("UtilsModule")
local UIManagerModule = require("UIManagerModule")
local DecorationsModule = require("DecorationsModule")

--!SerializeField
local shopScript:Shop = nil

local hiddenDecorations: { GameObject } = {}

--!SerializeField
local decorationTiles:GameObject = nil

function self:OnTriggerEnter(collider: Collider)
    local playerCharacter = collider.gameObject:GetComponent(Character)
    if UtilsModule.CheckIfLocalPlayer(playerCharacter.player) ~= true then return end
    if(playerCharacter.player ~= shopScript.assignedPlayer) then return end

    UIManagerModule.SwitchEditShopButton(true)
end

function self:OnTriggerExit(collider: Collider)
    local playerCharacter = collider.gameObject:GetComponent(Character)
    if UtilsModule.CheckIfLocalPlayer(playerCharacter.player) ~= true then return end
    if(playerCharacter.player ~= shopScript.assignedPlayer) then return end

    UIManagerModule.SwitchEditShopButton(false)
    DecorationsModule.OnDecorationModeExit()
    ActivateEditMode(false)
end

function self:Start()
    ActivateEditMode(false)
end

function GetTileByPos(pos)
    for i = 0, decorationTiles.transform.childCount - 1 do
        local tile = decorationTiles.transform:GetChild(i)
        local decorationTile = tile:GetComponent(DecorationTile)

        local tilePos:Vector2 = decorationTile.GetTilePosition()
        if(pos == tilePos) then
            return tile
        end
    end
    
    return nil
end

function ActivateEditMode(activate)
    for i = 0, decorationTiles.transform.childCount - 1 do
        local tile = decorationTiles.transform:GetChild(i)
        local decorationTile = tile:GetComponent(DecorationTile)

        decorationTile.SetEnabled(activate)
    end
end

function PlaceDecoration(decorationId, model, pos)
    local correspondingTile = GetTileByPos(pos)

    if(correspondingTile == nil) then return false end
    if(correspondingTile.transform.childCount > 0) then return false end

    local spawnedDecoration:GameObject = Object.Instantiate(model).gameObject

    spawnedDecoration.transform.parent = correspondingTile.transform
    spawnedDecoration.transform.position = correspondingTile.transform.position

    return true, spawnedDecoration
end

function HideDecoration(pos)
    local correspondingTile = GetTileByPos(pos)
    if(correspondingTile.childCount == 0) then return end

    local decoration = correspondingTile:GetChild(0).gameObject
    if(not decoration.activeSelf) then return end

    table.insert(hiddenDecorations, decoration)
    decoration:SetActive(false)
end

function UnhideDecorations()
    for i, k in ipairs(hiddenDecorations) do
        hiddenDecorations[i]:SetActive(true)
    end

    hiddenDecorations = {}
end

function RemoveHiddenDecorations()
    local removedDecorationIds = {}
    for i, k in ipairs(hiddenDecorations) do
        local decorationId = hiddenDecorations[i]:GetComponent(Decoration).GetDecorationId()
        DecorationsModule.RemoveDecorationPlaced(hiddenDecorations[i])

        if(removedDecorationIds[decorationId] == nil) then
            removedDecorationIds[decorationId] = 1
        else
            removedDecorationIds[decorationId] += 1
        end
        
        GameObject.Destroy(hiddenDecorations[i])
    end

    hiddenDecorations = {}

    return removedDecorationIds
end

function LoadDecorations(decorationsPlaced)
    local destroyAndInstantiateOperations = 0

    -- iterate over all tiles
    for i = 0, decorationTiles.transform.childCount - 1 do
        local tile = decorationTiles.transform:GetChild(i)
        local decorationTile = tile:GetComponent(DecorationTile)
        local tilePos:Vector2 = decorationTile.GetTilePosition()

        -- iterate over all decorations
        for pos, decorationId in pairs(decorationsPlaced) do

            if(tilePos == pos) then
                destroyAndInstantiateOperations += LoadDecoration(tile, decorationId)
                decorationsPlaced[pos] = nil
            end
        end
    end

    print("Destroy And Instantiate Operations:", destroyAndInstantiateOperations)
end

function LoadDecoration(tile:Transform, decorationId)
    local operations = 0

    if(tile.childCount > 0) then
        local decorationObject = tile:GetChild(0).gameObject
        local id = decorationObject:GetComponent(Decoration).GetDecorationId()

        if(decorationId == id) then return operations end

        GameObject.Destroy(decorationObject)
        operations += 1
    end

    local model = DecorationsModule.GetDecorationModelById(decorationId)
    local spawnedDecoration:GameObject = Object.Instantiate(model).gameObject
    operations += 1

    spawnedDecoration.transform.parent = tile
    spawnedDecoration.transform.position = tile.position

    return operations
end