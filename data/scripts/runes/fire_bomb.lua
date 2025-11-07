function onCreateFireField(creature, position)  
	local tile = Tile(position)  
	if not tile then  
		return false  
	end  
  
	-- Crear el item SIN posición  
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
combat:setArea(createCombatArea(AREA_SQUARE1X1))  
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onCreateFireField")  
  
local rune = Spell("rune")  
  
function rune.onCastSpell(creature, var, isHotkey)  
	return combat:execute(creature, var)  
end  
  
rune:id(17)  
rune:group("attack")  
rune:name("firebomb rune")  
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)  
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_FIRE_BOMB_RUNE)  
rune:runeId(3192)  
rune:allowFarUse(true)  
rune:setPzLocked(true)  
rune:charges(2)  
rune:level(27)  
rune:magicLevel(5)  
rune:cooldown(2 * 1000)  
rune:groupCooldown(2 * 1000)  
rune:isBlocking(false)  
rune:register()