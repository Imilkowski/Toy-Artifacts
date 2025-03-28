--!Type(UI)

--!Bind
local _NameLabel: UILabel = nil

--!SerializeField
local nameText: string = ""

function self:Awake()
    SetText(nameText)
end

function SetText(text)
    _NameLabel:SetPrelocalizedText(text)
end