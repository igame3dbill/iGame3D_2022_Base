-- Begin of auto-script
loadMesh("Data/WTF/Locations/city2test2.wtf")
gSoundFiles={"Data/Sounds/engine.ogg","Data/Sounds/skid.ogg","Data/Sounds/planefly.ogg"}
for i=1,#gSoundFiles,1 do
	loadSound(gSoundFiles[i])
end
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, 2.231431, 7.457518, -14.087238)
setCameraInfo(IG3D_ROTATION, 31.666668, -15.324463, 0.000000)
gObjects={}
gObjectWTFs={"Vehicles_land/vehicle.wtf","Vehicles_land/ambulance.wtf","Vehicles_land/vehicle.wtf","Cubes/crate0001.wtf","Cubes/crate0001.wtf","Characters/greenalien.wtf","Characters/greenalien.wtf"}
gObjectNames={"vehicle1","vehicle2","vehicle3","crate00011","crate00012","greenalien1","greenalien2"}
gObjectPositions={{0.681761,0.480829,-14.743173},{6.125220,0.838004,-3.279200},{-4.295033,0.480815,-13.993366},{3.149746,0.499076,0.000365},{-7.949524,6.498968,-7.307128},{-0.000000,0.498480,-0.000000},{-4.061402,0.500001,-8.953198}}
gObjectRotations={{0.000228,-42.992073,0.000143},{-0.410216,-79.315399,0.332319},{0.000310,-0.000000,0.000009},{0.066939,-34.509480,-0.029790},{-0.064397,-18.916168,0.041845},{-0.000000,-0.000000,-0.000000},{-0.061084,-58.000519,0.033860}}
gObjectSizes={{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000}}
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
gParticleNamesAndEMTs={{"TireTraces","Data/Emitters/tiretrace.emt"}}
gParticlePositions={{0.000000,0.000000,0.000000}}
gParticleRotations={{0.000000,0.000000,0.000000}}
gParticleEmitters={}
for i=1,#gParticleNamesAndEMTs,1 do
	gParticleEmitters[i]=make(ig3d_particle_emitter, gParticleNamesAndEMTs[i][1], gParticleNamesAndEMTs[i][2])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_POSITION, gParticlePositions[i][1],gParticlePositions[i][2],gParticlePositions[i][3])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_ROTATION, gParticleRotations[i][1],gParticleRotations[i][2],gParticleRotations[i][3])
end
gNumParticleEmitters=#gParticleNamesAndEMTs
gSoundEmitterNames={"Engine","Skid"}
gSoundEmitterPositions={{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000}}
gSoundEmitterSamples={"Data/Sounds/engine.ogg","Data/Sounds/skid.ogg"}
gSoundEmitters={}
for i=1,#gSoundEmitterNames,1 do
	gSoundEmitters[i]=make(ig3d_sound_emitter, gSoundEmitterNames[i])
	setSound_emitterInfo(gSoundEmitters[i], IG3D_POSITION, gSoundEmitterPositions[i][1],gSoundEmitterPositions[i][2],gSoundEmitterPositions[i][3])
	setSound_emitterInfo(gSoundEmitters[i], IG3D_SAMPLE, gSoundEmitterSamples[i])
end
gNumSoundEmitters=#gSoundEmitterNames
gGroups={}
gNumGroups=0
setSceneInfo(IG3D_TINT_COLOR, 1.000000,1.000000,1.000000)
setSceneInfo(IG3D_FOG, false,0.500000,0.500000,0.500000,-0.000000,200.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.650000,0.650000,0.650000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setSceneInfo(IG3D_SKYBOX, "Skybox/newsky.wtf")
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, 50.000000,150.000000,50.000000,-0.000000)
setLightInfo(1, IG3D_AMBIENT, 0.400000,0.400000,0.400000,1.000000)
setLightInfo(1, IG3D_DIFFUSE, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(1, IG3D_SPECULAR, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(1, IG3D_CONSTANT_ATTENUATION, 1.000000)
setLightInfo(1, IG3D_LINEAR_ATTENUATION, -0.000000)
setLightInfo(1, IG3D_QUADRATIC_ATTENUATION, -0.000000)
setLightInfo(1, IG3D_SPOTLIGHT, -0.000000,-0.000000,-0.000000,180.000000,-0.000000)
setLightInfo(2, IG3D_ENABLED, false)
setLightInfo(3, IG3D_ENABLED, false)
setLightInfo(4, IG3D_ENABLED, false)
setLightInfo(5, IG3D_ENABLED, false)
setLightInfo(6, IG3D_ENABLED, false)
setLightInfo(7, IG3D_ENABLED, false)
setLightInfo(8, IG3D_ENABLED, false)
-- End of auto-script

--all objects have gravity
for i=1,#gObjects,1 do
	setObjectInfo(gObjects[i].cObj, IG3D_GRAVITY_MULTIPLIER, 1)
end


--setup vehicles
vehicles={ gObjects[2], gObjects[3] }
for i=1,#vehicles,1 do
	setObjectInfo(vehicles[i].cObj, IG3D_MASS, 20,1,1,1)
	setObjectInfo(vehicles[i].cObj, IG3D_VEHICLE, true)
end

--setup crates
crates={ gObjects[4], gObjects[5] }
for i=1,#crates,1 do
	---nothing special here yet
end

--setup aliens
aliens={gObjects[6], gObjects[7] }
for i=1,#aliens,1 do
	setObjectInfo(aliens[i].cObj, IG3D_BONE_COLL, true)
	setObjectInfo(aliens[i].cObj, IG3D_VECTOR_CONSTRAINT, 0,1,0)
	setObjectInfo(aliens[i].cObj, IG3D_ANIMATION, "Go", 0.1*(i-1), true)
	setObjectInfo(aliens[i].cObj, IG3D_LINK_MAIN_BONE_TO_VELOCITY, true)
	aliens[i].alive=true
end


car=gObjects[1]
setObjectInfo(car.cObj, IG3D_MASS, 20,1,1,1)
setObjectInfo(car.cObj, IG3D_VEHICLE, true)
setObjectInfo(car.cObj, IG3D_CAST_SHADOW, true, "Vehicles_land/vehicleshadow.wtf")
setSceneInfo(IG3D_RECEIVE_SHADOW, true)
setLightInfo(2, IG3D_POSITION, 50,150,50,0)

engine=gSoundEmitters[1]
setSound_emitterInfo(engine, IG3D_PITCH, 75)
setSound_emitterInfo(engine, IG3D_LOOP, true)
setSound_emitterInfo(engine, IG3D_START)

skid=gSoundEmitters[2]
setSound_emitterInfo(skid, IG3D_LOOP, true)
setSound_emitterInfo(skid, IG3D_VOLUME, 0)
setSound_emitterInfo(skid, IG3D_START)

tireTraces=gParticleEmitters[1]

longmag=1
latmag=0.1


gCameraBehind=5.0--5.0
gCameraUp=2.0--2.0

loadTexture("Data/Images/Vehicles/Cmro_texbrake.png")

function position_camera()
a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(car.cObj, IG3D_ROTATION_MATRIX)


x,y,z=getCameraInfo(IG3D_POSITION)
--get camera coordinates local to car
--tx=a11*x+a12*y+a13*z
--ty=a21*x+a22*y+a23*z
--tz=a31*x+a32*y+a33*z

--get vector from current cam position to desired cam position
x,y,z=getCameraInfo(IG3D_POSITION)
car.x,car.y,car.z=getObjectInfo(car.cObj, IG3D_POSITION)
dx=car.x-a31* gCameraBehind +a21*gCameraUp -x
dy=car.y-a32* gCameraBehind +a22*gCameraUp -y
dz=car.z-a33* gCameraBehind +a23*gCameraUp -z


local vx,vy,vz=getObjectInfo(car.cObj, IG3D_VELOCITY)
local vmag=vecLength(vx, vy, vz)
vx,vy,vz=normalized(vx,vy,vz)

--length of the current to desired position vector
local dmag=vecLength(dx,dy,dz)

--what part of the camera move direction is aligned with velocity?
local mag=dot(vx,vy,vz, dx,dy,dz)
local mag=dot(a31,a32,a33, dx,dy,dz)--lets try that

--calculate lateral component
local lx=dx-a31*mag
local ly=dy-a32*mag
local lz=dz-a33*mag



--rotate the camera
cx=car.x-x
cy=car.y-y
cz=car.z-z
b11,b12,b13,b14, b21,b22,b23,b24, b31,b32,b33,b34, b41,b42,b43,b44=getCameraInfo(IG3D_ROTATION_MATRIX)
setCameraInfo(IG3D_ROTATION, dirToAngles(0.333333*(a31+b31+cx), 0.333333*(a32+b32+cy), 0.333333*(a33+b33+cz)))




--longitudinal part
x=x+(dx-lx)*longmag
y=y+(dy-ly)*longmag
z=z+(dz-lz)*longmag

--lateral part
x=x +lx *latmag
y=y +ly *latmag
z=z +lz *latmag


--setCameraInfo(IG3D_ROTATION, getObjectInfo(car.cObj, IG3D_ROTATION) )

setCameraInfo(IG3D_POSITION, x,y,z)

end

function walk_away_from(obj1, obj2)
	if not obj1.alive then return end
	--obj1 should walk away from the obj2
	obj1.x,obj1.y,obj1.z=getObjectInfo(obj1.cObj, IG3D_POSITION)
	obj2.x,obj2.y,obj2.z=getObjectInfo(obj2.cObj, IG3D_POSITION)
	local dx,dy,dz=normalized(obj1.x-obj2.x,0,obj1.z-obj2.z)
	
	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj1.cObj, IG3D_ROTATION_MATRIX)
	d=dot(a31,a32,a33, dx,dy,dz)
	
	mult=1
	if dot(a11,a12,a13,dx,dy,dz)<dot(-a11,-a12,-a13,dx,dy,dz) then
		--turn... but in what direction?
		mult=-1
	end
	setObjectInfo(obj1.cObj, IG3D_OMEGA, 0,math.acos(d)*mult,0)
end

function getEnginePitchForCar()
	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(car.cObj, IG3D_ROTATION_MATRIX)
	local velx,vely,velz=getObjectInfo(car.cObj, IG3D_VELOCITY)
	local vel=dot(velx,vely,velz,a31,a32,a33)*2

	if vel>35 then
		vel=vel-20
	end
	if vel>35 then
		vel=vel-15
	end
	
	if vel>35 then
		vel=vel-10
	end

	local pitch=75+math.abs(vel)
	return pitch
end



function handle_car_sounds()
	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(car.cObj, IG3D_ROTATION_MATRIX)
	setSound_emitterInfo(engine, IG3D_POSITION, getObjectInfo(car.cObj, IG3D_POSITION))
	setSound_emitterInfo(engine, IG3D_PITCH, getEnginePitchForCar())
	setSound_emitterInfo(engine, IG3D_VOLUME, 100)
	local skidvalue
	local velx,vely,velz=getObjectInfo(car.cObj, IG3D_VELOCITY)
	if vecLength(velx,vely,velz)>4 then
		velx,vely,velz=normalized(velx,vely,velz)
		skidvalue=math.abs(dot(a11,a12,a13, velx,vely,velz))
		
		
		ox,oy,oz=getCameraInfo(IG3D_ROTATION)
	setCameraInfo(IG3D_ROTATION_MATRIX, a11,a12,a13, a31,a32,a33, -a21,-a22,-a23)
	setParticle_emitterInfo(tireTraces, IG3D_PARTICLE_PLANE, true, getCameraInfo(IG3D_ROTATION))
	setCameraInfo(IG3D_ROTATION, ox,oy,oz)
	px,py,pz=getBoneInfo(get(ig3d_bone, car.cObj, "RightRearWheel"),IG3D_POSITION)
	setParticle_emitterInfo(tireTraces, IG3D_POSITION, px,py-0.2,pz)
	setParticle_emitterInfo(tireTraces, IG3D_START)
	
	px,py,pz=getBoneInfo(get(ig3d_bone, car.cObj, "LeftRearWheel"),IG3D_POSITION)
	setParticle_emitterInfo(tireTraces, IG3D_POSITION, px,py-0.2,pz)
	setParticle_emitterInfo(tireTraces, IG3D_START)
	else
		skidvalue=math.abs(dot(a11,a12,a13, velx,vely,velz))/4
	end
	
	
	setSound_emitterInfo(skid, IG3D_VOLUME, 100*skidvalue)
	setSound_emitterInfo(skid, IG3D_PITCH, 130)
	setSound_emitterInfo(skid, IG3D_POSITION, getObjectInfo(car.cObj, IG3D_POSITION))
	
	
		--[[
		px,py,pz=getBoneInfo(get(ig3d_bone, car.cObj, "RightFrontWheel"),IG3D_POSITION)
		setParticle_emitterInfo(tireTraces, IG3D_POSITION, px,py,pz)
		setParticle_emitterInfo(tireTraces, IG3D_START)
		
		px,py,pz=getBoneInfo(get(ig3d_bone, car.cObj, "LeftFrontWheel"),IG3D_POSITION)
		setParticle_emitterInfo(tireTraces, IG3D_POSITION, px,py,pz)
		setParticle_emitterInfo(tireTraces, IG3D_START)
		--]]
		
	
	
end

function car_control()
	local fr=get(ig3d_bone, car.cObj, "RightFrontWheel")
	local fl=get(ig3d_bone, car.cObj, "LeftFrontWheel")
	local rr=get(ig3d_bone, car.cObj, "RightRearWheel")
	local rl=get(ig3d_bone, car.cObj, "LeftRearWheel")

	longmag=math.min(longmag+passed(), 1)
	latmag=math.min(latmag+passed()*0.1,0.1)

	--throttle
	if key("w","-") then
		setBoneInfo(fr, IG3D_TORQUE, 20)
		setBoneInfo(fl, IG3D_TORQUE, 20)
	else
		if key("s","-") then
			setBoneInfo(fr, IG3D_TORQUE, -15)
			setBoneInfo(fl, IG3D_TORQUE, -15)
		else
		
		setBoneInfo(fr, IG3D_TORQUE, 0)
		setBoneInfo(fl, IG3D_TORQUE, 0)
		end
	end
	
	--front braking
	m=get(ig3d_material, car.cObj, 6)
	if key(" ","-") then
		setBoneInfo(fr, IG3D_BRAKE,1)
		setBoneInfo(fl, IG3D_BRAKE,1)
		setMaterialInfo(m, IG3D_TEXTURE, 1, "Data/Images/Vehicles/Cmro_texbrake.png")
		setMaterialInfo(m, IG3D_EMISSION, 1,0,0,1)
	else
		setBoneInfo(fr, IG3D_BRAKE,0)
		setBoneInfo(fl, IG3D_BRAKE,0)
		setMaterialInfo(m, IG3D_TEXTURE, 1, "Data/Images/Vehicles/Cmro_tex.png")
		setMaterialInfo(m, IG3D_EMISSION, 0,0,0,1)
	end
	
	--hand brakes
	if click("-") then
		setBoneInfo(rr, IG3D_BRAKE, 1)
		setBoneInfo(rl, IG3D_BRAKE, 1)
	else
		setBoneInfo(rr, IG3D_BRAKE, 0)
		setBoneInfo(rl, IG3D_BRAKE, 0)
	end
	
	
	--steering
	steer=0
	if key("a","-") then
		steer=steer+1
	end
	
	if key("d","-") then
		steer=steer-1
	end
	setBoneInfo(fr, IG3D_STEERING_ANGLE, steer)
	setBoneInfo(fl, IG3D_STEERING_ANGLE, steer)
	
	
	--reset (lift car up a bit)
	if key("c","n") then
		loadLevel("Data/Levels/Car")
	end
	
	for i=1,#aliens,1 do
		walk_away_from(aliens[i], car)
	end
	
	
	
	handle_car_sounds()
	
	position_camera()
	fltk_update()
end

function objectAgainstObject(obj1, bone1, obj2, bone2, x,y,z)
	if obj1==car and obj2.alive then
		setObjectInfo(obj2.cObj, IG3D_RAGDOLL, true)
		obj2.alive=false
		longmag=0
		latmag=0
	end
	if obj2==car and obj1.alive then
		setObjectInfo(obj1.cObj, IG3D_RAGDOLL, true)
		obj1.alive=false
		longmag=0
		latmag=0
	end
end

function objectAgainstMesh(obj, bone, x,y,z)
	if obj==car and y>0.2 then
		longmag=0
		latmag=0
	end
end

coll_o_m=objectAgainstMesh
coll_o_o=objectAgainstObject
game_func=car_control
edit_func = default_escapekey