function trigger_load_instructions()
	loadLevel("Data/Levels/UDG/UDG_Instructions")
end



function trigger_load_currentlevel()
	--
	if #gMenuButtonsText <= 2 then
		loadLevel(gCurrentLevel)
	else
		trigger_show_level_list()
	end
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

gOnlyOneAllowedMaterial=nil
gOldSelectedMenuMaterial=nil
gPicked=false
gButtonMaterialNames={"Tutorial","Play","Exit"}
gButtonTriggerFunctions={trigger_load_instructions, trigger_load_currentlevel, quit}

tmp=get(ig3d_object, "udgmainmenu1")
if not tmp then
	print("Missing udgmainmenu1 object")
	gMenuButtons=nil
else
	gMenuButtons=gObjects[get(ig3d_object, "udgmainmenu1")]
	menuTeam=17
	gMenuButtons.team=menuTeam
	if ig3d_GetLevelName__s()~="Data/Levels/UDG/UDG_MainMenu" then
		gButtonMaterialNames={"Continue","Restart","Controls","Menu"}
		gButtonTriggerFunctions={trigger_continue, trigger_restart, trigger_controls, trigger_menu}
		setObjectInfo(gMenuButtons.cObj, IG3D_MODEL, "Misc/udggamemenu.wtf")
		setObjectInfo(gMenuButtons.cObj, IG3D_HUD, true)
		setObjectInfo(gMenuButtons.cObj, IG3D_POSITION, 0,0,-10)
	end
end



function udg_mouse_and_buttons()
	setSceneInfo(IG3D_MOUSE_VIEW, false, 1)
	if gOldSelectedMenuMaterial then setMaterialInfo(gOldSelectedMenuMaterial, IG3D_UV_TRANSFORMATION, 0,0,0,1,1,0,0) end

	if ig3d_GetLevelName__s()~="Data/Levels/UDG/UDG_MainMenu" and gMenuButtons.mayReposition then
			a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44=getCameraInfo(IG3D_ROTATION_MATRIX)
			setObjectInfo(gMenuButtons.cObj, IG3D_POSITION, a41+a31*0.05, a42+a32*0.05,a43+a33*0.05)
			setObjectInfo(gMenuButtons.cObj, IG3D_ROTATION, dirToAngles(-a31,-a32,-a33))
			setText_boxInfo(3, IG3D_TEXT, "")
	end
	

	local ax,ay,az,bx,by,bz=getSceneInfo(IG3D_MOUSE_LINE)
	local c,x,y,z,o=lineCollision(ax,ay,az, bx,by,bz)
	if c==2 then
		if o==gMenuButtons then
			result,x,y,z,u,v,gOldSelectedMenuMaterial,nx,ny,nz=getObjectInfo(gMenuButtons.cObj, IG3D_EXACT_COLLISION_DATA, ax,ay,az, bx,by,bz)
		
			if result then
				if not gOnlyOneAllowedMaterial then setMaterialInfo(gOldSelectedMenuMaterial, IG3D_UV_TRANSFORMATION, 0,0,0,1,1,0.25,0) end
		
				if click("n") then
					gOnlyOneAllowedMaterial=gOldSelectedMenuMaterial
					gPicked=true
				end
		
				if click("o") then
					setMaterialInfo(gOldSelectedMenuMaterial, IG3D_UV_TRANSFORMATION, 0,0,0,1,1,0.75,0)
					render()
					local clickedButton=getMaterialInfo(gOldSelectedMenuMaterial, IG3D_NAME)
					local i
					for i=1,#gButtonMaterialNames,1 do
						if clickedButton==gButtonMaterialNames[i] then
							gButtonTriggerFunctions[i]()
							break
						end
					end
				end
		
			
				if click("-") and gOldSelectedMenuMaterial== gOnlyOneAllowedMaterial then
					setMaterialInfo(gOldSelectedMenuMaterial, IG3D_UV_TRANSFORMATION, 0,0,0,1,1,0.5,0)
				end
			end
		end
	end
	
		if   key(311,"-")  or key(462,"-")  then 
	 if key("o","n") then
	--setSceneInfo(IG3D_FULLSCREEN, false)
	dofile(gameroot.."Data/Fluid/UDG_LevelsPick/UDG_LevelsPick.fl")
	end
	end
	
	if click("o") then
		gOnlyOneAllowedMaterial=nil
	end
	
	
	if ig3d_GetLevelName__s()~="Data/Levels/UDG/UDG_MainMenu" then
		if key(27,"n") then
			trigger_continue()
		end
	else

		if not gUDGMusic then gUDGMusic=gSoundEmitters[1] end
		setSound_emitterInfo(gUDGMusic, IG3D_POSITION, getCameraInfo(IG3D_POSITION))
		if getSound_emitterInfo(gUDGMusic, IG3D_STOP) then
			setSound_emitterInfo(gUDGMusic, IG3D_VOLUME, 40)
			setSound_emitterInfo(gUDGMusic, IG3D_SAMPLE, "Data/Sounds/drivingrock.ogg")
			setSound_emitterInfo(gUDGMusic, IG3D_START)
		end
	end

	fltk_update()
end