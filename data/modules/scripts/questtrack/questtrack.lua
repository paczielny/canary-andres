function onRecvbyte(player, msg, byte)
	if byte == 0xD0 then
		local data = player:getCastViewers()
		if data and data.broadcast then
			player:sendCancelMessage("You cannot use these systems during the cast system live.")
			return
		end

		local quests = {}
		local missions = msg:getByte()
		for i = 1, missions do
			quests[#quests + 1] = msg:getU16()
		end
		player:resetTrackedMissions(quests)
	end
end
