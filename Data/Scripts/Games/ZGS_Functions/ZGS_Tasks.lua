function turn_away_from(obj1, obj2)
	if not obj1.alive then return end
	--obj1 should walk away from the obj2
	obj1.x,obj1.y,obj1.z=getObjectInfo(obj1.cObj, IG3D_POSITION)
	obj2.x,obj2.y,obj2.z=getObjectInfo(obj2.cObj, IG3D_POSITION)
	local dx,dy,dz=normalized(obj1.x-obj2.x,0,obj1.z-obj2.z)
	
	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj1.cObj, IG3D_ROTATION_MATRIX)
	d=dot(a31,a32,a33, dx,dy,dz)
	
	mult=2
	if dot(a11,a12,a13,dx,dy,dz)<dot(-a11,-a12,-a13,dx,dy,dz) then
		--turn... but in what direction?
		mult=-2
	end
	
	--you are in big trouble computing the acos of numbers < -1 or > 1, so clamp values for devil's sake!!!!!
	d=math.min(0.999999, math.max(-0.999999,d))
	setObjectInfo(obj1.cObj, IG3D_OMEGA, 0,math.acos(d)*mult,0)
end

function turn_towards(obj1, obj2)
	if not obj1.alive then return end
	--obj1 should walk to the obj2
	obj1.x,obj1.y,obj1.z=getObjectInfo(obj1.cObj, IG3D_POSITION)
	obj2.x,obj2.y,obj2.z=getObjectInfo(obj2.cObj, IG3D_POSITION)
	local dx,dy,dz=normalized(obj2.x-obj1.x,0,obj2.z-obj1.z)
	
	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj1.cObj, IG3D_ROTATION_MATRIX)
	d=dot(a31,a32,a33, dx,dy,dz)
	
	mult=2
	if dot(a11,a12,a13,dx,dy,dz)<dot(-a11,-a12,-a13,dx,dy,dz) then
		--turn... but in what direction?
		mult=-2
	end

	--you are in big trouble computing the acos of numbers < -1 or > 1, so clamp values!!!!!
	d=math.min(0.999999, math.max(-0.999999,d))
	setObjectInfo(obj1.cObj, IG3D_OMEGA, 0,math.acos(d)*mult,0)
end

function turn_towards_obj_bone(obj1, obj2, bn)
	if not obj1.alive then return end
	--obj1 should walk to head of obj2
	obj1.x,obj1.y,obj1.z=getObjectInfo(obj1.cObj, IG3D_POSITION)
	obj2.x,obj2.y,obj2.z=getBoneInfo(get(ig3d_bone, obj2.cObj, bn), IG3D_POSITION)
	local dx,dy,dz=normalized(obj2.x-obj1.x,0,obj2.z-obj1.z)
	
	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj1.cObj, IG3D_ROTATION_MATRIX)
	d=dot(a31,a32,a33, dx,dy,dz)
	
	mult=2
	if dot(a11,a12,a13,dx,dy,dz)<dot(-a11,-a12,-a13,dx,dy,dz) then
		--turn... but in what direction?
		mult=-2
	end

	--you are in big trouble computing the acos of numbers < -1 or > 1, so clamp values!!!!!
	d=math.min(0.999999, math.max(-0.999999,d))
	setObjectInfo(obj1.cObj, IG3D_OMEGA, 0,math.acos(d)*mult,0)
end

function turn_towards_spot(obj1, x,y,z)
	if not obj1.alive then return end
	--obj1 should walk to the x,y,z
	obj1.x,obj1.y,obj1.z=getObjectInfo(obj1.cObj, IG3D_POSITION)
	local dx,dy,dz=normalized(x-obj1.x, 0, z-obj1.z)
	
	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj1.cObj, IG3D_ROTATION_MATRIX)
	d=dot(a31,a32,a33, dx,dy,dz)
	
	mult=2
	if dot(a11,a12,a13,dx,dy,dz)<dot(-a11,-a12,-a13,dx,dy,dz) then
		--turn... but in what direction?
		mult=-2
	end

	--you are in big trouble computing the acos of numbers < -1 or > 1, so clamp values!!!!!
	d=math.min(0.999999, math.max(-0.999999,d))
	setObjectInfo(obj1.cObj, IG3D_OMEGA, 0,math.acos(d)*mult,0)
end
