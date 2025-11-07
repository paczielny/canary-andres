function onCreateFireWall(creature, position)  
	local tile = Tile(position)  
	if not tile then  
		return false  
	end  
  
	local item = Game.createItem(ITEM_FIREFIELD_PVP_FULL, 1)  
	if item then  
		item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, string.format("Casted by: %s", creature:getName()))  
		item:setOwner(creature)  
		  
		tile:addItemEx(item)  
        item:decay() 
	end  
	return true  
end  
  
local combat = Combat()  
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)  
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITBYFIRE)  
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)  
combat:setArea(createCombatArea(AREA_WALLFIELD, AREADIAGONAL_WALLFIELD))  
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onCreateFireWall")  
  
local rune = Spell("rune")  
  
function rune.onCastSpell(creature, var, isHotkey)  
	return combat:execute(creature, var)  
end  
  
rune:id(28)  
rune:group("attack")  
rune:name("fire wall rune")  
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)  
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_FIRE_WALL_RUNE)  
rune:runeId(3190)  
rune:allowFarUse(true)  
rune:setPzLocked(true)  
rune:charges(4)  
rune:level(33)  
rune:magicLevel(6)  
rune:cooldown(2 * 1000)  
rune:groupCooldown(2 * 1000)  
rune:isBlocking(false)  
rune:register()