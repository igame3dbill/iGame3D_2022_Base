-- Begin of auto-script
loadMesh("Data/Levels/UDG/UDG_IntroCredits/UDG_IntroCredits_level_mesh.wtf")
gSoundFiles={"Data/Sounds/drivingrock.ogg","Data/Sounds/brakeandcrash.ogg"}
for i=1,#gSoundFiles,1 do
	loadSound(gSoundFiles[i])
end
gFontFiles={{"Data/FontPngs/Shlop32_1.png","Data/FontPngs/Shlop32_2.png"},{"Data/FontPngs/CRAMPS32_1.png","Data/FontPngs/CRAMPS32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, 47.944233, 2.004113, 85.644997)
setCameraInfo(IG3D_ROTATION, 14.999991, 5.666550, 0.000000)
gObjects={}
gObjectWTFs={"Vehicles_land/vehicle.wtf","Vehicles_land/ambulance.wtf","Vehicles_land/Truck6wheeler.wtf","Shapes/blendquad.wtf","Cubes/kiste.wtf","Characters/tomdrinwoman2_3k.wtf","Characters/tomdrinman2_3k.wtf"}
gObjectNames={"vehicle1","ambulance1","Truck6wheeler1","blendquad1","kiste1","truebonesmaster1","truebonesmaster2"}
gObjectPositions={{46.305626,0.475983,8.490750},{49.891037,0.943582,94.482208},{47.136135,1.277280,94.647942},{-0.000000,-0.000000,-0.100000},{50.400150,-101.713539,56.151123},{45.602867,1.144851,89.746315},{49.694416,1.644848,90.490242}}
gObjectRotations={{0.000000,-0.000000,0.000000},{25.001698,0.890048,-91.790543},{-179.961304,-19.500286,179.993347},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.061256,63.000027,-0.057631},{-0.060979,-83.418610,0.027033}}
gObjectSizes={{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000}}
gObjectColls={true,true,true,false,true,false,false}
gObjectHUDs={false,false,false,true,false,false,false}
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
gParticleNamesAndEMTs={{"snow","Data/Emitters/snow.emt"},{"oilonfloor","Data/Emitters/oilonfloor.emt"},{"oilonfloor","Data/Emitters/oilonfloor.emt"},{"oil","Data/Emitters/oil.emt"},{"blizzard1","Data/Emitters/snow4x4.emt"},{"blizzard2","Data/Emitters/snow4x4.emt"}, {"roadflare1","Data/Emitters/roadflare1.emt"}}
gParticlePositions={{1000.000000,1000.000000,1000.000000},{47.054546,0.010000,94.533524},{47.093922,0.010000,94.000954},{47.726200,10.000000,91.840355},{47.136135,1.277280,94.647942},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000}}
gParticleRotations={{90.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{90.000000,-0.000000,-0.000000},{-0.000000,180.000000,-0.000000},{-0.000000,180.000000,-0.000000},{-0.000000,-0.000000,-0.000000}}
gParticleEmitters={}
for i=1,#gParticleNamesAndEMTs,1 do
	gParticleEmitters[i]=make(ig3d_particle_emitter, gParticleNamesAndEMTs[i][1], gParticleNamesAndEMTs[i][2])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_POSITION, gParticlePositions[i][1],gParticlePositions[i][2],gParticlePositions[i][3])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_ROTATION, gParticleRotations[i][1],gParticleRotations[i][2],gParticleRotations[i][3])
end
gNumParticleEmitters=#gParticleNamesAndEMTs
gSoundEmitterNames={"Music","noise"}
gSoundEmitterPositions={{44.995869,0.480840,39.401543},{44.995869,0.480840,39.401543}}
gSoundEmitterSamples={"Data/Sounds/drivingrock.ogg","Data/Sounds/brakeandcrash.ogg"}
gSoundEmitters={}
for i=1,#gSoundEmitterNames,1 do
	gSoundEmitters[i]=make(ig3d_sound_emitter, gSoundEmitterNames[i])
	setSound_emitterInfo(gSoundEmitters[i], IG3D_POSITION, gSoundEmitterPositions[i][1],gSoundEmitterPositions[i][2],gSoundEmitterPositions[i][3])
	setSound_emitterInfo(gSoundEmitters[i], IG3D_SAMPLE, gSoundEmitterSamples[i])
end
gNumSoundEmitters=#gSoundEmitterNames
gGroups={}
gNumGroups=0
gTextboxFonts={"Data/FontPngs/Shlop32_1.png","Data/FontPngs/Shlop32_1.png"}
gTextboxPositions={{270,171},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0}}
gTextboxSizes={48,0,0,0,0,0,0,0,0,0}
gTextboxColors={{1.000000,1.000000,1.000000,-0.000000},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0}}
gTextboxes={}
for i=1,#gTextboxFonts,1 do
	gTextboxes[i]=make(ig3d_text_box, gTextboxFonts[i])
	setText_boxInfo(gTextboxes[i], IG3D_POSITION, gTextboxPositions[i][1],gTextboxPositions[i][2])
	setText_boxInfo(gTextboxes[i], IG3D_SIZE, gTextboxSizes[i])
	setText_boxInfo(gTextboxes[i], IG3D_COLOR, gTextboxColors[i][1],gTextboxColors[i][2],gTextboxColors[i][3], gTextboxColors[i][4])
end
gNumTextboxes=#gTextboxFonts
setSceneInfo(IG3D_TINT_COLOR, 1.000000,1.000000,1.000000)
setSceneInfo(IG3D_FOG, true,0.000000,0.000000,0.000000,7.000000,8.00000)
setSceneInfo(IG3D_BACKGROUND_COLOR, -0.000000,-0.000000,-0.000000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, 49.500000,40.000000,60.000000,1.000000)
setLightInfo(1, IG3D_AMBIENT, 0.000000,0.000000,0.000000,1.000000)
setLightInfo(1, IG3D_DIFFUSE, 1.000000,1.000000,0.700000,1.000000)
setLightInfo(1, IG3D_SPECULAR, 0.000000,0.000000,0.000000,1.000000)
setLightInfo(1, IG3D_CONSTANT_ATTENUATION, 1.0000000)
setLightInfo(1, IG3D_LINEAR_ATTENUATION, 0.000000)
setLightInfo(1, IG3D_QUADRATIC_ATTENUATION, 0.00100000)
setLightInfo(1, IG3D_SPOTLIGHT, 0.000000,-0.70700000,0.500000000,180.000000,15.000000)
setLightInfo(2, IG3D_ENABLED, false)
setLightInfo(3, IG3D_ENABLED, false)
setLightInfo(4, IG3D_ENABLED, false)
setLightInfo(5, IG3D_ENABLED, false)
setLightInfo(6, IG3D_ENABLED, false)
setLightInfo(7, IG3D_ENABLED, false)
setLightInfo(8, IG3D_ENABLED, false)
-- End of auto-script

if ig3d_GetMode__i() == 4 then
if UIMainTools then UIMainTools:hide() end
end  -- if not game mode don't do  this stuff

dofile(gameroot.."Data/Levels/UDG/UDG_IntroCredits/UDG_IntroCreditsGlobals.lua")
dofile(gameroot.."Data/Levels/UDG/UDG_IntroCredits/UDG_IntroCreditsGame.lua")

setSceneInfo(IG3D_FULLSCREEN, true)

