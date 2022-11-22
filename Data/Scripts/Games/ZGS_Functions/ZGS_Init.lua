-- RTS MULTI FOLDER LEVEL LOAD PATTERNS 09 06 08
gLevelPath = gameroot.."Data/Levels/RTS/"
gDoShadows=false
gMasterAnimSource = "mcTrueBones.wtf"
gSelectionRectModel = "selectionRect.wtf"
gTrackingLight = 3
gObjCycle = 2
gTeamSelect = 0
--gTrackingLights={{1,gObjects[2].cObj}}

-- Preload Scripts
dofile(gameroot.."Data/Scripts/Default/Base/math_functions.lua")
RTSFUNCTIONS={"Attributes","Utilities","Sounds","Tasks","Behaviours","Senses","Vehicles","Weapons","Orders","AI","Collisions","Keyboard","Game","astar"}
		for i=1,#RTSFUNCTIONS,1 do
			tfile=gameroot.."Data/Scripts/Games/ZGS_Functions/ZGS_"..RTSFUNCTIONS[i]..".lua"
			print("dofile(".."'"..tfile.."'"..");")
			dofile(tfile)
		end
	--initialize game object variables from init script and function
	init_all_objects() -- see Attributes.lua

	-- assign entities behavior
	RTSENTITIES={"Emitters","Human","Zombie","Building","Gun","Car","GUI","BloodPencil"}
		for i=1,#RTSENTITIES,1 do
			local tfile = gameroot.."Data/Scripts/Games/ZGS_Functions/ZGS_Entities/ZGS_"..RTSENTITIES[i]..".lua"
			print("dofile(".."'"..tfile.."'"..");");
			dofile(tfile)
		end
HumansWithGuns()
--set hit sound and level of depth
allEntitySoundCollLOD() -- see Attributes.lua
-- Shadows

setSceneInfo(IG3D_RECEIVE_SHADOW, true)
setLightInfo(2, IG3D_POSITION, getLightInfo(1, IG3D_POSITION))
for i=1,#gTrackingLights,1 do
local rno=math.random(2,#gObjects)
if rno < #gObjects then
gTrackingLights[i][2]=gObjects[rno]
end
end

setupAStarGrid()
