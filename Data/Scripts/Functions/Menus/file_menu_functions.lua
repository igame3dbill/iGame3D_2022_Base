-- FILL THE FILE MENU
fileMenuText={}
fileMenuText.Save={"Save/Level","Save/Level Mesh","Save/Level State","Save/Screenshot"}
fileMenuText.Export={"Export/WTF","Export/OBJ","Export/3DS","Export/Path"}
fileMenuText.Open={"Open/default","Open/Level","Open/Script","Open/Mesh","Open/Fluid","Open/Emitter","Open/Shader"}
fileMenuText.Load={"Load/Object","Load/Sound","Load/Font","Load/Texture","Load/Mesh"}
fileMenuIndex={}

function fill_FileMenu()
n=#mainMenuIndex+1
mainMenuIndex[n]="Open"
for i=1,#fileMenuText.Open,1 do
n=n+1
menuLine="File/"..fileMenuText.Open[i]
menuBar:add(menuLine);
mainMenuIndex[n]=menuLine
end

n=n+2
mainMenuIndex[n]="Save"
for i=1,#fileMenuText.Save,1 do
n=n+1 
menuLine="File/"..fileMenuText.Save[i]
menuBar:add(menuLine);
mainMenuIndex[n]=menuLine
end
n=n+2
mainMenuIndex[n]="Load"
for i=1,#fileMenuText.Load,1 do
n=n+1 
menuLine="File/"..fileMenuText.Load[i]
menuBar:add(menuLine);
mainMenuIndex[n]=menuLine
end
n=n+2
mainMenuIndex[n]="Export"
for i=1,#fileMenuText.Export,1 do
n=n+1 
menuLine="File/"..fileMenuText.Export[i]
menuBar:add(menuLine);
mainMenuIndex[n]=menuLine
end
menuIndexCount=n
--print("n="..n)
end


-- open level
function openLevel()
fileName = fltk.fl_file_chooser("Choose a picture", "Image Files (*.{bmp,gif,jpg,png})", nil, nil)
end

-- nameLevel
function nameLevel(levelName)
ig3d_SetLevelName_s(gameroot.."Data/Levels/"..levelName)
end


-- file Menu Pick
function fileMenuPick(tPick)
local xPick=item(-2,tPick,"/")
local yPick=item(-1,tPick,"/")
local mPick=xPick.."/"..yPick
local tTitle=xPick.." "..yPick
local tDir=gameroot.."Data/"
local tFile="empty"
  -- chooseFile(title,filename_filter,start_path)
 -- chooseFolder(title,start_path)
print(xPick,yPick)
print("mPick="..mPick)
if xPick=="Save" or xPick =="Export" then savefile(yPick)
elseif   xPick== "Open"  or xPick == "Load" then openfile(yPick)
  end  
end


-- open file from menus 
 function openfile(yPick)
 Fl_File_Icon:load_system_icons()
 
 Fl_File_Icon:load_system_icons()
lua_icon=fltk:Fl_File_Icon("*.wtf",1) -- pattern, type (0=any, 1=file/directory)
lua_icon:load(gameroot.."Data/Icons/FileIcons/WTFICON.png")

 local tDir=gameroot.."Data/"
local tFile="empty"
      if yPick=="default" then action = exittomenu()
   	elseif yPick=="Level" then tFile = chooseFolder(tTitle,tDir.."Levels/")  
   	elseif yPick=="Script" then tFile =  chooseFile(tTitle,"*.lua",tDir.."Scripts/")
   	elseif yPick=="Fluid" then tFile =  chooseFile(tTitle,"*.fl",tDir.."Fluid/") 
   	elseif yPick=="Mesh" then tFile =  chooseFile(tTitle,"*.wtf",tDir.."WTF/")
   	elseif yPick=="Shader" then tFile =  chooseFolder(tTitle,tDir.."Shaders/") 
   	elseif yPick=="Object" then tFile =  chooseFile(tTitle,"*.wtf",tDir.."WTF/")
   	elseif yPick=="Sound" then tFile =  chooseFile(tTitle,"*.ogg",tDir.."Sounds/") 
   	elseif yPick=="Font" then tFile =  chooseFile(tTitle,"*.png",tDir.."FontPngs/") 
   	elseif yPick=="Texture" then tFile =  chooseFile(tTitle,"*.png",tDir.."Images/")
   	elseif yPick=="load script" then 
   		 levelPath = ig3d_GetLevelName__s() tFile =  ig3d_GetLevelName__s().."/load script.lua" 
   		if string.sub(levelPath,-1,-1) ~= "/" then 
   		tFile =  ig3d_GetLevelName__s().."/load script.lua"
   		else
   		tFile =  ig3d_GetLevelName__s().."load script.lua"
   		end
   	print(tFile)
   	end
   	print(tFile)
  	 if  tFile ~= nil then 
  	
  	 tFile = string.gsub(tFile,"//","") 
  	 lastLoadedFile = string.sub(tFile,1,-5)
  	 print(lastLoadedFile)
  	 	if yPick=="Level" then loadLevel(tFile);
   		elseif yPick=="Fluid" then  OPEN_UI_WINDOWS(item(-2,tFile,"/"))
   		elseif yPick=="Shader" then print(tFile);
   		elseif yPick=="Mesh" then loadMesh(tFile);
   		elseif yPick=="Texture" then loadTexture(tFile);
   		elseif yPick=="Sound" then loadSound(tFile);
   		elseif yPick=="Object" then loadObject(tFile);
   		end
   		
   		if yPick =="load script" or yPick == "Script" then 
   		OPEN_UI_WINDOWS("script_editor");
   		if scriptEditor ~=nil then openScript(tFile) end
   			end
   		 
   		 if yPick=="Font" then
   		firstFont=item(1,tFile,"_").."_1.png"
   		secondFont=item(1,tFile,"_").."_2.png"
   		loadTexture(firstFont)
   		loadTexture(secondFont)
   		loadFont(firstFont,secondFont)
   		print(firstFont.."/n"..secondFont)
   		end
   	end
 
   end
   
   
   -- save files from menus
function savefile(yPick)
local tDir=gameroot.."Data/"
local tFile="empty"
   if yPick=="Level" then save_level() 
   elseif yPick=="Level Mesh" then save_levelMesh()
   elseif yPick=="Level State" then save_levelState()
   elseif yPick=="Screenshot" then save_screenshot()
   elseif yPick=="WTF" then save_asWTF()
   elseif yPick=="OBJ" then save_asOBJ()
   elseif yPick=="3DS" then save_as3DS()
   elseif yPick=="Meshwork" then save_asMeshwork()
   end 
 print("saveFile"..yPick)
end


-- save script requires script editor, should make dynamic
function saveScript()
	if fileName == nil then
		fileName = fltk.fl_file_chooser("Please enter the filename:", "Lua Files (*.{lua, ig3d})", nil, nil)
		if fileName == nil then
			return false
		else
			path:label(fileName)
			closer:activate()
		end
	end
	
	local f=io.open(fileName, "w")
	f:write(editor:value())
	f:close()
	changed=false
	saver:deactivate()
	return true
end