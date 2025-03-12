--!Type(Module)

local UtilsModule = require("UtilsModule")

--!SerializeField
local decorationModels: { GameObject } = {}
--!SerializeField
local decorationIcons: { Texture } = {}

local chosenDecoration = 0
local decorationPlaced = false
local decorationObject:GameObject = nil

function GetDecorationIcons()
    return decorationIcons
end

function StartDecorating()
    local editShop = UtilsModule.localShop.GetEditShopScript()
    editShop.ActivateEditMode(true)
end

function SetChosenDecoration(id)
    chosenDecoration = id
    decorationPlaced = false
end

function TileTapped(pos)
    if(decorationPlaced) then return end

    print("Decoration:", chosenDecoration, "at", pos.x, pos.y)

    local editShop = UtilsModule.localShop.GetEditShopScript()
    decorationPlaced, decorationObject = editShop.PlaceDecoration(chosenDecoration, decorationModels[chosenDecoration], pos)

    if(decorationPlaced) then
        editShop.ActivateEditMode(false)
    end
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

end

function CancelDecoration()
    local editShop = UtilsModule.localShop.GetEditShopScript()
    editShop.ActivateEditMode(false)

    if(decorationObject == nil) then return end
    GameObject.Destroy(decorationObject)
end