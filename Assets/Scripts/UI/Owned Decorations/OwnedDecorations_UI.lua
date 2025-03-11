--!Type(UI)

local UIManagerModule = require("UIManagerModule")
local SaveModule = require("SaveModule")
local DecorationsModule = require("DecorationsModule")

--!SerializeField
local closeIcon : Texture = nil

--!Bind
local _TitleLabel: UILabel = nil

--!Bind
local _CloseButton : UIButton = nil
--!Bind
local _CloseIcon : Image = nil

--!Bind
local _DecorationsList: VisualElement = nil

function self:Awake()
    SetTitleText("Decorations Owned")
    SetIcons()
end

function SetTitleText(text)
    _TitleLabel:SetPrelocalizedText(text)
end

function SetIcons()
    _CloseIcon.image = closeIcon
end

function CreateDecorationsList()
    _DecorationsList:Clear()
    local decorationsOwned = SaveModule.GetDecorationsOwned(client.localPlayer)
    CreateDecorationsListStructure(decorationsOwned)
end

function CreateDecorationsListStructure(decorationsOwned)
    for k, v in pairs(decorationsOwned) do
        print(k, v)
    end
end

-- local editShop = UtilsModule.localShop.GetEditShopScript()
-- editShop.ActivateEditMode(true)

-- Register a callback for when the button is pressed
_CloseButton:RegisterPressCallback(function()
    UIManagerModule.SwitchEditShop(true)
end, true, true, true)