
-- iGame3D UI MAIN TOOLS FUNCTIONS APRIL 2009

-- Main Tools Click -- buttons
function MainToolsClick(w)
buttonID = w:label();
if Fl:event_key() == 32 then return end
if oldButton == nil then oldButton = w end
if oldButton ~= w then 
	oldButton:value(0)
	oldButton = w
	end
	w:value(1)
--Camera	
print(buttonID)
if buttonID=="edit_fluid" then
gLastMenuPick="Fluid"
UniversalBrowserShow()
end
if buttonID == "edit_camera" then lookbutton()
--Quad View
elseif buttonID == "edit_viewsquad" then toggleQuadView()
--Entity
elseif buttonID == "edit_entities" then 
if ModelsBrowser ~= nil then 
	ModelsBrowser:hide()
	ModelsBrowser = nil
	else
	editingModeSwitch("select_entity")
	OPEN_UI_WINDOWS("ModelsBrowser")
	end

--Lua Editor
elseif buttonID == "edit_lua" then openfile("load script")
--Lights
elseif buttonID == "edit_lights" then 
if lightswindow ~= nil then
		lightswindow:hide()
		lightswindow = nil
		else
		editingModeSwitch("select_entity")
		OPEN_UI_WINDOWS("Lights")	
		end
--Colors
elseif buttonID == "edit_colors" then
	if colorswindow ~= nil then
		colorswindow:hide()
		colorswindow  = nil
		else
		OPEN_UI_WINDOWS("Colors")	
		end
--Console		
	elseif buttonID == "edit_console" then 
		if console ~= nil then
		console:hide()
		console = nil 
		else
		OPEN_UI_WINDOWS("console")	
		end
--Entity Drop		
	elseif buttonID == "edit_entitydrop" then
		if WTFBrowserNew ~= nil then
			WTFBrowserNew:hide()
				WTFBrowserNew = nil
				else
				editingModeSwitch("select_entity")
					OPEN_UI_WINDOWS("WTFbrowser")	
			
				end
-- Mesh
	elseif buttonID == "edit_mesh" then
	if  mesheditor then
	mesheditor:hide()
	mesheditor=nil
	else
		OPEN_UI_WINDOWS("mesh_editor")	
	end
-- edit ZGS
		elseif buttonID == "edit_zgs" then
	if ZGS_Maker then
	 ZGS_Maker:hide()
	 ZGS_Maker=nil
		else
		OPEN_UI_WINDOWS("UDG_Options")	
		end
-- edit Particles
elseif buttonID == "edit_particles" then 
if ParticleBrowser ~= nil then
		EmitBrowserValueCatch()
		ParticleBrowser:hide()
		ParticleBrowser = nil
		else
	OPEN_UI_WINDOWS("ParticleBrowser")		
		ParticleBrowser:make_current()
		end -- particles		
elseif buttonID == "edit_text" then
		if TextboxBrowser ~= nil then
		TextboxBrowser:hide()
		TextboxBrowser = nil
		else
		OPEN_UI_WINDOWS("TextboxBrowser")		
		TextboxBrowser:make_current()
		listTextBoxes()
		end --  textboxbrowser
				
			fltk_update()	
end -- of  buttonID 

end --MainToolsClick

-- UI_MAINTOOLS_WINDOW
iconFiles={}
iconPath=getSceneInfo(IG3D_ROOT).."Data/Icons/"
toolButton={}
toolButton.button={}
toolButton.file={}

-- iGAME3D MAIN TOOLS WINDOW INIT APRIL 2009
function UI_MAINTOOLS_WINDOW()
if gNativeOS=="iphone" then return end
local i=1
local c=5
local r=31
local iconPath=getSceneInfo(IG3D_ROOT).."Data/Icons/MainTools/"
do UIMainTools= fltk:Fl_Double_Window(10,10,466,166,"")
UIMainTools:label("UI MAIN TOOLS")
UIMainTools:callback(UIMainToolsCB)
UIMainTools:when(2)
UIMainTools:size_range(100,100,1024,1024)
do buttonGroup= fltk:Fl_Group(5,5,266,266,"") 
for file in lfs.dir(iconPath) do
local ext=string.sub(file,-3,-1) 
if string.sub(file, 1, 1) ~= "." and file ~= nil and ext=="png" then 
ef=string.sub(file,1,string.len(file)-4)
iconFiles[i]=ef
if c<=4 then c=5 end
if r<=4 then r=5 end
if c >= UIMainTools:w()-24 then 
c=5
r=r+26
end --ifc
do w = fltk:Fl_Button(c,r,24,24,"")
toolButton.button[i]=w
w:box(fltk.FL_THIN_UP_BOX)
w:down_box(fltk.FL_BORDER_BOX)
toolButton.file[i]=iconPath..file 
local buttonID = string.gsub(file,".png","")
w:label(buttonID)
w:labelsize(1)
w:callback(MainToolsClick)
w:tooltip(buttonID)
fltk.fl_register_images()
imageFile = Fl_Shared_Image.get(toolButton.file[i])
--print(toolButton.file[i])
w:resize(c,r,24,24);
w:image(imageFile,24,24)
w:image(imageFile);
w:redraw();
Fl_Group:current(Fl_Group:current():parent())
end --dobutton
c=c+26
i=i+1
end --ifstring
end --forfile
Fl_Group:current(Fl_Group:current():parent())
end -- buttongroup
buttonGroup:resize(5,31,c+24,r+24)
UIMainTools:resize(10,10,c+24,r+24)
do menuBar= fltk:Fl_Menu_Bar(0,0,0,0,"")
menuBar:callback(main_menu_callback)
menuBar:resize(0,0,680,30)
menuBar:labelsize(10)
menuBar:textsize(11)
Fl_Group:current(Fl_Group:current():parent())
end --menubar
end --dowindow
UIMainTools:show();
Fl:scheme("plastic");
UIMainTools:make_current();
fixIcons();
menuBar:global();
FillMenuBar(); --see main_menu.lua
UIMainToolsCB();
end --setupIcons


--iGame3D Default User Interface
--see copy at Data/Fluid/UI_MAIN_TOOLS/UI_MAIN_TOOLS.fl

-- wButtonProperties
function wButtonProperties(w)
local wimage=w:image()
local isw=w:image():w()
local ish=w:image():h()
local n=w:label()
local x=w:x()
local y=w:y()
local height=w:h()
local width=w:w()
end

-- fix Icons
function fixIcons()
local sw=UIMainTools:w()
local sh=UIMainTools:h()
local sx=UIMainTools:x()
local sy=UIMainTools:y()
local x=5
local y=31
for i=1,#toolButton.button,1 do
local w=toolButton.button[i]
local wimage=w:image()
local isw=w:image():w()
local ish=w:image():h()
local n=w:label()
if isw >= 23 or ish  >= 23 then 
w:image(w:image():copy(22,22));
end
if x>=sw-23 then x=5 
y=y+24 
end
w:resize(x,y,24,24);
w:redraw();
srh=y+32
x=x+24
end
menuBar:resize(0,0,UIMainTools:w(),30)
menuBar:redraw();
if srh>sh then UIMainTools:resize(sx,sy,sw,srh) end
UIMainTools:redraw();
end

-- UIMainToolsCB  
function UIMainToolsCB(w)
resetFunctions()
UIMainTools:make_current();
fixIcons()
screen_x= Fl:event_x()
screen_y = Fl:event_y()
	if gEditingMode == "edit_entitydrop" then
	collideWithScene = false
	dropatx, dropaty, dropatz = ig3d_Get3DPositionFrom2DCoordinates_2ib_3f(screen_x, screen_y, collideWithScene)
end
allup();
	fltk_update();
 if oldgame~=nil then oldgame() end
end
-- store old game func
oldgame=game_func

function showDefaultTools()
oldgame=game_func
UI_MAINTOOLS_WINDOW();
ig3d_RebuildMacMenubar();
end
