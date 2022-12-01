--function make_window()
-- PNG BROWSER
guPNGBrowserPath=gameroot.."Data/Images/"
guPNGBrowserFiles={}
guPNGLastSelection = ""
function ulistPNGFiles()
guPNGBrowserFiles={}
    upngFileBrowser:clear()
    for file in lfs.dir(guPNGBrowserPath) do
        if string.sub(file, 1,1)~="." or file==".." then
            local f = guPNGBrowserPath..'/'..file
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
             if attr.mode == "file" and string.sub(file, -4,-1)==".png" then 
             	local a={file, "file"}
             	table.insert(guPNGBrowserFiles, a)
             	upngFileBrowser:add(file)
             end   
           if attr.mode == "directory" then 
           local a={file, "directory"}
             table.insert(guPNGBrowserFiles, a)
             upngFileBrowser:add(file.."     ->")
	   end  
        end
     end
     
end
function updateuPNGPreviewBox(name)
uBrowserNew:make_current()
	fltk.fl_register_images()
	local a=guPNGBrowserPath 
	local b=string.sub(name, 1,-5)..".png"
	local img = Fl_Shared_Image.get(a..b)
	upngPreviewBox:color(40)
	if img==nil then
		img=Fl_Shared_Image.get(gameroot.."Data/Images/Colors/white.png")
	end
	upngPreviewBox:image(img,128,128)
	upngPreviewBox:redraw()
end
function upngLoad(w)
	uBrowserNew:make_current()
	if upngFileBrowser:value()==0 then return end
	local theFile=guPNGBrowserFiles[tonumber(upngFileBrowser:value())]
	if theFile[2]=="directory" then return end
	
	local c=#(gameroot)+1
	local newObj={}
	table.insert(gObjects, newObj)
	local n=#gObjects
	loadTexture( string.sub(guPNGBrowserPath..theFile[1],c,-1))
	gCatchTexturePath = string.sub(guPNGBrowserPath..theFile[1],c,-1)
	
end
function uPNGbrowserControlDoubleClicked(w)
	--
	local theFile=guPNGBrowserFiles[tonumber(w:value())]
	if theFile[2]=="directory" then
		if theFile[1]==".." then 
			guPNGBrowserPath=goDirsUp(guPNGBrowserPath, 1)
		else
			guPNGBrowserPath=guPNGBrowserPath..theFile[1].."/"
		end
		ulistPNGFiles()
	end
end
function uPNGbrowserControlClicked(w)
	if w:value()==0 then return end
	local theFile=guPNGBrowserFiles[tonumber(w:value())]
	if theFile[2]=="file" then
		updateuPNGPreviewBox(theFile[1])
	end
	
	local t=time()
	
	if t-gLastBrowserControlClick < 0.4 and w:value()==guPNGLastSelection then
		uPNGbrowserControlDoubleClicked(w)
		gLastBrowserControlClick=0
	else
		gLastBrowserControlClick=time()
	end
	guPNGLastSelection=w:value()
	
end
-- WTF BROWSER CODE AHEAD 1015
gLastBrowserControlClick=time()
gLastSelection=-1
gDropObject = gameroot.."Data/WTF/Cubes/cube.wtf"
guWTFBrowserPath=gameroot.."Data/WTF/"
guWTFBrowserFiles={}
-- (left, top, right, bottom) 
gGLX,gGLY,gGLR,gGLB = ig3d_GetWindowBounds__4i()

function ulistWTFFiles()
guWTFBrowserFiles={}
    uwtfFileBrowser:clear()
    for file in lfs.dir(guWTFBrowserPath) do
        if string.sub(file, 1,1)~="." or file==".." then
            local f = guWTFBrowserPath..'/'..file
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
             if attr.mode == "file" and string.sub(file, -4,-1)==".wtf" then 
             	local a={file, "file"}
             	table.insert(guWTFBrowserFiles, a)
             	uwtfFileBrowser:add(file)
             end   
           if attr.mode == "directory" then 
           local a={file, "directory"}
             table.insert(guWTFBrowserFiles, a)
             uwtfFileBrowser:add(file.."     ->")
	   end  
        end
     end
     
end

function updateuWTFPreviewBox(name)
	fltk.fl_register_images()
	local a=string.gsub(guWTFBrowserPath, "/WTF/", "/WTFPreviews/")
	print("a= "..a)
	local b=string.sub(name, 1,-5).."_wtf.png"
	local img = Fl_Shared_Image.get(a..b)
	uwtfPreviewBox:color(40)
	if img==nil then
		img=Fl_Shared_Image.get(gameroot.."Data/Images/Colors/white.png")
		uwtfPreviewNote:label("No preview available")
	else
		uwtfPreviewNote:label("")
	end
	
	WPW=uwtfPreviewBox:w()
	WPH=uwtfPreviewBox:h()
	uwtfPreviewBox:image(img,WPW-8,WPH-8)
	--wtfPreviewBox:resize(90,3,WPW-8,WPH-8)
	uwtfPreviewBox:redraw()
end

function uwtfAddObjectClicked(w)
	if uwtfFileBrowser:value()==0 then return end
	local theFile=guWTFBrowserFiles[tonumber(uwtfFileBrowser:value())]
	if theFile[2]=="directory" then return end
	
	local c=#(gameroot.."Data/WTF/")+1
	local newObj={}
	table.insert(gObjects, newObj)
	local n=#gObjects
	gDropObject = string.sub(guWTFBrowserPath..theFile[1],c,-1)
	gObjects[n].cObj=make(ig3d_object, gDropObject)
	
end

function uwtfPreviewLoadMesh(w)
	if uwtfFileBrowser:value()==0 then return end
	local theFile=guWTFBrowserFiles[tonumber(uwtfFileBrowser:value())]
	if theFile[2]=="directory" then return end
	
	local c=#(gameroot)+1
	local newObj={}
	table.insert(gObjects, newObj)
	local n=#gObjects
	loadMesh( string.sub(guWTFBrowserPath..theFile[1],c,-1))
end

function ucreatePreviewsClicked(w)
	if uwtfFileBrowser:value()==0 then return end
	local theFile=guWTFBrowserFiles[tonumber(uwtfFileBrowser:value())]
	local a=string.gsub(guWTFBrowserPath, "/WTF/", "/WTFPreviews/")
	print("a= "..a)
	local b=string.sub(theFile[1], 1,-5).."_wtf.png"
	local c=#gameroot+1
	
	
	if theFile[2]=="file" then
		ig3d_CreateDirectory_s(goDirsUp(a..b,0))
		createWTFPreviewPNG(string.sub(guWTFBrowserPath..theFile[1], c,-1), a..b)
		updateuWTFPreviewBox(theFile[1])
	end
	
	if theFile[2]=="directory" then
		ig3d_CreateDirectory_s(a..theFile[1])
		batchPreviewsForFolder(string.sub(guWTFBrowserPath..theFile[1].."/", c,-1), string.sub(a..theFile[1].."/", c,-1))
	end
	ig3d_SetWindowBounds_4i(gGLX,gGLY,gGLR,gGLB)
end


function uWTFbrowserControlDoubleClicked(w)
	--
	local theFile=guWTFBrowserFiles[tonumber(w:value())]
	if theFile[2]=="directory" then
		if theFile[1]==".." then 
			guWTFBrowserPath=goDirsUp(guWTFBrowserPath, 1)
			if string.find(guWTFBrowserPath,"/WTF/") == nil then
			guWTFBrowserPath=gameroot.."Data/WTF/"
			end
		else
			guWTFBrowserPath=guWTFBrowserPath..theFile[1].."/"
		end
		ulistWTFFiles()
	end
	
end

function uWTFbrowserControlClicked(w)
	if w:value()==0 then return end
	local theFile=guWTFBrowserFiles[tonumber(w:value())]
	if theFile[2]=="file" then
		updateuWTFPreviewBox(theFile[1])
	end
	
	local t=time()
	
	if t-gLastBrowserControlClick < 0.4 and w:value()==guLastSelection then
		uWTFbrowserControlDoubleClicked(w)
		gLastBrowserControlClick=0
	else
		gLastBrowserControlClick=time()
	end
	guLastSelection=w:value()
	
end
-- Levels BROWSER CODE AHEAD 1015
gLastBrowserControlClick=time()
gLastSelection=-1

guLevelsBrowserPath=gameroot.."Data/Levels/"
guLevelsBrowserFiles={}
-- (left, top, right, bottom) 
gGLX,gGLY,gGLR,gGLB = ig3d_GetWindowBounds__4i()

function ulistLevelsFiles()
guLevelsBrowserFiles={}
    uLevelsFileBrowser:clear()
    for file in lfs.dir(guLevelsBrowserPath) do
        if string.sub(file, 1,1)~="." or file==".." then
            local f = guLevelsBrowserPath..'/'..file
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
             if attr.mode == "file" and string.sub(file, -15,-1)=="load script.lua" then 
             	local a={file, "file"}
             	table.insert(guLevelsBrowserFiles, a)
             	uLevelsFileBrowser:add(file)
             end   
             
             if attr.mode == "file" and string.sub(file, -8,-1)=="mesh.wtf" then 
             	local a={file, "file"}
             	table.insert(guLevelsBrowserFiles, a)
             	uLevelsFileBrowser:add(file)
             end   
             
           if attr.mode == "directory" then 
           local a={file, "directory"}
             table.insert(guLevelsBrowserFiles, a)
             uLevelsFileBrowser:add(file.."     ->")
	   end  
        end
     end
     
end








function uLevelsBrowserControlDoubleClicked(w)
	--
	local theFile=guLevelsBrowserFiles[tonumber(w:value())]
	if theFile[2]=="directory" then
		if theFile[1]==".." then 
			guLevelsBrowserPath=goDirsUp(guLevelsBrowserPath, 1)
		if string.find(guLevelsBrowserPath,"Levels") == nil then guLevelsBrowserPath=gameroot.."Data/Levels/" end
			
		else
			guLevelsBrowserPath=guLevelsBrowserPath..theFile[1].."/"
		end
		ulistLevelsFiles()
	end
	
end

function uLevelsBrowserControlClicked(w)
uLoadLevelBtn:hide()
uLoadLevelMeshBtn:hide()
local s = string.len(gameroot)
	if w:value()==0 then return end
	gSelectedLevelMesh=""
	gSelectedLevelScript=""
	gSelectedLevelName=""
	local theFile= guLevelsBrowserFiles[tonumber(w:value())]
	if theFile[2]=="file" then
	print(theFile[1])
		   if theFile[1] == "load script.lua" then
			gSelectedLevelScript = guLevelsBrowserPath..theFile[1]
			uLoadLevelBtn:show()
			gSelectedLevelName = string.sub(guLevelsBrowserPath,s,-1)
					
					uLoadLevelBtn:show()
		    end
		local LC = string.find(tostring(theFile[1]),"level_mesh.wtf")
		if LC ~= nil then
			gSelectedLevelMesh=guLevelsBrowserPath..theFile[1] 
			uLoadLevelMeshBtn:show()
			gSelectedLevelName = string.sub(guLevelsBrowserPath,s,-1)
		end
		
	end
		if theFile[2]=="directory" then
		-- seek one level deeper for like loadscript and level_mesh
				for file in lfs.dir(guLevelsBrowserPath..theFile[1].."/") do
					if string.find(file,"load script.lua") ~= nil then
					gSelectedLevelName = "Data/Levels/"..theFile[1]
					gSelectedLevelScript = gSelectedLevelName.."/"..file
					uLoadLevelBtn:show()
             				end
             				
             				if string.find(file,"level_mesh.wtf") ~= nil then
             				gSelectedLevelName = "Data/Levels/"..theFile[1]
             				gSelectedLevelMesh = gSelectedLevelName.."/"..file
             				uLoadLevelMeshBtn:show()
             				end
             			end
        	end
	local t=time()
	
	if t-gLastBrowserControlClick < 0.4 and w:value()==guLastSelection then
		uLevelsBrowserControlDoubleClicked(w)
		gLastBrowserControlClick=0
	else
		gLastBrowserControlClick=time()
	end
	guLastSelection=w:value()
	
	
	
	
	
	
end
function uLevelsLoadClicked()
if gSelectedLevelName== nil then return end
bs="/" -- forwardslash
if string.sub(gSelectedLevelScript,-4,-1) == ".lua" then 
	gSelectedLevelName =string.gsub(gSelectedLevelName,bs..bs,bs)
	if string.sub(gSelectedLevelName,1,1) == bs then gSelectedLevelName=string.sub(gSelectedLevelName,2,-2) end
	print(gSelectedLevelName.."\n\t"..gSelectedLevelScript)
	loadLevel(gSelectedLevelName) 
end
end



function uLevelsMeshLoadClicked()
if gSelectedLevelMesh== nil then return end
bs="/" -- forwardslash
gSelectedLevelMesh = string.gsub(gSelectedLevelMesh,gameroot,"")
if string.sub(gSelectedLevelMesh,-4,-1) == ".wtf" then 
	gSelectedLevelMesh =string.gsub(gSelectedLevelMesh,bs..bs,bs)
	if string.sub(gSelectedLevelMesh,1,1) == bs then gSelectedLevelMesh=string.sub(gSelectedLevelMesh,2,-2) end
	print(gSelectedLevelName.."\n\t"..gSelectedLevelMesh)
	loadMesh(gSelectedLevelMesh) 
end

end
-- Fluids BROWSER CODE AHEAD 1128
gLastBrowserControlClick=time()
gLastSelection=-1

guFluidBrowserPath = getSceneInfo(IG3D_ROOT).."Data/Fluid/"
gFullFluidpath = guFluidBrowserPath
gSelectedFluidFile = guFluidBrowserPath.."Console".."console.fl"
guFluidBrowserFiles={}
-- (left, top, right, bottom) 
gGLX,gGLY,gGLR,gGLB = ig3d_GetWindowBounds__4i()

function ulistFluidFiles()
guFluidBrowserFiles={}
    uFluidFileBrowser:clear()
    for file in lfs.dir(guFluidBrowserPath) do
        if string.sub(file, 1,1)~="." or file==".." then
            local f = guFluidBrowserPath..'/'..file
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
             if attr.mode == "file" and string.sub(file, -3,-1)==".fl" then 
             	local a={file, "file"}
             	table.insert(guFluidBrowserFiles, a)
             	uFluidFileBrowser:add(file)
             end   
           if attr.mode == "directory" then 
           local a={file, "directory"}
             table.insert(guFluidBrowserFiles, a)
             uFluidFileBrowser:add(file.."     ->")
	   end  
        end
     end
     
end


function uFluidBrowserControlDoubleClicked(w)
	--
	local theFile=guFluidBrowserFiles[tonumber(w:value())]
	if theFile[2]=="directory" then
			if theFile[1]==".." then 
			guFluidBrowserPath=goDirsUp(guFluidBrowserPath, 1)
			
				if string.find(guFluidBrowserPath,"Fluid") == nil then
				guFluidBrowserPath = gameroot.."Data/Fluid/"
				end
			
			else
				guFluidBrowserPath=guFluidBrowserPath..theFile[1].."/"
				gFullFluidpath = guFluidBrowserPath
			
             		end
             		
	end
		ulistFluidFiles()
	
	
end

function uFluidBrowserControlClicked(w)
	if w:value()==0 or w:value() == nil then return end
	n=w:value()
	local theFile= guFluidBrowserFiles[tonumber(n)]
	uLoadFluidBtn:hide()
	
	if theFile[2]=="file" then
	uLoadFluidBtn:show()
	gSelectedFluidFile = guFluidBrowserPath..theFile[1]
	end
	
	if theFile[2]=="directory" then
		-- seek one level deeper for like named
				for file in lfs.dir(guFluidBrowserPath..theFile[1].."/") do
					if string.find(file,theFile[1]..".fl") ~= nil then
					gSelectedFluidFile = guFluidBrowserPath..theFile[1].."/"..file
					print(gSelectedFluidFile)
					uLoadFluidBtn:show()
             				end
             			end
             	end
             	
	local t=time()
	
	if t-gLastBrowserControlClick < 0.4 and w:value()==guLastSelection then
		uFluidBrowserControlDoubleClicked(w)
		gLastBrowserControlClick=0
	else
	
		gLastBrowserControlClick=time()	
	end
	guLastSelection=w:value()
	
	
				
	
end


function uFluidLoad()
print(gSelectedFluidFile)
if gSelectedFluidFile == nil then return end
if string.sub(gSelectedFluidFile,-3,-1) == ".fl" then

LuaOutFile = string.sub(gSelectedFluidFile,1,-3).."lua"
parseFluid(gSelectedFluidFile,LuaOutFile)
print(gSelectedFluidFile,LuaOutFile)
dofile(LuaOutFile)
end
end
-- GUIs BROWSER CODE AHEAD 11222022
gLastBrowserControlClick=time()
gLastSelection=-1

guGUIBrowserPath = getSceneInfo(IG3D_ROOT).."Data/GUI/"
gFullGUIpath = guGUIBrowserPath
gSelectedGUIFile = guGUIBrowserPath.."Console".."console.fl"
guGUIBrowserFiles={}
-- (left, top, right, bottom) 
gGLX,gGLY,gGLR,gGLB = ig3d_GetWindowBounds__4i()

function ulistGUIFiles()
guGUIBrowserFiles={}
    uGUIFileBrowser:clear()
    for file in lfs.dir(guGUIBrowserPath) do
        if string.sub(file, 1,1)~="." or file==".." then
            local f = guGUIBrowserPath..'/'..file
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
             if attr.mode == "file" and string.sub(file, -3,-1)==".fl" then 
             	local a={file, "file"}
             	table.insert(guGUIBrowserFiles, a)
             	uGUIFileBrowser:add(file)
             end   
           if attr.mode == "directory" then 
           local a={file, "directory"}
             table.insert(guGUIBrowserFiles, a)
             uGUIFileBrowser:add(file.."     ->")
	   end  
        end
     end
     
end


function uGUIBrowserControlDoubleClicked(w)
	--
	local theFile=guGUIBrowserFiles[tonumber(w:value())]
	if theFile[2]=="directory" then
			if theFile[1]==".." then 
			guGUIBrowserPath=goDirsUp(guGUIBrowserPath, 1)
			
				if string.find(guGUIBrowserPath,"GUI") == nil then
				guGUIBrowserPath = gameroot.."Data/GUI/"
				end
			
			else
				guGUIBrowserPath=guGUIBrowserPath..theFile[1].."/"
				gFullGUIpath = guGUIBrowserPath
			
             		end
             		
	end
		ulistGUIFiles()
end

function uGUIBrowserControlClicked(w)
	if w:value()==0 or w:value() == nil then return end
	n=w:value()
	local theFile= guGUIBrowserFiles[tonumber(n)]
	uLoadGUIBtn:hide()
	
	if theFile[2]=="file" then
	uLoadGUIBtn:show()
	gSelectedGUIFile = guGUIBrowserPath..theFile[1]
	end
	
	if theFile[2]=="directory" then
		-- seek one level deeper for like named
				for file in lfs.dir(guGUIBrowserPath..theFile[1].."/") do
					if string.find(file,theFile[1]..".fl") ~= nil then
					gSelectedGUIFile = guGUIBrowserPath..theFile[1].."/"..file
					print(gSelectedGUIFile)
					uLoadGUIBtn:show()
             				end
             			end
             	end
             	
	local t=time()
	
	if t-gLastBrowserControlClick < 0.4 and w:value()==guLastSelection then
		uGUIBrowserControlDoubleClicked(w)
		gLastBrowserControlClick=0
	else
	
		gLastBrowserControlClick=time()	
	end
	guLastSelection=w:value()
end


function uGUILoad()

if gSelectedGUIFile == nil then return end
if string.sub(gSelectedGUIFile,-3,-1) == ".fl" then

LuaOutFile = string.sub(gSelectedGUIFile,1,-3).."lua"

parseFluid(gSelectedGUIFile,LuaOutFile)

dofile(LuaOutFile)
end
end
-- uScripts BROWSER CODE AHEAD 1129
gLastBrowserControlClick=time()
gLastSelection=-1
guSelectedScriptFile=""
guScriptsBrowserPath=gameroot.."Data/Scripts/"
guScriptsBrowserFiles={}
-- (left, top, right, bottom) 
gGLX,gGLY,gGLR,gGLB = ig3d_GetWindowBounds__4i()

function ulistScriptsFiles()
guScriptsBrowserFiles={}
    uScriptsFileBrowser:clear()
    for file in lfs.dir(guScriptsBrowserPath) do
        if string.sub(file, 1,1)~="." or file==".." then
            local f = guScriptsBrowserPath..'/'..file
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
             if attr.mode == "file" and string.sub(file, -4,-1)==".lua" then 
             	local a={file, "file"}
             	table.insert(guScriptsBrowserFiles, a)
             	uScriptsFileBrowser:add(file)
             end   
           if attr.mode == "directory" then 
           local a={file, "directory"}
             table.insert(guScriptsBrowserFiles, a)
             uScriptsFileBrowser:add(file.."     ->")
	   end  
        end
     end
     
end



function uScriptsAddObjectClicked(w)
	if uScriptsFileBrowser:value()==0 then return end
	local theFile=guScriptsBrowserFiles[tonumber(uScriptsFileBrowser:value())]
	if theFile[2]=="directory" then return end
	
	local c=#(gameroot.."Data/Scripts/")+1
	local newObj={}
	table.insert(gObjects, newObj)
	local n=#gObjects
	guSelectedScriptFile = string.sub(guScriptsBrowserPath..theFile[1],c,-1)
	--load the script and do something
	
	
end



function uScriptsbrowserControlDoubleClicked(w)
	--
	local theFile=guScriptsBrowserFiles[tonumber(w:value())]
	if theFile[2]=="directory" then
	
		if theFile[1]==".." then 
			guScriptsBrowserPath=goDirsUp(guScriptsBrowserPath, 1)
			if string.find(guScriptsBrowserPath,"/Scripts/") == nil then
			guScriptsBrowserPath=gameroot.."Data/Scripts/"
			end
		else
			guScriptsBrowserPath=guScriptsBrowserPath..theFile[1].."/"
		end
		ulistScriptsFiles()
	end
		
end

function uScriptsbrowserControlClicked(w)
	if w:value()==0 then return end
	print(w:value())
	local theFile= guScriptsBrowserFiles[tonumber(w:value())]
	
	
		if theFile[2]=="file" then
		guSelectedScriptFile = guScriptsBrowserPath..theFile[1]	
	
		else
		guSelectedScriptFile = nil
		end
		
	local t=time()
	
	if t-gLastBrowserControlClick < 0.4 and w:value()==guLastSelection then
		uScriptsbrowserControlDoubleClicked(w)
		gLastBrowserControlClick=0
	else
		gLastBrowserControlClick=time()
	end
	guLastSelection=w:value()
	
		if guSelectedScriptFile == nil then
		uLoadScriptsBtn:hide()
		else
		uLoadScriptsBtn:show()
		end	
		
end


function uLoadScriptBtnClicked()
	
	print(guSelectedScriptFile)
	OPEN_UI_WINDOWS("script_editor");
   		if scriptEditor ~=nil then 
   		scriptEditor:make_current()
   		local f=io.open(guSelectedScriptFile, "r")
		local tText=f:read("*a")
		editorPrint(tText)
		f:close()
		closer:activate()
		path:value(guSelectedScriptFile)
   		end
   		
	--if string.sub(gSelectedLevelScript,-4,-1) == ".lua" then loadLevel(gSelectedLevelName) end
end
-- uEmitter BROWSER CODE AHEAD 1129

ParticlesFileList={}
gParticleFilesShortNames={}
guEMTBrowserPath = gameroot.."Data/Emitters/"
gEmitterSourcePath =""
if gNumParticleEmitters == nil or gNumParticleEmitters < 1 then
	
	gParticleNamesAndEMTs={}
	gParticleEmitters={}
	gParticlePositions={}
	gParticleRotations={}
	gNumParticleEmitters=0
	end
	
-- uEMTemitterSourceList
function uListEmitters()
uBrowserNew:make_current()
ParticlesFileList={}
gParticleFilesShortNames={}
uEMTFileBrowser:clear()
   for file in lfs.dir(guEMTBrowserPath) do
        if string.sub(file, 1,1)~="." or file==".." then
            local f = guEMTBrowserPath..'/'..file
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
            
             if attr.mode == "file" and string.sub(file, -4,-1)==".emt" then 
             	local a={file, "file"}
             	table.insert(ParticlesFileList, a)
             	uEMTFileBrowser:add(file)
             end   
             
           if attr.mode == "directory" then 
           local a={file, "directory"}
             table.insert(ParticlesFileList, a)
             uEMTFileBrowser:add(file.."     ->")
	   end  
        end
     end
     

			 
end


-- uEMTbrowserControlDoubleClicked
function uEMTbrowserControlDoubleClicked(w)
	--
	local theFile=ParticlesFileList[tonumber(w:value())]
	if theFile[2]=="directory" then
		if theFile[1]==".." then 
			guEMTBrowserPath=goDirsUp(guEMTBrowserPath, 1)
		else
			guEMTBrowserPath=guEMTBrowserPath..theFile[1].."/"
		end
		uListEmitters()
	end
		print(gEmitterSourcePath)

end
-- uEMTbrowserControlClicked

function uEMTbrowserControlClicked(w)
	if w:value()==0 then return end
	local theFile = ParticlesFileList[tonumber(w:value())]
	print(w:value()) 
	
	if theFile[2]=="file" then
	gEmitterSourcePath = "Data/Emitters/"..theFile[1]
	else
	gEmitterSourcePath = nil
	end
	
	if gEmitterSourcePath ~= nil then
	uEMTLoadBtn:show()
	else
	uEMTLoadBtn:hide()
	end
	
	local t=time()
	
	if t-gLastBrowserControlClick < 0.4 and w:value()==gLastSelection then
		uEMTbrowserControlDoubleClicked(w)
		gLastBrowserControlClick=0
	else
		gLastBrowserControlClick=time()
	end
	gLastSelection=w:value()
	print(gEmitterSourcePath)
end


function uLoadEMTBtnClicked()
	
	print(gEmitterSourcePath)
	local s=string.len("Data/Emitters/n")
	emitterShortName = string.sub(gEmitterSourcePath,s,-5)
	print(emitterShortName)
   		plist= ig3d_GetParticle_emittersList__s()
 		pcount =  getlinecount(plist)
		local numofLike=1
	if pcount > 1 then 
		for i=1,pcount,1 do
		if string.find(getlineof(plist,i),emitterShortName) ~= nil then numofLike=numofLike+1 end
		end
		for i=4,2,-1 do
			if string.len(numofLike) < i then numofLike = "0"..numofLike end
		end
	end
	
	
	gSelectedParticle = emitterShortName..numofLike
	table.insert(gParticleNamesAndEMTs,{gSelectedParticle,gEmitterSourcePath})
	gParticleEmitters[#gParticleNamesAndEMTs]=make(ig3d_particle_emitter, gSelectedParticle, gEmitterSourcePath)
	gObjName = "particles "..gSelectedParticle;
	ig3d_SetSelection_s(gObjName)
	runningParticle = get(ig3d_particle_emitter,gSelectedParticle)
	setParticle_emitterInfo(runningParticle, IG3D_START)
   		
end
-- uFontPngs BROWSER CODE AHEAD 1129

FontPngsFileList={}
gFontPngsFilesShortNames={}
guFontPngsBrowserPath = gameroot.."Data/FontPngs/"
gFontPngsSourcePath =""
gSelectedFontPath = ""

if not gFontFiles then
	gFontFiles={{}}
	end
	
-- uFontPngsFontPngsSourceList
function uListFontPngs()
uBrowserNew:make_current()
FontPngsFileList={}
gFontPngsFilesShortNames={}
uFontPngsFileBrowser:clear()
   for file in lfs.dir(guFontPngsBrowserPath) do
        if string.sub(file, 1,1)~="." or file==".." then
            local f = guFontPngsBrowserPath..'/'..file
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
            
             if attr.mode == "file" and string.sub(file, -4,-1)==".png" then 
             	local a={file, "file"}
             	table.insert(FontPngsFileList, a)
             	uFontPngsFileBrowser:add(file)
             end   
             
           if attr.mode == "directory" then 
           local a={file, "directory"}
             table.insert(FontPngsFileList, a)
             uFontPngsFileBrowser:add(file.."     ->")
	   end  
        end
     end
     

			 
end


-- uFontPngsbrowserControlDoubleClicked
function uFontPngsbrowserControlDoubleClicked(w)
	--
	local theFile=FontPngsFileList[tonumber(w:value())]
	if theFile[2]=="directory" then
		if theFile[1]==".." then 
			guFontPngsBrowserPath=goDirsUp(guFontPngsBrowserPath, 1)
		else
			guFontPngsBrowserPath=guFontPngsBrowserPath..theFile[1].."/"
		end
		uListFontPngs()
	end
		--print(gFontPngsSourcePath)

end
-- uFontPngsbrowserControlClicked

function uFontPngsbrowserControlClicked(w)
	if w:value()==0 then return end
	local theFile = FontPngsFileList[tonumber(w:value())]
	print(w:value()) 
	
	if theFile[2]=="file" then
	gFontPngsSourcePath = "Data/FontPngs/"..theFile[1]
	else
	gFontPngsSourcePath = nil
	end
	
	if gFontPngsSourcePath ~= nil then
	uFontPngsLoadBtn:show()
	else
	uFontPngsLoadBtn:hide()
	end
	
	local t=time()
	
	if t-gLastBrowserControlClick < 0.4 and w:value()==gLastSelection then
		uFontPngsbrowserControlDoubleClicked(w)
		gLastBrowserControlClick=0
	else
		gLastBrowserControlClick=time()
	end
	gLastSelection=w:value()
	--print(gFontPngsSourcePath)
end



function uLoadFontPngsBtnClicked()
	
	print(gFontPngsSourcePath)
	local s=string.len("Data/FontPngs/n")
	FontPngsShortPath = string.sub(gFontPngsSourcePath,1,-6)
	--print(FontPngsShortPath.."1.png".."\n"..FontPngsShortPath.."2.png")
	table.insert(gFontFiles, FontPngsShortPath.."1.png")
	
	gSelectedFontPath = FontPngsShortPath.."1.png"
	loadFont(FontPngsShortPath.."1.png", FontPngsShortPath.."2.png")
	for i = 1,#gFontFiles,1 do
	print(gFontFiles[i][1])
	end
	
	if gTextboxes ~= nil and gSelectedTextBoxNum ~= nil then
	setText_boxInfo(gTextboxes[gSelectedTextBoxNum], IG3D_FONT, gSelectedFontPath)
	end

	   		
end
-- uBrowserUpdate
function uBrowserUpdate(what)
if what == nil then return end;
fs=string.find(what,"/")
if fs ~= nil then
what = string.sub(what,fs+1,-1) 
end
uBrowserNew:make_current()
print(what)

pngBrowserGroup:hide()
WTFBrowserGroup:hide()
uLevelsBrowserGroup:hide()
uFluidBrowserGroup:hide()
uGUIBrowserGroup:hide()
uScriptsBrowserGroup:hide()
uEMTBrowserGroup:hide()
uOGGBrowserGroup:hide()
uFontPngsBrowserGroup:hide()

if what == "Images" then 
ulistPNGFiles()
pngBrowserGroup:show()
end

if what == "Fluid" then
ulistFluidFiles()
uFluidBrowserGroup:show()
end

if what == "GUI" then
ulistGUIFiles()
uGUIBrowserGroup:show()
end

if what == "Models" then 
ulistWTFFiles()
WTFBrowserGroup:show()
end

if what == "Scripts" then 
ulistScriptsFiles()

uScriptsBrowserGroup:show()
uLoadScriptsBtn:hide()
end

if what == "Level" or what == "Levels" then
ulistLevelsFiles()
uLevelsBrowserGroup:show()
end
if what == "Emitters" then
uListEmitters()
uEMTBrowserGroup:show()
uEMTLoadBtn:hide()
end

if what == "Sounds" then
--uListSoundEmitters()  <<--- MISSING FUNCTION 11212022
uOGGBrowserGroup:show()
uOGGLoadBtn:hide()
end
if what == "FontPngs" then
uListFontPngs()
uFontPngsBrowserGroup:show()
uFontPngsLoadBtn:hide()
end

uBrowserNew:label(what)
uBrowserNew:redraw()
fltk_update()
end
do uBrowserNew= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "PNG Browser")
uBrowserNew:label(gLabelTable[#gLabelTable])
uBrowserNew:resize(94,184,143,398)
Fl_Group:current():resizable(uBrowserNew)
--unknown attribute: non_modal
uBrowserNew:size_range(143,403,192,680)
--uBrowserNew:show()
do pngBrowserGroup= fltk:Fl_Group(0,0,0,0,"")
pngBrowserGroup:resize(5,1,129,389)
do upngPreviewBox= fltk:Fl_Box(0,0,0,0,"")
upngPreviewBox:resize(5,1,128,128)
upngPreviewBox:box(fltk.FL_FLAT_BOX)
upngPreviewBox:color(40)
upngPreviewBox:align(16)
end

do upngFileBrowser= fltk:Fl_Browser(0,0,0,0,"")
upngFileBrowser:callback(uPNGbrowserControlClicked)
upngFileBrowser:resize(5,155,128,235)
upngFileBrowser:type(2)
upngFileBrowser:labelsize(10)
upngFileBrowser:when(3)
upngFileBrowser:textsize(10)
end

do uLoadButton= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Load Image")
uLoadButton:label(gLabelTable[#gLabelTable])
uLoadButton:callback(upngLoad)
uLoadButton:resize(5,132,128,20)
uLoadButton:labelsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do WTFBrowserGroup= fltk:Fl_Group(0,0,0,0,"")
WTFBrowserGroup:resize(0,0,136,389)
WTFBrowserGroup:labelsize(10)
do uwtfPreviewBox= fltk:Fl_Box(0,0,0,0,"")
uwtfPreviewBox:resize(5,0,128,128)
uwtfPreviewBox:box(fltk.FL_FLAT_BOX)
uwtfPreviewBox:color(40)
uwtfPreviewBox:labelsize(10)
uwtfPreviewBox:align(16)
end

do uwtfFileBrowser= fltk:Fl_Browser(0,0,0,0,"")
uwtfFileBrowser:callback(uWTFbrowserControlClicked)
uwtfFileBrowser:resize(5,154,128,235)
uwtfFileBrowser:type(2)
uwtfFileBrowser:labelsize(10)
uwtfFileBrowser:when(3)
uwtfFileBrowser:textsize(10)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Add object")
widget:label(gLabelTable[#gLabelTable])
widget:callback(uwtfAddObjectClicked)
widget:resize(66,132,65,19)
widget:labelsize(10)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Load mesh")
widget:label(gLabelTable[#gLabelTable])
widget:callback(uwtfPreviewLoadMesh)
widget:resize(5,132,60,19)
widget:labelsize(10)
end

do uwtfPreviewNote= fltk:Fl_Box(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "NO PREVIEW")
uwtfPreviewNote:label(gLabelTable[#gLabelTable])
uwtfPreviewNote:resize(5,62,130,16)
uwtfPreviewNote:labelsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do uLevelsBrowserGroup= fltk:Fl_Group(0,0,0,0,"")
uLevelsBrowserGroup:resize(0,1,135,389)
uLevelsBrowserGroup:labelsize(10)
do uLevelsFileBrowser= fltk:Fl_Browser(0,0,0,0,"")
uLevelsFileBrowser:callback(uLevelsBrowserControlClicked)
uLevelsFileBrowser:resize(4,25,128,365)
uLevelsFileBrowser:type(2)
uLevelsFileBrowser:labelsize(10)
uLevelsFileBrowser:when(3)
uLevelsFileBrowser:textsize(10)
end

do uLoadLevelBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Load Level")
uLoadLevelBtn:label(gLabelTable[#gLabelTable])
uLoadLevelBtn:callback(uLevelsLoadClicked)
uLoadLevelBtn:resize(66,3,65,19)
uLoadLevelBtn:labelsize(10)
end

do uLoadLevelMeshBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Load mesh")
uLoadLevelMeshBtn:label(gLabelTable[#gLabelTable])
uLoadLevelMeshBtn:callback(uLevelsMeshLoadClicked)
uLoadLevelMeshBtn:resize(5,3,60,19)
uLoadLevelMeshBtn:labelsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do uFluidBrowserGroup= fltk:Fl_Group(0,0,0,0,"")
uFluidBrowserGroup:resize(0,1,135,389)
uFluidBrowserGroup:labelsize(10)
do uFluidFileBrowser= fltk:Fl_Browser(0,0,0,0,"")
uFluidFileBrowser:callback(uFluidBrowserControlClicked)
uFluidFileBrowser:resize(4,25,128,365)
uFluidFileBrowser:type(1)
uFluidFileBrowser:labelsize(10)
uFluidFileBrowser:when(3)
uFluidFileBrowser:textsize(10)
end

do uLoadFluidBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Load Fluid")
uLoadFluidBtn:label(gLabelTable[#gLabelTable])
uLoadFluidBtn:callback(uFluidLoad)
uLoadFluidBtn:resize(5,3,125,19)
uLoadFluidBtn:labelsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do uGUIBrowserGroup= fltk:Fl_Group(0,0,0,0,"")
uGUIBrowserGroup:resize(0,1,135,389)
uGUIBrowserGroup:labelsize(10)
do uGUIFileBrowser= fltk:Fl_Browser(0,0,0,0,"")
uGUIFileBrowser:callback(uGUIBrowserControlClicked)
uGUIFileBrowser:resize(4,25,128,365)
uGUIFileBrowser:type(1)
uGUIFileBrowser:labelsize(10)
uGUIFileBrowser:when(3)
uGUIFileBrowser:textsize(10)
end

do uLoadGUIBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Load Fluid")
uLoadGUIBtn:label(gLabelTable[#gLabelTable])
uLoadGUIBtn:callback(uGUILoad)
uLoadGUIBtn:resize(5,3,125,19)
uLoadGUIBtn:labelsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do uScriptsBrowserGroup= fltk:Fl_Group(0,0,0,0,"")
uScriptsBrowserGroup:resize(0,1,135,389)
uScriptsBrowserGroup:labelsize(10)
do uScriptsFileBrowser= fltk:Fl_Browser(0,0,0,0,"")
uScriptsFileBrowser:callback(uScriptsbrowserControlClicked)
uScriptsFileBrowser:resize(4,25,128,365)
uScriptsFileBrowser:type(2)
uScriptsFileBrowser:labelsize(10)
uScriptsFileBrowser:when(3)
uScriptsFileBrowser:textsize(10)
end

do uLoadScriptsBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Load Script")
uLoadScriptsBtn:label(gLabelTable[#gLabelTable])
uLoadScriptsBtn:callback(uLoadScriptBtnClicked)
uLoadScriptsBtn:resize(5,3,125,19)
uLoadScriptsBtn:labelsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do uEMTBrowserGroup= fltk:Fl_Group(0,0,0,0,"")
uEMTBrowserGroup:resize(0,1,135,389)
uEMTBrowserGroup:labelsize(10)
do uEMTFileBrowser= fltk:Fl_Browser(0,0,0,0,"")
uEMTFileBrowser:callback(uEMTbrowserControlClicked)
uEMTFileBrowser:resize(4,25,128,365)
uEMTFileBrowser:type(2)
uEMTFileBrowser:labelsize(10)
uEMTFileBrowser:when(3)
uEMTFileBrowser:textsize(10)
end

do uEMTLoadBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Load Emitter")
uEMTLoadBtn:label(gLabelTable[#gLabelTable])
uEMTLoadBtn:callback(uLoadEMTBtnClicked)
uEMTLoadBtn:resize(5,3,125,19)
uEMTLoadBtn:labelsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do uOGGBrowserGroup= fltk:Fl_Group(0,0,0,0,"")
uOGGBrowserGroup:resize(0,1,135,389)
uOGGBrowserGroup:labelsize(10)
do uOGGFileBrowser= fltk:Fl_Browser(0,0,0,0,"")
uOGGFileBrowser:callback(uOGGbrowserControlClicked)
uOGGFileBrowser:resize(4,25,128,365)
uOGGFileBrowser:type(2)
uOGGFileBrowser:labelsize(10)
uOGGFileBrowser:when(3)
uOGGFileBrowser:textsize(10)
end

do uOGGLoadBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Load Emitter")
uOGGLoadBtn:label(gLabelTable[#gLabelTable])
uOGGLoadBtn:callback(uLoadOGGBtnClicked)
uOGGLoadBtn:resize(5,3,125,19)
uOGGLoadBtn:labelsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do uFontPngsBrowserGroup= fltk:Fl_Group(0,0,0,0,"")
uFontPngsBrowserGroup:resize(0,1,135,389)
uFontPngsBrowserGroup:labelsize(10)
do uFontPngsFileBrowser= fltk:Fl_Browser(0,0,0,0,"")
uFontPngsFileBrowser:callback(uFontPngsbrowserControlClicked)
uFontPngsFileBrowser:resize(4,25,128,365)
uFontPngsFileBrowser:type(2)
uFontPngsFileBrowser:labelsize(10)
uFontPngsFileBrowser:when(3)
uFontPngsFileBrowser:textsize(10)
end

do uFontPngsLoadBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Load FontPng")
uFontPngsLoadBtn:label(gLabelTable[#gLabelTable])
uFontPngsLoadBtn:callback(uLoadFontPngsBtnClicked)
uFontPngsLoadBtn:resize(5,3,125,19)
uFontPngsLoadBtn:labelsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end
end
uBrowserNew:show()

uBrowserNew:show()
uBrowserUpdate(gLastMenuPick)
 --ulistWTFFiles()
--end
Fl:run()
