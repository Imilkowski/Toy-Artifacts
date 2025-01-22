--!Type(UI)

local ToysModule = require("ToysModule")

--!Bind
local _counterLabel : UILabel = nil
--!Bind
local _Button : UIButton = nil

local counter = 0 -- Initialize the counter

-- Register a callback for when the button is pressed
_Button:RegisterPressCallback(function()
    -- counter = counter + 1 -- Increment the counter
    counter = ToysModule.GetRandomRarity()
    _counterLabel:SetPrelocalizedText(tostring(counter)) -- Update the label text
end, true, true, true)