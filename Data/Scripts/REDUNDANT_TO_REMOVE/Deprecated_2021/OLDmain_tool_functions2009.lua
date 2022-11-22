

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
--print(buttonID)


 
	
	
--Camera	
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
--Fluids
elseif buttonID == "edit_fluid" then openfile("Fluid")
--Lua Editor
elseif buttonID == "edit_lua" then openfile("load script")
--Lights
elseif buttonID == "edit_lights" then 
if lightswindow ~= nil then
		lightswindow:hide()
		lightswindow = nil
		else
		editingModeSwitch("select_entity")
		dofile(gameroot.."Data/Fluid/Lights/Lights.fl")
		end
--Colors
elseif buttonID == "edit_colors" then
	if colorswindow ~= nil then
		colorswindow:hide()
		colorswindow  = nil
		else
		dofile(gameroot.."Data/Fluid/Colors/Colors.fl")
		end
--Console		
	elseif buttonID == "edit_console" then 
		if console ~= nil then
		console:hide()
		console = nil 
		else
		dofile(gameroot.."Data/Fluid/console/console.fl")	
		end
--Entity Drop		
	elseif buttonID == "edit_entitydrop" then
		if WTFBrowserNew ~= nil then
			WTFBrowserNew:hide()
				WTFBrowserNew = nil
				else
				editingModeSwitch("select_entity")
				dofile(gameroot.."Data/Fluid/WTFbrowser/WTFbrowser.fl")
				end
-- Mesh
	elseif buttonID == "edit_mesh" then
	if  mesheditor then
	mesheditor:hide()
	mesheditor=nil
	else
	dofile(gameroot.."Data/Fluid/mesh_editor/mesh_editor.fl")
	end
-- edit ZGS
		elseif buttonID == "edit_zgs" then
	if ZGS_Maker then
	 ZGS_Maker:hide()
	 ZGS_Maker=nil
		else
		--dofile(gameroot.."Data/Fluid/ZGS_Maker/ZGS_Maker.fl")
		
		--dofile(gameroot.."Data/Fluid/RNDUDG/RNDUDG.fl")
		dofile(gameroot.."Data/Fluid/UDG_Options/UDG_Options.fl")
		end
-- edit Particles
elseif buttonID == "edit_particles" then 
if ParticleBrowser ~= nil then

		EmitBrowserValueCatch()
		ParticleBrowser:hide()
		ParticleBrowser = nil
		else
		--editingModeSwitch("select_entity")
	--	resetFunctions()
		dofile(gameroot.."Data/Fluid/ParticleBrowser/ParticleBrowser.fl")
		ParticleBrowser:make_current()
		end -- particles
		
elseif buttonID == "edit_text" then
		if TextboxBrowser ~= nil then
		TextboxBrowser:hide()
		TextboxBrowser = nil
		else
		dofile(gameroot.."Data/Fluid/TextboxBrowser/TextboxBrowser.fl")
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


function UI_MAINTOOLS_WINDOW()
local i=1
local c=5
local r=31
local iconPath=getSceneInfo(IG3D_ROOT).."Data/Icons/MainTools/"
do UIMainTools= fltk:Fl_Double_Window(100,100,466,166,"")
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
UIMainTools:resize(100,100,c+24,r+24)
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
FillMenuBar();
UIMainToolsCB();
end --setupIcons

