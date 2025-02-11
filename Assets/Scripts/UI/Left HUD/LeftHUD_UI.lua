--!Type(UI)

local UIManagerModule = require("UIManagerModule")

--!SerializeField
local coinIcon : Texture = nil
--!SerializeField
local shopIcon : Texture = nil
--!SerializeField
local tutorialIcon : Texture = nil
-- --!SerializeField
-- local upgradesIcon : Texture = nil

--!Bind
local _CoinIcon: Image  = nil
--!Bind
local _CoinLabel: UILabel = nil

--!Bind
local _ShopIcon: Image  = nil
--!Bind
local _ShopButton : UIButton = nil

--!Bind
local _TutorialIcon: Image  = nil
--!Bind
local _TutorialButton : UIButton = nil

-- --!Bind
-- local _UpgradesIcon: Image  = nil
-- --!Bind
-- local _UpgradesButton : UIButton = nil

function self:Awake()
    SetIcons();
    SetCoinsAmount(0)
end

function SetIcons()
    _CoinIcon.image = coinIcon
    _ShopIcon.image = shopIcon
    _TutorialIcon.image = tutorialIcon
    --_UpgradesIcon.image = upgradesIcon
end

function SetCoinsAmount(coinsAmount)
    _CoinLabel:SetPrelocalizedText(tostring(coinsAmount))
end

-- Register a callback for when the button is pressed
_ShopButton:RegisterPressCallback(function()
    UIManagerModule.SwitchShop()
end, true, true, true)

-- Register a callback for when the button is pressed
_TutorialButton:RegisterPressCallback(function()
    UIManagerModule.SwitchTutorial()
end, true, true, true)

-- Register a callback for when the button is pressed
-- _UpgradesButton:RegisterPressCallback(function()
--     print("Upgrades Button clicked")
-- end, true, true, true)