--!Type(ClientAndServer)

--!SerializeField
local destination : Transform = nil

--!SerializeField
--!Tooltip("Whether to play a sound when using the teleporter, local player only")
local playSound : boolean = false

--!SerializeField
--!Tooltip("The audio shader to play when teleporting.")
local soundToPlay : AudioShader = nil

--!SerializeField
--!Tooltip("Whether to play a particle effect when using the teleporter.")
local playParticleEffect : boolean = true

--!SerializeField
--!Tooltip("The prefab containing the particle effect to play at the destination after teleporting")
local teleportParticles : GameObject = nil

--!SerializeField
--!Tooltip("If false, the character will immediately teleport when entering the trigger, otherwise adds a button to the action bar to teleport.")
local useActionBar : boolean = true

--!SerializeField
local icon : Texture2D = nil

--!SerializeField
local sorting : number = 0

--!SerializeField
--!Tooltip("Whether to move the camera to your character after teleporting.")
local resetCameraAfterTeleport : boolean = true

local actionBarManager = require("ActionBarManager")
local teleportEvent = Event.new("TeleportEvent")

local petController = require("PetCharacterController")
local pets = {}

function self:ClientAwake()
    petController.PetCreatedEvent:Connect(function(pet)
        pets[pet.player] = pet.character
    end)
    
    scene.PlayerLeft:Connect(function(scene, player)
        pets[player] = nil
    end)
end

function self:ClientStart()

    local trigger = self:GetComponent(CharacterTrigger)
    local particleComponent = nil
    if playParticleEffect and teleportParticles ~= nil and destination ~= nil then
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
            if resetCameraAfterTeleport then
                client.Reset:Fire()
            end
            if playSound and soundToPlay ~= nil then
                Audio:PlayShader(soundToPlay)
            end
        end
    end

    trigger.LocalCharacterEnter:Connect(function()
        if useActionBar then
            actionBarManager.AddAction(icon, RequestTeleport, sorting)
        else
            RequestTeleport()
        end
    end)

    trigger.LocalCharacterExit:Connect(function()
        if useActionBar then
            actionBarManager.RemoveAction(RequestTeleport)
        end
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