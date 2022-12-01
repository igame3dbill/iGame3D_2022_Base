-- added 04 04 09
gAllFunctionsList={}
-- Added 01 17 2009
function read_load_script_text(whichLevel,textStart,textEnd)
--read_load_script_text("myLevel","gObjectsWTFs=","gObjectColls=")
local f=io.open(gameroot.."Data/Levels/"..whichLevel.."/load script.lua","r")
 if  f== nil then return end
 local gText=f:read("*a")
 io.close(f)
 local st = string.find(gText,textStart)
 local en =  string.find(gText,textEnd)
 return gText,st,en
end


---MurgaLua 0.5.5 Directory changes

-- Fast FilePaths, creates directories

function fastFilePaths(ft,whatExt)
fastPath=gameroot.."Data/"..ft
ig3d_CreateDirectory_s(fastPath)
fastFile=fastPath.."/"..os.time()..whatExt
return fastFile
end

function listFolders(path)
local folderList={}

    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            local f = path..file
           -- print(f)
            local attr = lfs.attributes(f)
            assert (type(attr) == "table")
             if attr.mode == "directory" and string.sub(file,1,1)~="." then    
             table.insert(folderList, file)

             end   
        end
    end
    return folderList
end

function folderExists(path,foldername)
local list= listFolders(path)

for i,v in pairs(list) do
if v == foldername then return true end
end
return false
end


function listFiles(path)
local fileList={}
--print(path)
    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            local f = path.."/"..file
           -- print(f)
            local attr = lfs.attributes(f)
            assert (type(attr) == "table")
             if attr.mode == "file" then 
             if file ~= ".DS_Store"  then
             table.insert(fileList, file)
             end
           -- print(file)
           end   
        end
     end
    return fileList
end

function isFile(filepath)
            local attr = lfs.attributes (filepath)
            assert (type(attr) == "table")
             if attr.mode == "file" then 
             return true
             else
             return false
             end
end

-- writetoURL ="write text to a file name"
function writetoURL(myFileName,whatText)
myFile = io.open(myFileName, "w")
if myFile ~= nil then
 myFile:write(string.char (10))
 myFile:write(whatText)
 myFile:write(string.char (10))
 io.close(myFile)
end 
end 
writetoFile=writetoURL

function writeafterURL(myFileName,whatText)
myFile = io.open(myFileName, "a")
 myFile:write(string.char (10))
 myFile:write(whatText)
 myFile:write(string.char (10))
 io.close(myFile)
end 
writeafterFile = writeafterURL
-- full text of file
function getFileText(w)
		 local wf=io.open(w, "r")
		 local o=wf:read("*a")
		 wf:close()
		 return o
		 end
		 
		 function copyFile(w,newname)
		o= getFileText(w)
		writetoFile(newname,o)
		 end
		 
function go_gui(whatwindow)
  print("go_gui("..whatwindow..")")
if whatwindow==nil then 
dofile(gameroot.."Data/Fluid/console/console.fl")
dofile(gameroot.."Data/Fluid/console/script_editor.fl")
return
end

guicxxFile=gameroot.."Data/Fluid/"..whatwindow.."/"..whatwindow..".fl"
guiluaFile=gameroot.."Data/Fluid/"..whatwindow.."/"..whatwindow..".lua"

if isFile(guicxxFile) then dofile(guicxxFile)
elseif isFile(guiluaFile) then dofile(guiluaFile)
end
end



function dofilewithoutwait(fileName)
oldgame=game_func
dofile(fileName)
if oldgame~= nil then
game_func=oldgame
end
end

function ListFolder(whatPath,whatItems)
folderCount=0
fileCount=0
folderList=""
fileList=""
folders={}
if whatPath==nil then whatPath=gameroot end;
if whatPath==nil then whatPath="/" end;

----First get the folders
directoryContents = listFolders(whatPath);  
dirItemCount=table.getn(directoryContents)
-- For each entry
if dirItemCount == 0 then return  end

for i=1,table.getn(directoryContents),1 do
directoryItemPath= whatPath..directoryContents[i]

if string.sub(directoryContents[i],1,1) ~="." then
folderCount=folderCount+1
folders[folderCount]=directoryContents[i]
folderList=folderList..directoryContents[i].."\n"
end
end  --fori

----NOW GET THE FILES
directoryContents = listFiles(whatPath);  
dirItemCount=#directoryContents
for i=1,#directoryContents,1 do
directoryItemPath= whatPath..directoryContents[i]
if string.sub(directoryContents[i],1,1) ~="." then
fileCount=fileCount+1
files[fileCount]=directoryContents[i]
fileList=fileList..directoryContents[i].."\n"
end
end

if whatItems == "t" then return folders end
if  whatItems ~=nil and string.find(whatItems,".")~=0 then 
return fileList
else
return folderList
end
end

function ls(tpath)
fileList = ListFolder(tpath)
return fileList
end


		 
-- application reset 
function appreset()
dofile(bundleroot.."Data/game script.lua")
end



-- custom gameroot
function folderPath(whatPath,doWhat)
if doWhat=="set" then
if whatPath~=nil then 
--setSceneInfo(gameroot..whatPath)
end
end
gameroot=getSceneInfo(IG3D_ROOT)
return gameroot
end

--Open FLUID FILES WITH CONVERSION
function OPEN_UI_WINDOWS(whichWindow)
gameroot=getSceneInfo(IG3D_ROOT)
FluidInFile=gameroot.."Data/GUI/"..whichWindow.."/"..whichWindow..".fl"
LuaOutFile=gameroot.."Data/GUI/"..whichWindow.."/"..whichWindow..".lua"
parseFluid(FluidInFile,LuaOutFile)
dofile(LuaOutFile)

end --OPEN_UI_WINDOWS

function OPEN_FLUID_WINDOWS(whichWindow)
gameroot=getSceneInfo(IG3D_ROOT)
FluidInFile=gameroot.."Data/Fluid/"..whichWindow.."/"..whichWindow..".fl"
LuaOutFile=gameroot.."Data/Fluid/"..whichWindow.."/"..whichWindow..".lua"
parseFluid(FluidInFile,LuaOutFile)
dofile(LuaOutFile)

end

function OPEN_WIZARD_WINDOWS(whichWindow)
gameroot=getSceneInfo(IG3D_ROOT)
FluidInFile=gameroot.."Data/Wizards/"..whichWindow.."/"..whichWindow..".fl"
LuaOutFile=gameroot.."Data/Wizards/"..whichWindow.."/"..whichWindow..".lua"
parseFluid(FluidInFile,LuaOutFile)
dofile(LuaOutFile)
end

function UniversalBrowserShow()
if uBrowserNew ~= nil then
	uBrowserNew:hide()
	uBrowserNew = nil
	end
OPEN_UI_WINDOWS("UniversalBrowser")
end

-- Open UniversalBrowser.fl fill it's main field with the browsed data
function UniversalBrowse(tpick)
  print("\nUniversalBrowse("..tpick..")")
n=1
if tPick =="" then UniversalBrowserShow() end
	if tPick == "Console" or tPick == "Library/Console" then 
		if console~= nil then
		console:hide()
		console = nil
		end
		--OPEN_UI_WINDOWS see Data/Scripts/Default/Base/file_functions.lua
	OPEN_UI_WINDOWS("console")
	n=0
	end
	
	if string.find(tPick,"WIF") ~= nil then 
		if wifBrowser~= nil then
		wifBrowser:hide()
		wifBrowser = nil
		end	
	OPEN_UI_WINDOWS("wifbrowser")
	n=0
	end
	
	if string.find(tPick,"WTF") ~= nil then 
		if WTFBrowserNew~= nil then
		WTFBrowserNew:hide()
		WTFBrowserNew = nil
		end
	OPEN_UI_WINDOWS("WTFBrowser")
	n=0
	end
	
	if string.find(tPick,"Collect") ~= nil then 
		if wifBrowser~= nil then
		wifBrowser:hide()
		wifBrowser = nil
		end	
	OPEN_UI_WINDOWS("Collector")
	n=0
	end
	
		if string.find(tPick,"BVH") ~= nil then 
		if BVHBrowser~= nil then
		BVHBrowser:hide()
		BVHBrowser = nil
		end	
	OPEN_UI_WINDOWS("BVHbrowser")
	n=0
	end
	
--
if n == 1 then
UniversalBrowserShow()
end
end


--Creates PNG preview of model thefile1 and saves it to thefile2 where thefile2 is a full path to the image and thefile1 is a wtf file relative to iGame3D root directory
function createWTFPreviewPNG(thefile1,thefile2)
delete(ig3d_scene)
ig3d_SetMode_i(1)
loadMesh(thefile1)


ig3d_SetMeshPositionNoUndo_3f(0,0,0)
--find out major axis and scale that to 1
local x1,x2,y1,y2,z1,z2=ig3d_GetMeshBounds__6f()

local sx=1
local sy=0
local sz=0
local major=x2-x1

if y2-y1 > major then
	sx=0
	sy=1
	major=y2-y1
end

if z2-z1 > major then
	sx=0
	sy=0
	sz=1
end


ig3d_Get3DControllerVisibility__b(false)
ig3d_ScaleSelectedMeshTo_3f(sx,sy,sz)
-- November 28 2013 changed rotation for OBJ/3DS export.
ig3d_RotateSelectedMesh_6f (90, 0, 0, 0, 0, 0)
ig3d_SetFourViews_b(false)
ig3d_SetWindowBounds_4i(100,100,356,356)
setSceneInfo(IG3D_FOV, true, 45)
setCameraInfo(IG3D_ROTATION, 37,-135,0)
setCameraInfo(IG3D_POSITION, 1.5,1.5,1.5)
setLightInfo(1, IG3D_POSITION, 15,15,15,1)
setLightInfo(2, IG3D_POSITION, 15,15,15,1)
ig3d_SetMode_i(4)
-- November 28 2013 added export for OBJ and 3DS to WTFPreview.
ig3d_SaveMeshAsOBJ_sf(string.sub(thefile2,1,-5)..".obj",100)
ig3d_SaveMeshAs3DS_sf(string.sub(thefile2,1,-5)..".3ds",100)
ig3d_SaveScreenshot_s2bi(thefile2, true,false,0)
delete(ig3d_scene)
end

--takes two relative folder paths. Creates previews of all WTFs in thefolder1 and puts these previews into thefolder2
function batchPreviewsForFolder(thefolder1, thefolder2)
	local allFiles=listFiles(gameroot..thefolder1)
	local i
	local suffix
	
	for i=1,#allFiles,1 do
	--for i=1,10,1 do
		suffix=string.sub(allFiles[i], -4,-1)
		if suffix==".wtf" then
			createWTFPreviewPNG(thefolder1..allFiles[i], gameroot..thefolder2..string.sub(allFiles[i],1,-5).."_wtf.png")
		end
	end
end

-- for parsing all scripts December 1 2008
gFoldersFound={}
gFilesFound={}
gScriptsPath = gameroot.."Data/Scripts"



function dirandsubdirs(tPath)
	for file in lfs.dir(tPath) do
		if string.sub(file, 1,1) ~= "."    then
		local f = tPath..'/'..file
            	local attr = lfs.attributes(f)
            	assert (type(attr) == "table")
             		if attr.mode == "directory" then 
           		local a={file, "directory"}
           		f =string.gsub(f,"//","/")
			table.insert(gFoldersFound, f)
			end 
		end
	end
	
end

function getfilelist(tPath)
	for file in lfs.dir(tPath) do
 		if string.sub(file, 1,1) ~= "."    then
        local f = tPath..'/'..file
        local attr = lfs.attributes(f)
		assert (type(attr) == "table")
        	if attr.mode == "file" and string.sub(file, -4,-1)==".lua" then 
            local a={file, "file"}  
            table.insert(gFilesFound, f) 
            end  
 		end          
	end
end


function getAllFoldersandFiles(tPath)
gFoldersFound={}
dirandsubdirs(tPath)
local n = #gFoldersFound
for i =1,n,1 do dirandsubdirs(gFoldersFound[i]) end
gFilesFound={}
if gFoldersFound[1]== nil then gFoldersFound[1] = tPath end
for i = 1,#gFoldersFound,1 do getfilelist(gFoldersFound[i]) end	
end


function parseScriptsForFunctions(wVals)
funOutput=""
fun=""
n=0
gFunctionsInFile={}
gAllFunctionsList={}
searchAFile= (string.sub(wVals,-3,-1) == "lua")
if searchAFile == true then 
gFilesFound={wVals} 
else
if wVals == nil then  
	getAllFoldersandFiles(gameroot.."Data/Scripts/") 
	wVals=gameroot.."Data/Scripts/"
	else 
	  getAllFoldersandFiles(gameroot.."Data/"..wVals) 
	 wVals =  gameroot.."Data/"..wVals
	end
	end
	for i = 1,#gFilesFound,1 do			
	f=io.open(gFilesFound[i], "r")
	tText=f:read("*a")
	f:close()	
	--print()
	--print(gFilesFound[i])
		for a in string.gmatch(tText,"function%s.*%(") do
				if wVals ~= nil   then	
				s,e=string.find(tText,a,1,true)
				sText = string.sub(tText,s,s+string.len(tText))
				cr=string.find(sText,"%)",1)
				b = string.sub(tText,s,s+cr)
				fun = string.sub(b,10,-2)
				table.insert(gFunctionsInFile,fun)
					if string.find(fun,funOutput) ~= nil then fun = fun .. "   --DUPLICATE"..gFilesFound[i] end
				funOutput = funOutput .."\n"..fun
				n=n+1
				searchAFile=true
				else
				fun = string.sub(a,10,string.find(a,"%(")-1)	
					if string.find(fun,funOutput) ~= nil then fun = fun .. "   --DUPLICATE"..gFilesFound[i] end
				funOutput = funOutput .."\n"..fun
				n=n+1
				searchAFile=true
				end		
				print(fun)	
				if searchAFile ~= true then	table.insert(gAllFunctionsList,fun) end
				end				
				
				
	end				
	print("Found "..n.." functions")
return	funOutput
end








