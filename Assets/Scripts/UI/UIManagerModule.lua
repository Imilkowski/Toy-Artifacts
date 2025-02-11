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
        SwitchUI(self.gameObject)
    end)
    
    if not status then end
end

function SwitchUI(go:GameObject)
    if(shopUI.gameObject == go) then
        shopUI.gameObject:SetActive(true)
    else
        shopUI.gameObject:SetActive(false)
    end

    if(bridgePopUpUI.gameObject == go) then
        bridgePopUpUI.gameObject:SetActive(true)
    else
        bridgePopUpUI.gameObject:SetActive(false)
    end

    if(upgradesUI.gameObject == go) then
        upgradesUI.gameObject:SetActive(true)
    else
        upgradesUI.gameObject:SetActive(false)
    end
end

function SwitchShop()
    if(shopUI.gameObject.activeSelf) then
        SwitchUI(self.gameObject)
    else
        SwitchUI(shopUI.gameObject)
        UpdateSellingRate()
        ShopCreateToysList()
    end
end

function SwitchBridgePopUpOff()
    SwitchUI(self.gameObject)
end

function SwitchBridgePopUp(bridgeBuy:BridgeBuy, repairCost)
    SwitchUI(bridgePopUpUI.gameObject)
    bridgePopUpUI.ConnectBridgeBuy(bridgeBuy)
    bridgePopUpUI.SetCost(repairCost)
end

function SwitchUpgradesOff()
    SwitchUI(self.gameObject)
end

function SwitchUpgrades(upgradeType)
    SwitchUI(upgradesUI.gameObject)
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

function SwitchTutorial()
    print("Switch tutorial")
end