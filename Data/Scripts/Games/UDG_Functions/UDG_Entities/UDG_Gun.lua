guns={}

gunNames={}
--[[
rifles={"rifle","Rifle","M198","shotgun","launcher","submachine","m198","m98","m16","mp40","machinegun","submachinegun"}
pistols={"glock","gun","pistol","disc","bow","colt","luger"}
energyweapons={"tracer","thrower","blaster","phaser","plasma"}
rockets={"rocket","rpg","mortar","grenade","rpgloaded","rpgempty"}
--]]
rifles={"Weapons/marinerifle.wtf","Weapons/shotgun626A.wtf","Weapons/m98_158.wtf","Weapons/mp40_186.wtf","Weapons/hk53Submachinegun.wtf","Weapons/M198Rifle548.wtf","Weapons/marinerifle350.wtf","Weapons/m16980.wtf","Weapons/M16A524.wtf","mp40_SMGun186"}
pistols={"Weapons/gloc.wtf","Weapons/luger140.wtf","Weapons/deadlydisc.wtf"}
energyweapons={"Weapons/lazerrifle.wtf"}
rockets={"Weapons/grenade.wtf","Weapons/rpgempty.wtf"}

	for i = 1,#pistols,1 do
	table.insert(gunNames,pistols[i])
	end
	for i = 1,#rifles,1 do
	table.insert(gunNames,rifles[i])
	end
	for i = 1,#energyweapons,1 do
	table.insert(gunNames,energyweapons[i])
	end
	for i = 1,#rockets,1 do
	table.insert(gunNames,rockets[i])
	end



function isPistol(tname)
for i = 1,#pistols,1 do
if string.find(tname,pistols[i]) then return true end
end
return false
end

function isRifle(tname)
for i = 1,#rifles,1 do
if string.find(tname,rifles[i]) then return true end
end
return false
end

function isEnergyWeapon(tname)
for i = 1,#energyweapons,1 do
if string.find(tname,energyweapons[i]) then return true end
end
return false
end

function isRocket(tname)
for i = 1,#rockets,1 do
if string.find(tname,rockets[i]) then return true end
end
return false
end



function isGun(tname,sourcename)
for i = 1,#gunNames,1 do
ln=string.len(gunNames[i])
--if string.find(string.sub(tname,ln),gunNames[i]) ~= nil then return true end
--if string.find(tname,gunNames[i]) ~= nil then return true end
if string.find(sourcename,gunNames[i]) ~= nil  then return true end
end
return false
end



local i,ii,shortname,checkName
for i=1,#gObjects,1 do
	checkName=getObjectInfo(gObjects[i].cObj, IG3D_NAME)
	
	sourceWTF =gObjectWTFs[i]
	if isGun(checkName,sourceWTF) == true  then
	
	gObjects[i].alive=false
	gObjects[i].isGun=true
	gObjects[i].isHuman=false
	gObjects[i].isZombie=false
	gObjects[i].isVehicle=false
	
	gObjects[i].deathCount=0
	resetCollisionToDefault(gObjects[i])
	setObjectInfo(gObjects[i].cObj, IG3D_IGNORE_OBJECT_COLLS, true)
	
	table.insert(guns, gObjects[i])
	guns[#guns].alive = false 
	if isRifle(sourceWTF) then
	gObjects[i].team=16
	guns[#guns].team=16
		guns[#guns].interval=0.1
		guns[#guns].intervalDeviation=0
		guns[#guns].sample="Data/Sounds/rifle.ogg"
		guns[#guns].shots= 32 -- has 32 shots by default
		guns[#guns].recharge={16,32}
	else
	gObjects[i].team=15
	guns[#guns].team=15
		guns[#guns].interval=0.4
		guns[#guns].intervalDeviation=0.4
		guns[#guns].sample="Data/Sounds/colt45.ogg"
		guns[#guns].shots= 8 -- has 8 shots by default
		guns[#guns].recharge={4,8}
	end
	--print("gun "..#guns.." = "..getObjectInfo(gObjects[i].cObj, IG3D_NAME))
	--print(getObjectInfo(gObjects[i].cObj, IG3D_NAME))
	end
end
	
--[[
function HumansWithGuns()
	local gunsToDistribute=math.min(#humans,#guns)
	--randomly give people guns
	local n=0
	while n<gunsToDistribute do
		local obj=humans[math.random(1,#humans)]
		if not obj.gun and not obj.meleeWeapon then
			n=n+1
			obj.behaviour = gunned_civilian_behaviour
			obj.gunSndEmt = assign_free_sound_emitter()
			setSound_emitterInfo(obj.gunSndEmt, IG3D_SAMPLE, guns[n].sample)
			obj.gun = guns[n]
			setObjectInfo(guns[n].cObj, IG3D_COLL, false)
			setObjectInfo(guns[n].cObj, IG3D_GRAVITY_MULTIPLIER, 0)
			--print(getObjectInfo(obj.cObj, IG3D_NAME), "got a gun")
		end
	end
end
--]]
function assign_gun(obj, gun)
	obj.behaviour = gunned_civilian_behaviour
	obj.gunSndEmt = assign_free_sound_emitter()
	setSound_emitterInfo(obj.gunSndEmt, IG3D_SAMPLE, gun.sample)
	obj.gun = gun
	setObjectInfo(gun.cObj, IG3D_COLL, false)
	setObjectInfo(gun.cObj, IG3D_GRAVITY_MULTIPLIER, 0)
end

--new HumansWithGuns() distributes guns to soldiers first, then to police officers and the remaining ones to civilians!!
function HumansWithGuns()
	local gunsToDistribute=math.min(#humans,#guns)
	local n=0
	
	--first round: soldier guns (they also get a grenade)
	local i
	for i=1,#humans,1 do
		if n>= gunsToDistribute then return end
		
		if string.find(getObjectInfo(humans[i].cObj, IG3D_MODEL),"soldier") then
			n=n+1
			assign_gun(humans[i], guns[n])
			humans[i].numGrenades=2
			humans[i].meleeDelay=0.9
			humans[i].meleeInterval=0.9
		end
	end
	
	--second round: police guns
	for i=1,#humans,1 do
		if n>= gunsToDistribute then return end
		if string.find(getObjectInfo(humans[i].cObj, IG3D_MODEL),"police")  then
			n=n+1
			assign_gun(humans[i], guns[n])
			humans[i].meleeDelay=0.9
			humans[i].meleeInterval=0.9
			--humans[i].numGrenades=1
		end
	end
	
	--distribute remaining guns
	while n<gunsToDistribute do
		local obj=humans[math.random(1,#humans)]
		if not obj.gun and not obj.meleeWeapon then
			n=n+1
			assign_gun(obj, guns[n])
			obj.meleeDelay=0.9
			obj.meleeInterval=0.9
		end
	end
end



--print("# guns=",#guns)


gGunIterator=1
function iterateHumansWithGuns(i,n)
if n > #guns then
n= 1 
gGunIterator=1
end

	--randomly give people guns, if a gun happens to map to an object, which already has a gun, this gun is ignored, ie can be picked up from floor
	
		local obj=humans[i]
		if not obj.gun and not obj.meleeWeapon then
			obj.behaviour = gunned_civilian_behaviour
			obj.gunSndEmt = assign_free_sound_emitter()
			setSound_emitterInfo(obj.gunSndEmt, IG3D_SAMPLE, guns[n].sample)
			obj.gun = guns[n]
			setObjectInfo(guns[n].cObj, IG3D_COLL, false)
			setObjectInfo(guns[n].cObj, IG3D_GRAVITY_MULTIPLIER, 0)
		end
end






function udg_sniper_guns()
local i,ii,shortname,checkName
for i=1,#gObjects,1 do
	checkName=string.sub(getObjectInfo(gObjects[i].cObj, IG3D_NAME),1,3)
	local shortname = string.sub(checkName, 1,3)
	
	if shortname== "glo" or shortname== "gun" or shortname== "rif" then
	table.insert(guns, gObjects[i])
	guns[#guns].alive = false 
	
	resetCollisionToDefault(gObjects[i])
	
	gObjects[i].isGun=true
	gObjects[i].deathCount=0
	if shortname=="rif" then
		guns[#guns].interval=0.8
		guns[#guns].sample="Data/Sounds/rifle.ogg"
		guns[#guns].shots= 999 -- has 8 shots by default
		guns[#guns].recharge={999,999}
	else
		gObjects[i].interval=0.8
		gObjects[i].sample="Data/Sounds/colt45.ogg"
		guns[#guns].shots= 999 -- has 8 shots by default
		guns[#guns].recharge={999,999}
	end
	--print("gun "..#guns.." = "..getObjectInfo(gObjects[i].cObj, IG3D_NAME))
	--print(getObjectInfo(gObjects[i].cObj, IG3D_NAME))
	end
end
end