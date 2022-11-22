-- Begin of auto-script
loadMesh("Data/Levels/ZFPS/ZFPS_LivingInn/ZFPS_LivingInn_level_mesh.wtf")
gSoundFiles={"Data/Sounds/bodyhit.ogg","Data/Sounds/skid.ogg","Data/Sounds/engine.ogg","Data/Sounds/colt45.ogg","Data/Sounds/rifle.ogg","Data/Sounds/zombie.ogg","Data/Sounds/male_scream1.ogg","Data/Sounds/male_scream2.ogg","Data/Sounds/female_scream1.ogg","Data/Sounds/female_scream2.ogg","Data/Sounds/zombie_eating.ogg","Data/Sounds/zombie_yes.ogg","Data/Sounds/zombie_idle1.ogg","Data/Sounds/zombie_idle2.ogg","Data/Sounds/zombie_idle3.ogg","Data/Sounds/zombie_idle4.ogg","Data/Sounds/footsteps_walk.ogg","Data/Sounds/footsteps_run.ogg","Data/Sounds/bodyhitfloor.ogg","Data/Sounds/male_eaten.ogg","Data/Sounds/female_eaten.ogg","Data/Sounds/no_way.ogg","Data/Sounds/punchsolid.ogg","Data/Sounds/glassbreaking.ogg","Data/Sounds/grenade.ogg","Data/Sounds/dropgrenade.ogg","Data/Sounds/throw_whoosh.ogg","Data/Sounds/drivingrock.ogg","Data/Sounds/brakeandcrash.ogg"}
for i=1,#gSoundFiles,1 do
	loadSound(gSoundFiles[i])
end
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"},{"Data/FontPngs/Shlop32_1.png","Data/FontPngs/Shlop32_2.png"},{"Data/FontPngs/CRAMPS32_1.png","Data/FontPngs/CRAMPS32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, 45.881348, 1.438412, 97.360054)
setCameraInfo(IG3D_ROTATION, 3.999965, -3.992859, -0.000000)
gObjects={}
gObjectWTFs={"Misc/selectionRect.wtf","Reticule/crosshair.wtf","Cubes/kiste.wtf","Characters/jackytrueboneszombie.wtf","Characters/thug_fatjack.wtf","Characters/thug_AJ.wtf","Characters/tomdrinman1_3k.wtf","Characters/tomdrinwoman4_3k.wtf","Characters/thug_fatjack.wtf","Characters/thug_miguel.wtf","Characters/tomdrinwoman5_3k.wtf","Characters/chick.wtf","Weapons/gloc.wtf","Tools/mallet228.wtf","Tools/broom.wtf","Tools/pickaxe128.wtf","Tools/snowshovel.wtf","Building_parts/hotelwindowbreak.wtf","Building_parts/hotelwindowbreak.wtf","Building_parts/hotelwindowbreak.wtf","Building_parts/hotelwindowbreak.wtf","Building_parts/hotelwindowbreak.wtf","Building_parts/hotelwindowbreak.wtf","Building_parts/hoteldoor.wtf","Building_parts/hoteldoor.wtf","Building_parts/hoteldoor.wtf","Building_parts/hoteldoor.wtf","Building_parts/hoteldoor.wtf","Building_parts/hoteldoor.wtf","Vehicles_land/threevehicleaccident.wtf","Vehicles_land/riocar520s.wtf","Vehicles_land/Truck6wheeler.wtf","Vehicles_land/Truck6wheeler.wtf","Building_parts/door1x1metal.wtf","Characters/tomdrinman5_3ksnowed.wtf","Characters/tomdrinman4_3kzombie.wtf","Characters/tomdrinman1is5police.wtf","Weapons/gloc.wtf","Characters/thug_mustafa.wtf","Weapons/bostaff84.wtf","Weapons/leadpipe84.wtf","Misc/zfpsmainmenu.wtf"}
gObjectNames={"selectionRect1","crosshair1","playerbox","zombiethug_AJ1","human2","human3","human4victim1","human5","human6","human7","human8","human10","gun2","melee1","melee2","melee3","melee4","hotelwindowbreak1","hotelwindowbreak2","hotelwindowbreak3","hotelwindowbreak4","hotelwindowbreak5","hotelwindowbreak6","hoteldoor1","hoteldoor2","hoteldoor3","hoteldoor4","hoteldoor5","hoteldoor6","scenery1","riocarscenery1","Truckatdoorscenery1","Truckscenery2","levelexit1","tomdrinman5_3ksnowed1","tomdrinman4_3kzombie1","tomdrinman1is5police1","gloc1","thug_mustafa1","bostaff841","leadpipe841","zfpsmainmenu1"}
gObjectPositions={{70.923073,-10000.088867,87.259117},{0.000000,0.000000,-0.100000},{45.884392,0.274246,97.174767},{44.425922,0.519221,97.593521},{73.488525,0.517879,86.953835},{70.499512,0.521023,86.751488},{71.383553,0.634249,78.830467},{71.412323,0.645321,88.221092},{60.807667,0.521605,85.727783},{70.697556,0.520142,82.732018},{71.962334,0.657955,81.792686},{70.151764,0.649336,80.225517},{27.352743,0.873329,73.670898},{71.432083,0.861885,78.963806},{70.556366,0.876035,82.655449},{73.524162,0.534755,87.058632},{72.005760,0.589671,81.900330},{67.090958,0.950000,78.112755},{67.120529,0.950000,82.067459},{67.075836,1.000000,86.098442},{74.950600,1.000000,78.094635},{74.921890,0.970916,82.076576},{74.867546,0.970916,86.129692},{67.098625,0.750000,79.985023},{67.076248,0.800000,84.003387},{67.064102,0.750000,88.058678},{74.880569,0.750000,79.999832},{74.944252,0.770916,83.997803},{74.890854,0.770916,88.040733},{46.128586,1.281389,103.198822},{33.327034,0.417496,82.373840},{33.555542,1.260242,84.576599},{42.987503,1.360242,80.238762},{28.455408,0.699997,75.241257},{47.923595,0.636863,97.951141},{44.129208,0.641227,98.219353},{27.257452,0.521120,73.602333},{70.518211,0.563892,86.630852},{63.946869,0.520835,87.072319},{71.472252,0.872892,88.349831},{64.050735,0.571683,86.996811},{45.787556,1.344226,98.703720}}
gObjectRotations={{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{-0.176253,-49.529354,0.193639},{-0.067003,69.184242,-0.005118},{0.210246,89.783295,0.000000},{179.948410,-62.297276,179.975113},{-0.014692,87.042091,-0.069421},{171.750519,85.825523,172.899017},{179.357971,-63.582150,179.996338},{-0.035050,-45.728207,-0.289292},{2.529451,85.282623,2.577184},{179.549667,-62.352085,179.800156},{17.441008,-49.203232,-51.178207},{74.000778,-59.020069,-98.412590},{-176.406937,39.566185,-138.938354},{157.649536,-4.444597,139.938736},{154.610382,-1.121093,140.344727},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{-2.944702,1.100776,-1.556191},{179.786774,87.082413,179.895782},{-179.929657,-86.595383,-179.997650},{-179.954620,-25.584309,179.989700},{0.000000,0.000000,0.000000},{0.020327,-68.500450,-0.082185},{179.752762,87.000755,179.696121},{-179.899719,59.500591,-179.974319},{-40.299889,-16.546072,41.714722},{179.919571,-21.500082,-179.986740},{60.241932,-58.722355,-85.400482},{-76.829483,-43.097477,60.876369},{0.000000,0.000000,0.000000}}
gObjectSizes={{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{50.000000,50.000000,50.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000}}
gObjectColls={false,false,true,true,true,true,true,true,true,true,true,true,false,false,false,false,false,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,false,true,false,false,true}
gObjectHUDs={false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false}
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
gParticleNamesAndEMTs={{"Bullets","Data/Emitters/pistol.emt"},{"Grenade","Data/Emitters/grenade.emt"},{"TireTraces","Data/Emitters/tiretrace.emt"},{"Blood","Data/Emitters/blood.emt"},{"MoreBlood","Data/Emitters/blood2.emt"},{"MuzzleFlash","Data/Emitters/muzzleflash.emt"},{"Unitmarker","Data/Emitters/unitmarker.emt"},{"Unitmarker2","Data/Emitters/unitmarker2.emt"},{"fpsgun","Data/Emitters/slowbullet.emt"},{"bloodonfloor","Data/Emitters/bloodonfloor.emt"},{"snow4x4001","Data/Emitters/snow4x4.emt"},{"snow4x4002","Data/Emitters/snow4x4.emt"},{"snow4x4003","Data/Emitters/snow4x4.emt"},{"snow4x4004","Data/Emitters/snow4x4short.emt"},{"snow4x4005","Data/Emitters/snow4x4.emt"},{"fire001","Data/Emitters/firebig.emt"},{"furniturechair178001","Data/Emitters/chair178.emt"},{"furniturenightstand1001","Data/Emitters/nightstand1.emt"},{"drumbarrel240debris1emt","Data/Emitters/Containers/drumbarrel240.emt"},{"drumbarrel240debris2emt","Data/Emitters/Containers/drumbarrel240.emt"},{"drumbarrel240debris3emt","Data/Emitters/Containers/drumbarrel240.emt"},{"drumbarrelopen234debrisy1emt","Data/Emitters/Containers/drumbarrelopen234.emt"},{"drumbarrellid56debris1emt","Data/Emitters/Containers/drumbarrellid56.emt"},{"coffeetable1181emt","Data/Emitters/Furniture/coffeetable118.emt"},{"chair581emt","Data/Emitters/Furniture/chair58.emt"},{"bed4061emt","Data/Emitters/Furniture/bed406.emt"},{"bed4062emt","Data/Emitters/Furniture/bed406.emt"},{"officechair1431emt","Data/Emitters/Furniture/officechair143.emt"},{"officechair1432emt","Data/Emitters/Furniture/officechair143.emt"},{"table521emt","Data/Emitters/Furniture/table52.emt"},{"tableblack501emt","Data/Emitters/Furniture/tableblack50.emt"},{"table1261emt","Data/Emitters/Furniture/table126.emt"},{"table522emt","Data/Emitters/Furniture/table52.emt"},{"bed4063emt","Data/Emitters/Furniture/bed406.emt"},{"chairblack822emt","Data/Emitters/Furniture/chairblack82.emt"},{"chairblack823emt","Data/Emitters/Furniture/chairblack82.emt"},{"table501emt","Data/Emitters/Furniture/table50.emt"},{"bed4064emt","Data/Emitters/Furniture/bed406.emt"},{"bed4065emt","Data/Emitters/Furniture/bed406.emt"},{"deskL521emt","Data/Emitters/Furniture/deskL52.emt"},{"officechair1433emt","Data/Emitters/Furniture/officechair143.emt"},{"table502emt","Data/Emitters/Furniture/table50.emt"},{"officechair1434emt","Data/Emitters/Furniture/officechair143.emt"},{"barrelopen003","Data/Emitters/barrelopen.emt"},{"barrelli002","Data/Emitters/Containers/barrellid.emt"},{"barrelli003","Data/Emitters/Containers/barrellid.emt"},{"barrelopen004","Data/Emitters/barrelopen.emt"},{"Explosion","Data/Emitters/grenadeexplosion.emt"},{"barrel010","Data/Emitters/barrel.emt"},{"barrel011","Data/Emitters/barrel.emt"},{"crate0001001","Data/Emitters/crate0001.emt"},{"crate0002001","Data/Emitters/crate0002.emt"},{"crate0002002","Data/Emitters/crate0002.emt"},{"crate0003001","Data/Emitters/crate0003.emt"},{"crate0004001","Data/Emitters/crate0004.emt"},{"barrel012","Data/Emitters/barrel.emt"},{"barrel013","Data/Emitters/barrel.emt"},{"barrel014","Data/Emitters/barrel.emt"},{"barrel015","Data/Emitters/barrel.emt"},{"barrel016","Data/Emitters/barrel.emt"},{"barrel017","Data/Emitters/barrel.emt"},{"crate0004002","Data/Emitters/crate0004.emt"},{"crate0004003","Data/Emitters/crate0004.emt"},{"crate0004004","Data/Emitters/crate0004.emt"}}
gParticlePositions={{-34.501820,-2.745420,-11.845739},{-34.501820,-2.745420,-11.845739},{-185.062057,-2.428456,-0.457016},{-29.986479,-2.190553,-33.200272},{-0.373143,0.522658,-0.824832},{-34.501820,-2.745420,-11.845739},{-34.501820,-2.745420,-11.845739},{44.930031,0.074673,97.431160},{-34.501820,-2.745420,-11.845739},{-34.501820,-2.745420,-11.845739},{46.040253,1.284368,80.487755},{36.040253,1.284368,60.487755},{54.040253,1.284368,60.487755},{66.040253,1.284368,60.487755},{83.757149,1.284368,71.944481},{46.581104,1.281389,104.199265},{-0.662137,0.000000,0.117214},{67.381844,0.900000,85.531639},{46.716015,2.366843,98.100273},{44.187099,2.154889,96.240013},{47.199776,1.604889,95.527122},{47.591766,0.704890,97.399467},{45.840843,1.166971,97.006081},{68.370911,0.291965,86.334091},{68.255241,0.444173,85.550819},{70.003105,0.431901,85.764908},{70.074699,0.539971,83.822342},{67.882919,0.557787,81.506454},{69.409050,0.569729,81.506485},{68.794189,0.467588,82.347038},{68.428200,0.413422,80.037071},{70.094246,0.394437,78.210716},{67.788261,0.353129,77.453545},{72.098961,0.584608,78.138016},{73.146637,0.607610,79.340576},{73.606537,0.607610,80.239090},{72.692963,0.594144,79.909088},{72.637398,0.515398,82.988464},{71.882645,0.558904,87.836853},{72.295120,0.448674,85.865463},{72.656776,0.822040,86.316109},{73.918106,0.553114,85.966454},{74.186424,0.550577,86.522614},{46.293736,2.455521,97.579201},{45.785721,2.484808,97.571449},{46.937351,1.489610,96.783295},{46.304741,1.637479,96.774803},{59.900326,1.143448,86.009842},{47.930714,0.972773,101.460930},{46.824997,1.083486,100.499908},{36.324703,1.088194,76.690414},{35.400997,1.168300,76.878914},{36.091560,1.071200,77.894814},{31.068521,0.581605,73.661812},{32.309166,0.465819,74.249130},{28.891460,1.383007,73.512840},{29.073151,1.326406,72.653671},{30.759836,1.304000,72.994385},{30.490561,1.388708,73.976830},{35.077862,1.566722,79.862183},{34.825146,1.540766,78.456451},{76.213394,0.782198,75.899742},{68.226631,1.150277,75.744751},{67.642220,1.487306,89.749771}}
gParticleRotations={{-9.058784,168.954941,0.000000},{-9.058784,168.954941,0.000000},{17.067825,64.048012,0.000000},{-29.986481,-2.190553,-33.200272},{-0.182363,0.522658,-0.518280},{-0.182363,0.522658,-0.518280},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,90.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,-121.000000,-34.500000},{-25.500000,30.500002,35.000000},{23.500000,0.000000,-176.000000},{-93.500961,-4.979620,105.435585},{-55.000000,-21.500000,0.000000},{0.000000,-2.081683,0.000000},{0.000000,-7.917366,0.000000},{0.000000,87.501190,0.000000},{0.000000,86.088234,0.000000},{0.000000,0.000000,0.000000},{0.000000,-9.000753,0.000000},{0.000000,0.000000,0.000000},{0.000000,81.001060,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,-1.999488,0.000000},{0.000000,0.000000,0.000000},{0.000000,-88.418480,0.000000},{0.000000,0.500460,0.000000},{0.000000,-89.581757,0.000000},{0.000000,0.000000,0.000000},{0.000000,-1.079287,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{-86.500000,0.000000,13.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{-30.000000,0.000000,56.000000},{-36.000000,0.000000,43.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000}}
gParticleEmitters={}
for i=1,#gParticleNamesAndEMTs,1 do
	gParticleEmitters[i]=make(ig3d_particle_emitter, gParticleNamesAndEMTs[i][1], gParticleNamesAndEMTs[i][2])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_POSITION, gParticlePositions[i][1],gParticlePositions[i][2],gParticlePositions[i][3])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_ROTATION, gParticleRotations[i][1],gParticleRotations[i][2],gParticleRotations[i][3])
end
gNumParticleEmitters=#gParticleNamesAndEMTs
gSoundEmitterNames={"emt1","emt2","emt3","emt4","emt5","emt6","emt7","emt8","emt9","emt10","emt11","emt12","emt13","emt14","emt15","emt16","emt17","emt18","emt19","emt20","emt21","emt22","emt23","emt24","emt25","emt26","emt27","emt28","emt29","emt30","emt31","emt32","emt33","emt34","emt35","emt36","emt37","emt38","emt39","emt40","emt41","emt42","emt43","emt44","emt45","emt46","emt47","emt48","emt49","emt50","emt51","emt52","emt53","emt54","emt55","emt56","emt57","emt58","emt59","emt60","emt61","emt61","emt62","emt62","emt63","emt63","emt64","emt64","emt65","emt65","emt66","emt66","emt67","emt67","emt68","emt68","emt69","emt69","emt70","emt70","emt71","emt71","emt72","emt72","emt73","emt73","emt74","emt74","emt75","emt75","emt76","emt76","emt77","emt77","emt78","emt78","emt79","emt79","emt80","emt80","emt81","emt81","emt82","emt82","emt83","emt83","emt84","emt84","emt85","emt85","emt86","emt86","emt87","emt87","emt88","emt88","emt89","emt89","emt90","emt90","emt91","emt91","emt92","emt92","emt93","emt93","emt94","emt94","emt95","emt95","emt96","emt96","emt97","emt97","emt98","emt98","emt99","emt99","emt100","emt100","emt101","emt101","emt102","emt102","emt103","emt103","emt104","emt104","emt105","emt105","emt106","emt106","emt107","emt107","emt108","emt108","emt109","emt109","emt110","emt110","emt111","emt111","emt112","emt112","emt113","emt113","emt114","emt114","emt115","emt115","emt116","emt116","emt117","emt117","emt118","emt118","emt119","emt119","emt120","emt120","emt121","emt121","emt122","emt122","emt123","emt123","emt124","emt124","emt125","emt125","emt126","emt126","emt127","emt127","emt128","emt128","emt129","emt129","emt130","emt130","emt131","emt131","emt132","emt132","emt133","emt133","emt134","emt134","emt135","emt135","emt136","emt136","emt137","emt137","emt138","emt138","emt139","emt139","emt140","emt140","emt141","emt141","emt142","emt142","emt143","emt143","emt144","emt144","emt145","emt145","emt146","emt146","emt147","emt147","emt148","emt148","emt149","emt149","emt150","emt150","emt151","emt151","emt152","emt152","emt153","emt153"}
gSoundEmitterPositions={{44.779774,0.519221,97.905075},{47.980968,0.636863,98.188843},{44.129208,0.641227,98.219353},{67.090958,0.950000,78.112755},{67.120529,0.950000,82.067459},{67.075836,1.000000,86.098442},{74.950600,1.000000,78.094635},{74.921890,0.970916,82.076576},{74.867546,0.970916,86.129692},{67.098625,0.750000,79.985023},{67.076248,0.800000,84.003387},{67.064102,0.750000,88.058678},{74.880569,0.750000,79.999832},{74.944252,0.770916,83.997803},{74.890854,0.770916,88.040733},{33.555542,1.260242,84.576599},{35.795223,0.644796,82.054932},{46.400356,0.516672,88.258530},{48.000065,0.516540,89.909554},{-37.270939,-3.423660,-0.301831},{44.779774,0.519221,97.905075},{73.488525,0.517879,86.953835},{70.499512,0.521023,86.751488},{71.383553,0.634249,78.830467},{71.412323,0.645321,88.221092},{60.807667,0.521605,85.727783},{70.697556,0.520142,82.732018},{71.962334,0.657955,81.792686},{70.151764,0.649336,80.225517},{47.980968,0.636863,98.188843},{44.129208,0.641227,98.219353},{27.257452,0.521120,73.602333},{63.946869,0.520835,87.072319},{-1.836934,0.000000,10.522897},{0.000000,0.000000,-0.100000},{73.488525,0.517879,86.953835},{70.499512,0.521023,86.751488},{71.383553,0.634249,78.830467},{71.412323,0.645321,88.221092},{60.807667,0.521605,85.727783},{70.697556,0.520142,82.732018},{71.962334,0.657955,81.792686},{70.151764,0.649336,80.225517},{27.257452,0.521120,73.602333},{63.946869,0.520835,87.072319},{-2.148632,0.000000,15.640233},{-2.103099,0.000000,17.291697},{-2.182349,0.000000,16.747002},{-2.027389,0.000000,17.991289},{-1.914886,0.000000,18.929188},{-1.887625,0.000000,19.839075},{-1.607615,0.000000,20.566446},{-1.705121,0.000000,21.748552},{-20.684217,0.000000,1.312660},{-0.209051,-0.014542,17.709719},{-1.354467,0.518953,12.465975},{-0.902818,0.574555,6.651788},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000}}
gSoundEmitterSamples={"Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","","","","","","","","","","","","","","","","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/rifle.ogg","","","","","","","","","","","","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""}
gSoundEmitters={}
for i=1,#gSoundEmitterNames,1 do
	gSoundEmitters[i]=make(ig3d_sound_emitter, gSoundEmitterNames[i])
	setSound_emitterInfo(gSoundEmitters[i], IG3D_POSITION, gSoundEmitterPositions[i][1],gSoundEmitterPositions[i][2],gSoundEmitterPositions[i][3])
	setSound_emitterInfo(gSoundEmitters[i], IG3D_SAMPLE, gSoundEmitterSamples[i])
end
gNumSoundEmitters=#gSoundEmitterNames
gGroups={}
gNumGroups=0
gTextboxFonts={"Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/Shlop32_1.png","Data/FontPngs/Shlop32_1.png","Data/FontPngs/Shlop32_1.png","Data/FontPngs/Shlop32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/Shlop32_1.png","Data/FontPngs/Shlop32_1.png","Data/FontPngs/Shlop32_1.png","Data/FontPngs/Shlop32_1.png"}
gTextboxPositions={{8,8},{56,26},{50,36},{50,24},{50,48},{20,20},{10,202},{10,202},{10,202},{10,202},{10,202},{20,20},{20,20},{20,20}}
gTextboxSizes={12,12,12,12,12,10,32,32,32,32,32,10,10,10}
gTextboxColors={{1.000000,1.000000,1.000000,1.000000},{0.000000,0.000000,1.000000,0.000000},{1.000000,0.000000,0.000000,0.000000},{0.000000,1.000000,1.000000,0.000000},{0.000000,1.000000,0.000000,0.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000}}
gTextboxes={}
for i=1,#gTextboxFonts,1 do
	gTextboxes[i]=make(ig3d_text_box, gTextboxFonts[i])
	setText_boxInfo(gTextboxes[i], IG3D_POSITION, gTextboxPositions[i][1],gTextboxPositions[i][2])
	setText_boxInfo(gTextboxes[i], IG3D_SIZE, gTextboxSizes[i])
	setText_boxInfo(gTextboxes[i], IG3D_COLOR, gTextboxColors[i][1],gTextboxColors[i][2],gTextboxColors[i][3], gTextboxColors[i][4])
end
gNumTextboxes=#gTextboxFonts
setSceneInfo(IG3D_TINT_COLOR, 1.000000,1.000000,1.000000)
setSceneInfo(IG3D_FOG, false,0.100000,0.000000,0.000000,7.000000,10.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 1.000000,1.000000,1.000000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, 72.000000,2.924348,74.000000,1.000000)
setLightInfo(1, IG3D_AMBIENT, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(1, IG3D_DIFFUSE, 0.700000,0.700000,0.700000,1.000000)
setLightInfo(1, IG3D_SPECULAR, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(1, IG3D_CONSTANT_ATTENUATION, 0.700000)
setLightInfo(1, IG3D_LINEAR_ATTENUATION, 0.600000)
setLightInfo(1, IG3D_QUADRATIC_ATTENUATION, 0.010000)
setLightInfo(1, IG3D_SPOTLIGHT, 0.000000,0.000000,0.000000,180.000000,0.000000)
setLightInfo(2, IG3D_ENABLED, true)
setLightInfo(2, IG3D_POSITION, 45.884392,4.924246,97.174767,1.000000)
setLightInfo(2, IG3D_AMBIENT, 0.100000,0.100000,0.100000,1.000000)
setLightInfo(2, IG3D_DIFFUSE, 0.200000,0.200000,0.200000,1.000000)
setLightInfo(2, IG3D_SPECULAR, -0.200000,-0.200000,2.000000,1.000000)
setLightInfo(2, IG3D_CONSTANT_ATTENUATION, 0.050000)
setLightInfo(2, IG3D_LINEAR_ATTENUATION, 0.020000)
setLightInfo(2, IG3D_QUADRATIC_ATTENUATION, 0.008000)
setLightInfo(2, IG3D_SPOTLIGHT, 0.000000,0.000000,0.000000,160.000000,0.800000)
setLightInfo(3, IG3D_ENABLED, false)
setLightInfo(4, IG3D_ENABLED, true)
setLightInfo(4, IG3D_POSITION, 43.884392,1.024246,95.174767,1.000000)
setLightInfo(4, IG3D_AMBIENT, 0.400000,0.400000,0.500000,1.000000)
setLightInfo(4, IG3D_DIFFUSE, 0.312000,0.276000,0.116000,1.000000)
setLightInfo(4, IG3D_SPECULAR, 0.844000,1.000000,0.496000,1.000000)
setLightInfo(4, IG3D_CONSTANT_ATTENUATION, 0.500000)
setLightInfo(4, IG3D_LINEAR_ATTENUATION, 0.036000)
setLightInfo(4, IG3D_QUADRATIC_ATTENUATION, 0.004000)
setLightInfo(4, IG3D_SPOTLIGHT, 0.000000,0.000000,0.000000,180.000000,0.000000)
setLightInfo(5, IG3D_ENABLED, false)
setLightInfo(6, IG3D_ENABLED, false)
setLightInfo(7, IG3D_ENABLED, false)
setLightInfo(8, IG3D_ENABLED, false)
-- End of auto-script


truckfire=  get(ig3d_particle_emitter, "fire001")
setParticle_emitterInfo(truckfire, IG3D_START)



--zfps_clear_textboxes() -- ; see ZFPS_Utilities.lua
if ig3d_GetMode__i() == 4 then
dontPlaceRandomly=true
gGridSize=2
dofile(gameroot.."Data/Scripts/Games/ZFPS_Functions/ZFPS_Init.lua")
zfps_StartUpEmitters() ;--see ZFPS_Utilities.lua
ZFPSLevel1Lighting() -- ;see ZFPS_Lights.lua
lit = ZFPSWorkLighting 
dark =zfps_FourLight
dark()
gTextualTimer=0
game_func = handle_zfps
end





function zfps_check_game_end_condition()
	rts_update_living_and_dead_counts()
	if gNumZombies==0 then
		return ig3d_GetLevelName__s(),"\nYour legion of undead have been destroyed!!\n\nPress space bar to restart scenario"
	end
	if gNumHumans==0 then
		return "Data/Levels/ZFPS/ZFPS_PonchoCo","\nThe living have been devoured!!\n\nGo Zombies Go!!\n\nPress space bar to raid Poncho Co."
	end
	return nil,""	
end





--game_func=handle_zfps_astartest

function move_camera_to_poncho_co_building()
	if gObjects[playerBox].order then
		gObjects[playerBox].order.fn(gObjects[playerBox], gObjects[playerBox].order.target)
		do_task(gObjects[playerBox])
		x,y,z=getObjectInfo(playerBox, IG3D_POSITION)
		y=y+0.65
		setCameraInfo(IG3D_POSITION, x,y,z)
		setCameraInfo(IG3D_ROTATION, getObjectInfo(playerBox, IG3D_ROTATION))
	end
end



-- auto camera move 
--[[
		zfps_handle_camera=move_camera_to_poncho_co_building
		local cx,cy,cz=getObjectInfo(gObjects[playerBox].cObj, IG3D_POSITION)
		local lx,ly,lz=getObjectInfo(get(ig3d_object, "levelexit1"), IG3D_POSITION)
		lz=lz-1
		lx=lx+4
		if vecLength(cx-lx, cy-ly, cz-lz)<2.5 then
			return "Data/Levels/ZFPS/ZFPS_PonchoCo","\nThe living have been devoured!!\n\nPress space bar to continue."
		else
			gObjects[playerBox].mayRush=true
			gObjects[playerBox].pth,success=generateAStarPathBetweenPositions(nil, cx, cy, cz, lx,ly,lz,0)
			gObjects[playerBox].order={fn= run_on_path, target=nil, x=lx, y=ly, z=lz}
			return nil,"\nMoving to the Poncho Co. building..."
		end
		--]]




