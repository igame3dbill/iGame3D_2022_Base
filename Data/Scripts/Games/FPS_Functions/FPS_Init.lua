-- RTS MULTI FOLDER LEVEL LOAD PATTERNS 09 06 08
gLevelPath = gameroot.."Data/Levels/"
gDoShadows=true
gMasterAnimSource = "mcTrueBones.wtf"
gSelectionRectModel = "selectionRect.wtf"
gTrackingLight = 3
gObjCycle = 2
gTeamSelect = 0
setSceneInfo(IG3D_RECEIVE_SHADOW, true)
setLightInfo(2, IG3D_POSITION, getLightInfo(1, IG3D_POSITION))


dofile(gameroot.."Data/Scripts/Default/Base/math_functions.lua")
RTSFUNCTIONS={"Attributes","Utilities","Sounds","Tasks","Behaviours","Senses","Vehicles","Weapons","Orders","Events","AI","Collisions","Keyboard","Game","astar"}
		for i=1,#RTSFUNCTIONS,1 do
			tfile=gameroot.."Data/Scripts/Games/RTS_Functions/RTS_"..RTSFUNCTIONS[i]..".lua"
			dofile(tfile)
		end
	--initialize game object variables from init script and function
	--init_all_objects() -- see RTS_Attributes.lua

for i=1,#gObjects-1,1 do
	gObjects[i].hit=false
	gObjects[i].dedoll=0
	setObjectInfo(gObjects[i].cObj, IG3D_VECTOR_CONSTRAINT, 0,1,0)
	setObjectInfo(gObjects[i].cObj, IG3D_GRAVITY_MULTIPLIER, 1)
	setObjectInfo(gObjects[i].cObj, IG3D_MASS, 1,1,1,1)
end

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


	--dofile(gameroot.."Data/Scripts/Games/FPS_Functions/FPS_AI.lua") --crashy and doesn't workt FPS_Game.lua
	dofile(gameroot.."Data/Scripts/Games/FPS_Functions/FPS_Game.lua")


	


