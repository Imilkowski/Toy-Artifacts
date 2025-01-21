--!Type(Client)

--!SerializeField
local targetTransform: Transform = nil
--!SerializeField
local speed:number = 1.0
--!SerializeField
local amplitude:number = 1.0

local startPos = targetTransform.position
local timeOffset = 0.0

function self:Update()
    local animationScale = Mathf.Sin(Time.time * speed) * amplitude
    targetTransform.position = startPos + Vector3.new(0, startPos.y * animationScale, 0)
end