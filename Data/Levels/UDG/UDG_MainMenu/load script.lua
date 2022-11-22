-- Begin of auto-script
loadMesh("Data/Levels/UDG/UDG_MainMenu/UDG_MainMenu_level_mesh.wtf")
gSoundFiles={"Data/Sounds/drivingrock.ogg"}
for i=1,#gSoundFiles,1 do
	loadSound(gSoundFiles[i])
end
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, -2.604867, 10.326765, -0.818572)
setCameraInfo(IG3D_ROTATION, 87.000008, 87.005203, -0.000000)
gObjects={}
gObjectWTFs={"Misc/udg_logo1x1.wtf","Misc/udgmainmenu.wtf"}
gObjectNames={"udg_logo1x11","udgmainmenu1"}
gObjectPositions={{-0.836470,1.052167,0.753137},{0.006320,0.746067,-0.002714}}
gObjectRotations={{97.629211,82.415298,115.622139},{0.000000,0.000000,0.000000}}
gObjectSizes={{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000}}
gObjectColls={true,true}
gObjectHUDs={false,false}
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
gParticleNamesAndEMTs={{"snow4x4001","Data/Emitters/snow4x4.emt"},{"snow4x4002","Data/Emitters/snow4x4.emt"},{"barrellid001","Data/Emitters/Containers/barrellid.emt"},{"barrellid002","Data/Emitters/Containers/barrellid.emt"},{"barrellid003","Data/Emitters/Containers/barrellid.emt"},{"barrelopen001","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen002","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen003","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen004","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen005","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen006","Data/Emitters/Containers/barrelopen.emt"},{"vehicletire001","Data/Emitters/Vehicles_land/vehicletire.emt"},{"vehicletire002","Data/Emitters/Vehicles_land/vehicletire.emt"},{"vehicletire003","Data/Emitters/Vehicles_land/vehicletire.emt"},{"vehicletire004","Data/Emitters/Vehicles_land/vehicletire.emt"}}
gParticlePositions={{-1.237104,4.679227,-1.416158},{-7.999743,1.740090,-0.428016},{-0.671044,7.494551,-0.512705},{-1.551405,10.761714,-1.127718},{-0.993244,13.962162,-0.459393},{-1.343096,19.967644,-1.896057},{-1.145827,9.379030,-0.274372},{-2.150975,8.101139,-2.481436},{-1.314619,10.923021,-0.426737},{-2.001944,7.871811,-2.176668},{-0.158290,25.227905,-1.138979},{-2.676687,6.571373,-1.371626},{-1.690042,8.712455,-0.994628},{-1.619693,11.240948,-0.334729},{-1.512198,7.741199,-2.110139}}
gParticleRotations={{0.000000,37.000000,0.000000},{0.000000,68.500000,0.000000},{3.500000,63.500000,0.000000},{-22.500000,0.000000,0.000000},{-19.000000,0.000000,0.000000},{13.500000,0.000000,0.000000},{-99.000000,0.000000,39.500000},{-29.500000,0.000000,0.000000},{0.000000,0.000000,0.000000},{-20.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{-33.500000,-46.500000,35.000000},{0.000000,-44.000000,51.500000},{35.500000,21.500000,143.000000}}
gParticleEmitters={}
for i=1,#gParticleNamesAndEMTs,1 do
	gParticleEmitters[i]=make(ig3d_particle_emitter, gParticleNamesAndEMTs[i][1], gParticleNamesAndEMTs[i][2])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_POSITION, gParticlePositions[i][1],gParticlePositions[i][2],gParticlePositions[i][3])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_ROTATION, gParticleRotations[i][1],gParticleRotations[i][2],gParticleRotations[i][3])
end
gNumParticleEmitters=#gParticleNamesAndEMTs
gSoundEmitterNames={"radio"}
gSoundEmitterPositions={{-5.426918,0.751314,-0.257536}}
gSoundEmitterSamples={""}
gSoundEmitters={}
for i=1,#gSoundEmitterNames,1 do
	gSoundEmitters[i]=make(ig3d_sound_emitter, gSoundEmitterNames[i])
	setSound_emitterInfo(gSoundEmitters[i], IG3D_POSITION, gSoundEmitterPositions[i][1],gSoundEmitterPositions[i][2],gSoundEmitterPositions[i][3])
	setSound_emitterInfo(gSoundEmitters[i], IG3D_SAMPLE, gSoundEmitterSamples[i])
end
gNumSoundEmitters=#gSoundEmitterNames
gGroups={}
gNumGroups=0
gTextboxFonts={"Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png"}
gTextboxPositions={{10,202},{10,202},{10,202},{10,202},{10,202},{10,202},{10,202},{10,202},{10,202},{10,202},{10,202}}
gTextboxSizes={12,32,32,32,32,32,32,32,32,32,32}
gTextboxColors={{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000}}
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
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.000000,0.000000,0.000000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, -0.500000,2.000000,-1.000000,0.000000)
setLightInfo(1, IG3D_AMBIENT, 0.200000,0.200000,0.200000,1.000000)
setLightInfo(1, IG3D_DIFFUSE, 1.000000,0.000000,0.000000,1.000000)
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


--now lets fill up the cache with some animations
	--ig3d_ReadAnimationsFromFileIntoCache_si(gameroot.."Data/WTF/Characters/truebonesmaster.wtf", 25179)
	--setObjectInfo(gObjects[1].cObj, IG3D_ANIMATION, "Idle",0, true)
	--setObjectInfo(gObjects[2].cObj, IG3D_ANIMATION, "Idle",0, true)
--setSound_emitterInfo(gSoundEmitters[1], IG3D_POSITION, getCameraInfo(IG3D_POSITION))
--setSound_emitterInfo(gSoundEmitters[1], IG3D_VOLUME, 40)
--setSound_emitterInfo(gSoundEmitters[1], IG3D_START)
for i=1,#gParticleNamesAndEMTs,1 do
		
				runningParticle = get(ig3d_particle_emitter, i)
				setParticle_emitterInfo(gParticleEmitters[i], IG3D_FORCE, 0,-9.81,0)
				setParticle_emitterInfo(gParticleEmitters[i], IG3D_START)
			end


setObjectInfo(gObjects[1].cObj, IG3D_POSITION, -0.836470,1.052167,0.753137)
setObjectInfo(gObjects[1].cObj, IG3D_ROTATION, 97.629211,82.415298,115.622139)
setObjectInfo(gObjects[1].cObj, IG3D_MASS, 0,0,0,0)
setObjectInfo(gObjects[2].cObj, IG3D_MASS, 0,0,0,0)

setCameraInfo(IG3D_POSITION, 0.668879, 1.149802, 0.717157)
setCameraInfo(IG3D_ROTATION, 13.000004, -106.328125, 0.000000)

dofile(gameroot.."Data/Scripts/Games/UDG_Functions/UDG_Entities/UDG_TextMenu.lua")
dofile(gameroot.."Data/Scripts/Games/UDG_Functions/UDG_Entities/UDG_Menu.lua")
function udg_menu_maintainPosition()
for i=1,#gObjectWTFs,1 do
		setObjectInfo(gObjects[i].cObj, IG3D_POSITION, gObjectPositions[i][1],gObjectPositions[i][2],gObjectPositions[i][3])
	setObjectInfo(gObjects[i].cObj, IG3D_ROTATION, gObjectRotations[i][1],gObjectRotations[i][2],gObjectRotations[i][3])
	
end
udg_mouse_and_buttons()
end

game_func=udg_menu_maintainPosition
