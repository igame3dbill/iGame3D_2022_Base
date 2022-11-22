-- Begin of auto-script
loadMesh("Data/Levels/Recognizer/Recognizer_level_mesh.wtf")
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, 17.583622, 2.053568, -24.200924)
setCameraInfo(IG3D_ROTATION, 24.600327, 3.333160, 0.000000)
gObjects={}
gObjectWTFs={"Vehicles_land/recognizerwbase.wtf"}
gObjectNames={"recognizerwbase1"}
gObjectPositions={{17.583683,1.353871,-23.200924}}
gObjectRotations={{-0.024228,-0.000004,-0.019782}}
gObjectSizes={{40.000001,40.000001,40.000001}}
gObjectColls={true}
gObjectHUDs={false}
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
gSoundEmitterNames={}
gSoundEmitterPositions={}
gSoundEmitterSamples={}
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
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, -0.500000,2.000000,-1.000000,-0.000000)
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

--setSceneInfo(IG3D_MOUSE_VIEW, true, 1)

player=gObjects[1].cObj --make(ig3d_object, "Vehicles_land/recognizerwbase.wtf") 
--setObjectInfo(player, IG3D_POSITION, 0,1,0)
--setObjectInfo(player, IG3D_ROTATION, 0,180,0)
--setObjectInfo(player, IG3D_SIZE, 40,40,40)
setObjectInfo(player, IG3D_VECTOR_CONSTRAINT, 0,1,0)
setObjectInfo(player, IG3D_GRAVITY_MULTIPLIER, 0.4)

speed=6
jump=0

b=get(ig3d_bone, player, "base")
--setBoneInfo(b, IG3D_ENABLED, false)
c=get(ig3d_bone, player, "None")
--setObjectInfo(player, IG3D_BONE_COLL, true)
setBoneInfo(c, IG3D_COLL, false)

--setSceneInfo(IG3D_RECEIVE_SHADOW, true)
-- setObjectInfo(player, IG3D_CAST_SHADOW, true)
setLightInfo(2, IG3D_POSITION, 20,20,20,0)


function airborne(obj)
	x1,x2,y1,y2,z1,z2=getObjectInfo(obj, IG3D_BOUNDS)
	x,y,z=getObjectInfo(obj, IG3D_POSITION)
	local ct,x3,y3,z3,o=lineCollision(x,y+y1-0.3,z, x,y,z)
	if ct==1 then return false else return true end
end


function the_game()

a11,a12,a13,a14, a21,a22,a23,a34, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(player, IG3D_ROTATION_MATRIX)

mx,my=getSceneInfo(IG3D_MOUSE_DELTA)

if focus_y==nil then
focus_y=0
else
focus_y=focus_y-my*0.01
end

dx=0
dy=0
dz=0

local ab=airborne(player)

if key("w","-") and not ab then
dx=dx+a31
dy=dy+a32
dz=dz+a33
end

if key("s","-") and not ab then
dx=dx-a31
dy=dy-a32
dz=dz-a33
end

if key("a","-") and not ab then
dx=dx+a11
dy=dy+a12
dz=dz+a13
end

if key("d","-") and not ab then
dx=dx-a11
dy=dy-a12
dz=dz-a13
end

ox,oy,oz=getObjectInfo(player, IG3D_VELOCITY)
if ab then
	ox=0
	oy=0
	oz=0
end

if key(" ","n")  and not ab and jump==0 then
jump=15
end

jump=jump-passed()*20

if jump< 0 or not key(" ","-") then jump=0 end


setObjectInfo(player, IG3D_FORCE, dx*speed-ox,dy*speed-oy+jump,dz*speed-oz)
setObjectInfo(player, IG3D_OMEGA, 0,-mx*0.3,0)
setSceneInfo(IG3D_MOUSE_VIEW, true, 1)

px,py,pz=getObjectInfo(player, IG3D_POSITION)
setCameraInfo(IG3D_POSITION, px-a31,1+py-a32,pz-a33)
setCameraInfo(IG3D_ROTATION, dirToAngles(a31,focus_y-1+a32,a33))

-- simply calling default_escapekey() over and over slows things down
char,code,name=input(false)
 --- SPACE KEY
 --- SHIFT KEY
	if char~= nil then
		if  name=="Escape" then
default_escapekey()
end
end

end

game_func=the_game