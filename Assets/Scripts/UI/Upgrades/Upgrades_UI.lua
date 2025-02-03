--!Type(UI)

local UIManagerModule = require("UIManagerModule")
local UpgradesModule = require("UpgradesModule")

--!SerializeField
local closeIcon : Texture = nil
--!SerializeField
local coinIcon : Texture = nil

--!Bind
local _CloseButton : UIButton = nil
--!Bind
local _CloseIcon : Image = nil

--!Bind
local _TitleLabel: UILabel = nil

--!Bind
local _UpgradesList: VisualElement = nil 

function self:Awake()
    SetTitleText("Upgrades Test")
    SetIcons()
end

function SetTitleText(text)
    _TitleLabel:SetPrelocalizedText(text)
end

function SetIcons()
    _CloseIcon.image = closeIcon
end

function CreateUpgradesList(upgradeType)
    local upgrades = UpgradesModule.GetUpgrades(client.localPlayer, upgradeType)

    if(upgrades == nil) then return end

    _UpgradesList:Clear()

    for i = 1, #upgrades do 
        local _upgradeContainer = VisualElement.new()
        _upgradeContainer:AddToClassList("upgrade-container")
        _UpgradesList:Add(_upgradeContainer)
        
        local _upgradeIcon = Image.new()
        _upgradeIcon:AddToClassList("upgrade-icon")
        _upgradeIcon.image = UpgradesModule.GetUpgradeIcon(upgrades[i].iconId)--
        _upgradeContainer:Add(_upgradeIcon)

        local _upgradeInfo = VisualElement.new()
        _upgradeInfo:AddToClassList("upgrade-info")
        _upgradeContainer:Add(_upgradeInfo)

        local _descriptionLabel = UILabel.new()
        _descriptionLabel:AddToClassList("description-label")
        _descriptionLabel:SetPrelocalizedText(upgrades[i].description)--
        _upgradeInfo:Add(_descriptionLabel)

        local _upgradeButton = UIButton.new()
        _upgradeButton:AddToClassList("upgrade-button")
        _upgradeInfo:Add(_upgradeButton)

        local _buttonLabel = UILabel.new()
        _buttonLabel:AddToClassList("coin-label")
        _buttonLabel:SetPrelocalizedText("Buy")
        _upgradeButton:Add(_buttonLabel)

        local _priceContainer = VisualElement.new()
        _priceContainer:AddToClassList("price-container")
        _upgradeButton:Add(_priceContainer)

        local _coinIcon = Image.new()
        _coinIcon:AddToClassList("coin-icon")
        _coinIcon.image = coinIcon
        _priceContainer:Add(_coinIcon)

        local _coinLabel = UILabel.new()
        _coinLabel:AddToClassList("coin-label")
        _coinLabel:SetPrelocalizedText(tostring(upgrades[i].price))--
        _priceContainer:Add(_coinLabel)

        -- Register a callback for when the button is pressed
        _upgradeButton:RegisterPressCallback(function()
            UpgradesModule.BuyAnUpgrade(client.localPlayer, upgradeType, upgrades[i].upgradeId)
            UIManagerModule.SwitchUpgrades()
            UIManagerModule.SwitchUpgrades(upgradeType)
        end, true, true, true)
    end
end

-- Register a callback for when the button is pressed
_CloseButton:RegisterPressCallback(function()
    UIManagerModule.SwitchUpgrades()
end, true, true, true)