--!Type(Module)

--!SerializeField
local leftHUD : LeftHUD_UI = nil
--!SerializeField
local shopUI : Shop_UI = nil
--!SerializeField
local bridgePopUpUI : BridgePopUp_UI = nil
--!SerializeField
local upgradesUI : Upgrades_UI = nil
--!SerializeField
local tutorialUI : Tutorial_UI = nil
--!SerializeField
local toyCollectedUI : ToyCollected_UI = nil

--!SerializeField
local editShopButtonUI : EditShopButton_UI = nil
--!SerializeField
local editShopUI : EditShop_UI = nil
--!SerializeField
local ownedDecorationsUI : OwnedDecorations_UI = nil

function self:Start()
    local status, result = pcall(function()
        SwitchUI(self.gameObject)
        toyCollectedUI.gameObject:SetActive(false)
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

    if(tutorialUI.gameObject == go) then
        tutorialUI.gameObject:SetActive(true)
    else
        tutorialUI.gameObject:SetActive(false)
    end

    if(editShopButtonUI.gameObject == go) then
        editShopButtonUI.gameObject:SetActive(true)
    else
        editShopButtonUI.gameObject:SetActive(false)
    end

    if(editShopUI.gameObject == go) then
        editShopUI.gameObject:SetActive(true)
    else
        editShopUI.gameObject:SetActive(false)
    end

    if(ownedDecorationsUI.gameObject == go) then
        ownedDecorationsUI.gameObject:SetActive(true)
    else
        ownedDecorationsUI.gameObject:SetActive(false)
    end
end

function SwitchShop()
    if(shopUI.gameObject.activeSelf) then
        SwitchUI(self.gameObject)
    else
        SwitchUI(shopUI.gameObject)
        UpdateSellingRate()
        UpdateToysList()
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

function SwitchTutorialOff()
    SwitchUI(self.gameObject)
end

function SwitchTutorial()
    if(tutorialUI.gameObject.activeSelf) then
        SwitchUI(self.gameObject)
    else
        SwitchUI(tutorialUI.gameObject)
    end
end

function UpdateCoinsAmount(coinsAmount)
    leftHUD.SetCoinsAmount(coinsAmount)
end

function UpdateSellingRate()
    shopUI.SetSellingRate()
end

function ShopCreateToysList()
    shopUI.CreateToysList(0)
end

function UpdateToysList()
    shopUI.UpdateToysList()
end

function UpdateToysAmount(toysAmount)
    shopUI.SetToysAmount(toysAmount)
end

function StartTutorialFromBeginning()
    tutorialUI.StartTutorial()
end

function ShowCollectedToy(toyName, rarity)
    toyCollectedUI.ShowAToy(toyName, rarity)
    toyCollectedUI.gameObject:SetActive(true)
end

function SwitchEditShopButton(show)
    if(show) then
        SwitchUI(editShopButtonUI.gameObject)
    else
        SwitchUI(self.gameObject)
    end
end

function SwitchEditShop(show)
    if(show) then
        SwitchUI(editShopUI.gameObject)
    else
        SwitchUI(self.gameObject)
    end
end

function SwitchDecorationsOwned()
    if(ownedDecorationsUI.gameObject.activeSelf) then
        SwitchUI(self.gameObject)
    else
        SwitchUI(ownedDecorationsUI.gameObject)
        UpdateDecorationsOwned()
    end
end

function UpdateDecorationsOwned()
    ownedDecorationsUI.CreateDecorationsList()
end