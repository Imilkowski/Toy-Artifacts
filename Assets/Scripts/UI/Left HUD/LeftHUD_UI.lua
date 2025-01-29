--!Type(UI)

--!SerializeField
local coinIcon : Texture = nil
--!SerializeField
local shopIcon : Texture = nil
--!SerializeField
local upgradesIcon : Texture = nil

--!Bind
local _CoinIcon: Image  = nil
--!Bind
local _CoinLabel: UILabel = nil
--!Bind
local _ShopIcon: Image  = nil
--!Bind
local _UpgradesIcon: Image  = nil

function self:Awake()
    SetIcons();
    SetCoinsAmount(0)
end

function SetIcons()
    _CoinIcon.image = coinIcon
    _ShopIcon.image = shopIcon
    _UpgradesIcon.image = upgradesIcon
end

function SetCoinsAmount(coinsAmount)
    _CoinLabel:SetPrelocalizedText(tostring(coinsAmount))
end