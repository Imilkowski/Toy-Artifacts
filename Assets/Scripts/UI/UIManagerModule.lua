--!Type(Module)

--!SerializeField
local leftHUD : LeftHUD_UI = nil
--!SerializeField
local shopUI : Shop_UI = nil

function self:Start()
    local status, result = pcall(function()
        SwitchShop()
    end)
    
    if not status then end
end

function SwitchShop()
    shopUI.gameObject.SetActive(shopUI.gameObject, not shopUI.gameObject.activeSelf)

    if(shopUI.gameObject.activeSelf) then
        UpdateSellingRate()
        ShopCreateToysList()
    end
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