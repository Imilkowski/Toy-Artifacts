--!Type(Module)

--!SerializeField
local actionBarUI : ActionBarUI = nil

local actions : {[() -> ()] : VisualElement} = {}

function self:ClientStart()
    --Adds a new button to the action bar with the given icon that calls the
    --given function when pressed.  The order of the buttons is determined
    --by the sorting value, lower numbers will be to the left of higher ones
    function AddAction(icon : Texture2D, callback : () -> (), sorting : number)
        local button = actionBarUI.AddButton(icon, callback, sorting)
        actions[callback] = button
    end

    function RemoveAction(callback : () -> ())
        actionBarUI.RemoveButton(actions[callback])
        actions[callback] = nil
    end
end