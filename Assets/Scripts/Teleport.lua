--!Type(ClientAndServer)

--!SerializeField
local destination : Transform = nil

--!SerializeField
local teleportParticles : GameObject = nil

local teleportEvent = Event.new("TeleportEvent")

local petController = require("PetCharacterController")
local pets = {}

function self:ClientStart()

    local trigger = self:GetComponent(CharacterTrigger)
    local particleComponent = nil
    if teleportParticles ~= nil and destination ~= nil then
        local particleObject = Object.Instantiate(teleportParticles, destination.position)
        particleComponent = particleObject:GetComponent(ParticleSystem)
    end

    function RequestTeleport()
        if destination == nil then
            return
        end

        teleportEvent:FireServer(destination.position)
    end

    function Teleport(character : Character, destination : Vector3)
        character:Teleport(destination)
        if particleComponent ~= nil then
            particleComponent:Play()
        end

        if pets[character.player] ~= nil then
            pets[character.player]:Teleport(destination)
        end

        if character.player == client.localPlayer then
            client.Reset:Fire()
        end
    end

    trigger.LocalCharacterEnter:Connect(function()
        RequestTeleport()
    end)

    teleportEvent:Connect(function(character, destination)
        Teleport(character, destination)
    end)

end

function self:ServerStart()

    teleportEvent:Connect(function(player, destination)
        player.character.transform.position = destination
        teleportEvent:FireAllClients(player.character, destination)
    end)

end