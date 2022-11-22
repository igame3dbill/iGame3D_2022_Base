--function make_window()
gFullscreen = getSceneInfo(IG3D_FULLSCREEN) 
setSceneInfo(IG3D_FULLSCREEN, false) 


function optionsclose(w)
game_func=old_func
showGLWindowState=true
setSceneInfo(IG3D_FULLSCREEN, gFullscreen) 
ig3d_SetupWindowVisibility_b(showGLWindowState)
w:hide()
w=nil
end
-- prefs will be overridden if the dofile exists.
UDG_LevelsTable={
{"UDG/UDG_IntroCredits","Intro"},
{"UDG/UDG_LivingInn","Living Inn"},
{"UDG/UDG_PonchoCo","Poncho Co"},
{"UDG/UDG_Gauntlet","The Gauntlet"},
{"UDG/UDG_SnipersAlley","The Alley"}
}




--resolutionOptions
resolutionOptions={
{380,320},
{640,480},
{800,600},
{1024,640},
{1024,768},
{1152,720},
{1440,900}
}

-- udg_AudioVideoOptions & udg_ControlsSettings
udg_AudioVideoOptions={
{"Shadows","YES"},
{"Clouds","YES"},
{"Particle effects","YES"},
{"High quality models","YES"},
{"Sound effects","YES"},
{"Music","YES"}
}
udg_ControlsSettings={
{"Foward","w"},
{"Back","s"},
{"Zombie Fall","f"},
{"Zombie Rush","r"},
{"Strafe left","a"},
{"Strafe right","d"},
{"Mouse Sensitivity","7"}
}
local globalsfile =gameroot.."Data/Levels/UDG/UDG_Prefs/UDG_Prefs_Globals.lua"




--local f = io.open(globalsfile,"r")
 dofile(globalsfile) 
 --io.close(f)
gMouseSpeed=udg_ControlsSettings[#udg_ControlsSettings][2]

Q='"'
if UDG_OptionsWindow ~= nil then
UDG_OptionsWindow:hide()
UDG_OptionsWindow=nil
end
gUDG_PickedLevel = "Data/Levels/UDG/UDG_IntroCredits"

gMouseMin=1
gMouseMax=10

showGLWindowState = false
ig3d_SetupWindowVisibility_b(showGLWindowState)
-- udg_listLevels
function udg_listLevels()
UDG_LevelsTable={}
udgPath=gameroot.."Data/Levels/UDG/"
folderList=ListFolder(udgPath,"t")
local levelslist=""
	for i,v in pairs(folderList) do 
	listedFiles=listFiles(udgPath ..v)
		for ii,vv in pairs(listedFiles) do
		--print(ii,vv)
		if vv ~= nil then 
			if string.find(vv,"load script.lua") ~= nil then
			local levelshortname = string.sub(v,string.find(v,"UDG_")+4,-1)
			table.insert(UDG_LevelsTable,{"UDG/"..v, levelshortname})
			levelslist=levelslist..levelshortname.."\n"
			break
			end
			end
		end
	end
	return levelslist
end


--see duplicated in UDG_Utilities.lua for function overwriting UDG_LevelsTable
udg_listLevels()
function fill_udgLevelsBrowser()
udgLevelsBrowser:clear()

for i = 1,#UDG_LevelsTable,1 do
udgLevelsBrowser:add(UDG_LevelsTable[i][2])
end
end

function udgLevelsBrowserCB(w)
if w:value() == nil or w:value() == 0 then return end
gUDG_PickedLevel = "Data/Levels/"..UDG_LevelsTable[w:value()][1]
end
-- closeUDGOptions "DONE BUTTON"

function closeUDGOptions()




if showGLWindowState == true then 
local l,t,r,b = ig3d_GetWindowBounds__4i() 
		cfile=io.open(getSceneInfo(IG3D_ROOT).."Data/Levels/UDG/UDG_Prefs/UDG_ScreenRes.lua","w")
		local sout="ig3d_SetWindowBounds_4i("..l..","..t..","..r..","..b..")\n"
		sout=sout.."table.insert(resolutionOptions,{"..l..","..t..","..r..","..b.."})\n"
		cfile:write(sout)
		cfile:close()	
		fltk_update()	
		
		
end

showGLWindowState=true
setSceneInfo(IG3D_FULLSCREEN, gFullscreen) 
ig3d_SetupWindowVisibility_b(true)

UDG_OptionsWindow:redraw()

if UDG_OptionsWindow ~= nil then
UDG_OptionsWindow:hide()
UDG_OptionsWindow=nil
end
game_func=fltk_update --dont do mess with text boxes

loadLevel(gUDG_PickedLevel)

end
-- fill_browsers
function fill_resolutionBrowser(n)
resolutionBrowser:clear()
for i = 1,#resolutionOptions,1 do 
resolutionBrowser:add(resolutionOptions[i][1].." x "..resolutionOptions[i][2])
end
if n ~= nil then 
resolutionBrowser:select(n)
resolutionBrowser:selected(n)
resolutionBrowser:value(n)
end
end

function fill_videoOptionsBrowsers()
videoOptionsListBrowser:clear()
videoOptionsStateBrowser:clear()
for i = 1,#udg_AudioVideoOptions,1 do
videoOptionsListBrowser:add(udg_AudioVideoOptions[i][1])
videoOptionsStateBrowser:add(udg_AudioVideoOptions[i][2])
UDG_OptionsWindow:redraw()
fltk_update()
end
end


function fill_controlsBrowser()
controlsOptionsListBrowser:clear()
controlsOptionsStateBrowser:clear()
for i = 1,#udg_ControlsSettings-1,1 do
controlsOptionsListBrowser:add(udg_ControlsSettings[i][1])
controlsOptionsStateBrowser:add(udg_ControlsSettings[i][2])
UDG_OptionsWindow:redraw()
fltk_update()
end
end
-- resolutionBrowserCB

function resolutionBrowserCB(w)
 if w:value() == nil then return end
local sx=resolutionOptions[w:value()][1]
local sy=resolutionOptions[w:value()][2]
dofile(getSceneInfo(IG3D_ROOT).."Data/Levels/UDG/UDG_Prefs/UDG_ScreenRes.lua")
	local l,t,r,b = ig3d_GetWindowBounds__4i() 
ig3d_SetWindowBounds_4i(l, t, l+sx, t+sy)
local l,t,r,b = ig3d_GetWindowBounds__4i() 
	
		cfile=io.open(getSceneInfo(IG3D_ROOT).."Data/Levels/UDG/UDG_Prefs/UDG_ScreenRes.lua","w")
		local sout="ig3d_SetWindowBounds_4i("..l..","..t..","..r..","..b..")\n"
		cfile:write(sout)
		cfile:close()	
		fltk_update()		
end
-- videoOptionsBrowserCB
function videoOptionsBrowserCB(w)
if w:value() == nil or w:value() == 0 then return end
local n = w:value()

if udg_AudioVideoOptions[n][2] == "YES" then
udg_AudioVideoOptions[n][2]="NO"
else
udg_AudioVideoOptions[n][2]="YES"
end
local s =""
videoOptionsStateBrowser:clear()
videoOptionsListBrowser:clear()
for i = 1,#udg_AudioVideoOptions,1 do
print(i)
videoOptionsListBrowser:add(udg_AudioVideoOptions[i][1])
videoOptionsStateBrowser:add(udg_AudioVideoOptions[i][2])
s=s.."{"..Q..udg_AudioVideoOptions[i][1]..Q..","..Q..udg_AudioVideoOptions[i][2]..Q.."},\n"
end

videoOptionsListBrowser:select(n)
videoOptionsStateBrowser:select(n)
videoOptionsListBrowser:value(n)
videoOptionsStateBrowser:value(n)
videoOptionsListBrowser:selected(n)
videoOptionsStateBrowser:selected(n)
UDG_OptionsWindow:redraw()
fltk_update()
sout="udg_AudioVideoOptions={"..string.sub(s,1,-3).."}"
cfile=io.open(getSceneInfo(IG3D_ROOT).."Data/Levels/UDG/UDG_Prefs/UDG_AudioVideoOptions.lua","w")
		cfile:write(sout)
		cfile:close()	
		fltk_update()

end
-- controlsOptionsUpdate
function controlsOptionsUpdate(n)
local s =""

if  n~=nil and n ~= 0  then 
controlsOptionsStateBrowser:clear()
controlsOptionsListBrowser:clear()
for i = 1,#udg_ControlsSettings-1,1 do
controlsOptionsListBrowser:add(udg_ControlsSettings[i][1])
controlsOptionsStateBrowser:add(udg_ControlsSettings[i][2])
end
controlsOptionsListBrowser:select(n)
controlsOptionsStateBrowser:select(n)
controlsOptionsListBrowser:value(n)
controlsOptionsStateBrowser:value(n)
controlsOptionsListBrowser:selected(n)
controlsOptionsStateBrowser:selected(n)
keyInputFld:value(udg_ControlsSettings[n][2])
keyInputFld:show()
keyInputFld:take_focus()
end

UDG_OptionsWindow:redraw()
fltk_update()


for i = 1,#udg_ControlsSettings,1 do
s=s.."{"..Q..udg_ControlsSettings[i][1]..Q..","..Q..udg_ControlsSettings[i][2]..Q.."},\n"
end
sout="udg_ControlsSettings={"..string.sub(s,1,-3).."}"
cfile=io.open(getSceneInfo(IG3D_ROOT).."Data/Levels/UDG/UDG_Prefs/UDG_ControlsPrefs.lua","w")
		cfile:write(sout)
		cfile:close()	
		fltk_update()
end



function keyInputFldCB(w)
local n=controlsOptionsStateBrowser:value()
if w:value() ~= nil then
local k = string.sub(w:value(),-1,-1)

udg_ControlsSettings[n][2]= k
end

controlsOptionsUpdate(n)
end

function controlsOptionsBrowserCB(w)
if w:value() == nil or w:value() == 0 then return end
local n = w:value()
controlsOptionsUpdate(n)
end
-- mouseSenseRollerCB
function mouseSenseRollerCB(w)
if w:value()==nil then return end
w:label(w:value())
w:redraw()
fltk_update()
gMouseSpeed=w:value()
udg_ControlsSettings[#udg_ControlsSettings][2] = gMouseSpeed
controlsOptionsUpdate()
end
--showGLWindow
function showGLWindow()
showGLWindowState= not showGLWindowState 
ig3d_SetupWindowVisibility_b(showGLWindowState)
end
--reset game_func
old_func=game_func

function udg_options_func()
setSceneInfo(IG3D_MOUSE_VIEW, false, 1)
fltk_update()
end

game_func=udg_options_func
do UDG_OptionsWindow= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "uDeadGame Options")
UDG_OptionsWindow:label(gLabelTable[#gLabelTable])
UDG_OptionsWindow:callback(optionsclose)
UDG_OptionsWindow:resize(359,270,257,267)
--UDG_OptionsWindow:show()
do UDG_OptionsdoneButton= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Done")
UDG_OptionsdoneButton:label(gLabelTable[#gLabelTable])
UDG_OptionsdoneButton:callback(closeUDGOptions)
UDG_OptionsdoneButton:resize(15,240,225,25)
UDG_OptionsdoneButton:align(16)
UDG_OptionsdoneButton:when(6)
end

do widget= fltk:Fl_Group(0,0,0,0,"")
widget:resize(2,3,245,232)
do UDG_OptionsTabs= fltk:Fl_Tabs(0,0,0,0,"")
UDG_OptionsTabs:resize(10,3,235,232)
UDG_OptionsTabs:labelsize(12)
do LevelsGroup= fltk:Fl_Group(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Levels")
LevelsGroup:label(gLabelTable[#gLabelTable])
LevelsGroup:resize(15,49,225,181)
LevelsGroup:labelsize(11)
LevelsGroup:align(0)
do udgLevelsBrowser= fltk:Fl_Browser(0,0,0,0,"")
udgLevelsBrowser:callback(udgLevelsBrowserCB)
udgLevelsBrowser:resize(15,54,225,176)
udgLevelsBrowser:type(2)
udgLevelsBrowser:labelsize(11)
udgLevelsBrowser:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do VideoGroup= fltk:Fl_Group(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Video")
VideoGroup:label(gLabelTable[#gLabelTable])
VideoGroup:resize(15,41,225,181)
VideoGroup:labelsize(11)
--unknown attribute: hide
do resolutionBrowser= fltk:Fl_Browser(0,0,0,0,"")
resolutionBrowser:callback(resolutionBrowserCB)
resolutionBrowser:resize(15,46,70,125)
resolutionBrowser:type(2)
resolutionBrowser:labelsize(11)
resolutionBrowser:textsize(10)
--unknown attribute: hide
end

do videoOptionsListBrowser= fltk:Fl_Browser(0,0,0,0,"")
videoOptionsListBrowser:callback(videoOptionsBrowserCB)
videoOptionsListBrowser:resize(85,46,105,125)
videoOptionsListBrowser:type(2)
videoOptionsListBrowser:labelsize(11)
videoOptionsListBrowser:textsize(10)
--unknown attribute: hide
end

do videoOptionsStateBrowser= fltk:Fl_Browser(0,0,0,0,"")
videoOptionsStateBrowser:callback(videoOptionsBrowserCB)
videoOptionsStateBrowser:resize(190,46,44,125)
videoOptionsStateBrowser:type(2)
videoOptionsStateBrowser:labelsize(11)
videoOptionsStateBrowser:textsize(10)
--unknown attribute: hide
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Show Window\nand\n Set Manually")
widget:label(gLabelTable[#gLabelTable])
widget:callback(showGLWindow)
widget:resize(15,176,75,39)
widget:labelsize(9)
--unknown attribute: hide
end
Fl_Group:current(Fl_Group:current():parent())
end

do ControlsGroup= fltk:Fl_Group(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Keys")
ControlsGroup:label(gLabelTable[#gLabelTable])
ControlsGroup:resize(10,43,235,192)
ControlsGroup:labelsize(11)
ControlsGroup:align(0)
--unknown attribute: hide
do controlsOptionsListBrowser= fltk:Fl_Browser(0,0,0,0,"")
controlsOptionsListBrowser:callback(controlsOptionsBrowserCB)
controlsOptionsListBrowser:resize(15,46,105,126)
controlsOptionsListBrowser:type(2)
controlsOptionsListBrowser:labelsize(11)
controlsOptionsListBrowser:textsize(11)
end

do controlsOptionsStateBrowser= fltk:Fl_Browser(0,0,0,0,"")
controlsOptionsStateBrowser:callback(controlsOptionsBrowserCB)
controlsOptionsStateBrowser:resize(120,46,40,126)
controlsOptionsStateBrowser:type(2)
controlsOptionsStateBrowser:labelsize(11)
controlsOptionsStateBrowser:textsize(11)
end

do keyInputFld= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Press Key \n to change")
keyInputFld:label(gLabelTable[#gLabelTable])
keyInputFld:callback(keyInputFldCB)
keyInputFld:resize(165,100,65,21)
keyInputFld:labelsize(9)
keyInputFld:align(1)
keyInputFld:when(1)
keyInputFld:textsize(12)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Fullscreen:  Cmd + F \n Pause:  Cmd + P \n Quit:  Cmd + Q")
widget:label(gLabelTable[#gLabelTable])
widget:resize(25,176,215,55)
widget:box(fltk.FL_NO_BOX)
widget:labelsize(11)
widget:when(2)
end
Fl_Group:current(Fl_Group:current():parent())
end

do MouseSenseGroup= fltk:Fl_Group(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Mouse")
MouseSenseGroup:label(gLabelTable[#gLabelTable])
MouseSenseGroup:resize(20,47,220,81)
MouseSenseGroup:labelsize(10)
--unknown attribute: hide
do mouseSenseRoller= fltk:Fl_Slider(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "5")
mouseSenseRoller:label(gLabelTable[#gLabelTable])
mouseSenseRoller:callback(mouseSenseRollerCB)
mouseSenseRoller:resize(25,87,205,20)
mouseSenseRoller:type(1)
mouseSenseRoller:minimum(1)
mouseSenseRoller:maximum(10)
mouseSenseRoller:step(1)
mouseSenseRoller:value(5)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Adjust Mouse Sensitivity")
widget:label(gLabelTable[#gLabelTable])
widget:resize(20,47,215,23)
widget:box(fltk.FL_NO_BOX)
widget:labelsize(11)
widget:when(2)
end
Fl_Group:current(Fl_Group:current():parent())
end
end
Fl_Group:current(Fl_Group:current():parent())
end
end
UDG_OptionsWindow:show()

fill_resolutionBrowser()
fill_controlsBrowser()
fill_videoOptionsBrowsers()
keyInputFld:hide()
fill_udgLevelsBrowser()
UDG_OptionsWindow:redraw()
fltk_update()
--end
Fl:run()
