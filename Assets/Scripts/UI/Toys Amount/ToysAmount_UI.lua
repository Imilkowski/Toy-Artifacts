--!Type(UI)

--!Bind
local _ToyIcon: Image  = nil
--!Bind
local _ToyLabel: UILabel = nil

--!SerializeField
local img : Texture = nil

function self:Awake()
    SetIcon();
    SetAmount(0)
end

function SetAmount(toysAmount)
    _ToyLabel:SetPrelocalizedText(tostring(toysAmount))
end

function SetIcon()
    _ToyIcon.image = img
end