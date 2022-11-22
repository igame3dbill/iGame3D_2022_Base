-- Begin of auto-script
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, 0.953707, 0.586922, 1.684527)
setCameraInfo(IG3D_ROTATION, 16.867249, -150.483337, -0.000000)
gObjects={}
gObjectWTFs={}
gObjectNames={}
gObjectPositions={}
gObjectRotations={}
gObjectSizes={}
gObjectColls={}
gObjectHUDs={}
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
setSceneInfo(IG3D_FOG, false,0.500000,0.500000,0.500000,0.000000,200.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.300000,0.300000,0.900000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, -1.000000,10.000000,10.000000,0.000000)
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
ig3d_SetMode_i(2)
gCurFrame=1
gStart=0.0

dofile(gameroot.."Data/Scripts/Examples/truebonesbvh_parser.lua")

loadBVHFile(gameroot.."Data/BVH/FreeBVH/BoxerWarming1.bvh")

function ModelAnimationList(whichmodel)
	p=ig3d_GetObjectModelPath_s_s(whichmodel)
	local tmp=io.open(p,"r")
	gAnimsList={}
	tmp:seek("set",ig3d_GetObjectModelAnimOffset_s_i(whichmodel))
	local n=tmp:read("*l")	--read chunk name
	n=tonumber(tmp:read("*l"))		--how many animations?
	for i=1,n,1 do
		local newAnim={markers={} }
		newAnim.name=tmp:read("*l")
		local an=tonumber(tmp:read("*l"))
		for j=1,an,1 do
			local m={cntrl=nil}
			tims=tmp:read("*l")
			morphs=tmp:read("*l")
			end
			table.insert(gAnimsList, newAnim)		
		print(newAnim.name)
		end
		tmp:close()
end

selectionList=ig3d_GetSelection__s()
listAnims = ModelAnimationList("truebonesmaster1")

dofile(gameroot.."Data/GUI/BVHbrowser/BVHbrowser.fl")
function truebonesbvhtestloop()
	gStart=gStart+passed()
	local frm=math.floor( gStart/gFrameTime)
	if frm>#poses then gStart=0;frm=1 end	
	itrtr=string.gmatch(poses[frm], "[%w.-]+")
	createLocalMatricesForBVHFrame(rootBone, itrtr)
	if click("-") then
		neutralPose(rootBone)
	end
	fltk_update()
end

edit_func=truebonesbvhtestloop