--function make_window()
if ModelsBrowser then
ModelsBrowser:hide()
ModelsBrowser = nil
end

gObjName=""
gOldSel=""
gCurSel=""
gBoneName=""
gMarkers={}
gAnimSourceModels=""
lastPushed=nil
storedSingleSelect=0
dragged=false
gAnimOffset=0
gSourceAnimsList={{name="NewAnim", markers={} }}
gCurAnim=1
gObjName=getObjectInfo(1, IG3D_NAME)
gSelector=nil
 orig_edit_func=nil
 ModelsBrowser=nil
 filad={"Walk","Idle","Fight"}
 ModelsFileList={}
 WTFsourcelist={}
 
 gObjName=""
gOldSel=""
gSelectedModels=""
gAttributePicked = 1
gEVals={}
gCurSel=ig3d_GetSelection__s()
gObjName=gCurSel ;  

ModelsFieldValues={}
gModelsFileValues={}
gModelsFileAttributes={}
lastPushed=nil
storedSingleSelect=0
dragged=false
gLastBrowserControlClick=time()
gLastSelection=-1

ModelsBrowserFileList={}
gModelsFilesShortNames={}
gModelsSource = ""
gModelsSourcePath = ""
gModelsBrowserFiles={}

if gNumModels == nil or gNumModels == 0 then 
gModelsNames={}
gModelsPositions={}
gModelsRotations={}
gModels={}
end

gModelsValues={} ; -- List of current values
-- gModelsAttributes={} ; --List of current attribute names
gModelsAttributes={"name","position","rotation","scale","bones","materials","source"}

gSelModelsData={}  ; --raw input from getInfo

gBrowserModelsPath = gameroot.."Data/WTF/"
gModelsBrowserPath = gBrowserModelsPath
gBrowserImagesPath = gameroot.."Data/Images/"
gBrowserEMTPath = gameroot.."Data/Emitters"
gBrowserImagesFiles={}
gBrowserEMTFiles={}
gCatchModelPath = ""
gCatchTexturePath=""
gwtfFileBrowserLines={}

gSourceRequest = ""  ;-- mode of selecting Models source from browser
gModelsNewName=""  ; -- hold short name of Models or Models name for new make

gNewModelsValueItems={} ;-- multi item list from field values ie x,y,z etc
gModelsValueItems={};-- multi item list from Models attriute values ie x,y,z etc
gOldInfo = ""

gLastModelsSourceSelection =0
gLastModelsSourceBrowserControlClick = 0
gModelsBrowserFiles={}
gLastSourceDirectory ="WTF"
gModelsShortPath=""
gWTFReplacementFile=""

gSelectedMaterialAttributes={}
gSelectedMaterialValues={}
gSelectedMaterialData={} ; -- raw
gObjectNum = 0
gObjectInfoAttributes={}

if gObjects == nil then 
gObjects={}
gObjectColls={}
gObjectHUDs={}
gObjectWTFs={}
gObjectNames={}
gObjectPositions={}
gObjectRotations={}
gObjectSizes={}
end

gModelsDetailsInfo ={}
gNumHelpedAttributes=1
gModelsGetInfoTable={}
gModelsToolTipPicked="translate"
gModelsMaterialsValueItems={}
gSelModelsMaterialsData={}
gModelsMaterialsAttributes={}
gSelectedMaterialAttributes={}
gSelectedMaterialAttribute=1
gNewModelsMaterialsValueItems={}
colorfulMaterialAtt="color,ambient,diffuse,specular,emission"
gObjNum = 1
-- globals_and_functions_codeblock
colorAttributes={"Ambient","Diffuse","Specular","Alpha"}
gColorEditMode = "Background"
gColorAttribute = "Ambient"
gColorTargets = {"Background","Grid","Fog","Light","Object","Material","Tint"}
gfogEnabled, gFogRed, gFogGreen, gFogBlue, gFogstart, gFogend = getSceneInfo(IG3D_FOG)

--colorsourcefile = gameroot.."Data/Images/Colors/colorsource.png"
--loadTexture("Data/Images/Colors/colorsource.png") 
--fltk.fl_register_images()

quote ='"'
gRed,gBlue,gGreen,Alpha = 1,1,1,1
gRed, gGreen, gBlue = getSceneInfo(IG3D_BACKGROUND_COLOR)
gAlpha = 1
choosr,choosg,choosb = (gRed +1) * 254, (gGreen+1) * 254, (gBlue+1) * 254


function MaxOfOne(w)

--if tonumber(w) == nil then return 0 end 
if tonumber(w) >= 1 then return 1 end
--if tonumber(w) <= 0.00004 then return 0.00004 end
end
-- executeTable
function executeTable(w)
local i=0

if #w == nil then return end
	for i=1,#w,1 do		
	local code,error=loadstring(w[i])
		if code==nil then
		fltk.fl_message("The script you were attempting to run contains errors:\n"..error)
		else
		code()
		end
	end
end
-- ModelsBrowserGroupsHide
function ModelsBrowserGroupsHide()
  		if gModelsToolTipPicked ~="source" then  
  		ModelsSourceGroup:hide() 
  		ReplaceWTFSourceBtn:hide()
		ReplaceAllWTFSourceBtn:hide()
  		end
  		
	

	ModelsTextureGroup:hide() 
	ModelsSaveAsGroup:hide()
		
		if gModelsToolTipPicked ~="translate" or gNumObjects < 1 then
		ModelsInputGroup:hide() 
		ModelsValueGroup:hide()
		ModelsValInputA:value()
		ModelsValInputB:value()
		ModelsValInputC:value()
		ModelsValInputD:value()
		ModelsValInputA:hide()
		ModelsValInputB:hide()
		ModelsValInputC:hide()
		ModelsValInputD:hide()
		ModelsBoolBtn:hide()
		ModelsNameInput:hide()
		else
		ModelsValueGroup:show()
		end
		
		
		
			
	if gModelsToolTipPicked ~="bones" then	ModelsBonesGroup:hide() end
		
		if gModelsToolTipPicked ~="materials" then  
		ModelsMaterialsGroup:hide() 	
		ModelsMaterialsInputGroup:hide() 
		ModelsValueGroup:hide()
		ModelsMaterialsValInputA:value()
		ModelsMaterialsValInputB:value()
		ModelsMaterialsValInputC:value()
		ModelsMaterialsValInputD:value()
		ModelsMaterialsValInputA:hide()
		ModelsMaterialsValInputB:hide()
		ModelsMaterialsValInputC:hide()
		ModelsMaterialsValInputD:hide()
		ModelsMaterialsBoolBtn:hide()
		ModelsMaterialsNameInput:hide()
		end
		
	
end
-- listWTFFiles
function listWTFFiles()
gModelsBrowserFiles={}
    wtfFileBrowser:clear()
    ModelsSourceGroup:show()
    for file in lfs.dir(gModelsBrowserPath) do
        if string.sub(file, 1,1)~="." or file==".." then
            local f = gModelsBrowserPath..'/'..file
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
             if attr.mode == "file" and string.sub(file, -4,-1)==".wtf" then 
             	local a={file, "file"}
             	table.insert(gModelsBrowserFiles, a)
             	wtfFileBrowser:add(file)
             end   
           if attr.mode == "directory" then 
           local a={file, "directory"}
             table.insert(gModelsBrowserFiles, a)
             wtfFileBrowser:add(file.."     ->")
	   end  
        end
     end
     
end
-- resetObjectTables
function resetObjectTables()

plist= ig3d_GetObjectsList__s()

if string.len(plist) < 2  then return end

--gObjects={}
--gObjectColls={}
--gObjectHUDs={}
--gObjectWTFs={}
--gObjectNames={}
--gObjectPositions={}
--gObjectRotations={}
--gObjectSizes={}

for i = 1,getlinecount(plist.."\n"),1 do

tModelsName = getlineof(plist,i)
touchModel = get(ig3d_object,tModelsName)
tModelsInfo = ig3d_GetObjectInfo_s_s(tModelsName)
tModelSourcePath = ig3d_GetObjectModelPath_s_s(tModelsName)
tcurModelInfo={}
	for ii=1,getlinecount(tModelsInfo),1 do
	table.insert(tcurModelInfo,getlineof(tModelsInfo,ii))
	end
tModelsShortPath = string.sub(tModelSourcePath,string.len(gameroot.."Data/WTF/")+1,-1)

--[[gObjects[i]={}
gObjects[i].cObj = touchModel

table.insert(gObjectNames,tcurModelInfo[1])
table.insert(gObjectPositions,tcurModelInfo[2])
table.insert(gObjectRotations,tcurModelInfo[3])
table.insert(gObjectSizes,tcurModelInfo[4])
table.insert(gObjectWTFs,tModelsShortPath)
tbool = getObjectInfo(touchModel, IG3D_COLL)
table.insert(gObjectColls,tbool)
tbool = getObjectInfo(touchModel, IG3D_HUD)
table.insert(gObjectHUDs,tbool)]]--
end


	--[[for i=1,#gObjectWTFs,1 do
	--gObjects[i]={}
	--gObjects[i].cObj=get(ig3d_object, gObjectNames[i])
	--setObjectInfo(gObjects[i].cObj, IG3D_NAME, gObjectNames[i])
	--setObjectInfo(gObjects[i].cObj, IG3D_POSITION, gObjectPositions[i][1],gObjectPositions[i][2],gObjectPositions[i][3])
	--setObjectInfo(gObjects[i].cObj, IG3D_ROTATION, gObjectRotations[i][1],gObjectRotations[i][2],gObjectRotations[i][3])
	--setObjectInfo(gObjects[i].cObj, IG3D_SIZE, gObjectSizes[i][1],gObjectSizes[i][2],gObjectSizes[i][3])
	--setObjectInfo(gObjects[i].cObj, IG3D_COLL, gObjectColls[i])
	--setObjectInfo(gObjects[i].cObj, IG3D_HUD, gObjectHUDs[i])
	end]]--

end
--  ModelsBrowserValueCatch
function ModelsBrowserValueCatch()
ModelsFieldValues[1]=ModelsListBrowser:value()
ModelsFieldValues[2]=ModelsAttListBrowser:value()
ModelsFieldValues[3]=ModelsAttListBrowser:value()

ModelsFieldValues[4]=wtfFileBrowser:value()
ModelsFieldValues[5]=ModelsBoolBtn:value()
ModelsFieldValues[6]=ModelsValInputA:value()
ModelsFieldValues[7]=ModelsNameInput:value()

ModelsFieldValues[8]=ModelsMaterialsBrowser:value()
ModelsFieldValues[9]=ModelsMaterialsAttributesBrowser:value()
ModelsFieldValues[10]=ModelsFieldValues[9]
ModelsFieldValues[11]=ModelsMaterialsBoolBtn:value()
curValBool = gModelsValueItems[1]
	if curValBool ~= "true" and curValBool ~= "false" then 	
	curValBool = nil
	end	
	
gNewModelsValueItems={}	
for i=1,#gModelsValueItems,1 do
  if i == 1 then
	if curValBool == nil then
 	
 	table.insert(gNewModelsValueItems,ModelsValInputA:value());
 	else
 	table.insert(gNewModelsValueItems,curValBool);
 	end
 	end
 
	if i == 2 then 
	if curValBool == nil then
 	table.insert(gNewModelsValueItems,ModelsValInputB:value());
 	else
 	table.insert(gNewModelsValueItems,ModelsValInputA:value());
 	end
 	end
 
	if i == 3 then 
	if curValBool == nil then
 	table.insert(gNewModelsValueItems,ModelsValInputC:value());
 	else
 	table.insert(gNewModelsValueItems,ModelsValInputB:value());
 	end
 	end
 	
	if i == 4 then 
	if curValBool == nil then
 	table.insert(gNewModelsValueItems,ModelsValInputD:value());
	else
 	table.insert(gNewModelsValueItems,ModelsValInputC:value());
 	end
 	end		
end

gNewModelsMaterialsValueItems={}
if gModelsMaterialsValueItems[1] =="true" or gModelsMaterialsValueItems[1] =="false" then
table.insert(gNewModelsMaterialsValueItems,ModelsFieldValues[11])
else
for i=1,#gModelsMaterialsValueItems,1 do
  if i == 1 then
 	table.insert(gNewModelsMaterialsValueItems,ModelsMaterialsValInputA:value());
 	end
 
	if i == 2 then 
 	table.insert(gNewModelsMaterialsValueItems,ModelsMaterialsValInputB:value());
 	end
 
	if i == 3 then 
 	table.insert(gNewModelsMaterialsValueItems,ModelsMaterialsValInputC:value());
 	end
 	
	if i == 4 then 
 	table.insert(gNewModelsMaterialsValueItems,ModelsMaterialsValInputD:value());
 	end		
end
end

 fltk_update()
end
-- parseHelpForAttributes

function parseHelpForModelsAttributes()
ModelsBrowserValueCatch()
whichCommand = "getObjectInfo"
whichElement = "obj"
q= string.char(34); --quotation mark;
pc = string.char(37); --percent sign;
gFoundAttributes={"name","position","rotation","size","coll","hud"}
        pslist = ""
	for i = 1,#gFoundAttributes,1 do
	pslist = pslist..gFoundAttributes[i].."\n"
	end
	slist=pslist
	shText=tText
	f=io.open(gameroot.."Data/Help/scripting.txt", "r")
	tText=f:read("*a")
	f:close()	
	-- get one underscores 
	firstMatch = whichCommand..pc.."p"..whichElement..pc.."p"..pc.."sIG3D_"..pc.."u+."..pc..")"..pc..":";
 	for s in string.gmatch(tText,firstMatch) do 	
 		shText = string.sub(s,string.len(whichCommand.."("..whichElement..", IG3D_")+1,-1)
 		shText = string.sub(shText,1,string.find(shText,")")-1)

		 if string.find(slist,string.lower(shText)) == nil then
		 slist = slist..shText.."\n"
 		 table.insert(gFoundAttributes,string.lower(shText))
 		 end
 	 end
 	-- get two underscores 	
   	secondMatch = whichCommand..pc.."p"..whichElement..pc.."p"..pc.."sIG3D_"..pc.."u+"..pc.."_"..pc.."u+"..pc..")";
		for s in string.gmatch(tText,secondMatch) do 
 			shText = string.sub(s,string.len(whichCommand.."("..whichElement..", IG3D_")+1,-1)
 			shText = string.sub(shText,1,string.find(shText,")")-1)

	 		if string.find(slist,string.lower(shText)) == nil then
	 		slist = slist..shText.."\n"
 	 		table.insert(gFoundAttributes,string.lower(shText))
 	 		end
		end	
end
-- parseModelsAttributesTable
function parseModelsAttributesTable(whichCommand, whichElement)
		gModelsDetailsInfo={}
		gObjectInfoAttributes={}
		gModelsAttVars={{}}
		whichCommand = "getObjectInfo"
		whichElement = "obj"
		gModelsGetInfoTable={}
		local tally=""
		for i =1,#gFoundAttributes,1 do
		ts = "IG3D_"..string.upper(gFoundAttributes[i])
		table.insert(gObjectInfoAttributes,ts)
		thirdMatch = whichCommand..pc.."p"..whichElement..pc.."p"..pc.."s"..ts..pc..")"..pc..":"..pc.."("..".+";
		tk = string.match(tText,thirdMatch,1)
		if tk ~= nil then 
		tmsub=string.sub(tk,string.len(whichCommand.."("..whichElement..", "..ts.."):(")+1, string.find(tk,"\n")-2)
		
		-- insert model info attributes
		table.insert(gModelsAttVars ,tmsub)
		-- temp strings
		tmsur=tmsub
		its=tmsub
			if string.find(tmsur,",") ~= nil then
			its=""
			mn=0
			for items in string.gmatch(tmsub, pc.."a+") do
			fc=string.find(tmsur,",")
				if fc ==nil then fc =0 end
				its=its..string.sub(tmsur,1,fc-1)..","
				tmsur=string.sub(tmsur,fc+1,-1)
				mn=mn+1
				end
			end
			
			-- insert commands to get info as strings
			tmas=  tmsub.."="..whichCommand.."(gObjects["..gObjNum.."].cObj , "..ts.." )"
			tally =tally.. tmas .. "\n"
			table.insert(gModelsGetInfoTable,tmas)
			-- insert command to insert retrieved info into table  
			tmai = "table.insert(gModelsDetailsInfo,{"..tmsub.."} )"
			table.insert(gModelsGetInfoTable,tmai)	
	end
	end
	--print(tally)
	
end
-- updateModelAttributesTables
function updateModelAttributesTables()
gModelsDetailsInfo={}
executeTable(gModelsGetInfoTable) 	
		
	gSelModelsData={}

	for i=1,#gModelsDetailsInfo,1 do
	sou=""
		for ii=1,#gModelsDetailsInfo[i],1 do
		if gModelsDetailsInfo[i][ii] ~= nil then
		sou=sou..tostring(gModelsDetailsInfo[i][ii])..","
		end
		end
		sout = string.sub(sou,1,-2)	
	table.insert(gSelModelsData, sout)
	end
	
	
	gModelsAttributes={}
	for i=1,#gFoundAttributes,1 do
	table.insert(gModelsAttributes,gFoundAttributes[i])
	end
	
	
end
-- showModelsColorChooser
function showModelsColorChooser()
	colorChooserLabel = gSelectedMaterialAttributes[gSelectedMaterialAttribute]
	choosr,choosg,choosb= (gRed * 255) , (gGreen * 255), (gBlue *255)
	color_ok, choosr, choosg , choosb = fltk.fl_color_chooser(colorChooserLabel,choosr,choosg,choosb)	
	
	if color_ok == 1 then -- color_ok represents the first value (exit status) returned by fl_color_chooser
	Fl:set_color(15,choosr,choosg,choosb) -- change color 15
 	gRed, gGreen, gBlue = (choosr) / 255.0, (choosg) / 255.0, (choosb) / 255.0
 		
	ModelsMaterialsValInputA:value(tonumber(string.sub(gRed,1,4)))
	ModelsMaterialsValInputB:value(tonumber(string.sub(gGreen,1,4)))
	ModelsMaterialsValInputC:value(tonumber(string.sub(gBlue,1,4)))
	
	ModelsBrowserValueCatch()
	local lVal = ""	
	for i=1,#gNewModelsMaterialsValueItems,1 do
	lVal = lVal..gNewModelsMaterialsValueItems[i]..","
	end
	changeModelsMaterialsVal(string.sub(lVal,1,-2));

		
	end
end
-- ModelsBrowserWindowUpdate
function ModelsBrowserWindowUpdate(arg)
 if ModelsBrowser == nil then return end
 ModelsBrowser:make_current()
 ModelsBrowserValueCatch()
  
 local i = 1
 local FBn,EBLn,EAn = nil,nil,nil
 EAn= ModelsFieldValues[2]
ModelsBrowserGroupsHide()
 ---- SourceList 
		if arg == "SourceList" then
	local FBn = wtfFileBrowser:value()
		wtfFileBrowser:clear() 
  			for i=1,#gModelsFilesShortNames,1 do
			wtfFileBrowser:add(gModelsFilesShortNames[i])
			end
		end
---- CurModelsInfo	
		if arg == "CurModelsInfo" then
			if gModelsourcePath ~= nil then  
				local ss,se = string.find(gModelsourcePath,"Data/WTF/")
				if se ~= nil then 
				local curModelsName = string.sub(gModelsourcePath,se+1,-1)
				SourceNameInput:value(curModelsName)
				SourceNameInput:redraw()
				end;	
			end;
			updateModelAttributesTables()
				
			 if #gSelModelsData > 1 then 
			 EAn = ModelsFieldValues[2]
			 EBLn = ModelsFieldValues[1]
				
				ModelsAttListBrowser:clear()
				ModelsValueListBrowser:clear()
				
				
			        local i = 1
				for i = 1,#gModelsAttributes,1 do
				ModelsAttListBrowser:add(gModelsAttributes[i])
				ModelsAttListBrowser:redraw()
				end
				
				for i = 1,#gSelModelsData,1 do
				ModelsValueListBrowser:add(gSelModelsData[i])
				gOldInfo = gSelectedModelsInfo
				end
				
			end
			
	
	
			
				
		end; -- if_curModelsinfo
		
---- updateModelsListBrowser 		
		if arg == "updateModelsListBrowser" then
		if #gObjectNames > 0  then
		 EBLn = ModelsFieldValues[1]
			  ModelsListBrowser:clear()
			  for i=1,#gObjectNames,1 do 
			  ModelsListBrowser:add(gObjectNames[i])	
			 	 if gSelectedModels == gObjectNames[i] then EBLn = i end;
			  end
		gSourceRequest = ""
		else
		
		end	
		end;
		  

	
	if arg == "newModels" then
		ModelsAttListBrowser:value(2)
		ModelsValueListBrowser:value(2)
		ModelsAttListBrowser:select(2)
		ModelsValueListBrowser:select(2)
		ModelsBrowserValueCatch()
	end
	
	if arg == "updateMaterialsBrowser" then
		

	end



---- SELECT LINE OF BROWSER  
				if FBn ~= nil then
				wtfFileBrowser:selected(FBn,FBn)
				wtfFileBrowser:value(FBn)
				wtfFileBrowser:select(FBn)
				wtfFileBrowser:redraw()
				end
		
				if EBLn ~= nil then
				ModelsFieldValues[1] = EBLn
				gSelectedModels = gObjectNames[EBLn] 
				 ModelsListBrowser:select(EBLn,EBLn)
		 		ModelsListBrowser:value(EBLn)
		 		ModelsListBrowser:selected(EBLn)
				end
			if EAn ~= nil then 		 
			ModelsAttListBrowser:select(EAn,EAn)
			ModelsAttListBrowser:value(EAn)
			ModelsAttListBrowser:selected(EAn)
			ModelsValueListBrowser:select(EAn,EAn)
			ModelsValueListBrowser:value(EAn)
			ModelsValueListBrowser:selected(EAn) 
			
			end
fltk_update()
end
-- updateModelsListBrowser
function updateModelsListBrowser()
ModelsBrowserValueCatch()
plist= ig3d_GetObjectsList__s()
if plist ~= nil then 
	--gObjectNames={}
	
	pcount =  getlinecount(plist)
	if pcount == 0 and string.len(plist) ~=0 then 
	pcount = 1 
	plist = plist.."\n"
	end
	
	if pcount ~= 0 then  
		for i=1,pcount,1 do		
		pname = getlineof(plist,i)
			
			if pname ~= nil then  
			objTest = false
			for ii = 1,#gObjectNames,1 do
			if pname == #gObjectNames[ii] then objTest = true end
			end

			--if objTest == false then table.insert(gObjectNames,pname) end
			end;	
		end	
	end
	
	 
	end
	ModelsBrowserWindowUpdate("updateModelsListBrowser")
	
end
-- updateMaterialBrowsers
function updateMaterialBrowsers()
ModelsBrowserValueCatch()
ModelsBrowserGroupsHide()
	updateMaterialsTables()
ModelsMaterialsAttributesBrowser:clear()
ModelsMaterialsValuesBrowser:clear()
ModelsMaterialsBrowser:clear()

if #gSelectedMaterialValues == nil then return end
	for i=1,#gSelectedMaterialValues,1 do
	values= gSelectedMaterialValues[i]
				if tonumber(values) ~= 0 then
				for z in string.gmatch(values,"00") do
				values = string.gsub(values,"000","0")
				end
				end				
	ModelsMaterialsValuesBrowser:add(values)
	end
	if #gSelectedMaterialAttributes == nil then return end

	for i=1,#gSelectedMaterialAttributes,1 do
	ModelsMaterialsAttributesBrowser:add(gSelectedMaterialAttributes[i])
	end	
	
	for i=1,#gselModelsMaterialsList,1 do
	ModelsMaterialsBrowser:add(gselModelsMaterialsList[i]);
	end
	ModelsMaterialsAttributesBrowser:select(ModelsFieldValues[9])
	ModelsMaterialsValuesBrowser:select(ModelsFieldValues[9])
	ModelsMaterialsBrowser:select(ModelsFieldValues[8])
	ModelsMaterialsAttributesBrowser:value(ModelsFieldValues[9])
	ModelsMaterialsValuesBrowser:value(ModelsFieldValues[9])
	ModelsMaterialsBrowser:value(ModelsFieldValues[8])
	ModelsMaterialsAttributesBrowser:selected(ModelsFieldValues[9],ModelsFieldValues[9])
	ModelsMaterialsValuesBrowser:selected(ModelsFieldValues[9],ModelsFieldValues[9])
	ModelsMaterialsBrowser:selected(ModelsFieldValues[8],ModelsFieldValues[8])
	
	
end
-- changeModelsMaterialsVal
function changeModelsMaterialsVal(PValue)
if ModelsBrowser == nil then return end;
ModelsBrowserValueCatch()
changeLine = ModelsFieldValues[9]
setVal=""
gSelectedModelsInfo = CurModelsInfo()
curData = gSelectedMaterialData[changeLine]
currentModelsVal = gSelectedMaterialValues[changeLine]

gSelectedMaterialValues[changeLine] = PValue

gSelectedMaterialValues[changeLine] = PValue
gChangeMaterial = gSelectedMaterialAttributes[changeLine].."="..PValue
MatString = gSelectedMaterialValues[1].."\n"..gSelectedMaterialValues[2].."\n"

for i = 3, #gSelectedMaterialValues,1 do
MatString = MatString..gSelectedMaterialAttributes[i].."="..gSelectedMaterialValues[i].."\n"
end

MaterialsUpdate = string.sub(MatString,1,-2)
ig3d_SetObjectMaterialInfo_sis(gSelectedModels,ModelsFieldValues[8],MaterialsUpdate)

print(MaterialsUpdate)
updateMaterialBrowsers()
				
fltk_update()
end
-- updateMaterialsTables

function updateMaterialsTables()
gSelectedMaterialAttributes={}
gSelectedMaterialValues={}
gSelectedMaterialData={} ; -- raw data
gSelectedMaterial = ModelsFieldValues[8]
gselModelsMaterialsList ={}
	cMatList = ig3d_GetObjectMaterialsList_s_s(gObjName).."\n"
	
	mcount = getlinecount(cMatList)
	if mcount == 0 and string.len(cMatList) ~= 0 then ModelsMaterialsBrowser:add(cMatList) end
	
	for i =1,mcount,1 do
	linem=getlineof(cMatList,i)
	if linem ~= nil then
	table.insert(gselModelsMaterialsList,linem)
	
	end
	end
	
curmatinfo = ig3d_GetObjectMaterialInfo_si_s(gObjName , gSelectedMaterial).."\n"				 

	for i = 1,getlinecount(curmatinfo),1 do
	curMatInfoLine = getlineof(curmatinfo,i)
		
		if curMatInfoLine ~= nil then 
		table.insert(gSelectedMaterialData,curMatInfoLine)
		
		if i == 1 then curMatInfoLine = "name="..curMatInfoLine end
		if i == 2 then curMatInfoLine = "lines="..curMatInfoLine end
		
		fe = string.find(curMatInfoLine,"=")
			if fe ~= nil  then 
				attrb = string.sub(curMatInfoLine,1,fe-1)
				values = string.sub(curMatInfoLine,fe+1,-1)
		
			if attrb ~= nil then table.insert(gSelectedMaterialAttributes,attrb) end
			
			if i == 1 and values == nil then 
			values =  gselModelsMaterialsList[gSelectedMaterial]
			end
			if values ~= nil then table.insert(gSelectedMaterialValues,values) end;
		 	end
		end
	end
end
-- ModelsMaterialsValInput

function ModelsMaterialsValInput(w)

if ModelsBrowser == nil then return end;
ModelsBrowserValueCatch()
local lVal = ""	
for i=1,#gNewModelsMaterialsValueItems,1 do
lVal = lVal..gNewModelsMaterialsValueItems[i]..","
end


changeModelsMaterialsVal(string.sub(lVal,1,-2));
end
-- PickedModelsMaterialsAttribute
function PickedMaterialsAttribute(n)
if ModelsBrowser == nil then return end;
ModelsBrowserValueCatch()
if n == nil then n = ModelsFieldValues[9] end
if n == nil then return end

gSelectedModelsInfo = CurModelsInfo()             
ModelsBrowserGroupsHide()		



if gModelsToolTipPicked =="materials" then 
	ModelsMaterialsGroup:show()
	ModelsMaterialsInputGroup:show() 
	ModelsMaterialsNameInput:hide()
	ModelsMaterialsValInputA:hide()
	
	if n == 1 or ModelsFieldValues[9] == 1 then 
	-- Models NAME
		ModelsMaterialsValInputA:hide()
		ModelsMaterialsValInputB:hide()
		ModelsMaterialsValInputC:hide()
		ModelsMaterialsValInputD:hide()
	ModelsMaterialsInputGroup:show()  
	ModelsMaterialsNameInput:show()
	ModelsMaterialsNameInput:value(gSelectedMaterialValues[1])
	ModelsMaterialsValInputA:hide()
	end



	
if n > 1 then 

	gModelsMaterialsValueItems={}
	curVal = gSelectedMaterialValues[n]
	curValBool=curVal
	curValF=""
	sstr = nil
	-- COMMAS
	if curVal ~= nil then 
	fc=string.find(curVal,",")
		if fc == nil then 
		
		table.insert(gModelsMaterialsValueItems,curVal)
		else
			for i = 1, numberofitems(curVal,","), 1 do
			local va=item(i,curVal,",")
			
			table.insert(gModelsMaterialsValueItems,va)
			end
		end
		
	end	

if #gModelsMaterialsValueItems == 1 then 
		ModelsMaterialsValInputA:hide()
		ModelsMaterialsValInputB:hide()
		ModelsMaterialsValInputC:hide()
		ModelsMaterialsValInputD:hide()
		end
		
	if string.find(colorfulMaterialAtt,gSelectedMaterialAttributes[n]) ~= nil then 
	gRed = gModelsMaterialsValueItems[1]
	gGreen = gModelsMaterialsValueItems[2]
	gBlue = gModelsMaterialsValueItems[3]
	end
	

-- BOOLS
curValBool = tostring(gModelsMaterialsValueItems[1])
	if curValBool == "true" then
	ModelsMaterialsBoolBtn:value(1)
	else
	ModelsMaterialsBoolBtn:value(0)
	end
	
	if curValBool == "true" or curValBool == "false" then 	
	ModelsMaterialsBoolBtn:show()
	ModelsMaterialsBoolBtn:label(gSelectedMaterialAttributes[n])		
	else
	ModelsMaterialsBoolBtn:hide()
	
		
	
	
for i=1,#gModelsMaterialsValueItems,1 do
cModelsValueItem = tonumber(gModelsMaterialsValueItems[i])
  	if i == 1 then
 	ModelsMaterialsValInputA:show()
 	ModelsMaterialsValInputA:value(cModelsValueItem)
 	end
 
	if i == 2 then 
	ModelsMaterialsValInputB:show()
 	ModelsMaterialsValInputB:value(cModelsValueItem)
 	end
 
	if i == 3 then 
	ModelsMaterialsValInputC:show()
 	ModelsMaterialsValInputC:value(cModelsValueItem)
 	end
 	
	if i == 4 then 
	ModelsMaterialsValInputD:show()
 	ModelsMaterialsValInputD:value(cModelsValueItem)
 	end
 	end
 		
end  -- <5
end -- > 1

end



fltk_update()
end

-- end PickedModelsAttribute --
-- changeModelsMaterialsBool
function changeModelsMaterialsBool(w)
if ModelsBrowser == nil then return end;
ModelsBrowserValueCatch()
changeLine = ModelsFieldValues[9]


	if w:value() == 1 then 
		tBool = "true"
	else
		tBool = "false"
	end
gChangeMaterial = gSelectedMaterialAttributes[changeLine].."="..tBool

gSelectedMaterialValues[changeLine] = tBool
MatString = gSelectedMaterialValues[1].."\n"..gSelectedMaterialValues[2].."\n"

for i = 3, #gSelectedMaterialValues,1 do
MatString = MatString..gSelectedMaterialAttributes[i].."="..gSelectedMaterialValues[i].."\n"
end
MaterialsUpdate = string.sub(MatString,1,-2)
ig3d_SetObjectMaterialInfo_sis(gSelectedModels,ModelsFieldValues[8],MaterialsUpdate)




fltk_update()
end
--  CurModelsInfo
function CurModelsInfo(n)
ModelsBrowserValueCatch()
plist= ig3d_GetObjectsList__s()

pcount = getlinecount(plist)
if pcount == 0 and string.len(plist) ~=0 then 
	pcount = 1 
	plist = plist.."\n"
	end
	gNumObjects = pcount
if pcount == 0 then return end
if n == nil then n = ModelsFieldValues[1] end
if n ~= nil then gSelectedModels =  getlineof(plist,n) end
if gSelectedModels == nil then return end;


	gSelectedModelsInfo = ig3d_GetObjectInfo_s_s(gSelectedModels)
	gDropx,gDropy,gDropz = getlineof(gSelectedModelsInfo,2)
	gObjNum = n
	gObjName = gSelectedModels;
	gSelObj = get(ig3d_object,gObjName)
	ig3d_SetSelection_s(gObjName)
	
	gModelsSourcePath = ig3d_GetObjectModelPath_s_s(gObjName)
	
	gModelsShortPath = string.sub(gModelsSourcePath,string.len(gameroot.."Data/WTF/")+1,-1)			
	gselModelsBoneList = ig3d_GetObjectBonesList_s_s(gObjName)
	ModelsBonesBrowser:clear()
	for i =1,getlinecount(gselModelsBoneList),1 do
	if getlineof(gselModelsBoneList,i) ~= nil then
	ModelsBonesBrowser:add(getlineof(gselModelsBoneList,i));
	end
	end
	
	
parseHelpForModelsAttributes()
parseModelsAttributesTable("getObjectInfo","obj")	

gNumHelpedAttributes=#gModelsAttributes

ModelsBrowserWindowUpdate("CurModelsInfo")
--updateMaterialBrowsers()
return gSelectedModelsInfo

end


-- end CurModelsInfo --
-- changeModelsVal
function changeModelsVal(PValue)
if ModelsBrowser == nil then return end;
ModelsBrowserValueCatch()
changeLine = ModelsFieldValues[2]
setVal=""
gSelectedModelsInfo = CurModelsInfo()
curData = gSelModelsData[changeLine]
currentModelsVal = gModelsValues[changeLine]

gSelModelsData[changeLine] = PValue

local tally =""
for i=1,4,1 do
setVal = setVal .. gSelModelsData[i].."\n"
end
ig3d_SetObjectInfo_2s(gObjName,setVal)

for i=1,#gSelModelsData,1 do
if i<#gObjectInfoAttributes and i < #gSelModelsData  then
setObjString ="setObjectInfo(gObjects["..gObjectNum.."].cObj,"..gObjectInfoAttributes[i]..","..gSelModelsData[i]..")"
tally = tally..setObjString.."\n"
end
end

--print(tally)

ModelsBrowserValueCatch()
CurModelsInfo()
				

end
-- ModelsValInput

function ModelsValInput(w)
	if ModelsBrowser == nil then return end;
	ModelsBrowserValueCatch()
	local lVal = ""	
		for i=1,#gNewModelsValueItems,1 do
		lVal = lVal..gNewModelsValueItems[i]..","
		end
	changeModelsVal(string.sub(lVal,1,-2));
end
-- changeModelsBool
function changeModelsBool(w)
if ModelsBrowser == nil then return end;
ModelsBrowserValueCatch()
changeLine = ModelsFieldValues[2]

gSelectedModelsInfo = CurModelsInfo()

	if w:value() == 1 then 
		tBool = "true"
	else
		tBool = "false"
	end

gSelModelsData[changeLine] = tBool

ses= "setObjectInfo(gObjects["..gObjectNum.."].cObj,"..gObjectInfoAttributes[changeLine]..","..gSelModelsData[changeLine]..")"
local code,error = loadstring(ses)
if error == nil then code() end

CurModelsInfo()
fltk_update()
end
-- PickObjectDetails
function PickObjectDetails()
ModelsBrowserValueCatch()
AttributeLine = gModelsAttributes[ModelsFieldValues[2]]


if AttributeLine == "bones" then ModelsBonesGroup:show()
elseif AttributeLine == "materials" then ModelsMaterialsGroup:show()
elseif AttributeLine == "source" then listWTFFiles () 
end

end
-- PickedModelsAttribute
function PickedModelsAttribute(n)
if ModelsBrowser == nil then return end;
ModelsBrowserValueCatch()
if n == nil then n = ModelsFieldValues[2] end
if n == nil then return end

gSelectedModelsInfo = CurModelsInfo()
             
ModelsBrowserGroupsHide()		
ModelsNameInput:value(gModelsValues[1]) 
-- Path to Source
if n == 9999 then 
ModelsBrowserWindowUpdate("SourceList")
gSourceRequest = "Replace"
wtfFileBrowser:label("Replace Models Source")
ModelsSourceGroup:show()
wtfFileBrowser:value(ModelsFieldValues[4])
wtfFileBrowser:select(ModelsFieldValues[4])
ModelsSourceGroup:redraw()
 end
 

if gModelsToolTipPicked =="translate" then 

	ModelsValueGroup:show()
	ModelsInputGroup:show() 
	ModelsNameInput:hide()
	ModelsValInputA:hide()
	
	if n == 1 or ModelsFieldValues[2] == 1 then 
	-- Models NAME
	ModelsInputGroup:show()  
	ModelsNameInput:show()
	ModelsNameInput:value(gSelModelsData[1])
	ModelsValInputA:hide()
	end



	
if n > 1 then 

	gModelsValueItems={}
	curVal = gSelModelsData[n]
	curValBool=curVal
	curValF=""
	sstr = nil
	-- COMMAS
	if curVal ~= nil then 
	fc=string.find(curVal,",")
		if fc == nil then 
		
		table.insert(gModelsValueItems,curVal)
		else
			for i = 1, numberofitems(curVal,","), 1 do
			local va=item(i,curVal,",")
			
			table.insert(gModelsValueItems,va)
			end
		end
		
	end	


if #gModelsValueItems == 1 then 
		ModelsValInputA:hide()
		ModelsValInputB:hide()
		ModelsValInputC:hide()
		ModelsValInputD:hide()
		end
-- BOOLS
curValBool = gModelsValueItems[1]
	if curValBool == "true" or curValBool == "false" then 	
	ModelsBoolBtn:show()
	ModelsBoolBtn:label(gModelsAttributes[n])
		if string.len(curValF) >1  then 
		ModelsValInputA:show()
		ModelsValInputA:value(tonumber(curValF))
		else
		ModelsValInputA:hide()
		end
	else
	if n ~= 1 then 
	ModelsValInputA:value(tonumber(curValBool))
	ModelsValInputA:show()
	end
	ModelsBoolBtn:hide()
	curValBool = nil
	end	
		
	if curValBool == "true" then
	ModelsBoolBtn:value(1)
	else
	ModelsBoolBtn:value(0)
	end
	
for i=1,#gModelsValueItems,1 do
cModelsValueItem = tonumber(gModelsValueItems[i])
  if i == 1 then
	if curValBool == nil then
 	ModelsValInputA:show()
 	ModelsValInputA:value(cModelsValueItem)
 	end
 	end
 
	if i == 2 then 
	if curValBool == nil then
	ModelsValInputB:show()
 	ModelsValInputB:value(cModelsValueItem)
 	else
 	ModelsValInputA:show()
 	ModelsValInputA:value(cModelsValueItem)
 	end
 	end
 
	if i == 3 then 
	if curValBool == nil then
	ModelsValInputC:show()
 	ModelsValInputC:value(cModelsValueItem)
 	else
 	ModelsValInputB:show()
 	ModelsValInputB:value(cModelsValueItem)
 	end
 	end
 	
	if i == 4 then 
	if curValBool == nil then
	ModelsValInputD:show()
 	ModelsValInputD:value(cModelsValueItem)
 	else
 	ModelsValInputC:show()
 	ModelsValInputC:value(cModelsValueItem)
 	end
 	end
 	
		
end  -- <5
end -- > 1
end

fltk_update()
end

-- end PickedModelsAttribute --
-- RenameModels
function RenameModels(w)
nName = tostring(w:value())
changeModelsVal(nName)
updateModelsListBrowser("updateModelsListBrowser")
PickedModelsAttribute(ModelsFieldValues[2])
				
end
-- ModelsAttPicked
function ModelsAttPicked(w)
if ModelsBrowser == nil then return end;
if w:value() == nil then return end
ModelsValueListBrowser:value(w:value())
ModelsValueListBrowser:select(w:value())
ModelsValueListBrowser:selected(w:value(),w:value())
ModelsBrowserValueCatch()
PickedModelsAttribute(ModelsFieldValues[2])
end
-- ModelsMaterialsAttributesBrowserCallback
function ModelsMaterialsAttributesBrowserCallback(w)
local n = w:value()
gSelectedMaterialAttribute = n 


ModelsMaterialsAttributesBrowser:select(n)
ModelsMaterialsAttributesBrowser:value(n)
ModelsMaterialsAttributesBrowser:selected(n,n)

ModelsMaterialsValuesBrowser:select(n)
ModelsMaterialsValuesBrowser:value(n)
ModelsMaterialsValuesBrowser:selected(n,n)


updateMaterialBrowsers()
PickedMaterialsAttribute(n)
if string.find(colorfulMaterialAtt,gSelectedMaterialAttributes[n]) ~= nil then  showModelsColorChooser() end
end
-- ModelsMaterialsBrowserCallback 
function ModelsMaterialsBrowserCallback(w)
gSelectedMaterial=w:value()
updateMaterialBrowsers()
end
-- ModelsBonesBrowserCallback 
function ModelsBonesBrowserCallback(w)
end
-- ModelsValueListCallback
function ModelsValueListCallback(w)
if ModelsBrowser == nil then return end;
if w:value() == nil then return end
ModelsAttListBrowser:value(w:value())
ModelsAttListBrowser:select(w:value())
ModelsAttListBrowser:selected(w:value(),w:value())
ModelsBrowserValueCatch()
PickedModelsAttribute(ModelsFieldValues[2])
end
-- ModelsSourceBrowserControlDoubleClicked
function ModelsSourceBrowserControlDoubleClicked(w)
local theFile=gModelsBrowserFiles[tonumber(w:value())]
	if theFile[2]=="directory" then
		if theFile[1]==".." then 
			gModelsBrowserPath=goDirsUp(gModelsBrowserPath, 1)
		else
			gModelsBrowserPath=gModelsBrowserPath..theFile[1].."/"
			if theFile[1] ~= nil then gLastSourceDirectory=theFile[1] end
		end
		listWTFFiles()
	end
	
end
-- ModelsSourcebrowserControlClicked



function ModelsSourcebrowserControlClicked(w)
if w:value()==0 then return end
	local theFile=gModelsBrowserFiles[tonumber(w:value())]
	if theFile[2]=="file" then
		--updateWTFPreviewBox(theFile[1])
		
		gWTFReplacementFile = gLastSourceDirectory.. "/"..theFile[1]
		
		gDropModel = gWTFReplacementFile
		ReplaceWTFSourceBtn:label(gModelsShortPath.."\nwith\n"..gWTFReplacementFile)
	ReplaceWTFSourceBtn:show()
		ReplaceAllWTFSourceBtn:show()
	end
	local t=time()
	if t-gLastModelsSourceBrowserControlClick < 0.4 and w:value()==gLastModelsSourceSelection then
	ModelsSourceBrowserControlDoubleClicked(w)
		gLastModelsSourceBrowserControlClick=0
	else
		gLastModelsSourceBrowserControlClick=time()
	end
	gLastModelsSourceSelection=w:value()	
end
-- ReplaceWTFSourceBtnClick
function ReplaceWTFSourceBtnClick()

fileName = gameroot..ig3d_GetLevelName__s().."/load script.lua"

	local f=io.open(fileName, "r")
	if f == nil then return end
	local tText=f:read("*a")
	f:close()
	q='"'
	
	s,ig = string.find(tText,"gObjectWTFs")
	se,ig = string.find(tText,"gObjectNames")
	
	refrsrc = string.sub(tText,s,se-1)
	
	loadstring(refrsrc) -- refreshes gObjectWTFs table
	
	gObjectWTFs[gObjectNum] = gWTFReplacementFile
	
	local tableout = "gObjectWTFs={"
	for i=1,#gObjectWTFs,1 do
	tableout = tableout..q..gObjectWTFs[i]..q..","
	end
	
	tableout = string.sub(tableout,1,-2).."}"
	
	tText = string.gsub(tText,refrsrc,tableout)
	
	f=io.open(fileName,"w")
	
	f:write(tText)
	f:close()
	
	loadLevel(ig3d_GetLevelName__s())
end
-- ReplaceAllWTFSourceBtnClick
function ReplaceAllWTFSourceBtnClick()

fileName = gameroot..ig3d_GetLevelName__s().."/load script.lua"

local f=io.open(fileName, "r")
if f == nil then return end
	local tText=f:read("*a")
	for repmatch in string.gmatch(tText,gModelsShortPath) do
	tText = string.gsub(tText,gModelsShortPath,gWTFReplacementFile,1)
	end
	
	f:close()
	f=io.open(fileName,"w")
	
	f:write(tText)
	f:close()
	
	loadLevel(ig3d_GetLevelName__s())
end
-- Models MENU FUNCTIONS
ModelsMenuIndex={}
ModelsMenuText={}
ModelsMenuText.Source={"Make", "Save","Duplicate"}
ModelsMenuText.Control={"Run","Stop","Clear"}

function fillModelsSourceMenu()
if ModelsBrowser == nil then return end;
	for  i=1,#ModelsMenuText.Source,1 do
	menuLine="Models/"..ModelsMenuText.Source[i]
	ModelsMenu:add(menuLine);
	table.insert(ModelsMenuIndex,menuLine)
	end
ModelsMenu:add("");
table.insert(ModelsMenuIndex,"")
ModelsMenu:redraw()
end 

function fillModelsControlMenu()
if ModelsBrowser == nil then return end;
for  i=1,#ModelsMenuText.Control,1 do
	menuLine="Current/"..ModelsMenuText.Control[i]
	ModelsMenu:add(menuLine);
	table.insert(ModelsMenuIndex,menuLine)
	end
ModelsMenu:add("");
table.insert(ModelsMenuIndex,"")
ModelsMenu:add("");
table.insert(ModelsMenuIndex,"")
--All
for  i=1,#ModelsMenuText.Control,1 do
	menuLine="All/"..ModelsMenuText.Control[i]
	ModelsMenu:add(menuLine);
	table.insert(ModelsMenuIndex,menuLine)
	end



ModelsMenu:redraw()
end


function ModelsCurrentPick(tPick)

		if tPick == "Clear" then
	
		render()
		end
		
		if tPick == "Run" then		
		
		render()
		end
		
		if tPick == "Stop" then		
	 
		render()
		end
end


function ModelsBrowsersMenuPick(tPick)
if ModelsBrowser == nil then return end;
CurModelsInfo()	
if tPick == "Save" then 
PickedModelsAttribute(2)
ModelsInputGroup:hide()
ModelsourceGroup:hide()
ModelsValueGroup:hide()
ModelsTextureGroup:hide()
ModelsaveAsGroup:show()
end

if tPick == "Make" then
wtfFileBrowser:label(tPick)
gSourceRequest = tPick
PickedModelsAttribute(1)
ValueListBrowser:clear()
ModelsInputGroup:hide()
ModelsourceGroup:show()
ModelsValueGroup:hide()
ModelsTextureGroup:hide()
ModelsaveAsGroup:hide()
ModelsourceList()
ModelsBrowserWindowUpdate("SourceList") --
end		
if tPick == "Duplicate" then MakeModels() end;

end




function Models_menu_callback(w)
if ModelsBrowser == nil then return end;
tMenu = w:label()
tVal = w:value()
tPick = w:text()
tIndex = ModelsMenuIndex[tVal]
tIndex1 = ModelsMenuIndex[tVal-1]
tIndex2 = ModelsMenuIndex[tVal+1]

	if tIndex ~=nil  then 
	ModelsmenuHead=item(1,tIndex,"/")

 		if ModelsmenuHead == "Models" then ModelsBrowsersMenuPick(tPick) end;
 		if ModelsmenuHead == "Current" then ModelsCurrentPick(tPick) end;
 		if ModelsmenuHead == "All" 	then  ModelsAllMenuPick(tPick) end;
 		
 	 end 
 	 if tIndex1 == "All/Clear" then ModelsAllMenuPick("Clear") end
 	 if tIndex1 == "Current/Clear" then ModelsCurrentPick("Clear") end
  Fl:check();
   io.flush();
end

function Models_MenuBarFill()
if ModelsBrowser == nil then return end;
fillModelsSourceMenu()
fillModelsControlMenu()
end
-- ModelsListBrowserCallback
function ModelsListBrowserCallback(w)
if ModelsBrowser == nil then return end;
n = w:value()
ModelsBrowserValueCatch()
resetObjectTables()
gObjName = gObjectNames[w:value()]

ig3d_SetSelection_s(gObjName)
gSelectedModels = gObjName
CurModelsInfo()	
gObjectNum = w:value()	
camera_faceObj(gObjectNum)
if gModelsToolTipPicked == "translate" then PickedModelsAttribute(ModelsFieldValues[2]) end
if gModelsToolTipPicked == "materials" then updateMaterialsTables() end
render()			
end
-- ModelsToolPick
function ModelsToolPick(gModelsToolTipPicked)
ModelsBrowserValueCatch()
ModelsBrowserGroupsHide()
if gModelsToolTipPicked == "bones" then ModelsBonesGroup:show()
elseif gModelsToolTipPicked == "materials" then ModelsMaterialsGroup:show()
elseif gModelsToolTipPicked == "source" then listWTFFiles () 
elseif gModelsToolTipPicked == "translate" then ModelsValueGroup:show()
elseif gModelsToolTipPicked == "anims" then ig3d_SetMode_i(2)
end


fltk_update()
end
-- modelsToolBtnCallback
function modelsToolBtnCallback(w)
gModelsToolTipPicked = w:tooltip()

ModelsToolPick(gModelsToolTipPicked)

end
-- ModelswtfAddObjectClicked
function ModelswtfAddObjectClicked(w)
	if wtfFileBrowser:value()==0 then return end
	local theFile=gModelsBrowserFiles[tonumber(wtfFileBrowser:value())]
	if theFile[2]=="directory" then return end
	
	local c=#(gameroot.."Data/WTF/")+1
	local newObj={}
	table.insert(gObjects, newObj)
	local n=#gObjects
	gDropObject = string.sub(gModelsBrowserPath..theFile[1],c,-1)
	gObjects[n].cObj=make(ig3d_object, gDropObject)
	table.insert(gObjectPositions,{gDropx,gDropy,gDropz})
	setObjectInfo(gObjects[n].cObj, IG3D_POSITION, gDropx,gDropy,gDropz)
	table.insert(gObjectRotations,{gDroprx,gDropry,gDroprz})
	table.insert(gObjectSizes,{gDropsx,gDropsy,gDropsz})
	table.insert(gObjectColls,false)
	table.insert(gObjectHUDs,false)
	updateModelsListBrowser()
	
end
do ModelsBrowser= fltk:Fl_Double_Window(0,0,0,0,"")
ModelsBrowser:callback(wClose)
ModelsBrowser:resize(97,177,369,390)
ModelsBrowser:color(40)
ModelsBrowser:labelsize(10)
--ModelsBrowser:show()
do mainttoolsgroup= fltk:Fl_Group(0,0,0,0,"")
mainttoolsgroup:resize(0,21,645,30)
do modelstool1= fltk:Fl_Button(0,0,0,0,"")
modelstool1:callback(modelsToolBtnCallback)
modelstool1:resize(3,22,26,26)
modelstool1:labelsize(1)
modelstool1:align(16)
end

do modelstool2= fltk:Fl_Button(0,0,0,0,"")
modelstool2:callback(modelsToolBtnCallback)
modelstool2:resize(31,22,26,26)
modelstool2:labelsize(1)
modelstool2:align(16)
end

do modelstool3= fltk:Fl_Button(0,0,0,0,"")
modelstool3:callback(modelsToolBtnCallback)
modelstool3:resize(58,22,26,26)
modelstool3:labelsize(11)
modelstool3:align(50)
end

do modelstool4= fltk:Fl_Button(0,0,0,0,"")
modelstool4:callback(modelsToolBtnCallback)
modelstool4:resize(86,22,26,26)
modelstool4:labelsize(2)
modelstool4:align(16)
end

do modelstool5= fltk:Fl_Button(0,0,0,0,"")
modelstool5:callback(modelsToolBtnCallback)
modelstool5:resize(114,22,26,26)
modelstool5:labelsize(2)
modelstool5:align(16)
end

do modelstool6= fltk:Fl_Button(0,0,0,0,"")
modelstool6:callback(modelsToolBtnCallback)
modelstool6:resize(142,22,26,26)
modelstool6:labelsize(1)
modelstool6:align(16)
end

do modelstool7= fltk:Fl_Button(0,0,0,0,"")
modelstool7:callback(modelsToolBtnCallback)
modelstool7:resize(170,22,26,26)
modelstool7:labelsize(1)
modelstool7:align(16)
end
Fl_Group:current(Fl_Group:current():parent())
end

do ModelsMenu= fltk:Fl_Menu_Bar(0,0,0,0,"")
menudir0=""
ModelsMenu:callback(Models_menu_callback)
ModelsMenu:resize(-2,0,371,22)
ModelsMenu:color(38)
ModelsMenu:labelsize(10)
ModelsMenu:textsize(10)
Fl_Group:current(Fl_Group:current():parent())
end

do ModelsSaveAsGroup= fltk:Fl_Group(0,0,0,0,"")
ModelsSaveAsGroup:resize(370,370,217,50)
do SourceNameInput= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Models Source File ")
SourceNameInput:label(gLabelTable[#gLabelTable])
SourceNameInput:callback(ModelsSaveButtonClick)
SourceNameInput:resize(370,370,217,25)
SourceNameInput:color(50)
SourceNameInput:labelsize(10)
SourceNameInput:align(1)
SourceNameInput:when(8)
SourceNameInput:textsize(10)
end

do PSaveControl= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Save")
PSaveControl:label(gLabelTable[#gLabelTable])
PSaveControl:callback(ModelsSaveButtonClick)
PSaveControl:resize(537,400,50,20)
PSaveControl:labelsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do ModelsTextureGroup= fltk:Fl_Group(0,0,0,0,"")
ModelsTextureGroup:resize(370,67,217,303)
ModelsTextureGroup:box(fltk.FL_THIN_DOWN_BOX)
do pngPreviewGroup= fltk:Fl_Group(0,0,0,0,"")
pngPreviewGroup:resize(416,204,128,129)
pngPreviewGroup:align(16)
pngPreviewGroup:when(6)
do pngPreviewBox= fltk:Fl_Box(0,0,0,0,"")
pngPreviewBox:callback(pngLoad)
pngPreviewBox:resize(416,204,128,128)
pngPreviewBox:box(fltk.FL_FLAT_BOX)
pngPreviewBox:color(40)
pngPreviewBox:align(16)
end
Fl_Group:current(Fl_Group:current():parent())
end

do pngFileBrowser= fltk:Fl_Browser(0,0,0,0,"")
pngFileBrowser:callback(browserControlClicked)
pngFileBrowser:resize(370,67,217,132)
pngFileBrowser:type(2)
pngFileBrowser:color(48)
pngFileBrowser:labelsize(10)
pngFileBrowser:align(1)
pngFileBrowser:when(3)
pngFileBrowser:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do ModelsValueGroup= fltk:Fl_Group(0,0,0,0,"")
ModelsValueGroup:resize(75,47,284,289)
do ModelsValueListBrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Values:")
ModelsValueListBrowser:label(gLabelTable[#gLabelTable])
ModelsValueListBrowser:callback(ModelsValueListCallback)
ModelsValueListBrowser:resize(137,61,222,272)
ModelsValueListBrowser:type(3)
ModelsValueListBrowser:color(50)
ModelsValueListBrowser:labelsize(10)
ModelsValueListBrowser:align(1)
ModelsValueListBrowser:when(4)
ModelsValueListBrowser:textsize(10)
end

do ModelsAttListBrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Attributes:")
ModelsAttListBrowser:label(gLabelTable[#gLabelTable])
ModelsAttListBrowser:callback(ModelsAttPicked)
ModelsAttListBrowser:resize(75,62,64,272)
ModelsAttListBrowser:type(1)
ModelsAttListBrowser:color(48)
ModelsAttListBrowser:labelsize(10)
ModelsAttListBrowser:align(1)
ModelsAttListBrowser:when(4)
ModelsAttListBrowser:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do ModelsInputGroup= fltk:Fl_Group(0,0,0,0,"")
ModelsInputGroup:resize(3,333,355,44)
ModelsInputGroup:box(fltk.FL_EMBOSSED_BOX)
ModelsInputGroup:color(50)
do ModelsNameInput= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Name:")
ModelsNameInput:label(gLabelTable[#gLabelTable])
ModelsNameInput:callback(RenameModels)
ModelsNameInput:resize(148,339,205,22)
ModelsNameInput:color(50)
ModelsNameInput:labelsize(10)
ModelsNameInput:textsize(10)
end

do ModelsBoolBtn= fltk:Fl_Check_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "button")
ModelsBoolBtn:label(gLabelTable[#gLabelTable])
ModelsBoolBtn:callback(changeModelsBool)
ModelsBoolBtn:resize(123,339,19,23)
ModelsBoolBtn:down_box(fltk.FL_DOWN_BOX)
ModelsBoolBtn:align(4)
ModelsBoolBtn:when(1)
end

do ModelsValInputA= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "x")
ModelsValInputA:label(gLabelTable[#gLabelTable])
ModelsValInputA:callback(ModelsValInput)
ModelsValInputA:resize(148,339,46,22)
ModelsValInputA:color(51)
ModelsValInputA:labelsize(12)
ModelsValInputA:align(2)
ModelsValInputA:minimum(-10000)
ModelsValInputA:maximum(10000)
ModelsValInputA:step(0.2)
ModelsValInputA:textsize(10)
end

do ModelsValInputB= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "y")
ModelsValInputB:label(gLabelTable[#gLabelTable])
ModelsValInputB:callback(ModelsValInput)
ModelsValInputB:resize(201,339,46,22)
ModelsValInputB:color(51)
ModelsValInputB:labelsize(12)
ModelsValInputB:align(2)
ModelsValInputB:minimum(-10000)
ModelsValInputB:maximum(10000)
ModelsValInputB:step(0.2)
ModelsValInputB:textsize(10)
end

do ModelsValInputC= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "z")
ModelsValInputC:label(gLabelTable[#gLabelTable])
ModelsValInputC:callback(ModelsValInput)
ModelsValInputC:resize(254,339,46,22)
ModelsValInputC:color(51)
ModelsValInputC:labelsize(12)
ModelsValInputC:align(2)
ModelsValInputC:minimum(-10000)
ModelsValInputC:maximum(10000)
ModelsValInputC:step(0.2)
ModelsValInputC:textsize(10)
end

do ModelsValInputD= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "a")
ModelsValInputD:label(gLabelTable[#gLabelTable])
ModelsValInputD:callback(ModelsValInput)
ModelsValInputD:resize(308,339,46,22)
ModelsValInputD:color(51)
ModelsValInputD:labelsize(12)
ModelsValInputD:align(2)
ModelsValInputD:minimum(-10000)
ModelsValInputD:maximum(10000)
ModelsValInputD:step(0.2)
ModelsValInputD:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do ModelsRootGroup= fltk:Fl_Group(0,0,0,0,"")
ModelsRootGroup:callback(runButton)
ModelsRootGroup:resize(3,61,148,272)
do ModelsListBrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Models")
ModelsListBrowser:label(gLabelTable[#gLabelTable])
ModelsListBrowser:callback(ModelsListBrowserCallback)
ModelsListBrowser:resize(3,61,74,272)
ModelsListBrowser:type(2)
ModelsListBrowser:color(48)
ModelsListBrowser:labelsize(10)
ModelsListBrowser:align(1)
ModelsListBrowser:when(4)
ModelsListBrowser:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do ModelsBonesGroup= fltk:Fl_Group(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Bones")
ModelsBonesGroup:label(gLabelTable[#gLabelTable])
ModelsBonesGroup:resize(74,61,286,272)
ModelsBonesGroup:labelsize(10)
do ModelsBonesBrowser= fltk:Fl_Browser(0,0,0,0,"")
ModelsBonesBrowser:callback(ModelsBonesBrowserCallback)
ModelsBonesBrowser:resize(74,61,285,272)
ModelsBonesBrowser:type(3)
ModelsBonesBrowser:color(50)
ModelsBonesBrowser:labelsize(10)
ModelsBonesBrowser:when(4)
ModelsBonesBrowser:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do ModelsMaterialsGroup= fltk:Fl_Group(0,0,0,0,"")
ModelsMaterialsGroup:resize(8,51,355,331)
ModelsMaterialsGroup:labelsize(10)
ModelsMaterialsGroup:align(0)
do ModelsMaterialsBrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Materials")
ModelsMaterialsBrowser:label(gLabelTable[#gLabelTable])
ModelsMaterialsBrowser:callback(ModelsMaterialsBrowserCallback)
ModelsMaterialsBrowser:resize(74,61,56,272)
ModelsMaterialsBrowser:type(3)
ModelsMaterialsBrowser:color(50)
ModelsMaterialsBrowser:labelsize(10)
ModelsMaterialsBrowser:align(1)
ModelsMaterialsBrowser:when(4)
ModelsMaterialsBrowser:textsize(10)
end

do ModelsMaterialsAttributesBrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Attributes:")
ModelsMaterialsAttributesBrowser:label(gLabelTable[#gLabelTable])
ModelsMaterialsAttributesBrowser:callback(ModelsMaterialsAttributesBrowserCallback)
ModelsMaterialsAttributesBrowser:resize(128,61,56,272)
ModelsMaterialsAttributesBrowser:type(3)
ModelsMaterialsAttributesBrowser:color(50)
ModelsMaterialsAttributesBrowser:labelsize(10)
ModelsMaterialsAttributesBrowser:align(1)
ModelsMaterialsAttributesBrowser:when(4)
ModelsMaterialsAttributesBrowser:textsize(10)
end

do ModelsMaterialsValuesBrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Values:")
ModelsMaterialsValuesBrowser:label(gLabelTable[#gLabelTable])
ModelsMaterialsValuesBrowser:callback(ModelsMaterialsAttributesBrowserCallback)
ModelsMaterialsValuesBrowser:resize(182,61,177,272)
ModelsMaterialsValuesBrowser:type(3)
ModelsMaterialsValuesBrowser:color(50)
ModelsMaterialsValuesBrowser:labelsize(10)
ModelsMaterialsValuesBrowser:align(1)
ModelsMaterialsValuesBrowser:when(4)
ModelsMaterialsValuesBrowser:textsize(10)
end

do ModelsMaterialsInputGroup= fltk:Fl_Group(0,0,0,0,"")
ModelsMaterialsInputGroup:resize(8,338,355,44)
ModelsMaterialsInputGroup:box(fltk.FL_EMBOSSED_BOX)
ModelsMaterialsInputGroup:color(50)
do ModelsMaterialsNameInput= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Name:")
ModelsMaterialsNameInput:label(gLabelTable[#gLabelTable])
ModelsMaterialsNameInput:callback(RenameModelsMaterials)
ModelsMaterialsNameInput:resize(153,344,205,22)
ModelsMaterialsNameInput:color(50)
ModelsMaterialsNameInput:labelsize(10)
ModelsMaterialsNameInput:textsize(10)
end

do ModelsMaterialsBoolBtn= fltk:Fl_Check_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "button")
ModelsMaterialsBoolBtn:label(gLabelTable[#gLabelTable])
ModelsMaterialsBoolBtn:callback(changeModelsMaterialsBool)
ModelsMaterialsBoolBtn:resize(128,344,19,23)
ModelsMaterialsBoolBtn:down_box(fltk.FL_DOWN_BOX)
ModelsMaterialsBoolBtn:align(4)
ModelsMaterialsBoolBtn:when(1)
end

do ModelsMaterialsValInputA= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "x")
ModelsMaterialsValInputA:label(gLabelTable[#gLabelTable])
ModelsMaterialsValInputA:callback(ModelsMaterialsValInput)
ModelsMaterialsValInputA:resize(153,344,46,22)
ModelsMaterialsValInputA:color(51)
ModelsMaterialsValInputA:labelsize(12)
ModelsMaterialsValInputA:align(2)
ModelsMaterialsValInputA:minimum(0.001)
ModelsMaterialsValInputA:step(0.01)
ModelsMaterialsValInputA:textsize(10)
end

do ModelsMaterialsValInputB= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "y")
ModelsMaterialsValInputB:label(gLabelTable[#gLabelTable])
ModelsMaterialsValInputB:callback(ModelsMaterialsValInput)
ModelsMaterialsValInputB:resize(206,344,46,22)
ModelsMaterialsValInputB:color(51)
ModelsMaterialsValInputB:labelsize(12)
ModelsMaterialsValInputB:align(2)
ModelsMaterialsValInputB:minimum(0.001)
ModelsMaterialsValInputB:step(0.01)
ModelsMaterialsValInputB:textsize(10)
end

do ModelsMaterialsValInputC= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "z")
ModelsMaterialsValInputC:label(gLabelTable[#gLabelTable])
ModelsMaterialsValInputC:callback(ModelsMaterialsValInput)
ModelsMaterialsValInputC:resize(259,344,46,22)
ModelsMaterialsValInputC:color(51)
ModelsMaterialsValInputC:labelsize(12)
ModelsMaterialsValInputC:align(2)
ModelsMaterialsValInputC:minimum(0.001)
ModelsMaterialsValInputC:step(0.01)
ModelsMaterialsValInputC:textsize(10)
end

do ModelsMaterialsValInputD= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "a")
ModelsMaterialsValInputD:label(gLabelTable[#gLabelTable])
ModelsMaterialsValInputD:callback(ModelsMaterialsValInput)
ModelsMaterialsValInputD:resize(313,344,46,22)
ModelsMaterialsValInputD:color(51)
ModelsMaterialsValInputD:labelsize(12)
ModelsMaterialsValInputD:align(2)
ModelsMaterialsValInputD:minimum(0.001)
ModelsMaterialsValInputD:step(0.01)
ModelsMaterialsValInputD:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end
Fl_Group:current(Fl_Group:current():parent())
end

do ModelsSourceGroup= fltk:Fl_Group(0,0,0,0,"")
ModelsSourceGroup:resize(-1,49,361,366)
ModelsSourceGroup:labelsize(10)
ModelsSourceGroup:align(0)
do ReplaceSourceGroup= fltk:Fl_Group(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Replace")
ReplaceSourceGroup:label(gLabelTable[#gLabelTable])
ReplaceSourceGroup:resize(3,333,355,49)
ReplaceSourceGroup:box(fltk.FL_EMBOSSED_BOX)
ReplaceSourceGroup:color(50)
ReplaceSourceGroup:labelsize(10)
ReplaceSourceGroup:align(21)
do ReplaceWTFSourceBtn= fltk:Fl_Button(0,0,0,0,"")
ReplaceWTFSourceBtn:callback(ReplaceWTFSourceBtnClick)
ReplaceWTFSourceBtn:resize(48,336,140,44)
ReplaceWTFSourceBtn:labelsize(10)
end

do ReplaceAllWTFSourceBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Replace All")
ReplaceAllWTFSourceBtn:label(gLabelTable[#gLabelTable])
ReplaceAllWTFSourceBtn:callback(ReplaceAllWTFSourceBtnClick)
ReplaceAllWTFSourceBtn:resize(195,336,140,44)
ReplaceAllWTFSourceBtn:labelsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do wtfFileBrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Model Source")
wtfFileBrowser:label(gLabelTable[#gLabelTable])
wtfFileBrowser:callback(ModelsSourcebrowserControlClicked)
wtfFileBrowser:resize(180,63,180,272)
wtfFileBrowser:type(2)
wtfFileBrowser:labelsize(10)
wtfFileBrowser:align(1)
wtfFileBrowser:when(3)
wtfFileBrowser:textsize(10)
end

do MakeModelsWTFBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "make")
MakeModelsWTFBtn:label(gLabelTable[#gLabelTable])
MakeModelsWTFBtn:callback(ModelswtfAddObjectClicked)
MakeModelsWTFBtn:tooltip("make model")
MakeModelsWTFBtn:resize(80,69,95,22)
MakeModelsWTFBtn:labelsize(10)
end

do MakeModelsWTFBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "replace")
MakeModelsWTFBtn:label(gLabelTable[#gLabelTable])
MakeModelsWTFBtn:callback(ReplaceWTFSourceBtnClick)
MakeModelsWTFBtn:tooltip("make model")
MakeModelsWTFBtn:resize(80,100,95,22)
MakeModelsWTFBtn:labelsize(10)
end

do MakeModelsWTFBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "replace similiar")
MakeModelsWTFBtn:label(gLabelTable[#gLabelTable])
MakeModelsWTFBtn:callback(ReplaceAllWTFSourceBtnClick)
MakeModelsWTFBtn:tooltip("make model")
MakeModelsWTFBtn:resize(80,132,95,22)
MakeModelsWTFBtn:labelsize(10)
end

do MakeModelsWTFBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "replace all")
MakeModelsWTFBtn:label(gLabelTable[#gLabelTable])
MakeModelsWTFBtn:callback(ReplaceAllWTFSourceBtnClick)
MakeModelsWTFBtn:tooltip("make model")
MakeModelsWTFBtn:resize(80,164,95,22)
MakeModelsWTFBtn:labelsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end
end
ModelsBrowser:show()

ModelsBrowser:label("")
ModelsBrowser:show()
ModelsBrowser:make_current()
resetObjectTables()
updateModelsListBrowser()
Models_MenuBarFill()
listWTFFiles()
ModelsBrowserGroupsHide()
---- BUTTON ICONS 
fltk.fl_register_images()
local iconPath=gameroot.."Data/Icons/ModelsBrowser/Models_"
gModelsBrowserButtons={"source","translate","camera","materials","bones","anims","views"}
gModelsBrowserIcons ={}
for i = 1, #gModelsBrowserButtons,1 do
table.insert(gModelsBrowserIcons,Fl_Shared_Image.get(iconPath..gModelsBrowserButtons[i]..".png"))
end

mtl1 = Fl_Shared_Image.get(iconPath.."source.png")
mtl2 = Fl_Shared_Image.get(iconPath.."translate.png")
mtl3 = Fl_Shared_Image.get(iconPath.."camera.png")
mtl4 = Fl_Shared_Image.get(iconPath.."materials.png")
mtl5 = Fl_Shared_Image.get(iconPath.."bones.png")
mtl6 = Fl_Shared_Image.get(iconPath.."anims.png")
mtl7 = Fl_Shared_Image.get(iconPath.."anims.png")

modelstool1:image(gModelsBrowserIcons[1])
modelstool2:image(gModelsBrowserIcons[2])
modelstool3:image(gModelsBrowserIcons[3])
modelstool4:image(gModelsBrowserIcons[4])
modelstool5:image(gModelsBrowserIcons[5])
modelstool6:image(gModelsBrowserIcons[6])


modelstool1:image(gModelsBrowserIcons[1],22,22)
modelstool2:image(gModelsBrowserIcons[2],22,22)
modelstool3:image(gModelsBrowserIcons[3],22,22)
modelstool4:image(gModelsBrowserIcons[4],22,22)
modelstool5:image(gModelsBrowserIcons[5],22,22)
modelstool6:image(gModelsBrowserIcons[6],22,22)

modelstool1:tooltip(gModelsBrowserButtons[1])
modelstool2:tooltip(gModelsBrowserButtons[2])
modelstool3:tooltip(gModelsBrowserButtons[3])
modelstool4:tooltip(gModelsBrowserButtons[4])
modelstool5:tooltip(gModelsBrowserButtons[5])
modelstool6:tooltip(gModelsBrowserButtons[6])


modelstool1:redraw()
modelstool2:redraw()
modelstool3:redraw()
modelstool4:redraw()
modelstool5:redraw()
modelstool6:redraw()


modelstool1:when(11)
modelstool2:when(11)
modelstool3:when(11)
modelstool4:when(11)
modelstool5:when(11)
modelstool6:when(11)
--end
Fl:run()
