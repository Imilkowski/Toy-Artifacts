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
    for i, k in ipairs(hiddenDecorations) do
        GameObject.Destroy(hiddenDecorations[i])
    end

    hiddenDecorations = {}
end