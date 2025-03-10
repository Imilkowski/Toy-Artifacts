--!Type(UI)

local UIManagerModule = require("UIManagerModule")

--!Bind
local _EditButton : UIButton = nil

--!Bind
local _EditButtonLabel: UILabel = nil

function self:Awake()
    SetLabel()
end

function SetLabel()
    _EditButtonLabel:SetPrelocalizedText("Edit Shop")
end

-- Register a callback for when the button is pressed
_EditButton:RegisterPressCallback(function()
    UIManagerModule.SwitchShopButton(true)
end, true, true, true)