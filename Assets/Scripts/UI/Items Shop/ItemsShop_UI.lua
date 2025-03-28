--!Type(UI)

local UIManagerModule = require("UIManagerModule")
local ItemsShopModule = require("ItemsShopModule")

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
local _ItemsList: VisualElement = nil

function self:Awake()
    SetIcons()
end

function SetTitleText(text)
    _TitleLabel:SetPrelocalizedText(text)
end

function SetIcons()
    _CloseIcon.image = closeIcon
end

function CreateItemsList(shopType)
    if(shopType == nil) then return end

    SetTitleText(shopType)
    _ItemsList:Clear()

    local items = ItemsShopModule.GetItems(shopType)

    for i = 1, #items do 
        local _itemButtonContainer = UIButton.new()
        _itemButtonContainer:AddToClassList("item-button-container")
        _ItemsList:Add(_itemButtonContainer)

        local _itemIcon = Image.new()
        _itemIcon:AddToClassList("item-icon")
        _itemIcon.image = ItemsShopModule.GetItemIcon(shopType, items[i].itemId)
        _itemButtonContainer:Add(_itemIcon)

        local _priceContainer = VisualElement.new();
        _priceContainer:AddToClassList("price-container")
        _itemButtonContainer:Add(_priceContainer)

        local _currencyIcon = Image.new()
        _currencyIcon:AddToClassList("currency-icon")
        _currencyIcon.image = coinIcon
        _priceContainer:Add(_currencyIcon)

        local _priceLabel = UILabel.new()
        _priceLabel:AddToClassList("currency-label")
        _priceLabel:SetPrelocalizedText(items[i].price)
        _priceContainer:Add(_priceLabel)

        -- Register a callback for when the button is pressed
        _itemButtonContainer:RegisterPressCallback(function()
            ItemsShopModule.BuyAnItem(client.localPlayer, shopType, items[i].itemId)
        end, true, true, true)
    end
end

-- Register a callback for when the button is pressed
_CloseButton:RegisterPressCallback(function()
    UIManagerModule.SwitchItemsShopOff()
end, true, true, true)