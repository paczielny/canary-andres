local customTeleport = MoveEvent()  
  
function customTeleport.onStepIn(creature, item, position, fromPosition)  
	local player = creature:getPlayer()  
	if not player then  
		return true  
	end  
  
	-- Verificar que estamos en la posición correcta  
	if position == Position(32373, 32236, 7) then  
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)  
		player:teleportTo(Position(33472, 32539, 10))  
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)  
	end  
	  
	return true  
end  
  
customTeleport:type("stepin")  
customTeleport:id(60154)  
customTeleport:register()