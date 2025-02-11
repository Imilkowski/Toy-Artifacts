--!Type(UI)

local UIManagerModule = require("UIManagerModule")
local UpgradesModule = require("UpgradesModule")

--!SerializeField
local closeIcon : Texture = nil
--!SerializeField
local nextIcon : Texture = nil

--!SerializeField
local tutorialImages : { Texture } = nil
--!SerializeField
local tutorialDescriptions : { string } = nil

--!Bind
local _CloseButton : UIButton = nil
--!Bind
local _CloseIcon : Image = nil

--!Bind
local _TitleLabel: UILabel = nil

--!Bind
local _TutorialImage: Image = nil
--!Bind
local _TutorialDescription: UILabel = nil

--!Bind
local _NextButton : UIButton = nil
--!Bind
local _NextIcon : Image = nil

local tutorialId

function self:Awake()
    SetIcons()
    SetTitleText()
    StartTutorial()
end

function SetTitleText()
    _TitleLabel:SetPrelocalizedText("Tutorial")
end

function SetIcons()
    _CloseIcon.image = closeIcon
    _NextIcon.image = nextIcon
end

function StartTutorial()
    tutorialId = 1
    _TutorialImage.image = tutorialImages[1];
    _TutorialDescription:SetPrelocalizedText(tutorialDescriptions[1])
end

function NextTutorial()
    tutorialId += 1

    if(tutorialId > #tutorialImages) then
        StartTutorial()
        UIManagerModule.SwitchTutorialOff()
    end

    _TutorialImage.image = tutorialImages[tutorialId];
    _TutorialDescription:SetPrelocalizedText(tutorialDescriptions[tutorialId])
end

-- Register a callback for when the button is pressed
_CloseButton:RegisterPressCallback(function()
    UIManagerModule.SwitchTutorialOff()
end, true, true, true)

-- Register a callback for when the button is pressed
_NextButton:RegisterPressCallback(function()
    NextTutorial()
end, true, true, true)