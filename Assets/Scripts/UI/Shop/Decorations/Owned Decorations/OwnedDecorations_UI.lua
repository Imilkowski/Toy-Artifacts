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
    local decorationsIcons = DecorationsModule.GetDecorationIcons()
    CreateDecorationsListStructure(decorationsOwned, decorationsIcons)
end

function CreateDecorationsListStructure(decorationsOwned, decorationsIcons)
    for k, v in pairs(decorationsOwned) do
        local _decorationElement = VisualElement.new()
        _decorationElement:AddToClassList("decoration-container")

        local _decorationIcon = Image.new()
        _decorationIcon.image = decorationsIcons[k]
        _decorationIcon:AddToClassList("decoration-icon")

        local _count = Label.new()
        _count.text = v
        _count:AddToClassList("decoration-count")

        _decorationElement:Add(_decorationIcon)
        _decorationElement:Add(_count)
        _DecorationsList:Add(_decorationElement)

        -- Register a callback for when the button is pressed
        _decorationElement:RegisterPressCallback(function()
            UIManagerModule.SwitchPlaceDecoration()
            DecorationsModule.SetChosenDecoration(k)
        end, true, true, true)
    end
end

-- Register a callback for when the button is pressed
_CloseButton:RegisterPressCallback(function()
    UIManagerModule.SwitchEditShop(true)
end, true, true, true)