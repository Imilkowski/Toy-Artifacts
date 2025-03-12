--!Type(Client)

local DecorationsModule = require("DecorationsModule")

--!SerializeField
local pos : Vector2 = Vector2.zero

--!SerializeField
local availableMaterial:Material = nil
--!SerializeField
local occupiedMaterial:Material = nil

local renderer:Renderer = nil
local collider:Collider = nil
local tileEnabled = false

-- Connect to the Tapped event
self.gameObject:GetComponent(TapHandler).Tapped:Connect(function()
    DecorationsModule.TileTapped(pos)
end)

function self:Awake()
    renderer = self.gameObject:GetComponent(Renderer)
    collider = self.gameObject:GetComponent(Collider)
end

function self:FixedUpdate()
    if(not tileEnabled) then return end

    if(self.transform.childCount > 0) then
        renderer.material = occupiedMaterial
    else
        renderer.material = availableMaterial
    end
end

function SetEnabled(enabled)
    tileEnabled = enabled
    renderer.enabled = enabled
    collider.enabled = enabled
end

function GetTilePosition()
    return pos
end