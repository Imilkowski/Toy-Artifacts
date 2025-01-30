--!Type(UI)

local SaveModule = require("SaveModule")
local UtilsModule = require("UtilsModule")
local ToysModule = require("ToysModule")

--!SerializeField
local sellingRateIcon : Texture = nil
--!SerializeField
local toysIcon : Texture = nil

--!Bind
local _TitleLabel: UILabel = nil

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

function self:Awake()
    SetTitleText("Your Shop")
    SetIcons()
    SetToysAmount(0)
end

function SetTitleText(text)
    _TitleLabel:SetPrelocalizedText(text)
end

function SetIcons()
    _SellingRateIcon.image = sellingRateIcon
    _ToysIcon.image = toysIcon
end

function SetToysAmount(amount)
    _ToysLabel:SetPrelocalizedText(tostring("Toys in shop: " .. amount))
end

function SetSellingRate(sellingRate)
    sellingRate = SaveModule.GetShopSellingRate(client.localPlayer)
    _SellingRateLabel:SetPrelocalizedText(tostring("Selling rate: " .. UtilsModule.RoundNumber(1/sellingRate) .. "/s"))
end

function CreateToysList()
    _ToysList:Clear()

    local toyIcons = ToysModule.GetToyIcons()

    for i = 1, #toyIcons do 
        local _toyElement = VisualElement.new()
        _toyElement:AddToClassList("toy-container")

        local _toyIcon = Image.new()
        _toyIcon:AddToClassList("toy-icon")
        _toyIcon.image = toyIcons[i]

        print(toyIcons[i].name)

        _toyElement:Add(_toyIcon)

        _ToysList:Add(_toyElement)
    end
end