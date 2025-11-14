local bathtubEnter = MoveEvent()

function bathtubEnter.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local condition = Condition(CONDITION_OUTFIT)
	condition:setOutfit({ lookTypeEx = 26087 })
	condition:setTicks(-1)

	position:sendMagicEffect(CONST_ME_WATERSPLASH)
	item:transform(BATHTUB_FILLED_NOTMOVABLE)
	player:addCondition(condition)
	return true
end

bathtubEnter:type("stepin")
bathtubEnter:id(BATHTUB_FILLED)
bathtubEnter:register()

local bathtubExit = MoveEvent()

function bathtubExit.onStepOut(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	item:transform(BATHTUB_FILLED)
	player:removeCondition(CONDITION_OUTFIT)
	return true
end

bathtubExit:type("stepout")
bathtubExit:id(BATHTUB_FILLED_NOTMOVABLE)
bathtubExit:register()

local newBathtubEnter = MoveEvent()  
  
function newBathtubEnter.onStepIn(creature, item, position, fromPosition)  
	local player = creature:getPlayer()  
	if not player then  
		return true  
	end  
  
	local condition = Condition(CONDITION_OUTFIT)  
	local lookTypeEx = player:getSex() == PLAYERSEX_FEMALE and 52891 or 52893  
	condition:setOutfit({ lookTypeEx = lookTypeEx }) 
	condition:setTicks(-1)  
  
	position:sendMagicEffect(CONST_ME_WATERSPLASH)  
	item:transform(XMAS_BATHTUB_FILLED_NOTMOVABLE)
	player:addCondition(condition)
	return true  
end  
  
newBathtubEnter:type("stepin")    
newBathtubEnter:id(XMAS_BATHTUB_FILLED)
newBathtubEnter:register()  
  
local newBathtubExit = MoveEvent()  
  
function newBathtubExit.onStepOut(creature, item, position, fromPosition)  
	local player = creature:getPlayer()  
	if not player then  
		return true  
	end  
  
	item:transform(XMAS_BATHTUB_FILLED)
	player:removeCondition(CONDITION_OUTFIT)  
	return true  
end  
  
newBathtubExit:type("stepout")    
newBathtubExit:id(XMAS_BATHTUB_FILLED_NOTMOVABLE)
newBathtubExit:register()