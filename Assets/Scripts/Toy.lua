--!Type(Client)

local fadeOut = false
local childTransform

function self:Awake()
    childTransform = self.gameObject.transform:GetChild(0)
end

function DigUp(diggingPosition)
    self.transform.position = diggingPosition + Vector3.new(0, 0.25, 0)
    self.transform.rotation = Quaternion.Euler(0, Random.Range(0, 360), 0)
    
    local rb = childTransform:GetComponent(Rigidbody)
    rb:AddForce(Vector3.new(Random.Range(-50, 50), 250, Random.Range(-50, 50)))

    Timer.After(3, function() 
        fadeOut = true
    end)
end

function self:FixedUpdate()
    if(fadeOut ~= true) then return end

    childTransform.localScale *= 0.99

    if(childTransform.localScale.x <= 0.5) then
        GameObject.Destroy(self.gameObject)
    end
end

