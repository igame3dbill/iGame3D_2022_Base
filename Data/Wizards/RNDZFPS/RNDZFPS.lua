--function make_window()
glistedFiles={}
gChosenCategory="Humans"
gCharacterPicked=""
gLastClick=os.time()
gameroot=getSceneInfo(IG3D_ROOT)
gBrowserPath=gameroot.."Data/WTF/Characters"
if gameroot == nil then gameroot=getSceneInfo(IG3D_ROOT) end
HumansList={}
EnemiesList={}
WeaponsList={}
AddedWeapons={}
AddedEnemies={}
AddedHumans={}
--disa
function disa(w)
w:enable(false)
end
local i,ii,iii
local maxHumans, maxEnemy, maxCars, maxBuildings = 20,20,12,15
local  numcars,numEnemy, numbuildings, numguns = 0,0,0,1
function TrueBoneFilter(s)
tbfilters={"TB","tb","boned","truebone","tomdrin","thug_","poncho","Officer"}
if string.find(s,".wtfb") then return false end
for i,v in pairs(tbfilters) do
if string.find(s,v) ~= nil then return true end
end

return false 
end
WeaponsList = listFiles(gameroot.."Data/WTF/Weapons")

hl = listFiles(gameroot.."Data/WTF/Characters")


for i = 1,#hl,1 do

if TrueBoneFilter(hl[i]) == true and string.find(hl[i],"low") == nil then table.insert(HumansList,hl[i]) end
end


for i =#HumansList,1,-1 do
if string.find(HumansList[i],"zom") ~=nil or string.find(HumansList[i],"slime") ~=nil then 
table.insert(EnemiesList,HumansList[i]) 
table.remove(HumansList,i) 
end
end
FPS_Humans={
"soldiersol1kTB","soldierusaTB","tomdrinman1is5police","swatsoldierTB","thug_rufus","thug_melvin","thug_jackson", 
"thug_miguel", 
"tomdrinman2_3kladyman"}

FPS_Enemy={"zombie","zombiechick","zombiechick_alt","zombiechick_alt2","tomdrinman1_3ksnowed",  "tomdrinman2_3kslimed", "ponchocorpgirlzombie", 
"civilianmale1zombieTB"}

FPS_Weapons={"gloc","policebaton","hk53Submachinegun"}
entityPos={}
levelInput = ""
math.randomseed(os.time())
zObjectWTFs={"Misc/selectionRect.wtf","Reticule/crosshair.wtf","Cubes/kiste.wtf"}
zObjectNames={"selectionRect1","crosshair1","playerbox"}
zObjectColls={false,true,true}
zObjectRotations={}
zObjectHuds={}
numDefaultWTFs=#zObjectWTFs
zObjectPositions={
{0.0,0.0,0.0},{1.0,1.0,1.0},{1.5,1.5,1.5}}
safeObjectPositions={
{62.000000,-86.646774,30.000000},
{47.258739,0.507678,76.424576},{43.243694,0.762421,25.413702},
{50.598743,0.764441,20.508604},{60.166893,1.170261,39.816010},
{57.660912,0.764038,18.233503},{60.978413,1.374350,81.188713},
{31.634617,0.736797,4.103798},{63.513039,0.878572,46.450378},
{58.737953,0.764495,54.094540},{45.005001,0.903753,34.784061},
{50.549290,0.905859,20.551596},{38.000641,0.905375,19.050364},
{31.658695,1.035665,4.201219},{40.337036,1.667325,25.380926},
{48.382099,0.983889,-2.469377},{43.806015,1.062596,10.225948},
{32.079155,1.062112,36.448139},{54.529438,1.340742,61.232269},
{58.361206,1.428861,77.813133},{43.265430,1.508237,3.466213},
{43.748135,1.092570,71.040619},{38.104900,0.922139,64.339561},
{37.156342,0.763291,78.264572},{48.217533,0.877104,59.315483},
{42.397167,0.884819,80.213249},{53.063938,0.874608,54.855629},
{64.224159,1.112247,76.856354},{34.902641,0.899743,90.209824},
{50.082310,0.886924,81.958778},{36.409924,0.764704,64.620277},
{54.436802,0.903149,78.552979},{63.437126,0.912949,61.963970},
{29.312325,0.956802,79.709892},{55.733536,0.944059,46.008541},
{41.341492,0.877269,59.821789},{34.605984,1.525926,20.206026},
{48.465740,0.691159,-2.416179},{51.468102,5.970838,13.207197},
{46.110199,0.763259,42.591469},{35.374496,3.272860,8.168362},
{47.943844,5.744731,14.502405},{40.402004,4.340430,5.039046},
{57.302944,2.045993,63.944870},{40.448048,0.762901,71.481964},
{43.389244,1.306236,3.409392},{42.389244,1.306236,59.409392},
{46.128483,0.762421,4.916518},{38.755932,0.764441,4.566350},
{50.202240,1.170261,5.506792},{41.706924,0.764038,14.032541},
{31.032784,1.374350,38.015568},{31.634617,0.736797,4.103798},
{42.104874,0.878572,4.241358},{30.193731,0.764495,32.230881},
{40.511398,0.763291,39.112206},{40.336136,0.877104,2.529009},
{30.088226,0.884819,26.384604},{35.243534,0.874608,6.538452},
{46.238403,1.112247,28.961725},{44.985340,0.886924,42.985210},
{45.496494,0.764704,23.754606},{35.036446,0.903149,19.745646},
{36.614655,0.912949,34.957787},{36.293510,0.956802,42.783073},
{35.540016,0.944059,16.401497},{44.231335,0.877269,-3.532514},
{36.731617,1.525926,11.247998},{40.139351,0.691159,-5.852829},
{51.468102,1.320837,13.207197},{45.363174,0.763259,12.720284},
{39.668343,2.045993,22.981691},{36.050701,0.762901,29.417643},
{39.558598,1.306236,-1.328957},
{45.138103,0.762421,35.270622},{56.281982,0.764441,44.582237},
{56.541237,1.170261,49.855648},{40.990074,0.764038,41.928017},
{60.978413,1.374350,81.188713},{47.737133,0.736797,38.982128},
{64.015030,0.878572,43.726421},{58.737953,0.764495,54.094540},
{30.112762,0.763291,85.979179},{49.209389,0.877104,66.421822},
{58.435184,0.884819,76.088493},{64.677284,0.874608,69.210144},
{60.964546,1.112247,73.538849},{56.299965,0.900199,81.325455},
{50.082310,0.886924,81.958778},{33.551224,0.764704,64.817604},
{54.436802,0.903149,78.552979},{62.628056,0.912949,57.283772},
{28.698185,1.098997,78.590775},{64.264183,0.944059,50.805820},
{33.092487,0.877269,60.928890},{47.298557,1.525926,43.142319},
{52.822884,0.691159,42.129509},{59.235199,1.020837,41.883987},
{52.239925,0.763259,46.490547},{52.842010,2.045993,63.762547},
{44.563370,0.762901,67.733589},{48.504169,1.306236,45.490852}
}
RNDFPSLoadScript={}
RNDFPSLoadScript[1]='loadMesh("Data/Levels/ZFPS/ZFPS_SnipersAlley/ZFPS_SnipersAlley_level_mesh.wtf")\n'

RNDZFPSMesh=gameroot.."Data/Levels/ZFPS/ZFPS_SnipersAlley/ZFPS_SnipersAlley_level_mesh.wtf"
-- sounds, fonts and camera in [2]
RNDFPSLoadScript[2]=[[
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

]] -- end of [2]
--  object generation here at [3]
RNDFPSLoadScript[3]=[[

gObjects={}
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
]]
-- the rest of autoscript goes here in [4]
RNDFPSLoadScript[4] = [[
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

]] -- end of RNDFPSLoadScript[4]
-- init files and game func in [5]
RNDFPSLoadScript[5]=[[
function rndzpfs_game()
 handle_zfps()
end

chud=get(ig3d_object, "crosshair1")
setObjectInfo(chud, IG3D_HUD, true) 

if ig3d_GetMode__i() == 4 then
dontPlaceRandomly=true
gGridSize=2
dofile(gameroot.."Data/Scripts/Games/ZFPS_Functions/ZFPS_Init.lua")
gTestLight=false
zfps_StartUpEmitters() ;--see ZFPS_Utilities.lua
dark = zfps_test_light_tint_fog
lit = zfps_test_light_tint_fog 
game_func =handle_zfps
end
]]
-- AutoLevelName
function AutoLevelName()

H =#AddedHumans
W =#AddedWeapons
Z=#AddedEnemies 

maxEnemy=EnemyFld:value()
maxHumans=HumansFld:value()
levelName = "H"..H.."W"..W.."Z"..Z.."_H"..maxHumans.."Z"..maxEnemy.."_ZFPS"
LevelNameFld:value(levelName) 
RNDZFPSWindow:redraw()
return levelName
end
--EntityLocations
function EntityLocations()
for i=1,#housePos-1,1 do

	local ex,ez = housePos[i][1],housePos[i][2]
	print(ex,ez)
	for ii = ex-2,ex+2,4 do
		for iii = ez-2,ez+2,4 do
		table.insert(entityPos,{ii,iii})
		end
	end
end
end
-- setEntityPos 
function setEntityPos()
if #safeObjectPositions >=1 then
local rndPos = math.random(1,#safeObjectPositions)
plx = safeObjectPositions[rndPos][1]
ply = safeObjectPositions[rndPos][2]
plz = safeObjectPositions[rndPos][3]
table.remove(safeObjectPositions,rndPos) 
else
plx,ply,plz=0,0,0
end


table.insert(zObjectPositions,{plx,ply,plz})
return plx,ply,plz
end
-- generate Enemy
function createEnemy()
maxEnemy=EnemyFld:value()
	for ii = 1,maxEnemy,1 do
		
		local rndZ = math.random(1,#AddedEnemies)
		local tObj,tNam = "Characters/"..AddedEnemies[rndZ][1]..".wtf", AddedEnemies[rndZ][1]..ii
		table.insert(zObjectWTFs,tObj)
		table.insert(zObjectNames,tNam)
		table.insert(zObjectColls,true)	
		setEntityPos()	
	end			
end
-- createEntities 
--generate humans and guns	
function createEntities()	
	maxHumans=HumansFld:value()
	

hPositions={}	
		
for i = 1,maxHumans,1 do
	local rndH = math.random(1,#AddedHumans)
	local tObj,tNam ="Characters/"..AddedHumans[rndH][1]..".wtf" , "human"..i
	table.insert(zObjectWTFs, tObj)
	table.insert(zObjectNames,tNam)	
	table.insert(zObjectColls,true)
	xx,yy,zz=setEntityPos()
	table.insert(hPositions,{xx,yy,zz})
		
end

--add weapons after humans, using same coordinates
for i = 1, #hPositions,1 do 
local rndW = math.random(1,#AddedWeapons)
	local tObj,tNam = "Weapons/"..AddedWeapons[rndW][1]..".wtf", "gun"..i
	table.insert(zObjectWTFs, tObj )
	table.insert(zObjectNames,tNam)
	table.insert(zObjectColls,true)
	xx,yy,zz=hPositions[i][1], hPositions[i][2], hPositions[i][3]
	table.insert(zObjectPositions,{xx,yy,zz})
end

end
-- getAllObjectInfo
function getAllObjectInfo()
	local o,n,p,r,s,c,h = 'gObjectWTFs={', 'gObjectNames={', 'gObjectPositions={', 'gObjectRotations={', 'gObjectSizes={', 'gObjectColls={', 'gObjectHUDs={'

	for i=1,#zObjectNames,1 do
	
		local x,y,z=zObjectPositions[i][1],zObjectPositions[i][2],zObjectPositions[i][3]
		o=o..'"'..zObjectWTFs[i]..'"';
		p=p.."{"..x..","..y..","..z.."}";
		n=n..'"'..zObjectNames[i]..'"';
		c=c..tostring(zObjectColls[i]);
		r=r.."{0.0,0.0,0.0}";
		s=s.."{100.0,100.0,100.0}";
		h=h.."false";
		if i ~= #zObjectNames then
			o=o..",";
			p=p..",";
			n=n..",";
			c=c..",";
			r=r..",";
			s=s..",";
			h=h..",";
		else
			o=o.."\}".."\n"
			p=p.."\}".."\n"
			n=n.."\}".."\n"
			c=c.."\}".."\n"
			r=r.."\}".."\n"
			s=s.."\}".."\n"
			h=h.."\}".."\n"
			objectInfoOut = o..n..p..r..s..c..h
		end
end
	return objectInfoOut	
end
-- saveLoadScript
function saveLoadScript()
	math.randomseed(os.time())
	maxEnemy=EnemyFld:value()
	maxHumans=HumansFld:value()
	createEntities();
	createEnemy();
	zObjectPositions[3]=zObjectPositions[4]
	table.insert(zObjectWTFs,"Misc/zfpsmainmenu.wtf")
	table.insert(zObjectNames,"zfpsmainmenu1")
	table.insert(zObjectColls,"true")
	table.insert(zObjectPositions,{59,9,73})
	
	allobjectinfo = getAllObjectInfo();
	
	RNDFPSLoadScriptOut = "-".."- Begin of auto-script\n"..RNDFPSLoadScript[1]..RNDFPSLoadScript[2]..allobjectinfo..RNDFPSLoadScript[3]..RNDFPSLoadScript[4]..RNDFPSLoadScript[5]
	if  string.len(LevelNameFld:value()) <= 4  then
	levelName  = AutoLevelName() 
	LevelNameFld:value(levelName) 
	RNDZFPSWindow:redraw()

	end
	levelName = LevelNameFld:value()
	ig3d_CreateDirectory_s(gameroot.."Data/Levels/"..levelName) --create folder 
	
	meshout=gameroot.."Data/Levels/"..levelName.."/"..levelName.."_mesh.wtf"
	copyFile(RNDZFPSMesh,meshout)
	levelFile = gameroot.."Data/Levels/"..levelName.."/load script.lua"
	
	local f=io.open(levelFile, "w")
	if f ~= nil then 
	f:write(RNDFPSLoadScriptOut)
	f:close()
	end
	PlayBtn:show()
end; --saveLoadScript
--playRNDFPS
function playRNDZFPS()
cLevel = ig3d_GetLevelName__s()
if Fl:event_key() == 32 then return end
RNDFPSMakerLevel = "Data/Levels/"..LevelNameFld:value()
--if cLevel ~= RNDFPSMakerLevel then
loadLevel(RNDFPSMakerLevel)
--end
end
--filterTableSubOneFor
function filterTableSubOneFor(t,s)
for i,v in pairs(t) do
if v[1]==s then return true end
end
return false
end
--fill_ZFPSBrowsers
function fill_ZFPSBrowsers(p)
CharacterBrowser:clear()
AddedBrowser:clear()
local d = false
local t={}


if p==nil then p = gChosenCategory end

if string.find(p,"Humans")~=nil then 
glistedFiles = HumansList 
t = AddedHumans
end

if string.find(p,"Enemies")~=nil then 
glistedFiles = EnemiesList 
t = AddedEnemies
end

if string.find(p,"Weapons")~=nil then 
glistedFiles = WeaponsList 
t = AddedWeapons
end

if string.find(p,"Defaults")~=nil then
glistedFiles = zObjectWTFs
t = glistedFiles
d=true
end
--print(p)


	for i,v in pairs(glistedFiles) do
	s=string.gsub(v,".wtf","")
	 CharacterBrowser:add(s) 
	end
	if d==false then
	for i,v in pairs(t) do
	s=string.gsub(v[1],".wtf","")
	 AddedBrowser:add(s) 
	end
	end
	
	
end
--fill_WeaponBrowsers
function fill_WeaponBrowsers(w)
CharacterBrowser:clear()
AddedBrowser:clear()
gChosenCategory = w:label()
glistedFiles = WeaponsList 
gCharacterPicked=""
t = AddedWeapons

	for i,v in pairs(WeaponsList) do
	s=string.gsub(v,".wtf","")
	--print(s)
	 CharacterBrowser:add(s) 
	end
	
	for i=1,#t,1 do
	b=t[i][1]
	if b~= nil then 
	s=string.gsub(b,".wtf","")
	 AddedBrowser:add(s) 
	 end
	end
	
end
--clickedRemove
function clickedRemove(w)
local n=w:value()
local t ={{}}
if n==nil or n== 0 then return end
local p=gChosenCategory
if p==nil then p = "Humans" end
if p=="Humans" then t = AddedHumans end
if p=="Enemies" then t = AddedEnemies end
if p=="Weapons" then t = AddedWeapons end
gCharacterPicked=t[n][1]
pn=t[n][2]
	
gCharacterPicked=string.gsub(gCharacterPicked,".wtf","")	

if p== "Humans" then
table.insert(HumansList,pn,gCharacterPicked)
table.remove(AddedHumans,n)
end

if p=="Enemies" then 
table.insert(EnemiesList,pn,gCharacterPicked)
table.remove(AddedEnemies,n)
end

if p=="Weapons" then 
table.insert(WeaponsList,pn,gCharacterPicked)
table.remove(AddedWeapons,n)
end

fill_ZFPSBrowsers(p)
end
--clickedAdd
function clickedAdd(w)
n=w:value()
a=""
if n==nil or n== 0 then return end

gCharacterPicked=glistedFiles[n]
gCharacterPicked=string.gsub(gCharacterPicked,".wtf","")

p=gChosenCategory
if p==nil then p = "Humans" end

if p== "Humans" then
if filterTableSubOneFor(AddedHumans,gCharacterPicked) == false then 
table.remove(HumansList,n)
table.insert(AddedHumans,{gCharacterPicked,n})
end
end

if p=="Enemies" then 
if filterTableSubOneFor(AddedEnemies,gCharacterPicked) == false then 
table.remove(EnemiesList,n)
table.insert(AddedEnemies,{gCharacterPicked,n})
end

end

if p=="Weapons" then 
if filterTableSubOneFor(AddedWeapons,gCharacterPicked) == false then 
table.remove(WeaponsList,n)
table.insert(AddedWeapons,{gCharacterPicked,n})
end

end
gChosenCategory=p
fill_ZFPSBrowsers(gChosenCategory)
end
--zfpsButton_cb
function zfpsButton_cb(w)
p=w:label()
gChosenCategory=p
gCharacterPicked=""
fill_ZFPSBrowsers(p)
end
--zfpsSaveButton_cb
function zfpsSaveButton_cb()
for i,v in pairs(AddedHumans) do
	s=string.gsub(v[1],".wtf","")
	 table.insert(zObjectWTFs,"Characters/"..s..".wtf")
	end
	saveLoadScript()
end
--revertToDefaultLists
function revertToDefaultLists(a,b,c)
for i,v in pairs(a) do
	for ii=#b,1,-1 do 
	vv=b[ii]

	if string.gsub(vv,".wtf","")==v then 
	table.insert(c,{v,ii})
	table.remove(b,ii)
	 
	break
	end
	end
end
return b,c
end
--zfpsDefaultButton_cb


function zfpsDefaultButton_cb()
local a = {}
local b = {}
local c = {{}}
AddedBrowser:clear()
if gChosenCategory=="Humans" then
AddedHumans={}
a=FPS_Humans
b=HumansList
c=AddedHumans
HumansList,AddedHumans = revertToDefaultLists(a,b,c)
end

if gChosenCategory=="Enemies" then
AddedEnemies={}
a=FPS_Enemy
b=EnemiesList
c=AddedEnemies
EnemiesList,AddedEnemies = revertToDefaultLists(a,b,c)
end

if gChosenCategory=="Weapons" then
AddedWeapons={}
a=FPS_Weapons
b=WeaponsList
c=AddedWeapons
WeaponsList,AddedWeapons = revertToDefaultLists(a,b,c)
end

end
--  randomizeZFPS
function randomizeZFPS()
n=#safeObjectPositions
theseed = math.floor( n/ math.random(4,6))

	maxEnemy=math.random(12,theseed)
	EnemyFld:value(maxEnemy)
	maxHumans=math.random(12,theseed)
	HumansFld:value(maxHumans)
	
hrnd=math.random(2,maxHumans)
ernd=math.random(2,maxEnemy)	
	
for i = 1,hrnd,1 do
if #HumansList <=1 then break end
r=math.random(1,#HumansList)

o=string.gsub(HumansList[r],".wtf","")
table.insert(AddedHumans,{o,r})
table.remove(HumansList,r)
end

for i = 1,ernd,1 do
if #EnemiesList <=1 then break end
r=math.random(1,#EnemiesList)
o=string.gsub(EnemiesList[r],".wtf","")
table.insert(AddedEnemies,{o,r})
table.remove(EnemiesList,r)
end

AddedWeapons={}
for i = 1,#FPS_Weapons,1 do
o=FPS_Weapons[i]
table.insert(AddedWeapons,{o,i})
end


fill_ZFPSBrowsers()


end
function maxflds_cb()

maxEnemy=EnemyFld:value()
maxHumans=HumansFld:value()
end
do RNDZFPSWindow= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "RNDZFPS")
RNDZFPSWindow:label(gLabelTable[#gLabelTable])
RNDZFPSWindow:resize(7,105,403,339)
RNDZFPSWindow:size_range(412,463,412,463)
--RNDZFPSWindow:show()
do HumansButton= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Humans")
HumansButton:label(gLabelTable[#gLabelTable])
HumansButton:callback(zfpsButton_cb)
HumansButton:resize(15,5,51,20)
HumansButton:labelsize(10)
end

do EnemiesButton= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Enemies")
EnemiesButton:label(gLabelTable[#gLabelTable])
EnemiesButton:callback(zfpsButton_cb)
EnemiesButton:resize(82,5,51,20)
EnemiesButton:labelsize(10)
end

do WeaponsButton= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Weapons")
WeaponsButton:label(gLabelTable[#gLabelTable])
WeaponsButton:callback(fill_WeaponBrowsers)
WeaponsButton:resize(150,5,51,20)
WeaponsButton:labelsize(10)
end

do DefaultsButton= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Defaults")
DefaultsButton:label(gLabelTable[#gLabelTable])
DefaultsButton:callback(zfpsDefaultButton_cb)
DefaultsButton:resize(265,5,60,20)
DefaultsButton:labelsize(10)
end

do CharacterBrowser= fltk:Fl_Browser(0,0,0,0,"")
CharacterBrowser:callback(clickedAdd)
CharacterBrowser:resize(15,30,190,240)
CharacterBrowser:type(2)
CharacterBrowser:labelsize(12)
CharacterBrowser:textsize(11)
end

do AddedBrowser= fltk:Fl_Browser(0,0,0,0,"")
AddedBrowser:callback(clickedRemove)
AddedBrowser:resize(207,30,178,240)
AddedBrowser:type(2)
AddedBrowser:labelsize(12)
AddedBrowser:textsize(11)
end

do SaveButton= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Save")
SaveButton:label(gLabelTable[#gLabelTable])
SaveButton:callback(zfpsSaveButton_cb)
SaveButton:resize(325,300,63,20)
SaveButton:labelsize(10)
end

do HumansFld= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Max Humans:")
HumansFld:label(gLabelTable[#gLabelTable])
HumansFld:callback(maxflds_cb)
HumansFld:resize(85,276,25,17)
HumansFld:labelsize(11)
HumansFld:minimum(1)
HumansFld:maximum(20)
HumansFld:step(1)
HumansFld:value(1)
HumansFld:textsize(11)
end

do EnemyFld= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Max Enemy:")
EnemyFld:label(gLabelTable[#gLabelTable])
EnemyFld:callback(maxflds_cb)
EnemyFld:resize(185,276,25,17)
EnemyFld:labelsize(11)
EnemyFld:minimum(1)
EnemyFld:maximum(20)
EnemyFld:step(1)
EnemyFld:value(1)
EnemyFld:textsize(11)
end

do LevelNameFld= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Level Name:")
LevelNameFld:label(gLabelTable[#gLabelTable])
LevelNameFld:resize(140,298,180,22)
LevelNameFld:labelsize(11)
LevelNameFld:textsize(11)
end

do PlayBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Play")
PlayBtn:label(gLabelTable[#gLabelTable])
PlayBtn:callback(playRNDZFPS)
PlayBtn:resize(325,275,63,20)
PlayBtn:labelsize(10)
end

do Randomize= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Random")
Randomize:label(gLabelTable[#gLabelTable])
Randomize:callback(randomizeZFPS)
Randomize:resize(245,275,60,20)
Randomize:labelsize(10)
end

do AutoBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Auto Name")
AutoBtn:label(gLabelTable[#gLabelTable])
AutoBtn:callback(AutoLevelName)
AutoBtn:tooltip("Auto Name Based On Fields Values")
AutoBtn:resize(15,300,60,20)
AutoBtn:labelsize(10)
end
end
RNDZFPSWindow:show()

RNDZFPSWindow:show()
RNDZFPSWindow:make_current()
fill_ZFPSBrowsers(gChosenCategory)
PlayBtn:hide()
--end
Fl:run()
