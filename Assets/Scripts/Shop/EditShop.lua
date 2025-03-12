--!Type(Client)

local UtilsModule = require("UtilsModule")
local UIManagerModule = require("UIManagerModule")

--!SerializeField
local shopScript:Shop = nil

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
end

function GetTileByPos(pos)
    for i = 0, decorationTiles.transform.childCount - 1 do
        local tile = decorationTiles.transform:GetChild(i)
        local decorationTile = tile:GetComponent(DecorationTile)

        local tilePos:Vector2 = decorationTile.GetTilePosition()
        if(pos == tilePos) then
            print("Found tile")
            return tile
        end
    end
    
    return nil
end

function ActivateEditMode(activate)
    decorationTiles:SetActive(activate)
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