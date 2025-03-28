--!Type(Module)

local DecorationsModule = require("DecorationsModule")
local UtilsModule = require("UtilsModule")

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
local itemsShopUI : ItemsShop_UI = nil
--!SerializeField
local iwpUI : IWP_UI = nil

--!SerializeField
local editShopButtonUI : EditShopButton_UI = nil
--!SerializeField
local editShopUI : EditShop_UI = nil
--!SerializeField
local ownedDecorationsUI : OwnedDecorations_UI = nil
--!SerializeField
local placeDecorationUI : PlaceDecoration_UI = nil
--!SerializeField
local removeDecorationsUI : RemoveDecorations_UI = nil

function self:Start()
    local status, result = pcall(function()
        SwitchUI(self.gameObject)
        toyCollectedUI.gameObject:SetActive(false)
    end)
    
    if not status then end
end

function SwitchUI(go:GameObject)
    local UI_Visible = false

    if(shopUI.gameObject == go) then
        shopUI.gameObject:SetActive(true)
        UI_Visible = true
    else
        shopUI.gameObject:SetActive(false)
    end

    if(bridgePopUpUI.gameObject == go) then
        bridgePopUpUI.gameObject:SetActive(true)
        UI_Visible = true
    else
        bridgePopUpUI.gameObject:SetActive(false)
    end

    if(upgradesUI.gameObject == go) then
        upgradesUI.gameObject:SetActive(true)
        UI_Visible = true
    else
        upgradesUI.gameObject:SetActive(false)
    end

    if(tutorialUI.gameObject == go) then
        tutorialUI.gameObject:SetActive(true)
        UI_Visible = true
    else
        tutorialUI.gameObject:SetActive(false)
    end

    if(editShopButtonUI.gameObject == go) then
        editShopButtonUI.gameObject:SetActive(true)
        UI_Visible = true
    else
        editShopButtonUI.gameObject:SetActive(false)
    end

    if(editShopUI.gameObject == go) then
        editShopUI.gameObject:SetActive(true)
        UI_Visible = true
    else
        editShopUI.gameObject:SetActive(false)
    end

    if(ownedDecorationsUI.gameObject == go) then
        ownedDecorationsUI.gameObject:SetActive(true)
        UI_Visible = true
    else
        ownedDecorationsUI.gameObject:SetActive(false)
    end

    if(placeDecorationUI.gameObject == go) then
        placeDecorationUI.gameObject:SetActive(true)
        UI_Visible = true
    else
        placeDecorationUI.gameObject:SetActive(false)
    end

    if(removeDecorationsUI.gameObject == go) then
        removeDecorationsUI.gameObject:SetActive(true)
        UI_Visible = true
    else
        removeDecorationsUI.gameObject:SetActive(false)
    end

    if(itemsShopUI.gameObject == go) then
        itemsShopUI.gameObject:SetActive(true)
        UI_Visible = true
    else
        itemsShopUI.gameObject:SetActive(false)
    end

    if(iwpUI.gameObject == go) then
        iwpUI.gameObject:SetActive(true)
        UI_Visible = true
    else
        iwpUI.gameObject:SetActive(false)
    end

    if(not UI_Visible and UtilsModule.inOwnShop) then
        editShopButtonUI.gameObject:SetActive(true)
        UI_Visible = true
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

function SwitchPlaceDecoration()
    SwitchUI(placeDecorationUI.gameObject)
end

function SwitchRemoveDecorations()
    SwitchUI(removeDecorationsUI.gameObject)
end

function SwitchItemsShop(shopType)
    SwitchUI(itemsShopUI.gameObject)
    itemsShopUI.CreateItemsList(shopType)
end

function SwitchItemsShopOff()
    SwitchUI(self.gameObject)
end

function SwitchIWP()
    if(iwpUI.gameObject.activeSelf) then
        SwitchUI(self.gameObject)
    else
        SwitchUI(iwpUI.gameObject)
    end
end