---Some utility functions for weapons

function attachGunToHand(carrierObject, handBone, gunObject)

	local bn=get(ig3d_bone, carrierObject.cObj, handBone)
	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getBoneInfo(bn, IG3D_ROTATION_MATRIX)
	local x,y,z=getBoneInfo(bn, IG3D_POSITION)
	setObjectInfo(gunObject.cObj, IG3D_ROTATION_MATRIX, a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, x,y,z,1)
	bn=get(ig3d_bone, gunObject.cObj, "None")
	setBoneInfo(bn, IG3D_ROTATION, 90.089622497559, 1.0486701726913, -84.99787902832)
	setBoneInfo(bn, IG3D_POSITION, -0.11,-0.02,0)
	
end


function aimingAtFriendlyObject(obj, ax,ay,az, bx,by,bz)
	local oldcoll=getObjectInfo(obj.cObj, IG3D_COLL)
	setObjectInfo(obj.cObj, IG3D_COLL, false)
	local c,px,py,pz,o=lineCollision(ax,ay,az, bx,by,bz)
	setObjectInfo(obj.cObj, IG3D_COLL, oldcoll)
	
	if c==2 and o.team==obj.team then 
		return true
	else
		return false
	end

end


function friendlyObjectsInAreaOfEnemy(obj, enemyObj, dst)
	local i
	local x,y,z=getObjectInfo(enemyObj.cObj, IG3D_POSITION)
	
	for i=1,#gObjects,1 do
		if gObjects[i]~= obj and gObjects[i]~= enemyObj and gObjects[i].alive and gObjects[i].team==obj.team then
			local x2,y2,z2=getObjectInfo(gObjects[i].cObj, IG3D_POSITION)
			local d=vecLength(x2-x,y2-y,z2-z)
			if d<dst then return true end
		end
	end
	return false
end

function rightHandedPistols()
	----now position all guns that are in the hands of people
	for i=1,#gObjects,1 do
		gObjects[i].blood=false
		if gObjects[i].gun ~= nil then
			attachGunToHand(gObjects[i],"rHand",gObjects[i].gun)
		end
	end
end