--!Type(UI)

--!Bind
local _NameLabel: UILabel = nil

--!SerializeField
local nameText: string = ""

function self:Awake()
    _NameLabel:SetPrelocalizedText(nameText)
end