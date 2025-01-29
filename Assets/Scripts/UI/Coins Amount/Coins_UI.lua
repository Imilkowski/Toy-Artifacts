--!Type(UI)

--!Bind
local _CoinIcon: Image  = nil
--!Bind
local _CoinLabel: UILabel = nil

--!SerializeField
local img : Texture = nil

function self:Awake()
    SetIcon();
    SetAmount(0)
end

function SetAmount(coinsAmount)
    _CoinLabel:SetPrelocalizedText(tostring(coinsAmount))
end

function SetIcon()
    _CoinIcon.image = img
end