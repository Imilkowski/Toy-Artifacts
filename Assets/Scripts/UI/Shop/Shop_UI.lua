--!Type(UI)

--!Bind
local _TitleLabel: UILabel = nil

function self:Awake()
    SetTitleText("Your Shop")
end

function SetTitleText(text)
    _TitleLabel:SetPrelocalizedText(text)
end