local emptyXmasBathtub = Action()  
  
function emptyXmasBathtub.onUse(player, item, fromPosition, target, toPosition, isHotkey)  
    -- Verificar que estamos usando la bañera llena directamente  
    if item.itemid ~= 52884 then  
        return false  
    end  
      
    -- Transformar a bañera vacía  
    item:transform(52883)  
    toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)  
      
    return true  
end  
  
emptyXmasBathtub:id(52884)  -- Registrar para la bañera llena  
emptyXmasBathtub:register()