function onRecvbyte(player, msg, byte)
	if IsRunningGlobalDatapack() and player then
		local data = player:getCastViewers()
		if data and data.broadcast then
			return player:sendCancelMessage("You cannot use these systems during the cast system live.")
		end
		local storageDeathFake = player:getStorageValue(Storage.CultsOfTibia.Barkless.Death)
		if storageDeathFake == 1 then
			player:setStorageValue(Storage.CultsOfTibia.Barkless.Death, 0)
			player:addHealth(player:getMaxHealth())
			player:addMana(player:getMaxMana())
			player:setHiddenHealth(false)
			player:removeCondition(CONDITION_OUTFIT)
			player:teleportTo(player:getTown():getTemplePosition(), true)
		end
	end
end
