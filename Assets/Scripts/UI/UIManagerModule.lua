--!Type(Module)

--!SerializeField
local coinsUI : Coins_UI = nil
--!SerializeField
local toysAmountUI : ToysAmount_UI = nil

function UpdateCoinsAmount(coinsAmount)
    coinsUI.SetAmount(coinsAmount)
end

function UpdateToysAmount(toysAmount)
    toysAmountUI.SetAmount(toysAmount)
end