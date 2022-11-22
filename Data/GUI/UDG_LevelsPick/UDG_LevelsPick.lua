--function make_window()
showGLWindowState = false

ig3d_SetupWindowVisibility_b(showGLWindowState)
gFullscreen = getSceneInfo(IG3D_FULLSCREEN)
setSceneInfo(IG3D_FULLSCREEN, false) 

old_func=game_func

function levelspick_func()
fltk_update()
setSceneInfo(IG3D_MOUSE_VIEW, false, 1)
end
game_func=levelspick_func
function LevelsPickclose(w)
game_func=old_func
setSceneInfo(IG3D_FULLSCREEN, gFullscreen) 
showGLWindowState=true
ig3d_SetupWindowVisibility_b(showGLWindowState)
if w ~= nil then
w:hide()
w=nil
end
end
Q='"'

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
						print("UDG/"..v,"level stat")
						
					
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




function fill_udgLevelsBrowser()
--udgLevelsBrowser:clear()

for i = 1,#UDG_EasyLevelsTable,1 do
easyLevelsBrowser:add(UDG_EasyLevelsTable[i][2])
end

for i = 1,#UDG_ChallengeLevelsTable,1 do
challengeLevelsBrowser:add(UDG_ChallengeLevelsTable[i][2])
end


end

function easyLevelsBrowserCB(w)
if w:value() == nil or w:value() == 0 then return end
gUDG_PickedLevel = "Data/Levels/"..UDG_EasyLevelsTable[w:value()][1]
end

function challengeLevelsBrowserCB(w)
if w:value() == nil or w:value() == 0 then return end
gUDG_PickedLevel = "Data/Levels/"..UDG_ChallengeLevelsTable[w:value()][1]
end
-- closeUDGLevelsPick "DONE BUTTON"

function closeUDGLevelsPick()
if showGLWindowState == true then 
local l,t,r,b = ig3d_GetWindowBounds__4i() 
		cfile=io.open(getSceneInfo(IG3D_ROOT).."Data/Levels/UDG/UDG_Prefs/UDG_ScreenRes.lua","w")
		local sout="ig3d_SetWindowBounds_4i("..l..","..t..","..r..","..b..")\n"
		sout=sout.."table.insert(resolutionLevelsPick,{"..l..","..t..","..r..","..b.."})\n"
		cfile:write(sout)
		cfile:close()	
		fltk_update()	
		
		
end
showGLWindowState=true
setSceneInfo(IG3D_FULLSCREEN, gFullscreen) 
ig3d_SetupWindowVisibility_b(true)

UDG_LevelsPickWindow:redraw()

if UDG_LevelsPickWindow ~= nil then
UDG_LevelsPickWindow:hide()
UDG_LevelsPickWindow=nil
end

game_func=fltk_update --dont do mess with text boxes
if udg_all_sounds_stop then udg_all_sounds_stop() end
coll_o_m=nil
coll_o_p=nil
coll_o_o=nil
coll_p_m=nil
gUDGMusic=nil
gUDGMusicAction=nil

loadLevel(gUDG_PickedLevel)
end
--showGLWindow
function showGLWindow()
showGLWindowState= not showGLWindowState 
ig3d_SetupWindowVisibility_b(showGLWindowState)
end
do UDG_LevelsPickWindow= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Unlocked Levels")
UDG_LevelsPickWindow:label(gLabelTable[#gLabelTable])
UDG_LevelsPickWindow:callback(LevelsPickclose)
UDG_LevelsPickWindow:resize(608,301,260,323)
--UDG_LevelsPickWindow:show()
do UDG_LevelsPickdoneButton= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Done")
UDG_LevelsPickdoneButton:label(gLabelTable[#gLabelTable])
UDG_LevelsPickdoneButton:callback(closeUDGLevelsPick)
UDG_LevelsPickdoneButton:resize(10,290,225,25)
UDG_LevelsPickdoneButton:align(16)
UDG_LevelsPickdoneButton:when(6)
end

do widget= fltk:Fl_Group(0,0,0,0,"")
widget:resize(2,3,245,279)
do UDG_LevelsPickTabs= fltk:Fl_Tabs(0,0,0,0,"")
UDG_LevelsPickTabs:resize(10,3,235,279)
UDG_LevelsPickTabs:labelsize(12)
do EasyGroup= fltk:Fl_Group(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Easy")
EasyGroup:label(gLabelTable[#gLabelTable])
EasyGroup:resize(12,32,230,249)
EasyGroup:labelsize(11)
EasyGroup:align(0)
do easyLevelsBrowser= fltk:Fl_Browser(0,0,0,0,"")
easyLevelsBrowser:callback(easyLevelsBrowserCB)
easyLevelsBrowser:resize(12,34,228,245)
easyLevelsBrowser:type(2)
easyLevelsBrowser:labelsize(11)
easyLevelsBrowser:textsize(11)
end
Fl_Group:current(Fl_Group:current():parent())
end

do ChallengeGroup= fltk:Fl_Group(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Difficult")
ChallengeGroup:label(gLabelTable[#gLabelTable])
ChallengeGroup:resize(10,32,233,250)
ChallengeGroup:labelsize(11)
ChallengeGroup:align(0)
--unknown attribute: hide
do challengeLevelsBrowser= fltk:Fl_Browser(0,0,0,0,"")
challengeLevelsBrowser:callback(challengeLevelsBrowserCB)
challengeLevelsBrowser:resize(11,37,228,245)
challengeLevelsBrowser:type(2)
challengeLevelsBrowser:labelsize(11)
challengeLevelsBrowser:textsize(11)
end
Fl_Group:current(Fl_Group:current():parent())
end
end
Fl_Group:current(Fl_Group:current():parent())
end
end
UDG_LevelsPickWindow:show()

UDG_LevelsPickWindow:show()
udg_listLevels()

fill_udgLevelsBrowser()
UDG_LevelsPickWindow:redraw()
fltk_update()
--end
Fl:run()
