-- Begin of auto-script
--loadMesh("Data/Levels/Studio/Studio_level_mesh.wtf")
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, 0.000000, 6.799996, -9.045894)
setCameraInfo(IG3D_ROTATION, 30.000000, -0.000000, -0.000000)
gObjects={}
gObjectWTFs={"Characters/tomdrinman2_3k.wtf"}
gObjectNames={"test1"}
gObjectPositions={{0.000000,3.000001,0.000000}}
gObjectRotations={{0.000000,-0.000000,0.000000}}
gObjectSizes={{100.000000,100.000000,100.000000}}
gObjectColls={false}
gObjectHUDs={false}
for i=1,#gObjectWTFs,1 do
	gObjects[i]={}
gObjects[i].cObj=make(ig3d_object, gObjectWTFs[i])
	setObjectInfo(gObjects[i].cObj, IG3D_NAME, gObjectNames[i])
	sx,bx,sy,by,sz,bz=getObjectInfo(gObjects[i].cObj, IG3D_BOUNDS)
	siz=700.0/(by-sy)
	setObjectInfo(gObjects[i].cObj, IG3D_SIZE, siz,siz,siz)
	setObjectInfo(gObjects[i].cObj, IG3D_POSITION, 0,-sy*(siz*0.01),0)
	--setObjectInfo(gObjects[i].cObj, IG3D_POSITION, gObjectPositions[i][1],gObjectPositions[i][2],gObjectPositions[i][3])
	setObjectInfo(gObjects[i].cObj, IG3D_ROTATION, gObjectRotations[i][1],gObjectRotations[i][2],gObjectRotations[i][3])
	--setObjectInfo(gObjects[i].cObj, IG3D_SIZE, siz,siz,siz)
	setObjectInfo(gObjects[i].cObj, IG3D_COLL, gObjectColls[i])
	setObjectInfo(gObjects[i].cObj, IG3D_HUD, gObjectHUDs[i])
end
gNumObjects=#gObjectWTFs
gGroups={}
gNumGroups=0
setSceneInfo(IG3D_TINT_COLOR, 1.000000,1.000000,1.000000)
setSceneInfo(IG3D_FOG, false,0.500000,0.500000,0.500000,0.000000,200.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 1,1,1)
setSceneInfo(IG3D_FOV, true, 45.000000)
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


--ig3d_SetWindowBounds_4i(0,0,1600,1200)

function setupMaterialsForTexturePass()
i=1
m=get(ig3d_material, 1,i)
while m do
	setMaterialInfo(m, IG3D_LUX, true)
	setMaterialInfo(m, IG3D_TEXTURE, 2, nil)
	setMaterialInfo(m, IG3D_SHADER, nil)
	i=i+1
	m=get(ig3d_material, 1,i)
end

end

function setupMaterialsForGeometryPass()
i=1
m=get(ig3d_material, 1,i)
while m do
	setMaterialInfo(m, IG3D_LUX, true)
	--setMaterialInfo(m, IG3D_COLOR, 0.7,0.7,0.7)
	setMaterialInfo(m, IG3D_COLOR, 1,0,0,1)
	setMaterialInfo(m, IG3D_TEXTURE, 1, nil)
	setMaterialInfo(m, IG3D_SHADER, nil)
	i=i+1
	m=get(ig3d_material, 1,i)
end

end

cnt=0
numfotos=13
degr=-(1/numfotos*2)*3.1415
--degr=0.25*3.1415
theHeight=9


function create_geometry_images()

	local randomjitter=-2+math.random()*4
	local randomjitter2=-2+math.random()*4
	
	
	setCameraInfo(IG3D_POSITION, 14*math.sin(degr), theHeight, 14*math.cos(degr))
	x,y,z=getCameraInfo(IG3D_POSITION)
	--x=x+randomjitter
	--z=z+randomjitter2
		
	setCameraInfo(IG3D_ROTATION, dirToAngles(0-x,2.5-y,0-z))
	
	
	--if click("n") then
	degr=degr+(1/numfotos*2)*3.1415
	
	if cnt~=0 then
	ig3d_SaveScreenshot_s2bi(gameroot.."Data/Levels/Utility/Studio/geometry_images/pic"..degr..".png", false, false, 0)
	end
	
	cnt=cnt+1
	--end
	
	--if cnt % 8 == 0 then theHeight=80 end
	
	if cnt==numfotos+1 then
		game_func=fltk_update
	end
end

function create_texture_images()

	local randomjitter=-2+math.random()*4
	local randomjitter2=-2+math.random()*4
	
	setCameraInfo(IG3D_POSITION, 14*math.sin(degr), theHeight, 14*math.cos(degr))
	x,y,z=getCameraInfo(IG3D_POSITION)
	--x=x+randomjitter
	--z=z+randomjitter2
		
	setCameraInfo(IG3D_ROTATION, dirToAngles(0-x,2.5-y,0-z))
	degr=degr+(1/numfotos*2)*3.1415
	
	if cnt~=0 then
	ig3d_SaveScreenshot_s2bi(gameroot.."Data/Levels/Utility/Studio/texture_images/pic"..degr..".png", false, false, 0)
	end
	
	cnt=cnt+1
	--if cnt % 8 == 0 then theHeight=16 end
	
	if cnt==numfotos+1 then
		cnt=0
		degr=-(1/numfotos*2)*3.1415
		--degr=0.25*3.1415
		theHeight=9
		setupMaterialsForGeometryPass()
		game_func= create_geometry_images
	end
end

setupMaterialsForTexturePass()
game_func= create_texture_images

