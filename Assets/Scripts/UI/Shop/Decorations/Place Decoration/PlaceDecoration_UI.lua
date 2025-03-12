--!Type(UI)

local UIManagerModule = require("UIManagerModule")
local DecorationsModule = require("DecorationsModule")

--!SerializeField
local rotateLeftIcon : Texture = nil
--!SerializeField
local rotateRightIcon : Texture = nil

--!Bind
local _RotateLeftButton : UIButton = nil
--!Bind
local _RotateLeftIcon : Image = nil

--!Bind
local _RotateRightButton : UIButton = nil
--!Bind
local _RotateRightIcon : Image = nil

--!Bind
local _CancelButton : UIButton = nil
--!Bind
local _CancelButtonLabel: UILabel = nil

--!Bind
local _AcceptButton : UIButton = nil
--!Bind
local _AcceptButtonLabel: UILabel = nil

function self:Awake()
    SetIcons()
    SetTierLabels()
end

function SetIcons()
    _RotateLeftIcon.image = rotateLeftIcon
    _RotateRightIcon.image = rotateRightIcon
end

function SetTierLabels()
    _CancelButtonLabel:SetPrelocalizedText("Cancel")
    _AcceptButtonLabel:SetPrelocalizedText("Accept")
end

-- Register a callback for when the button is pressed
_RotateLeftButton:RegisterPressCallback(function()
    DecorationsModule.RotateDecoration(false)
end, true, true, true)

-- Register a callback for when the button is pressed
_RotateRightButton:RegisterPressCallback(function()
    DecorationsModule.RotateDecoration(true)
end, true, true, true)

-- Register a callback for when the button is pressed
_CancelButton:RegisterPressCallback(function()
    DecorationsModule.CancelDecoration()
    UIManagerModule.SwitchEditShop(true)
end, true, true, true)

-- Register a callback for when the button is pressed
_AcceptButton:RegisterPressCallback(function()
    DecorationsModule.AcceptDecoration()
    UIManagerModule.SwitchEditShop(true)
end, true, true, true)