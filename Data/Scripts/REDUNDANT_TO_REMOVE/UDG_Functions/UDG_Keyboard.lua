-- RTS_Keyboard.lua
gTrackLightEnabled = false--true


function udg_escape_to_menu()

if gMenuButtons then
		if ig3d_GetLevelName__s()~="Data/Levels/UDG/UDG_MainMenu" then
			a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44=getCameraInfo(IG3D_ROTATION_MATRIX)
			setObjectInfo(gMenuButtons.cObj, IG3D_POSITION, a41+a31*0.05, a42+a32*0.05,a43+a33*0.05)
			setObjectInfo(gMenuButtons.cObj, IG3D_ROTATION, dirToAngles(-a31,-a32,-a33))
			setObjectInfo(gMenuButtons.cObj, IG3D_MASS, 0,0,0,0)
			setObjectInfo(gMenuButtons.cObj, IG3D_SIZE, 4.5,4.5,4.5)
			setObjectInfo(gMenuButtons.cObj, IG3D_COLL, true)
			setObjectInfo(gMenuButtons.cObj, IG3D_HUD, false)
			setObjectInfo(crosshair.cObj, IG3D_POSITION, 0,0,10)
		end
		setSceneInfo(IG3D_SPEED, 0)
		gMenuButtons.mayReposition=true
		game_func= udg_mouse_and_buttons
	end

end


function bulletTimeKey(tkey)
	if time()>=gSpeedResetTime then
		setSceneInfo(IG3D_SPEED, gOldGameSpeed)
		-- toggle freeze time slow mode
		if key(tkey,"n") then
			if getSceneInfo(IG3D_SPEED)>=1 then
				setSceneInfo(IG3D_SPEED, 0.1)
				gOldGameSpeed=0.1
			else
				setSceneInfo(IG3D_SPEED, 1)
				gOldGameSpeed=1
			end
		end
	end
end

function stopTimeKey(tkey)
		if key(tkey,"-") then setSceneInfo(IG3D_SPEED, 0.0001) end ;	
	end

	
	function udg_commandKeys()
	if key("o","n") then
	--setSceneInfo(IG3D_FULLSCREEN, false)
	dofile(gameroot.."Data/Fluid/UDG_LevelsPick/UDG_LevelsPick.fl")
	end
	
--default_escapekey()
	end
	
	

function udg_game_keyboard()
--CMD Or CNTRol O to open UDG_Options 	
if   key(311,"-")  or key(462,"-")  then 
udg_commandKeys()

return
end
if   key("l","n")   then gHideHUD = not gHideHUD end
-- keyboard time controls
bulletTimeKey("z") ; 
 -- tab key = 314, slows time to .00001
--stopTimeKey(314) ; 	
-- 		char,code,name=input(false)
-- 		if char~= nil then RTS_print(code) end;
	
if key("p","n") then
	gDebugOutput=not gDebugOutput
end

--toggle music
if key("m","n") then
	gMusicOn=not gMusicOn
	setSound_emitterInfo(gUDGMusic, IG3D_PAUSE, not gMusicOn)
	setSound_emitterInfo(gUDGMusicAction, IG3D_PAUSE, not gMusicOn)
end

--all rush



if key(314,"-") and gNumHumans>0 then
gCapsLockKey=true
	local sndPlayed=false
	for i=1,#gObjects,1 do
		if gObjects[i].team==1 and gObjects[i].alive and gObjects[i].task.id~=object_action_eat and gObjects[i].behaviour~=zombie_rush_behaviour and not gObjects[i].delayedRush then
			gObjects[i].delayedRush=time()+math.random()*0.5
		end
	end
	rts_update_living_and_dead_counts()
	else
	gCapsLockKey=false
end



local getcrosshair= get(ig3d_object,"crosshair1")
local m = get(ig3d_material, getcrosshair, 1)
	if  gHideHUD==true then
	setMaterialInfo(m, IG3D_DIFFUSE, 0,0,0,0)
	else
	setMaterialInfo(m, IG3D_DIFFUSE, 0,0,0,1.0)
	end


if key("r","n") and gNumHumans>0 then
	local sndPlayed=false
	for i=1,#gObjects,1 do
		if gObjects[i].team==1 and gObjects[i].alive and gObjects[i].task.id~=object_action_eat then
			gObjects[i].delayedRush=time()+math.random()*0.5
			if not sndPlayed then udg_play_zombie_acknowledge_sound(gObjects[i]); sndPlayed=true end
		end
	end
	rts_update_living_and_dead_counts()
end




--

--all follow

if key("f","n") or key("c","n")  then

	local sndPlayed=false
	for i=1,#gObjects,1 do
		if gObjects[i].team==1 and gObjects[i].alive then
			gObjects[i].pth=nil
			if gObjects[i].task.id~=object_action_eat then gObjects[i].order=nil end
			gObjects[i].behaviour=zombie_behaviour
			gOldPlayerPosX=1000
			gOldPlayerPosY=0
			gOldPlayerPosZ=1000
			if not sndPlayed then udg_play_zombie_acknowledge_sound(gObjects[i]); sndPlayed=true end
		end
	end
	gZombieBehaviour= zombie_behaviour
	rts_update_living_and_dead_counts()
end

--all hold position
if key("h","n") or (key(" ","n")  and gNextUDGLevel==nil) then
		
	local sndPlayed=false
	for i=1,#gObjects,1 do
		if gObjects[i].team==1 and gObjects[i].alive then
			gObjects[i].pth=nil
			if gObjects[i].task.id~=object_action_eat then gObjects[i].order=nil end
			gObjects[i].behaviour=zombie_hold_behaviour
			if not sndPlayed then udg_play_zombie_acknowledge_sound(gObjects[i]); sndPlayed=true end
		end
	end
	gZombieBehaviour=zombie_hold_behaviour
	rts_update_living_and_dead_counts()
end

if key(" ","n") and gNextUDGLevel ~= nil then
	gDisplayLoading= true
	gLoadingBoxMessage="Loading"
	udg_loading_text(gLoadingBoxMessage)
end

--[[
if key("j","n") then
	for i=1,#gObjects,1 do
		if gObjects[i].team==0 then 
		gObjects[i].health=-10;gObjects[i].deathCount=0
	end
	end
end
--]]
key_462 =commandKey
		

				
	if key("+","n") then		a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44=getCameraInfo(IG3D_ROTATION_MATRIX)
		udg_throw_grenade(a41,a42,a43,a31,a32,a33)
	end
	
	--if key("!","n") then
	--	game_func=handle_udg_astartest
	--end
	
	

	--Escape key
if key(27,"n") then

gHideHUD=true

udg_display_FPS()
udg_escape_to_menu()
	end

end