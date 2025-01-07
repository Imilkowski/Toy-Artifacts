--!Type(Client)
print("Hello World")

local object = self.gameObject

print(object.name)

function self:OnTriggerEnter(collider: Collider)
    local playerCharacter = collider.gameObject:GetComponent(Character)
    if playerCharacter == nil then return end

    local player = playerCharacter.player
    if client.localPlayer ~= player then return end

    print(player.name)
end