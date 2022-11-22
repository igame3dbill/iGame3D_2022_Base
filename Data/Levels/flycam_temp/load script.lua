-- Begin of auto-script
loadMesh("Data/WTF/flightpath.wtf")
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, 0.000000, 15.000000, 0.000000)
setCameraInfo(IG3D_ROTATION, 90.000000, -0.000000, -0.000000)
gObjects={}
gObjectWTFs={"Floors/strassenteppich.wtf","Reticule/crosshair.wtf","chessboard.wtf","Spheres/unitsphere.wtf","Spheres/unitsphere.wtf","Spheres/unitsphere.wtf","Spheres/unitsphere.wtf","Spheres/unitsphere.wtf","Spheres/unitsphere.wtf","Spheres/unitsphere.wtf","Spheres/unitsphere.wtf","Spheres/unitsphere.wtf","Spheres/unitsphere.wtf","Spheres/unitsphere.wtf","Spheres/unitsphere.wtf","Spheres/unitsphere.wtf"}
gObjectNames={"strassenteppich1","crosshair1","chessboard1","unitsphere1","unitsphere2","unitsphere3","unitsphere4","unitsphere5","unitsphere6","unitsphere7","unitsphere8","unitsphere9","unitsphere10","unitsphere11","unitsphere12","unitsphere13"}
gObjectPositions={{0.000000,0.000000,0.000000},{0.000000,0.000000,1000.000000},{0.000000,0.001000,0.000000},{6.657777,0.500001,5.461458},{3.068819,0.500001,7.906110},{-3.692987,0.500001,6.501735},{-7.646042,0.500001,3.797013},{-7.802083,0.500001,-2.236598},{-5.929583,0.500001,-5.461460},{-0.364097,0.500001,-6.397708},{6.969862,0.500001,-5.617499},{10.558821,0.500001,-2.028541},{8.010139,0.500001,2.028542},{-10.610833,0.500001,5.877568},{-5.721528,0.500001,10.298748},{-13.939720,0.500001,1.248331}}
gObjectRotations={{0.000000,0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000}}
gObjectSizes={{133.333325,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000}}
gObjectColls={true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false}
gObjectHUDs={false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false}
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
gTextboxFonts={"Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png"}
gTextboxPositions={{220,158},{289,109},{423,137},{501,191},{504,311},{467,375},{357,394},{211,378},{140,307},{183,226},{549,154},{452,69},{610,243}}
gTextboxSizes={32,32,32,32,32,32,32,32,32,32,32,32,32}
gTextboxColors={{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000}}
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
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.703000,0.050000,0.050000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, -0.500000,2.000000,-1.000000,0.000000)
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