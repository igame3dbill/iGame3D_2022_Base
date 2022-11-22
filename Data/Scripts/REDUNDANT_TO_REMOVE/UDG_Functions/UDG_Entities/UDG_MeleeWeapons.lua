function isTwoHandedWeapon(obj)
	local pth=ig3d_GetObjectModelPath_s_s(getObjectInfo(obj.cObj, IG3D_NAME))
	local mdl=string.sub(pth, #gameroot+10,-1)
	if mdl=="Tools/broom" then return true end
	if mdl=="Tools/mallet228" then return true end
	if mdl=="Weapons/rpgempty" then return true end
	if mdl=="Weapons/halberd292.wtf" then return true end
	if mdl=="Weapons/icepick.wtf" then return true end
	if mdl=="Weapons/leadpipe84.wtf" then return true end
	if mdl=="Weapons/bostaff84.wtf" then return true end
	if string.find(mdl,"baton") then return true end
	if string.find(mdl,"shovel") then return true end
	if string.find(mdl,"spear") then return true end
	if string.find(mdl,"sword") then return true end
	if string.find(mdl,"Tools") then return true end
	return false
end

--in progress
--[[
function isSingleHandedWeapon(obj)
	local pth=ig3d_GetObjectModelPath_s_s(getObjectInfo(obj.cObj, IG3D_NAME))
	local mdl=string.sub(pth, #gameroot+10,-1)
	if mdl=="Tools/snowshovel.wtf" then return true end
	if mdl=="Weapons/halberd292.wtf" then return true end
	return false
end
--]]

meleeWeapons={}
local i,ii,shortname,checkName
for i=1,#gObjects,1 do
	if isTwoHandedWeapon(gObjects[i]) then
		table.insert(meleeWeapons, gObjects[i])
		meleeWeapons[#meleeWeapons].alive = false
		meleeWeapons[#meleeWeapons].team=meleeWeaponsTeam 
		--just an object, forget about any strange collision stuff set before
		resetCollisionToDefault(gObjects[i])
		setObjectInfo(gObjects[i].cObj, IG3D_IGNORE_OBJECT_COLLS, true)
		
		gObjects[i].isMeleeWeapon=true
		gObjects[i].deathCount=0
		--[[
		gObjects[i].isGun=true
		if shortname=="rif" then
			meleeWeapons[#meleeWeapons].interval=0.1
			meleeWeapons[#meleeWeapons].sample="Data/Sounds/rifle.ogg"
			meleeWeapons[#meleeWeapons].shots= 32 -- has 8 shots by default
			meleeWeapons[#meleeWeapons].recharge={16,32}
		else
			gObjects[i].interval=0.4
			gObjects[i].sample="Data/Sounds/colt45.ogg"
			meleeWeapons[#meleeWeapons].shots= 8 -- has 8 shots by default
			meleeWeapons[#meleeWeapons].recharge={4,8}
		end
		--]]
	
	end
end

--melee weapons are distributed after guns, so see how many can be distributed
function HumansWithMeleeWeapons()
	local meleesToDistribute=math.min( #humans-math.min(#humans,#guns), #meleeWeapons)
	--randomly give people guns, if a gun happens to map to an object, which already has a gun, this gun is ignored, ie can be picked up from floor
	local n=0
	while n< meleesToDistribute do
		local obj=humans[math.random(1,#humans)]
		if not obj.gun and not obj.meleeWeapon then
			n=n+1
			obj.behaviour = civilian_with_melee_weapon_behaviour
			setObjectInfo(meleeWeapons[n].cObj, IG3D_COLL, false)
			setObjectInfo(meleeWeapons[n].cObj, IG3D_GRAVITY_MULTIPLIER, 0)
			obj.meleeWeapon=meleeWeapons[n]
			obj.meleeDelay=0.9
			obj.meleeInterval=0.9
			obj.mayStunThisCombat=true
		end
	end
end




gMeleeIterator=1
function iterateHumansWithMeleeWeapons(i,n)
	--print(gMeleeIterator)
if n > #meleeWeapons then
n=1
gMeleeIterator = 1
end
	--randomly give people melee weapons, if a gun happens to map to an object, which already has a gun, this gun is ignored, ie can be picked up from floor
	
		local obj=humans[i]
		if not obj.gun and not obj.meleeWeapon then
			obj.behaviour = civilian_with_melee_weapon_behaviour
			--obj.behaviour = gunned_civilian_behaviour
			--obj.meleeWeaponsndEmt = assign_free_sound_emitter()
			--setSound_emitterInfo(obj.meleeWeaponsndEmt, IG3D_SAMPLE, meleeWeapons[n].sample)
			--obj.gun = meleeWeapons[n]
			setObjectInfo(meleeWeapons[n].cObj, IG3D_COLL, false)
			setObjectInfo(meleeWeapons[n].cObj, IG3D_GRAVITY_MULTIPLIER, 0)
			obj.meleeWeapon=meleeWeapons[n]
			obj.meleeDelay=0.9
			obj.meleeInterval=0.9
			obj.mayStunThisCombat=true
		end
end





--print("# meleeWeapons=",#meleeWeapons)