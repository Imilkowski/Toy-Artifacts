--!Type(Module)

local UtilsModule = require("UtilsModule")

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

function AcceptDecoration()
    chosenDecoration = 0
    decorationPlaced = false
    decorationObject = nil
    --do something here
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

    editShop.RemoveHiddenDecorations()
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