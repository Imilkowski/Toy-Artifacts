--!Type(Client)

AnyCharacterEnter = Event.new("AnyCharacterEnter")
AnyCharacterExit = Event.new("AnyCharacterExit")

LocalCharacterEnter = Event.new("LocalCharacterEnter")
LocalCharacterExit = Event.new("LocalCharacterExit")

function self:OnTriggerEnter(collider: Collider)
    local character = collider:GetComponent(Character)
    if character == nil then
        return 
    end

    AnyCharacterEnter:Fire(character)

    if(client.localPlayer ~= nil and client.localPlayer.character == character ) then
        LocalCharacterEnter:Fire()
    end
end

function self:OnTriggerExit(collider: Collider)
    local character = collider:GetComponent(Character)
    if character == nil then
        return 
    end

    AnyCharacterExit:Fire(character)

    if(client.localPlayer ~= nil and client.localPlayer.character == character ) then
        LocalCharacterExit:Fire()
    end
end

