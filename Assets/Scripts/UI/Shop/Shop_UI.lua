--!Type(UI)

local UIManagerModule = require("UIManagerModule")
local SaveModule = require("SaveModule")
local UtilsModule = require("UtilsModule")
local ToysModule = require("ToysModule")
local UpgradesModule = require("UpgradesModule")

--!SerializeField
local sellingRateIcon : Texture = nil
--!SerializeField
local toysIcon : Texture = nil
--!SerializeField
local closeIcon : Texture = nil

--!Bind
local _TitleLabel: UILabel = nil

--!Bind
local _CloseButton : UIButton = nil
--!Bind
local _CloseIcon : Image = nil

--!Bind
local _SellingRateIcon: Image  = nil
--!Bind
local _SellingRateLabel: UILabel = nil

--!Bind
local _ToysIcon: Image  = nil
--!Bind
local _ToysLabel: UILabel = nil

--!Bind
local _ToysList: VisualElement = nil

--!Bind
local _TierIButton: UIButton = nil
--!Bind
local _TierIIButton: UIButton = nil
--!Bind
local _TierIIIButton: UIButton = nil

--!Bind
local _TierILabel: UILabel = nil
--!Bind
local _TierIILabel: UILabel = nil
--!Bind
local _TierIIILabel: UILabel = nil

local currentTier = 0

function self:Awake()
    SetTitleText("Your Shop")
    SetIcons()
    SetToysAmount(0)
    SetTierLabels()
end

-- Register a callback for when the button is pressed
_CloseButton:RegisterPressCallback(function()
    UIManagerModule.SwitchShop()
end, true, true, true)

-- Register a callback for when the button is pressed
_TierIButton:RegisterPressCallback(function()
    CreateToysList(0)
end, true, true, true)

-- Register a callback for when the button is pressed
_TierIIButton:RegisterPressCallback(function()
    CreateToysList(1)
end, true, true, true)

_TierIIIButton:RegisterPressCallback(function()
    CreateToysList(2)
end, true, true, true)

function SetTitleText(text)
    _TitleLabel:SetPrelocalizedText(text)
end

function SetIcons()
    _SellingRateIcon.image = sellingRateIcon
    _ToysIcon.image = toysIcon
    _CloseIcon.image = closeIcon
end

function SetToysAmount(amount)
    _ToysLabel:SetPrelocalizedText(tostring("Toys in shop: " .. amount))
end

function SetSellingRate(sellingRate)
    sellingRate = UpgradesModule.GetUpgradeValue("b-ssr")
    _SellingRateLabel:SetPrelocalizedText(tostring("Selling rate: " .. UtilsModule.RoundNumber(1/sellingRate) .. "/s"))
end

function SetTierLabels()
    _TierILabel:SetPrelocalizedText("I")
    _TierIILabel:SetPrelocalizedText("II")
    _TierIIILabel:SetPrelocalizedText("III")
end

function UpdateToysList()
    CreateToysList(currentTier)
end

function CreateToysList(t)
    currentTier = t

    _ToysList:Clear()
    local toyIcons = ToysModule.GetToyIcons()
    local toyIconsUndiscovered = ToysModule.GetToyIconsUndiscovered()
    CreateToysListStructure(t, toyIcons, toyIconsUndiscovered)
end

function CreateToysListStructure(t, toyIcons, toyIconsUndiscovered)
    for r = 0, 2 do 
        for toy = 1, 3 do 
            local i = t * 9 + r * 3 + toy

            local collected = SaveModule.GetToyFromRegister(client.localPlayer, toyIcons[i].name)
            
            local _toyElement = VisualElement.new()

            if(collected == nil) then
                _toyElement:AddToClassList("toy-container")
            else
                _toyElement:AddToClassList("toy-container-collected")
            end

            local _toyRarty = VisualElement.new()

            if(r == 0)then
                _toyRarty:AddToClassList("toy-rarity-common")
            elseif(r == 1) then
                _toyRarty:AddToClassList("toy-rarity-rare")
            else
                _toyRarty:AddToClassList("toy-rarity-epic")
            end

            local _toyIcon = Image.new()
            _toyIcon:AddToClassList("toy-icon")

            if(collected == nil) then
                _toyIcon.image = toyIconsUndiscovered[i]
            else
                _toyIcon.image = toyIcons[i]
            end

            --print(toyIcons[i].name)

            _toyElement:Add(_toyIcon)
            _toyElement:Add(_toyRarty)
            
            _ToysList:Add(_toyElement)
        end
    end
end