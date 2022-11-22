-- Begin of auto-script
loadMesh("Data/Levels/Colltests/mesh.wtf")
gTextureFiles={"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png","Data/Images/Effects/cloud.png","Data/Images/Logos/logo0.png"}
for i=1,#gTextureFiles,1 do
	loadTexture(gTextureFiles[i])
end
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, -7.488011, 11.233835, 3.243137)
setCameraInfo(IG3D_ROTATION, 49.487797, 125.060448, -0.000000)
gObjects={}
gObjectWTFs={"Spheres/kugel.wtf","Spheres/kugel.wtf","Spheres/kugel.wtf","Spheres/kugel.wtf"}
gObjectNames={"kugel1","kugel2","kugel3","kugel4"}
gObjectPositions={{0.000000,10.224803,0.000000},{-0.400000,6.074802,0.000000},{-1.000000,0.994468,0.000000},{1.550000,0.994468,0.000000}}
gObjectRotations={{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000}}
gObjectSizes={{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000}}
gObjectColls={true,true,true,true}
gObjectHUDs={false,false,false,false}
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

kugel1=gObjects[1]
kugel2=gObjects[2]
kugel3=gObjects[3]
kugel4=gObjects[4]
setObjectInfo(kugel1.cObj, IG3D_SHAPE, ig3d_sphere)
setObjectInfo(kugel2.cObj, IG3D_SHAPE, ig3d_sphere)
setObjectInfo(kugel3.cObj, IG3D_SHAPE, ig3d_sphere)
setObjectInfo(kugel4.cObj, IG3D_SHAPE, ig3d_sphere)
setObjectInfo(kugel1.cObj, IG3D_GRAVITY_MULTIPLIER, 1)
setObjectInfo(kugel2.cObj, IG3D_GRAVITY_MULTIPLIER, 1)
setObjectInfo(kugel3.cObj, IG3D_GRAVITY_MULTIPLIER, 1)
setObjectInfo(kugel4.cObj, IG3D_GRAVITY_MULTIPLIER, 1)
setSceneInfo(IG3D_RECEIVE_SHADOW, true)
setObjectInfo(kugel1.cObj, IG3D_CAST_SHADOW, true)
setObjectInfo(kugel2.cObj, IG3D_CAST_SHADOW, true)
setObjectInfo(kugel3.cObj, IG3D_CAST_SHADOW, true)
setObjectInfo(kugel4.cObj, IG3D_CAST_SHADOW, true)
setLightInfo(1, IG3D_POSITION, 3,10,3,1)
setLightInfo(2, IG3D_POSITION, 3,10,3,1)
function camresetter()
setCameraInfo(IG3D_POSITION, -7.488011, 11.233835, 3.243137)
setCameraInfo(IG3D_ROTATION, 49.487797, 125.060448, -0.000000)
fltk_update()
default_escapekey()
end
game_func=camresetter

if console==nil then dofile(gameroot.."Data/GUI/console/console.fl") end

function mycallback(objA, boneA, objB, boneB, x,y,z)
	local nameA, nameB	
	nameA=getObjectInfo(objA.cObj, IG3D_NAME)
	nameB=getObjectInfo(objB.cObj, IG3D_NAME)
	--print(nameA.." collided with "..nameB)
end
coll_o_o=mycallback