-- ZFPS_Init with copies from RTS Init 01 03 09
gLevelPath = gameroot.."Data/Levels/"
gDoShadows=true
gMasterAnimSource = "mcTrueBones.wtf"
gSelectionRectModel = "selectionRect.wtf"
gTrackingLight = 3
gObjCycle = 2
gTeamSelect = 0
gLastClick=0
gDoubleClickInterval=0.4
gStatusString=""
gCameraSpeed=4
gVelocityClamp=0.1--1.16
levelislit = false
gHandle_ZFPSAI = true
gTrackLightEnabled = false
gNextZFPSLevel=nil
gCapsLockKey=false
-- this tracks the screamer with  light 5
gScreamer = nil 
gScreamX,gScreamY,gScreamZ = nil,nil,nil
-- counts how long the gun flare is on
gGunLightCount = 0
reloadLevel = false ;-- added 02 08 2009 
gStartPositionTimer=0
gTeamSelect =0 ;-- added 02 26 2009 keyboard teleport
gTeleportTimerActive = false
gTeleportTime = 0
gTrackedPosition={}
gTrackedPosition.x,gTrackedPosition.y,gTrackedPosition.z =0,0,0
gTrackedObject = 3	
gDisplayLoading= false
gRestartLevel = false
gTimeBeforeLoad=0
gLoadingTextBoxNum=1
gLoadingBoxMessage=""
gTextualTimer=0
currentText = 1
gHideHUD=false
gWonThisLevel=false
gLastPlayerGunshot=0
gLastPlayerGrenadeThrow=0
Q='"'


--write currentlevel.lua to ZFPS folder
local tCurrentLevel=ig3d_GetLevelName__s()
if tCurrentLevel~="Data/Levels/ZFPS/ZFPS_Instructions" then
	local currentLevelFile = io.open(gameroot.."Data/Levels/ZFPS/currentlevel.lua","w")
	if currentLevelFile~=nil then
		local thislevelout="gCurrentLevel="..Q..tCurrentLevel..Q.."\n"
		currentLevelFile:write(thislevelout)
		currentLevelFile:close()
	end
end			
			
--- INSTRUCTIONS
gControlsScreenText=[[Controls
Mouse to look around
Click   To send a zombie to a location, or to attack a target
        Additional clicks send more zombies.

KEYS
W   move Forward
S   move Back
A   move Left
D   move Right

H or SPACE: all zombies will hold position until given orders

F   All zombies will follow the player
R   All zombies rush attack, seeking out any  living to eat
I   Activates the help text
Z   Toggles 'zombie time' slow motion
M   Toggles music
L   Toggles HUD

CMD+O to access unlocked levels

ESCAPE activates the menu
]]



-- Preload Scripts
dofile(gameroot.."Data/Scripts/Default/Base/math_functions.lua")



-- USING RTS SCRIPTS?!? ARGH Lets move what we can to ZFPS specifics!
	RTSFUNCTIONS={"Attributes","Utilities","Sounds","Tasks","Behaviours","Senses","Vehicles","Weapons","Orders","Events","AI","Collisions","Keyboard","astar","Game"}
		for i=1,#RTSFUNCTIONS,1 do
		tfile=gameroot.."Data/Scripts/Games/RTS_Functions/RTS_"..RTSFUNCTIONS[i]..".lua"
		dofile(tfile)
		end




--initialize game object variables from init script and function
init_all_objects() -- see RTS_Attributes.lua


ZFPSFUNCTIONS = {"Editor","Lights","AI","Utilities","Sounds","Fallback","Textboxes","Keyboard","Game","Music","HUD","Behaviours"}
	for i=1,#ZFPSFUNCTIONS,1 do
			tfile=gameroot.."Data/Scripts/Games/ZFPS_Functions/ZFPS_"..ZFPSFUNCTIONS[i]..".lua"
			dofile(tfile)
		end


	-- assign ZFPS entities behavior Now in its own ZFPS Folder
ZFPSENTITIES={"Teams","Emitters","Human","Zombie","Building","Gun","Car","GUI","Window","Door","Scenery","BloodPencil","MeleeWeapons","LevelExits","Furniture","Grenade","Menu"}
		for i=1,#ZFPSENTITIES,1 do
		local tfile = gameroot.."Data/Scripts/Games/ZFPS_Functions/ZFPS_Entities/ZFPS_"..ZFPSENTITIES[i]..".lua"
		dofile(tfile)
		end


-------------------
function zfps_init()
	setObjectInfo(playerBox, IG3D_CAST_SHADOW, false)
	
	-- further initialization
	randomWalking= walk_between_safe_places --replace the random walking
	standard_flee= flee_to_safe_place --replace flee
	
	gZombieBehaviour=zombie_hold_behaviour

	
	playerGunSound = assign_free_sound_emitter()
	setSound_emitterInfo(playerGunSound, IG3D_SAMPLE, "Data/Sounds/rifle.ogg")
	setSound_emitterInfo(playerGunSound, IG3D_LOOP, false)--true
	
	local i
	for i=1,#gObjects,1 do
		setObjectInfo(gObjects[i].cObj, IG3D_BONE_COLL, false)--no bone colls for heavens sake!
		if gObjects[i].team==0 or gObjects[i].team==1 then
			--setObjectInfo(gObjects[i].cObj, IG3D_SHAPE, ig3d_sphere) --sphere sucks
			setObjectInfo(gObjects[i].cObj, IG3D_COLLBOX_MULTIPLICATORS, 0.5,1,1)--brave new world!
		end
		
		if gObjects[i].team==1 and gObjects[i].alive then
			gObjects[i].behaviour= gZombieBehaviour
			gObjects[i].noise=0.2
			--gObjects[i].meleeDistance=2
		end
		
		if gObjects[i].team==0 then
			--dead on a papercut
			
			if string.sub(tCurrentLevel,-4,-1) ~= "Hard" then
				gObjects[i].behaviour= idle_until_zombie_in_sight
			end
			
			
			gObjects[i].health=1
			gObjects[i].voiceSndEmt=assign_free_sound_emitter()--people need to scream etc.
			
		end
		setSound_emitterInfo(gObjects[i].voiceSndEmt, IG3D_VOLUME, 80)--3
		setSound_emitterInfo(gObjects[i].noiseSndEmt, IG3D_VOLUME, 80)--3
	end
	
	setObjectInfo(playerBox, IG3D_COLLBOX_MULTIPLICATORS, 1,1,1)--brave new world!
	setObjectInfo(playerBox, IG3D_SHAPE, ig3d_sphere)--sphere
	
	xa,ya,za=getCameraInfo(IG3D_ROTATION)
	setLightInfo(2, IG3D_POSITION, 0,5,7,1)
	setCameraInfo(IG3D_POSITION, 0,15,0)
	setObjectInfo(playerBox, IG3D_POSITION, getCameraInfo(IG3D_POSITION))
	
	--setSceneInfo(IG3D_RECEIVE_SHADOW, gDoShadows)--do we cast shadows?

	--ignore reset
	for i=1,#gObjectWTFs,1 do
	setObjectInfo(gObjects[i].cObj, IG3D_POSITION, gObjectPositions[i][1],gObjectPositions[i][2],gObjectPositions[i][3])
end
	

	
	--setObjectInfo(playerBox, IG3D_IGNORE_OBJECT_COLLS, true)
	crosshair=gObjects[get(ig3d_object, "crosshair1")]
	crosshair.alive=false
	setObjectInfo(crosshair.cObj, IG3D_GRAVITY_MULTIPLIER, 0)
	crosshair.team=12
	setObjectInfo(crosshair.cObj, IG3D_POSITION, 0,0,-0.1)
	bloodonfloor=get(ig3d_particle_emitter, "bloodonfloor")
end

-----------------------------------------------------------
-- if not game mode don't do all this stuff
if ig3d_GetMode__i() == 4 then 	
HumansWithGuns()
HumansWithMeleeWeapons()
SoldiersWithGrenades()
--set hit sound and level of depth
allEntitySoundCollLOD() -- see RTS_Attributes.lua
setupAStarGrid()
end

-------------------------------------------------------------
-- Copied from FPS Init 
FPSgun = get(ig3d_particle_emitter,"fpsgun")
playerBox = get(ig3d_object, "playerbox")
setObjectInfo(gObjects[playerBox].cObj, IG3D_MODEL, "Characters/fatscifisoldierTB.wtf")
setObjectInfo(gObjects[playerBox].cObj, IG3D_MODEL, "Cubes/kiste.wtf")
--

setObjectInfo(playerBox,IG3D_POSITION,0.0,1,0.0)
setObjectInfo(playerBox,IG3D_SIZE,50,50,50)
looker=get(ig3d_bone, playerBox, "None")
setBoneInfo(looker, IG3D_ENABLED, false)
first=true
if FPSgun ==nil then print("Missing \"fpsgun\" emitter\n") end
if playerBox ==nil then print("Missing \"playerbox\" object\n") end
setSceneInfo(IG3D_MOUSE_VIEW, true, 1)
setObjectInfo(playerBox, IG3D_VECTOR_CONSTRAINT, 0,1,0)
setObjectInfo(playerBox, IG3D_GRAVITY_MULTIPLIER, 0.1)
setObjectInfo(playerBox, IG3D_IGNORE_COLL, true, ig3d_particle_emitter, FPSgun)
setParticle_emitterInfo(FPSgun, IG3D_IGNORE_COLL, true, ig3d_particle_emitter, FPSgun)--dont collide bullets with bullets
setObjectInfo(playerBox, IG3D_SHAPE, ig3d_sphere)
xa,ya,za=getCameraInfo(IG3D_ROTATION)
setLightInfo(2, IG3D_POSITION, 0,5,7,1)
gPlayerGun=assign_free_sound_emitter()
loadSound("Data/Sounds/pistolshot.ogg")
setSound_emitterInfo(gPlayerGun, IG3D_SAMPLE, "Data/Sounds/pistolshot.ogg")
-------------------------------------------------------------		



if ig3d_GetMode__i() == 4 then
--init phase
zfps_init()
zfps_place_objects_randomly()--haha!
zfps_create_safe_places_randomly()--ho ho ho

rts_update_living_and_dead_counts()
end  -- if not game mode don't do all this stuff

----------- re-init the player
gObjects[playerBox].alive=true
gObjects[playerBox].team= 0 -- human team
gObjects[playerBox].health=200
function nothing()

end
hiliteMarkedObjects=nothing