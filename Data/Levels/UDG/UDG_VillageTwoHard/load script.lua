-- Begin of auto-script
loadMesh("Data/Levels/UDG/UDG_Village/UDG_Village_level_mesh.wtf")
gSoundFiles={"Data/Sounds/bodyhit.ogg","Data/Sounds/skid.ogg","Data/Sounds/engine.ogg","Data/Sounds/colt45.ogg","Data/Sounds/rifle.ogg","Data/Sounds/zombie.ogg","Data/Sounds/male_scream1.ogg","Data/Sounds/male_scream2.ogg","Data/Sounds/female_scream1.ogg","Data/Sounds/female_scream2.ogg","Data/Sounds/zombie_eating.ogg","Data/Sounds/zombie_yes.ogg","Data/Sounds/zombie_idle1.ogg","Data/Sounds/zombie_idle2.ogg","Data/Sounds/zombie_idle3.ogg","Data/Sounds/zombie_idle4.ogg","Data/Sounds/footsteps_walk.ogg","Data/Sounds/footsteps_run.ogg","Data/Sounds/bodyhitfloor.ogg","Data/Sounds/male_eaten.ogg","Data/Sounds/female_eaten.ogg","Data/Sounds/no_way.ogg","Data/Sounds/punchsolid.ogg","Data/Sounds/glassbreaking.ogg","Data/Sounds/grenade.ogg","Data/Sounds/dropgrenade.ogg","Data/Sounds/throw_whoosh.ogg","Data/Sounds/drivingrock.ogg","Data/Sounds/brakeandcrash.ogg"}
for i=1,#gSoundFiles,1 do
	loadSound(gSoundFiles[i])
end
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"},{"Data/FontPngs/Shlop32_1.png","Data/FontPngs/Shlop32_2.png"},{"Data/FontPngs/CRAMPS32_1.png","Data/FontPngs/CRAMPS32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, -16.986689, 1.212398, 36.508385)
setCameraInfo(IG3D_ROTATION, 8.333313, 88.633530, 0.000000)
gObjects={}
gObjectWTFs={"Misc/selectionRect.wtf","Reticule/crosshair.wtf","Cubes/kiste.wtf","Characters/ponchocorpgirl.wtf","Characters/soldierusaTB.wtf","Characters/ponchocorpgirl.wtf","Characters/tomdrinman1_3k.wtf","Characters/civilianmale3TB.wtf","Characters/soldierusaTB.wtf","Characters/jackytruebones.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Characters/civilianmale1zombieTB.wtf","Characters/zombiechick.wtf","Characters/tomdrinman2_3ksnowed.wtf","Characters/tomdrinman5_3ksnowed.wtf","Characters/tomdrinman5_zombiepolice.wtf","Characters/tomdrinman5_zombiepolice.wtf","Characters/civilianmale1TB.wtf","Weapons/gloc.wtf","Characters/ponchocorpgirlzombie.wtf","Tools/snowshovel.wtf","Tools/mallet228.wtf","Tools/pickaxe128.wtf","Tools/broom.wtf","Tools/mallet228.wtf","Tools/shovel102.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/luger140.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/leadpipe84.wtf","Weapons/gloc.wtf","Tools/pickaxe128.wtf","Weapons/gloc.wtf","Weapons/bostaff84.wtf","Weapons/gloc.wtf","Weapons/policebaton.wtf","Characters/tomdrinwoman3police.wtf","Characters/tomdrinman5_police.wtf","Characters/tomdrinman1is5police.wtf","Characters/thug_miguel.wtf","Characters/soldierboyTB.wtf","Characters/soldierboyTB.wtf","Characters/soldierboyTB.wtf","Characters/soldierboyTB.wtf","Characters/tomdrinman1police.wtf","Characters/tomdrinman1police.wtf","Characters/tomdrinman5_police.wtf","Characters/tomdrinwoman3police.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/policebaton.wtf","Weapons/policebaton.wtf","Weapons/policebaton.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Weapons/gloc.wtf","Characters/scientistold.wtf","Characters/thug_mustafa.wtf","Characters/thug_rufus.wtf","Characters/fatscifisoldierTB.wtf","Characters/thug_AJ.wtf","Characters/soldierboyTB.wtf","Characters/soldierboyTB.wtf","Characters/soldierboyTB.wtf","Characters/thug_fatjackblack.wtf","Characters/thug_jackson.wtf","Misc/udgmainmenu.wtf","Characters/fatscifizombieA.wtf","Characters/jackytrueboneszombie.wtf","Characters/ponchocorpgirlzombie.wtf"}
gObjectNames={"selectionRect1","crosshair1","playerbox","human1","human2","ponchozombiegri","human5","human7","human10","human11","gun2","gun3","gun4","gun5","gun6","gun7","zombie1","zombiechick2","tom2zombie_3ksnowed3","tom5zombiesnowed4","tom5policezombie1","tomdrinman5_zombiepolice1","tomdrinman2_3k1","mp40_1861","tomdrinman2_3ksnowed1","snowshovel1","baton1","baton21","broom1","mallet2281","shovel1021","grenade1","gloc1","luger1401","M198Rifle5481","m98_1581","marinerifle3501","mp40_1862","leadpipe1","rpgempty1","pickaxe1281","shotgun626A1","bostaff841","sword1261","policebaton1","tomdrinwoman3police1","tomdrinman5_police1","tomdrinman1is5police1","thug_miguel1","soldierboyTB1","soldierboyTB2","soldierboyTB3","soldierboyTB4","tomdrinman1police1","tomdrinman1police2","tomdrinman5_police2","tomdrinwoman3police2","gloc2","gloc3","gloc4","shotgun626A2","shotgun626A3","policebaton2","policebaton3","policebaton4","gloc5","gloc6","gloc7","gloc8","gloc9","scientistold1","thug_mustafa1","thug_rufus1","tomdrinman5_police3","thug_AJ1","soldierboyTB5","soldierboyTB6","tomdrinwoman1_3kredhead1","thug_fatjackblack1","thug_jackson1","udgmainmenu1","fatscifizombieA1","jackytrueboneszombie1","ponchocorpgirlzombie1"}
gObjectPositions={{-0.000000,-28.515560,-0.000000},{-0.000000,-0.000000,-0.100000},{-19.741064,0.349624,36.491535},{16.244158,0.611760,0.501545},{-15.968340,0.610863,-4.515440},{29.958961,0.614926,-40.608627},{18.433672,0.612542,21.932026},{-16.012821,0.811239,-6.817821},{30.630623,0.621581,2.826807},{17.013962,0.499570,1.406188},{25.055788,0.730085,0.435560},{-15.467991,0.731008,-4.719650},{5.649139,0.703535,23.477427},{-19.139729,0.742365,-1.923924},{-17.682566,0.705371,-3.799343},{6.883308,0.736751,-34.014446},{-18.664398,0.624351,34.546852},{-18.327314,0.599552,35.192009},{-19.350323,0.719476,34.404057},{-18.498791,0.713960,36.150349},{-16.329323,0.695281,37.280804},{-20.137606,0.713041,35.115181},{25.073357,0.721333,-35.179173},{26.097988,0.839552,-31.686844},{-20.559551,0.714926,35.888908},{2.134765,-18.834846,10.561147},{15.466652,-27.712618,-0.331722},{5.402838,-27.712589,18.438581},{8.819039,0.026694,-9.881094},{14.943570,-27.611362,-0.186810},{-12.390896,-24.854420,5.435165},{13.766562,0.523977,23.806128},{-18.216188,0.827393,-4.841796},{14.566694,0.533586,26.525404},{-1.010540,0.732209,-34.611286},{28.741543,0.872789,4.410836},{11.192141,0.739326,-10.124488},{12.873110,0.738271,-5.117713},{5.201950,-27.025818,11.489989},{-0.488589,0.732687,-25.375292},{2.167722,-27.472303,7.525289},{-20.480757,0.660780,37.008244},{4.379345,-27.330252,14.086583},{15.698499,0.739829,-0.693475},{-7.819704,-28.387959,6.324248},{2.442820,0.597241,-34.513393},{7.862990,0.612064,-34.773003},{15.895226,0.496954,2.100491},{10.961861,0.716011,-27.980204},{27.273195,0.599267,-41.197002},{29.142315,0.496919,-29.701933},{12.601221,0.498233,-7.367409},{-14.221224,0.498765,8.602151},{-21.385378,0.499371,-1.083159},{-18.139685,0.521589,0.456172},{-27.219528,0.614731,29.475334},{15.132074,0.599599,25.752527},{25.112602,0.705895,2.400259},{6.956110,0.704839,22.213110},{-20.606873,0.731384,-4.950027},{27.194151,0.758830,-34.558784},{-25.849081,0.681510,31.353134},{-17.481972,-27.600006,37.406876},{-17.481487,-27.612007,37.406876},{-17.482346,-27.625563,37.406876},{7.581759,0.667893,-26.301931},{-20.138353,0.744204,35.850842},{4.627996,0.730050,-18.547134},{6.275422,1.308223,-11.775535},{-17.589794,0.074870,37.415684},{28.641399,0.705552,-32.890816},{11.329558,0.796905,-31.600885},{-18.225021,0.662977,4.630091},{-26.859140,1.198921,20.022615},{-25.335665,1.040803,30.231703},{12.570277,1.011172,8.176374},{-22.565899,0.675288,18.983004},{17.762327,0.775851,28.769867},{5.697996,0.998668,13.897759},{30.053699,1.125841,5.169943},{-6.746348,4.144569,8.407148},{-15.680640,0.567466,37.086098},{-15.827768,0.617466,36.336555},{-15.997528,0.617466,36.531979}}
gObjectRotations={{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{0.082935,-46.032986,-0.035232},{180.000000,-48.499470,180.000000},{0.575174,-20.420490,-0.598602},{179.907578,-53.999901,-179.952911},{180.000000,-81.000336,180.000000},{-0.099698,-52.320499,0.113229},{-0.000000,-51.418537,-0.000000},{166.607971,23.879930,-166.727341},{166.607971,23.879930,-166.727341},{166.621552,23.877005,-166.719284},{166.607971,23.879930,-166.727341},{166.604324,23.880718,-166.729874},{104.792503,-75.525612,-122.786583},{-0.045480,-15.471561,0.006178},{-0.042592,-62.941257,0.009670},{0.041641,-31.104040,-0.011589},{-179.973846,-25.318781,179.994125},{179.421692,-5.513164,-168.533630},{-0.051870,64.270164,-0.020901},{-0.022421,-23.237192,0.039591},{80.048317,-25.288837,-166.224136},{179.936859,56.499443,179.966080},{96.166962,-0.927370,0.266928},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.094422,-0.002144,-0.017524},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-48.292049,6.404290,84.050941},{166.607971,23.879930,-166.727341},{-102.142067,-0.996174,81.254562},{166.607971,23.879930,-166.727341},{-177.517685,39.192402,-134.396820},{166.608994,23.879704,-166.721329},{166.607971,23.879930,-166.727341},{-0.000000,-0.000000,-0.000000},{166.607971,23.879930,-166.727341},{-0.000000,-0.000000,-0.000000},{-59.868973,36.529430,-43.562801},{-0.000000,-0.000000,-0.000000},{166.613510,23.878735,-166.722153},{-0.000000,-0.000000,-0.000000},{0.167714,80.500092,0.169472},{0.048181,17.999895,0.007631},{-0.042128,-32.499767,0.012279},{-179.965622,5.501017,-179.998352},{0.030411,10.581658,0.065641},{0.055230,-63.499401,-0.062669},{0.054743,19.580204,0.009446},{179.947876,-54.090744,-179.951172},{179.225052,89.002205,179.165710},{-0.101654,-48.999844,0.083980},{0.093505,53.581467,0.082254},{179.430374,-88.502495,-179.530319},{166.632294,23.874678,-166.715683},{166.604538,23.880678,-166.729935},{166.607971,23.879930,-166.727341},{-109.329315,68.716232,2.821354},{-47.178265,23.513180,-37.204399},{-4.704820,-0.043968,-0.346523},{-0.191757,0.181998,-0.013660},{4.896264,-0.167636,0.356537},{-177.517685,39.192402,-134.396820},{-34.418407,51.379948,-19.693132},{-21.637323,12.743864,-12.446813},{166.607971,23.879930,-166.727341},{-0.027759,-0.000000,-0.000000},{-0.031415,-53.500057,0.000170},{-179.922714,54.581646,-179.924927},{-179.763031,-76.000237,179.785431},{-0.100309,6.001278,-0.005258},{0.024897,19.501169,-0.020305},{-0.059566,-53.000122,0.056771},{0.168584,-81.004486,-0.130988},{-179.878174,-64.499588,179.855942},{179.959167,-28.581772,-179.989594},{179.995987,-81.000351,179.964401},{-0.000000,-0.000000,-0.000000},{179.762756,-80.499786,-179.771652},{-0.034318,-40.000080,0.012491},{-0.026512,-56.000320,-0.001746}}
gObjectSizes={{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{50.000000,50.000000,50.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000}}
gObjectColls={false,false,true,true,true,true,true,true,true,true,false,false,false,false,false,false,true,true,true,true,true,true,true,false,true,true,true,true,true,true,true,false,false,false,false,false,false,false,true,false,true,false,true,false,true,true,true,true,true,true,true,true,true,true,true,true,true,false,false,false,false,false,true,true,true,false,false,false,false,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true}
gObjectHUDs={false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false}
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
gParticleNamesAndEMTs={{"Bullets","Data/Emitters/pistol.emt"},{"TireTraces","Data/Emitters/tiretrace.emt"},{"Blood","Data/Emitters/blood.emt"},{"MoreBlood","Data/Emitters/blood2.emt"},{"MuzzleFlash","Data/Emitters/muzzleflash.emt"},{"Unitmarker","Data/Emitters/unitmarker.emt"},{"Unitmarker2","Data/Emitters/unitmarker2.emt"},{"fpsgun","Data/Emitters/slowbullet.emt"},{"bloodonfloor","Data/Emitters/bloodonfloor.emt"},{"crate0004001","Data/Emitters/Cubes/crate0004.emt"},{"crate0004002","Data/Emitters/Cubes/crate0004.emt"},{"crate0004003","Data/Emitters/Cubes/crate0004.emt"},{"crate0004004","Data/Emitters/Cubes/crate0004.emt"},{"crate0004005","Data/Emitters/Cubes/crate0004.emt"},{"crate0004006","Data/Emitters/Cubes/crate0004.emt"},{"crate0004007","Data/Emitters/Cubes/crate0004.emt"},{"crate0004008","Data/Emitters/Cubes/crate0004.emt"},{"crate0004009","Data/Emitters/Cubes/crate0004.emt"},{"crate0003001","Data/Emitters/Cubes/crate0003.emt"},{"crate0003002","Data/Emitters/Cubes/crate0003.emt"},{"crate0003003","Data/Emitters/Cubes/crate0003.emt"},{"crate0003004","Data/Emitters/Cubes/crate0003.emt"},{"crate0003005","Data/Emitters/Cubes/crate0003.emt"},{"crate0003006","Data/Emitters/Cubes/crate0003.emt"},{"crate0002001","Data/Emitters/Cubes/crate0002.emt"},{"crate0002002","Data/Emitters/Cubes/crate0002.emt"},{"crate0002003","Data/Emitters/Cubes/crate0002.emt"},{"crate0002004","Data/Emitters/Cubes/crate0002.emt"},{"crate0002005","Data/Emitters/Cubes/crate0002.emt"},{"crate0002006","Data/Emitters/Cubes/crate0002.emt"},{"crate0002007","Data/Emitters/Cubes/crate0002.emt"},{"crate0002008","Data/Emitters/Cubes/crate0002.emt"},{"crate0002009","Data/Emitters/Cubes/crate0002.emt"},{"crate0002010","Data/Emitters/Cubes/crate0002.emt"},{"crate0002011","Data/Emitters/Cubes/crate0002.emt"},{"crate0002012","Data/Emitters/Cubes/crate0002.emt"},{"crate0002013","Data/Emitters/Cubes/crate0002.emt"},{"crate0002014","Data/Emitters/Cubes/crate0002.emt"},{"crate0002015","Data/Emitters/Cubes/crate0002.emt"},{"crate0002016","Data/Emitters/Cubes/crate0002.emt"},{"crate0002017","Data/Emitters/Cubes/crate0002.emt"},{"crate0002018","Data/Emitters/Cubes/crate0002.emt"},{"crate0002019","Data/Emitters/Cubes/crate0002.emt"},{"crate0002020","Data/Emitters/Cubes/crate0002.emt"},{"crate0002021","Data/Emitters/Cubes/crate0002.emt"},{"crate0002022","Data/Emitters/Cubes/crate0002.emt"},{"crate0002023","Data/Emitters/Cubes/crate0002.emt"},{"crate0002024","Data/Emitters/Cubes/crate0002.emt"},{"crate0002025","Data/Emitters/Cubes/crate0002.emt"},{"crate0002026","Data/Emitters/Cubes/crate0002.emt"},{"crate0002027","Data/Emitters/Cubes/crate0002.emt"},{"crate0002028","Data/Emitters/Cubes/crate0002.emt"},{"crate0002029","Data/Emitters/Cubes/crate0002.emt"},{"crate0002030","Data/Emitters/Cubes/crate0002.emt"},{"crate0002031","Data/Emitters/Cubes/crate0002.emt"},{"crate0002032","Data/Emitters/Cubes/crate0002.emt"},{"crate0002033","Data/Emitters/Cubes/crate0002.emt"},{"crate0002034","Data/Emitters/Cubes/crate0002.emt"},{"crate0002035","Data/Emitters/Cubes/crate0002.emt"},{"barrelopen001","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen002","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen003","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen004","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen005","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen006","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen007","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen008","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen009","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen010","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen011","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen012","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen013","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen014","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen015","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen016","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen017","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen018","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen019","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen020","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen021","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen022","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen023","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen024","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen025","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen026","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen027","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen028","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen029","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen030","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen031","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen032","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen033","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen034","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen035","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen036","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen037","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen038","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen039","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen040","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen041","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen042","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen043","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen044","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen045","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen046","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen047","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen048","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen049","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen050","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen051","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen052","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen053","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen054","Data/Emitters/Containers/barrelopen.emt"},{"barrelopen055","Data/Emitters/Containers/barrelopen.emt"},{"crate0003007","Data/Emitters/Cubes/crate0003.emt"},{"crate0003008","Data/Emitters/Cubes/crate0003.emt"},{"crate0003009","Data/Emitters/Cubes/crate0003.emt"},{"crate0003010","Data/Emitters/Cubes/crate0003.emt"},{"crate0003011","Data/Emitters/Cubes/crate0003.emt"},{"crate0003012","Data/Emitters/Cubes/crate0003.emt"},{"crate0003013","Data/Emitters/Cubes/crate0003.emt"}}
gParticlePositions={{26.788507,0.764301,-32.613628},{-185.062057,-2.428456,-0.457016},{26.351570,0.570253,-34.550896},{-0.182363,0.522658,-0.518280},{-34.501820,-2.745420,-11.845739},{-34.501820,-2.745420,-11.845739},{27.388687,0.050000,-31.765268},{-34.501820,-2.745420,-11.845739},{-34.501820,-2.745420,-11.845739},{4.490345,1.751027,19.951504},{6.297253,1.440223,10.692506},{2.072998,0.666922,11.077527},{8.495956,0.825611,12.903823},{0.649813,2.454195,9.426503},{-10.964418,2.283636,6.815652},{-19.014206,0.693576,3.532161},{-20.088156,0.566788,-4.751178},{5.899244,0.828473,12.285194},{7.830497,1.195656,21.287907},{9.197449,0.515152,25.923477},{13.558537,1.594072,25.412243},{15.111563,0.916615,28.910973},{17.767241,1.215620,23.713245},{5.144178,0.625586,26.996410},{5.423867,2.798409,28.301836},{4.705150,0.833136,13.387005},{6.917634,1.183143,12.989121},{12.003686,1.514242,8.275331},{15.731533,0.971621,5.178747},{15.503353,0.845475,4.717509},{25.192759,1.049373,4.106706},{29.216597,1.353188,4.287912},{26.833685,2.745147,-0.170173},{15.939508,0.375243,-1.277311},{13.814161,0.355376,-1.610655},{14.259027,0.758341,-4.439984},{10.855941,0.763345,-8.700378},{7.945328,0.377348,-12.570849},{5.781204,1.050798,-12.618009},{5.789122,3.115227,-19.341507},{5.725232,1.018106,-19.310596},{4.589407,1.248731,-25.230850},{3.297313,0.518581,-29.018482},{1.348166,1.530871,-32.511070},{5.127707,0.619286,-34.720703},{10.548865,1.486925,-29.261044},{14.201016,0.584947,-32.853882},{28.210035,0.629781,-37.792660},{26.076416,0.472481,-36.242077},{26.409838,1.712922,-37.496208},{26.793873,2.223699,-38.037899},{27.894953,1.663197,-37.615944},{27.269266,0.752123,-35.979721},{23.938673,1.083680,-32.931129},{25.203112,1.089261,-32.096382},{27.649206,1.100452,-32.653782},{29.298656,0.798373,-32.499996},{27.177038,0.896029,-30.813280},{24.933302,1.695031,-30.084969},{25.474844,0.787044,-35.035278},{26.575291,0.787044,-35.738380},{28.198500,1.000601,-37.264637},{29.029133,0.429208,-31.186609},{26.940926,0.571684,-29.301935},{19.937824,1.059662,-29.984379},{14.906169,0.661991,-31.707941},{14.591888,0.740186,-28.337465},{12.296410,0.954487,-28.466761},{12.296410,0.954487,-28.466761},{8.792709,1.097204,-31.084486},{7.878430,0.989453,-28.762909},{7.988158,0.873816,-27.933010},{6.799313,0.606841,-27.127670},{6.577312,0.624007,-27.976841},{0.130263,1.671410,-32.431393},{-1.199731,0.758973,-31.874849},{0.894939,0.798047,-30.384417},{7.560941,0.924301,-11.714047},{13.609904,0.515437,-5.988351},{13.358936,0.961002,-4.077185},{14.641211,0.862494,1.612069},{14.889880,0.840151,0.406434},{15.362388,0.763268,1.227402},{15.239769,0.475407,2.788400},{7.890350,0.901632,10.404242},{10.517306,0.884702,9.657039},{8.764354,0.426439,11.658597},{3.603173,0.749368,14.454597},{5.041174,0.576199,20.817932},{7.593985,0.762988,25.652897},{13.329013,0.631362,25.645212},{-17.253202,0.341402,4.908215},{-17.462759,0.436852,6.341375},{1.085721,0.650313,10.566917},{-20.483448,0.684733,-1.337255},{-20.608995,0.661763,-0.882274},{-15.492241,0.531876,6.308531},{-26.046932,1.096012,20.757685},{-11.999019,1.096012,6.122282},{-22.456715,1.106450,8.045984},{-27.715517,1.386615,22.251055},{-26.308310,1.397509,23.120207},{-24.607924,1.424946,21.223600},{-20.960337,2.025117,4.142135},{-24.709335,2.053831,20.029240},{-27.106688,2.394537,21.694544},{-19.444765,2.309697,5.213625},{-25.262354,2.629637,31.527262},{-27.226452,1.265597,29.882963},{-18.421114,1.351173,5.761434},{3.884409,1.748009,10.412809},{-20.045012,1.332705,3.394060},{-20.869211,1.172798,35.863773},{-17.228857,0.846398,36.969257},{-27.059866,1.542116,28.070684},{-25.459560,1.621886,20.440283},{-29.151459,0.552668,30.227755},{-27.640863,0.920755,27.096687},{-25.875032,1.277278,22.375015},{-24.577652,0.441696,19.936337},{-24.184843,1.027247,13.074905}}
gParticleRotations={{5.695937,-22.512119,-0.000000},{17.067825,64.048012,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.182363,0.522658,-0.518280},{-0.182363,0.522658,-0.518280},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000}}
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
gTextboxFonts={"Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png"}
gTextboxPositions={{8,8},{20,20},{20,20},{20,20}}
gTextboxSizes={12,10,10,10}
gTextboxColors={{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000},{1.000000,1.000000,1.000000,1.000000}}
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
setLightInfo(1, IG3D_SPOTLIGHT, -0.000000,-0.000000,-0.000000,180.000000,-0.000000)
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
setLightInfo(4, IG3D_ENABLED, true)
setLightInfo(4, IG3D_POSITION, 27.811422,2.899623,-32.896694,1.000000)
setLightInfo(4, IG3D_AMBIENT, 0.200000,0.200000,0.500000,1.000000)
setLightInfo(4, IG3D_DIFFUSE, 0.312000,0.276000,0.116000,1.000000)
setLightInfo(4, IG3D_SPECULAR, 0.844000,1.000000,0.496000,1.000000)
setLightInfo(4, IG3D_CONSTANT_ATTENUATION, 0.500000)
setLightInfo(4, IG3D_LINEAR_ATTENUATION, 0.036000)
setLightInfo(4, IG3D_QUADRATIC_ATTENUATION, 0.004000)
setLightInfo(4, IG3D_SPOTLIGHT, -0.000000,-0.000000,-0.000000,180.000000,-0.000000)
setLightInfo(5, IG3D_ENABLED, false)
setLightInfo(6, IG3D_ENABLED, false)
setLightInfo(7, IG3D_ENABLED, false)
setLightInfo(8, IG3D_ENABLED, false)
-- End of auto-script
if ig3d_GetMode__i() == 4 then
dontPlaceRandomly=true
gGridSize=1
dofile(gameroot.."Data/Scripts/Games/UDG_Functions/UDG_Init.lua")
udg_StartUpEmitters() ;--see UDG_Utilities.lua
UDGLevel1Lighting() -- ;see UDG_Lights.lua
lit = UDGWorkLighting 
dark = udg_Instructions_lightfive 
game_func = handle_udg
end


function udg_check_game_end_condition()
	rts_update_living_and_dead_counts()
	if gNumZombies==0 then
		return ig3d_GetLevelName__s(),"\nYour legion of undead have been destroyed!!\n\nPress space bar to restart scenario"
	end
	if gNumHumans==0 then
			return "Data/Levels/UDG/UDG_GauntletTwoHard","\nTeam Zombie is unstoppable!\n\nPress space bar to continue."
	end
	return nil,""	
end
