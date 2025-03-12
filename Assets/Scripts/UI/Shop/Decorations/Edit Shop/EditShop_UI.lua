--!Type(UI)

local UtilsModule = require("UtilsModule")
local UIManagerModule = require("UIManagerModule")
local DecorationsModule = require("DecorationsModule")

--!Bind
local _FurnitureButton : UIButton = nil
--!Bind
local _RemoveFurnitureButton : UIButton = nil
--!Bind
local _CancelButton : UIButton = nil

--!Bind
local _FurnitureButtonLabel: UILabel = nil
--!Bind
local _RemoveFurnitureButtonLabel: UILabel = nil
--!Bind
local _CancelButtonLabel: UILabel = nil

function self:Awake()
    SetLabels()
end

function SetLabels()
    _FurnitureButtonLabel:SetPrelocalizedText("Place Decorations")
    _RemoveFurnitureButtonLabel:SetPrelocalizedText("Remove Decorations")
    _CancelButtonLabel:SetPrelocalizedText("Cancel")
end

-- Register a callback for when the button is pressed
_FurnitureButton:RegisterPressCallback(function()
    UIManagerModule.SwitchDecorationsOwned()
end, true, true, true)

-- Register a callback for when the button is pressed
_RemoveFurnitureButton:RegisterPressCallback(function()
    UIManagerModule.SwitchRemoveDecorations()
    DecorationsModule.StartDecorating("remove")
end, true, true, true)

-- Register a callback for when the button is pressed
_CancelButton:RegisterPressCallback(function()
    UIManagerModule.SwitchEditShopButton(true)
end, true, true, true)