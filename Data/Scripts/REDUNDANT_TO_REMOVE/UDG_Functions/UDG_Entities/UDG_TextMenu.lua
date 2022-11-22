loadFont("Data/FontPngs/Shlop32_1.png","Data/FontPngs/Shlop32_2.png")
loadFont("Data/FontPngs/CRAMPS32_1.png","Data/FontPngs/CRAMPS32_2.png")

gUDG_PickedLevel = "Data/Levels/UDG/UDG_MainMenu"
-- udg_listLevels

UDG_LevelsTable={}
UDG_EasyLevelsTable={}
UDG_ChallengeLevelsTable={}
UDG_HardLevelsTable={}

function udg_listLevels()
UDG_LevelsTable={}
UDG_EasyLevelsTable={}
UDG_ChallengeLevelsTable={}
UDG_HardLevelsTable={}


udgPath=gameroot.."Data/Levels/UDG/"
folderList=ListFolder(udgPath,"t")
local levelslist=""
local foundloadscript = false

local levelshortname =""
	for i,v in pairs(folderList) do 
	listedFiles=listFiles(udgPath ..v)
		for ii,vv in pairs(listedFiles) do
		--print(ii,vv)
			if vv ~= nil then 
					if string.find(vv,"load script.lua") ~= nil then
			 		levelshortname = string.sub(v,string.find(v,"UDG_")+4,-1)
			 		for iii,vvv in pairs(listedFiles) do
					if  vvv ~= nil then
						if string.find(vvv,"levelstats") ~= nil then
					
						if string.find(v,"Two") ~= nil then
						table.insert(UDG_ChallengeLevelsTable,{"UDG/"..v, levelshortname})
						levelslist=levelslist..levelshortname.."\n"
						else
						table.insert(UDG_EasyLevelsTable,{"UDG/"..v, levelshortname})
						levelslist=levelslist..levelshortname.."\n"	
						end
						end
						
					end
					end
					break	
					end
			end
		end
	end
	
	return levelslist
end











--[[
function trigger_load_instructions()
	loadLevel("Data/Levels/UDG/UDG_Instructions")
end

function trigger_load_living_inn()
	loadLevel("Data/Levels/UDG/UDG_LivingInn")
end

function trigger_load_currentlevel()
	loadLevel(gCurrentLevel)
end

local thislevel=ig3d_GetLevelName__s() 
	   local  currentLevelFile = io.open(gameroot.."Data/Levels/UDG/currentlevel.lua","r")
			if currentLevelFile~=nil then
			dofile(gameroot.."Data/Levels/UDG/currentlevel.lua")
			currentLevelFile:close()
			end
			if gCurrentLevel == nil then gCurrentLevel = "Data/Levels/UDG/UDG_LivingInn" end

function trigger_continue()
	setObjectInfo(gMenuButtons.cObj, IG3D_HUD, true)
	setObjectInfo(gMenuButtons.cObj, IG3D_POSITION, 0,0,10)
	setObjectInfo(crosshair.cObj, IG3D_POSITION, 0,0,-0.1)
	setSceneInfo(IG3D_SPEED, 1)
	gHideHUD=false
	game_func=handle_udg
	setText_boxInfo(3, IG3D_TEXT, "")
end

function trigger_restart()
	udg_all_sounds_stop()--good idea
	coll_o_m=nil
	coll_o_p=nil
	coll_o_o=nil
	coll_p_m=nil
	gUDGMusic=nil
	gUDGMusicAction=nil
	loadLevel(ig3d_GetLevelName__s())
end

function trigger_controls()
	setObjectInfo(gMenuButtons.cObj, IG3D_POSITION, 0,0,10)
	setObjectInfo(gMenuButtons.cObj, IG3D_HUD, true)
	gMenuButtons.mayReposition=false
	udg_showControlsWindow(3)
end

function trigger_menu()
	udg_all_sounds_stop()--good idea
	coll_o_m=nil
	coll_o_p=nil
	coll_o_o=nil
	coll_p_m=nil
	gUDGMusic=nil
	gUDGMusicAction=nil					
	loadLevel("Data/Levels/UDG/UDG_MainMenu")
end
--]]


function trigger_show_level_list()
	gOldCameraX,gOldCameraY,gOldCameraZ=getCameraInfo(IG3D_ROTATION)
	setCameraInfo(IG3D_ROTATION, 0,90,0)
	game_func= udg_mouse_and_buttons_text
end

function trigger_back_to_main_menu()
	setCameraInfo(IG3D_ROTATION, gOldCameraX,gOldCameraY,gOldCameraZ)
	game_func=udg_mouse_and_buttons
	local i
	for i=1,#gMenuButtonsText,1 do
		setText_boxInfo(gMenuButtonsText[i], IG3D_TEXT, "")
	end
end

function trigger_load_level_i()
	coll_o_m=nil
	coll_o_p=nil
	coll_o_o=nil
	coll_p_m=nil
	gUDGMusic=nil
	gUDGMusicAction=nil
	loadLevel("Data/Levels/UDG/UDG_"..gButtonNames[gOldSelectedMenuButton])
end


function textboxCollision(x,y)
	local theBox=nil
	for i=1,#gMenuButtonsText,1 do
		local leftb,topb,rightb,bottomb=getText_boxInfo(gMenuButtonsText[i], IG3D_BOUNDS)
		if x>=leftb then
			if x<=rightb then
				if y>=topb then
					if y<=bottomb then
						return gMenuButtonsText[i]
					end
				end
			end
		end
	end
end



--build the levels list
 udg_listLevels()
 gButtonNames={}
 gMenuButtonsText={}
 gButtonTriggerFunctionsText={}
 for i=1,#UDG_EasyLevelsTable,1 do
 	table.insert(gButtonNames, string.sub(UDG_EasyLevelsTable[i][1], 9,-1))
 	make(ig3d_text_box, "Data/FontPngs/CRAMPS32_1.png")
 	table.insert(gMenuButtonsText, #gMenuButtonsText+1)
 	setText_boxInfo(#gMenuButtonsText, IG3D_FONT, "Data/FontPngs/CRAMPS32_1.png")
 	table.insert(gButtonTriggerFunctionsText, trigger_load_level_i)
 	setText_boxInfo(#gMenuButtonsText, IG3D_COLOR, 1,1,1,1)
 end
  for i=1,#UDG_ChallengeLevelsTable,1 do
 	table.insert(gButtonNames, string.sub(UDG_ChallengeLevelsTable[i][1], 9, -1))
 	make(ig3d_text_box, "Data/FontPngs/CRAMPS32_1.png")
 	table.insert(gMenuButtonsText, #gMenuButtonsText+1)
 	setText_boxInfo(#gMenuButtonsText, IG3D_FONT, "Data/FontPngs/CRAMPS32_1.png")
 	table.insert(gButtonTriggerFunctionsText, trigger_load_level_i)
 	setText_boxInfo(#gMenuButtonsText, IG3D_COLOR, 1,1,1,1)
 end
 
table.insert(gButtonNames, "Return to Main Menu")
make(ig3d_text_box, "Data/FontPngs/CRAMPS32_1.png")
table.insert(gMenuButtonsText, #gMenuButtonsText+1)
setText_boxInfo(#gMenuButtonsText, IG3D_FONT, "Data/FontPngs/CRAMPS32_1.png")
table.insert(gButtonTriggerFunctionsText, trigger_back_to_main_menu)
setText_boxInfo(#gMenuButtonsText, IG3D_COLOR, 1,1,1,1)

gOnlyOneAllowedButton =nil
gOldSelectedMenuButton=nil
gPicked=false
gMenuOffsetV=0
gMenuFontSize=20
gMenuButtonColumns=1

function udg_mouse_and_buttons_text()
	setSceneInfo(IG3D_MOUSE_VIEW, false, 1)
	local left,top,right,bottom=ig3d_GetWindowBounds__4i()
	
	if gOldSelectedMenuButton then
		setText_boxInfo(gOldSelectedMenuButton, IG3D_COLOR, 1,1,1,1)
	end
	
	for i=1,#gButtonNames,1 do
		if ("Data/Levels/UDG/UDG_"..gButtonNames[i])==gCurrentLevel then setText_boxInfo(i, IG3D_COLOR, 0,1,0,1) end
	end

	if #gButtonNames >21 then
		gMenuButtonColumns=2
	end
	gMenuFontSize=math.ceil( (bottom-top)/37)
	gMenuOffsetH=-(gMenuButtonColumns-1) * (right-left)/3.5
	gMenuOffsetV=15

	for i=1,#gMenuButtonsText,1 do
		setText_boxInfo(gMenuButtonsText[i], IG3D_TEXT, gButtonNames[i])
		local leftb,topb,rightb,bottomb=getText_boxInfo(gMenuButtonsText[i], IG3D_BOUNDS)
		
		if i>21 then gMenuOffsetH=(right-left)/3.5; gMenuOffsetV=-21*(gMenuFontSize*1.5)+15 end
		setText_boxInfo(gMenuButtonsText[i], IG3D_POSITION, (right-left)/2 - (rightb-leftb)/2 + gMenuOffsetH, (i-1)*(gMenuFontSize*1.5) + gMenuOffsetV)
		
		if i==#gMenuButtonsText then setText_boxInfo(gMenuButtonsText[i], IG3D_POSITION, (right-left)/2 - (rightb-leftb)/2, 22*(gMenuFontSize*1.5)) end
		setText_boxInfo(gMenuButtonsText[i], IG3D_SIZE, gMenuFontSize)
	end
	
	local ax,ay,az,bx,by,bz=getSceneInfo(IG3D_MOUSE_LINE)
	local x,y,z=getSceneInfo(IG3D_WINDOW_COORDS, ax,ay,az)
	gOldSelectedMenuButton = textboxCollision(x,y)
	
	if gOldSelectedMenuButton then		
		if not gOnlyOneAllowedButton then setText_boxInfo(gOldSelectedMenuButton, IG3D_COLOR, 1,1,0,1) end
		
		if click("n") then
			gOnlyOneAllowedButton = gOldSelectedMenuButton
			gPicked=true
		end
		
		if click("o") then
			setText_boxInfo(gOldSelectedMenuButton, IG3D_COLOR, 0.5, 0.5, 0.5, 1)
			render()
			gButtonTriggerFunctionsText[gOldSelectedMenuButton]()
		end
		
			
		if click("-") and gOldSelectedMenuButton == gOnlyOneAllowedButton then
			setText_boxInfo(gOldSelectedMenuButton, IG3D_COLOR, 1,0,0,1)
		end
	end
	
	if click("o") then
		gOnlyOneAllowedButton =nil
	end
	

	fltk_update()
end