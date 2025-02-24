--!Type(Client)

local characterRigContainers = {} -- Table to store player characters
local billboardEnabled : {boolean} = {} -- Table to store player billboard states

local sceneNPCs : {Character} = {}
local sceneAnchors : {Anchor} = {}
local anchorOccupants = {} -- Table to store players attached to anchors

--!SerializeField
--!Tooltip("The distance the rig should offset toward the camera to account for clipping")
local rigOffset:number = 0.75
--!SerializeField
--!Tooltip("The maximum pitch angle for the character rig")
local xRotationClamp:number = 30

-- Function to track players in the game and set up character change callbacks
local function TrackPlayers(game, callBack)
    game.PlayerConnected:Connect(function(player) -- Connect to the PlayerConnected event
        if characterRigContainers[player] == nil then -- Check if the player's character is not already being tracked
            player.CharacterChanged:Connect(function(player, character) -- Connect to the CharacterChanged event
                if character == nil then return end -- Exit if the character is nil

                billboardEnabled[character] = true -- Enable billboarding for the character
                
                if callBack then
                    callBack(character, player) -- Call the callback function if provided
                end
            end)
        end
    end)

    game.PlayerDisconnected:Connect(function(player) -- Connect to the PlayerDisconnected event
        characterRigContainers[player] = nil -- Remove the player's character from the tracking table
    end)

    for i, anchor in ipairs(sceneAnchors) do
        anchor.Entered:Connect(function(anchor)
            print(anchor.occupant.name .. " entered anchor")
            billboardEnabled[anchor.occupant.player.character] = false
            anchorOccupants[anchor] = anchor.occupant.player
        end)
        anchor.Exited:Connect(function(anchor)
            print(anchorOccupants[anchor].name .. " exited anchor")
            billboardEnabled[anchorOccupants[anchor].character] = true
            anchorOccupants[anchor] = nil
        end)
    end
end

local function ValidateCharacters()
    validCharCount = 0
    for actor, character in pairs(characterRigContainers) do
        if character == nil then
            characterRigContainers[actor] = nil -- Remove nil values from the characters table
        else
            validCharCount = validCharCount + 1
        end
    end
    if validCharCount == 0 then
        --print("No valid characters found!")
    else
        --print("Valid characters: " .. validCharCount)
    end
end

local function FindInChildren(parent:Transform, name:string)
    for i = 0, parent.childCount - 1 do
        local child = parent:GetChild(i)
        if child and child.name == name then return child end
    end
    return nil
end

function self:Awake()

    anchors = Object.FindObjectsOfType(Anchor)
    npcs = Object.FindObjectsOfType(Character)

    for i, anchor in ipairs(anchors) do
        sceneAnchors[i] = (anchor :: GameObject):GetComponent(Anchor)
    end
    for i, npc in ipairs(npcs) do
        sceneNPCs[i] = (npc :: GameObject):GetComponent(Character)
    end

    local function InsertRigContainer(character)
        charTransform = character.transform
        characterRig = FindInChildren(charTransform, "Rig")
        if characterRig then
            shadow = FindInChildren(characterRig, "Shadow")
            if shadow then
                shadow:SetParent(charTransform)
            end
            rigContainer = GameObject.new("RigContainer").transform
            rigContainer:SetParent(charTransform)
            rigContainer.localPosition = Vector3.zero
            rigContainer.localRotation = charTransform.localRotation
            rigContainer.localScale = Vector3.one
            characterRig:SetParent(rigContainer)
            characterRigContainers[character] = rigContainer
        end
    end
    
    function characterCreatedCallback(playerinfo)
        local player = playerinfo.player
        InsertRigContainer(player.character)
    end

    for i, npc in ipairs(sceneNPCs) do
        if not billboardEnabled[npc] then
            InsertRigContainer(npc)
            billboardEnabled[npc] = true
        end
    end

    TrackPlayers(client, characterCreatedCallback) -- Start tracking players on the client side
end

function self:LateUpdate()
    ValidateCharacters()

    for actor, billboardCorrector:Transform in pairs(characterRigContainers) do
        if billboardCorrector ~= nil and billboardCorrector.gameObject.activeInHierarchy then
            -- Start the true billboarding process here

            local verticalOffset = .1
            local scaleModifier = 1

            if billboardEnabled[actor] then
                local characterRig:Transform = billboardCorrector:GetChild(0)

                newRotation = billboardCorrector.eulerAngles
                newXRot = math.min((Camera.main.transform.eulerAngles.x+360)%360, xRotationClamp)
                newRotation.x = -newXRot
                newRotation.y = characterRig.eulerAngles.y
                billboardCorrector.eulerAngles = newRotation

                charScale = characterRig.localScale
                billboardCorrector.localScale = Vector3.new(1,0.5,1.5) * scaleModifier

                offsetVector = Camera.main.transform.position - characterRig.position
                offsetVector = offsetVector.normalized * rigOffset
                characterRig.position = billboardCorrector.position + offsetVector + (Vector3.up * verticalOffset)
            
            elseif billboardCorrector.localScale.y ~= 1 then

                billboardCorrector.eulerAngles = Vector3.zero
                billboardCorrector.localScale = Vector3.one
                billboardCorrector.localPosition = Vector3.zero
                billboardCorrector:GetChild(0).localPosition = Vector3.zero

            end
        end
    end
end

function self:OnDisable()
    for player, billboardCorrector:Transform in pairs(characterRigContainers) do
        if billboardCorrector ~= nil then
            -- Reset the billboard corrector to its parent's orientation
            billboardCorrector.eulerAngles = Vector3.zero
            billboardCorrector.localScale = Vector3.one
            billboardCorrector.localPosition = Vector3.zero
            billboardCorrector:GetChild(0).localPosition = Vector3.zero
        end
    end
end