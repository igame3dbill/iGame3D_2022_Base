--function make_window()
function disa(w)
w:enable(false)
end
local i,ii,iii
local maxFriends, maxEnemy, maxCars, maxBuildings = 20,20,12,15
local  numcars,numEnemy, numMotherShips, numguns = 0,0,0,1
afterburnercount = 0
zInitStrings=""
RNDiFLYLoadScript={}
iFly_Friends={"avatarp1"}
iFly_Enemy={"enemyfighter"}
iFly_MotherShip={"airfrigatep1"}
iFly_WaterPlane={"Floors/waterplane"}


levelInput = ""
zObjectWTFs={"Powerups/powerup.wtf","Floors/waterplane.wtf"}

zObjectNames={"StrafingPowerUp","water"}
zObjectColls={true,true}
zObjectPositions={{0.0,-10000.0,0.0},{0.0,0.0,0.0}}
zObjectRotations={}
zObjectHuds={}
zInitStrings=zInitStrings.."water=gObjects[2]\n"

initParticles={"gun","fire","shrabnel","bigFire","fshrabnel","smoke","splash","lilsplash","clouds","friendshrabnel","motherengine"}
zParticleNamesAndEMTs={{"BoardGun","Data/Emitters/tracer.emt"},{"Fire","Data/Emitters/explosion.emt"},{"PlayerShrabnel","Data/Emitters/playerexplode.emt"},{"BiggerFire","Data/Emitters/fire.emt"},{"FighterShrabnel","Data/Emitters/fighterexplode.emt"},{"Smoke","Data/Emitters/smoke.emt"},{"Splash","Data/Emitters/seasplash.emt"},{"LittleSplash","Data/Emitters/lilsplash.emt"},{"Clouds","Data/Emitters/cloud.emt"},{"FriendShrabnel","Data/Emitters/friendexplode.emt"},{"MotherEngine","Data/Emitters/engine.emt"}}
for i = 1,#initParticles,1 do
zInitStrings=zInitStrings..initParticles[i].."=gParticleEmitters["..i.."]\n"
end


math.randomseed(os.time())
local LevelComplexity=math.random(4,12)
local plx,plz 
local ply = 100.0
local blx,blz = 0,0
print("LevelComplexity=",LevelComplexity)
entityPos={}
zSoundEmitterNames={"Snd1","Engine"}
zSoundEmitterPositions={{0.000000,0.000000,0.000000},{500.000000,100.000000,-500.000000}}
zSoundEmitterSamples={"Data/Sounds/planehit.ogg","Data/Sounds/planefly.ogg"}


zInitStrings=zInitStrings.."hitSnd=gSoundEmitters[1]\n engineSnd=gSoundEmitters[2]\n"




zTextboxFonts={"Data/FontPngs/default32_1.png"}

EnemyTableText="--enemy table building\n"
zEnemies={}
zEnemySndEmitters={}
zEnemyParticleEmitters1={}
zEnemyTextboxes={}
zEnemyAfterBurners={}
zEnemyParticleEmitters2={}
FriendTableText="--friend table building\n"
zFriends={}
zFriendSndEmitters={}
zFriendParticleEmitters={}

MotherShipPos ={}
-- create MotherShipPos positions  at 64 units per square
for i = -488,488,64 do
for ii = -488,488,64 do
table.insert(MotherShipPos,{i,ii})
end
end
-- RNDiFLY  load Script loadMesh in [1]
RNDiFLYLoadScript["mesh"]='loadMesh("Data/WTF/PathSources/cloudpath.wtf")\n'
-- sounds, fonts  fonts,  [2]

RNDiFLYLoadScript["textures"]=[[
gTextureFiles={"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png","Data/Images/Effects/cloud.png","Data/Images/Street/rollfield.png","Data/Images/Foliage/grass.png","Data/Images/Vehicles/drewjetfighter.png","Data/Images/Weapons/muzzleflash.png","Data/Images/Effects/explosion640.png","Data/Images/Effects/contrail.png","Data/Images/Effects/seasplash.png","Data/Images/Effects/engineblue.png","Data/Images/Vehicles/airfrigate1.png","Data/Images/Dirt/sand.png","Data/Images/Vehicles/afterburn.png","Data/Images/Vehicles/enemyfighter1.png","Data/Images/Weapons/tracer.png","Data/Images/skybox/skybox3.png","Data/Images/Effects/wolken.png","Data/FontPngs/crosshairs32_1.png","Data/FontPngs/crosshairs32_2.png","Data/Images/Effects/smoke.png"}
for i=1,#gTextureFiles,1 do
	loadTexture(gTextureFiles[i])
end
]]

RNDiFLYLoadScript["sounds"]=[[
for i=1,#gSoundFiles,1 do loadSound(gSoundFiles[i]) end
]]

RNDiFLYLoadScript["fonts"]=[[
for i=1,#gFontFiles,1 do loadFont(gFontFiles[i][1],gFontFiles[i][2]) end
]] -- end of [2]
--  object generation here at [3]

RNDiFLYLoadScript["objects"]=[[
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
gNumObjects=#gObjectWTFs
]]
-- the rest of autoscript goes here in [4]
RNDiFLYLoadScript["particles"] = [[


for i=1,#gParticleNamesAndEMTs,1 do
	gParticleEmitters[i]=make(ig3d_particle_emitter, gParticleNamesAndEMTs[i][1], gParticleNamesAndEMTs[i][2])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_POSITION, gParticlePositions[i][1],gParticlePositions[i][2],gParticlePositions[i][3])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_ROTATION, gParticleRotations[i][1],gParticleRotations[i][2],gParticleRotations[i][3])
end
gNumParticleEmitters=#gParticleNamesAndEMTs
]]




RNDiFLYLoadScript["soundemitters"]  =[[
gSoundEmitters={}
for i=1,#gSoundEmitterNames,1 do
	gSoundEmitters[i]=make(ig3d_sound_emitter, gSoundEmitterNames[i])
	setSound_emitterInfo(gSoundEmitters[i], IG3D_POSITION, gSoundEmitterPositions[i][1],gSoundEmitterPositions[i][2],gSoundEmitterPositions[i][3])
	setSound_emitterInfo(gSoundEmitters[i], IG3D_SAMPLE, gSoundEmitterSamples[i])
end
gNumSoundEmitters=#gSoundEmitterNames
]]

RNDiFLYLoadScript["textboxes"]=[[
gTextboxes={}
for i=1,#gTextboxFonts,1 do
	gTextboxes[i]=make(ig3d_text_box, gTextboxFonts[i])
	setText_boxInfo(gTextboxes[i], IG3D_POSITION, gTextboxPositions[i][1],gTextboxPositions[i][2])
	setText_boxInfo(gTextboxes[i], IG3D_SIZE, gTextboxSizes[i])
	setText_boxInfo(gTextboxes[i], IG3D_COLOR, gTextboxColors[i][1],gTextboxColors[i][2],gTextboxColors[i][3], gTextboxColors[i][4])
end
gNumTextboxes=#gTextboxFonts
]]

RNDiFLYLoadScript["sceneinfo"] =[[
setSceneInfo(IG3D_TINT_COLOR, 1.000000,1.000000,1.000000)
setSceneInfo(IG3D_FOG, true,0.859000,0.906000,0.949000,0.000000,8000.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.000000,0.000000,0.000000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setSceneInfo(IG3D_SKYBOX, "Skybox/newskydesert.wtf")
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, 0.000000,1.000000,0.000000,0.000000)
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
]] -- end of RNDiFLYLoadScript[4]
-- init files and game func in [5]
RNDiFLYLoadScript["enemyfriendtables"] = [[
--enemy table building
--friend table building

]]

RNDiFLYLoadScript["gameglobals"] = [[
dofile(getSceneInfo(IG3D_ROOT).."Data/Scripts/Games/iFly_Functions/iFly_Init.lua") 
]]



RNDiFLYLoadScript["gamefunc"] = [[

 -------------------------
game_func=airforce
coll_p_m=particlesAgainstMesh
coll_o_m=objectsAgainstMesh
coll_o_p=objectsAgainstParticles
coll_o_o=objectsAgainstObjects

]] -- end random ifly post auto script
-- AutoLevelName
function AutoLevelName()
Brnd = BuildingsFld:value()
Hrnd = FriendsFld:value()
Grnd = GunsFld:value()
Crnd = CarsFld:value()
Zrnd = EnemyFld:value()
levelName = "B"..Brnd.."_".."H"..Hrnd.."_".."G"..Grnd.."_".."C"..Crnd.."_".."Z"..Zrnd.."_iFLY"
LevelNameFld:value(levelName) 
RNDiFLY_Maker:redraw()
return levelName
end
-- updateTotal
function updateTotal()
totalObjs= BuildingsFld:value()+FriendsFld:value()+GunsFld:value()+CarsFld:value()+EnemyFld:value()
TotalFld:value(totalObjs)
end
-- randomizeit
function randomizeit()
Brnd = math.random(1,20)
Hrnd = math.random(1,20)
Grnd = math.random(1,20)
Crnd = math.random(1,20)
Zrnd = math.random(1,20)
BuildingsFld:value(Brnd)
FriendsFld:value(Hrnd)
GunsFld:value(Grnd)
CarsFld:value(Crnd)
EnemyFld:value(Zrnd)
levelName = "B"..Brnd.."_".."H"..Hrnd.."_".."G"..Grnd.."_".."C"..Crnd.."_".."Z"..Zrnd.."_iFLY"
LevelNameFld:value(levelName)
updateTotal()
PlayBtn:hide()
end
-- createWalls after making houses

function createWalls()
local HouseWallMap={}
	table.insert(HouseWallMap,{8,0})
	table.insert(HouseWallMap,{-8,0})
	table.insert(HouseWallMap,{0,-8})
	table.insert(HouseWallMap,{0,8})
	for i =1,4,1 do
	wallWTF = nil
	 rndWallChance = math.random(1,4)
		if rndWallChance ~= 1 then 
		rndWall = math.random(1,#HouseWallMap)
		local tlx = HouseWallMap[rndWall][1]
		local tlz = HouseWallMap[rndWall][2]
	
	
			if tlz ~= 0 then
			nwall =   math.random(1,#iFLY_WallsWide)
			wallWTF = iFLY_WallsWide[nwall] -- "brickwall8x1xp5"
			wlx = blx
			wlz = blz+tlz
			end
	
				if tlx ~= 0 then
				nwall =   math.random(1,#iFLY_WallsLong)
				wallWTF =   iFLY_WallsLong[nwall]
				wlx = blx+tlx
				wlz = blz
				end
		
		table.insert(zObjectPositions,{wlx,3.0,wlz})
		numwalls = numwalls + 1
		local	tObj, tNam = "Buildings/"..wallWTF..".wtf", "wall"..numwalls
		table.insert(zObjectWTFs,tObj)
		table.insert(zObjectNames,tNam )
		table.insert(zObjectColls,true)
		table.remove(HouseWallMap,rndWall) 
		end
	
	end
	
	
end
-- create Mothership first to clear MothershipPos tables, entities exist in the remaining spaces

function createMotherShip()
local i,ii,iii
numMotherShips = 0
maxMotherShip = BuildingsFld:value()
maxMotherShip =1

	for iii = 1,maxMotherShip,1 do	
	    numMotherShips = numMotherShips + 1
		local rndB = math.random(1,#iFly_MotherShip)
		local	tObj, tNam = "Vehicles_air/"..iFly_MotherShip[rndB]..".wtf", "EnemyMothership"..numMotherShips
		table.insert(zObjectWTFs,tObj)
		table.insert(zObjectNames,tNam )
		table.insert(zObjectColls,true)
zInitStrings =zInitStrings .. "mother=gObjects["..#zObjectWTFs.."]\n"

-- set position	
	
	local rndPos = math.random(1,#MotherShipPos)
	local blx = MotherShipPos[rndPos][1]
	local blz = MotherShipPos[rndPos][2]
	table.insert(zObjectPositions,{blx,100.0,blz})
	table.remove(MotherShipPos,rndPos)
	
	
	end
end
-- generate entity spaces from the remaining empty housePos values 

function EntityLocations()

for i=1,#MotherShipPos-1,1 do
	local ex,ez = MotherShipPos[i][1],MotherShipPos[i][2]
	print(ex,ez)
	for ii = ex-28,ex+28,4 do
		for iii = ez-28,ez+28,4 do
		table.insert(entityPos,{ii,iii})
		end
	end
end
end
-- get positions from a defined table of spaces that don't have houses
function setEntityPos()

local rndPos = math.random(1,#entityPos)
plx = entityPos[rndPos][1]
plz = entityPos[rndPos][2]
table.remove(entityPos,rndPos) 
table.insert(zObjectPositions,{plx,300.0,plz})
return plx,plz
end
-- createPlayerShip first 

function createPlayerShip()
table.insert(zObjectWTFs,"Vehicles_air/avatarp1.wtf")
table.insert(zObjectNames,"ship")
table.insert(zObjectColls,true)
table.insert(zObjectPositions,{500.0,200.0,-500.0})
zInitStrings = zInitStrings .. "ship=gObjects["..#zObjectWTFs.."]\n";


table.insert(zSoundEmitterNames,"playergun")
table.insert(zSoundEmitterSamples,"Data/Sounds/turret.ogg")
table.insert(zSoundEmitterPositions,{0.0,0.0,0.0})
zInitStrings=zInitStrings.."gunSnd=gSoundEmitters["..#zSoundEmitterNames.."]\n";

table.insert(zObjectWTFs,"Vehicles_air/afterburner.wtf")
table.insert(zObjectNames,"PlayerAfterburner")
table.insert(zObjectColls,false)
table.insert(zObjectPositions,{500.0,100.0,-500.0})
zInitStrings = zInitStrings .. "ship.afterburner=gObjects["..#zObjectWTFs.."]\n";
end
-- generate Enemy
function createEnemy()
maxEnemy=EnemyFld:value()
	for ii = 1,maxEnemy,1 do
		
		local rndZ = math.random(1,#iFly_Enemy)
		local tObj,tNam = "Vehicles_air/"..iFly_Enemy[rndZ]..".wtf", "enemy"..ii
		table.insert(zObjectWTFs,tObj)
		table.insert(zObjectNames,tNam)
		table.insert(zObjectColls,true)
		
		table.insert(zEnemies,#zObjectWTFs)
		
		enemyGunName = "EnemyGun"..ii
		enemyTracerName = "EnemyTracer"..ii
		tracerFile = "Data/Emitters/tracer.emt"
		table.insert(zParticleNamesAndEMTs, {enemyGunName,tracerFile})
		table.insert(zEnemyParticleEmitters1,#zParticleNamesAndEMTs)
		
		
		nextzParticles = #zParticleNamesAndEMTs+1
		table.insert(zParticleNamesAndEMTs, {enemyTracerName,tracerFile})
		
		table.insert(zEnemyParticleEmitters2,#zParticleNamesAndEMTs)
		
		
		table.insert(zSoundEmitterNames, "enemy"..ii)
		table.insert(zSoundEmitterPositions,{0.0,0.0,0.0})
		table.insert(zSoundEmitterSamples,"")
		table.insert(zEnemySndEmitters,#zSoundEmitterNames)
		
		table.insert(zTextboxFonts,"Data/FontPngs/crosshairs32_1.png")
		table.insert(zEnemyTextboxes,#zTextboxFonts)
		
	end
	
	for ab= 1,maxEnemy,1 do
	afterburnercount = afterburnercount + 1
		table.insert(zObjectWTFs,"Vehicles_air/afterburner.wtf")
		table.insert(zObjectNames,"afterburner"..afterburnercount)
		table.insert(zObjectColls,false)
		table.insert(zEnemyAfterBurners,#zObjectWTFs)
		end
	
	local t = ""
	for i =1,#zEnemies,1 do 
	t=t.."gObjects["..zEnemies[i].."], "
	end
	EnemyTableText=EnemyTableText.."gEnemies={"..string.sub(t,1,-3).."}\n"
	
	t=""
	for i = 1,#zEnemyAfterBurners,1 do 
	t=t.."gObjects["..zEnemyAfterBurners[i].."], "
	end
	
	EnemyTableText=EnemyTableText.."gEnemyAfterburners={"..string.sub(t,1,-3).."}\n"


	t=""
	for i = 1,#zEnemySndEmitters,1 do 
	t=t.."gSoundEmitters["..zEnemySndEmitters[i].."], "
	end
	EnemyTableText=EnemyTableText.."gEnemySndEmitters={"..string.sub(t,1,-3).."}\n"
	
	t=""
	for i = 1,#zEnemyParticleEmitters1,1 do 
	t=t.."gParticleEmitters["..zEnemyParticleEmitters1[i].."], "
	end
	EnemyTableText=EnemyTableText.."gEnemyParticleEmitters1={"..string.sub(t,1,-3).."}\n"
	
	t=""
	for i = 1,#zEnemyParticleEmitters2,1 do 
	t=t.."gParticleEmitters["..zEnemyParticleEmitters2[i].."], "
	end
		EnemyTableText=EnemyTableText.."gEnemyParticleEmitters2={"..string.sub(t,1,-3).."}\n"

	t=""
	for i = 1,#zEnemyTextboxes,1 do 
	t=t.."gTextboxes["..zEnemyTextboxes[i].."], "
	end
		EnemyTableText=EnemyTableText.."gEnemyTextboxes={"..string.sub(t,1,-3).."}\n"
RNDiFLYLoadScript["enemyfriendtables"]=RNDiFLYLoadScript["enemyfriendtables"]..EnemyTableText.."gNumEnemies=#gEnemies\n"
			
end
-- generate Friends and guns	
function createFriends()	
maxFriends=FriendsFld:value()
maxCars=CarsFld:value()
maxGuns=GunsFld:value()
		
for i = 1,maxFriends,1 do
	local rndH = math.random(1,#iFly_Friends)
	local tObj,tNam ="Vehicles_air/"..iFly_Friends[rndH]..".wtf" , "Friend"..i
	table.insert(zObjectWTFs, tObj)
	table.insert(zObjectNames,tNam)
	table.insert(zObjectColls,true)
	--plx,plz = setEntityPos()
	table.insert(zFriends,#zObjectWTFs)
	
	afterburnercount = afterburnercount + 1
		table.insert(zObjectWTFs,"Vehicles_air/afterburner.wtf")
		table.insert(zObjectNames,"afterburner"..afterburnercount)
		table.insert(zObjectColls,false)
		
	
	FriendGunName = "FriendGun"..i
		FriendTracerName = "FriendTracer"..i
		nextzParticle = #zParticleNamesAndEMTs+1
		zParticleNamesAndEMTs[nextzParticle]={{}}
		zParticleNamesAndEMTs[nextzParticle][1]=FriendGunName
		zParticleNamesAndEMTs[nextzParticle][2]="Data/Emitters/tracer.emt"
		table.insert(zFriendParticleEmitters,#zParticleNamesAndEMTs)
		
		
		
		table.insert(zSoundEmitterNames, "friend"..i)
		table.insert(zSoundEmitterPositions,{0.0,0.0,0.0})
		table.insert(zSoundEmitterSamples,"")
		table.insert(zFriendSndEmitters,#zSoundEmitterNames)
		
		
		
end



local t = ""
	for i =1,#zFriends,1 do 
	t=t.."gObjects["..zFriends[i].."], "
	end
	FriendTableText=FriendTableText.."gFriends={"..string.sub(t,1,-3).."}\n"
	
	
	
	t=""
	for i = 1,#zFriendSndEmitters,1 do 
	t=t.."gSoundEmitters["..zFriendSndEmitters[i].."], "
	end
	FriendTableText=FriendTableText.."gFriendSndEmitters={"..string.sub(t,1,-3).."}\n"
	
	t=""
	for i = 1,#zFriendParticleEmitters,1 do 
	t=t.."gParticleEmitters["..zFriendParticleEmitters[i].."], "
	end
	FriendTableText=FriendTableText.."gFriendParticleEmitters={"..string.sub(t,1,-3).."}\n"
	
		
	RNDiFLYLoadScript["enemyfriendtables"]=RNDiFLYLoadScript["enemyfriendtables"]..FriendTableText.."gNumFriends=#gFriends\n"
		

end
-- getLoadSounds

function getLoadSounds()
local Q,f = '"' , 'gSoundFiles={'
for i = 1,#zSoundEmitterNames, 1 do
local s=zSoundEmitterSamples[i]
local n=string.len(s)
	
	if n>3  then f=f..Q..s..Q  end
	
		if i~= #zSoundEmitterNames then
			if n>3  then  f=f..","  end
		else
			if string.sub(f,-1,-1) == "," then f = string.sub(f,1,-2) end
		f=f.."\}".."\n"
		end
		
end
	
	return f
		
end
-- getLoadFontFiles

function getLoadFontFiles()
local Q = '"' 
ff =  'gFontFiles={'
	for i=1,#zTextboxFonts,1 do 
	sfont=string.sub(zTextboxFonts[i],1,string.find(zTextboxFonts[i],"_") )
	ff=ff.."{"..Q..zTextboxFonts[i]..Q..","..Q..sfont.."2.png"..Q.."}";
		if i ~= #zTextboxFonts then
		ff=ff..",";
		else
		ff=ff.."\}".."\n"
		end
	end
	
	return ff
	
end
-- getAllObjectInfo
function getAllObjectInfo()
	local o,n,p,r,s,c,h = 'gObjectWTFs={', 'gObjectNames={', 'gObjectPositions={', 'gObjectRotations={', 'gObjectSizes={', 'gObjectColls={', 'gObjectHUDs={'
local Q='"'
	for i=1,#zObjectWTFs,1 do
		local x,y,z=zObjectPositions[i][1],zObjectPositions[i][2],zObjectPositions[i][3]
		o=o..Q..zObjectWTFs[i]..Q;
		p=p.."{"..x..","..y..","..z.."}";
		n=n..Q..zObjectNames[i]..Q;
		c=c..tostring(zObjectColls[i]);
		r=r.."{0.0,0.0,0.0}";
		s=s.."{100.0,100.0,100.0}";
		h=h.."false";
		if i ~= #zObjectWTFs then
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
-- getAllEmitterInfo
function getAllEmitterInfo()
	local o,p,r = 'gParticleNamesAndEMTs={', 'gParticlePositions={', 'gParticleRotations={'
	local Q = '"'
emitterInfoOut = ''
	for i=1,#zParticleNamesAndEMTs,1 do
		
		o=o..'{'..Q..zParticleNamesAndEMTs[i][1]..Q..","..Q..zParticleNamesAndEMTs[i][2]..Q..'}';
		p=p.."{0.0,0.0,0.0}";
		r=r.."{0.0,0.0,0.0}";
		
		if i ~= #zParticleNamesAndEMTs then
			o=o..",";
			p=p..",";		
			r=r..",";	
		else
			o=o.."\}".."\n"
			p=p.."\}".."\n"
			r=r.."\}".."\n"
			
			emitterInfoOut = o..p..r
		end
	end
	
	
	return emitterInfoOut	
end
-- getAllSoundInfo
function getAllSoundInfo()

local Q = '"'
emitterInfoOut = ''
local n,p,s = 'gSoundEmitterNames={', 'gSoundEmitterPositions={', 'gSoundEmitterSamples={'
	
	for i = 1,#zSoundEmitterNames, 1 do
	 	n=n..Q..zSoundEmitterNames[i]..Q;
	 	p=p.."{0.0,0.0,0.0}";
	 	s=s..Q..zSoundEmitterSamples[i]..Q;
	 	
	 	if i~= #zSoundEmitterNames then
	 		n=n..",";
			p=p..",";		
			s=s..",";
			
		 else
		        n=n.."\}".."\n";
			p=p.."\}".."\n";
			s=s.."\}".."\n";
		
			emitterInfoOut = n..p..s
		 end	 	 
	end
	return emitterInfoOut
end
-- getAllTextboxInfo
function getAllTextboxInfo()
	local f,p,s,c,ff = 'gTextboxFonts={', 'gTextboxPositions={', 'gTextboxSizes={', 'gTextboxColors={','gFontFiles={'
	local Q = '"'
textboxesInfoOut = ""
	for i=1,#zTextboxFonts,1 do
		
		f=f..Q..zTextboxFonts[i]..Q;
		p=p.."{1.0,1.0}";
		s=s.."32";
		c=c.."{1.0,0.0,0.0,1.0}";
		
		
		if i ~= #zTextboxFonts then
			f=f..",";
			p=p..",";		
			s=s..",";
			c=c..",";	
			ff=ff..",";
		else
			f=f.."\}".."\n"
			p=p.."\}".."\n"
			s=s.."\}".."\n"
			c=c.."\}".."\n"
			ff=ff.."\}".."\n"
			
			textboxesInfoOut = f..p..s..c
		end
	end
	

	return textboxesInfoOut	
end
-- saveLoadScript
function saveLoadScript()
	math.randomseed(os.time())
	createPlayerShip();
	createMotherShip();
	EntityLocations();
	createEnemy();
	createFriends();
	
	
	
	RNDiFLYLoadScriptOut = "-".."- Begin of auto-script\n"
	for i=1,#zObjectWTFs,1 do setEntityPos() end;
	
	dataouttables={}
	dataouttables["mesh"] = ""
	
	dataouttables["sounds"] = getLoadSounds();
	dataouttables["fonts"] = getLoadFontFiles();
	dataouttables["objects"] = getAllObjectInfo();
	dataouttables["particles"] = getAllEmitterInfo();
	dataouttables["soundemitters"] = getAllSoundInfo();
	dataouttables["textboxes"] = getAllTextboxInfo();
	dataouttables["enemyfriendtables"]=""
	dataouttables["sceneinfo"] = ""
	dataouttables["gameglobals"] = zInitStrings
	dataouttables["gamefunc"] = ""
	
	
	local T={"mesh","textures","sounds","fonts","objects","particles","soundemitters","textboxes","sceneinfo","enemyfriendtables","gameglobals","gamefunc"}
	for i = 1,#T,1 do
	local t = T[i]
	print(t)
	local s = RNDiFLYLoadScript[t]
	if dataouttables[t] ~= nil then s="\n"..dataouttables[t].."\n"..RNDiFLYLoadScript[t] end
	
	RNDiFLYLoadScriptOut=RNDiFLYLoadScriptOut..s
	end
	

	if  string.len(LevelNameFld:value()) <= 4  then
	levelName  = AutoLevelName() 
	LevelNameFld:add(leveName)
	print(levelName)
	end
	

	levelName = LevelNameFld:value()

	ig3d_CreateDirectory_s(gameroot.."Data/Levels/"..levelName) --create folder 

	levelFile = gameroot.."Data/Levels/"..levelName.."/load script.lua"

	local f=io.open(levelFile, "w")
	if f ~= nil then 
	f:write(RNDiFLYLoadScriptOut)
	f:close()
	end

PlayBtn:show()
end
function playRNDiFLY()
cLevel = ig3d_GetLevelName__s()


if Fl:event_key() == 32 then return end

RNDiFLYMakerLevel = "Data/Levels/"..LevelNameFld:value()
--if cLevel ~= RNDiFLYMakerLevel then
loadLevel(RNDiFLYMakerLevel)
--end



end
do RNDiFLY_Maker= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "RNDiFLY_Maker")
RNDiFLY_Maker:label(gLabelTable[#gLabelTable])
RNDiFLY_Maker:resize(632,50,186,164)
RNDiFLY_Maker:when(6)
--unknown attribute: hide
do BuildingsFld= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Buildings:")
BuildingsFld:label(gLabelTable[#gLabelTable])
BuildingsFld:callback(updateTotal)
BuildingsFld:resize(60,3,25,17)
BuildingsFld:labelsize(11)
BuildingsFld:minimum(1)
BuildingsFld:maximum(20)
BuildingsFld:step(1)
BuildingsFld:value(1)
BuildingsFld:textsize(11)
end

do FriendsFld= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Friends:")
FriendsFld:label(gLabelTable[#gLabelTable])
FriendsFld:callback(updateTotal)
FriendsFld:resize(60,23,25,17)
FriendsFld:labelsize(11)
FriendsFld:minimum(1)
FriendsFld:maximum(20)
FriendsFld:step(1)
FriendsFld:value(1)
FriendsFld:textsize(11)
end

do GunsFld= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Guns:")
GunsFld:label(gLabelTable[#gLabelTable])
GunsFld:callback(updateTotal)
GunsFld:resize(60,43,25,17)
GunsFld:labelsize(11)
GunsFld:minimum(1)
GunsFld:maximum(20)
GunsFld:step(1)
GunsFld:value(1)
GunsFld:textsize(11)
end

do CarsFld= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Cars:")
CarsFld:label(gLabelTable[#gLabelTable])
CarsFld:callback(updateTotal)
CarsFld:resize(145,3,25,17)
CarsFld:labelsize(11)
CarsFld:minimum(1)
CarsFld:maximum(20)
CarsFld:step(1)
CarsFld:value(1)
CarsFld:textsize(11)
end

do EnemyFld= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Enemy:")
EnemyFld:label(gLabelTable[#gLabelTable])
EnemyFld:callback(updateTotal)
EnemyFld:resize(145,23,25,17)
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
LevelNameFld:resize(15,128,160,17)
LevelNameFld:labelsize(11)
LevelNameFld:align(1)
LevelNameFld:textsize(11)
end

do TotalFld= fltk:Fl_Value_Output(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Total::")
TotalFld:label(gLabelTable[#gLabelTable])
TotalFld:resize(145,43,25,17)
TotalFld:labelsize(11)
TotalFld:textsize(11)
end

do SaveBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Save")
SaveBtn:label(gLabelTable[#gLabelTable])
SaveBtn:callback(saveLoadScript)
SaveBtn:resize(25,90,60,20)
SaveBtn:labelsize(10)
end

do PlayBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Play")
PlayBtn:label(gLabelTable[#gLabelTable])
PlayBtn:callback(playRNDiFLY)
PlayBtn:resize(110,90,60,20)
PlayBtn:labelsize(10)
end

do Randomize= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Randomize")
Randomize:label(gLabelTable[#gLabelTable])
Randomize:callback(randomizeit)
Randomize:resize(25,65,60,20)
Randomize:labelsize(10)
end

do AutoBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Auto Name")
AutoBtn:label(gLabelTable[#gLabelTable])
AutoBtn:callback(AutoLevelName)
AutoBtn:tooltip("Auto Name Based On Fields Values")
AutoBtn:resize(110,65,60,20)
AutoBtn:labelsize(10)
end
end
RNDiFLY_Maker:show()

RNDiFLY_Maker:show();
PlayBtn:hide();
RNDiFLY_Maker:make_current();
--end
Fl:run()
