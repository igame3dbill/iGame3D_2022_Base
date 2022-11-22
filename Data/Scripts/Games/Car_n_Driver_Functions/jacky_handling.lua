gGunFocusVerticalOffset=0
gGunFocusHorizontalOffset=0
gOldFocusX=0
gOldFocusY=0
gOldFocusZ=0
gFocusX=0
gFocusY=0
gFocusZ=0
gSavedChestRotationX=0
gSavedChestRotationY=0
gSavedChestRotationZ=0

function jacky_control()
	

	gCameraBehind=1--5.0
	gCameraUp=1--2.0
	
	longmag=math.min(longmag+passed(), 0.3)
	latmag=math.min(latmag+passed()*0.05,0.1)

	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(jacky.cObj, IG3D_ROTATION_MATRIX)
	setObjectInfo(jacky.cObj, IG3D_LINK_MAIN_BONE_TO_VELOCITY, true)
	
	if key("w","n") then
		setObjectInfo(jacky.cObj, IG3D_ANIMATION, "Run", 0, true)
	end
	
	if key("w","o") then
		setObjectInfo(jacky.cObj, IG3D_ANIMATION, "Stand",0,false)
		--setObjectInfo(jacky.cObj, IG3D_ANIMATION, "LookAround", 0, false)
	end
	
	if key("s","n") then
		setObjectInfo(jacky.cObj, IG3D_ANIMATION, "Dance", 0, true)
	end
	
	if key("s","o") then
		--setObjectInfo(jacky.cObj, IG3D_ANIMATION, "LookAround", 0, false)
		setObjectInfo(jacky.cObj, IG3D_ANIMATION, "Stand",0,false)
	end
	
	local omega=0
	local lookup
	
	if time()>=jacky.nextshot then
		jacky.shooting=false
		if click("-") then
			setSound_emitterInfo(jacky.gunsound, IG3D_POSITION, a41,a42,a43)
			setSound_emitterInfo(jacky.gunsound, IG3D_START)
			setObjectInfo(jacky.cObj, IG3D_ANIMATION, "PistolShot", 0, false)
			jacky.shooting=true
			jacky.nextshot=time()+0.3
			setParticle_emitterInfo(jacky.gunparticles, IG3D_POSITION, getObjectInfo(jacky.gun.cObj, IG3D_POSITION))
			local px,py,pz=getObjectInfo(crosshair.cObj, IG3D_POSITION)
			local qx,qy,qz=getBoneInfo(get(ig3d_bone, jacky.gun.cObj, "Exit"), IG3D_POSITION)
			setParticle_emitterInfo(jacky.gunparticles, IG3D_ROTATION, dirToAngles(px-qx,py-qy,pz-qz))
			setParticle_emitterInfo(jacky.gunparticles, IG3D_START)
		end
	end
	
	omega,lookup=getSceneInfo(IG3D_MOUSE_DELTA)
	omega=omega*0.05
	lookup=-lookup*0.05
	
	
	--gGunFocusVerticalOffset=math.min(math.max(-10, gGunFocusVerticalOffset+lookup),10)
	gGunFocusVerticalOffset= gGunFocusVerticalOffset+lookup
	
	
	
	setBoneInfo(get(ig3d_bone, jacky.cObj, "Chest"), IG3D_ROTATION, gSavedChestRotationX, gSavedChestRotationY, gSavedChestRotationZ)--yesssss

	local b1=get(ig3d_bone, jacky.cObj, "RightArm")
	local b2=get(ig3d_bone, jacky.cObj, "LowerRightArm")
	setBoneInfo(b1, IG3D_ROTATION, -90,0,0)
	local px,py,pz=getBoneInfo(b1, IG3D_POSITION)
	local qx,qy,qz=getBoneInfo(b2, IG3D_POSITION)
	local dx=qx-px
	local dy=qy-py
	local dz=qz-pz
	dx,dy,dz=normalized(dx, dy, dz)
	local rx,ry,rz=cross(dx,dy,dz, 0,1,0)
	
	if omega~=0  or lookup ~= 0 then
		if gFocusX==0 and gFocusY==0 and gFocusZ==0 then
			gFocusX=px+a31*10
			gFocusY=py+a32*10 + gGunFocusVerticalOffset
			gFocusZ=pz+a33*10
		else
			gFocusX=px+dx*10 + rx*omega
			gFocusY=py+dy*10 + ry*omega + gGunFocusVerticalOffset
			gFocusZ=pz+dz*10 + rz*omega
		end
	
	else
		gFocusX=gOldFocusX
		gFocusY=gOldFocusY
		gFocusZ=gOldFocusZ
	end
	
	onehandgunfocus(jacky,gFocusX,gFocusY,gFocusZ)
	
	gSavedChestRotationX, gSavedChestRotationY, gSavedChestRotationZ=getBoneInfo(get(ig3d_bone, jacky.cObj, "Chest"), IG3D_ROTATION)
	
	
	gOldFocusX=gFocusX
	gOldFocusY=gFocusY
	gOldFocusZ=gFocusZ
	
	
	dx=gFocusX-px
	dy=gFocusY-py
	dz=gFocusZ-pz
	
	dx,dy,dz=normalized(dx,dy,dz)
		
	
	
	
	setObjectInfo(jacky.cObj, IG3D_HUD, true)
	
	qx,qy,qz=getBoneInfo(get(ig3d_bone, jacky.gun.cObj, "Exit"), IG3D_POSITION)
	
	local c,x,y,z,o=lineCollision(qx,qy,qz, px+dx*50, py+dy*50, pz+dz*50)
	setObjectInfo(jacky.cObj, IG3D_HUD, false)
	
	setObjectInfo(crosshair.cObj, IG3D_POSITION, px+dx*10, py+dy*10, pz+dz*10)
	if c > 0 then
		setObjectInfo(crosshair.cObj, IG3D_POSITION, x-dx*0.01,y-dy*0.01,z-dz*0.01)
	end
	
	for i=1,#aliens,1 do
		walk_towards(aliens[i], jacky)
	end
	
	
	setSound_emitterInfo(engine, IG3D_VOLUME, 0)
	
	
	
	
	position_camera(jacky)
end