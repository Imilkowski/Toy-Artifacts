--!Type(Client)

local DecorationsModule = require("DecorationsModule")

--!SerializeField
local pos : Vector2 = Vector2.zero

--!SerializeField
local availableMaterial:Material = nil
--!SerializeField
local occupiedMaterial:Material = nil

local renderer:Renderer = nil

-- Connect to the Tapped event
self.gameObject:GetComponent(TapHandler).Tapped:Connect(function()
    DecorationsModule.TileTapped(pos)
end)

function self:Awake()
    renderer = self.gameObject:GetComponent(Renderer)
end

function self:FixedUpdate()
    if(self.transform.childCount > 0) then
        renderer.material = occupiedMaterial
    else
        renderer.material = availableMaterial
    end
end

function GetTilePosition()
    return pos
end