-- RTS_Human.lua
humans={}

humanAnims = { {name="Stand", anims={ {name="Cellphone", linked=false},{name="EatStanding", linked=false} } } }


gZombieNames = {"zombie","slimed","snowed","ghost","hungry","mech","alien"}
function isZombie(n)
local pth=ig3d_GetObjectModelPath_s_s(getObjectInfo(gObjects[n].cObj, IG3D_NAME))
for i = 1,#gZombieNames,1 do 
if string.find(pth,gZombieNames[i]) then return true end
end
return false
end



gHumanNames={
"fatscifisoldierTB",
"fatscifizombieA",
"fatscifizombieB",
"swatsoldierTB",
"soldiersol1kTB",
"soldierusaTB",
"jackytruebones",
"robothead",
"civilianmale1TB",
"civilianmale2TB",
"civilianmale3TB",
"chick",
"ponchocorpgirl",
"tomdrinman1_3k",
"tomdrinman1_3k",
"tomdrinman2_3k",
"tomdrinman3_3k",
"tomdrinman4_3k",
"tomdrinman5_3k",
"tomdrinwoman1_3k",
"tomdrinwoman2_3k",
"tomdrinwoman3_3k",
"tomdrinwoman4_3k",
"tomdrinwoman5_3k",
"tomdrinman1longsleave",
"tomdrinman1police",
"tomdrinman1is5police",
"tomdrinwoman1_3kredhead",
"tomdrinwoman3police",
"tomdrinman2_3kblacknblue",
"tomdrinman2_3kladyman",
"tomdrinman2tronguy",
"tomdrinman4_3kgreenbeard",
"tomdrinman5_police",
"scientist",
"scientistold",
"thug_mustafa",
"thug_melvin",
"thug_jackson",
"thug_rufus",
"thug_fatjackblack",
"thug_fatjack",
"thug_miguel",
"soldierboyTB",
"swatfemale1k",
"bumpywoman",
"bumpywoman2","jacky",
"masterchief",
"officer1",
"officer2",
"anita",
"mcTr",
"true",
"human",
"fighter",
"chick",
"tomd",
"soldier",
"thug"}

function isHuman(n)

for i=1,#gHumanNames,1 do
	if gHumanNames[i] == nil then return end
	if string.find( getObjectInfo(gObjects[n].cObj, IG3D_MODEL),"zombie") then return false end
	if string.find( getObjectInfo(gObjects[n].cObj, IG3D_MODEL),"slimed") then return false end
	if string.find( getObjectInfo(gObjects[n].cObj, IG3D_MODEL),"snowed") then return false end
	if string.find( getObjectInfo(gObjects[n].cObj, IG3D_MODEL),"hungry") then return false end
	if string.find( getObjectInfo(gObjects[n].cObj, IG3D_MODEL),"ghost") then return false end
	if string.find( getObjectInfo(gObjects[n].cObj, IG3D_MODEL),"mech") then return false end
	if string.find( getObjectInfo(gObjects[n].cObj, IG3D_MODEL),"alien") then return false end
	if string.find( getObjectInfo(gObjects[n].cObj, IG3D_MODEL),gHumanNames[i]) then return true end
	end
return false
end


function isCharacter(n)
local pth=ig3d_GetObjectModelPath_s_s(getObjectInfo(gObjects[n].cObj, IG3D_NAME))
if string.find(pth,"WTF/Characters/") then return true end
return false
end



gTrackingLights={}
gTrackingLight= 2
function attachTrackLight()
if gTrackingLight < 9 then
		table.insert(gTrackingLights,{gTrackingLight,gObjects[i]})
		gTrackingLight = gTrackingLight + 1
		end	
end

function zfps_init_Humans()
local i
	for i=1,#gObjects,1 do
	if isCharacter(i) == true then
	
			if isHuman(i) == true and isZombie(i) ==false  then
			--additional repositioning, a house could have been placed above a human...
			
			putObjectOnGround(gObjects[i])
			gObjects[i].meleeDelay=0.5
			gObjects[i].animPickTable=humanAnims
			table.insert(humans, gObjects[i])		
			end
			else
			gObjects[i].alive = false 
		end
	end
end 
zfps_init_Humans()


function zfps_gauntlet_humans()
for i=1,#humans,1 do
obj=humans[i]
obj.followPlayer=false
	obj.hearingDistance=5.0
	obj.scareDistance=2
	obj.farDistance=1.0
	if math.random(1,5) == 1 then 
			obj.behaviour = gunned_civilian_behaviour
			end
end
end


function zfps_sniper_humans()
	for i=1,#humans,1 do
	obj=humans[i]
	local x,y,z=getObjectInfo(obj.cObj, IG3D_POSITION)
		if y > 1 then
		obj.followPlayer=false
		obj.isSniper=true
		obj.hearingDistance=40.0
		obj.scareDistance=2
		obj.farDistance=30.0
		obj.behaviour = sniper_behaviour
		end
			end
end

actors={}
function zfps_human_actor_LivingInn()
	local WTF="Characters/tomdrinman1_3k.wtf"
	local Name="humanActor"

	table.insert(gObjectWTFs,actorWTF)
	table.insert(gObjectNames,actorName )
	table.insert(gObjectPositions, {47,0.666,90.0})
	table.insert(gObjectSizes, {100,100,100})
	table.insert(gObjectRotations, {0,0,0})
	table.insert(gObjectColls, true)
	table.insert(gObjectHUDs, false) 
	local i=#gObjects+1 
gObjects[i].cObj=make(ig3d_object, gObjectWTFs[i])
setObjectInfo(gObjects[i].cObj, IG3D_NAME, gObjectNames[i])
	setObjectInfo(gObjects[i].cObj, IG3D_POSITION, gObjectPositions[i][1],gObjectPositions[i][2],gObjectPositions[i][3])
	setObjectInfo(gObjects[i].cObj, IG3D_ROTATION, gObjectRotations[i][1],gObjectRotations[i][2],gObjectRotations[i][3])
	setObjectInfo(gObjects[i].cObj, IG3D_SIZE, gObjectSizes[i][1],gObjectSizes[i][2],gObjectSizes[i][3])
	setObjectInfo(gObjects[i].cObj, IG3D_COLL, gObjectColls[i])
	setObjectInfo(gObjects[i].cObj, IG3D_HUD, gObjectHUDs[i])
	gObjects[i].animPickTable=humanAnims
		table.insert(humans, gObjects[i])
		table.insert(actors,gObjects[i])
		
		
end

function zfps_human_actor_behavior(obj)
obj.followPlayer=true
		obj.actor=true
		obj.hearingDistance=10
		obj.scareDistance=0
		obj.farDistance=4
		--obj.behaviour = follow_player
		obj.team = actorTeam
end
