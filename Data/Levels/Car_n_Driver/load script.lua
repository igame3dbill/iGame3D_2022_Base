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
setCameraInfo(IG3D_POSITION, 3.453596, 1.964323, 5.943768)
setCameraInfo(IG3D_ROTATION, 21.000021, -159.324463, 0.000000)
gObjects={}
gObjectWTFs={"Vehicles_land/vehicle.wtf","Vehicles_land/ambulance.wtf","Vehicles_land/vehicle.wtf","Cubes/crate0001.wtf","Characters/zombie.wtf","Characters/zombie.wtf","Characters/zombie.wtf","Characters/bvhjacky.wtf","Weapons/gloc.wtf","Reticule/crosshair.wtf"}
gObjectNames={"vehicle1","vehicle2","vehicle3","crate00011","crate00012","greenalien1","greenalien2","jacky1","gloc1","crosshair"}
gObjectPositions={{6.000000,6.000000,-0.000000},{6.125220,0.838004,-3.279200},{-4.295033,0.480815,-13.993366},{3.149746,0.499076,0.000365},{-7.949524,10.498968,-7.307128},{-0.000000,0.498480,-0.000000},{-4.061402,0.500001,-8.953198},{2.720850,-5000.558105,3.397441},{1.391726,0.690690,4.587914},{1.391726,0.690690,4.587914}}
gObjectRotations={{12.000000,23.000000,-0.000000},{-0.410216,-79.315399,0.332319},{0.000310,-0.000000,0.000009},{0.066939,-34.509480,-0.029790},{-0.064397,-18.916168,0.041845},{-0.000000,-0.000000,-0.000000},{-0.061084,-58.000519,0.033860},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000}}
gObjectSizes={{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{4000.000000,4000.000000,4000.000000}}
gObjectColls={true,true,true,true,true,true,true,true,false,false}
gObjectHUDs={false,false,false,false,false,false,false,false,false,false}
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
gParticleNamesAndEMTs={{"TireTraces","Data/Emitters/tiretrace.emt"},{"JackysGlock","Data/Emitters/pistol.emt"}}
gParticlePositions={{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000}}
gParticleRotations={{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000}}
gParticleEmitters={}
for i=1,#gParticleNamesAndEMTs,1 do
	gParticleEmitters[i]=make(ig3d_particle_emitter, gParticleNamesAndEMTs[i][1], gParticleNamesAndEMTs[i][2])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_POSITION, gParticlePositions[i][1],gParticlePositions[i][2],gParticlePositions[i][3])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_ROTATION, gParticleRotations[i][1],gParticleRotations[i][2],gParticleRotations[i][3])
end
gNumParticleEmitters=#gParticleNamesAndEMTs
gSoundEmitterNames={"Engine","Skid","Pistol"}
gSoundEmitterPositions={{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000}}
gSoundEmitterSamples={"Data/Sounds/engine.ogg","Data/Sounds/skid.ogg",""}
gSoundEmitters={}
for i=1,#gSoundEmitterNames,1 do
	gSoundEmitters[i]=make(ig3d_sound_emitter, gSoundEmitterNames[i])
	setSound_emitterInfo(gSoundEmitters[i], IG3D_POSITION, gSoundEmitterPositions[i][1],gSoundEmitterPositions[i][2],gSoundEmitterPositions[i][3])
	setSound_emitterInfo(gSoundEmitters[i], IG3D_SAMPLE, gSoundEmitterSamples[i])
end
gNumSoundEmitters=#gSoundEmitterNames
gGroups={}
gNumGroups=0
gTextboxFonts={"Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png"}
gTextboxPositions={{20,20},{20,20}}
gTextboxSizes={14,14}
gTextboxColors={{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000}}
gTextboxes={}
for i=1,#gTextboxFonts,1 do
	gTextboxes[i]=make(ig3d_text_box, gTextboxFonts[i])
	setText_boxInfo(gTextboxes[i], IG3D_POSITION, gTextboxPositions[i][1],gTextboxPositions[i][2])
	setText_boxInfo(gTextboxes[i], IG3D_SIZE, gTextboxSizes[i])
	setText_boxInfo(gTextboxes[i], IG3D_COLOR, gTextboxColors[i][1],gTextboxColors[i][2],gTextboxColors[i][3], gTextboxColors[i][4])
end
gNumTextboxes=#gTextboxFonts
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

--let's access some utility functions
local carRoot=gameroot.."Data/Scripts/Games/Car_n_Driver_Functions/"
dofile(carRoot.."character_utilities.lua")
dofile(carRoot.."gun_handling.lua")
dofile(carRoot.."car_handling.lua")
dofile(carRoot.."jacky_handling.lua")




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
crates={ gObjects[4] }
for i=1,#crates,1 do
	---nothing special here yet
end

--setup aliens
aliens={ gObjects[5], gObjects[6], gObjects[7] }
for i=1,#aliens,1 do
	setObjectInfo(aliens[i].cObj, IG3D_BONE_COLL, true)
	setObjectInfo(aliens[i].cObj, IG3D_VECTOR_CONSTRAINT, 0,1,0)
	setObjectInfo(aliens[i].cObj, IG3D_ANIMATION, "Run", 0, true)
	setObjectInfo(aliens[i].cObj, IG3D_LINK_MAIN_BONE_TO_VELOCITY, true)
	aliens[i].alive=true
end

--setup guns (carrier, gun)
guns={ {gObjects[8], gObjects[9]} }
for i=1,#guns,1 do
	guns[i][1].alive=true --gun carriers are alive!
	---nothing special here yet
end

--some globals
gPlayMode="car"
jacky=gObjects[8]
car=gObjects[1]
setObjectInfo(car.cObj, IG3D_IGNORE_COLL, true, ig3d_object, jacky.cObj)
gJackyActivateTime=-1
setObjectInfo(jacky.cObj, IG3D_VECTOR_CONSTRAINT, 0,1,0)
jacky.gun=gObjects[9]
jacky.gunsound=gSoundEmitters[3]
jacky.nextshot=0
jacky.shooting=false
jacky.gunparticles=gParticleEmitters[2]
setObjectInfo(jacky.cObj, IG3D_IGNORE_COLL, true, ig3d_particle_emitter, jacky.gunparticles)
setObjectInfo(jacky.gun.cObj, IG3D_GRAVITY_MULTIPLIER, 0)
crosshair=gObjects[10]
setObjectInfo(crosshair.cObj, IG3D_GRAVITY_MULTIPLIER, 0)
--setObjectInfo(crosshair.cObj, IG3D_BILLBOARD_X, true)
setObjectInfo(crosshair.cObj, IG3D_BILLBOARD_Y, true)
setObjectInfo(crosshair.cObj, IG3D_BILLBOARD_Z, true)

setObjectInfo(car.cObj, IG3D_MASS, 20,1,1,1)
setObjectInfo(car.cObj, IG3D_VEHICLE, true)
setObjectInfo(car.cObj, IG3D_CAST_SHADOW, true, "Vehicles_land/vehicleshadow.wtf")
setSceneInfo(IG3D_RECEIVE_SHADOW, true)
setLightInfo(2, IG3D_POSITION, 50,150,50,0)

engine=gSoundEmitters[1]
setSound_emitterInfo(engine, IG3D_PITCH, 75)
setSound_emitterInfo(engine, IG3D_LOOP, true)
setSound_emitterInfo(engine, IG3D_START)
setSound_emitterInfo(engine, IG3D_VOLUME, 15)

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

setSceneInfo(IG3D_REPEAT, true)


-- Create a new text box t with the default font 
-- This font is loaded at startup of iGame3D and uses "Data/FontPngs/default32_1.png" and "Data/FontPngs/default32_2.png"
t=make(ig3d_text_box, "Data/FontPngs/default32_1.png")

-- Make this text box read "Hello, World"
setText_boxInfo(t, IG3D_TEXT, "Car: Newton Vehicle Dynamics Demo\n W Accelerates\n S Reverses\n A & D Turn\n Space Brakes")

if gNativeOS == "iphone" then
	setText_boxInfo(t, IG3D_TEXT, "Car: Newton Vehicle Dynamics Demo\nin the iPhone simulator (mouse controlled)\n")
end

--Size It
setText_boxInfo(t, IG3D_SIZE, 14) 

-- Set the position of the text box to top-left corner of the window (with an offset of 50 pixels in the horizontal and vertical)
setText_boxInfo(t, IG3D_POSITION, 20,20)

function position_camera(obj)
a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)

x,y,z=getCameraInfo(IG3D_POSITION)
--get camera coordinates local to obj
--tx=a11*x+a12*y+a13*z
--ty=a21*x+a22*y+a23*z
--tz=a31*x+a32*y+a33*z

--get vector from current cam position to desired cam position
x,y,z=getCameraInfo(IG3D_POSITION)
obj.x,obj.y,obj.z=getObjectInfo(obj.cObj, IG3D_POSITION)
dx=obj.x-a31* gCameraBehind +a21*gCameraUp -x
dy=obj.y-a32* gCameraBehind +a22*gCameraUp -y
dz=obj.z-a33* gCameraBehind +a23*gCameraUp -z

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
cx=obj.x-x
cy=obj.y-y
cz=obj.z-z
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


--setCameraInfo(IG3D_ROTATION, getObjectInfo(obj.cObj, IG3D_ROTATION) )

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

function walk_towards(obj1, obj2)
	if not obj1.alive then return end
	--obj1 should walk to the obj2
	obj1.x,obj1.y,obj1.z=getObjectInfo(obj1.cObj, IG3D_POSITION)
	obj2.x,obj2.y,obj2.z=getObjectInfo(obj2.cObj, IG3D_POSITION)
	local dx,dy,dz=normalized(obj2.x-obj1.x,0,obj2.z-obj1.z)
	
	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj1.cObj, IG3D_ROTATION_MATRIX)
	d=dot(a31,a32,a33, dx,dy,dz)
	
	mult=1
	if dot(a11,a12,a13,dx,dy,dz)<dot(-a11,-a12,-a13,dx,dy,dz) then
		--turn... but in what direction?
		mult=-1
	end
	setObjectInfo(obj1.cObj, IG3D_OMEGA, 0,math.acos(d)*mult,0)
end



function car_and_jacky_game()
	setSceneInfo(IG3D_MOUSE_VIEW, true, 1)


	if gPlayMode=="car" then
		car_control()
		local vel=vecLength(getObjectInfo(car.cObj, IG3D_VELOCITY))
		if key("	","n") and vel<0.5 then
			setObjectInfo(car.cObj, IG3D_ANIMATION, "OpenDoor",0,false)
			a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(car.cObj, IG3D_ROTATION_MATRIX)
			setObjectInfo(jacky.cObj, IG3D_ROTATION_MATRIX, a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41+a11*0.4, a42+a12*0.4, a43+a13*0.4, a44)
			setObjectInfo(jacky.cObj, IG3D_VELOCITY, 0,0,0)
			setObjectInfo(jacky.cObj, IG3D_OMEGA, 0,0,0)
			setObjectInfo(jacky.cObj, IG3D_LINK_MAIN_BONE_TO_VELOCITY, false)
			setObjectInfo(jacky.cObj, IG3D_ANIMATION, "StepOutOfCar",0, false)
			gJackyActivateTime=time()+1.5
			gPlayMode="none"
		else
			setObjectInfo(jacky.cObj, IG3D_POSITION, getObjectInfo(car.cObj, IG3D_POSITION))
		end
	else
		
		if gPlayMode=="jacky" then
			jacky_control()
			if key("	","n") then
				setObjectInfo(jacky.cObj, IG3D_IGNORE_COLL, true, ig3d_object, car.cObj)
				setObjectInfo(crosshair.cObj, IG3D_POSITION, 0,-1000,0)
				gPlayMode="car"
			end
		end
		
		if time()>=gJackyActivateTime and gJackyActivateTime > 0 and gPlayMode=="none" then
			
			setObjectInfo(jacky.cObj, IG3D_POSITION, getBoneInfo(get(ig3d_bone, jacky.cObj, "None"), IG3D_POSITION))
			setObjectInfo(jacky.cObj, IG3D_ANIMATION, "STOP", 0, true)
			setObjectInfo(car.cObj, IG3D_ANIMATION, "STOP", 0, true)
			setObjectInfo(jacky.cObj, IG3D_ANIMATION, "Stand",0, false)
			setObjectInfo(jacky.cObj, IG3D_IGNORE_COLL, false, ig3d_object, car.cObj)
			a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(car.cObj, IG3D_ROTATION_MATRIX)
			setObjectInfo(jacky.cObj, IG3D_ROTATION, dirToAngles(a31,a32,a33))
			gGunFocusVerticalOffset=0
			gGunFocusHorizontalOffset=0
			gFocusX,gFocusY,gFocusZ=getBoneInfo(get(ig3d_bone, jacky.cObj, "RightArm"), IG3D_POSITION)
			gFocusX=gFocusX+a31
			gFocusY=gFocusY+a32
			gFocusZ=gFocusZ+a33
			gOldFocusX=gFocusX
			gOldFocusY=gFocusY
			gOldFocusZ=gFocusZ
			gJackyActivateTime=-1
			longmag=0
			latmag=0
			gPlayMode="jacky"
		end
		
		
	end
	
	--reset (lift car up a bit)
	if key("c","n") then
		setSound_emitterInfo(skid, IG3D_STOP)
		setSound_emitterInfo(engine, IG3D_STOP)
		loadLevel("Data/Levels/Car")
	end
	
	
	
	handle_guns() --defined in gun_handling.lua
	
	
	
	
	fltk_update()
end

function objectAgainstObject(obj1, bone1, obj2, bone2, x,y,z)
	if obj1==car and obj2.alive and gPlayMode=="car" then
		setObjectInfo(obj2.cObj, IG3D_RAGDOLL, true)
		obj2.alive=false
		--longmag=0
		--latmag=0
	end
	if obj2==car and obj1.alive and gPlayMode=="car" then
		setObjectInfo(obj1.cObj, IG3D_RAGDOLL, true)
		obj1.alive=false
		--longmag=0
		--latmag=0
	end
end

function objectAgainstParticles(obj, bone, emt, x,y,z)
	
	if emt=="JackysGlock" and obj.alive then
		setObjectInfo(obj.cObj, IG3D_RAGDOLL, true)
		obj.alive=false
	end
end



function objectAgainstMesh(obj, bone, x,y,z)
	if obj==car and y>0.2 then
		--longmag=0
		--latmag=0
	end
end

function particlesAgainstMesh(emt, x,y,z)
	--beep()
end

coll_o_m=objectAgainstMesh
coll_o_o=objectAgainstObject
coll_o_p=objectAgainstParticles
coll_p_m=particlesAgainstMesh

game_func= car_and_jacky_game
edit_func = default_escapekey