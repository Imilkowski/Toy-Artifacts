--!Type(UI)

local UIManagerModule = require("UIManagerModule")
local ToysModule = require("ToysModule")

--!Bind
local _ToyIcon: Image  = nil
--!Bind
local _ShineEffect: Image  = nil

--!SerializeField
local shineTexture: { Texture } = nil

--!SerializeField
local showTime: number = 0

local disappearTime = 0

function ShowAToy(toyName, rarity)
    _ToyIcon.image = ToysModule.GetToyIcon(toyName)
    _ShineEffect.image = shineTexture[rarity]

    disappearTime = showTime
end

function self:Update()
    if(disappearTime <= 0) then
        self.gameObject:SetActive(false)
    else
        disappearTime -= Time.deltaTime
    end
end