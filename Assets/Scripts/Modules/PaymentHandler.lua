--!Type(Module)

local SaveModule = require("SaveModule")

local addCoinsEvent = Event.new("Add Coins Event")

-- Server Side

function self:ServerAwake()
    Payments.PurchaseHandler = ServerHandlePurchase
end

-- Function to handle the purchase
function ServerHandlePurchase(purchase, player: Player)
    local productId = purchase.product_id

    local coinsAmount = 0

    if productId == "small-coins-pack" then
        coinsAmount = 500
    elseif productId == "medium-coins-pack" then
        coinsAmount = 2000
    elseif productId == "big-coins-pack" then
        coinsAmount = 6000
    else
        -- No product found, reject the purchase and return
        Payments.AcknowledgePurchase(purchase, false)
        print("Unknown product ID: " .. productId)
        return
    end

    -- The purchase was successful, acknowledge the purchase and give the player coins
    Payments.AcknowledgePurchase(purchase, true, function(ackErr: PaymentsError)
        if ackErr ~= PaymentsError.None then
            print(ackErr)
            return
        end

        addCoinsEvent:FireClient(player, coinsAmount)
    end)
end

-- Client Side

function self:ClientAwake()
    addCoinsEvent:Connect(function(coinsAmount)
        SaveModule.BuyCoinsIWP(client.localPlayer, coinsAmount)
    end)
end

-- Function to Prompt the player to purchase coins
function PromptIWPPurchase(id: string)
    Payments:PromptPurchase(id, function(paid)
    if paid then
        print("Purchase successful")
    else
        print("Purchase failed")
    end
    end)
end