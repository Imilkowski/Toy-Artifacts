--!Type(UI)

local UIManagerModule = require("UIManagerModule")

--!SerializeField
local closeIcon : Texture = nil

--!Bind
local _CloseButton : UIButton = nil
--!Bind
local _CloseIcon : Image = nil

--!Bind
local _TitleLabel: UILabel = nil

--!Bind
local _RepairButton : UIButton = nil

function self:Awake()
    SetTitleText("Broken Bridge")
    SetIcons()
end

-- Register a callback for when the button is pressed
_CloseButton:RegisterPressCallback(function()
    UIManagerModule.SwitchBridgePopUp()
end, true, true, true)

_RepairButton:RegisterPressCallback(function()
    print("Repairing")
end, true, true, true)

function SetTitleText(text)
    _TitleLabel:SetPrelocalizedText(text)
end

function SetIcons()
    _CloseIcon.image = closeIcon
end