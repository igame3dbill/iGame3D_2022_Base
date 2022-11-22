-- Begin of auto-script
loadMesh("Data/WTF/Locations/streetMap384x384A.wtf")
gSoundFiles={"Data/Sounds/bodyhit.ogg","Data/Sounds/skid.ogg","Data/Sounds/engine.ogg","Data/Sounds/colt45.ogg","Data/Sounds/zombie.ogg","Data/Sounds/rifle.ogg"}
for i=1,#gSoundFiles,1 do
	loadSound(gSoundFiles[i])
end
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, -75.568512, 4.490177, -29.051826)
setCameraInfo(IG3D_ROTATION, 29.666668, -134.070862, -0.000000)
gObjects={}
gObjectWTFs={"Vehicles_land/BHWarthog1k7.wtf","Vehicles_land/BHWarthog1k7.wtf","Weapons/hk53Submachinegun.wtf","Characters/zombiechick.wtf","Characters/jackytruebones.wtf","Characters/fighterManbvh.wtf","Characters/fighterManbvh.wtf","Characters/Officer.wtf","Characters/zombiechick_alt.wtf","Characters/zombie_sm.wtf","Characters/zombie_sm.wtf","Characters/zombiechick_alt2.wtf","Characters/chick.wtf","Characters/zombie_sm.wtf","Vehicles_land/vehicle.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Houses/domicile.wtf","Misc/selectionRect.wtf","Buildings/building14x24x14.wtf","Buildings/building14x24x14.wtf","Buildings/building14x24x14.wtf","Buildings/building14x24x14.wtf","Buildings/building24x24x24.wtf","Buildings/building24x24x24.wtf","Buildings/building24x24x24.wtf","Buildings/building24x24x24.wtf","Buildings/building24x24x24.wtf","Buildings/building28x38x28.wtf","Buildings/building28x38x28.wtf","Buildings/building28x38x28.wtf","Buildings/building28x38x28.wtf","Buildings/building34x44x24.wtf","Buildings/building34x44x24.wtf","Characters/zombie_sm.wtf","Characters/zombie_sm.wtf","Characters/zombie_sm.wtf","Characters/zombie_sm.wtf","Characters/zombie_sm.wtf","Characters/zombie_sm.wtf","Characters/zombie_sm.wtf","Characters/zombie_sm.wtf","Characters/zombie_sm.wtf","Characters/zombie_sm.wtf","Characters/zombie_sm.wtf"}
gObjectNames={"car","car2","rifle1","zombiechick","jacky","masterchief","officer1","officer2","zombiechick2","zombie1","zombie2","zombiechick3","anita","zombie3","car3","gloc1","gloc2","gloc3","domicile1","selectionRect1","building14x24x141","building14x24x142","building14x24x143","building14x24x144","building24x24x241","building24x24x242","building24x24x243","building24x24x244","building24x24x245","building28x38x281","building28x38x282","building28x38x283","building28x38x284","building34x44x241","building34x44x242","zombie4","zombie5","zombie6","zombie7","zombie8","zombie9","zombie10","zombie11","zombie12","zombie13","zombie14"}
gObjectPositions={{-82.229950,-0.399370,-54.562592},{-58.966618,-0.561479,-40.778442},{-79.197098,-0.633583,-43.977192},{-59.964954,-0.919727,-54.266525},{-81.666504,0.073437,-36.540585},{-81.418671,0.046094,-45.051888},{-83.061279,0.224805,-41.229946},{-78.054863,-0.337695,-34.900768},{-61.656940,-1.035483,-25.477583},{-62.939762,-1.125781,-30.869177},{-70.608101,-0.888477,-59.525570},{-54.979557,-0.903636,-59.772606},{-80.197594,-0.090069,-28.686607},{-58.320290,-0.804492,-36.706638},{-55.777229,-0.692365,-17.707989},{-80.683044,-0.456656,-40.155304},{-77.653748,-0.811148,-44.844639},{-80.513649,-0.475210,-42.220020},{-106.603096,0.568685,-47.339645},{0.000000,-1.199023,0.000000},{167.265060,5.825368,104.042381},{81.891838,5.623219,-103.427635},{27.420242,5.823415,40.703918},{-111.787254,5.441579,-16.292168},{148.318893,11.800000,-22.400591},{104.286285,11.799024,164.352875},{-88.942413,11.799024,91.297539},{-146.689041,11.682813,162.829208},{104.169006,11.800000,84.800362},{-170.305176,13.800001,-105.655540},{-32.363468,13.800001,162.257156},{-164.919983,13.800001,93.130875},{93.147194,13.800001,-169.688766},{156.128983,21.799999,-170.330032},{-149.023376,21.799999,-156.222168},{-2.257506,-1.043750,-41.686630},{14.768401,-1.158008,-0.608393},{50.346939,-0.686328,10.018907},{66.442070,-1.029102,-21.879917},{23.221802,12.401563,37.306744},{18.665747,-0.686328,-7.735530},{3.863429,-1.117969,1.181591},{0.979975,-1.131641,-3.327398},{-2.371711,-1.034961,4.825593},{-20.260180,0.299023,-29.201937},{-53.566792,-0.915820,-4.083251}}
gObjectRotations={{2.085048,5.234454,-1.449518},{179.665207,-20.748501,178.195282},{-179.973557,-30.444090,179.960358},{-0.080928,-65.465202,0.051625},{179.911911,-33.041035,-179.985687},{0.148066,-80.306870,-0.147651},{-0.045227,-75.918854,-0.108244},{-179.966919,-0.805252,179.937897},{0.018936,-0.000185,-0.023103},{179.903931,-17.654774,179.984283},{172.016418,-12.330005,-178.923889},{0.246095,-81.916481,-0.237759},{-8.131411,81.651833,-10.434368},{-0.263169,20.945168,0.066198},{179.667068,13.035575,179.943985},{-108.227303,27.508116,19.483601},{-179.980164,-4.752491,179.999176},{179.878387,-33.054356,-179.933975},{0.031149,0.232032,-0.002624},{0.000000,-0.000000,0.000000},{0.013966,-13.653747,0.056191},{-0.049878,0.797548,-0.024945},{0.037009,0.000006,-0.019782},{-0.001582,-2.499786,0.042258},{-0.008287,-0.338016,0.030528},{0.036803,0.410568,-0.032041},{-0.011049,0.725185,-0.053527},{-0.003298,5.946024,0.014949},{0.065697,-0.771383,0.039470},{-0.014393,0.010800,-0.081093},{0.040295,3.001242,-0.025052},{-0.018871,-0.099220,0.038498},{0.055493,-0.129506,0.031196},{0.001925,-0.374157,0.050665},{-0.005451,-0.098258,0.041216},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000}}
gObjectSizes={{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000}}
gObjectColls={true,true,false,true,true,true,true,true,true,true,true,true,true,true,true,false,false,false,true,false,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true}
gObjectHUDs={false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false}
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
gParticleRotations={{-9.058784,168.954941,0.000000},{17.067825,64.048012,0.000000},{-29.986481,-2.190553,-33.200272},{-0.182363,0.522658,-0.518280},{-0.182363,0.522658,-0.518280},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000}}
gParticleEmitters={}
for i=1,#gParticleNamesAndEMTs,1 do
	gParticleEmitters[i]=make(ig3d_particle_emitter, gParticleNamesAndEMTs[i][1], gParticleNamesAndEMTs[i][2])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_POSITION, gParticlePositions[i][1],gParticlePositions[i][2],gParticlePositions[i][3])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_ROTATION, gParticleRotations[i][1],gParticleRotations[i][2],gParticleRotations[i][3])
end
gNumParticleEmitters=#gParticleNamesAndEMTs
gSoundEmitterNames={"emt1","emt2","emt3","emt4","emt5","emt6","emt7","emt8","emt9","emt10","emt11","emt12","emt13","emt14","emt15","emt16","emt17","emt18","emt19","emt20","emt21","emt22","emt23","emt24","emt25","emt26","emt27","emt28","emt29","emt30","emt31","emt32","emt33","emt34","emt35","emt36","emt37","emt38","emt39","emt40","emt41","emt42","emt43","emt44","emt45","emt46","emt47","emt48","emt49","emt50","emt51","emt52","emt53","emt54","emt55","emt56","emt57","emt58","emt59","emt60"}
gSoundEmitterPositions={{-34.501820,-2.745420,-11.845739},{-79.557938,0.000000,1.835643},{-179.351593,-1.875124,1.645756},{-179.351593,-1.875124,1.645756},{-9.479267,0.000000,-2.248839},{0.000000,0.000000,0.000000},{57.685104,-2.986562,-58.026970},{-37.328007,-3.404095,-0.246476},{-54.438046,-2.877837,30.954058},{-30.368822,-2.469231,-33.033920},{32.548939,-2.700276,-37.814537},{-33.527245,-3.116081,-11.320180},{132.915329,-4.007683,-118.504578},{132.915329,-4.007683,-118.504578},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{-37.270939,-3.423660,-0.301831},{0.000000,0.000000,0.000000},{-29.986479,-2.190553,-33.200272},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{-33.932728,-2.924038,-15.022549},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000}}
gSoundEmitterSamples={"Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/skid.ogg","Data/Sounds/engine.ogg","Data/Sounds/skid.ogg","Data/Sounds/engine.ogg","Data/Sounds/skid.ogg","Data/Sounds/engine.ogg","Data/Sounds/rifle.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","","","","","","","","",""}
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
setSceneInfo(IG3D_FOG, false,0.500000,0.500000,0.500000,0.000000,200.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.562000,0.488000,0.050000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, 250.000000,250.000000,250.000000,1.000000)
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


dofile(gameroot.."Data/Scripts/Games/ZGS_Functions/ZGS_Init.lua")
-- handle_zgs in ZGS_Functons/ZGS_Game.lua
game_func = handle_ZGS
