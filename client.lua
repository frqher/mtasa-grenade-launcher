engineImportTXD (engineLoadTXD("file/shotgspa.txd"), 366)
engineReplaceModel(engineLoadDFF("file/shotgspa.dff", 366), 366)

local force = 0.1
local spam_engel

function granadeForceYukselt()
	if force >= 1.1	then return end
	force = force + 0.05
end

function granadeForceStop()
	removeEventHandler("onClientRender", root, granadeForceYukselt)
end

function granadeForceStart()
	if getPedTask(localPlayer, "secondary", 0) == "TASK_SIMPLE_USE_GUN" then
		if durum_grenade == false then return end
		addEventHandler("onClientRender", root, granadeForceYukselt)
	end
end

function fireGranade(key, keyState)
	if getPedWeapon(localPlayer) == 42 then
		if getPedTask(localPlayer, "secondary", 0) == "TASK_SIMPLE_USE_GUN" then
			if force <= 0.1 then return end
			
			if spam_engel and getTickCount() - spam_engel < 5000 then outputChatBox("5 saniye dolmadan kullanamazsınız", 255, 0, 0, true) return end
			spam_engel = getTickCount()
			
			local id = 16
			local x, y, z = getElementPosition( localPlayer )
			createProjectile( localPlayer, id, x, y, z, force)
			force = 0.1
			triggerServerEvent("grenade:use", localPlayer, id)
		end
	end
end
bindKey("mouse1", "down", granadeForceStart)
bindKey("mouse1", "up", granadeForceStop)
bindKey("mouse1", "up", fireGranade)


addEventHandler("onClientPlayerWeaponSwitch", getRootElement(), function(prevSlot, curSlot)
	if source == localPlayer then
		if getPedWeapon(source, curSlot) == 42 then 
			toggleControl("fire", false)
			toggleControl("action", false)
		else
			toggleControl("fire", true)
			toggleControl("action", true)
		end
	end
end)