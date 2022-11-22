-- Begin of auto-script
loadMesh("Data/Levels/BobetteSoccer/mesh.wtf")
--[[gTextureFiles={"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"}
for i=1,#gTextureFiles,1 do
	loadTexture(gTextureFiles[i])
end
gSoundFiles={"Data/Sounds/planehit.ogg","Data/Sounds/planefly.ogg","Data/Sounds/exp.ogg","Data/Sounds/turret.ogg"}
for i=1,#gSoundFiles,1 do
	loadSound(gSoundFiles[i])
end
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"},{"Data/FontPngs/crosshairs32_1.png","Data/FontPngs/crosshairs32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end]]--
setCameraInfo(IG3D_POSITION, -7.488011, 11.233835, 3.243137)
setCameraInfo(IG3D_ROTATION, 49.487797, 125.060448, 0.000000)
gObjects={}
gObjectWTFs={"Spheres/kugel.wtf","Spheres/kugel.wtf","Spheres/kugel.wtf","Spheres/kugel.wtf","Characters/bobette.wtf"}
gObjectNames={"kugel1","kugel2","kugel3","kugel4","bobette1"}
gObjectPositions={{7.096495,0.994182,0.067170},{-2.366530,0.994211,2.761407},{-5.025806,0.992500,0.552016},{-2.396347,0.991479,0.759971},{-2.876378,2.217536,-4.749677}}
gObjectRotations={{0.596827,-2.338482,-48.516891},{177.279465,-40.771534,-174.148712},{-30.754990,18.289536,-134.716705},{-40.305977,-28.223953,-113.813736},{0.017033,-17.120832,-0.006126}}
gObjectSizes={{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{400.000000,400.000000,400.000000}}
gObjectColls={true,true,true,true,true}
gObjectHUDs={false,false,false,false,false}
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
setSceneInfo(IG3D_FOG, false,0.500000,0.500000,0.500000,0.000000,200.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.650000,0.650000,0.650000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, 3.000000,10.000000,3.000000,1.000000)
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

dofile(gameroot.."Data/Scripts/iFly_Functions/iFly_math.lua")

kugel1=gObjects[1]
kugel2=gObjects[2]
kugel3=gObjects[3]
kugel4=gObjects[4]
woman=gObjects[5]
setObjectInfo(kugel1.cObj, IG3D_SHAPE, ig3d_sphere)
setObjectInfo(kugel2.cObj, IG3D_SHAPE, ig3d_sphere)
setObjectInfo(kugel3.cObj, IG3D_SHAPE, ig3d_sphere)
setObjectInfo(kugel4.cObj, IG3D_SHAPE, ig3d_sphere)
setObjectInfo(kugel1.cObj, IG3D_GRAVITY_MULTIPLIER, 1)
setObjectInfo(kugel2.cObj, IG3D_GRAVITY_MULTIPLIER, 1)
setObjectInfo(kugel3.cObj, IG3D_GRAVITY_MULTIPLIER, 1)
setObjectInfo(kugel4.cObj, IG3D_GRAVITY_MULTIPLIER, 1)
setObjectInfo(woman.cObj, IG3D_GRAVITY_MULTIPLIER, 1)
setSceneInfo(IG3D_RECEIVE_SHADOW, true)
setObjectInfo(kugel1.cObj, IG3D_CAST_SHADOW, true)
setObjectInfo(kugel2.cObj, IG3D_CAST_SHADOW, true)
setObjectInfo(kugel3.cObj, IG3D_CAST_SHADOW, true)
setObjectInfo(kugel4.cObj, IG3D_CAST_SHADOW, true)
setLightInfo(1, IG3D_POSITION, 3,10,3,1)
setLightInfo(2, IG3D_POSITION, 3,10,3,1)


schlagDistanz=5
cosAlpha=0.707


function whatCanSheSee()
	for i=1,gNumObjects,1 do
		if gObjects[i]~=woman then
			disjunct, ax,ay,az, bx,by,bz, nx,ny,nz=getObjectInfo (woman.cObj, IG3D_CLOSEST_POINTS, gObjects[i].cObj)
			if disjunct==1 then
				local dist=vecLength(ax-bx,ay-by,az-bz)
				r=0
				g=1
				b=0
				a=1
				m11,m12,m13,m14, m21,m22,m23,m24, m31,m32,m33,m34, m41,m42,m43,m44=getObjectInfo(woman.cObj, IG3D_ROTATION_MATRIX)
				
				if dot(nx,ny,nz, m31,m32,m33)>=cosAlpha then
					r=0
					g=0
					b=1
				end
				
				if dist<=schlagDistanz then
					r=1
					g=1
					b=0
				end
				
				if dot(nx,ny,nz, m31,m32,m33)>=cosAlpha and dist<=schlagDistanz then
					r=1
					g=0
					b=0
				end
				
				
				m=get(ig3d_material, gObjects[i].cObj, 1)
				setMaterialInfo(m, IG3D_COLOR, r,g,b,a)
				setMaterialInfo(m, IG3D_TEXTURE, 1, "")
			end
		end
	end
end

function camresetter()
--setCameraInfo(IG3D_POSITION, -7.488011, 11.233835, 3.243137)
--setCameraInfo(IG3D_ROTATION, 49.487797, 125.060448, -0.000000)
whatCanSheSee()
--fltk_update()
default_escapekey()
WASD_pushObject(woman.cObj)
faceObj("camera",woman.cObj)
end




game_func=camresetter
edit_func= default_escapekey


function mycallback(objA, boneA, objB, boneB, x,y,z)
	local nameA, nameB	
	nameA=getObjectInfo(objA.cObj, IG3D_NAME)
	nameB=getObjectInfo(objB.cObj, IG3D_NAME)
	--print(nameA.." collided with "..nameB)
end
coll_o_o=mycallback