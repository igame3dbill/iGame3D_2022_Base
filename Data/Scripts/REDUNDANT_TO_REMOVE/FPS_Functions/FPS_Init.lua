-- RTS MULTI FOLDER LEVEL LOAD PATTERNS 09 06 08
gLevelPath = gameroot.."Data/Levels/"
gDoShadows=true
gMasterAnimSource = "mcTrueBones.wtf"
gSelectionRectModel = "selectionRect.wtf"
gTrackingLight = 3
gObjCycle = 2
gTeamSelect = 0
--gTrackingLights={{1,gObjects[2].cObj}}

-- Preload Scripts
dofile(gameroot.."Data/Scripts/Default/Base/math_functions.lua")

RTSFUNCTIONS={"Attributes","Utilities","Sounds","Tasks","Behaviours","Senses","Vehicles","Weapons","Orders","AI","Collisions","Keyboard","astar","Game"}
		for i=1,#RTSFUNCTIONS,1 do
			tfile=gameroot.."Data/Scripts/RTS_Functions/RTS_"..RTSFUNCTIONS[i]..".lua"
			dofile(tfile)
		end
	--initialize game object variables from init script and function
	init_all_objects() -- see RTS_Attributes.lua

	-- assign entities behavior
	RTSENTITIES={"Emitters","Human","Zombie","Building","Gun","Car","GUI","BloodPencil"}
		for i=1,#RTSENTITIES,1 do
			--	local tfile = gLevelPath.."RTS_Entities/RTS_"..RTSENTITIES[i]..".lua"
		local tfile = gameroot.."Data/Scripts/RTS_Functions/RTS_Entities/RTS_"..RTSENTITIES[i]..".lua"
		dofile(tfile)
		end
HumansWithGuns()
--set hit sound and level of depth
allEntitySoundCollLOD() -- see RTS_Attributes.lua
-- RTS_Shadows

setSceneInfo(IG3D_RECEIVE_SHADOW, true)
setLightInfo(2, IG3D_POSITION, getLightInfo(1, IG3D_POSITION))
for i=4,#gTrackingLights,1 do
local rno=math.random(2,#gObjects)
if rno < #gObjects then
gTrackingLights[i][2]=gObjects[rno]
end
end
setupAStarGrid()
FPSgun = get(ig3d_particle_emitter,"fpsgun")
playerBox = get(ig3d_object, "playerbox")
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
FPSFUNCTIONS={"AI","Game"}
for i=1,#FPSFUNCTIONS,1 do
		local tfile = gameroot.."Data/Scripts/Games/FPS_Functions/FPS_"..FPSFUNCTIONS[i]..".lua"
		dofile(tfile)
		end
	
	


