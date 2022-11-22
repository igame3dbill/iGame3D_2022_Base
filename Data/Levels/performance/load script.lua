-- Begin of auto-script
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, 32.393574, 24.108076, 64.329811)
setCameraInfo(IG3D_ROTATION, 23.333349, -149.333328, 0.000000)
gObjects={}
gObjectWTFs={"Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf","Characters/ponchocorpgirl.wtf"}
gObjectNames={"ponchocorpgirl1","ponchocorpgirl2","ponchocorpgirl3","ponchocorpgirl4","ponchocorpgirl5","ponchocorpgirl6","ponchocorpgirl7","ponchocorpgirl8","ponchocorpgirl9","ponchocorpgirl10","ponchocorpgirl11","ponchocorpgirl12","ponchocorpgirl13","ponchocorpgirl14","ponchocorpgirl15","ponchocorpgirl16","ponchocorpgirl17","ponchocorpgirl18","ponchocorpgirl19","ponchocorpgirl20","ponchocorpgirl21","ponchocorpgirl22","ponchocorpgirl23","ponchocorpgirl24","ponchocorpgirl25","ponchocorpgirl26","ponchocorpgirl27","ponchocorpgirl28","ponchocorpgirl29","ponchocorpgirl30","ponchocorpgirl31","ponchocorpgirl32","ponchocorpgirl33","ponchocorpgirl34","ponchocorpgirl35","ponchocorpgirl36","ponchocorpgirl37","ponchocorpgirl38","ponchocorpgirl39","ponchocorpgirl40","ponchocorpgirl41","ponchocorpgirl42","ponchocorpgirl43","ponchocorpgirl44","ponchocorpgirl45","ponchocorpgirl46","ponchocorpgirl47","ponchocorpgirl48","ponchocorpgirl49","ponchocorpgirl50","ponchocorpgirl51","ponchocorpgirl52","ponchocorpgirl53","ponchocorpgirl54","ponchocorpgirl55","ponchocorpgirl56","ponchocorpgirl57","ponchocorpgirl58","ponchocorpgirl59","ponchocorpgirl60","ponchocorpgirl61","ponchocorpgirl62","ponchocorpgirl63","ponchocorpgirl64","ponchocorpgirl65","ponchocorpgirl66","ponchocorpgirl67","ponchocorpgirl68","ponchocorpgirl69","ponchocorpgirl70","ponchocorpgirl71","ponchocorpgirl72","ponchocorpgirl73","ponchocorpgirl74","ponchocorpgirl75","ponchocorpgirl76","ponchocorpgirl77","ponchocorpgirl78","ponchocorpgirl79","ponchocorpgirl80","ponchocorpgirl81","ponchocorpgirl82","ponchocorpgirl83","ponchocorpgirl84","ponchocorpgirl85","ponchocorpgirl86","ponchocorpgirl87","ponchocorpgirl88","ponchocorpgirl89","ponchocorpgirl90","ponchocorpgirl91","ponchocorpgirl92","ponchocorpgirl93","ponchocorpgirl94","ponchocorpgirl95","ponchocorpgirl96","ponchocorpgirl97","ponchocorpgirl98","ponchocorpgirl99","ponchocorpgirl100"}
gObjectPositions={{-33.813869,0.000000,-9.709045},{20.072979,0.000000,-33.427853},{-21.913460,0.000000,0.466425},{39.211941,0.000000,35.076618},{32.748489,0.000000,3.857429},{31.810400,0.000000,37.404896},{-35.922535,0.000000,49.925465},{-2.726230,0.000000,-19.751577},{35.223915,0.000000,8.363700},{-31.302931,0.000000,-8.367768},{-37.085449,0.000000,4.867416},{6.659044,0.000000,18.549810},{-33.333000,0.000000,-27.711782},{48.067593,0.000000,-27.957155},{24.078924,0.000000,-5.506154},{-41.932446,0.000000,41.363750},{0.545048,0.000000,-39.379959},{40.995605,0.000000,13.150559},{21.456450,0.000000,18.558691},{15.904123,0.000000,0.601425},{8.153870,0.000000,42.083427},{-3.854481,0.000000,17.738342},{28.331839,0.000000,-26.782646},{-35.940258,0.000000,-47.893715},{-49.639778,0.000000,4.241337},{-15.841207,0.000000,-43.151718},{49.091969,0.000000,-11.261963},{20.184147,0.000000,34.947193},{-42.518063,0.000000,-1.055534},{-40.364212,0.000000,-1.317000},{-34.825943,0.000000,-19.593996},{-16.288116,0.000000,45.636738},{16.678204,0.000000,10.580878},{32.828083,0.000000,41.588203},{-27.059662,0.000000,8.266936},{42.391624,0.000000,-23.975901},{37.052002,0.000000,33.023960},{33.705822,0.000000,-6.242631},{-19.902060,0.000000,6.079471},{-22.331724,0.000000,-29.286448},{-17.319729,0.000000,7.327595},{-45.116974,0.000000,19.025942},{-30.986261,0.000000,13.905340},{7.053246,0.000000,43.912617},{39.377754,0.000000,21.918360},{-18.113455,0.000000,-32.836205},{21.926178,0.000000,13.264675},{39.398239,0.000000,-33.772263},{-10.430779,0.000000,-10.094216},{46.504951,0.000000,8.723767},{20.361965,0.000000,23.551168},{24.490768,0.000000,16.335957},{-41.577477,0.000000,7.369818},{-35.473465,0.000000,-2.494637},{-27.364742,0.000000,-19.222712},{23.878016,0.000000,17.798220},{34.681618,0.000000,-6.063151},{-3.388469,0.000000,49.994598},{-40.800755,0.000000,-38.264259},{-7.387575,0.000000,37.034439},{37.788269,0.000000,7.416140},{43.067142,0.000000,29.441366},{21.029123,0.000000,36.490585},{-2.752830,0.000000,33.192905},{-26.849062,0.000000,47.830872},{-6.543623,0.000000,21.326944},{41.960873,0.000000,36.413399},{-0.038493,0.000000,-46.955467},{19.472939,0.000000,-18.331535},{1.887239,0.000000,18.831818},{6.353009,0.000000,-24.984676},{-17.466080,0.000000,47.591305},{-32.938248,0.000000,6.842313},{-1.243258,0.000000,4.563373},{-3.387192,0.000000,-28.541584},{1.583229,0.000000,9.331861},{40.599224,0.000000,-48.816959},{33.356773,0.000000,27.276108},{29.553152,0.000000,-0.165628},{16.296242,0.000000,-9.061900},{-3.352433,0.000000,-44.345383},{-12.835939,0.000000,-33.635017},{-3.763402,0.000000,48.512775},{-45.763443,0.000000,-46.164410},{14.797901,0.000000,8.329484},{-6.363413,0.000000,-49.888500},{23.974030,0.000000,31.529037},{8.525538,0.000000,-11.271774},{-44.711975,0.000000,25.827469},{-17.732985,0.000000,-38.280067},{26.880579,0.000000,-18.101503},{-31.958349,0.000000,-23.973110},{-16.051609,0.000000,20.604294},{-3.643053,0.000000,-28.787132},{-25.338762,0.000000,31.419867},{-26.286905,0.000000,-4.016500},{-5.326314,0.000000,-19.370638},{37.681553,0.000000,13.869011},{-3.535821,0.000000,-26.551168},{-45.483402,0.000000,-39.558899}}
gObjectRotations={{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000}}
gObjectSizes={{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000}}
gObjectColls={true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true}
gObjectHUDs={false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false}
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
setSceneInfo(IG3D_TINT_COLOR, 1.000000,1.000000,1.000000)
setSceneInfo(IG3D_FOG, false,0.500000,0.500000,0.500000,0.000000,200.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.338000,0.712000,0.050000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, -0.500000,2.000000,-1.000000,0.000000)
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

ig3d_ReadAnimationsFromFileIntoCache_si(gameroot.."Data/WTF/Characters/truebonesmaster.wtf", 25179)


for i=1,#gObjects,1 do
	setObjectInfo(gObjects[i].cObj, IG3D_ANIMATION, "Walk",0,true)
end

passedTable={}

function benchmark()
	--we are drawing 100 models
	
	table.insert(passedTable, passed())
	a=0
	for i=1,#passedTable,1 do
		a=a+passedTable[i]
	end
	--print(ig3d_GetNumberOfPolys__i().." polys were drawn in "..passed().." seconds. Mean: "..a/#passedTable)
	
	print(ig3d_GetNumberOfPolys__i(), getSceneInfo(IG3D_FPS))
end

function no_textures()
	i=1
	local m=get(ig3d_material, -1, i)
	while m do
		setMaterialInfo(m, IG3D_TEXTURE, 1, nil)
		i=i+1
		m=get(ig3d_material, -1, i)
	end
	
	for j=1,#gObjects,1 do
		i=1
		local m=get(ig3d_material, gObjects[j].cObj, i)
		while m do
			setMaterialInfo(m, IG3D_TEXTURE, 1, nil)
			i=i+1
			m=get(ig3d_material, gObjects[j].cObj, i)
		end
	end

end

--OLD
--0.048 VBOs
--0.06 no VBOs

--NEW
--0.031 VBOs
--0.046 no VBOs

--old technique: GPU vertex transformation, multi-bones, static VBOs
--new technique: CPU vertex transformation, multi-bones, streaming VBOs


game_func= benchmark