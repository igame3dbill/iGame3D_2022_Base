-- Begin of auto-script
loadMesh("Data/Levels/iPhoneCar/iPhoneCar_level_mesh.wtf")
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"},{"Data/FontPngs/iphonecarsprites32_1.png","Data/FontPngs/iphonecarsprites32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, 11.285857, 0.867694, -7.148548)
setCameraInfo(IG3D_ROTATION, 21.490395, -88.135071, 0.000000)
gObjects={}
gObjectWTFs={"Carpack/carpack_cop.wtf","Cubes/crate0001.wtf","Characters/zombie.wtf","Cubes/crate0001.wtf","Characters/zombie.wtf","Characters/zombie.wtf","Characters/tomdrinman4_3klow.wtf"}
gObjectNames={"car","crate00011","crate00012","crate00013","crate00014","crate00015","avatar"}
gObjectPositions={{6.277685,-1.105152,-6.985477},{-21.237837,-1.226768,0.842932},{-6.616117,-1.171149,0.261997},{-6.394490,-1.125281,-9.232073},{-16.135582,-0.994290,-8.438102},{-18.712811,-1.112813,-3.711362},{-32.339378,-1009.977966,-6.505240}}
gObjectRotations={{-1.625195,-88.150826,1.313617},{0.127276,-80.759109,-0.116162},{0.004074,13.027747,0.001144},{0.070170,-12.395103,-0.004925},{1.543988,-46.502586,-0.324554},{2.912975,-69.398651,-0.727716},{0.140568,-20.512299,0.011266}}
gObjectSizes={{69.999999,69.999999,69.999999},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000}}
gObjectColls={true,true,true,true,true,true,true}
gObjectHUDs={false,false,false,false,false,false,false}
for i=1,#gObjectWTFs,1 do
	gObjects[i]={}
gObjects[i].cObj=make(ig3d_object, gObjectWTFs[i])
	setObjectInfo(gObjects[i].cObj, IG3D_NAME, gObjectNames[i])
	setObjectInfo(gObjects[i].cObj, IG3D_POSITION, gObjectPositions[i][1],gObjectPositions[i][2],gObjectPositions[i][3])
	setObjectInfo(gObjects[i].cObj, IG3D_ROTATION, gObjectRotations[i][1],gObjectRotations[i][2],gObjectRotations[i][3])
	setObjectInfo(gObjects[i].cObj, IG3D_SIZE, gObjectSizes[i][1],gObjectSizes[i][2],gObjectSizes[i][3])
	setObjectInfo(gObjects[i].cObj, IG3D_COLL, gObjectColls[i])
	setObjectInfo(gObjects[i].cObj, IG3D_HUD, gObjectHUDs[i])
end
gNumObjects=#gObjectWTFs
gParticleNamesAndEMTs={{"Bullets","Data/Emitters/pistol.emt"}}
gParticlePositions={{10.355871,0.501349,-7.118267}}
gParticleRotations={{0.000000,0.000000,0.000000}}
gParticleEmitters={}
for i=1,#gParticleNamesAndEMTs,1 do
	gParticleEmitters[i]=make(ig3d_particle_emitter, gParticleNamesAndEMTs[i][1], gParticleNamesAndEMTs[i][2])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_POSITION, gParticlePositions[i][1],gParticlePositions[i][2],gParticlePositions[i][3])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_ROTATION, gParticleRotations[i][1],gParticleRotations[i][2],gParticleRotations[i][3])
end
gNumParticleEmitters=#gParticleNamesAndEMTs
gSoundEmitterNames={"zombie eat"}
gSoundEmitterPositions={{-0.096607,0.608349,-0.565226}}
gSoundEmitterSamples={""}
gSoundEmitters={}
for i=1,#gSoundEmitterNames,1 do
	gSoundEmitters[i]=make(ig3d_sound_emitter, gSoundEmitterNames[i])
	setSound_emitterInfo(gSoundEmitters[i], IG3D_POSITION, gSoundEmitterPositions[i][1],gSoundEmitterPositions[i][2],gSoundEmitterPositions[i][3])
	setSound_emitterInfo(gSoundEmitters[i], IG3D_SAMPLE, gSoundEmitterSamples[i])
end
gNumSoundEmitters=#gSoundEmitterNames
gGroups={}
gNumGroups=0
gTextboxFonts={"Data/FontPngs/default32_1.png","Data/FontPngs/iphonecarsprites32_1.png","Data/FontPngs/iphonecarsprites32_1.png","Data/FontPngs/iphonecarsprites32_1.png"}
gTextboxPositions={{18,14},{940,15},{940,592},{50,592}}
gTextboxSizes={12,40,40,40}
gTextboxColors={{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{0.000000,1.000000,0.000000,1.000000}}
gTextboxes={}
for i=1,#gTextboxFonts,1 do
	gTextboxes[i]=make(ig3d_text_box, gTextboxFonts[i])
	setText_boxInfo(gTextboxes[i], IG3D_POSITION, gTextboxPositions[i][1],gTextboxPositions[i][2])
	setText_boxInfo(gTextboxes[i], IG3D_SIZE, gTextboxSizes[i])
	setText_boxInfo(gTextboxes[i], IG3D_COLOR, gTextboxColors[i][1],gTextboxColors[i][2],gTextboxColors[i][3], gTextboxColors[i][4])
end
gNumTextboxes=#gTextboxFonts
setSceneInfo(IG3D_TINT_COLOR, 1.000000,1.000000,1.000000)
setSceneInfo(IG3D_FOG, false,0.500000,0.500000,0.500000,0.000000,200.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.650000,0.650000,0.650000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, 11.285544,0.867697,-7.148538,1.000000)
setLightInfo(1, IG3D_AMBIENT, 0.400000,0.400000,0.400000,1.000000)
setLightInfo(1, IG3D_DIFFUSE, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(1, IG3D_SPECULAR, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(1, IG3D_CONSTANT_ATTENUATION, 1.000000)
setLightInfo(1, IG3D_LINEAR_ATTENUATION, 0.000000)
setLightInfo(1, IG3D_QUADRATIC_ATTENUATION, 0.000000)
setLightInfo(1, IG3D_SPOTLIGHT, 0.000000,0.000000,0.000000,180.000000,0.000000)
setLightInfo(2, IG3D_ENABLED, false)
setLightInfo(3, IG3D_ENABLED, false)
setLightInfo(4, IG3D_ENABLED, false)
setLightInfo(5, IG3D_ENABLED, false)
setLightInfo(6, IG3D_ENABLED, false)
setLightInfo(7, IG3D_ENABLED, false)
setLightInfo(8, IG3D_ENABLED, false)
-- End of auto-script



ig3d_ReadAnimationsFromFileIntoCache_si(gameroot.."Data/WTF/Characters/truebonesmaster.wtf", 25179)

car=gObjects[1]

setObjectInfo(car.cObj, IG3D_MASS, 20,1,1,1)

setObjectInfo(car.cObj, IG3D_VEHICLE, true)

--setObjectInfo(car.cObj, IG3D_GRAVITY_MULTIPLIER, 0)


for i=2,#gObjects,1 do
	setObjectInfo(gObjects[i].cObj, IG3D_VECTOR_CONSTRAINT, 0,1,0)
	setObjectInfo(gObjects[i].cObj, IG3D_GRAVITY_MULTIPLIER, 1)
end

enemy={}
table.insert(enemy, gObjects[3])
table.insert(enemy, gObjects[5])
table.insert(enemy, gObjects[6])

for i=1,#enemy,1 do
	setObjectInfo(enemy[i].cObj, IG3D_ANIMATION, "Walk",0,true)
end

longmag=1
latmag=1
gTorqueMult=2.5
gBrakeMult= 4
camcontinue=0
avatar=gObjects[7]
statusBox=gTextboxes[1]
forwardArrow=gTextboxes[2]
backwardArrow=gTextboxes[3]
toggleButton=gTextboxes[4]
gCargameMode="car"--can be "avatar" as well
gDefaultTrackObj=car--car
gTrackObj=gDefaultTrackObj
gWalking=false
gShooting=false
gCamBehind=5
gCamUp=2
bullets= gParticleEmitters[1]
lastShot=0


setParticle_emitterInfo(bullets, IG3D_IGNORE_COLL, true, ig3d_object, avatar.cObj)
setObjectInfo(avatar.cObj, IG3D_ANIMATION, "Stand",0,false)


function animate_them()
	for i=1,#enemy,1 do
		if not enemy[i].dead then
			a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(enemy[i].cObj, IG3D_ROTATION_MATRIX)
			setObjectInfo(enemy[i].cObj, IG3D_VELOCITY, a31,a32,a33)
			setObjectInfo(enemy[i].cObj, IG3D_OMEGA, 0,0,0)
		end
	end
end


function position_camera(obj,behind,up)
if time()>camcontinue then
	gTrackObj=gDefaultTrackObj
	obj=gTrackObj
else
	x,y,z=getObjectInfo(car.cObj, IG3D_POSITION)
	obj.x,obj.y,obj.z=getObjectInfo(obj.cObj, IG3D_POSITION)
	setCameraInfo(IG3D_POSITION, x,obj.y+0.2,z)
	x,y,z=getCameraInfo(IG3D_POSITION)
	dx=obj.x-x
	dy=obj.y-y
	dz=obj.z-z
	setCameraInfo(IG3D_ROTATION, dirToAngles(dx,dy,dz))
	return
end

a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)

x,y,z=getCameraInfo(IG3D_POSITION)
--get camera coordinates local to obj
--tx=a11*x+a12*y+a13*z
--ty=a21*x+a22*y+a23*z
--tz=a31*x+a32*y+a33*z

--get vector from current cam position to desired cam position
x,y,z=getCameraInfo(IG3D_POSITION)
obj.x,obj.y,obj.z=getObjectInfo(obj.cObj, IG3D_POSITION)
dx=obj.x-a31* behind +a21*up -x
dy=obj.y-a32* behind +a22*up -y
dz=obj.z-a33* behind +a23*up -z

--setObjectInfo(1, IG3D_ROTATION, 0,0,0)
--setObjectInfo(1, IG3D_POSITION, gObjectPositions[1][1],gObjectPositions[1][2]+0.5,gObjectPositions[1][3])

local vx,vy,vz=getObjectInfo(obj.cObj, IG3D_VELOCITY)
local vmag=vecLength(vx, vy, vz)
vx,vy,vz=normalized(vx,vy,vz)

--length of the current to desired position vector
local dmag=vecLength(dx,dy,dz)

--what part of the camera move direction is aligned with velocity?
--local mag=dot(vx,vy,vz, dx,dy,dz)
local mag=dot(a31,a32,a33, dx,dy,dz)--lets try that

--calculate lateral component
local lx=dx-a31*mag
local ly=dy-a32*mag
local lz=dz-a33*mag

--rotate the camera
--cx=obj.x-x
--cy=obj.y-y
--cz=obj.z-z
--b11,b12,b13,b14, b21,b22,b23,b24, b31,b32,b33,b34, b41,b42,b43,b44=getCameraInfo(IG3D_ROTATION_MATRIX)
--setCameraInfo(IG3D_ROTATION, dirToAngles(0.333333*(a31+b31+cx), 0.333333*(a32+b32+cy), 0.333333*(a33+b33+cz)))


--longitudinal part
x=x+(dx-lx)*longmag--*passed()
y=y+(dy-ly)*longmag--*passed()
z=z+(dz-lz)*longmag--*passed()

--lateral part
x=x +lx *latmag*passed()
y=y +ly *latmag*passed()
z=z +lz *latmag*passed()


--setCameraInfo(IG3D_ROTATION, getObjectInfo(obj.cObj, IG3D_ROTATION) )

setCameraInfo(IG3D_POSITION, x,y,z)

cx=obj.x-x
cy=obj.y-y
cz=obj.z-z
setCameraInfo(IG3D_ROTATION, dirToAngles(cx,cy,cz))

end

--we want to drive forward, if we are still driving backwards brake, first return value is speed coeff, second is brake coeff
function computeForwardDrivingCoefficients(obj)
	local a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)
	local vx,vy,vz=getObjectInfo(obj.cObj, IG3D_VELOCITY)
	local vmag=vecLength(vx,vy,vz)
	
	if vmag<0.1 then
		--we are slow enough to just drive forward
		return 1,0
	end
	
	if vmag>=0.1 then
		--we are pretty quick
		if dot(vx,vy,vz,a31,a32,a33) > 0 then
			--we are already driving forward, go on with that
			return 1,0
		else
			--we are driving backwards, brake!
			return 0,1
		end
	end
end

--we want to drive forward, if we are still driving backwards brake, first return value is speed coeff, second is brake coeff
function computeBackwardDrivingCoefficients(obj)
	local a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)
	local vx,vy,vz=getObjectInfo(obj.cObj, IG3D_VELOCITY)
	local vmag=vecLength(vx,vy,vz)
	
	if vmag<0.1 then
		--we are slow enough to just drive forward
		return -1,0
	end
	
	if vmag>=0.1 then
		--we are pretty quick
		if dot(vx,vy,vz,a31,a32,a33) < 0 then
			--we are already driving forward, go on with that
			return -1,0
		else
			--we are driving backwards, brake!
			return 0,1
		end
	end
end

--passedTable={}

function benchmark()
	--we are drawing 100 models
	
	--table.insert(passedTable, passed())
	--a=0
	--for i=1,#passedTable,1 do
	--	a=a+passedTable[i]
	--end
	
	setText_boxInfo(statusBox, IG3D_TEXT, "Polys: "..ig3d_GetNumberOfPolys__i().."\nFPS: "..getSceneInfo(IG3D_FPS).."\nTouches: "..getSceneInfo(IG3D_NUM_TOUCHES))
	--print(ig3d_GetNumberOfPolys__i().." polys were drawn in "..passed().." seconds. Mean: "..a/#passedTable)
end

function forwardControlDown(s)
	if gNativeOS=="iphone" then
		for j=1,16,1 do
			if touch(s,j) then
				a,b,c,d,e,f=getSceneInfo(IG3D_TOUCH_LINE,j)
				g,h,i=getSceneInfo(IG3D_WINDOW_COORDS, d,e,f)
				boxLeft,boxTop,boxRight,boxBottom=getText_boxInfo(forwardArrow, IG3D_BOUNDS)
				if mouseInBox(boxLeft-30,boxTop-30, boxRight+30,boxBottom+30, g,h) then
					return true
				end
			end
		end
	end
	
	if gNativeOS~="iphone" then
		return key("w",s)
	end
	
	return false
end

function toggleDown(s)
	for j=1,16,1 do
		if touch(s,j) then
			a,b,c,d,e,f=getSceneInfo(IG3D_TOUCH_LINE,j)
			g,h,i=getSceneInfo(IG3D_WINDOW_COORDS, d,e,f)
			boxLeft,boxTop,boxRight,boxBottom=getText_boxInfo(toggleButton, IG3D_BOUNDS)
			if mouseInBox(boxLeft-30,boxTop-30, boxRight+30,boxBottom+30, g,h) then
				return true
			end
		end
	end
	return false
end

function backwardControlDown(s)
	if gNativeOS=="iphone" then
		for j=1,16,1 do
			if touch(s,j) then
				a,b,c,d,e,f=getSceneInfo(IG3D_TOUCH_LINE,j)
				g,h,i=getSceneInfo(IG3D_WINDOW_COORDS, d,e,f)
				boxLeft,boxTop,boxRight,boxBottom=getText_boxInfo(backwardArrow, IG3D_BOUNDS)
				if mouseInBox(boxLeft-30,boxTop-30, boxRight+30,boxBottom+30, g,h) then
					return true
				end
			end
		end
	end
	
	if gNativeOS~="iphone" then
		return key("s",s)
	end
	
	return false
end


function drive_car()

	--a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(car.cObj, IG3D_ROTATION_MATRIX)
	--setObjectInfo(car.cObj, IG3D_FORCE, -9.81*20*a21, -9.81*20*a22, -9.81*20*a23)

	local accel0,accel1,accel2=getSceneInfo(IG3D_ACCELEROMETER_VALUES)--quick test if this does anything
	
	gCamBehind=5
	gCamUp=2
	
	local fr=get(ig3d_bone, car.cObj, "RightFrontWheel")
	local fl=get(ig3d_bone, car.cObj, "LeftFrontWheel")
	local rr=get(ig3d_bone, car.cObj, "RightRearWheel")
	local rl=get(ig3d_bone, car.cObj, "LeftRearWheel")
	
	local vx,vy,vz=getObjectInfo(car.cObj, IG3D_VELOCITY)
	local speed=math.sqrt(vx*vx+vy*vy+vz*vz)
	local torqueVal=gTorqueMult * (1.0 - speed / 25.0)
	
	if gNativeOS~="iphone" then
		if key("a","-") then
			accel1=1
		end
		
		if key("d","-") then
			accel1=-1
		end
		
		if not key("a","-") and not key("d","-") then
			accel1=0
		end
	end
	
	accel1=math.min(1,math.max(-1,accel1*2));
	
	if math.abs(accel1) < 0.1 then
		accel1=0
	end
		
	setBoneInfo(fr, IG3D_STEERING_ANGLE, accel1)
	setBoneInfo(fl, IG3D_STEERING_ANGLE, accel1)
	
	local tq=0
	local br=0.2
	
	if forwardControlDown("-") then
		tq,br= computeForwardDrivingCoefficients(car)
		setText_boxInfo(forwardArrow, IG3D_COLOR, 1,0,0,1)
		setText_boxInfo(backwardArrow, IG3D_COLOR, 1,1,1,1)
	end
	
	if backwardControlDown("-") then
		tq,br= computeBackwardDrivingCoefficients(car)
		setText_boxInfo(backwardArrow, IG3D_COLOR, 1,0,0,1)
		setText_boxInfo(forwardArrow, IG3D_COLOR, 1,1,1,1)
		--gCamBehind=-5
	end
	
	
	setBoneInfo(fr, IG3D_TORQUE, tq*torqueVal)
	setBoneInfo(fl, IG3D_TORQUE, tq*torqueVal)
	setBoneInfo(fr, IG3D_BRAKE, br*gBrakeMult)
	setBoneInfo(fl, IG3D_BRAKE, br*gBrakeMult)
	setBoneInfo(rr, IG3D_TORQUE, 0)
	setBoneInfo(rr, IG3D_BRAKE, 0)
	setBoneInfo(rl, IG3D_TORQUE, 0)
	setBoneInfo(rl, IG3D_BRAKE, 0)
	
	if toggleDown("-") then
		setText_boxInfo(toggleButton, IG3D_COLOR, 1,0,0,1)
	else
		setText_boxInfo(toggleButton, IG3D_COLOR, 0,1,0,1)
	end
	
	if toggleDown("o") then
		setText_boxInfo(toggleButton, IG3D_COLOR, 0,1,0,1)
		a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(car.cObj, IG3D_ROTATION_MATRIX)
		setObjectInfo(avatar.cObj, IG3D_POSITION, a41+a11*1.5, a42+a12*1.5+0.25, a43+a13*1.5)
		setObjectInfo(avatar.cObj, IG3D_ROTATION, getObjectInfo(car.cObj, IG3D_ROTATION))
		setObjectInfo(avatar.cObj, IG3D_VELOCITY, 0,0,0)
		setObjectInfo(avatar.cObj, IG3D_ANIMATION, "Stand",0,false)
		gWalking=false
		gCargameMode="avatar"
		gDefaultTrackObj=avatar
		setBoneInfo(rr, IG3D_TORQUE, 0)
		setBoneInfo(rr, IG3D_BRAKE, 1)
		setBoneInfo(rl, IG3D_TORQUE, 0)
		setBoneInfo(rl, IG3D_BRAKE, 1)
		setBoneInfo(fr, IG3D_TORQUE, 0)
		setBoneInfo(fr, IG3D_BRAKE, 1)
		setBoneInfo(fl, IG3D_TORQUE, 0)
		setBoneInfo(fl, IG3D_BRAKE, 1)
	end
	
	setText_boxInfo(toggleButton, IG3D_TEXT, "d")
end

function touchOnAButton(i)
	local a,b,c,d,e,f=getSceneInfo(IG3D_TOUCH_LINE,i)
	wx,wy,wz=getSceneInfo(IG3D_WINDOW_COORDS, a,b,c)
	for j=1,gNumTextboxes,1 do
		boxLeft,boxTop,boxRight,boxBottom=getText_boxInfo(gTextboxes[j], IG3D_BOUNDS)
		if mouseInBox(boxLeft-30,boxTop-30, boxRight+30,boxBottom+30, wx,wy) then
			return true
		end
	end
	return false
end


function shoot()

	for j=1,16,1 do
		if touch("-",j) and not touchOnAButton(j) then
			if not gShooting then
				--setObjectInfo(avatar.cObj, IG3D_ANIMATION, "Shoot",0,false)
				--gShooting=true
			end
			--a,b,c,d,e,f=getSceneInfo(IG3D_TOUCH_LINE,j)
			--cc,x,y,z,o=lineCollision(a,b,c,d,e,f)
			a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(avatar.cObj, IG3D_ROTATION_MATRIX)
	
			if time()-lastShot > 0.2 then
				bn=get(ig3d_bone, avatar.cObj, "rHand")
				a,b,c=getBoneInfo(bn, IG3D_POSITION)
				setParticle_emitterInfo(bullets, IG3D_POSITION, a,b,c)
				setParticle_emitterInfo(bullets, IG3D_ROTATION, dirToAngles(a31,a32,a33))
				setParticle_emitterInfo(bullets, IG3D_START)
				lastShot=time()
				return
			end
		end
	
	end
end

function walk_avatar()
	
	gCamBehind=1.5
	gCamUp=1
	
	
	shoot()--maybe he is shooting
	
	
	if (forwardControlDown("o") and not backwardControlDown("-")) or (backwardControlDown("o") and not forwardControlDown("-")) then
		setObjectInfo(avatar.cObj, IG3D_ANIMATION, "Stand", 0, false)
		setObjectInfo(avatar.cObj, IG3D_FORCE, 0,0,0)
		gWalking=false
	end
	
	local omegamult=1
	
	if forwardControlDown("-") then
		if not gWalking then
			setObjectInfo(avatar.cObj, IG3D_ANIMATION, "Walk",0,true)
		end
		gWalking=true
		a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(avatar.cObj, IG3D_ROTATION_MATRIX)
		vx,vy,vz=getObjectInfo(avatar.cObj, IG3D_VELOCITY)
		vlength=math.sqrt(vx*vx+vy*vy+vz*vz)
		if vlength<1 then
			setObjectInfo(avatar.cObj, IG3D_FORCE, a31*20,a32*20,a33*20)
		else
			setObjectInfo(avatar.cObj, IG3D_FORCE, 0,0,0)
		end
		setText_boxInfo(forwardArrow, IG3D_COLOR, 1,0,0,1)
		setText_boxInfo(backwardArrow, IG3D_COLOR, 1,1,1,1)
	end
	
	if backwardControlDown("-") then
		if not gWalking then
			setObjectInfo(avatar.cObj, IG3D_ANIMATION, "Walk",0,true)
		end
		gWalking=true
		omegamult=-1
		a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(avatar.cObj, IG3D_ROTATION_MATRIX)
		vx,vy,vz=getObjectInfo(avatar.cObj, IG3D_VELOCITY)
		vlength=math.sqrt(vx*vx+vy*vy+vz*vz)
		if vlength<1 then
			setObjectInfo(avatar.cObj, IG3D_FORCE, -a31*20,-a32*20,-a33*20)
		else
			setObjectInfo(avatar.cObj, IG3D_FORCE, 0,0,0)
		end
		setText_boxInfo(backwardArrow, IG3D_COLOR, 1,0,0,1)
		setText_boxInfo(forwardArrow, IG3D_COLOR, 1,1,1,1)
		--gCamBehind=-1.5
	end
	
	if not forwardControlDown("-") and not backwardControlDown("-") then
		local vx,vy,vz=getObjectInfo(avatar.cObj, IG3D_VELOCITY)
		setObjectInfo(avatar.cObj, IG3D_VELOCITY, 0,vy,0)
	end
	
	--[[
	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getCameraInfo(IG3D_ROTATION_MATRIX)
	local omegamult=1
	local vx,vy,vz=getObjectInfo(avatar.cObj, IG3D_VELOCITY)
	if dot(vx,vy,vz,a31,a32,a33) > 0 or vecLength(vx,vy,vz)==0 then
		omegamult=1
	else
		omegamult=-1
	end
	--]]
	
	if gNativeOS~="iphone" then
		if key("a","-") then
			--a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(avatar.cObj, IG3D_ROTATION_MATRIX)
			setObjectInfo(avatar.cObj, IG3D_OMEGA, 0,1*omegamult,0)
		else
			if key("d","-") then
				--a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(avatar.cObj, IG3D_ROTATION_MATRIX)
				setObjectInfo(avatar.cObj, IG3D_OMEGA, 0,-1*omegamult,0)
			else
				--a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(avatar.cObj, IG3D_ROTATION_MATRIX)
				setObjectInfo(avatar.cObj, IG3D_OMEGA, 0,0,0)
			end
		end
	else
		local accel0,accel1,accel2=getSceneInfo(IG3D_ACCELEROMETER_VALUES)--quick test if this does anything
		setObjectInfo(avatar.cObj, IG3D_OMEGA, 0,accel1*omegamult*5,0)
	end
	
	
	local x1,y1,z1=getObjectInfo(car.cObj, IG3D_POSITION)
	local x2,y2,z2=getObjectInfo(avatar.cObj, IG3D_POSITION)
	local dst=vecLength(x1-x2,y1-y2,z1-z2)
	if dst>2 then
		setText_boxInfo(toggleButton, IG3D_COLOR, 0.5,0.5,0.5,1)
	else
	
		if toggleDown("-") then
			setText_boxInfo(toggleButton, IG3D_COLOR, 1,0,0,1)
		else
			setText_boxInfo(toggleButton, IG3D_COLOR, 0,1,0,1)
		end
	
		if toggleDown("o") then
			setText_boxInfo(toggleButton, IG3D_COLOR, 0,1,0,1)
			gCargameMode="car"
			gDefaultTrackObj=car
			setObjectInfo(avatar.cObj, IG3D_POSITION, -1000,-1000,-1000)
			setObjectInfo(avatar.cObj, IG3D_VELOCITY, 0,0,0)
			setObjectInfo(avatar.cObj, IG3D_FORCE, 0,0,0)
		end
	end
	
	setText_boxInfo(toggleButton, IG3D_TEXT, "c")
end




oldclick=0

function mainloop()

	a,b,c,d=ig3d_GetWindowBounds__4i()
	setText_boxInfo(forwardArrow, IG3D_TEXT, "a")
	setText_boxInfo(forwardArrow, IG3D_POSITION, c-50, 15)
	setText_boxInfo(forwardArrow, IG3D_COLOR, 1,1,1,1)
	setText_boxInfo(backwardArrow, IG3D_TEXT, "b")
	setText_boxInfo(backwardArrow, IG3D_POSITION, c-50, d-55)
	setText_boxInfo(backwardArrow, IG3D_COLOR, 1,1,1,1)
	setText_boxInfo(toggleButton, IG3D_POSITION, 50, d-55)
	setText_boxInfo(toggleButton, IG3D_COLOR, 1,1,1,1)
		
	
	benchmark()
	animate_them();
	

	
	
	x,y,z=getObjectInfo(gDefaultTrackObj.cObj, IG3D_POSITION)
	x2,y2,z2=getCameraInfo(IG3D_POSITION)
	setLightInfo(1, IG3D_POSITION, x2,y2,z2,1)
	--setLightInfo(1, IG3D_POSITION, 50,50,50,1)
	
	
	
	if gCargameMode=="car" then		
		drive_car()
	else
		walk_avatar()
	end
	
	position_camera(gTrackObj, gCamBehind, gCamUp);
	--[[
	if click("n") then
		if time()-oldclick < 0.2 then
			loadLevel("Data/Levels/iPhoneCar")
		end
		oldclick=time()
	end
	--]]
end

function hitthem(obj1, bone1, obj2, bone2, x,y,z)
	if obj1== car and obj2==avatar then return end
	if obj2== car and obj1==avatar then return end
	if getObjectInfo(obj1.cObj, IG3D_VEHICLE)== true then
		if not obj2.dead then
			setObjectInfo(obj2.cObj, IG3D_RAGDOLL, true)
			obj2.freezeTime=time()+3
			obj2.dead=true
			--gTrackObj=obj2
			--camcontinue=time()+3
		end
		
	end
	if getObjectInfo(obj2.cObj, IG3D_VEHICLE)== true then
		if not obj1.dead then
			setObjectInfo(obj1.cObj, IG3D_RAGDOLL, true)
			obj1.freezeTime=time()+3
			obj1.dead=true
			--gTrackObj=obj1
			--camcontinue=time()+3
		end
		
	end
end

function no_textures()
	i=1
	local m=get(ig3d_material, -1, i)
	while m do
		setMaterialInfo(m, IG3D_TEXTURE, 1, nil)
		i=i+1
		m=get(ig3d_material, -1, i)
	end
	
	for j=1,#gObjects,1 do
		i=1
		local m=get(ig3d_material, gObjects[j].cObj, i)
		while m do
			setMaterialInfo(m, IG3D_TEXTURE, 1, nil)
			i=i+1
			m=get(ig3d_material, gObjects[j].cObj, i)
		end
	end

end

function hitbybullet(obj, bone, psys, x,y,z)
	if psys=="Bullets" and not getObjectInfo(obj.cObj, IG3D_VEHICLE) then
		if not obj.health then obj.health=50 end--health wasnt set
		obj.health=obj.health-10
		if obj.health<0 then
			obj.dead=true
			setObjectInfo(obj.cObj, IG3D_RAGDOLL, true)
		end
	end
end

if gNativeOS=="iphone" then
	setSceneInfo(IG3D_LOD_DISTANCE, 0,25,25,25)
end

coll_o_p=hitbybullet
coll_o_o=hitthem--makes sense with zombies only
game_func= mainloop

--ig3d_ScaleAllTexturesDownToWidth_i(32)--very low res for iphone
--no_textures()