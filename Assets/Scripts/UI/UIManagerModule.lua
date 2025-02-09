--!Type(Module)

--!SerializeField
local leftHUD : LeftHUD_UI = nil
--!SerializeField
local shopUI : Shop_UI = nil
--!SerializeField
local bridgePopUpUI : BridgePopUp_UI = nil
--!SerializeField
local upgradesUI : Upgrades_UI = nil

function self:Start()
    local status, result = pcall(function()
        SwitchShop()
        SwitchBridgePopUp()
        SwitchUpgrades()
    end)
    
    if not status then end
end

function SwitchShop()
    shopUI.gameObject:SetActive(not shopUI.gameObject.activeSelf)

    if(shopUI.gameObject.activeSelf) then
        UpdateSellingRate()
        ShopCreateToysList()
    end
end

function SwitchBridgePopUp()
    bridgePopUpUI.gameObject:SetActive(not bridgePopUpUI.gameObject.activeSelf)
end

function SwitchBridgePopUp(bridgeBuy:BridgeBuy, repairCost)
    bridgePopUpUI.gameObject:SetActive(not bridgePopUpUI.gameObject.activeSelf)
    bridgePopUpUI.ConnectBridgeBuy(bridgeBuy)
    bridgePopUpUI.SetCost(repairCost)
end

function SwitchUpgrades()
    upgradesUI.gameObject:SetActive(not upgradesUI.gameObject.activeSelf)
end

function SwitchUpgrades(upgradeType)
    upgradesUI.gameObject:SetActive(not upgradesUI.gameObject.activeSelf)
    upgradesUI.CreateUpgradesList(upgradeType)
end

function UpdateCoinsAmount(coinsAmount)
    leftHUD.SetCoinsAmount(coinsAmount)
end

function UpdateSellingRate()
    shopUI.SetSellingRate()
end

function ShopCreateToysList()
    shopUI.CreateToysList()
end

function UpdateToysAmount(toysAmount)
    shopUI.SetToysAmount(toysAmount)
end