--!Type(UI)

--!Bind
local _CoinLabel: UILabel = nil

function self:FixedUpdate()
    _CoinLabel:SetPrelocalizedText(tostring(math.random(0, 10)))
end