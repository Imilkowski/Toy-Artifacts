--!Type(Module)

local UtilsModule = require("UtilsModule")

--!SerializeField
local decorationModels: { GameObject } = {}
--!SerializeField
local decorationIcons: { Texture } = {}

function GetDecorationIcons()
    return decorationIcons
end

function StartDecorating()
    local editShop = UtilsModule.localShop.GetEditShopScript()
    editShop.ActivateEditMode(true)
end