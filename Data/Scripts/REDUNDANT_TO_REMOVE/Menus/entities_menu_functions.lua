-- FILL THE EDIT MENU
entityMenuText={"camera","colors","lights","groups","mesh","models","particles","paths","scene","sounds","script","text","view",}
function fill_EntityMenu()
n=menuIndexCount+3
mainMenuIndex[n]="Entity"
for i=1,#entityMenuText,1 do
n=n+1
menuLine="Entity/"..entityMenuText[i]
menuBar:add(menuLine);
mainMenuIndex[n]=menuLine
end
menuIndexCount=n
end

-- entity Menu Pick
function entityMenuPick(tPick)

local xPick=item(-2,tPick,"/")
local yPick=item(-1,tPick,"/")
local mPick=xPick.."/"..yPick
local tTitle=xPick.." "..yPick
local tDir=gameroot.."Data/"
local tFile="empty"
 
print("mPick="..mPick)
	if yPick == "models" then 
		if ModelsBrowser ~= nil then 
		ModelsBrowser:hide()
		ModelsBrowser = nil
		end
		editingModeSwitch("select_entity")
		OPEN_UI_WINDOWS("ModelsBrowser")
		
		
		
		 elseif yPick == "camera" then
		if CameraBrowser ~= nil then
		CameraBrowser:hide()
		CameraBrowser = nil
		end
		OPEN_UI_WINDOWS("CameraBrowser")
		CameraBrowser:make_current()
		
		 --  CameraBrowser
		
	elseif yPick == "lights" then 
	if lightswindow ~= nil then
		lightswindow:hide()
		lightswindow = nil
		end
		editingModeSwitch("select_entity")
		OPEN_UI_WINDOWS("Lights")
		
	elseif yPick == "mesh" then
		if  mesheditor then
		mesheditor:hide()
		mesheditor=nil
		end
		OPEN_UI_WINDOWS("mesh_editor")
		 
	elseif yPick == "colors" then
	if colorswindow ~= nil then
		colorswindow:hide()
		colorswindow  = nil
		end
		OPEN_UI_WINDOWS("Colors")
		
		
	elseif yPick == "particles" then 
		if ParticleBrowser ~= nil then
		EmitBrowserValueCatch()
		ParticleBrowser:hide()
		ParticleBrowser = nil
		end
		OPEN_UI_WINDOWS("ParticleBrowser")
		ParticleBrowser:make_current()
		 -- particles
		 
		 elseif yPick == "text" then
		if TextboxBrowser ~= nil then
		TextboxBrowser:hide()
		TextboxBrowser = nil
		end
		OPEN_UI_WINDOWS("TextboxBrowser")
		TextboxBrowser:make_current()
		listTextBoxes()
		 --  textboxbrowser
		
		
	-- endif ypick
	end
	
	
end