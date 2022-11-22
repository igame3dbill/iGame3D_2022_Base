----------TOGGLE OBJECT EDITING WITH CONTROL KEY
gMouse=false
lookmode=false
gEditingMode="play"
gFourView=false
gViewX,gViewY,gViewZ=30,30,30

function escape_to(aLevel)
if aLevel==nil then aLevel=gTimedLevel end
if gTimedLevelLoad==true then   
if time() > gTimedLevelLoadTime then
	gTimedLevelLoad=false
	game_func=nil
	loadLevel(aLevel)
	return
end
end
end --end escape_to


function open_gui_keys()
char,code,name=input(false)
if key(311,"-") or key(462,"-") then
  if key("t","-") then OPEN_UI_WINDOWS("console")  ;-- see file_functions.lua
  elseif key("n","-") then OPEN_UI_WINDOWS("script_editor") 
  elseif key("m","-") then OPEN_UI_WINDOWS("mesh_editor") 
  end
end
end




function igame3d_controlkeys()

 open_gui_keys()
char,code,name=input(false)
--if name~=nil then print(name..","..char..","..code) end

--key ` to toggle lookaround and play modes
if key(385,"-") then EditLookToggle() end


-- CONTROL_KEY & COMMAND_KEY
 if gEditingMode ~= "play" then 
 		--BILL, this is ugly. Each press of spacebar in any text field toggles mouse view once mouse view has been used!!
		--if key(32,"n") then editingModeSwitch("lookaround") end
  end
  
--[[ key_311 = controlKey
     key_462 =commandKey ]]--
     
if key(311,"-") or key(462,"-") then	 
	
--if key("r","-") then escape_to("Data/Levels/default")  end
  if key("l","-") then editingModeSwitch("lookaround")  end
 
--Key 0
  if key(48,"n") then end
--1     
  if key(49,"n") then
  editingModeSwitch("select_entity")
  end 
--2
if key(50,"n") then editingModeSwitch("select_mesh") end

--[[3
if key(51,"n") then end
--4
if key(52,"n") then end
--5
if key(53,"n") then end
--6
if key(54,"n") then end
--7
if key(55,"n") then end
--8
if key(56,"n") then end
--9 
if key(57,"n") then end
]]--

--key_66 = B
if key(66,"n") then
  editingModeSwitch("bone_mode")
  gEditingMode="bone_mode"
  ig3d_SetMode_i(2) --bone mode
  end
  --key_11 = o
  if key(111,"n") then
  editingModeSwitch("select_entity")
    gLastMenuPick = "Levels"
  UniversalBrowse("Levels")
  end

--Cntrl/Cmnd SPACE BAR to activate four view 
--Spotlight took this control!!
if key(32,"-") then
 gFourView=not gFourView
       ig3d_SetFourViews_b(gFourView)
        end 
if key("e","-") then editingModeSwitch("select_entities") end

        end
        
end --control or command KeyDown

function adjustFontSize()
if key("]", "-")  then
FontSizeMod=FontSizeMod+0.1
elseif key("[", "-") then
FontSizeMod=FontSizeMod-0.1
end
end

function default_escapekey()
if gNativeOS=="iphone" then return end

char,code,name=input(false)
 --- SPACE KEY
 --- SHIFT KEY
	if char~= nil then
		if  name=="Escape" then
		EditModeToggle()
		--EditLookToggle()	
if gEditingMode ~= "play" then 
			if UIMainTools == nil then 
			OPEN_UI_WINDOWS("UIMainTools") 
			else
			UIMainTools:show();
			end
			end			
onClickBeep();
	end

igame3d_controlkeys()

end
ig3d_DrawGL();
fltk_update();
end



function drive_off(obj)
if key("w", "-") == true then
go(obj.cObj, passed() * 20)
end

if key("s", "-") == true then
go(obj.cObj, -passed() * 20)
end

if key("a", "-") == true then
setObjectInfo(obj.cObj, IG3D_TORQUE, 0,15,0)
else

if key("d", "-") == true then
setObjectInfo(obj.cObj, IG3D_TORQUE, 0,-15,0)
else
setObjectInfo(obj.cObj, IG3D_TORQUE, 0,0,0)
end
end
end --drive_off


---------------------------------------------------------
function WASD_pushObject(ObjectName)
if ObjectName==nil then
ObjectName=gObjects[1].cObj
end
a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(ObjectName, IG3D_ROTATION_MATRIX)
theTrick=0
downForce=0
frontForce=0


if key("w","-") then
frontForce=32
downForce=2
setObjectInfo(ObjectName, IG3D_OMEGA, 0)
theTrick=0
end

if key("r","-") then
frontForce=12
downForce=32
setObjectInfo(ObjectName, IG3D_OMEGA, 0)
theTrick=0
end

if key("s","-") then
downForce=2
frontForce=-32
setObjectInfo(ObjectName, IG3D_OMEGA, 0)
theTrick=0
end

if key("a","-") then
downForce=2
theTrick=16
end

if key("d", "-") then
theTrick=-16
downForce=2
end

setObjectInfo(ObjectName,IG3D_FORCE, a31*frontForce, a32*frontForce+downForce, a33*frontForce)
setObjectInfo(ObjectName,IG3D_TORQUE, a21*theTrick, a22*theTrick, a23*theTrick)
setObjectInfo(ObjectName,IG3D_VECTOR_CONSTRAINT, 0,1,0)
end



--  ig3d_SetMeshTool_i(1) --Line Tool
-- ig3d_SetMeshTool_i(3)  -- Vertex Tool
-- ig3d_SetMeshTool_i(4)  -- split-tool
 -- ig3d_SetMeshTool_i(5) -- break tool
 
--WAIT on terminal line input to act
 function LineInputLoop()
	local input
	local ps1 = ps1 or "> "
	while true do
		io.stdout:write(ps1)
		input =  io.stdin:read(); --LINE INPUT "", a$
		if not input then io.stdout:write('\n') return end
		 g = "some return values" ; -- or function etc 
		-- store the input   --table.insert(score["learnstrings"],input)
		-- write a file    --WriteTablesToFile()
	end
	return g
end







