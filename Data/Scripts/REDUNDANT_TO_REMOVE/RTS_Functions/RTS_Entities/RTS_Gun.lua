guns={}
local i,ii,shortname,checkName
for i=1,#gObjects,1 do
	checkName=string.sub(getObjectInfo(gObjects[i].cObj, IG3D_NAME),1,3)
	local shortname = string.sub(checkName, 1,3)
	
	if shortname== "glo" or shortname== "gun" or shortname== "rif" then
	table.insert(guns, gObjects[i])
	guns[#guns].alive = false 
	
	setObjectInfo(gObjects[i].cObj, IG3D_VECTOR_CONSTRAINT, 0,0,0)
	setObjectInfo(gObjects[i].cObj, IG3D_BONE_COLL, false)
	setObjectInfo(gObjects[i].cObj, IG3D_SHAPE, ig3d_box)
	gObjects[i].isGun=true
	if shortname=="rif" then
		guns[#guns].interval=0.1
		guns[#guns].intervalDeviation=0
		guns[#guns].sample="Data/Sounds/rifle.ogg"
		guns[#guns].shots= 32 -- has 8 shots by default
		guns[#guns].recharge={16,32}
	else
		gObjects[i].interval=0.4
		guns[#guns].intervalDeviation=0.4
		gObjects[i].sample="Data/Sounds/colt45.ogg"
		guns[#guns].shots= 8 -- has 8 shots by default
		guns[#guns].recharge={4,8}
	end
	--print("gun "..#guns.." = "..getObjectInfo(gObjects[i].cObj, IG3D_NAME))
	--print(getObjectInfo(gObjects[i].cObj, IG3D_NAME))
	end
end
	

function HumansWithGuns()
	local n

	--randomly give people guns, if a gun happens to map to an object, which already has a gun, this gun is ignored, ie can be picked up from floor
	for n=1,#guns,1 do
		local obj=humans[math.random(1,#humans)]
		if not obj.gun then
			obj.behaviour = gunned_civilian_behaviour
			obj.gunSndEmt = assign_free_sound_emitter()
			setSound_emitterInfo(obj.gunSndEmt, IG3D_SAMPLE, guns[n].sample)
			obj.gun = guns[n]
			setObjectInfo(guns[n].cObj, IG3D_COLL, false)
			setObjectInfo(guns[n].cObj, IG3D_GRAVITY_MULTIPLIER, 0)
		end
end


end
--print("# guns=",#guns)