--function make_window()
Q='"'
CBI=string.char(123)
CBO=string.char(125)

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
GridSpread=10
randomColor =  math.random(1,255)
newcolor = randomColor
currentMapLevel=1
nTagNumber=0
vgridwidth=2
vgridlength=2
vcubewidth=2
vcubelength=2
vcubeheight=2
gridSize,cubeSize=2,2
gridSize,quadSize=2,2
WEWall = nil
NSWall = nil
TheFloor=nil
gMapName="untitled"
gMapFile=""
gMapOutFile=""
gBSDDungeonOutFile=""
--
dsbtext2map={}

dofile(gameroot.."Data/Scripts/Convert/DSB_global.lua")
dofile(gameroot.."Data/Scripts/Convert/DSB_Dungeons.lua")
currentMapLevel = #dsbtext2map
cubewalls={}
quadwalls={}
--BtnBrowserListMaps

function BtnBrowserListMaps()
if BtnBrowser == nil then return end;

BtnListBrowser:clear()

for  i=1,#dsbtext2map,1 do
	bLine=tostring(i)
	BtnListBrowser:add(bLine);
	
	end
	BtnBrowser:redraw()
end
-- uBtnList BROWSER CODE AHEAD 1129
gLastBrowserControlClick=os.time()
gLastSelection=-1
guSelectedBtn=""
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
	--print(w:value())
	
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
-- saveBSDMAP
function saveBSDMAP()
local s=""
local sc=0
local sb=""
MapTextFld:clear()
MapTextWindow:show()
	--
	 local f =  chooseFile("Save Lua","*.lua",gameroot.."Data/WTF/Dungeons/")
	print(f)
if f == nil then return end

local tFile = io.open(gameroot..f,"w")
--tFile:write(string.char(10))
	if tFile == nil then return end 
	gMapFile = gameroot..f
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
-- saveMappedXY
function saveMappedXY()
local sb=""
if currentMapLevel == 0 or currentMapLevel==nil then currentMapLevel = 1 end
if gMapName == nil then gMapName = "untitled" end
gMapOutFile = gameroot.."Data/WTF/Dungeons/"..gMapName..currentMapLevel.."_ig3dmap.lua"	
	tFile = io.open(gMapOutFile,"w")
	if tFile ~= nil then 
		for i=1,#textmapXY,1 do
		sb=sb..CBI..textmapXY[i][1]..","..textmapXY[i][2]..CBO..","
		end
		s="levelmapXY={"..string.sub(sb,1,-2).."\n}"
								
		tFile:write(s)
		io.close(tFile)	
	end	
	
end
--saveMapout
function saveMapDSBInsertTextMapOut()
local s=""
local sb=""

if currentMapLevel == 0 or currentMapLevel==nil then currentMapLevel = 1 end
if gMapName == nil then gMapName = "untitled" end
gMapOutFile = gameroot.."Data/WTF/Dungeons/"..gMapName..currentMapLevel.."_dsbtextmap.lua"	
	tFile = io.open(gMapOutFile,"w")
	if tFile ~= nil then 
		for i=1,#textArray,1 do
		sb=sb..textArray[i]
				if string.len(sb) == 52 then 		
				s=s..Q..sb..Q..",\n"
				sb=""
				end			end
		s="{\n"..string.sub(s,1,-3).."\n}"
		
		for i=1,#dsbtext2map[currentMapLevel]-1,1 do
		sb=sb..dsbtext2map[currentMapLevel][i]..","
		end		
		se = "table.insert(".."dsbtext2map,"..CBI..sb..s..CBO.."\n"..")";						
		tFile:write(se)
		io.close(tFile)	
		dofile(gMapOutFile)
	end	
	
end
-- wClose

function wClose(w)
w:hide()
w=nil
end
-- gridcb
function gridcb(w)
	tt=w:tooltip()
	if Fl:event_key()==32 then newcolor=fltk.fl_show_colormap(randomColor) end

 if newcolor == nil then 
randomColor = math.random(1,255)
else
randomColor = newcolor
end

if tt ~= nil then 
	--print(tt)
	xt = string.sub(tt,2,string.find(tt,"y")-1)
	x = tonumber(xt)+1
	n = string.find(tt,"y")
	if n ~= nil  and string.len(tt) > n then 
	y = tonumber(string.sub(tt,n+1,-1))+1
	--print(x..","..y)
	end
	end
	xys=(x..","..y)
	
	local s = ""
	for i =1,#btnList,1 do s=s..tostring(btnList[i]).."\n" end
	if x == nil or y == nil then return end
	if string.find(s,xys) == nil then
	 table.insert(btnList,xys) 
	
	--print("xy@buttonlist="..xys)
	table.insert(textmapXY,{x,y}) 
 	table.insert(btnListXY,{x,y})
	serialXY=x+(GridSize*y)-GridSize
	
	textArray[serialXY]="1"
	print(serialXY)
	w:color(randomColor)
	w:value(0)
	end
	
	Fl:check()
end
-- startGrid
	
	
function startGrid()

	textArray={}
	local s=""
		for i = 1,GridSize,1 do
		btnListXY[i]={}
		--textmapXY[i]={}
		for ii = 1,GridSize,1 do
		--table.insert(textArray,0)
		randomColor = math.random(1,2)
		fltk.fl_color(randomColor)
		btnm = "x"..tostring(i-1).."y"..tostring(ii-1)
		btnListXY[i][ii]={}
		srun = btnm.."= fltk:Fl_Button("..(i-1)*GridSpread..","..(ii-1)*GridSpread..","..tostring(GridSpread)..","..tostring(GridSpread)..","..Q..Q..");\n"..btnm..":box(fltk.FL_FLAT_BOX);\n"..btnm..":show()\n"..btnm..":tooltip("..Q..btnm..Q..")\n"..btnm..":callback(gridcb)\n"..btnm..":when(3)\n  keeper:add("..btnm..") \n "
		s=s..srun
		end
		end
		--textmapXY[i][ii]="0"
		--if f ~= nil then f:write(srun) end
			if DungeonMapperWindow ~= nil then
			makeabutton =  loadstring(s)
			makeabutton()				
			end
	
		baseBtnColor=x0y0:color()	
keeper:redraw()	
DungeonMapperWindow:redraw()
	end
	


function stackcb()

if Fl:event_key()==32 then newcolor=fltk.fl_show_colormap(randomColor) end
fltk_update()
Fl:check()
end
--quadGrid
 function quadGrid()
 ig3d_DeleteMesh_b(true)
 local sb=""
 local s=""
  WEWall = loadTheWalls("east")
NSWall = loadTheWalls("north")
TheFloor = loadTheFloor() 
	parseDungeon(currentMapLevel)	
		
 for i =1,#quadwalls,1 do
	tempt=quadwalls[i]
	x=tempt[1]*gridSize
	y=tempt[2]*gridSize
	face=tempt[3]
	print(x,y,face)
		if  WEWall~= nil and NSWall ~= nil  then
		icopyWalls(x,y,face)
		else
		idrawWallZ(x,y,face)
		end
		render()				
	end
	
	-- textmapXY[n][1] or textmapXY[n][2] is the x,y value of the grid input
	for i =1,#textmapXY,1 do
		tempt=textmapXY[i]
		x=tempt[1]*gridSize
		y=tempt[2]*gridSize
		if TheFloor ~= nil then
		icopyRoofs(x,y)
		icopyFloors(x,y)
		else
		idrawQuad(x,y)
		end
		render()				
	end
	
	ig3d_ShowAll()
 ig3d_SelectWholeMesh() 
 ig3d_CombineSelectedMeshOverlaps_f(1)
 polycount =ig3d_GetNumberOfPolys__i()
 ig3d_CombineEqualMeshMaterials() 
 ig3d_SaveMesh_sf_b(gameroot.."Data/WTF/Dungeons/"..gMapName..currentMapLevel..".wtf",100)
 ig3d_InvertMeshSelection()

 --editingModeSwitch("select_entity")
	--lookbutton()
 end
-- Reset all buttons

function resetAllButtons()
local s=""
for i = 0,GridSize-1,1 do
for ii = 0,GridSize-1,1 do
btnm = "x"..tostring(i).."y"..tostring(ii)
s=s..btnm..":color("..baseBtnColor..")\n"
end
end
ClearAllButtons =loadstring(s)
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
vgridwidth=4
vgridlength,vcubewidth=4,4
vcubelength,vcubeheight=4,4
gridSize,cubeSize=4,4
gridSize,quadSize=4,4
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

	local cc=0
	local sb=""
	local s=""
		for i=1,#textArray,1 do
		cc=cc+1
		sb=sb..textArray[i]
		if cc == GridSize then
		cc=0
		s=s..Q..sb..Q..",\n"
		sb=""
		end
		end
		
		
if currentMapLevel == nil then currentMapLevel = 1 end
if dsbtext2map[currentMapLevel] then
print(currentMapLevel)
	dsbtextsethead="dsbtext2map["..currentMapLevel.."]="..CBI.."1,52,52,0,5,"..CBI.."\n"
	currentText2MapTable = dsbtextsethead.."\n"..string.sub(s,1,-3).."\n"..CBO..CBO.."\n"
	print(currentText2MapTable)
	makenewdsbtext = loadstring(currentText2MapTable)
	makenewdsbtext()
	end

currentMapLevel = n
print(gMapFile)
resetMapper()
--f=io.open(gMapFile,"r")
--if f ~= nil then 
--dofile(gMapFile)
--io.close(f)
--end

--local f = BSDDungeonSpawnsOut()
--if f ~= nil then dofile(f) end
parseDungeon(currentMapLevel)
		fltk_update()		
		--quadGrid()	
end
-- openMapFiles
function openMapFiles()
textArray={}
gMapFile =  chooseFile(tTitle,"*.lua",gameroot.."Data/WTF/Dungeons/")
	if tFile ~= nil then 
	gMapFile = gameroot..tFile
	resetMapper()
	resetDSB()
	local s=""
	local sb=""
	levelmapXY={}
	dofile(gMapFile)
	if #levelmapXY > 1 then
	zeromap={{}}
	zeroline = string.rep("0",52)
		for i=1,GridSize,1 do 
		zeromap[i]={{}}
		
		for ii=1,GridSize,1 do 
		zeromap[i][ii]="0"
		textArray[i+ii]="0"
		 end
		 end
		for i=1,#levelmapXY,1 do
		x=levelmapXY[i][1]
		y=levelmapXY[i][2]
		serialXY=x+(GridSize*y)-GridSize
		textArray[serialXY]="1"
		zeromap[x+1][y+1]=1
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
--table.insert(dsbtext2map,{currentMapLevel})
	dsbtextsethead="table.insert(dsbtext2map,"..CBI.."1,52,52,0,5,"..CBI.."\n"
	currentText2MapTable = dsbtexthead.."\n"..string.sub(s,1,-3).."\n"..CBO..CBO..")\n"
	makenewdsbtext = loadstring(currentText2MapTable)
	makenewdsbtext()
	--print(s)
	print(currentText2MapTable)
	--textmapXY=levelmapXY
	--btnListXY=levelmapXY
	end
	
	gMapName=fileShortNameFromPath(gMapFile)
	currentMapLevel=1
		if #dsbtext2map > 0 then 
		BtnBrowserListMaps()
		parseDungeon(currentMapLevel)		
		end
	end
end
do DungeonMapperWindow= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Click Grid 256")
DungeonMapperWindow:label(gLabelTable[#gLabelTable])
DungeonMapperWindow:callback(wClose)
DungeonMapperWindow:resize(218,377,330,334)
DungeonMapperWindow:when(1)
Fl_Group:current():resizable(DungeonMapperWindow)
DungeonMapperWindow:size_range(260,260,912,854)
--DungeonMapperWindow:show()
do keeper= fltk:Fl_Scroll(0,0,0,0,"")
keeper:resize(0,0,328,328)
keeper:type(7)
keeper:align(5)
Fl_Group:current():resizable(keeper)
do grp= fltk:Fl_Group(0,0,0,0,"")
grp:resize(0,0,325,320)
grp:when(1)
Fl_Group:current():resizable(grp)
Fl_Group:current(Fl_Group:current():parent())
end
end
end
DungeonMapperWindow:show()

-- Mapper MENU FUNCTIONS
MapperMenuIndex={}
MapperMenuText={}
MapperMenuText.Source={"New","Open" ,"Save ig3d","Save BSD Text"}
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
print(tPick)
if tPick == nil or tPick == 0 then tPick = 1 end
print(gMapFile)
resetMapper()
dofile(gMapFile)
local f = BSDDungeonSpawnsOut()
if f ~= nil then dofile(f) end
if currentMapLevel == nil or currentMapLevel == 0 then currentMapLevel = 1 end
parseDungeon(currentMapLevel)
		ButtonSpawnXY()
		BtnBrowserListMaps()
		BtnBrowser:redraw()
		fltk_update()		
		quadGrid()	
end


function MapperBrowsersMenuPick(tPick)
if BtnBrowser == nil then return end;
--CurMapperInfo()	
print(tPick)
if tPick == "New" then 
resetMapper() 
newbsdtext2Map()
currentMapLevel=#dsbtext2map
parseDungeon(currentMapLevel)

BtnBrowserListMaps()
end
		
--if tPick == "Duplicate" then MakeMapper() end;

if tPick == "Open" then
openMapFiles()
end

if tPick == "Save ig3d" then
	saveMappedXY()	
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
print(tMenu,tVal,tPick)
print(tIndex,tIndex1,tIndex2)
	if tIndex ~=nil  then 
	MappermenuHead=item(1,tIndex,"/")
	con=item(1,tIndex2,"/")
	
print(MappermenuHead)
 		if MappermenuHead == "File" then MapperBrowsersMenuPick(tPick) end;
 		if con =="Convert" then quadGrid() end
 		   
 	 end 	
 	 
  Fl:check();
   io.flush();
end

function Mapper_MenuBarFill()
if BtnBrowser == nil then return end;
fillMapperSourceMenu()
fillMapperControlMenu()
end
