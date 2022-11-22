-- Begin of auto-script
loadMesh("letscrash.wtf")

gSoundFiles={"Data/Sounds/bodyhit.ogg","Data/Sounds/skid.ogg","Data/Sounds/engine.ogg","Data/Sounds/colt45.ogg","Data/Sounds/rifle.ogg","Data/Sounds/zombie.ogg","Data/Sounds/male_scream1.ogg","Data/Sounds/male_scream2.ogg","Data/Sounds/female_scream1.ogg","Data/Sounds/female_scream2.ogg","Data/Sounds/zombie_eating.ogg","Data/Sounds/zombie_yes.ogg","Data/Sounds/zombie_idle1.ogg","Data/Sounds/zombie_idle2.ogg","Data/Sounds/zombie_idle3.ogg","Data/Sounds/zombie_idle4.ogg","Data/Sounds/footsteps_walk.ogg","Data/Sounds/footsteps_run.ogg","Data/Sounds/bodyhitfloor.ogg","Data/Sounds/male_eaten.ogg","Data/Sounds/female_eaten.ogg","Data/Sounds/no_way.ogg"}
for i=1,#gSoundFiles,1 do
	loadSound(gSoundFiles[i])
end
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"},{"Data/FontPngs/Shlop32_1.png","Data/FontPngs/Shlop32_2.png"},{"Data/FontPngs/CRAMPS32_1.png","Data/FontPngs/CRAMPS32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, 44.115448, 2.302702, 83.798988)
setCameraInfo(IG3D_ROTATION, 21.333370, 22.563583, -0.000000)
gObjects={}
gObjectWTFs={"Misc/selectionRect.wtf","Reticule/crosshair.wtf","Cubes/kiste.wtf","Characters/jackytrueboneszombie.wtf","Characters/thug_fatjack.wtf","Characters/thug_AJ.wtf","Characters/tomdrinman1_3k.wtf","Characters/tomdrinwoman4_3k.wtf","Characters/thug_fatjack.wtf","Characters/thug_miguel.wtf","Characters/tomdrinwoman5_3k.wtf","Characters/tomdrinwoman4_3k.wtf","Weapons/gloc.wtf","Tools/mallet228.wtf","Tools/broom.wtf","Tools/baton2.wtf","Tools/snowshovel.wtf","Building_parts/hotelwindowbreak.wtf","Building_parts/hotelwindowbreak.wtf","Building_parts/hotelwindowbreak.wtf","Building_parts/hotelwindowbreak.wtf","Building_parts/hotelwindowbreak.wtf","Building_parts/hotelwindowbreak.wtf","Building_parts/hoteldoorbreak.wtf","Building_parts/hoteldoorbreak.wtf","Building_parts/hoteldoorbreak.wtf","Building_parts/hoteldoorbreak.wtf","Building_parts/hoteldoorbreak.wtf","Building_parts/hoteldoorbreak.wtf","Vehicles_land/threevehicleaccident.wtf","Vehicles_land/riocar520s.wtf","Vehicles_land/Truck6wheeler.wtf","Vehicles_land/Truck6wheeler.wtf","Building_parts/door1x1metal.wtf"}
gObjectNames={"selectionRect1","crosshair1","playerbox","zombiethug_AJ1","human2","human3","human4victim1","human5","human6","human7","human8","human10","gun2","melee1","melee2","melee3","melee4","hotelwindowbreak1","hotelwindowbreak2","hotelwindowbreak3","hotelwindowbreak4","hotelwindowbreak5","hotelwindowbreak6","hoteldoorbreak1","hoteldoorbreak2","hoteldoorbreak3","hoteldoorbreak4","hoteldoorbreak5","hoteldoorbreak6","scenery1","riocarscenery1","Truckatdoorscenery1","Truckscenery2","levelexit1"}
gObjectPositions={{70.923073,-214.435165,87.259117},{0.000000,0.000000,-0.100000},{46.040253,0.274553,95.487755},{45.979527,0.823169,96.881126},{73.711632,0.921780,82.586067},{68.144936,0.818020,86.499321},{38.997604,0.736581,73.468239},{32.881477,0.646245,83.700218},{32.936859,1.265142,80.757675},{68.529633,0.833563,82.717178},{73.901436,0.996158,83.721725},{68.286926,0.775672,83.788002},{68.963966,0.865437,79.865646},{56.194321,1.538351,75.283005},{63.802345,2.243135,81.964218},{71.849373,0.871583,81.599838},{77.386002,0.823956,75.996292},{67.090958,0.950000,78.112755},{67.120537,0.950000,82.173439},{67.075836,1.000000,86.098442},{74.950600,1.000000,78.094635},{74.921890,0.970916,82.026573},{74.867546,0.920916,86.079689},{67.098625,0.750000,80.035027},{67.076248,0.800000,84.003387},{67.064102,0.800000,88.058678},{74.880569,0.750000,79.999832},{74.944252,0.770916,83.997803},{74.890854,0.770916,88.040733},{45.750603,1.281389,102.836708},{33.327034,0.417496,82.373840},{39.925461,1.260242,77.940643},{28.318014,1.360242,70.689163},{28.461771,0.699997,75.156006}}
gObjectRotations={{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{-0.001525,-0.000005,-0.000009},{179.999725,-0.594790,-179.947662},{178.174622,87.094711,178.008957},{179.956375,-58.999134,-179.998047},{-0.012965,85.225082,-0.081439},{178.466858,44.078300,179.317093},{179.402374,66.081665,179.997986},{-0.111832,-26.187330,-0.209537},{179.824173,43.774090,179.702744},{179.639572,-63.964870,179.737656},{-0.468846,52.465111,0.163917},{-1.490730,-41.578270,0.653230},{179.983658,-0.818842,-171.519867},{-179.878967,22.096100,179.889648},{-1.490960,-41.578255,0.654086},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000},{-2.944702,1.100776,-1.556191},{179.786774,87.082413,179.895782},{-179.929657,-86.595383,-179.997650},{179.847916,-82.916039,-179.842789},{0.000000,-0.000000,0.000000}}
gObjectSizes={{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{50.000000,50.000000,50.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000}}
gObjectColls={false,false,true,true,true,true,true,true,true,true,true,true, true, true, true, true, true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true}
gObjectHUDs={false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false}
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
gParticleNamesAndEMTs={{"Bullets","Data/Emitters/pistol.emt"},{"TireTraces","Data/Emitters/tiretrace.emt"},{"Blood","Data/Emitters/blood.emt"},{"MoreBlood","Data/Emitters/blood2.emt"},{"Muzzleflash","Data/Emitters/muzzleflash.emt"},{"Unitmarker","Data/Emitters/unitmarker.emt"},{"Unitmarker2","Data/Emitters/unitmarker2.emt"},{"fpsgun","Data/Emitters/slowbullet.emt"},{"bloodonfloor","Data/Emitters/bloodonfloor.emt"},{"snow4x4001","Data/Emitters/snow4x4.emt"},{"snow4x4002","Data/Emitters/snow4x4.emt"},{"snow4x4003","Data/Emitters/snow4x4.emt"},{"snow4x4004","Data/Emitters/snow4x4short.emt"},{"snow4x4005","Data/Emitters/snow4x4.emt"},{"fire001","Data/Emitters/firebig.emt"},{"furniturecouch001","Data/Emitters/couch.emt"},{"furniturechair178001","Data/Emitters/chair178.emt"},{"furniturenightstand1001","Data/Emitters/nightstand1.emt"},{"furniturenightstand2001","Data/Emitters/nightstand2.emt"},{"furniturenightstand3001","Data/Emitters/nightstand3.emt"},{"furnituretablenchairs378001","Data/Emitters/tablenchairs378.emt"},{"furnituretvtube1001","Data/Emitters/tvtube1.emt"},{"drumbarrel240debris1emt","Data/Emitters/Containers/drumbarrel240.emt"},{"drumbarrel240debris2emt","Data/Emitters/Containers/drumbarrel240.emt"},{"drumbarrel240debris3emt","Data/Emitters/Containers/drumbarrel240.emt"},{"drumbarrelopen234debrisy1emt","Data/Emitters/Containers/drumbarrelopen234.emt"},{"drumbarrellid56debris1emt","Data/Emitters/Containers/drumbarrellid56.emt"}}
gParticlePositions={{-34.501820,-2.745420,-11.845739},{-185.062057,-2.428456,-0.457016},{-29.986479,-2.190553,-33.200272},{-0.373143,0.522658,-0.824832},{-34.501820,-2.745420,-11.845739},{-34.501820,-2.745420,-11.845739},{46.040253,0.274553,95.487755},{-34.501820,-2.745420,-11.845739},{-34.501820,-2.745420,-11.845739},{46.040253,1.284368,80.487755},{36.040253,1.284368,60.487755},{54.040253,1.284368,60.487755},{66.040253,1.284368,60.487755},{83.757149,1.284368,71.944481},{46.581104,1.281389,104.199265},{65.208908,0.900000,74.403427},{-0.662137,0.000000,0.117214},{60.200409,0.900000,77.271049},{64.605942,0.900000,76.109741},{63.474483,0.900000,76.445518},{62.242092,0.900000,76.226669},{44.907063,1.166971,96.925613},{46.721306,2.366843,98.073036},{44.187099,2.154889,96.240013},{47.199776,1.604889,95.527122},{47.591766,0.704890,97.399467},{46.159786,1.166971,96.989304}}
gParticleRotations={{-9.058784,168.954941,0.000000},{17.067825,64.048012,0.000000},{-29.986481,-2.190553,-33.200272},{-0.182363,0.522658,-0.518280},{-0.182363,0.522658,-0.518280},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,90.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{-93.500961,-4.979620,105.435585},{0.000000,0.000000,0.000000}}
gParticleEmitters={}
for i=1,#gParticleNamesAndEMTs,1 do
	gParticleEmitters[i]=make(ig3d_particle_emitter, gParticleNamesAndEMTs[i][1], gParticleNamesAndEMTs[i][2])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_POSITION, gParticlePositions[i][1],gParticlePositions[i][2],gParticlePositions[i][3])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_ROTATION, gParticleRotations[i][1],gParticleRotations[i][2],gParticleRotations[i][3])
end
gNumParticleEmitters=#gParticleNamesAndEMTs
gSoundEmitterNames={"emt1","emt2","emt3","emt4","emt5","emt6","emt7","emt8","emt9","emt10","emt11","emt12","emt13","emt14","emt15","emt16","emt17","emt18","emt19","emt20","emt21","emt22","emt23","emt24","emt25","emt26","emt27","emt28","emt29","emt30","emt31","emt32","emt33","emt34","emt35","emt36","emt37","emt38","emt39","emt40","emt41","emt42","emt43","emt44","emt45","emt46","emt47","emt48","emt49","emt50","emt51","emt52","emt53","emt54","emt55","emt56","emt57","emt58","emt59","emt60","emt61","emt61","emt62","emt62","emt63","emt63","emt64","emt64","emt65","emt65","emt66","emt66","emt67","emt67","emt68","emt68","emt69","emt69","emt70","emt70","emt71","emt71","emt72","emt72","emt73","emt73","emt74","emt74","emt75","emt75","emt76","emt76","emt77","emt77","emt78","emt78","emt79","emt79","emt80","emt80","emt81","emt81","emt82","emt82","emt83","emt83","emt84","emt84","emt85","emt85","emt86","emt86","emt87","emt87","emt88","emt88","emt89","emt89","emt90","emt90","emt91","emt91","emt92","emt92","emt93","emt93","emt94","emt94","emt95","emt95","emt96","emt96","emt97","emt97","emt98","emt98","emt99","emt99","emt100","emt100","emt101","emt101","emt102","emt102","emt103","emt103","emt104","emt104","emt105","emt105","emt106","emt106","emt107","emt107","emt108","emt108","emt109","emt109","emt110","emt110","emt111","emt111","emt112","emt112","emt113","emt113","emt114","emt114","emt115","emt115","emt116","emt116","emt117","emt117","emt118","emt118","emt119","emt119","emt120","emt120","emt121","emt121","emt122","emt122","emt123","emt123","emt124","emt124","emt125","emt125","emt126","emt126","emt127","emt127","emt128","emt128","emt129","emt129","emt130","emt130","emt131","emt131","emt132","emt132","emt133","emt133","emt134","emt134","emt135","emt135","emt136","emt136","emt137","emt137","emt138","emt138","emt139","emt139","emt140","emt140","emt141","emt141","emt142","emt142","emt143","emt143","emt144","emt144","emt145","emt145","emt146","emt146","emt147","emt147","emt148","emt148","emt149","emt149","emt150","emt150","emt151","emt151","emt152","emt152","emt153","emt153"}
gSoundEmitterPositions={{47.637989,0.515290,96.394562},{-79.557938,0.000000,1.835643},{-179.351593,-1.875124,1.645756},{-179.351593,-1.875124,1.645756},{-9.479267,0.000000,-2.248839},{-1.771667,0.000000,2.347483},{45.980976,0.523161,95.812912},{32.489071,0.642794,83.668953},{36.019871,0.644898,79.420464},{48.025978,0.636598,90.384407},{70.677383,0.517788,85.189590},{73.680809,0.607961,90.463249},{70.080673,0.670003,77.956131},{68.782036,0.519741,80.238457},{70.873199,0.632246,81.950905},{70.617233,0.650585,85.531487},{35.795223,0.644796,82.054932},{46.400356,0.516672,88.258530},{48.000065,0.516540,89.909554},{-37.270939,-3.423660,-0.301831},{-2.008939,0.000000,1.896740},{-29.986479,-2.190553,-33.200272},{48.025978,0.636598,90.384407},{-3.330672,0.000000,1.618744},{-33.932728,0.861009,-14.321043},{-4.007217,0.000000,1.596008},{-4.999723,0.000000,1.790151},{-1.846931,0.000000,8.136511},{-5.835466,0.000000,1.726959},{68.000000,0.617223,76.000000},{-6.867738,0.000000,1.713369},{-1.312039,0.000000,9.042771},{-8.192620,0.000000,1.852457},{-1.836934,0.000000,10.522897},{-9.186561,0.000000,1.817939},{-1.929190,0.000000,11.671301},{-10.078955,0.000000,1.707725},{-1.921479,0.000000,12.318409},{-11.144773,0.000000,1.682763},{-2.149908,0.000000,14.025126},{-12.026814,0.000000,1.628878},{-13.171659,0.000000,1.599076},{-14.931591,0.000000,1.687620},{-17.153421,0.000000,1.811627},{-20.307222,0.000000,1.930817},{-2.148632,0.000000,15.640233},{-2.103099,0.000000,17.291697},{-2.182349,0.000000,16.747002},{-2.027389,0.000000,17.991289},{-1.914886,0.000000,18.929188},{-1.887625,0.000000,19.839075},{-1.607615,0.000000,20.566446},{-1.705121,0.000000,21.748552},{-20.684217,0.000000,1.312660},{-0.209051,-0.014542,17.709719},{-1.354467,0.518953,12.465975},{-0.902818,0.574555,6.651788},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000},{-1.000000,3.000000,-1.000000}}
gSoundEmitterSamples={"Data/Sounds/zombie.ogg","Data/Sounds/colt45.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/rifle.ogg","Data/Sounds/rifle.ogg","Data/Sounds/rifle.ogg","Data/Sounds/footsteps_walk.ogg","Data/Sounds/rifle.ogg","Data/Sounds/rifle.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/male_scream1.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/rifle.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/rifle.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""}
gSoundEmitters={}
for i=1,#gSoundEmitterNames,1 do
	gSoundEmitters[i]=make(ig3d_sound_emitter, gSoundEmitterNames[i])
	setSound_emitterInfo(gSoundEmitters[i], IG3D_POSITION, gSoundEmitterPositions[i][1],gSoundEmitterPositions[i][2],gSoundEmitterPositions[i][3])
	setSound_emitterInfo(gSoundEmitters[i], IG3D_SAMPLE, gSoundEmitterSamples[i])
end
gNumSoundEmitters=#gSoundEmitterNames
gGroups={}
gNumGroups=0
gTextboxFonts={"Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/Shlop32_1.png","Data/FontPngs/Shlop32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/Shlop32_1.png"}
gTextboxPositions={{40,0},{50,24},{50,36},{50,24},{50,48},{20,20},{10,202},{10,202},{10,202},{10,202},{10,202}}
gTextboxSizes={24,12,12,12,12,10,32,32,32,32,32}
gTextboxColors={{1.000000,0.000000,0.000000,0.000000},{0.000000,0.000000,1.000000,0.000000},{1.000000,0.000000,0.000000,0.000000},{0.000000,1.000000,1.000000,0.000000},{0.000000,1.000000,0.000000,0.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000}}
gTextboxes={}
for i=1,#gTextboxFonts,1 do
	gTextboxes[i]=make(ig3d_text_box, gTextboxFonts[i])
	setText_boxInfo(gTextboxes[i], IG3D_POSITION, gTextboxPositions[i][1],gTextboxPositions[i][2])
	setText_boxInfo(gTextboxes[i], IG3D_SIZE, gTextboxSizes[i])
	setText_boxInfo(gTextboxes[i], IG3D_COLOR, gTextboxColors[i][1],gTextboxColors[i][2],gTextboxColors[i][3], gTextboxColors[i][4])
end
gNumTextboxes=#gTextboxFonts
setSceneInfo(IG3D_TINT_COLOR, 1.000000,1.000000,1.000000)
setSceneInfo(IG3D_FOG, false,0.100000,-0.000000,-0.000000,7.000000,10.000000)
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
setLightInfo(2, IG3D_POSITION, -0.000000,5.000000,7.000000,1.000000)
setLightInfo(2, IG3D_AMBIENT, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(2, IG3D_DIFFUSE, -0.000000,-0.000000,-0.000000,1.000000)
setLightInfo(2, IG3D_SPECULAR, -0.000000,-0.000000,-0.000000,1.000000)
setLightInfo(2, IG3D_CONSTANT_ATTENUATION, 1.000000)
setLightInfo(2, IG3D_LINEAR_ATTENUATION, -0.000000)
setLightInfo(2, IG3D_QUADRATIC_ATTENUATION, -0.000000)
setLightInfo(2, IG3D_SPOTLIGHT, -0.000000,-0.000000,-0.000000,180.000000,-0.000000)
setLightInfo(3, IG3D_ENABLED, false)
setLightInfo(4, IG3D_ENABLED, false)
setLightInfo(5, IG3D_ENABLED, false)
setLightInfo(6, IG3D_ENABLED, false)
setLightInfo(7, IG3D_ENABLED, false)
setLightInfo(8, IG3D_ENABLED, false)
-- End of auto-script

function udg_EmitAtStart(i)
 if string.find(gParticleNamesAndEMTs[i][1], "furniture") then return true end
  if string.find(gParticleNamesAndEMTs[i][1], "debris") then return true end
   if string.find(gParticleNamesAndEMTs[i][1], "scenery") then return true end
   if string.find(gParticleNamesAndEMTs[i][1], "snow") then return true end
end

for i=1,#gParticleNamesAndEMTs,1 do
if udg_EmitAtStart(i) then
runningParticle = get(ig3d_particle_emitter, i)
setParticle_emitterInfo(gParticleEmitters[i], IG3D_FORCE, 0,-9.81,0)
setParticle_emitterInfo(gParticleEmitters[i], IG3D_START)
end
end
	
dontPlaceRandomly=true
truckfire=  get(ig3d_particle_emitter, "fire001")
setParticle_emitterInfo(truckfire, IG3D_START)





 
dofile(gameroot.."Data/Levels/UDG/UDG_LivingInn/UDG_LivingInnTexts.lua")

dofile(gameroot.."Data/Scripts/Games/UDG_Functions/UDG_Init.lua")
--udg_clear_textboxes() -- ; see UDG_Utilities.lua
UDGLevel1Lighting() -- ;see UDG_Lights.lua
lit = UDGWorkLighting 
dark = UDGLevel1Lighting 
currentText = 1
setCameraInfo(IG3D_POSITION, 62.188305, 3.776757, 71.242134)
setCameraInfo(IG3D_ROTATION, 9.333357, 8.563614, -0.000000)
lit()
game_func = handle_udg
