--!Type(Module)

-- --!SerializeField
-- local toysAmountUI : ToysAmount_UI = nil

--!SerializeField
local leftHUD : LeftHUD_UI = nil

function UpdateCoinsAmount(coinsAmount)
    leftHUD.SetCoinsAmount(coinsAmount)
end

function UpdateToysAmount(toysAmount)
    --toysAmountUI.SetAmount(toysAmount)
end