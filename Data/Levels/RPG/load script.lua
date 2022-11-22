-- Begin of auto-script
loadMesh("Data/WTF/Foliage/grass2.wtf")
gTextureFiles={"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png","Data/Images/BrickRoomLarge_wtf.png","Data/Images/Effects/cloud.png","Data/Images/Characters/seuche.png","Data/Images/Characters/Squiggy.png","Data/Images/Characters/Schwertkaempfer.png","Data/Images/Characters/bobetteT40.png","Data/Images/Characters/bobetteT41.png","Data/Images/Characters/bobetteT47.png"}
for i=1,#gTextureFiles,1 do
	loadTexture(gTextureFiles[i])
end
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, 1.343978, 4.690016, 2.295835)
setCameraInfo(IG3D_ROTATION, 33.811417, -179.289902, -0.000000)
gObjects={}
gObjectWTFs={"Characters/Squiggy.wtf","Characters/schwertkaempfer.wtf","Characters/schwertkaempfer.wtf","Characters/schwertkaempfer.wtf","Characters/schwertkaempfer.wtf","Characters/bobette.wtf","Characters/bobette.wtf","Characters/bobette.wtf","Characters/bobette.wtf","Characters/bobette.wtf","Characters/bobette.wtf"}
gObjectNames={"Squig","schwertkaempfer1","schwertkaempfer2","schwertkaempfer3","schwertkaempfer4","ball6","ball7","ball8","ball9","ball10","ball11"}
gObjectPositions={{-0.320065,-1.178906,-4.212040},{-5.472311,-0.676825,-5.425461},{-3.673818,-1.436596,-2.524663},{3.580408,-1.704609,-4.033528},{2.065148,-1.292871,-1.711678},{7.064650,-0.957048,-4.020529},{5.420887,-0.831413,-8.233725},{7.795571,-0.754075,-7.551083},{6.061349,2.565327,-10.772850},{8.142060,0.220956,-9.031288},{9.717152,0.274459,-9.647816}}
gObjectRotations={{-0.583096,-0.192003,-0.544215},{-179.702942,88.572617,-179.746658},{-179.921875,69.048553,-179.925476},{-0.213829,-88.031586,0.177430},{-179.973358,-47.125240,179.988373},{-0.026973,-72.206871,0.036985},{-0.039894,-65.325676,0.025575},{-0.019817,-65.122337,0.012654},{-0.000000,-41.724873,0.000000},{-0.023093,-58.011597,0.012804},{-0.000000,-59.585957,0.000000}}
gObjectSizes={{200.000000,150.000000,200.000000},{100.000000,200.000000,100.000000},{100.000000,120.000005,100.000000},{100.000000,89.999998,100.000000},{100.000000,89.999998,100.000000},{250.000000,250.000000,250.000000},{250.000000,250.000000,250.000000},{250.000000,250.000000,250.000000},{250.000000,250.000000,250.000000},{250.000000,250.000000,250.000000},{250.000000,250.000000,250.000000}}
gObjectColls={true,true,true,true,true,true,true,true,true,true,true}
gObjectHUDs={false,false,false,false,false,false,false,false,false,false,false}
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
gTextboxFonts={"Data/FontPngs/default32_1.png"}
gTextboxPositions={{25,8}}
gTextboxSizes={12}
gTextboxColors={{1.000000,-0.000000,-0.000000,1.000000}}
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
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.600000,0.600000,1.000000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, 4.000000,4.000000,4.000000,1.000000)
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




--- RPG_OBJECT GRAVITY 
for i=1,gNumObjects,1 do
setObjectInfo(gObjects[i].cObj, IG3D_GRAVITY_MULTIPLIER, 1.0)
--setObjectInfo(gObjects[i].cObj, IG3D_VECTOR_CONSTRAINT, 0,1,0)
end



consolebox=gTextboxes[1]
setText_boxInfo(consolebox, IG3D_POSITION, 20,20)
setText_boxInfo(consolebox, IG3D_COLOR, 1,0,0,1)
setText_boxInfo(consolebox, IG3D_SIZE, 12)
SquigText="Keys move Squig =W A S D & R"
setText_boxInfo(consolebox, IG3D_TEXT, SquigText)


Squig=gObjects[1].cObj
pawn=gObjects[2].cObj
setObjectInfo(Squig, IG3D_CAST_SHADOW, true)
setSceneInfo(IG3D_RECEIVE_SHADOW, true)
setLightInfo(2, IG3D_POSITION, 4,4,4,1)
setLightInfo(1, IG3D_POSITION, 4,4,4,1)

tObjN=2
--dofile(gameroot.."Data/Levels/default/default_Globals.lua")
function RPG_loop()
default_escapekey()

WASD_pushObject(Squig)
faceObj("camera",Squig)
tObjN = tObjN +1
if tObjN >11 then tObjN=2 end

 for i=2,11,1 do
 	facer=gObjects[i].cObj
	faceObj(facer,Squig)
	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(facer, IG3D_ROTATION_MATRIX)
	a21=0
	a22=1
	a23=0
	a31,a32,a33=normalized(a31,a32,a33)
	a11,a12,a13=normalized(a11,a12,a13)
	setObjectInfo(facer, IG3D_ROTATION_MATRIX, a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44)
	if i==tObjN then setObjectInfo(facer, IG3D_FORCE, a31*2,a32*2+1,a33*2) end
 end
 end
game_func=RPG_loop