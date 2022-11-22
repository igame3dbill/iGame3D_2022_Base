-- Begin of auto-script
loadMesh("Data/Levels/BrokenDoor/BrokenDoor_level_mesh.wtf")
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, 0.038588, 1.160832, 1.455605)
setCameraInfo(IG3D_ROTATION, 23.333332, 179.666672, 0.000000)
gObjects={}
gObjectWTFs={"Building_parts/hoteldoorbreak.wtf"}
gObjectNames={"hoteldoorbreak"}
gObjectPositions={{-0.000000,-0.000000,-0.000000}}
gObjectRotations={{-0.000000,-0.000000,-0.000000}}
gObjectSizes={{100.000000,100.000000,100.000000}}
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
gGroups={}
gNumGroups=0
setSceneInfo(IG3D_TINT_COLOR, 1.000000,1.000000,1.000000)
setSceneInfo(IG3D_FOG, false,0.500000,0.500000,0.500000,-0.000000,200.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.857000,0.050000,0.050000)
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

setObjectInfo(1, IG3D_CAST_SHADOW, true)
--setSceneInfo(IG3D_RECEIVE_SHADOW, true)
setLightInfo(2, IG3D_POSITION, 0,15,15,1)

for i=1,56,1 do
bn=get(ig3d_bone, 1, i)
setBoneInfo(bn, IG3D_RAGDOLL, false)
end
setObjectInfo(1, IG3D_RAGDOLL, true)
m=get(ig3d_material, 1,1)
--setMaterialInfo(m, IG3D_SMOOTH, false)--, "Data/Shaders/per_pixel_lighting/")
--setMaterialInfo(m, IG3D_SHADER, "Data/Shaders/per_pixel_lighting/")