gameroot=getSceneInfo(IG3D_ROOT)

function ModelAnimationList(src)
gAnimSourceModel = src --gObjectNames[n]
if gAnimSourceModel == nil then gAnimSourceModel = gObjName end
	p=ig3d_GetObjectModelPath_s_s(gAnimSourceModel)
	local tmp=io.open(p,"r")
	if tmp== nil then return end
	gAnimsList={}
	tmp:seek("set",ig3d_GetObjectModelAnimOffset_s_i(gAnimSourceModel))
	local n=tmp:read("*l")	--read chunk name
	n=tonumber(tmp:read("*l"))		--how many animations?
	if n >= 1 then 
	for i=1,n,1 do
	--print("i=",i,"n=",n)
		local newAnim={markers={} }
		newAnim.name=tmp:read("*l")
		local an=tonumber(tmp:read("*l"))
		if an ~= nil then 
		for j=1,an,1 do
			local m={cntrl=nil}
			tims=tmp:read("*l")
			morphs=tmp:read("*l")
			end
			table.insert(gAnimsList, newAnim)		
		--print(newAnim.name)
		end
		end
		else
		print("no animations")
		end
		tmp:close()	
		return gAnimsList
end

function runLevelAnim(trgt,src,n,b)
if src ~= nil then 
if n == nil then n = 1 end
if b==nil or b == 0 then b=false else b=true end
	local o=get(ig3d_object, trgt)
	ModelAnimationList(src)
	offst=ig3d_GetObjectModelAnimOffset_s_i(src)
	ig3d_ReadModelAnimationsFromFile_2si(trgt, ig3d_GetObjectModelPath_s_s(src), offst)
	ig3d_SetAutoBoneUpdating_b(true)
	setObjectInfo(o, IG3D_ANIMATION, gAnimsList[n].name, 0, b)
	end
end


--[[for bvh to wif to wtf conversion use the following functions
1. createBVHPathTables
2a. open a level with a model with  compatible bones
2b. run convertBVHtoWIF
3. run convertWIFtoWTF
--]]

function createBVHPathTables()
--[[createBVHPathTables Seeks through the given path ex, "Data/BVH/TrueBones/", 
	through folders and sub folders
	for files and creates a table and file of the anim name and path to load
	which is called by the sortBVHWIFTables and matched with the available WIF files]]--
	BVHTables={"animname","pathtoload"}
	BVHTables.animname={}
	BVHTables.pathtoload={}
	local  dirList={}
	dirList=listFolders(gameroot.."Data/BVH/TrueBones/")
	local  namessout=""
	local pathsout=""
	local qt='"'
	tableinc=1
	for i = 1,#dirList,1 do 
	
	 BVHinDir = gameroot.."Data/BVH/TrueBones/"..dirList[i]
	 
	 --get files at root of folder first
	 BVHFileList={}
	 BVHFileList=listFiles(BVHinDir)
			if #BVHFileList >= 1 then
			for ii = 1,#BVHFileList,1 do 
	 		BVHtoRead  = BVHinDir.."/"..BVHFileList[ii]
	 		--print(BVHtoRead)
	 		tableinc=tableinc+1
			AnimName = string.sub(BVHFileList[ii], 1, string.find(BVHFileList[ii],"%p")-1)
			BVHTables.animname[tableinc] = AnimName
			BVHTables.pathtoload[tableinc] = BVHtoRead
			namessout = namessout..qt..AnimName..qt..","
	     	pathsout = pathsout..qt..BVHtoRead..qt..","
	 		end --foreachfile
	 		end -- endif
	 		
	 		--get files from second level folders
	 		subdirlist={}
	        subdirlist=listFolders(BVHinDir.."/")
	        if #subdirlist >= 1 then
	 			for iii = 1,#subdirlist,1 do 
	 			subpath=BVHinDir.."/"..subdirlist[iii]
	 		--	print(subdirlist[iii])
	 			BVHFileList={}
	 			BVHFileList=listFiles(subpath)
	 			
	 			if #BVHFileList >= 1 then
					for iv = 1,#BVHFileList,1 do
					tableinc= tableinc + 1
				--	print(tableinc)
	 				BVHtoRead  = subpath.."/"..BVHFileList[iv]
	 				--print(BVHtoRead)
					AnimName = string.sub(BVHFileList[iv], 1, string.find(BVHFileList[iv],"%p")-1)
					BVHTables.animname[tableinc] = AnimName
					BVHTables.pathtoload[tableinc] = BVHtoRead
					namessout = namessout..qt..AnimName..qt..","
	     			pathsout = pathsout..qt..BVHtoRead..qt..","
	 				end --foreachfile  iv
	 			end --endif
	 			end --iii
	 		end --endif subdirlist
	 			
 				
	end --foreachfolder
	
	 namestable = "BVHTables.animname={"..string.sub(namessout,1,-2).."}\n"
	 pathstable = "BVHTables.pathtoload={"..string.sub(pathsout,1,-2).."}\n"
	BVHTableOut = "BVHTables={"..qt.."animname"..qt..","..qt.."pathtoload"..qt.."}\n"..namestable.."\n"..pathstable
	myFileName=gameroot.."Data/BVHPathTables.lua"
			myFile = io.open(myFileName, "w")
					if myFile ~= nil then
					myFile:write(string.char (10))
 					myFile:write(BVHTableOut)
 					myFile:write(string.char (10))
  				    end 
				io.close(myFile)
end	

function recreateWIFPathTables()
--[[Seeks inside of of Data/WIF/ for organized bvh files 
	Creates tables of the name and the path which will be used to match with bvh files
	This function was necessary for reexport over 1,000 bvh without losing the organization
	Requires "Data/WIF" directory with subdirectories labeled Walk_*, Idle_*, Fight_* etc]]--
	
	WIFTables={"animname","pathtosave"}
	WIFTables.animname={}
	WIFTables.pathtosave={}
 	dirList={}
 	dirList=listFolders(gameroot.."Data/WIF/")
 	namessout=""
 	pathsout=""
 	qt='"'
	for i = 1,#dirList,1 do 
	 WifinDir = gameroot.."Data/WIF/"..dirList[i]
	 
	 wifFileList={}
	 wifFileList=listFiles(WifinDir)
			if #wifFileList >= 1 then
			for ii = 1,#wifFileList,1 do 
	 		WIFtoRead  = WifinDir.."/"..wifFileList[ii]
			AnimName = string.sub(wifFileList[ii], 1, string.find(wifFileList[ii],"%p")-1)
			WIFTables.animname[ii] = AnimName
			WIFTables.pathtosave[ii] = WifinDir.."/"
			namessout = namessout..qt..AnimName..qt..","
	 		pathsout = pathsout..qt..WifinDir.."/"..qt..","
	 		end --foreachfile
	 		
 			end	--endif	
	end --foreachfolder
	
	namestable = "WIFTables.animname={"..string.sub(namessout,1,-2).."}\n"
	pathstable = "WIFTables.pathtosave={"..string.sub(pathsout,1,-2).."}\n"
	WIFTableOut = "WIFTables={"..qt.."animname"..qt..","..qt.."pathtosave"..qt.."}\n"..namestable.."\n"..pathstable
	myFileName=gameroot.."Data/WIFPathTables.lua"
			myFile = io.open(myFileName, "w")
					if myFile ~= nil then
					myFile:write(string.char (10))
 					myFile:write(WIFTableOut)
 					myFile:write(string.char (10))
  				    end 
				io.close(myFile)
end	

function sortBVHWIFTables()
--[[matches the WIF path such as Data/WIF/Idle_Alive/someanim.txt with
	the appropriate BVH animation file, creating a table and file for access
	This sorted table file was used to convert 1,000+ BVH to .txt file]]--
pathsMatched={"animname","inpath","outpath"}
pathsMatched.animname={}
pathsMatched.inpath={}
pathsMatched.outpath={}
counter=1
ntext=""
itext=""
otext=""
qt='"'
dofile(gameroot.."Data/BVHPathTables.lua")
dofile(gameroot.."Data/WIFPathTables.lua")
for i=1,#BVHTables.pathtoload,1 do
bvhname=BVHTables.animname[i]
-- check match
amatch=false
matchout = nil
for ii=1,#WIFTables.animname,1 do
wifname = WIFTables.animname[ii]
pathsMatched.animname[counter] = bvhname
pathsMatched.inpath[counter]=BVHTables.pathtoload[i]
if wifname == bvhname then matchout = WIFTables.pathtosave[ii] end 
end --forii
if matchout == nil then matchout = gameroot.."Data/WIF/" end
pathsMatched.outpath[counter] = matchout
ntext=ntext..qt..bvhname..qt..","
itext=itext..qt..BVHTables.pathtoload[i]..qt..","
otext=otext..qt..matchout..qt..","
counter=counter+1
end --fori
 namestable = "BVHtoWIF.animname={"..string.sub(ntext,1,-2).."}\n"
	 intable = "BVHtoWIF.import={"..string.sub(itext,1,-2).."}\n"
	  outtable = "BVHtoWIF.export={"..string.sub(otext,1,-2).."}\n"
	conversionTableOut = "BVHtoWIF={"..qt.."animname"..qt..","..qt.."import"..qt..","..qt.."export"..qt.."}\n"..namestable.."\n"..intable.."\n"..outtable
	myFileName=gameroot.."Data/WIFtoBVHTables.lua"
			myFile = io.open(myFileName, "w")
					if myFile ~= nil then
					myFile:write(string.char (10))
 					myFile:write(conversionTableOut)
 					myFile:write(string.char (10))
  				    end 
				io.close(myFile)
end --fun

function convertBVHtoWIF(nstrt)
--[[ Use the imported tables to convert BVH files to .txt (WIF) files, in sorted paths
BVHtoWIF.animname = short names of BVH files
BVHtoWIF.import = the .bvh import path for the converter to use
BVHtoWIF.export = the path that the .txt or (WIF) file
use this function for automated conversion, beware, bugs stop the function
nstrt is used to track the failed files and start at the next step
]]--
dofile(gameroot.."/Data/Scripts/Examples/truebonesbvh_parser.lua")
--dofile(gameroot.."Data/WIFtoBVHTables.lua")--for recreation only
dofile(gameroot.."Data/BVHPathTables.lua")
if nstrt == nil then nstrt = 1 end
for iii = nstrt,#BVHtoWIF.animname,1 do
--[[for recreation from wif/bvh sorted tables
animName = BVHtoWIF.animname[iii]
bvhFile = BVHtoWIF.import[iii]
wifPath = BVHtoWIF.export[iii]]--
-- use this for generic export to wif folder
animName = BVHTables.animname[iii]
bvhFile = BVHTables.pathtoload[iii]
wifPath = gameroot.."Data/WIF/"
--print(iii,wifPath,animName)
ts=io.open(bvhFile,"r")
if ts ~= nil then 
	loadBVHFile(bvhFile, false)	
	local step=0.1	
	local lStart=0
	local lFrm=1	
	
	fh=io.open(wifPath..animName..".txt","w")	
	local t=math.floor(#poses*gFrameTime / step)*20 ---better count bones and dont assume 20
	
	fh:write(animName.."\n"..t.."\n")	
	local at=0	
	
	while lFrm<#poses do
		lStart=lStart+step
		lFrm=math.floor( lStart/gFrameTime)
		if lFrm<=#poses and lFrm>0 and at < t then
			at=at+20
			rootBone.itrtr=string.gmatch(poses[lFrm], "[^ ]+")
			createLocalMatricesForBVHFrame(rootBone, rootBone.itrtr)			
			local objname=getObjectInfo(1, IG3D_NAME)
			bns=ig3d_GetObjectBonesList_s_s(objname)
			local itrtr=string.gmatch(bns, "[^\n ]+")	
			local a=true
			local i=0
			while a~= nil do
				a=itrtr()
				if a ~=nil then
					local bonx,bony,bonz,bonxa,bonya,bonza=ig3d_GetObjectBoneInfo_2s_6f(objname,a)
					a=itrtr()
					fh:write((lStart-step)..","..lStart.."\n")
					fh:write("morph="..i..","..bonx..","..bony..","..bonz..","..bonxa..","..bonya..","..bonza.."\n")
					i=i+1
				end		
			end			
		end
	end
	fh:close()
--tt just slows it down a tiny bit
	for tt=1,10000,1 do end
	end  ---if not nil
	ts:close()
	end --fori
end

function WTFNoAnimFile()
-- return the chosen file without animation chunk
-- used as template for WIF animation WTF file creation
sourceWTFText=""
sourceWTFile = gameroot.."Data/WTF/Characters/truebonesmaster.wtf"
	local sf=io.open(sourceWTFile, "r")
	local tWTF=sf:read("*a")
	local animSt,animEn=string.find(tWTF,"#Animations")
	if animSt ~= nil then
	sourceWTFText=string.sub(tWTF,1,animSt-1)
	end
	sf:close()
	return sourceWTFText
end



function convertWIFtoWTF()
-- create animation wtf files from folders containing exported BVH data as text
-- requires "Data/WIF" directory with subdirectories labeled Walk_*, Idle_*, Fight_* etc
 dirList={}
 dirList=listFolders(gameroot.."Data/WIF/")
	for i = 1,#dirList,1 do 
	realAnimCount=0
	 WTFouttext=""
     SourceAnimsText=""
	 WifinDir = gameroot.."Data/WIF/"..dirList[i]
	 dst,den=string.find(dirList[i],"_")
	-- first part of name is prefix
	 animFilePrefix=dirList[i]    --string.sub(dirList[f],1,dst-1)
	-- print(animFilePrefix)
	 wifFileList={}
	 wifFileList=listFiles(WifinDir)
-- each file
if #wifFileList >= 1 then
		for ii = 1,#wifFileList,1 do 
	 	WIFtoRead  = WifinDir.."/"..wifFileList[ii]
	 	wifText = getFileText(WIFtoRead)
	
		AnimCount =0 
		AnimName = string.sub(wifFileList[ii], 1, string.find(wifFileList[ii],"%p")-1)
	 --print(AnimName) 
	  if string.len(wifText) >= string.len(AnimName) then	 	
	 		elo=string.find(wifText,"\n")
	 		wifshort = string.sub(wifText,elo+1,-1)
	 			if wifshort ~= nil then 
	 			elt=string.find(wifshort,"\n")
	 			AnimCount = string.sub(wifshort,1,elt-1)
	 				if tonumber(AnimCount) ~= nil then
	 					
	 					wifdata = string.sub(wifshort,elt+1,-1)
						countanlins=0
		     				for cw in string.gmatch(wifdata,"\n") do countanlins=countanlins+1 end 
					     	
								if  countanlins >= (tonumber(AnimCount)*2)  then 
								realAnimCount = realAnimCount+1
						 		SourceAnimsText = SourceAnimsText..AnimName.."BVH"..countanlins.."\n"..AnimCount.."\n"..wifdata
						 		--print(AnimName.."   normal Animcount*2="..(tonumber(AnimCount)*2).."count="..countanlins)
						 		else
						 	realAnimCount = realAnimCount+1
						 		SourceAnimsText = SourceAnimsText..AnimName.."BVH"..countanlins.."\n"..math.floor(countanlins/2).."\n"..wifdata
						 	--	print(AnimName.."   error Animcount*2="..(tonumber(AnimCount)*2).."count="..countanlins)
 								end
 					end		--animcount
 				end		--wifshort
 			end -- wiftext
 		end --foreachfile
 end
 		
		if  SourceAnimsText ~= nil then 
		WTFouttext = WTFNoAnimFile().."#Animations\n"..realAnimCount.."\n"..SourceAnimsText.."END"
		end
	
		if WTFouttext ~= nil then 
			myFileName=gameroot.."Data/WTF/WIF/"..dirList[i]..".wtf"
			myFile = io.open(myFileName, "w")
					if myFile ~= nil then
					--myFile:write(string.char (10))
 					myFile:write(WTFouttext)
 					myFile:write(string.char (10))
  				    end 
				io.close(myFile)
		end
	end --foreachfolder
end	


