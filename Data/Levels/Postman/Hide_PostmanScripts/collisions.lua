function objectAgainstObject(objA, boneA, objB, boneB, x,y,z)
	if objA==gPlayer then
		if getObjectInfo(objB.cObj, IG3D_MODEL)=="Characters/grandma.wtf" then
			pickup_powerup(gGrandma)
		end
	end
	
	if objB==gPlayer then
		if getObjectInfo(objA.cObj, IG3D_MODEL)=="Characters/grandma.wtf" then
			pickup_powerup(gGrandma)
		end
	end
	
	
	if getObjectInfo(objA.cObj, IG3D_MODEL)=="Characters/grandma.wtf" then
		local theDir= gGrandmaDirections[math.random(1,4)]
		objA.velx=theDir[1]
		objA.velz=theDir[2]
	end
	
	if getObjectInfo(objB.cObj, IG3D_MODEL)=="Characters/grandma.wtf" then
		local theDir= gGrandmaDirections[math.random(1,4)]
		objB.velx=theDir[1]
		objB.velz=theDir[2]
	end
end


function objectAgainstMesh(obj, bone, x,y,z)
	if getObjectInfo(obj.cObj, IG3D_MODEL)=="Characters/grandma.wtf" then
		if y>0.05 then
			local theDir= gGrandmaDirections[math.random(1,4)]
			obj.velx=theDir[1]
			obj.velz=theDir[2]
		end
		
	end

end

coll_o_o=objectAgainstObject
coll_o_m=objectAgainstMesh