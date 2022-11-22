-- Begin of auto-script
loadMesh("Data/Levels/ZGS_default/default_level_mesh.wtf")
gSoundFiles={"Data/Sounds/bodyhit.ogg","Data/Sounds/skid.ogg","Data/Sounds/engine.ogg","Data/Sounds/colt45.ogg","Data/Sounds/zombie.ogg"}
for i=1,#gSoundFiles,1 do
	loadSound(gSoundFiles[i])
end
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, -7.904955, 12.901425, -32.218155)
setCameraInfo(IG3D_ROTATION, 37.666630, -77.404633, 0.000000)
gObjects={}
gObjectWTFs={"Misc/selectionRect.wtf","Characters/mcTrueBones.wtf","Characters/zombie.wtf","Characters/zombiechick_alt.wtf","Houses/domicile.wtf","Vehicles_land/vehicle.wtf","Vehicles_land/BHWarthog1k7.wtf","Weapons/gloc.wtf"}
gObjectNames={"selectionRect1","masterchief","zombie1","zombiechick1","domicile1","car1","car2","gun1"}
gObjectPositions={{-20.886086,1.000000,-12.211576},{-9.217467,1.900000,-8.961292},{-22.418497,1.000000,-22.580770},{-33.523537,1.000000,-31.077461},{-36.523537,1.000000,-36.077461},{-24.642694,1.000000,-14.585917},{-17.285038,1.000000,-30.848927},{-10.000000,-1.000000,-10.000000},{10.000000,1.000000,0.000000}}
gObjectRotations={{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{0.000000,-0.000000,0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{0.000000,100.000000,0.000000}}
gObjectSizes={{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000}}
gObjectColls={false,true,true,true,true,true,true,true,false}
gObjectHUDs={false,false,false,false,false,false,false,false}
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
gParticleNamesAndEMTs={{"Bullets","Data/Emitters/pistol.emt"},{"TireTraces","Data/Emitters/tiretrace.emt"},{"Blood","Data/Emitters/blood.emt"},{"MoreBlood","Data/Emitters/blood2.emt"},{"Muzzleflash","Data/Emitters/muzzleflash.emt"},{"Unitmarker","Data/Emitters/unitmarker.emt"},{"Unitmarker2","Data/Emitters/unitmarker2.emt"}}
gParticlePositions={{-34.501820,-2.745420,-11.845739},{-185.062057,-2.428456,-0.457016},{-29.986479,-2.190553,-33.200272},{-0.182363,0.522658,-0.518280},{-34.501820,-2.745420,-11.845739},{-34.501820,-2.745420,-11.845739},{-34.501820,-2.745420,-11.845739}}
gParticleRotations={{-9.058784,168.954941,-0.000000},{17.067825,64.048012,-0.000000},{-29.986481,-2.190553,-33.200272},{-0.182363,0.522658,-0.518280},{-0.182363,0.522658,-0.518280},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000}}
gParticleEmitters={}
for i=1,#gParticleNamesAndEMTs,1 do
	gParticleEmitters[i]=make(ig3d_particle_emitter, gParticleNamesAndEMTs[i][1], gParticleNamesAndEMTs[i][2])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_POSITION, gParticlePositions[i][1],gParticlePositions[i][2],gParticlePositions[i][3])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_ROTATION, gParticleRotations[i][1],gParticleRotations[i][2],gParticleRotations[i][3])
end
gNumParticleEmitters=#gParticleNamesAndEMTs
gSoundEmitterNames={"emt1","emt2","emt3","emt4","emt5","emt6","emt7","emt8","emt9","emt10","emt11","emt12","emt13","emt14","emt15","emt16","emt17","emt18","emt19","emt20","emt21","emt22","emt23","emt24","emt25","emt26","emt27","emt28","emt29","emt30","emt31","emt32","emt33","emt34","emt35","emt36","emt37","emt38","emt39","emt40","emt41","emt42","emt43","emt44","emt45","emt46","emt47","emt48","emt49","emt50","emt51","emt52","emt53","emt54","emt55","emt56","emt57","emt58","emt59","emt60"}
gSoundEmitterPositions={{-34.501820,-2.745420,-11.845739},{-79.557938,-0.000000,1.835643},{-179.351593,-1.875124,1.645756},{-179.351593,-1.875124,1.645756},{-9.479267,-0.000000,-2.248839},{-1.771667,-0.000000,2.347483},{57.685104,-2.986562,-58.026970},{-37.328007,-3.404095,-0.246476},{-54.438046,-2.877837,30.954058},{-30.368822,-2.469231,-33.033920},{32.548939,-2.700276,-37.814537},{-33.527245,-3.116081,-11.320180},{132.915329,-4.007683,-118.504578},{132.915329,-4.007683,-118.504578},{-1.719807,-0.000000,3.347189},{-1.965025,-0.000000,4.364202},{-2.171625,-0.000000,5.881331},{-2.020918,-0.000000,6.366313},{-1.885633,-0.000000,7.027786},{-37.270939,-3.423660,-0.301831},{-2.008939,-0.000000,1.896740},{-29.986479,-2.190553,-33.200272},{-2.569049,-0.000000,1.660343},{-3.330672,-0.000000,1.618744},{-33.932728,0.861009,-14.321043},{-4.007217,-0.000000,1.596008},{-4.999723,-0.000000,1.790151},{-1.846931,-0.000000,8.136511},{-5.835466,-0.000000,1.726959},{-1.531549,-0.000000,8.353496},{-6.867738,-0.000000,1.713369},{-1.312039,-0.000000,9.042771},{-8.192620,-0.000000,1.852457},{-1.836934,-0.000000,10.522897},{-9.186561,-0.000000,1.817939},{-1.929190,-0.000000,11.671301},{-10.078955,-0.000000,1.707725},{-1.921479,-0.000000,12.318409},{-11.144773,-0.000000,1.682763},{-2.149908,-0.000000,14.025126},{-12.026814,-0.000000,1.628878},{-13.171659,-0.000000,1.599076},{-14.931591,-0.000000,1.687620},{-17.153421,-0.000000,1.811627},{-20.307222,-0.000000,1.930817},{-2.148632,-0.000000,15.640233},{-2.103099,-0.000000,17.291697},{-2.182349,-0.000000,16.747002},{-2.027389,-0.000000,17.991289},{-1.914886,-0.000000,18.929188},{-1.887625,-0.000000,19.839075},{-1.607615,-0.000000,20.566446},{-1.705121,-0.000000,21.748552},{-20.684217,-0.000000,1.312660},{-0.209051,-0.000000,17.709719},{-0.744054,-0.000000,12.465975},{-0.329400,-0.000000,6.651788},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000}}
gSoundEmitterSamples={"Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/skid.ogg","Data/Sounds/engine.ogg","Data/Sounds/skid.ogg","Data/Sounds/engine.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/colt45.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","","","","",""}
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
gTextboxPositions={{50,50}}
gTextboxSizes={10}
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
setSceneInfo(IG3D_FOG, false,0.562000,0.488000,0.050000,-0.000000,200.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.562000,0.488000,0.050000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, 250.000000,250.000000,250.000000,1.000000)
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


dofile(gameroot.."Data/Scripts/Games/ZGS_Functions/ZGS_Init.lua")
-- handle_zgs in ZGS_Functons/ZGS_Game.lua
game_func = handle_RTS