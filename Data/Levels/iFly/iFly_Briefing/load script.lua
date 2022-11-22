-- Begin of auto-script
loadMesh("Data/Levels/iFly/iFly_Briefing/iFly_Briefing_level_mesh.wtf")
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, -1.083349, 6.062556, 23.312731)
setCameraInfo(IG3D_ROTATION, 52.105602, -3.308929, 0.000000)
gObjects={}
gObjectWTFs={"Vehicles_air/avatarp1.wtf","Vehicles_air/avatarp1.wtf"}
gObjectNames={"avatarp11","avatarp12"}
gObjectPositions={{-2.934393,0.689402,25.818726},{-0.171614,0.474330,25.273233}}
gObjectRotations={{2.209830,70.544418,5.110155},{-0.841081,-1.446577,-1.257466}}
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
gTextboxFonts={"Data/FontPngs/default32_1.png"}
gTextboxPositions={{17,31}}
gTextboxSizes={14}
gTextboxColors={{1.000000,1.000000,1.000000,1.000000}}
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

f=io.open(getSceneInfo(IG3D_ROOT).."Data/Levels/iFly/iFly_name.txt","r")
playerName=f:read("*line")
f:close()


briefing="MISSION BRIEFING\n\nAttention, "..playerName..",\nOur sensors have detected a large enemy air frigate\nin sector Z42. It is heading towards one of their outposts\nin the south. Since it is heavily guarded and it's flighing a\ndifferent route than the standard weapon transport convoys\nwe believe it to carry some unusual cargo.\n\nObjectives:\n- Destroy all enemies escorting that frigate\n- Force the frigate to stop and land\n  You may destroy its engines if they don't cooperate\n\nDO NOT ENTER the enemy frigate under any circumstances!\nWe will be sending a special investigation team for any further\nactions.\n\nCLICK TO PROCEED"


setText_boxInfo(gTextboxes[1], IG3D_TEXT, briefing)

setSceneInfo(IG3D_MOUSE_VIEW, true)

setSceneInfo(IG3D_RECEIVE_SHADOW, true)
setObjectInfo(gObjects[1].cObj, IG3D_CAST_SHADOW, true, "avatarp1shadow.wtf")
setObjectInfo(gObjects[2].cObj, IG3D_CAST_SHADOW, true, "avatarp1shadow.wtf")
setLightInfo(2, IG3D_POSITION, 1,1,0,0)

theLevel="Data/Levels/iFly/iFly_Game"
loadtime=0

function loop()
setObjectInfo(gObjects[2].cObj, IG3D_FORCE, 0,0,4)
if loadtime~=0 then
if time()>=loadtime then
loadLevel(theLevel)
end
else
-- End the briefing delay by clicking mouse
if click("n") then
loadtime=time()-1
end
end
end

--ig3d_SetMode_i(4)
game_func=loop
edit_func=default_escapekey