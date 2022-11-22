-- Begin of auto-script
loadMesh("Data/Levels/Postman/Postman_level_mesh.wtf")
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"},{"Data/FontPngs/iphonecarsprites32_1.png","Data/FontPngs/iphonecarsprites32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, -26.080761, 10.489416, 4.489507)
setCameraInfo(IG3D_ROTATION, 90.000000, -0.000000, 0.000000)
gObjects={}
gObjectWTFs={"Characters/mailman.wtf","Characters/grandma.wtf","Characters/grandma.wtf","Characters/grandma.wtf","Characters/grandma.wtf","Misc/arrow.wtf"}
gObjectNames={"mailman","grandma1","grandma2","grandma3","grandma4","arrow1"}
gObjectPositions={{-26.080761,0.489417,4.489507},{-25.022242,0.790167,-4.752849},{-43.765881,2.087687,4.489543},{-3.735052,0.951961,6.491702},{-25.830694,1.387740,-15.845622},{-26.080761,6.489416,4.489507}}
gObjectRotations={{0.000000,-0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000}}
gObjectSizes={{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{10.000000,10.000000,10.000000}}
gObjectColls={true,true,true,true,true,false}
gObjectHUDs={false,false,false,false,false,false}
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
gParticleNamesAndEMTs={{"Kaffee","Data/Emitters/coffeesprite.emt"},{"Oma","Data/Emitters/grandmasprite.emt"}}
gParticlePositions={{6.000000,0.100000,6.000000},{-26.000000,0.100000,-8.000000}}
gParticleRotations={{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000}}
gParticleEmitters={}
for i=1,#gParticleNamesAndEMTs,1 do
	gParticleEmitters[i]=make(ig3d_particle_emitter, gParticleNamesAndEMTs[i][1], gParticleNamesAndEMTs[i][2])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_POSITION, gParticlePositions[i][1],gParticlePositions[i][2],gParticlePositions[i][3])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_ROTATION, gParticleRotations[i][1],gParticleRotations[i][2],gParticleRotations[i][3])
end
gNumParticleEmitters=#gParticleNamesAndEMTs
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
gTextboxFonts={"Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png"}
gTextboxPositions={{16,10},{120,559},{268,501},{1007,559},{-470,173},{-470,559},{-194,231},{-194,231},{-470,559},{-194,771},{731,501},{120,173},{-194,-38},{-175,173},{-657,771},{731,-38},{-657,771},{731,771},{1007,173},{731,771},{120,559},{731,-38},{120,559},{1194,231},{1007,559},{-175,559},{416,173},{-470,559},{268,-38},{-657,-38},{1194,-38}}
gTextboxSizes={16,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14}
gTextboxColors={{1.000000,-0.000000,-0.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000}}
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
--if UIMainTools then UIMainTools:hide() end
--gameroot=getSceneInfo(IG3D_ROOT)

--default global functions init
	--dofile(gameroot.."Data/Scripts/Default/default_Globals.lua")
		--showDefaultTools() --   see Data/Scripts/Default/User_Interface/main_tool_functions.lua
	--ig3d_SetMode_i(1) -- 
	--TextBox_Levels_Menu()  -- see Data/Scripts/Default//Entity/textBox_functions.lua

--dofile(gameroot.."Data/Fluid/Console/Console.fl")
dofile(gameroot.."Data/Scripts/Functions/math_functions.lua")
dofile(gameroot.."Data/Scripts/Games/Postman_Functions/Postman_timer.lua")
dofile(gameroot.."Data/Scripts/Games/Postman_Functions/Postman_roads.lua")
dofile(gameroot.."Data/Scripts/Games/Postman_Functions/Postman_letters.lua")
dofile(gameroot.."Data/Scripts/Games/Postman_Functions/Postman_powerups.lua")
dofile(gameroot.."Data/Scripts/Games/Postman_Functions/Postman_collisions.lua")
dofile(gameroot.."Data/Scripts/Games/Postman_Functions/Postman_grandmas.lua")
dofile(gameroot.."Data/Scripts/Games/Postman_Functions/Postman_input.lua")
dofile(gameroot.."Data/Scripts/Games/Postman_Functions/Postman_game.lua")
game_func = handle_getready_postman_game

--edit_func = default_escapekey
-- libraryMenuPick("Levels")