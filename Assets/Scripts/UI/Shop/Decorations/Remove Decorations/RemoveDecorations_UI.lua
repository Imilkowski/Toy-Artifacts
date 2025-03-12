--!Type(UI)

local UIManagerModule = require("UIManagerModule")
local DecorationsModule = require("DecorationsModule")

--!Bind
local _CancelButton : UIButton = nil
--!Bind
local _CancelButtonLabel: UILabel = nil

--!Bind
local _AcceptButton : UIButton = nil
--!Bind
local _AcceptButtonLabel: UILabel = nil

function self:Awake()
    SetLabels()
end

function SetLabels()
    _CancelButtonLabel:SetPrelocalizedText("Cancel")
    _AcceptButtonLabel:SetPrelocalizedText("Accept")
end

_CancelButton:RegisterPressCallback(function()
    DecorationsModule.CancelDecorationRemoval()
    UIManagerModule.SwitchEditShop(true)
end, true, true, true)

-- Register a callback for when the button is pressed
_AcceptButton:RegisterPressCallback(function()
    DecorationsModule.AcceptDecorationRemoval()
    UIManagerModule.SwitchEditShop(true)
end, true, true, true)