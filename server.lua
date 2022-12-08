addEvent("grenade:use", true)
addEventHandler("grenade:use", root, function(id)
	takeWeapon(source, 42, 1)
end)
