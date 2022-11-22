--function make_window()
Q=string.char(34)--Quote
CBI=string.char(123)--CurlybracketIn
CBO=string.char(125)--CurlybracketOut

nc =  math.random(1,255)
newcolor = nc	


ig3d_SetMode_i(1)
baseBtnColor=16
grpGrid={}
drpGrid={}
drpColors={}

btnMakeList={}
btnListXY={{}}
btnList={}
textmapXY={}
XYSpawned={}
textArray={}
GridSize=52
GridSpread=8
nc =  math.random(1,255)
	newcolor = nc

currentLevel=1

meshDrawBrushSize = 1

WEWall = nil
NSWall = nil
TheFloor=nil
gMapName=item(-1,ig3d_GetLevelName__s(),"/")

gMapPath = gameroot.."Data/Levels/"..gMapName.."/"
gMapFile = gameroot.."Data/Levels/"..gMapName.."/"..gMapName.."mapXY.lua"
gMapMeshPath = gameroot.."Data/Levels/"..gMapName.."/"..gMapName.."map_mesh.wtf"
gMapOutFile=""
gBSDDungeonOutFile=""
-- match with RNDUDG 
gMapEnemy={}
gMapFriend={}
gMapPaths={}
gMapMaterials={}
gMapEmitters={}
gMapWeapons={}
gMapTags={}
gMapButtonColors={}
gMapFoundFloors={}
gMapFoundWalls={}

gMapRNDEnemy={}
gMapRNDFriend={}
gSelectedDropEntity=""


--
dsbtext2map={}
--dofile(gameroot.."Data/Scripts/Convert/DSB_Dungeons.lua")
--parseText2Map moved to DungeonMapper 2010 from DSB_Dungeons
--DSB_Dungeons possibly obsolete
-- parseText2Map
function parseText2Map(n)
local sb=""
textArray={}
btnListXY={}
textmapXY={}
btnList={}
quadwalls={}
if n==nil then n=1 end
if n == 0 then n=1 end
local schc=""
y=1
if n > #dsbtext2map then n = #dsbtext2map end
for i = 1,#dsbtext2map[n][6], 1 do
	sc=dsbtext2map[n][6][i]
	sb=sb..sc.."\n"
	--print(sb)
for c=1,string.len(sc),1 do
	--floor
	QFloor = string.sub(sc,c,c) 
	QEast = string.sub(sc,c+1,c+1)
	QWest = string.sub(sc,c-1,c-1)
	schc=schc..QWest 

	table.insert(textArray,QFloor)	
	
	if QFloor ~= "0" then
	
	table.insert(textmapXY,{c,y}) 
 	table.insert(btnListXY,{c,y})
 	xys=(tostring(c)..","..tostring(y))
	table.insert(btnList,xys) 
	-- using quadwalls for roof and floor
 	table.insert(quadwalls,{c,y,"floor"})
 	table.insert(quadwalls,{c,y,"roof"})
	
		QRoof = QFloor
		if i <= #dsbtext2map[n][6] then 
		QSouth = string.sub(dsbtext2map[n][6][i+1],c,c) -- wall faces north
		if QSouth ~= "1" then table.insert(quadwalls,{c,y+1,"north"}) end
		end
		
		if i >= 2 then
		QNorth = string.sub(dsbtext2map[n][6][i-1],c,c) -- wall faces south
		if QNorth ~= "1" then table.insert(quadwalls,{c,y-1,"south"}) end
		end
		--
		

 	-- east and west
 
if c < string.len(sc) and QEast ~= "1" then table.insert(quadwalls,{c,y,"east"}) end
 
 	--West
 	if c>1 and QWest ~= "1" then table.insert(quadwalls,{c,y,"west"}) end
 	-- Border
 		if i == 1 then table.insert(quadwalls,{c,y,"north"}) end
		if c== 1 then table.insert(quadwalls,{c,y,"west"}) end
 	   	if c==string.len(sc) then table.insert(quadwalls,{c,y,"east"}) end
 	 	if i==#dsbtext2map then table.insert(quadwalls,{c,y,"south"}) end 	 		
 end -- if
end  -- c
	
y=y+1
end  -- i
--for i=1,#quadwalls,1 do print(quadwalls[i][2]) end
	act="DungeonMapperWindow:make_current()\n"
	for i=1,#textmapXY,1 do
	x=tonumber(textmapXY[i][1])
	y=tonumber(textmapXY[i][2])
	if x == nil  or y == nil then  return end
	if x > GridSize then x = GridSize end
	if y > GridSize then y = GridSize end
	tbtn = "x"..tostring(x).."y"..tostring(y)
	if DungeonMapperWindow ~= nil then	
	act="if "..tbtn.."~= nil then "..tbtn..":color(255) end\n"
	 dsbtext2mapButtonChanges= loadstring(act)
	dsbtext2mapButtonChanges()
	end
	end
end
local dsbtexthead = "table.insert(dsbtext2map,"..CBI.."1,52,52,0,5,"..CBI
local s=""
local sb=""
for i=1,52,1 do
sb = sb..Q.."0000000000000000000000000000000000000000000000000000"..Q..",\n"
end
bsdtext2MapBaseString = dsbtexthead..string.sub(sb,1,-2)..CBO..CBO..")\n"

newbsdtext2Map = loadstring(bsdtext2MapBaseString)
newbsdtext2Map()
currentLevel = #dsbtext2map
cubewalls={}
quadwalls={}
DungeonTools ={"brush","eraser","Enemy","Friend","Building","Car","Gun","Token","path","map","mesh","live"}
DungeonTool="map"

mapSaveOptionsTable={"WTF","Level Map XY","Spawns","Paths","DSB text2Map"}
mapSaveOptionsChosen=mapSaveOptionsTable


humanlist={}
 zombielist ={ "zombiechick_alt2", "zombiechick_altlow", "zombiechick", "zombiechicklow", "zombiechick_alt", "zombiechick_alt2low", "tomdrinwoman5_3kslimed", "tomdrinman1_3kslimed", "tomdrinman1_3ksnowed", "tomdrinman5_2k4slimed", "tomdrinman2_3ksnowed", "tomdrinman5_2k4snowed"}
for i = 1,5,1 do
	 table.insert(humanlist,"tomdrinman"..i.."_3k")
	   table.insert(humanlist,"tomdrinwoman"..i.."_3k")
	end
--dofile(gameroot.."/Data/Scripts/Convert/pbm_functions.lua")
--gridInsertDraw
function gridInsertDraw(x,y,xys)
 	table.insert(btnList,xys) 	
	table.insert(textmapXY,{x,y}) 
 	table.insert(btnListXY,{x,y})
	serialXY=x+(GridSize*y)-GridSize	
	textArray[serialXY]="1"
	--print(serialXY)
end
--BtnBrowserListMaps

function BtnBrowserListMaps()
if BtnBrowser == nil then return end;

BtnListBrowser:clear()

for  i=1,#dsbtext2map,1 do
	bLine=tostring(i)
	BtnListBrowser:add(bLine);
	
	end
	BtnBrowser:redraw()
	BtnListBrowser:select(currentLevel)
	BtnListBrowser:selected(currentLevel,currentLevel)
	BtnListBrowser:value(currentLevel)
end
-- uBtnList BROWSER CODE AHEAD 1129
gLastBrowserControlClick=os.time()
gLastSelection=-1
gSelectedBtn=""
BtnListBrowserIndex ={{}}


function ulistBtnList()
--broken?
if God == nil then return end
BtnBrowser:make_current()
n=BtnListBrowser:value()
if n ~= nil and BtnListBrowserIndex[n] ~=nil then 
ox,oy = BtnListBrowserIndex[n][1],BtnListBrowserIndex[n][2]
else
ox,oy = 0,0
end
local sb = ""
local s =""
	BtnListBrowser:clear()
	BtnListBrowserIndex={{}}
	tempt={}
	if #btnListXY > 1 then return end 
	for i =1,#btnListXY,1 do
	if type(btnListXY[i]) ~= nil then 
	tempt=btnListXY[i]
	x=tempt[1]
	y=tempt[2]
	
	
	 s = x..","..y
	
		if string.find(sb,s) ==nil then 
		BtnListBrowser:add(s)
		sb=sb.." "..s
		table.insert(BtnListBrowserIndex,{x,y}) 
		if i == ox and ii == oy then gLastSelection = #BtnListBrowserIndex end
		end
		
	end
	end
	
	
	
	
	BtnBrowser:redraw()
	if gLastSelection ~= nil or gLastSelection > 0 then 
	BtnListBrowser:select(gLastSelection)
		BtnListBrowser:value(gLastSelection)
		BtnListBrowser:selected(gLastSelection,gLastSelection)
		
	end
	DungeonMapperWindow:make_current()
end




function uBtnListBrowserControlDoubleClicked(w)
	
		ulistBtnList()
		
		
end

function uBtnListBrowserControlClicked(w)
	if w:value()==0 then return end
	
	
	n=w:value()	
	local t=os.time()
	
	if t-gLastBrowserControlClick < 0.4 and w:value()==gLastSelection then
		uBtnListbrowserControlDoubleClicked(w)
		gLastBrowserControlClick=0
	else
		gLastBrowserControlClick=time()
		MapListCurrentPick(n)
		
	end
	gLastSelection=w:value()
	
			
end
-- updateCurrentLevelMap
function updateCurrentLevelMap()
	local cc=0
	local sb=""
	local s=""
		for i=1,#textArray,1 do
		cc=cc+1
		tai=textArray[i]
		--print(tai)
		sb=sb..tai
		if cc == GridSize then
		cc=0
		s=s..Q..sb..Q..",\n"
		sb=""
		end
		end
		
		
if currentLevel == nil then currentLevel = 1 end
if dsbtext2map[currentLevel] then

	dsbtextsethead="dsbtext2map["..currentLevel.."]="..CBI.."1,52,52,0,5,"..CBI.."\n"
	currentText2MapTable = dsbtextsethead.."\n"..string.sub(s,1,-3).."\n"..CBO..CBO.."\n"
	
	makenewdsbtext = loadstring(currentText2MapTable)
	makenewdsbtext()
	end

end
-- saveDSBMAP
-- save to Dungeon Strikes Back file
function saveDSBMAP()
local s=""
local sc=0
local sb=""
MapTextWindow:show()
MapTextFld:clear()

	--
	 local f =  chooseFile("Save Lua","*.lua",gMapPath)
if f == nil then return end

local tFile = io.open(f,"w")
--tFile:write(string.char(10))
	if tFile == nil then return end 
	gMapFile = f
	gMapName=fileShortNameFromPath(gMapFile)
		for i=1,#textArray,1 do
		sb=sb..textArray[i]
		if sb==nil then return end
		if string.len(sb) == 52 then 
		MapTextFld:add(sb)
		MapTextWindow:redraw()
		s=s..Q..sb..Q..",\n"
		sb=""
		end	
		end
		s="dsb_text2map(0, 52, 52, 100, 0, {\n"..string.sub(s,1,-3).."\n})"
		tFile:write(s)
		io.close(tFile)	
end
--saveMapDSBInsertTextMapOut
function saveMapDSBInsertTextMapOut()
local s=""
local sb=""

if currentLevel == 0 or currentLevel==nil then currentLevel = 1 end
if gMapName == nil then gMapName = "untitled" end
DSBMap2TEXTOutFile = gMapPath..currentLevel.."_dsbtextmap.lua"	
	tFile = io.open(DSBMap2TEXTOutFile,"w")
	if tFile ~= nil then 
		for i=1,#textArray,1 do
		sb=sb..textArray[i]
				if string.len(sb) == 52 then 		
				s=s..Q..sb..Q..",\n"
				sb=""
				end			end
		s="{\n"..string.sub(s,1,-3).."\n}"
		
		for i=1,#dsbtext2map[currentLevel]-1,1 do
		sb=sb..dsbtext2map[currentLevel][i]..","
		end		
		se = "table.insert(".."dsbtext2map,"..CBI..sb..s..CBO.."\n"..")";						
		tFile:write(se)
		io.close(tFile)	
		dofile(gMapOutFile)
	end	
	
end
-- saveMappedXY
function saveMappedXY()
local sb=""
local s ="-".."-"..gMapFile.."\n"
if currentLevel == 0 or currentLevel==nil then currentLevel = 1 end

	for i=1,#textmapXY,1 do
	sb=sb..CBI..textmapXY[i][1]..","..textmapXY[i][2]..CBO..","
	end
	s="levelmapXY={"..string.sub(sb,1,-2).."\n}"									
	sb=""			
	--for i = 1,#gMapButtonColors,1 do
	--sb=sb..CBI..gMapButtonColors[i][1]..","..Q..gMapButtonColors[i][2]..Q..","..gMapButtonColors[i][3]..CBO..","
	--end
	--s=s.."\n".."levelmapColors={"..string.sub(sb,1,-2).."\n}"
	--sb=""
	
	
	tFile = io.open(gMapFile,"w")
	if tFile ~= nil then 
	tFile:write(s)
	io.close(tFile)		
	end
	
	gMapContentFile  = gameroot.."Data/Levels/"..gMapName.."/"..gMapName.."_MapData.lua"
	s="-".."-"..gMapContentFile.."\n"
	--for i = 1,#gMapEnemy,1 do
	--sb=sb..CBI..gMapEnemy[i][1]..","..gMapEnemy[i][2]..","..gMapEnemy[i][2]..CBO..","
	--end
	--s=s.."\n".."levelmapEnemies={"..string.sub(sb,1,-2).."\n}"
	--sb=""
	
	--for i = 1,#gMapFriend,1 do
	--sb=sb..CBI..gMapFriend[i][1]..","..gMapFriend[i][2]..","..gMapFriend[i][2]..CBO..","
	--end
	
	s=s.."\n".."levelmapFriends={"..string.sub(sb,1,-2).."\n}"
	sb=""
	
	if gMeshObjectWTFs then
	local wt="\ngMeshObjectWTFs={"
	local wn="\ngMeshObjectNames={"
	local wp="\ngMeshObjectPositions={"
	local wr="\ngMeshObjectRotations={"
	local ws="\ngMeshObjectSizes={"
	
	for i = 1,#gMeshObjectWTFs,1 do 
	wt=wt..Q..gMeshObjectWTFs[i]..Q..","
	wn=wn..Q..gMeshObjectNames[i]..Q..","
	wp=wp.."{"..gMeshObjectPositions[i][1]..","..gMeshObjectPositions[i][2]..","..gMeshObjectPositions[i][3].."},"
	wr=wr.."{"..gMeshObjectRotations[i][1]..","..gMeshObjectRotations[i][2]..","..gMeshObjectRotations[i][3].."},"
	ws=ws.."{"..gMeshObjectSizes[i][1]..","..gMeshObjectSizes[i][2]..","..gMeshObjectSizes[i][3].."},"
	end
	wt=string.sub(wt,1,-2).."}\n"
	wn=string.sub(wn,1,-2).."}\n"
	wp=string.sub(wp,1,-2).."}\n"
	wr=string.sub(wr,1,-2).."}\n"
	ws=string.sub(ws,1,-2).."}\n"
	s=s..wt..wn..wp..wr..ws
	end
	cmnt="-"
	fts="convertMeshObjectsTablesToMeshFile("..Q.."Data/Levels/"..gMapName.."/"..gMapName.."_gMeshObjects.wtf"..Q..")"
	s=s.."\n"..cmnt..cmnt..fts
	
	tFile = io.open(gMapContentFile,"w")
	if tFile ~= nil then 
	tFile:write(s)
	io.close(tFile)		
	end
	
	--saveMapDSBInsertTextMapOut()
end
-- wClose

function wClose(w)
w:hide()
w=nil
end
-- fastquickquad
function fastquickquad(x,y)

if TheFloor == nil then
  WEWall = loadTheWalls("east")
NSWall = loadTheWalls("north")
TheFloor = loadTheFloor() 
end
 x=x*gridSize
	 y=y*gridSize
icopyFloors(x,y) 
local tmx,tmy,tmz=ig3d_GetMeshCentroid__3f()
		local cx,cy,cz=getCameraInfo(IG3D_POSITION)
		setCameraInfo(IG3D_POSITION,tmx+1.8,cy,tmz+1.8)
		camera_face_xyz(tmx,tmy,tmz)		
	ig3d_ShowAll()
	
	MapListCurrentPick(currentLevel)
	end
	
	
	function quickquad()
	MapListCurrentPick(currentLevel)
	 ig3d_DeleteMesh_b(true)

  WEWall = loadTheWalls("east")
NSWall = loadTheWalls("north")
TheFloor = loadTheFloor() 

	 for i =1,#quadwalls,1 do
	local tempt=quadwalls[i]
	local x=tempt[1]*gridSize
	local y=tempt[2]*gridSize
	local face=tempt[3]
	if face == "east" or face == "west" or face == "south" or face =="north" then
		if  WEWall ~= nil and NSWall ~= nil   then icopyWalls(x,y,face) end
		local tmx,tmy,tmz=ig3d_GetMeshCentroid__3f()
		local cx,cy,cz=getCameraInfo(IG3D_POSITION)
		setCameraInfo(IG3D_POSITION,tmx+1.8,cy,tmz+1.8)
		camera_face_xyz(tmx,tmy,tmz)
		
	else
		if TheFloor ~= nil then
		--if face == "floor" then icopyFloors(x,y) end
		--if face == "roof" then	icopyRoofs(x,y) end
		end
		
	end
			
	end
	
	end
-- startGrid
	
	
function startGrid()
	textArray={}
		for i = 1,GridSize,1 do
		btnListXY[i]={}
		for ii = 1,GridSize,1 do
		nc = math.random(1,2)
		fltk.fl_color(nc)
		btnm = "x"..tostring(i).."y"..tostring(ii)
		btnListXY[i][ii]={}
		srun =btnm.."= fltk:Fl_Button("..(i-1)*GridSpread..","..(ii-1)*GridSpread..","..tostring(GridSpread)..","..tostring(GridSpread)..","..Q..Q..");\n".."keeper:add("..btnm..")\n"..btnm..":box(fltk.FL_FLAT_BOX);\n"..btnm..":show()\n"..btnm..":tooltip("..Q..btnm..Q..")\n"..btnm..":callback(gridcb)\n"..btnm..":when(3)\n"
		makeabutton =  loadstring(srun)
		makeabutton()	
		table.insert(textArray,"0")			
		end
		end
		baseBtnColor=x1y1:color()
			
keeper:redraw()	
DungeonMapperWindow:redraw()
	end
	


function stackcb()

if Fl:event_key()==32 then newcolor=fltk.fl_show_colormap(nc) end
fltk_update()
Fl:check()
end
-- convertMapXYToMesh



 function convertMapXYToMesh()
updateCurrentLevelMap()
	parseText2Map(currentLevel)
	saveMappedXY()	
 ig3d_DeleteMesh_b(true)
 local sb=""
 local s=""
 local face=""

gMeshObjectWTFs={}
gMeshObjectNames={}
gMeshObjectPositions={}
gMeshObjectRotations={}
gMeshObjectSizes={}
		
 for i =1,#quadwalls,1 do
	local tempt=quadwalls[i]
	local x=tempt[1]*gridSize
	local y=tempt[2]*gridSize
	local face=tempt[3]	
	if face == "east" or face == "west" or face == "south" or face =="north" then
	  iBuildMeshObjectTables(x,y,face)
	else
	iBuildMeshObjectTables(x,y)	
	end
		render()
	end
	
	convertMeshObjectsTableToMesh(gMapName)
				
	--ig3d_ShowAll()
 	--ig3d_SelectWholeMesh() 
	--ig3d_CombineSelectedMeshOverlaps_f(1)
	-- polycount =ig3d_GetNumberOfPolys__i()
 	--ig3d_CombineEqualMeshMaterials() 
 	ig3d_SaveMesh_sf_b(gMapMeshPath,100)
 	--ig3d_InvertMeshSelection()
 	--editingModeSwitch("select_entity")
	--lookbutton()
	saveAsNewLevel()
 end
-- quadGrid
 function quadGrid()
updateCurrentLevelMap()
	parseText2Map(currentLevel)	
 ig3d_DeleteMesh_b(true)
 local sb=""
 local s=""
 local face=""
--
	--WEWall=loadCubeWalls("east")
	--NSWall=loadCubeWalls("north")
  	--WEWall = loadTheWalls("east")
	--NSWall = loadTheWalls("north")
	--TheFloor = loadTheFloor() 
	--theDropMeshTagNumber=loadAModelTemplate("Misc/SnowMound2x2.wtf")		
 for i =1,#quadwalls,1 do
	local tempt=quadwalls[i]
	local x=tempt[1]*gridSize
	local y=tempt[2]*gridSize
	local face=tempt[3]	
	if face == "east" or face == "west" or face == "south" or face =="north" then
	--if  WEWall ~= nil and NSWall ~= nil   then  icopyWalls(x,y,face) end	
	-- icopyModelWalls(x,y,face) 
	  --iBuildMeshObjectTables(x,y,face)
	
		--if face == "north" then y = y+(gridSize/2) end
		--if face == "west" then x=x-gridSize end
		--if face == "south" then y=y-(gridSize/2) end
		--if face == "east" then x=x+gridSize end
		--if  WEWall ~= nil and NSWall ~= nil   then  icopyCubeWalls(x,y,face) end
	
		--if theDropMeshTagNumber ~= nil then
		--if face == "north" then y = y+(gridSize/2) end
		--if face == "west" then x=x-gridSize end
		--if face == "south" then y=y-(gridSize/2) end
		--if face == "east" then x=x+gridSize end
		--iCopyWTFXY(x,y,face)
		--end
		else
		--iBuildMeshObjectTables(x,y,face)
		--icopyModelFloors(x,y)
		--if TheFloor ~= nil then
		--if face == "floor" then icopyFloors(x,y) end
		--if face == "floor" then icopyModelFloors(x,y) end
		--if face == "roof" then	icopyRoofs(x,y) end
		--end		
	end
		render()
	end			
	--ig3d_ShowAll()
 	--ig3d_SelectWholeMesh() 
	--ig3d_CombineSelectedMeshOverlaps_f(0.5)
	-- polycount =ig3d_GetNumberOfPolys__i()
	--ig3d_CombineSelectedMeshOverlaps_f(0.5)
 	--ig3d_CombineEqualMeshMaterials() 
 	--ig3d_SaveMesh_sf_b(gMapMeshPath,100)
 	--ig3d_InvertMeshSelection()
 	--editingModeSwitch("select_entity")
	--lookbutton()
	saveAsNewLevel()
 end
-- Reset all buttons

function resetAllButtons()
local s=""
for i = 1,GridSize,1 do
for ii = 1,GridSize,1 do
btnm = "x"..tostring(i).."y"..tostring(ii)
s=s..btnm..":color("..baseBtnColor..")\n"
end
end
ClearAllButtons =loadstring(s)

end
-- recolorMapButtons
function recolorMapButtons()
if gMapButtonColors ~= nil then
	for i = 1,#gMapButtonColors,1 do
	lvl = gMapButtonColors[i][1]
		if lvl == currentLevel then
		btnm = gMapButtonColors[i][2]
		print(i,btnm)
		btncolor = gMapButtonColors[i][3]
	
		s=s..btnm..":color("..btncolor..")\n"
		
			if s ~= nil then 
			ReColorAllButtons =loadstring(s)
			ReColorAllButtons() 
			end
		end
	end


end
	
end
-- resetGrid
function resetGrid()
btnListXY={}
textmapXY={}
--textArray={}
for i = 1,GridSize*GridSize,1 do textArray[i]="0" end
		
end
-- resetDSB
function resetDSB()
listSpawnxy = {}
spawnXY={}
XYSpawned={}
for i=1,GridSize,1 do
XYSpawned[i]={}
for ii=1,GridSize,1 do
XYSpawned[i][ii]={}
end
end
dsbspawn ={}
spawninpack={}
exvar={}
dsbaddchampion={}
dsbtext2map={}
newbsdtext2Map()
wallset={}
spawngrid={{}}
spawnindex={}
spawntext=""
spawnXY={}
spawnindex={}
foundindex={}
level=nil
which=nil
dofile(gameroot.."Data/Scripts/Convert/DSB_global.lua")
dofile(gameroot.."Data/Scripts/Convert/DSB_Dungeons.lua")

end
-- resetMapper

function resetMapper()
GridSize=52
GridSpread=8
--nTagNumber=0
vgridwidth=2
vgridlength,vcubewidth=2,2
vcubelength,vcubeheight=2,2
gridSize,cubeSize=2,2
gridSize,quadSize=2,2
WEWall = nil
NSWall = nil
TheFloor=nil
grpGrid={}
drpGrid={}
drpColors={}
btnMakeList={}

btnList={}
cubewalls={}
quadwalls={}

ClearAllButtons()
resetGrid()
recolorMapButtons()
DungeonMapperWindow:redraw()

end
-- parseTextMapXY
function parseTextMapXY()
act="DungeonMapperWindow:make_current()\n"
for i=1,#textmapXY,1 do
x=tonumber(textmapXY[i][1])
y=tonumber(textmapXY[i][2])
if x > GridSize then x = GridSize end
if y > GridSize then y = GridSize end
tbtn = "x"..tostring(x).."y"..tostring(y)
	if DungeonMapperWindow ~= nil then	
	act="if "..tbtn.."~= nil then "..tbtn..":color(255) end\n"
	 dsbtext2mapButtonChanges= loadstring(act)
	dsbtext2mapButtonChanges()
	end
end
end
-- MapListCurrentPick
function MapListCurrentPick(n)
	
if n == nil then return end
if n == 0 then n = 1 end

currentLevel = n
resetMapper()
updateCurrentLevelMap()
	--FOR BSD SPAWNS
	--local f = BSDDungeonSpawnsOut()
	--if f ~= nil then dofile(f) end
-- BASED ON BSD text2Map()

resetAllButtons()
parseText2Map(currentLevel)
recolorMapButtons()
		fltk_update()		
		--quadGrid()
			
end
-- openMapFiles
function openMapFiles()
textArray={}
gMapFile =  chooseFile(tTitle,"*.lua",gMapPath)
	if tFile ~= nil then 
	gMapFile = gameroot..string.sub(tFile,string.find(tFile,"Data"),-1)
	resetMapper()
	resetDSB()
	local s=""
	local sb=""
	levelmapXY={}
	dofile(gMapFile)
	if #levelmapXY > 1 then
	dsbtext2map={}
	zeromap={{}}
	zeroline = string.rep("0",52)
		for i=1,GridSize,1 do 
		zeromap[i]={{}}
		
		for ii=1,GridSize,1 do 
		zeromap[i][ii]="0"
		--textArray[i+ii]="0"
		 end
		 end
		for i=1,#levelmapXY,1 do
		x=levelmapXY[i][2]
		y=levelmapXY[i][1]
		gridInsertDraw(x,y,tostring(x..","..y))
		--serialXY=x+(GridSize*y)-GridSize
		--textArray[serialXY]="1"
		zeromap[x][y]=1
		end
	local s=""
	local ss=""
	 	for i=1,GridSize,1 do
	 	for ii=1,GridSize,1 do
		ss=ss..zeromap[i][ii]
		end
		s=s..Q..ss..Q..",\n"
		ss=""
		end
--table.insert(dsbtext2map,{currentLevel})
	dsbtextsethead="table.insert(dsbtext2map,"..CBI.."1,52,52,0,5,"..CBI.."\n"
	currentText2MapTable = dsbtexthead.."\n"..string.sub(s,1,-3).."\n"..CBO..CBO..")\n"
	makenewdsbtext = loadstring(currentText2MapTable)
	makenewdsbtext()
	
	end
	
	gMapName=fileShortNameFromPath(gMapFile)
	currentLevel=1
		if #dsbtext2map > 0 then 
		BtnBrowserListMaps()
		parseText2Map(currentLevel)		
		end
	end
	
	if levelmapColors ~= nil then 
	for i=1,#levelmapColors,1 do
	local l = tonumber(levelmapColors[i][1])
	local n = levelmapColors[i][2]
	local c = tonumber(levelmapColors[i][3])
	
	table.insert(gMapButtonColors,{l,n,c})
	end
	recolorMapButtons()
	end
	

	
	DungeonMapperWindow:redraw()
end
-- DungeonToolListBrowserCB
function DungeonToolListBrowserCB(w)

updateCurrentLevelMap()
parseText2Map(currentLevel)
if w:value() == nil or w:value() == 0 then return end

dungeontoolnumber=w:value()
DungeonMapperWindow:make_current()
 DungeonToolOptionsBrowser:clear()
 
DungeonTool = DungeonTools[dungeontoolnumber]
if DungeonTool == "brush" then
 --meshDrawBrushSize = meshDrawBrushSize + 2

  DungeonToolOptionsBrowser:add(meshDrawBrushSize)
   DungeonToolOptionsBrowser:add("+")
 DungeonToolOptionsBrowser:add("-")
end


	if DungeonTool == "Friend" then
	DungeonToolOptionsBrowser:clear()
	for i,v in pairs(humanlist) do
	DungeonToolOptionsBrowser:add(v)
	end
	end


	if DungeonTool == "Enemy" then
	DungeonToolOptionsBrowser:clear()
	for i,v in pairs(zombielist) do
	DungeonToolOptionsBrowser:add(v)
	end
	end



end
--DungeonToolOptionsBrowserCB
function DungeonToolOptionsBrowserCB(w)


DungeonToolOptionsBtnVal=w:value()

updateCurrentLevelMap()
parseText2Map(currentLevel)

if DungeonTool == "brush" then
	if DungeonToolOptionsBtnVal == 2 then meshDrawBrushSize = meshDrawBrushSize +1 end
	if DungeonToolOptionsBtnVal == 3 then meshDrawBrushSize = meshDrawBrushSize -1 end

	if meshDrawBrushSize > 20 then meshDrawBrushSize = 20 end
	if meshDrawBrushSize < 1 then meshDrawBrushSize =1 end
 	DungeonToolOptionsBrowser:clear()
  	DungeonToolOptionsBrowser:add(meshDrawBrushSize)
   	DungeonToolOptionsBrowser:add("+")
 	DungeonToolOptionsBrowser:add("-")
end

if DungeonTool == "Friend" then
gDropModel="Characters/"..humanlist[DungeonToolOptionsBtnVal]..".wtf"
print(gDropModel)
end

if DungeonTool == "Enemy" then
gDropModel="Characters/"..zombielist[DungeonToolOptionsBtnVal]..".wtf"
print(gDropModel)
end


end
-- updateDungeonToolListBrowser
function updateDungeonToolListBrowser()
if DungeonTool == nil then DungeonTool = "map" end
DungeonToolListBrowser:clear()
for i = 1,#DungeonTools,1 do
DungeonToolListBrowser:add(DungeonTools[i])
end
end
-- eraserTool
function eraserTool(x,y,xys)
for i =1,#btnList,1 do
if btnList[i] == xys then table.remove(btnList,i) end
end

for i =1,#textmapXY,1 do
	
	if textmapXY[i][1] == x and textmapXY[i][2] == y then 
	textmapXY[i]={}
	btnListXY[i]={}
	
end
end

serialXY=x+(GridSize*y)-GridSize	
textArray[serialXY]="0"
	btnm = "x"..x.."y"..y
	local tobasecolor = loadstring(btnm..":color("..baseBtnColor..")")
	
	tobasecolor()
	
	for i=1,#gMapButtonColors,1 do
	if gMapButtonColors[i][2] == btnm then 
	gMapButtonColors[i]={curentLevel,btnm,baseBtnColor,} 
	
	
	end
	end

	updateCurrentLevelMap()
	parseText2Map(currentLevel)
	--recolorMapButtons()
	DungeonMapperWindow:redraw()
end
-- brushQuad

function brushQuad(size,x,y)
if x == nil or y == nil then return end
local xf=x+math.floor((size/2))
local yf=y+math.floor((size/2))

local xb=x-math.floor((size/2))
local yb=y-math.floor((size/2))
local bs=""
local nc=8
local s=""
if size == 2 then
xb=x
yb=y
end

if xf > GridSize then xf =GridSize end
if yf > GridSize then yf = GridSize end
if xb < 0 then xb = 1 end
if yb < 0 then yb = 1 end

local bs=""
for iii =1,#btnList,1 do bs=bs..tostring(btnList[iii]).."\n" end

for i=xb,xf,1 do

for ii=yb,yf,1 do
xys=i..","..ii
btnm="x"..(i).."y"..(ii)
		
		
	if string.find(bs,xys) == nil then 
	gridInsertDraw(i,ii,xys)
	updateCurrentLevelMap()
	--bs=bs.."\n"..xys 
	--s=s..  btnm..":color("..size..")\n"..btnm..":value(0)\n"
	table.insert(gMapButtonColors,{currentLevel,btnm,size})
	end
	
	end
	
	end

	
	
	
	
	parseText2Map(currentLevel)
	recolorMapButtons()
	DungeonMapperWindow:redraw()
	
	
end
-- GRID BUTTONS CALL BACK

function gridcb(w)
	tt=w:tooltip()	
	if Fl:event_key()==32 then newcolor=fltk.fl_show_colormap(nc) end
	if tt == nil then return end
	
 	if newcolor == nil then 
	nc = math.random(1,255)
	else
	nc = newcolor
	end
	local yn = string.find(tt,"y")
		if yn ~= nil  and string.len(tt) > yn then 
		xt = string.sub(tt,2,yn-1)
		xyshift = 0
		
		
		x = tonumber(xt)+xyshift
		y = tonumber(string.sub(tt,yn+1,-1))+xyshift
		
		
		xys=(x..","..y)
		end
		
		local s = ""
		gDropx,gDropz = x*gridSize,y*gridSize
		if DungeonTool=="eraser" then
		 eraserTool(x,y,xys)
		 else
		 
		 
		for i =1,#btnList,1 do s=s..tostring(btnList[i]).."\n" end
		if x == nil or y == nil then return end
		--print(xys,string.find(s,xys))
		if string.find(s,xys) == nil then
			
		if DungeonTool == "map" then 
		gridInsertDraw(x,y,xys)
		w:color(nc)
		w:value(0)
		table.insert(gMapButtonColors,{currentLevel,tt,nc})
		updateCurrentLevelMap()
		  end
		 
		 if DungeonTool=="path" then
		 w:color(180)
		 w:value(0)
		 table.insert(gMapButtonColors,{currentLevel,tt,180})
		 pathMapDraw(x,y)
		 end
		 
		 if DungeonTool=="Friend" then
		 w:color(100)
		 w:value(0)
		 gridInsertDraw(x,y,xys)
		 updateCurrentLevelMap()
		 table.insert(gMapButtonColors,{currentLevel,tt,100})
		 table.insert(gMapFriend,{currentLevel,x,y,gDropModel})
		 icopyModelWalls(x*gridSize,y*gridSize,"floorlive",gDropModel) 
		-- pathMapDraw(x,y)
		print(gDropModel)
		 end
		 
		 if DungeonTool=="Enemy" then
		  w:color(200)
		 w:value(0)
		 gridInsertDraw(x,y,xys)
		 updateCurrentLevelMap()
		 
		 table.insert(gMapButtonColors,{currentLevel,tt,200})
		 table.insert(gMapEnemy,{currentLevel,x,y,gDropModel})
		 icopyModelWalls(x*gridSize,y*gridSize,"floorlive",gDropModel)
 
		 end
		 
		 if DungeonTool=="live" then
		 w:color(100)
		 w:value(0)
		 gridInsertDraw(x,y,xys)
		 updateCurrentLevelMap()
		 --quickquad(x,y)
		 icopyModelWalls(x*gridSize,y*gridSize,"floorlive",gDropModel)
		 end
		 
		 if DungeonTool=="brush" then
		 brushQuad(meshDrawBrushSize,x,y)
		 end
		 
		 end
		
		
		end
		serialXY=x+(GridSize*y)-GridSize	
		 print(serialXY)
		Fl:check()

end
-- fillmapSaveOptionsBrowser

function fillmapSaveOptionsBrowser()
local n = mapSaveOptionsListBrowser:value()
mapSaveOptionsListBrowser:clear()
mapSaveOptionsBrowser:clear()
local a = mapSaveOptionsTable
local b = mapSaveOptionsChosen
local s = ""
	for i = 1,#b,1 do
	s=s..b[i].."\n"
	mapSaveOptionsListBrowser:add(b[i])
	end
	for i = 1,#a,1 do
	if string.find(s,a[i]) == nil then 
	
	mapSaveOptionsBrowser:add(mapSaveOptionsTable[i])
	end
	end
mapSaveOptionsListBrowser:value(n)
mapSaveOptionsListBrowser:selected(n,n)
mapSaveOptionsListBrowser:select(n)
mapSaveOptionsListBrowser:redraw()
mapSaveOptionsBrowser:redraw()
end

function saveOptionsAdd()
local n = mapSaveOptionsListBrowser:value()
local nn = mapSaveOptionsBrowser:value()
	 mapSaveOptionsChosen[nn] =  mapSaveOptionsTable[nn] 
	fillmapSaveOptionsBrowser()
	
end

function saveOptionsRemove()
local n = mapSaveOptionsListBrowser:value()
local nn = mapSaveOptionsBrowser:value()
	 table.remove( mapSaveOptionsChosen,n)
	fillmapSaveOptionsBrowser()
	
end
-- saveMapButtonClicked

function saveMapButtonClicked()
gMapName = mapNameTextInput:value()

if gMapName == nil then gMapName = "untitled" end
isafolder = folderExists(gameroot.."Data/Levels/",gMapName)

	if folderExists(gameroot.."Data/Levels/",gMapName) == false then
	ig3d_CreateDirectory_s( gameroot.."Data/Levels/"..gMapName.."/")
	
	end
	saveMappedXY()	
end


function refreshMapFileLists()
gMapName = mapNameTextInput:value()
gMapPath = gameroot.."Data/Levels/"..gMapName
gMapFile = gameroot.."Data/Levels/"..gMapName.."/"..gMapName.."mapXY.lua"
gMapMeshPath = gameroot.."Data/Levels/"..gMapName.."/"..gMapName.."map_mesh.wtf"



MapSavePathsBrowser:clear()
MapSavePathsBrowser:add(gMapPath)
MapSavePathsBrowser:add(gMapFile)
MapSavePathsBrowser:add(gMapMeshPath)
end

function mapNameTextInputCB()
refreshMapFileLists()

end
-- openMapSaveWindow
function openMapSaveWindow()
MapSaveWindow:show()


--MapSaveWindow:redraw()
MapSaveWindow:make_current()
mapNameTextInput:value(gMapName)
refreshMapFileLists()
end
-- Mapper MENU FUNCTIONS
MapperMenuIndex={}
MapperMenuText={}
MapperMenuText.Source={"New","Open" ,"Save"}
MapperMenuText.Maps={}

function fillMapperSourceMenu()
if BtnBrowser == nil then return end;
	for  i=1,#MapperMenuText.Source,1 do
	menuLine="File/"..MapperMenuText.Source[i]
	MapperMenu:add(menuLine);
	table.insert(MapperMenuIndex,menuLine)
	end
MapperMenu:add("");
table.insert(MapperMenuIndex,"")
MapperMenu:redraw()
end 

function fillMapperControlMenu()


MapperMenu:add("");
table.insert(MapperMenuIndex,"")
MapperMenu:add("");
table.insert(MapperMenuIndex,"")


menuLine="Convert/".."to 3D"
MapperMenu:add(menuLine);
table.insert(MapperMenuIndex,menuLine)
MapperMenu:add("");
table.insert(MapperMenuIndex,"")
MapperMenu:redraw()
fltk_update()
end


function MapperCurrentPick(tPick)

if tPick == nil or tPick == 0 then tPick = 1 end

--resetMapper()

local f = BSDDungeonSpawnsOut()
if f ~= nil then dofile(f) end
if currentLevel == nil or currentLevel == 0 then currentLevel = 1 end
parseText2Map(currentLevel)
		ButtonSpawnXY()
		BtnBrowserListMaps()
		BtnBrowser:redraw()
		fltk_update()		
		quadGrid()	
end


function MapperBrowsersMenuPick(tPick)
if BtnBrowser == nil then return end;
--updateCurrentLevelMap()	
--parseText2Map(currentLevel)

	
if tPick == "New" then 
resetMapper() 
newbsdtext2Map()
currentLevel=#dsbtext2map
parseText2Map(currentLevel)

BtnBrowserListMaps()
end
		
--if tPick == "Duplicate" then MakeMapper() end;

if tPick == "Open" then
openMapFiles()
end

if tPick == "Save" then
openMapSaveWindow()
	
end

if tPick == "Save BSD Text" then saveMapDSBInsertTextMapOut() end


end

function Mapper_menu_callback(w)
if BtnBrowser == nil then return end;
tMenu = w:label()
tVal = w:value()
tPick = w:text()

tIndex = MapperMenuIndex[tVal]
tIndex1 = MapperMenuIndex[tVal-1]
tIndex2 = MapperMenuIndex[tVal+1]
--print(tMenu,tVal,tPick)
--print(tIndex,tIndex1,tIndex2)
	if tIndex ~=nil  then 
	MappermenuHead=item(1,tIndex,"/")
	con=item(1,tIndex2,"/")
	
--print(MappermenuHead)
 		if MappermenuHead == "File" then MapperBrowsersMenuPick(tPick) end;
 		if con =="Convert" then 
 		 updateCurrentLevelMap()
 		parseText2Map(currentLevel)
 		convertMapXYToMesh()
 		--quadGrid() 
 		end
 		   
 	 end 	
 	 
  Fl:check();
   io.flush();
end

function Mapper_MenuBarFill()
if BtnBrowser == nil then return end;
fillMapperSourceMenu()
fillMapperControlMenu()
end
do DungeonMapperWindow= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Click Grid 256")
DungeonMapperWindow:label(gLabelTable[#gLabelTable])
DungeonMapperWindow:callback(wClose)
DungeonMapperWindow:resize(287,312,407,408)
DungeonMapperWindow:when(1)
Fl_Group:current():resizable(DungeonMapperWindow)
DungeonMapperWindow:size_range(331,330,452,447)
--DungeonMapperWindow:show()
do keeper= fltk:Fl_Scroll(0,0,0,0,"")
keeper:resize(0,0,420,425)
keeper:type(7)
keeper:align(5)
Fl_Group:current():resizable(keeper)
do grp= fltk:Fl_Group(0,0,0,0,"")
grp:resize(0,0,420,425)
grp:when(1)
Fl_Group:current():resizable(grp)
Fl_Group:current(Fl_Group:current():parent())
end
end
end
DungeonMapperWindow:show()

do MapSaveWindow= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Save Map")
MapSaveWindow:label(gLabelTable[#gLabelTable])
MapSaveWindow:callback(hide)
MapSaveWindow:resize(7,298,368,129)
--unknown attribute: hide
MapSaveWindow:size_range(361,129,361,129)
do MapSaveTextFld= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Output")
MapSaveTextFld:label(gLabelTable[#gLabelTable])
MapSaveTextFld:resize(10,283,350,117)
MapSaveTextFld:type(2)
MapSaveTextFld:labelsize(9)
MapSaveTextFld:align(1)
MapSaveTextFld:textsize(10)
end

do mapSaveOptionsBrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Save Options")
mapSaveOptionsBrowser:label(gLabelTable[#gLabelTable])
mapSaveOptionsBrowser:resize(225,203,135,70)
mapSaveOptionsBrowser:type(2)
mapSaveOptionsBrowser:labelsize(10)
mapSaveOptionsBrowser:align(1)
mapSaveOptionsBrowser:textsize(10)
end

do mapSaveOptionsListBrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Save Options")
mapSaveOptionsListBrowser:label(gLabelTable[#gLabelTable])
mapSaveOptionsListBrowser:resize(10,203,135,70)
mapSaveOptionsListBrowser:type(2)
mapSaveOptionsListBrowser:labelsize(10)
mapSaveOptionsListBrowser:align(1)
mapSaveOptionsListBrowser:textsize(10)
end

do addsaveoptionbtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "<<")
addsaveoptionbtn:label(gLabelTable[#gLabelTable])
addsaveoptionbtn:callback(saveOptionsAdd)
addsaveoptionbtn:resize(160,203,50,20)
end

do removesaveoptionbtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, ">>")
removesaveoptionbtn:label(gLabelTable[#gLabelTable])
removesaveoptionbtn:callback(saveOptionsRemove)
removesaveoptionbtn:resize(160,228,50,20)
end

do mapNameTextInput= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Levels/")
mapNameTextInput:label(gLabelTable[#gLabelTable])
mapNameTextInput:callback(mapNameTextInputCB)
mapNameTextInput:resize(46,4,309,20)
mapNameTextInput:labelsize(12)
mapNameTextInput:when(1)
mapNameTextInput:textsize(11)
end

do saveMapButton= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Save")
saveMapButton:label(gLabelTable[#gLabelTable])
saveMapButton:callback(saveMapButtonClicked)
saveMapButton:resize(260,104,79,20)
saveMapButton:labelsize(12)
end

do MapSavePathsBrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Paths")
MapSavePathsBrowser:label(gLabelTable[#gLabelTable])
MapSavePathsBrowser:resize(10,38,345,61)
MapSavePathsBrowser:labelsize(9)
MapSavePathsBrowser:align(1)
MapSavePathsBrowser:textsize(10)
end
end
MapSaveWindow:show()

do BtnBrowser= fltk:Fl_Double_Window(0,0,0,0,"")
BtnBrowser:callback(wClose)
BtnBrowser:resize(6,50,228,238)
--BtnBrowser:show()
do MapperMenu= fltk:Fl_Menu_Bar(0,0,0,0,"")
menudir0=""
MapperMenu:callback(Mapper_menu_callback)
MapperMenu:resize(-5,-2,415,24)
MapperMenu:color(38)
MapperMenu:labelsize(10)
MapperMenu:textsize(10)
Fl_Group:current(Fl_Group:current():parent())
end

do DungeonToolListBrowser= fltk:Fl_Browser(0,0,0,0,"")
DungeonToolListBrowser:callback(DungeonToolListBrowserCB)
DungeonToolListBrowser:resize(50,30,45,190)
DungeonToolListBrowser:type(2)
DungeonToolListBrowser:labelsize(10)
DungeonToolListBrowser:textsize(10)
end

do BtnListBrowser= fltk:Fl_Browser(0,0,0,0,"")
BtnListBrowser:callback(uBtnListBrowserControlClicked)
BtnListBrowser:resize(5,30,45,190)
BtnListBrowser:type(2)
BtnListBrowser:labelsize(10)
BtnListBrowser:textsize(10)
end

do DungeonToolOptionsBrowser= fltk:Fl_Browser(0,0,0,0,"")
DungeonToolOptionsBrowser:callback(DungeonToolOptionsBrowserCB)
DungeonToolOptionsBrowser:resize(95,30,125,190)
DungeonToolOptionsBrowser:type(2)
DungeonToolOptionsBrowser:labelsize(10)
DungeonToolOptionsBrowser:when(4)
DungeonToolOptionsBrowser:textsize(10)
end
end
BtnBrowser:show()

do MapTextWindow= fltk:Fl_Double_Window(0,0,0,0,"")
MapTextWindow:callback(wClose)
MapTextWindow:resize(214,631,329,263)
--unknown attribute: hide
Fl_Group:current():resizable(MapTextWindow)
MapTextWindow:size_range(329,263,331,579)
do MapTextFld= fltk:Fl_Browser(0,0,0,0,"")
MapTextFld:resize(0,0,330,576)
MapTextFld:type(2)
MapTextFld:labelsize(9)
MapTextFld:textsize(10)
Fl_Group:current():resizable(MapTextFld)
end
end
MapTextWindow:show()

startGrid()
resetAllButtons()
resetDSB()
Mapper_MenuBarFill()
MapTextWindow:hide()
MapSaveWindow:hide()


BtnBrowser:show()
BtnBrowserListMaps()




updateDungeonToolListBrowser()
BtnBrowser:redraw()

DungeonMapperWindow:show()
DungeonMapperWindow:redraw()
timer = murgaLua.createFltkTimer()
timer:callback(stackcb)
timer:do_callback()
--end
Fl:run()
