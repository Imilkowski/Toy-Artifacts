The Action Bar asset adds a button bar above the chat box that custom actions can be added and removed from.  Includes a fully-functional teleporter prefab that uses the Action bar.

Action Bar features:
-Functions to add and remove buttons from the action bar
-Ability to set the order of the buttons

Teleporter features:
-Right click options in the Hierarchy tab to add One-Way and Two-Way Teleporters
-Customizable Action Bar icons per teleporter
-Customizable teleportation particle effect
-Customizable sound when teleporting (only when the local player teleports)
-Option to move camera to your character after teleporting
-Option to use the Action bar or immediately teleport 

How to use: Drag this asset into the scene to create the ActionBarManager
To add teleporters, right click in the Hierarchy tab and select Highrise > One-Way or Two-Way Teleporter.

Want to create your own actions for the action bar?  Here's some sample code:

--!Type(Client)

--!SerializeField
--!Tooltip("Icon for the action bar")
local icon : Texture2D = nil

local actionBarManager = require("ActionBarManager")

function self:ClientStart()
	actionBarManager.AddAction(icon, OnActionButton, 0)
end

function OnActionButton()
	--Here's where you put the code that should run when you press the button in the Action Bar
end