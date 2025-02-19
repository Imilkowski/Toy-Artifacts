--!Type(UI)

local UIManagerModule = require("UIManagerModule")
local ToysModule = require("ToysModule")

--!Bind
local _ToyIcon: Image  = nil

--!SerializeField
local showTime: number = 0

local disappearTime = 0

function ShowAToy(toyName)
    _ToyIcon.image = ToysModule.GetToyIcon(toyName)
    disappearTime = showTime
end

function self:Update()
    if(disappearTime <= 0) then
        self.gameObject:SetActive(false)
    else
        disappearTime -= Time.deltaTime
    end

    print(disappearTime)
end