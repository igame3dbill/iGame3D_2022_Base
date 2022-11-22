function attachGunToObject(target, source, handbone, armbone, shoulderbone)
	local b1=get(ig3d_bone, target, armbone)
	local b2=get(ig3d_bone, target, handbone)
	local b3=get(ig3d_bone, target, shoulderbone)
	local x1,y1,z1=getBoneInfo(b1, IG3D_POSITION)
	local x2,y2,z2=getBoneInfo(b2, IG3D_POSITION)
	local dx=x1-x2
	local dy=y1-y2
	local dz=z1-z2
	local x3,y3,z3=getBoneInfo(b3, IG3D_POSITION)
	local dx2=x2-x3
	local dy2=y2-y3
	local dz2=z2-z3
	
	b11,b12,b13,b14, b21,b22,b23,b24, b31,b32,b33,b34, b41,b42,b43,b44=getObjectInfo(target, IG3D_ROTATION_MATRIX)

	x2=x2-dx*0.9
	y2=y2-dy*0.9
	z2=z2-dz*0.9

	a31,a32,a33=normalized(dx,dy,dz)
	a11,a12,a13=cross(dx2,dy2,dz2, a31,a32,a33)
	a21,a22,a23=cross(a11,a12,a13, a31,a32,a33)
	 
	setObjectInfo(source, IG3D_ROTATION_MATRIX, a11,a12,a13,0, a21,a22,a23,0, a31,a32,a33,0, x2,y2,z2,1)
end

function onehandgunfocus(obj, x,y,z)
	local b1=get(ig3d_bone, obj.cObj, "RightHand")
	local b2=get(ig3d_bone, obj.cObj, "RightArm")
	local b3=get(ig3d_bone, obj.cObj, "Chest")
	local b4=get(ig3d_bone, obj.cObj, "LowerRightArm")
	if not obj.shooting then
		setBoneInfo(b4, IG3D_ROTATION, 0,0,0)
	end
	setBoneInfo(b3, IG3D_ROTATION, 0,0,0)
	setBoneInfo(b2, IG3D_ROTATION, -90,0,0)
	local x1,y1,z1=getBoneInfo(b4, IG3D_POSITION)--b1
	local x2,y2,z2=getBoneInfo(b2, IG3D_POSITION)
	local dx=x1-x2
	local dy=y1-y2
	local dz=z1-z2
	local tx=x-x2
	local ty=y-y2
	local tz=z-z2
	local rtd=180.0/3.14157
	local dx2,dy2,dz2=normalized(dx,0,dz)
	local tx2,ty2,tz2=normalized(tx,0,tz)
	--produce a plane equation
	local px,py,pz=cross(dx2,dy2,dz2, 0,1,0)
	local pd=dot(px,py,pz, x2,y2,z2)
	local d=dot(dx2,dy2,dz2, tx2,ty2,tz2)
	local ya=math.acos(d)*rtd
	local dst=px*x+py*y+pz*z-pd
	if dst>0 then ya=-ya end
	--rotate chest correctly
	setBoneInfo(b3, IG3D_ROTATION, 0,ya,0)
	
	tx,ty,tz=normalized(tx,ty,tz)
	d=dot(tx,ty,tz, tx2,ty2,tz2)
	local xa=math.acos(d)*rtd
	if y>y2 then xa=-xa end
	setBoneInfo(b2, IG3D_ROTATION, -90+xa,0,0)
	
	setObjectInfo(obj.cObj, IG3D_OMEGA, 0,ya*0.1,0)
end

