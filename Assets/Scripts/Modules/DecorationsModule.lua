--!Type(Module)

local UtilsModule = require("UtilsModule")
local SaveModule = require("SaveModule")

--!SerializeField
local decorationModels: { GameObject } = {}
--!SerializeField
local decorationIcons: { Texture } = {}

local decorationMode = "none"

local chosenDecoration = 0
local decorationPlaced = false
local decorationObject = nil

function SetMode(mode)
    decorationMode = mode
end

function GetDecorationIcons()
    return decorationIcons
end

function GetDecorationIcon(id)
    return decorationIcons[id]
end

function StartDecorating(mode)
    local editShop = UtilsModule.localShop.GetEditShopScript()
    editShop.ActivateEditMode(true)

    SetMode(mode)
end

function SetChosenDecoration(id)
    chosenDecoration = id
    decorationPlaced = false
end

function TileTapped(pos)
    if(decorationMode == "place") then
        PlaceAction(pos)
    end

    if(decorationMode == "remove") then
        RemoveAction(pos)
    end
end

function GetDecorationModelById(decorationId)
    return decorationModels[decorationId]
end

function PlaceAction(pos)
    if(decorationPlaced) then return end

    local editShop = UtilsModule.localShop.GetEditShopScript()
    decorationPlaced, decorationObject = editShop.PlaceDecoration(chosenDecoration, decorationModels[chosenDecoration], pos)

    if(decorationPlaced) then
        editShop.ActivateEditMode(false)
    end
end

function RemoveAction(pos)
    local editShop = UtilsModule.localShop.GetEditShopScript()
    editShop.HideDecoration(pos)
end

function RotateDecoration(right)
    if(decorationObject == nil) then return end

    if(right) then
        decorationObject.transform:Rotate(Vector3.up, 45)
    else
        decorationObject.transform:Rotate(Vector3.up, -45)
    end
end

function GetDecorationPos(decoration:GameObject)
    local decorationTile = decoration.transform.parent:GetComponent(DecorationTile)
    return decorationTile.GetTilePosition()
end

function AcceptDecoration()
    if(decorationPlaced == false) then
        CancelDecoration()
        return
    end
    
    SaveModule.UpdateDecoration(client.localPlayer, chosenDecoration, -1)
    SaveModule.AddDecorationPlaced(client.localPlayer, chosenDecoration, GetDecorationPos(decorationObject), decorationObject.transform.eulerAngles.y)

    chosenDecoration = 0
    decorationPlaced = false
    decorationObject = nil
    SetMode("none")
end

function CancelDecoration()
    local editShop = UtilsModule.localShop.GetEditShopScript()
    editShop.ActivateEditMode(false)

    if(decorationObject == nil) then return end
    GameObject.Destroy(decorationObject)
    SetMode("none")
end

function AcceptDecorationRemoval()
    local editShop = UtilsModule.localShop.GetEditShopScript()
    editShop.ActivateEditMode(false)

    local removedDecorations = editShop.RemoveHiddenDecorations()
    for k, v in pairs(removedDecorations) do
        SaveModule.UpdateDecoration(client.localPlayer, k, v)
    end

    SetMode("none")
end

function CancelDecorationRemoval()
    local editShop = UtilsModule.localShop.GetEditShopScript()
    editShop.ActivateEditMode(false)

    editShop.UnhideDecorations()
    SetMode("none")
end

function OnDecorationModeExit()
    if(decorationMode == "place") then
        chosenDecoration = 0
        decorationPlaced = false

        if(decorationObject ~= nil) then
            GameObject.Destroy(decorationObject)
        end

        print("Place exit")
    end

    if(decorationMode == "remove") then
        local editShop = UtilsModule.localShop.GetEditShopScript()
        editShop.UnhideDecorations()

        print("Remove exit")
    end

    SetMode("none")
end

function RemoveDecorationPlaced(decoration:GameObject)
    SaveModule.RemoveDecorationPlaced(client.localPlayer, GetDecorationPos(decoration))
end