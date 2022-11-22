-- Begin of auto-script
loadMesh("Data/Levels/ZFPS/ZFPS_SnipersAlley/ZFPS_SnipersAlley_level_mesh.wtf")
gSoundFiles={"Data/Sounds/bodyhit.ogg","Data/Sounds/skid.ogg","Data/Sounds/engine.ogg","Data/Sounds/colt45.ogg","Data/Sounds/rifle.ogg","Data/Sounds/zombie.ogg","Data/Sounds/male_scream1.ogg","Data/Sounds/male_scream2.ogg","Data/Sounds/female_scream1.ogg","Data/Sounds/female_scream2.ogg","Data/Sounds/zombie_eating.ogg","Data/Sounds/zombie_yes.ogg","Data/Sounds/zombie_idle1.ogg","Data/Sounds/zombie_idle2.ogg","Data/Sounds/zombie_idle3.ogg","Data/Sounds/zombie_idle4.ogg","Data/Sounds/footsteps_walk.ogg","Data/Sounds/footsteps_run.ogg","Data/Sounds/bodyhitfloor.ogg","Data/Sounds/male_eaten.ogg","Data/Sounds/female_eaten.ogg","Data/Sounds/no_way.ogg","Data/Sounds/punchsolid.ogg","Data/Sounds/glassbreaking.ogg","Data/Sounds/grenade.ogg","Data/Sounds/dropgrenade.ogg","Data/Sounds/throw_whoosh.ogg","Data/Sounds/drivingrock.ogg","Data/Sounds/brakeandcrash.ogg"}
for i=1,#gSoundFiles,1 do
	loadSound(gSoundFiles[i])
end
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"},{"Data/FontPngs/Shlop32_1.png","Data/FontPngs/Shlop32_2.png"},{"Data/FontPngs/CRAMPS32_1.png","Data/FontPngs/CRAMPS32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, 50.357830, 16.468178, 71.071663)
setCameraInfo(IG3D_ROTATION, 33.666721, -57.853302, 0.000000)
gObjects={}
gObjectWTFs={"Misc/selectionRect.wtf","Reticule/crosshair.wtf","Cubes/kiste.wtf","Characters/soldiersol1kTB.wtf","Characters/soldierusaTB.wtf","Characters/tomdrinman1is5police.wtf","Characters/soldiersol1kTB.wtf","Characters/tomdrinman5_police.wtf","Characters/soldierboyTB.wtf","Characters/swatsoldierTB.wtf","Characters/thug_rufus.wtf","Weapons/gloc.wtf","Weapons/hk53Submachinegun.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/policebaton.wtf","Weapons/policebaton.wtf","Weapons/policebaton.wtf","Characters/zombiechick_alt.wtf","Characters/tomdrinman1_3ksnowed.wtf","Characters/tomdrinman2_3kslimed.wtf","Characters/tomdrinman1_3kslimed.wtf","Characters/zombiechick_alt2.wtf","Characters/tomdrinman5_3ksnowed.wtf","Characters/ponchocorpgirlzombie.wtf","Characters/thug_melvin.wtf","Characters/tomdrinman5_3kslimed.wtf","Characters/civilianmale1zombieTB.wtf","Characters/ponchocorpgirlzombie.wtf","Characters/tomdrinman2_3ksnowed.wtf","Characters/tomdrinman1_3kslimed.wtf","Characters/soldiersol1kTB.wtf","Characters/soldierboyTB.wtf","Characters/soldierusaTB.wtf","Characters/soldierusaTB.wtf","Building_parts/4x4glassdoor.wtf","Building_parts/4x4glassdoor.wtf","Building_parts/4x4glassdoor.wtf","Characters/thug_jackson.wtf","Characters/thug_miguel.wtf","Characters/tomdrinman2_3kladyman.wtf","Misc/zfpsmainmenu.wtf"}
gObjectNames={"selectionRect1","crosshair1","playerbox","human1","human2","human3","human4","human5","human6","human7","human8","gun2","gun3","gun4","gun5","gun6","gun8","gun9","gun10","gun11","gun12","baton1","baton2","baton3","zombiechick_alt1","tomdrinman1zombie","tomdrinman2zombie3","tomdrinmanzombie4","zombiechick_alt25","tomdrinman5zombie6","tomdrinman27","humansoldier","tomdrinman5zombie11","zombie12","tomdrinman2zombie13","tomdrinman2zombies","tomdrinmanzombie15","humansniper11","humansniper12","humansniper13","humansniper14","4x4glasswindow1","4x4glasswindow2","4x4glasswindow3","thug_jackson1","thug_miguel1","tomdrinman2_3kladyman1","zfpsmainmenu1"}
gObjectPositions={{62.000000,-86.646774,30.000000},{-0.000000,-0.000000,-0.100000},{47.258739,0.507678,76.424576},{43.243694,0.762421,25.413702},{50.598743,0.764441,20.508604},{50.047787,1.170261,63.937115},{57.660912,0.764038,18.233503},{57.498180,1.374350,78.341377},{31.634617,0.736797,4.103798},{58.993988,0.878572,54.037827},{59.890369,0.764495,58.115681},{45.005001,0.903753,34.784061},{50.549290,0.905859,20.551596},{38.000641,0.905375,19.050364},{31.658695,1.035665,4.201219},{40.337036,1.667325,25.380926},{48.382099,0.983889,-2.469377},{43.806015,1.062596,10.225948},{32.079155,1.062112,36.448139},{54.529438,1.340742,61.232269},{58.361206,1.428861,77.813133},{43.265430,1.508237,3.466213},{43.748135,1.092570,71.040619},{38.104900,0.922139,64.339561},{32.409367,0.763291,85.789154},{31.302898,0.877104,86.953789},{34.081791,0.884819,86.345802},{29.909565,0.874608,84.832825},{34.221581,0.903503,88.471359},{36.387196,0.748915,87.770821},{31.919975,0.885822,87.689659},{38.035088,0.764704,64.322937},{35.278702,0.871387,89.082436},{33.812298,0.784163,88.550003},{33.426971,0.883574,87.889641},{32.038807,0.886537,88.428612},{34.247105,0.877269,87.084724},{34.605984,1.525926,20.206026},{48.465981,0.684985,-2.414492},{43.900242,0.763712,10.260333},{51.349094,0.763259,41.020779},{33.135868,4.485277,9.000000},{41.216854,2.092036,9.168571},{45.200317,2.109542,9.197345},{57.840660,2.045993,67.538536},{43.892822,0.762901,70.989799},{43.389244,1.306236,3.409392},{59.036781,9.729663,73.370804}}
gObjectRotations={{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.016611,7.455281,0.012431},{-0.000000,-0.000000,-0.069229},{-0.077864,-54.000648,0.011938},{0.233929,-39.246868,0.310910},{0.037838,45.499935,0.046451},{-179.998566,-4.783645,179.965652},{-0.079687,79.500298,-0.169997},{0.102802,-34.790535,-0.074249},{179.923889,6.999319,179.996262},{-144.454819,-2.995698,-116.544983},{-94.354111,19.193527,-108.826492},{172.481430,-20.716248,-107.064644},{102.262924,-66.944641,-132.121292},{-149.375092,-5.480315,-116.112358},{177.420547,58.473705,-146.278854},{166.678223,46.569000,-154.909058},{-5.641941,-55.215469,-30.984768},{-108.827591,14.124356,-112.472610},{31.246439,5.116724,-63.862289},{149.428009,5.171892,-163.003189},{149.428009,5.171892,-163.003189},{106.916367,-24.505932,-79.276802},{-0.005240,35.736889,-0.024742},{-0.000000,68.798622,-0.000000},{0.010911,-2.836916,-0.006777},{0.001392,52.250011,-0.000258},{179.975479,-50.069046,179.960236},{-179.852005,-11.547765,179.918030},{-0.000000,81.514038,-0.000000},{179.991730,74.419846,179.952515},{179.976334,-63.039349,179.979919},{-179.939346,18.839806,179.936218},{-0.243449,79.166817,-0.453531},{180.000000,77.672043,180.000000},{0.619651,-32.456432,0.198050},{-0.062097,32.999348,-0.039026},{0.138156,-57.542336,-0.083377},{-0.067461,-43.999397,0.027256},{0.001155,57.105461,0.290360},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{179.855942,1.581709,179.998016},{-0.051537,-42.000221,0.004800},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000}}
gObjectSizes={{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{50.000000,50.000000,50.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,80.000001,100.000000},{100.000000,80.000001,100.000000},{100.000000,80.000001,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000}}
gObjectColls={false,false,true,true,true,true,true,true,true,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true}
gObjectHUDs={false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false}
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
gParticleNamesAndEMTs={{"Bullets","Data/Emitters/pistol.emt"},{"TireTraces","Data/Emitters/tiretrace.emt"},{"Blood","Data/Emitters/blood.emt"},{"MoreBlood","Data/Emitters/blood2.emt"},{"MuzzleFlash","Data/Emitters/muzzleflash.emt"},{"Unitmarker","Data/Emitters/unitmarker.emt"},{"Unitmarker2","Data/Emitters/unitmarker2.emt"},{"fpsgun","Data/Emitters/slowbullet.emt"},{"bloodonfloor","Data/Emitters/bloodonfloor.emt"},{"barrelopen001","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen002","Data/Emitters/Containers/barrelopen.emt"},{"barrel003","Data/Emitters/Containers/barrel.emt"},{"barrel004","Data/Emitters/Containers/barrel.emt"},{"barrel005","Data/Emitters/Containers/barrel.emt"},{"barrel006","Data/Emitters/Containers/barrel.emt"},{"barrel007","Data/Emitters/Containers/barrel.emt"},{"barrel008","Data/Emitters/Containers/barrel.emt"},{"barrel009","Data/Emitters/Containers/barrel.emt"},{"barrel010","Data/Emitters/Containers/barrel.emt"},{"barrel011","Data/Emitters/Containers/barrel.emt"},{"barrel012","Data/Emitters/Containers/barrel.emt"},{"crate0001001","Data/Emitters/Cubes/crate0001.emt"},{"crate0001002","Data/Emitters/Cubes/crate0001.emt"},{"crate0004001","Data/Emitters/Cubes/crate0004.emt"},{"crate0003001","Data/Emitters/Cubes/crate0003.emt"},{"crate0003002","Data/Emitters/Cubes/crate0003.emt"},{"crate0003003","Data/Emitters/Cubes/crate0003.emt"},{"barrelopen003","Data/Emitters/Containers/barrelopen.emt"},{"crate0001003","Data/Emitters/Cubes/crate0001.emt"},{"crate0002001","Data/Emitters/Cubes/crate0002.emt"},{"barrelopen004","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen005","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen006","Data/Emitters/Containers/barrelopen.emt"},{"snow4x4001","Data/Emitters/snow4x4.emt"},{"snow4x4002","Data/Emitters/snow4x4.emt"},{"snow4x4003","Data/Emitters/snow4x4.emt"},{"snow4x4004","Data/Emitters/snow4x4.emt"},{"snow4x4005","Data/Emitters/snow4x4.emt"},{"Grenade","Data/Emitters/grenade.emt"},{"Explosion","Data/Emitters/grenadeexplosion.emt"}}
gParticlePositions={{61.662407,8.832481,24.123236},{-185.062057,-2.428456,-0.457016},{-29.986479,-2.190553,-33.200272},{-0.168340,0.522658,-0.579106},{-34.501820,-2.745420,-11.845739},{-34.501820,-2.745420,-11.845739},{34.000000,0.314862,88.000000},{-34.501820,-2.745420,-11.845739},{-34.501820,-2.745420,-11.845739},{36.176418,2.164295,81.636833},{44.531067,4.978607,76.305214},{46.753761,4.069006,68.150574},{58.816563,6.464845,67.656754},{55.498604,5.992557,57.687035},{63.532383,5.914866,46.830757},{45.569851,6.518484,41.492481},{44.796982,3.581577,31.730278},{35.803902,8.040364,33.144314},{33.684250,8.157679,32.950588},{38.181866,6.460938,19.742765},{48.393852,7.517386,17.113089},{38.557976,1.660892,40.129295},{40.533867,1.672518,39.928085},{48.271297,1.250467,43.000908},{46.289371,1.874104,34.463444},{55.449680,1.946572,46.025158},{60.246391,1.421451,65.663948},{49.601276,3.587441,67.927902},{45.027771,1.924101,75.812370},{44.470592,1.801463,77.105446},{39.023705,2.247294,79.987839},{40.436920,2.402337,79.454475},{41.260250,2.915662,80.425507},{40.561871,5.955193,65.061111},{33.359699,6.469444,79.691719},{59.465530,5.684661,46.881401},{40.492702,5.236188,28.548168},{46.578812,8.249417,12.138110},{43.862343,1.584703,75.795692},{43.862343,1.584703,75.795692}}
gParticleRotations={{55.037315,-138.831039,-0.000000},{17.067825,64.048012,-0.000000},{-29.986481,-2.190553,-33.200272},{-0.182363,0.522658,-0.518280},{-0.182363,0.522658,-0.518280},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{34.500000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{27.500000,-0.000000,-0.500000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000}}
gParticleEmitters={}
for i=1,#gParticleNamesAndEMTs,1 do
	gParticleEmitters[i]=make(ig3d_particle_emitter, gParticleNamesAndEMTs[i][1], gParticleNamesAndEMTs[i][2])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_POSITION, gParticlePositions[i][1],gParticlePositions[i][2],gParticlePositions[i][3])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_ROTATION, gParticleRotations[i][1],gParticleRotations[i][2],gParticleRotations[i][3])
end
gNumParticleEmitters=#gParticleNamesAndEMTs
gSoundEmitterNames={"emt1","emt2","emt3","emt4","emt5","emt6","emt7","emt8","emt9","emt10","emt11","emt12","emt13","emt14","emt15","emt16","emt17","emt18","emt19","emt20","emt21","emt22","emt23","emt24","emt25","emt26","emt27","emt28","emt29","emt30","emt31","emt32","emt33","emt34","emt35","emt36","emt37","emt38","emt39","emt40","emt41","emt42","emt43","emt44","emt45","emt46","emt47","emt48","emt49","emt50","emt51","emt52","emt53","emt54","emt55","emt56","emt57","emt58","emt59","emt60","emt61","emt61","emt62","emt62","emt63","emt63","emt64","emt64","emt65","emt65","emt66","emt66","emt67","emt67","emt68","emt68","emt69","emt69","emt70","emt70","emt71","emt71","emt72","emt72","emt73","emt73","emt74","emt74","emt75","emt75","emt76","emt76","emt77","emt77","emt78","emt78","emt79","emt79","emt80","emt80","emt81","emt81","emt82","emt82","emt83","emt83","emt84","emt84","emt85","emt85","emt86","emt86","emt87","emt87","emt88","emt88","emt89","emt89","emt90","emt90","emt91","emt91","emt92","emt92","emt93","emt93","emt94","emt94","emt95","emt95","emt96","emt96","emt97","emt97","emt98","emt98","emt99","emt99","emt100","emt100","emt101","emt101","emt102","emt102","emt103","emt103","emt104","emt104","emt105","emt105","emt106","emt106","emt107","emt107","emt108","emt108","emt109","emt109","emt110","emt110","emt111","emt111","emt112","emt112","emt113","emt113","emt114","emt114","emt115","emt115","emt116","emt116","emt117","emt117","emt118","emt118","emt119","emt119","emt120","emt120","emt121","emt121","emt122","emt122","emt123","emt123","emt124","emt124","emt125","emt125","emt126","emt126","emt127","emt127","emt128","emt128","emt129","emt129","emt130","emt130","emt131","emt131","emt132","emt132","emt133","emt133","emt134","emt134","emt135","emt135","emt136","emt136","emt137","emt137","emt138","emt138","emt139","emt139","emt140","emt140","emt141","emt141","emt142","emt142","emt143","emt143","emt144","emt144","emt145","emt145","emt146","emt146","emt147","emt147","emt148","emt148","emt149","emt149","emt150","emt150","emt151","emt151","emt152","emt152","emt153","emt153","emt154","emt154","emt155","emt155","emt156","emt156","emt157","emt157","emt158","emt158","emt159","emt159","emt160","emt160","emt161","emt161","emt162","emt162","emt163","emt163","emt164","emt164","emt165","emt165","emt166","emt166","emt167","emt167","emt168","emt168","emt169","emt169","emt170","emt170","emt171","emt171","emt172","emt172","emt173","emt173","emt174","emt174","emt175","emt175","emt176","emt176","emt177","emt177"}
gSoundEmitterPositions={{32.409367,0.763291,85.789154},{31.302898,0.877104,86.953789},{34.081791,0.884819,86.345802},{29.909565,0.874608,84.832825},{34.221581,0.903503,88.471359},{36.387196,0.748915,87.770821},{31.919975,0.885822,87.689659},{34.518475,0.871387,88.282944},{33.812298,0.784163,88.550003},{33.426971,0.883574,87.889641},{32.038807,0.886537,88.428612},{34.314945,0.877269,87.502419},{33.135868,4.485277,9.000000},{41.216854,2.092036,9.168571},{45.200317,2.109542,9.197345},{59.628204,14.359640,25.559540},{-2.172030,0.024887,5.881331},{-2.021329,0.023572,6.366313},{-1.886049,0.022392,7.027786},{-37.299896,-3.092352,-0.301831},{-2.009351,0.023466,1.896740},{-30.004936,-1.922854,-33.200272},{-2.569439,0.028355,1.660343},{-3.331035,0.035002,1.618744},{-33.924408,1.163024,-14.321043},{-4.007553,0.040906,1.596008},{-5.000021,0.049568,1.790151},{-1.847349,0.022053,8.136511},{44.999100,0.762421,34.718616},{50.598743,0.764441,20.508604},{54.572262,1.170261,61.177544},{37.949993,0.764038,19.008516},{58.630714,1.374350,74.352547},{31.634617,0.736797,4.103798},{56.343182,0.878572,40.925404},{59.890369,0.764495,58.115681},{32.409367,0.763291,85.789154},{31.302898,0.877104,86.953789},{34.081791,0.884819,86.345802},{29.909565,0.874608,84.832825},{34.221581,0.903503,88.471359},{36.387196,0.748915,87.770821},{31.919975,0.885822,87.689659},{38.035088,0.764704,64.322937},{34.518475,0.871387,88.282944},{33.812298,0.784163,88.550003},{33.426971,0.883574,87.889641},{32.038807,0.886537,88.428612},{34.314945,0.877269,87.502419},{40.325066,1.525926,25.316462},{48.465981,0.684985,-2.414492},{43.900242,0.763712,10.260333},{31.992788,0.763259,36.396969},{63.114479,2.045993,63.824738},{43.892822,0.762901,70.989799},{43.389244,1.306236,3.409392},{-0.329876,0.008811,6.651788},{-0.000000,-0.000000,-0.100000},{44.999100,0.762421,34.718616},{50.598743,0.764441,20.508604},{54.572262,1.170261,61.177544},{37.949993,0.764038,19.008516},{58.630714,1.374350,74.352547},{31.634617,0.736797,4.103798},{56.343182,0.878572,40.925404},{59.890369,0.764495,58.115681},{38.035088,0.764704,64.322937},{40.325066,1.525926,25.316462},{48.465981,0.684985,-2.414492},{43.900242,0.763712,10.260333},{31.992788,0.763259,36.396969},{63.114479,2.045993,63.824738},{43.892822,0.762901,70.989799},{43.389244,1.306236,3.409392},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000},{-0.000488,0.005937,-0.000000}}
gSoundEmitterSamples={"Data/Sounds/zombie_yes.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","","","","","","","Data/Sounds/colt45.ogg","Data/Sounds/rifle.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/footsteps_walk.ogg","Data/Sounds/footsteps_walk.ogg","Data/Sounds/footsteps_walk.ogg","Data/Sounds/footsteps_walk.ogg","Data/Sounds/footsteps_walk.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/footsteps_walk.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/footsteps_walk.ogg","Data/Sounds/footsteps_walk.ogg","Data/Sounds/footsteps_walk.ogg","Data/Sounds/footsteps_walk.ogg","Data/Sounds/footsteps_walk.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/rifle.ogg","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""}
gSoundEmitters={}
for i=1,#gSoundEmitterNames,1 do
	gSoundEmitters[i]=make(ig3d_sound_emitter, gSoundEmitterNames[i])
	setSound_emitterInfo(gSoundEmitters[i], IG3D_POSITION, gSoundEmitterPositions[i][1],gSoundEmitterPositions[i][2],gSoundEmitterPositions[i][3])
	setSound_emitterInfo(gSoundEmitters[i], IG3D_SAMPLE, gSoundEmitterSamples[i])
end
gNumSoundEmitters=#gSoundEmitterNames
gGroups={}
gNumGroups=0
gTextboxFonts={"Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png"}
gTextboxPositions={{8,8},{20,20},{20,20},{20,20},{20,20},{20,20},{20,20},{20,20},{20,20},{20,20},{20,20},{20,20},{20,20},{20,20},{20,20},{20,20}}
gTextboxSizes={12,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10}
gTextboxColors={{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000}}
gTextboxes={}
for i=1,#gTextboxFonts,1 do
	gTextboxes[i]=make(ig3d_text_box, gTextboxFonts[i])
	setText_boxInfo(gTextboxes[i], IG3D_POSITION, gTextboxPositions[i][1],gTextboxPositions[i][2])
	setText_boxInfo(gTextboxes[i], IG3D_SIZE, gTextboxSizes[i])
	setText_boxInfo(gTextboxes[i], IG3D_COLOR, gTextboxColors[i][1],gTextboxColors[i][2],gTextboxColors[i][3], gTextboxColors[i][4])
end
gNumTextboxes=#gTextboxFonts
setSceneInfo(IG3D_TINT_COLOR, 1.000000,1.000000,1.000000)
setSceneInfo(IG3D_FOG, true,0.700000,0.700000,0.700000,3.000000,24.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.600000,0.600000,0.600000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, 34.327629,1.157678,87.933052,1.000000)
setLightInfo(1, IG3D_AMBIENT, 0.100000,0.100000,0.100000,1.000000)
setLightInfo(1, IG3D_DIFFUSE, 0.400000,0.300000,0.400000,1.000000)
setLightInfo(1, IG3D_SPECULAR, -0.000000,-0.000000,-0.000000,-0.000000)
setLightInfo(1, IG3D_CONSTANT_ATTENUATION, 1.000000)
setLightInfo(1, IG3D_LINEAR_ATTENUATION, -0.000000)
setLightInfo(1, IG3D_QUADRATIC_ATTENUATION, 0.100000)
setLightInfo(1, IG3D_SPOTLIGHT, -0.000000,-0.000000,-0.000000,180.000000,-0.000000)
setLightInfo(2, IG3D_ENABLED, true)
setLightInfo(2, IG3D_POSITION, 34.327629,3.157678,87.933052,1.000000)
setLightInfo(2, IG3D_AMBIENT, 0.100000,0.100000,0.100000,1.000000)
setLightInfo(2, IG3D_DIFFUSE, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(2, IG3D_SPECULAR, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(2, IG3D_CONSTANT_ATTENUATION, 1.000000)
setLightInfo(2, IG3D_LINEAR_ATTENUATION, -0.000000)
setLightInfo(2, IG3D_QUADRATIC_ATTENUATION, 0.100000)
setLightInfo(2, IG3D_SPOTLIGHT, -0.000000,-0.000000,-0.000000,180.000000,-0.000000)
setLightInfo(3, IG3D_ENABLED, false)
setLightInfo(4, IG3D_ENABLED, false)
setLightInfo(5, IG3D_ENABLED, false)
setLightInfo(6, IG3D_ENABLED, false)
setLightInfo(7, IG3D_ENABLED, false)
setLightInfo(8, IG3D_ENABLED, true)
setLightInfo(8, IG3D_POSITION, 73.199997,39.200001,53.200001,-0.000000)
setLightInfo(8, IG3D_AMBIENT, 0.720000,1.000000,1.000000,1.000000)
setLightInfo(8, IG3D_DIFFUSE, -0.000000,-0.000000,-0.000000,1.000000)
setLightInfo(8, IG3D_SPECULAR, -0.000000,-0.000000,-0.000000,1.000000)
setLightInfo(8, IG3D_CONSTANT_ATTENUATION, 1.000000)
setLightInfo(8, IG3D_LINEAR_ATTENUATION, -0.000000)
setLightInfo(8, IG3D_QUADRATIC_ATTENUATION, -0.000000)
setLightInfo(8, IG3D_SPOTLIGHT, -0.000000,-0.000000,-0.000000,180.000000,-0.000000)
-- End of auto-script

function zfps_snipers_alley_game()
--dark()
 handle_zfps()
end



if ig3d_GetMode__i() == 4 then
dontPlaceRandomly=true
gGridSize=2
dofile(gameroot.."Data/Scripts/Games/ZFPS_Functions/ZFPS_Init.lua")
gTestLight=false
zfps_StartUpEmitters() ;--see ZFPS_Utilities.lua
dark = zfps_test_light_tint_fog
lit = zfps_test_light_tint_fog 
--dark()
game_func =handle_zfps
end



--[[
function zfps_check_game_end_condition()
	rts_update_living_and_dead_counts()
	if gNumZombies==0 then
		return ig3d_GetLevelName__s(),"\nYour legion of undead have been destroyed!!\n\nPress space bar to restart scenario"
	end
	if gNumHumans==0 then
			return "Data/Levels/ZFPS/ZFPS_Gauntlet","\nYou overtook the alley!\n\nPress space bar to continue."
	end
	return nil,""	
end
--]]
