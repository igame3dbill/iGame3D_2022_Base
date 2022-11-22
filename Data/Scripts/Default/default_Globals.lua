gameroot=getSceneInfo(IG3D_ROOT)
gScreenWidth, gScreenHeight = 720,480
gScreenLeft, gScreenTop= 455 , 44
ig3d_SetWindowBounds_4i(gScreenLeft , gScreenTop, gScreenLeft+gScreenWidth ,gScreenTop+ gScreenHeight)
setSceneInfo(IG3D_CAMERA_DROP, true)

gInit_Function_Paths={{}}

gInit_LoadOrder={
"core",
"game script",
"default_Globals", 
"gDefault_Functions",  
"gDefault_UIFunctions",
"gDefault_MenuFunctions"}

gDefault_Functions={
"Base/string","Base/file", "Base/math","Base/fltk",
"Base/physics", "Base/help",
"Input/keyboard", "Input/mouse",
"Entity/camera", "Entity/object","Entity/scene",
"Entity/material", "Entity/textBox",
 "Entity/particle"}

gDefault_UIFunctions={"collect",
"animation",
"main_tool",
"edit_mode",
"dialog",
"screenshot",
"uv", "bone",
"mesh_editor",
"mesh_tool",
"mesh_tag","path",
"GLwindow",
"particlesbrowser"}

-- menus need to load after all other functions, some error if used  only in resetFunctions
gDefault_MenuFunctions={
"entities",
"objects",
"file",
"mesh",
"library",
"levels",
"edit",
"level",
"fluid",
"particles",
"wizard",
"main"}

function resetFunctions()
	gInit_Function_Paths={{}}
	
	
	for i=1,#gDefault_Functions,1 do
		dFunctionPath=gameroot.."Data/Scripts/Default/"..gDefault_Functions[i].."_functions.lua"
		table.insert(gInit_Function_Paths,{dFunctionPath, gDefault_Functions[i]})		
		dofile(dFunctionPath)
	end 
	
		for i=1,#gDefault_UIFunctions,1 do	
		dFunctionPath=gameroot.."Data/Scripts/Default/User_Interface/"..gDefault_UIFunctions[i].."_functions.lua"
		table.insert(gInit_Function_Paths,{dFunctionPath, gDefault_UIFunctions[i]})	
		dofile(dFunctionPath)
	end 

end

resetFunctions()
	--Main Tools Menu Functions	
	for i=1,#gDefault_MenuFunctions,1 do
	print(gDefault_MenuFunctions[i])
	aPath=gameroot.."Data/Scripts/Default/Menus/"..gDefault_MenuFunctions[i].."_menu.lua"
	table.insert(gInit_Function_Paths,{aPath, gDefault_MenuFunctions[i]})
	dofile(aPath)
	end

	
--September 26 2010  removed global variables from function resetToDefault, that function simply runs this whole file
meshTagListTable={}
nTagNumber=0

gPathList={}
selectedPath = 1
selectedPathValues={{}}
CBI=string.char(123)  ;-- "{" curly bracket in
CBO=string.char(125) ;-- "}" curly bracket out

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

gfoldersFound={}
gfilesFound={}
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


--olderbelow
gameroot=getSceneInfo(IG3D_ROOT)
-- load script auto script globals
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
gNumGroups=0
gTextboxes={}
-- default font
gDefaultFontA="Data/FontPngs/default32_1.png"
gDefaultFontB="Data/FontPngs/default32_2.png"
gFontFiles={{gDefaultFontA , gDefaultFontB}}
loadTexture(gDefaultFontA)
loadTexture(gDefaultFontB)
loadFont(gDefaultFontA,gDefaultFontB)

--setSceneInfo(IG3D_SKYBOX, "newskydesert.wtf")
gTextRed ,gTextGreen, gTextBlue, gTextAlpha = 0.400000, 0.400000, 1.000000, 1.000000
gFontSize=14
gFontLeading=28

-- default text box
gTextboxes={}
gTextboxFonts={"Data/FontPngs/default32_1.png"}
gTextboxPositions={{20,20}}
gTextboxSizes={gFontSize}
gTextboxColors={{gTextRed ,gTextGreen, gTextBlue, gTextAlpha}}
gNumTextboxes=0

-- the current level 
gTimedLevel=ig3d_GetLevelName__s(); --"Data/Levels/default"
gTimedLevelLoad=true
gTimedLevelLoadTime=time()



jiggley=1000
jigglex=1000
gSelBox=0
load=false
gCurObject=1
gMouse=false
gEditingMode="play"

gLastMenuPick=""


function resetToDefault()
loadLevel(gameroot.."Data/Levels/Default/")
end ;--resetToDefault

function listDefaults()
		print("Menu Functions:")
	for i =1,#gDefault_MenuFunctions,1 do print(gDefault_MenuFunctions[i]) end
		print("\nDefault Functions:")
	for i =1,#gDefault_Functions,1 do print(gDefault_Functions[i]) end
		print("\nUI Functions:")
	for i =1,#gDefault_UIFunctions,1 do print(gDefault_UIFunctions[i]) end
return
end

flup=fltk_update
function allup()
ig3d_DrawGL();
flup();
end
fltk_update=allup;
