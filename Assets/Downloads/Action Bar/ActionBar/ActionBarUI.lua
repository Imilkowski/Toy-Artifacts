--!Type(UI)

local sortingValues : {[VisualElement] : number} = {}

function AddButton(icon : Texture2D, callback : () -> (), sorting : number) : VisualElement
    local button = VisualElement.new()
    button:AddToClassList("actionButton")
    button:RegisterPressCallback(callback)

    local image = Image.new()
    image:AddToClassList("buttonImage")
    image.image = icon
    button:Add(image)

    view:Add(button)
    sortingValues[button] = sorting

    for index, child in view:Children() do
        if(sortingValues[child] > sorting) then
            button:PlaceBehind(child)
            break
        end
    end

    return button
end

function RemoveButton(button : VisualElement)
    view:Remove(button)
    sortingValues[button] = nil
end