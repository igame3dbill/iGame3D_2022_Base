-- Begin of auto-script
loadMesh("Data/Levels/UFO/mesh.wtf")

gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, 6.181408, 2.554353, -2.842690)
setCameraInfo(IG3D_ROTATION, 17.999996, -80.666687, -0.000000)
gObjects={}
gObjectWTFs={"Vehicles_air/ufo.wtf","Characters/skeleton.wtf","Characters/skeleton.wtf","Characters/skeleton.wtf","Characters/skeleton.wtf","Characters/skeleton.wtf","Characters/skeleton.wtf","Characters/skeleton.wtf","Characters/skeleton.wtf","Vehicles_air/tractorbeam.wtf"}
gObjectNames={"ufo1","mrcheif1","mrcheif2","mrcheif3","mrcheif4","mrcheif5","mrcheif6","mrcheif7","mrcheif8","tractorbeam1"}
gObjectPositions={{4.201072,9.647311,-11.121045},{-3.501957,0.465569,-2.426884},{2.009847,0.441894,0.484627},{0.861363,0.418760,-0.484627},{-0.893061,0.534328,1.401895},{-1.356130,0.484328,-1.677743},{2.480726,0.476866,-2.197943},{1.058443,0.476866,2.275924},{-3.506092,0.688809,1.683402},{10000.000000,10000.000000,10000.000000}}
gObjectRotations={{0.000000,0.000000,0.000000},{0.000000,-70.000130,0.000000},{0.000000,52.500317,0.000000},{179.979767,-51.499935,-179.990234},{-0.039150,-58.500275,0.005893},{-0.050225,44.999962,-0.005663},{179.977310,66.081566,-179.994324},{0.000000,0.000000,0.000000},{0.000000,56.000290,0.000000},{0.000000,0.000000,0.000000}}
gObjectSizes={{1000.000000,1000.000000,1000.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000}}
gObjectColls={true,true,true,true,true,true,true,true,true,true}
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
gGroups={}
gNumGroups=0
setSceneInfo(IG3D_TINT_COLOR, 1.000000,1.000000,1.000000)
setSceneInfo(IG3D_FOG, false,0.500000,0.500000,0.500000,0.000000,200.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.650000,0.650000,0.650000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, 15.000000,15.000000,15.000000,0.000000)
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



ufo=gObjects[1]
hunting=true
target=2
nextHunt=0
tractorbeam=gObjects[#gObjects]

setObjectInfo(ufo.cObj, IG3D_CAST_SHADOW, true)
setLightInfo(2, IG3D_POSITION, 15,15,15,0)

setSceneInfo(IG3D_RECEIVE_SHADOW, true)

for i=2,#gObjects-1,1 do
	setObjectInfo(gObjects[i].cObj, IG3D_RECEIVE_SHADOW, true)
	setObjectInfo(gObjects[i].cObj, IG3D_GRAVITY_MULTIPLIER, 1)
end
setObjectInfo(tractorbeam.cObj, IG3D_COLL, false)


function ufo_game()


if hunting == true then
	local tx,ty,tz=getObjectInfo(gObjects[target].cObj, IG3D_POSITION)
	local sx,sy,sz=getObjectInfo(ufo.cObj, IG3D_POSITION)
	l=math.sqrt( (tx-sx)*(tx-sx) + (tz-sz)*(tz-sz) )
	local dx,dy,dz=normalized(tx-sx,0, tz-sz)
	setObjectInfo(ufo.cObj, IG3D_VELOCITY, dx*5,dy*5,dz*5)
	if l<0.5 then
		setObjectInfo(ufo.cObj, IG3D_VELOCITY, 0,0,0)
		hunting=false
		setObjectInfo(gObjects[target].cObj, IG3D_VELOCITY, 0,2,0)
		nextHunt=time()+3
		setObjectInfo(tractorbeam.cObj, IG3D_POSITION, tx,0,tz)
		
	end
else
	if time()>nextHunt then
		hunting=true
		setObjectInfo(gObjects[target].cObj, IG3D_RAGDOLL, true)
		oldtarget=target
		target=target+1
		if target>#gObjects-1 then loadLevel("Data/Levels/UFO") end
		setObjectInfo(tractorbeam.cObj, IG3D_POSITION, 10000,10000,10000)		
		
		
		setObjectInfo(gObjects[target].cObj, IG3D_RECEIVE_SHADOW, true)
	else
		setObjectInfo(gObjects[target].cObj, IG3D_VELOCITY, 0,2,0)
		setObjectInfo(gObjects[target].cObj, IG3D_RECEIVE_SHADOW, false)
	end
	
end
	


end

game_func=ufo_game