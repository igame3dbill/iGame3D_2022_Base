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
RTSFUNCTIONS={"Attributes","Utilities","Sounds","Tasks","Behaviours","Senses","Vehicles","Weapons","Orders","Events","AI","Collisions","Keyboard","Game","astar"}
		for i=1,#RTSFUNCTIONS,1 do
			tfile=gameroot.."Data/Scripts/Games/RTS_Functions/RTS_"..RTSFUNCTIONS[i]..".lua"
			dofile(tfile)
		end
	--initialize game object variables from init script and function
	init_all_objects() -- see RTS_Attributes.lua

	-- assign entities behavior
	RTSENTITIES={"Emitters","Human","Zombie","Building","Gun","Car","GUI","BloodPencil"}
		for i=1,#RTSENTITIES,1 do
			--	local tfile = gLevelPath.."RTS_Entities/RTS_"..RTSENTITIES[i]..".lua"
		local tfile = gameroot.."Data/Scripts/Games/RTS_Entities/RTS_"..RTSENTITIES[i]..".lua"
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
