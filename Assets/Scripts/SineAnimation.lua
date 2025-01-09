--!Type(Client)

--!SerializeField
local targetTransform: Transform = nil
--!SerializeField
local speed:number = 1.0
--!SerializeField
local randomTimeOffset:boolean = true

local startScale = targetTransform.localScale
local timeOffset = 0.0

function self:Start()
    if randomTimeOffset then
        timeOffset = Random.Range(0.0, 1.0)
    end
end

function self:Update()
    local animationScale = Mathf.Sin(Time.time * speed + timeOffset)
    targetTransform.localScale = startScale * animationScale
end