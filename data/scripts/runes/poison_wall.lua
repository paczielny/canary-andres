function onCreatePoisonWall(creature, position)  
	local tile = Tile(position)  
	if not tile then  
		return false  
	end  
  
	-- Crear el item SIN posición  
	local item = Game.createItem(ITEM_POISONFIELD_PVP, 1)  
	if item then  
		item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, string.format("Casted by: %s", creature:getName()))  
		item:setOwner(creature)  
		  
		tile:addItemEx(item)  
        item:decay() 
	end  
	return true  
end  
  
local combat = Combat()  
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)  
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)  
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POISON)  
combat:setArea(createCombatArea(AREA_WALLFIELD, AREADIAGONAL_WALLFIELD))  
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onCreatePoisonWall")  
  
local rune = Spell("rune")  
  
function rune.onCastSpell(creature, var, isHotkey)  
	return combat:execute(creature, var)  
end  
  
rune:id(32)  
rune:group("attack")  
rune:name("poison wall rune")  
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)  
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_POISON_WALL_RUNE)  
rune:runeId(3176)  
rune:allowFarUse(true)  
rune:setPzLocked(true)  
rune:charges(4)  
rune:level(29)  
rune:magicLevel(5)  
rune:cooldown(2 * 1000)  
rune:groupCooldown(2 * 1000)  
rune:isBlocking(false)  
rune:register()