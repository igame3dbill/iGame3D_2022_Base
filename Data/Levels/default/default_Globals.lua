gameroot=getSceneInfo(IG3D_ROOT)

function resetFunctions()
default_Functions={
"string","file","math","fltk","keyboard","mouse","camera","object","scene","physics","material","textBox","help","particle"}

for i=1,#default_Functions,1 do
--print(default_Functions[i])
dFunctionPath=gameroot.."Data/Scripts/Functions/"..default_Functions[i].."_functions.lua"
dofile(dFunctionPath)
end --



default_UIFunctions={"collect","animation","main_tool","edit_mode","dialog","screenshot","uv","bone","mesh_editor","mesh_tool","mesh_tag","path","GLwindow","material","particlesbrowser"}
for i=1,#default_UIFunctions,1 do
--print(default_UIFunctions[i])
uFunctionPath=gameroot.."Data/Scripts/Functions/"..default_UIFunctions[i].."_functions.lua"
dofile(uFunctionPath)
end -- for

end



function resetToDefault()
--01 12 09 
gScreenWidth,gScreenHeight = 740,420
	
--12252008adding
meshTagListTable={}
gPathList={}
selectedPath = 1
selectedPathValues={{}}
CBI=string.char(123)
CBO=string.char(125)
nTagNumber=0
vgridwidth=2
vgridlength=2
vcubewidth=2
vcubelength=2
vcubeheight=2
gridSize,cubeSize=2,2
gridSize,quadSize=2,2
gCellSize=2
TheFloor=nil
WEWall = nil
NSWall = nil
gDropx,gDropy,gDropz = 0,0,0
gDroprx,gDropry,gDroprz = 0,0,0
gDropsx,gDropsy,gDropsz = 100,100,100
gDropModel = ""	
gMeshExclusionList=""
--olderbelow
gameroot=getSceneInfo(IG3D_ROOT)
gObjects={}

gObjectWTFs={}
gObjectNames={}
gObjectPositions={}
gObjectRotations={}
gObjectSizes={}
gObjectColls={}
gObjectHUDs={}

gMeshObjectWTFs={}
gMeshObjectNames={}
gMeshObjectPositions={}
gMeshObjectRotations={}
gMeshObjectSizes={}

gParticleNamesAndEMTs={}
gParticlePositions={}
gParticleRotations={}
gParticleEmitters={}

gSoundEmitters={}
gGroups={}
gTextboxes={}
folders={}
files={}
folders={}
boxes={}
labels={}
levels={}
cameras={}
cameraKeyCount=-1
cameras.cx={}
cameras.cy={}
cameras.cz={}
cameras.cxa={}
cameras.cya={}
cameras.cza={}
gTimedLevel=ig3d_GetLevelName__s(); --"Data/Levels/default"
gTimedLevelLoad=true
gTimedLevelLoadTime=time()
gDefaultFontA="Data/FontPngs/default32_1.png"
gDefaultFontB="Data/FontPngs/default32_2.png"
loadTexture(gDefaultFontA)
loadTexture(gDefaultFontB)
loadFont(gDefaultFontA,gDefaultFontB)
--setSceneInfo(IG3D_SKYBOX, "newskydesert.wtf")
gTextRed,gTextGreen,gTextBlue,gTextAlpha = 0.400000, 0.400000, 1.000000, 1.000000
gFontSize=14
gFontLeading=28
jiggley=1000
jigglex=1000
gSelBox=0
load=false
gCurObject=1
gMouse=false
gEditingMode="play"
setSceneInfo(IG3D_CAMERA_DROP, true)
resetFunctions()
end

resetToDefault()

