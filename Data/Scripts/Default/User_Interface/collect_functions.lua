gDoFileRemember=false
gDoFileRemembered={}

function dofiledump(theFile)
	if theFile=="" then return end
	if string.sub(theFile, -21,-1)~= "collect_functions.lua" then
	
	
	if gDoFileRemember then table.insert(gDoFileRemembered,theFile) end
	
	
	theFile=string.gsub(theFile, "%.fl", ".lua")
	local f=io.open(theFile,"r")
	if f == nil then return {} end
	local str=f:read("*a")
	f:close()
	
	--in a first step, remove comments
	str= removeCommentsFromString(str)
	str=string.gsub(str, "dofile%(", "dofiledump%(")
	str=string.gsub(str, "loadLevel%(", "loadLeveldump%(")
	str=string.gsub(str, "make%(","makedump%(")
	str=string.gsub(str, "loadMesh%(","loadMeshdump%(")

	local code,error=loadstring(str)
	if code== nil then
		print(error)
	else
		code()
	end
	
	end
end

function makedump(whatthing, daname, ...)
	
	if whatthing==ig3d_object then
		if gDoFileRemember then table.insert(gDoFileRemembered,gameroot.."Data/WTF/"..daname) end
	end
	if whatthing==ig3d_particle_emitter then
		if gDoFileRemember then table.insert(gDoFileRemembered,gameroot..daname) end
	end
	
	return make(whatthing, daname, ...)
end

function loadMeshdump(what)
	
	if gDoFileRemember then table.insert(gDoFileRemembered,gameroot..what) end
	loadMesh(what)
end

function loadLeveldump(theFile)
	if gDoFileRemember then table.insert(gDoFileRemembered,gameroot..theFile) end
	dofiledump(gameroot..theFile.."load script.lua")
	loadLevel(theFile)
	
end

gCollectSearchTable={ {"loadLeveldump%([^%)]+%)",""},{"dofiledump%([^%)]+%)",""},{"loadMeshdump%([^%)]+%)",""},{"makedump%([^%)]+%)",""}, {"[%w/_%-][%w/_%- ]*%.wtf","Data/WTF/"}, {"[%w/_%-][%w/_%- ]*%.png",""}, {"[%w/_%-][%w/_%- ]*%.emt",""}, {"[%w/_%-][%w/_%- ]*%.ogg",""} }

function removeCommentsFromString(str)
	local str1=string.gsub(str, "%-%-%[%[.*%-%-%]%]","\n")
	str1=string.gsub(str1, "%-%-[^\n]*\n","\n")
	return str1
end

function insertIfMissing(tbl, elmnt)
	local j
	local exists=false
	for j=1,#tbl,1 do
		if tbl[j]==elmnt then exists=true; break end
	end
	
	if not exists then table.insert(tbl, elmnt) end
end

function collectFilesFromScript(theFile, recursive, level)
	
	
	if level==0 then gDoFileRemember=true; gDoFileRemembered={} end
	
	
	
	--read the whole file to analize
	local f=io.open(theFile,"r")
	if f == nil then return {} end
	local str=f:read("*a")
	f:close()
	
	--in a first step, remove comments
	
	if string.sub(theFile, -4,-1)==".lua" then
	
		str=removeCommentsFromString(str)
		str=string.gsub(str, "dofile%(", "dofiledump%(")
		str=string.gsub(str, "loadLevel%(", "loadLeveldump%(")
		str=string.gsub(str, "make%(","makedump%(")
		str=string.gsub(str, "loadMesh%(","loadMeshdump%(")
	
		--in case of scripts run the file at first
		local code,error=loadstring(""..str)
		if error or code == nil then
			print("ERROR",error)
		else
			
			code()
			--delete(ig3d_scene)
			--game_func=nil
			ig3d_SetMode_i(1)
		end
	end
	
	--built a table of occurences of searches based on a global search table
	local fileList={}
	local subList={}
	if str ~=nil then 
	for i=1,#gCollectSearchTable,1 do

		for w in string.gmatch(str, gCollectSearchTable[i][1]) do
			table.insert(fileList, gCollectSearchTable[i][2]..w)
		end
	end
	end
	
	---there can be a double Data/WTF for occurences in loadMesh() and saveMesh() functions, get rid of these
	--some rules produce results that don't start with "Data", these need to be further analized
	for i=1,#fileList,1 do
		fileList[i]=string.gsub(fileList[i], "Data/WTF/Data/WTF/","Data/WTF/")
		
		if recursive then
			if string.sub(fileList[i],1,5)== "Data/" then
				if string.sub(fileList[i], -4,-1)==".wtf"  or string.sub(fileList[i], -4,-1)==".emt" or string.sub(fileList[i], -4,-1)==".lua" or string.sub(fileList[i], -4,-1)==".fl" then
				
				local subList2=collectFilesFromScript(gameroot..fileList[i],true,level+1)
				for j=1,#subList2,1 do
					table.insert(subList, subList2[j])
				end
				
				end
			else
				fileList[i]=nil --"invalidated"
			end
		end
		--if we
	end
	
	

	local myRemembered=gDoFileRemembered--!!
	
	if level==0 then
		for i=1,#myRemembered,1 do
			if myRemembered[i]~= nil and myRemembered[i]~= "" then 
				table.insert(subList, myRemembered[i])
				local subList2=collectFilesFromScript(myRemembered[i],true,0)
				for j=1,#subList2,1 do
					table.insert(subList, subList2[j])
				end
			end
		end
		gDoFileRemember=false
	end
	
	
	local finalList={}
	for i=1,#fileList,1 do
		if fileList[i]~=nil then insertIfMissing(finalList, gameroot..fileList[i]) end
	end
	for i=1,#subList,1 do
		if subList[i]~=nil then insertIfMissing(finalList,subList[i]) end
	end
	
	return finalList
end

--there may be files in the list that don't exist, remove those
function removeNonExistingFilesFromTable(tbl)
	local i
	for i=#tbl,1,-1 do
		local fh= io.open(tbl[i], "r")
		if fh == nil then table.remove(tbl, i) else fh:close() end
	end
	return tbl
end

function createAllPathsOnTheWay(pth)
	local i
	for i=3,#pth,1 do
		if string.sub(pth, i,i)=='/' then
			lfs.mkdir(string.sub(pth,1,i))
			--print(string.sub(pth,1,i))
		end
	end
end

function getRecursiveFileList(fldr)
	local tbl={}
	local i
	for w in lfs.dir(fldr) do
		if string.sub(w,1,1)~='.' then
			
			local attr=lfs.attributes(fldr..w)
			if attr then
				if attr.mode=="file" then
					table.insert(tbl, fldr..w)
				end
				if attr.mode=="directory" then
					subTbl=getRecursiveFileList(fldr..w.."/")
					for i=1,#subTbl,1 do
						table.insert(tbl, subTbl[i])
					end
				end
			end
		end
	end
	return tbl
end

function getRecursiveListOfAllLevels(fldr)
	local tbl={}
	local i
	for w in lfs.dir(fldr) do
		if string.sub(w,1,1)~='.' then
			
			local attr=lfs.attributes(fldr..w)
			if attr then
			
				if attr.mode=="directory" then
					local f=io.open(fldr..w.."/load script.lua","r")
					if f then
						table.insert(tbl, string.sub(fldr..w, #gameroot+1,-1))
						f:close()
					end
					
					subTbl= getRecursiveListOfAllLevels(fldr..w.."/")
					for i=1,#subTbl,1 do
						table.insert(tbl, subTbl[i])
					end
					
				end
			end
		end
	end
	return tbl
end


function getListOfAllLevels()
	return getRecursiveListOfAllLevels(gameroot.."Data/Levels/")
end


function collectLevels(levelList, targetPath)
	
	--first some essentials
	local tbl={}
	
	local scripts= getRecursiveFileList(gameroot.."Data/Scripts/")
	local icons= getRecursiveFileList(gameroot.."Data/Icons/")
	local fluids= getRecursiveFileList(gameroot.."Data/Fluid/")
	local shaders= getRecursiveFileList(gameroot.."Data/Shaders/")
	
	for i=1,#scripts, 1 do
		table.insert(tbl, scripts[i])
	end
	for i=1,#icons, 1 do
		table.insert(tbl, icons[i])
	end
	for i=1,#fluids, 1 do
		table.insert(tbl, fluids[i])
	end
	
	for i=1,#shaders, 1 do
		table.insert(tbl, shaders[i])
	end
	
	

	
	local i,j
	for i=1,#levelList,1 do
	print("Start:",levelList[i],os.time())
	
		local level=getRecursiveFileList(gameroot..levelList[i].."/")
		for j=1,#level, 1 do
			table.insert(tbl, level[j])
		end
	
		--local fromlevel=removeNonExistingFilesFromTable(collectFilesFromScript(gameroot..levelList[i].."/load script.lua",true,0))
		
		loadLevel(levelList[i])--actually load the level which fills the loaded files list of the engine
		ig3d_SetMode_i(4)
		game_func=nil -- must be defined in the game
		coll_o_m=nil -- can be defined in the game
		coll_o_o=nil -- can be defined in the game
		coll_o_p=nil -- can be defined in the game
		coll_p_p=nil -- can be defined in the game
		coll_p_m=nil -- can be defined in the game
		render()
		
		local fromlevel=stringtotable(ig3d_GetLoadedFilesList__s())
		
		
		insertIfMissing(tbl, gameroot..levelList[i].."/load script.lua")
		for j=1,#fromlevel,1 do
			insertIfMissing(tbl, gameroot..fromlevel[j])
		end
		
		print("Done:",levelList[i],os.time())
	
	end
	
	
	
	table.insert(tbl, gameroot.."Data/game script.lua")
	for i=1,#tbl,1 do

		local srcPath=tbl[i]
		local dstPath=targetPath..string.sub(tbl[i],#gameroot+1,-1)
		createAllPathsOnTheWay(dstPath)
		
		murgaLua.fileCopy(srcPath,dstPath)
	end
	
	
	--local fh=io.open(targetPath.."Data/alternateRoot.txt","w")
	--fh:write(targetPath)
	--fh:close()
	
	
	loadLevel("Data/Levels/default")
	fltk.fl_message("Collection successful")
	game_func = titleWait
	print("Done:",targetPath,os.time())
	ig3d_SetMode_i(1)
	return tbl
end

