--!Type(UI)

local UIManagerModule = require("UIManagerModule")
local SaveModule = require("SaveModule")

--!SerializeField
local closeIcon : Texture = nil
--!SerializeField
local coinIcon : Texture = nil

--!Bind
local _CloseButton : UIButton = nil
--!Bind
local _CloseIcon : Image = nil

--!Bind
local _TitleLabel: UILabel = nil

--!Bind
local _RepairButton : UIButton = nil
--!Bind
local _RepairLabel: UILabel = nil

--!Bind
local _CoinIcon: Image  = nil
--!Bind
local _CoinLabel: UILabel = nil

local bridgeBuy: BridgeBuy = nil

local repairCost = 0

function self:Awake()
    SetTitleText("Broken Bridge")
    SetIcons()
    SetLabels()
end

function SetTitleText(text)
    _TitleLabel:SetPrelocalizedText(text)
end

function SetLabels()
    _RepairLabel:SetPrelocalizedText("Repair")
end

function SetCost(cost)
    repairCost = cost
    _CoinLabel:SetPrelocalizedText(tostring(cost))
end

function SetIcons()
    _CloseIcon.image = closeIcon
    _CoinIcon.image = coinIcon
end

function ConnectBridgeBuy(bridgeBuyScript: BridgeBuy)
    bridgeBuy = bridgeBuyScript
end

-- Register a callback for when the button is pressed
_CloseButton:RegisterPressCallback(function()
    UIManagerModule.SwitchBridgePopUp()
end, true, true, true)

-- Register a callback for when the button is pressed
_RepairButton:RegisterPressCallback(function()
    local coinsCollected = SaveModule.GetPlayerCoins(client.localPlayer)

    if(coinsCollected >= repairCost) then
        SaveModule.UpdateCoins(client.localPlayer, -repairCost)
        bridgeBuy.RepairBridge(client.localPlayer)
        UIManagerModule.SwitchBridgePopUp()
    else 
        print("Not enough coins")
    end
end, true, true, true)