--!Type(UI)

local UIManagerModule = require("UIManagerModule")
local PaymentHandler = require("PaymentHandler")

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
local _IWPsList: VisualElement = nil 

--!SerializeField
local iwpIcons: { Texture } = {}

function self:Awake()
    SetTitleText()
    SetIcons()
    CreateIWPsList()
end

function SetTitleText()
    _TitleLabel:SetPrelocalizedText("Offers")
end

function SetIcons()
    _CloseIcon.image = closeIcon
end

function CreateIWPsList()
    _IWPsList:Clear()

    CreateIWP_Element("small-coins-pack", iwpIcons[1], "Small Coins Pack", "500 coins", 200)
    CreateIWP_Element("medium-coins-pack", iwpIcons[2], "Medium Coins Pack", "2 000 coins (x2 value)", 400)
    CreateIWP_Element("big-coins-pack", iwpIcons[3], "Big Coins Pack", "6 000 coins (x4 value)", 600)
end

function CreateIWP_Element(iwpId, icon, name, description, price)
    local _IWP_Container = VisualElement.new()
    _IWP_Container:AddToClassList("iwp-container")
    _IWPsList:Add(_IWP_Container)
    
    local _IWP_Icon = Image.new()
    _IWP_Icon:AddToClassList("iwp-icon")
    _IWP_Icon.image = icon
    _IWP_Container:Add(_IWP_Icon)

    local _IWP_Info = VisualElement.new()
    _IWP_Info:AddToClassList("iwp-info")
    _IWP_Container:Add(_IWP_Info)

    local _descriptionLabel = UILabel.new()
    _descriptionLabel:AddToClassList("description-label")
    _descriptionLabel:SetPrelocalizedText(description)
    _IWP_Info:Add(_descriptionLabel)

    local _purchaseButton = UIButton.new()
    _purchaseButton:AddToClassList("purchase-button")
    _IWP_Info:Add(_purchaseButton)

    local _priceContainer = VisualElement.new()
    _priceContainer:AddToClassList("price-container")
    _purchaseButton:Add(_priceContainer)

    local _coinIcon = Image.new()
    _coinIcon:AddToClassList("coin-icon")
    _coinIcon.image = coinIcon
    _priceContainer:Add(_coinIcon)

    local _coinLabel = UILabel.new()
    _coinLabel:AddToClassList("coin-label")
    _coinLabel:SetPrelocalizedText(tostring(price))
    _priceContainer:Add(_coinLabel)

    -- Register a callback for when the button is pressed
    _purchaseButton:RegisterPressCallback(function()
        print("Testing the purchase")
        PaymentHandler.PromptIWPPurchase(iwpId)
    end, true, true, true)
end

-- Register a callback for when the button is pressed
_CloseButton:RegisterPressCallback(function()
    UIManagerModule.SwitchUpgradesOff()
end, true, true, true)