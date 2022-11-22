function pick_first_zombie(x,y,z)
	for i=1,#gObjects,1 do
		if gObjects[i].team==1 and gObjects[i].alive and gObjects[i].order==nil then
			--found a zombie to do this task
			return gObjects[i]					
		end
	end
end

function pick_highest_ranked_zombie(x,y,z)
	--first version
	local zomb=nil
	local dist=10000
	local i
	
	--penalize objects with eating task
		for i=1,#gObjects,1 do
			if gObjects[i].team==1 and gObjects[i].order then
				if gObjects[i].order.fn==eat_dead_human then
					gObjects[i].distPenalty=5
				end
			end
		end	
	
		for i=1,#gObjects,1 do
					if gObjects[i].team==1 and gObjects[i].alive then
						--found a zombie to do this task
						local cx,cy,cz=getObjectInfo(gObjects[i].cObj, IG3D_POSITION)
						local thisdist=vecLength(cx-x,cy-y,cz-z) + gObjects[i].distPenalty
						if thisdist<dist or zomb==nil then
							dist=thisdist
							zomb=gObjects[i]
						end	
						
					end
				end
				
	if zomb then
		zomb.distPenalty=200
		return zomb
	end
end


gNumFramesThisLevel=0
function udg_handle_camera()
	a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44=getCameraInfo(IG3D_ROTATION_MATRIX)

	if gNumFramesThisLevel>5 then
		local dx,dy=getSceneInfo(IG3D_MOUSE_DELTA)
		xa=xa+dy
		ya=ya-dx
		xa=math.min(math.max(-90,xa), 90)
		setCameraInfo(IG3D_ROTATION, xa,ya,za)
	else
		xa,ya,za=dirToAngles(a31,a32,a33)
		setCameraInfo(IG3D_ROTATION, xa,ya,za)
		gNumFramesThisLevel = gNumFramesThisLevel+1
	end
	

	
	x=0
	y=0
	z=0
	forw={a31,a32,a33}
	forw[2]=0
	forw[1],forw[2],forw[3]=normalized(forw[1],forw[2],forw[3])
	
	
	
	if key("w","-") then
		x=x+forw[1]
		y=y+forw[2]
		z=z+forw[3]
	end
	
	if key("s","-") then
		x=x-forw[1]
		y=y-forw[2]
		z=z-forw[3]
	end
	
	if key("a","-") then
		x=x+a11
		y=y+a12
		z=z+a13
	end
	
	if key("d","-") then
		x=x-a11
		y=y-a12
		z=z-a13
	end
	
	dx,dy,dz=getObjectInfo(playerBox, IG3D_VELOCITY)
	if vecLength(dx,dy,dz)>gVelocityClamp and gDoVelocityClamp then
		x=0
		y=0
		z=0
	end
	setObjectInfo(playerBox, IG3D_FORCE, x*gCameraSpeed-0.2*gCameraSpeed*dx, y*gCameraSpeed-0.2*gCameraSpeed*dy, z*gCameraSpeed-0.2*gCameraSpeed*dz)
	
	
	
	x,y,z=getObjectInfo(playerBox, IG3D_POSITION)
	y=y+0.65
	setCameraInfo(IG3D_POSITION, x,y,z)	
	setSceneInfo(IG3D_MOUSE_VIEW, true, 1)
	
end


function udg_delayed_rush()
	for i=1,#gObjects,1 do
		if gObjects[i].team==1 and gObjects[i].delayedRush then
			if time()>gObjects[i].delayedRush then
				gObjects[i].delayedRush=nil
				gObjects[i].pth=nil
				gObjects[i].behaviour=zombie_rush_behaviour
			end
		end
	end
end




function udg_handle_target_click_selection()
	if click("n") then
		
		local ax,ay,az, bx,by,bz=getSceneInfo(IG3D_MOUSE_LINE)
		local c,lx,ly,lz,o=lineCollision(ax,ay,az, bx,by,bz)
		
		--better corrected collision positions:
		if c==1 then
			result,lx,ly,lz,u,v,mtrl,dx,dy,dz=getSceneInfo(IG3D_EXACT_COLLISION_DATA, ax,ay,az,bx,by,bz)
			if result then
				lx=lx+dx*0.15
				ly=ly+dy*0.15
				lz=lz+dz*0.15
			end
		end
			
		if c==2 then
			local result,x,y,z,u,v,mtrl,dx,dy,dz=getObjectInfo(o.cObj, IG3D_EXACT_COLLISION_DATA, ax,ay,az,bx,by,bz)
			if result then
				lx=x+dx*0.15
				ly=y+dy*0.15
				lz=z+dz*0.15
			end
			--lx,ly,lz=getObjectInfo(o.cObj, IG3D_POSITION)
		end
		-----------------------
		if c==2 then
			if o.team==0 and o.alive or (o.team == doorTeam and o.house) or (o.team == windowTeam and o.house) then
				o.blinkingRed=1
				-- hit an enemy
				
				local zomb= pick_highest_ranked_zombie(lx,ly,lz)
				if zomb then
					local cx,cy,cz=getObjectInfo(zomb.cObj, IG3D_POSITION)
					local success
					zomb.pth,success=generateAStarPathBetweenPositions(o, cx, cy, cz, lx,ly,lz,0)
					zomb.order={fn=fight_enemy_order, target=o, x=lx, y=ly, z=lz}
					zomb.behaviour= gZombieBehaviour
					if success then udg_play_zombie_acknowledge_sound(zomb); zomb.lastpath=zomb.pth; zomb.behaviour= gZombieBehaviour; else udg_play_zombie_impossible_sound(zomb) end
				end
				
			else
				if o.team==sceneryTeam then		
					local zomb= pick_highest_ranked_zombie(lx,ly,lz)
					if zomb then
						local cx,cy,cz=getObjectInfo(zomb.cObj, IG3D_POSITION)
						local success
						zomb.pth,success=generateAStarPathBetweenPositions(nil, cx, cy, cz, lx,ly,lz,0)
						zomb.order={fn= run_on_path, target=nil, x=lx, y=ly, z=lz}
						
						zomb.behaviour= gZombieBehaviour
						if success then udg_play_zombie_acknowledge_sound(zomb); zomb.lastpath=zomb.pth; zomb.behaviour= gZombieBehaviour; else udg_play_zombie_impossible_sound(zomb) end
					end				
				end				
			end
		end		
		if c==1 then
			local zomb= pick_highest_ranked_zombie(lx,ly,lz)
					if zomb then
						local cx,cy,cz=getObjectInfo(zomb.cObj, IG3D_POSITION)
						local success
						zomb.pth,success=generateAStarPathBetweenPositions(nil, cx, cy, cz, lx,ly,lz,0)
						zomb.order={fn= run_on_path, target=nil, x=lx, y=ly, z=lz}
						zomb.behaviour= gZombieBehaviour
						if success then udg_play_zombie_acknowledge_sound(zomb); zomb.lastpath=zomb.pth; zomb.behaviour= gZombieBehaviour; else 
							udg_play_zombie_impossible_sound(zomb); 
														
						end
					end
		
		end
		
	end
	rts_update_living_and_dead_counts()
end



function udg_check_game_end_condition()
	rts_update_living_and_dead_counts()
	if gNumHumans==0 then
		return ig3d_GetLevelName__s(),"\nThe Undead are victorius!!\n\nPress space bar to continue."
	end
	if gNumZombies==0 then
		return ig3d_GetLevelName__s(),"\nThe Undead have been defeated!!\n\nPress space bar to restart scenario."
	end
	
	return nil,""
end


function udg_handle_scrollwheel()
	local dx,dy=getSceneInfo(IG3D_WHEEL_DELTA)
	gOldGameSpeed =math.min(math.max(gOldGameSpeed-dy*0.07, 0.1), 1)
	setSceneInfo(IG3D_SPEED, gOldGameSpeed)
	gInverseGameSpeed=1.0/gOldGameSpeed
end

function deDollObjects()

end

gDoVelocityClamp=false

function handle_udg()
	
	
	for i=1,#gObjects,1 do
		if gObjects[i].team==1 then
			gObjects[i].distPenalty=math.max(gObjects[i].distPenalty-passed()*100, 0)
		end
	end
	udg_game_light() -- ;see UDG_Lights.lua	
	

	
	udg_game_keyboard() ; -- see UDG_Keyboard.lua

	
	--Killed the following line because it was for some reason causing trouble on windows, I cant tell why, doesnt look like it could harm anything....
	--udg_editor_keys() ;-- see UDG_Editor.lua

	udg_handle_camera()

		

	udg_handle_target_click_selection()
	
	udg_delayed_rush()--handle delayed rushers
	
	udg_handle_music()--handle music
	
	udg_handle_scrollwheel()

			
	--set the blood flags to false and see if paths need to be rebuilt
	for i=1,#gObjects,1 do
		gObjects[i].blood=false
		if gObjects[i].redoPath and gObjects[i].pth then
			local cx,cy,cz=getObjectInfo(gObjects[i].cObj, IG3D_POSITION)
			gObjects[i].pth,success= generateAStarPathBetweenPositions(target, cx,cy,cz, gObjects[i].pth.last.x,gObjects[i].pth.last.y,gObjects[i].pth.last.z, 0)
			gObjects[i].redoPath=false
		end
	end
	
udg_display_FPS() ; -- see UDG_Utilties.lua

-- this is toggled in game amazing FPS boost!
if gHandle_UDGAI == true then 
	handle_UDGAI() ;-- see UDG_AI.lua
end


	udg_zombies_follow()
	gActivateStartSounds=false
	udg_handle_zombie_idle_sounds()
	udg_update_object_sounds()	
	--something new: grenades!!!
	udg_handle_grenates()
	---
	
	if #doors > 0 then handle_UDG_Doors() end
	--handle game end check
	if not gNextGameEndCheckTime or time()>gNextGameEndCheckTime then
		gNextGameEndCheckTime=time()+2.5
		gNextUDGLevelString=""
		gNextUDGLevel,gNextUDGLevelString=udg_check_game_end_condition()
		gStatusString=gStatusString..gNextUDGLevelString
		-------write level stats of next level
		if gNextUDGLevel and not gWonThisLevel and gNextUDGLevel~="Data/Levels/UDG/UDG_MainMenu" then
			
			gWonThisLevel=true
			--print(gameroot..gNextUDGLevel.."/levelstats.lua")
			local levelstatsofnextlevel=io.open(gameroot..gNextUDGLevel.."/levelstats.lua","w")
			if levelstatsofnextlevel then
				levelstatsofnextlevel:write(gNextUDGLevel)
				levelstatsofnextlevel:close()
			end
		end
		--------------------------
		
	end
	if gTestLight then
		udg_test_light_tint_fog()
	end


	gInverseGameSpeed=1.0 / getSceneInfo(IG3D_SPEED) --calculate inverse of game speed
	
	
	if currentText then
		udg_display_levelText(3,3)
		if currentText>#levelText then currentText=nil end
	end

		if gDisplayLoading== true and gNextUDGLevel ~= nil then
			setText_boxInfo(3, IG3D_TEXT, "")
			gTimeBeforeLoad = gTimeBeforeLoad +passed()	
			gTimeBeforeLoad=0		 
			udg_all_sounds_stop()--good idea
			coll_o_m=nil
			coll_o_p=nil
			coll_o_o=nil
			coll_p_m=nil
			setSound_emitterInfo(gUDGMusic, IG3D_STOP)
			setSound_emitterInfo(gUDGMusicAction, IG3D_STOP)
			gUDGMusic=nil
			gUDGMusicAction=nil
			loadLevel(gNextUDGLevel)
			gNextUDGLevel=nil
			gNextUDGLevelString=""
			gStatusString=""
			gNextGameEndCheckTime=nil
		end
	
		

		fltk_update()
end



gClickPath=nil
function handle_udg_astartest()
	if key(" ","n") then
		--local zomb= pick_first_zombie(x,y,z)
		--setObjectInfo(zomb.cObj, IG3D_POSITION, getCameraInfo(IG3D_POSITION))
		gStartX,gStartY,gStartZ=getCameraInfo(IG3D_POSITION)
	end
	if click("n") then
		ax,ay,az,bx,by,bz=getSceneInfo(IG3D_MOUSE_LINE)
		local dx,dy,dz=normalized(ax-bx,ay-by,az-bz)
	
			
		
			c,x,y,z,o=lineCollision(ax,ay,az,bx,by,bz)
			
			
			if c==1 then
				result,x,y,z,u,v,mtrl,dx,dy,dz=getSceneInfo(IG3D_EXACT_COLLISION_DATA, ax,ay,az,bx,by,bz)
				x=x+dx
				y=y+dy
				z=z+dz
			end
			
			if c==2 then
				result,x,y,z,u,v,mtrl,dx,dy,dz=getObjectInfo(o.cObj, IG3D_EXACT_COLLISION_DATA, ax,ay,az,bx,by,bz)
				x=x+dx
				y=y+dy
				z=z+dz
			end
			
			--local zomb= pick_first_zombie(x,y,z)
			--gStartX,gStartY,gStartZ=getObjectInfo(zomb.cObj, IG3D_POSITION)
			
			
			if c>0 then
				gEndX=x
				gEndY=y
				gEndZ=z
				
				gClickPath,success= generateAStarPathBetweenPositions(nil,gStartX,gStartY,gStartZ,gEndX,gEndY,gEndZ,0)
				if not success then beep(); gClickPath=nil end
			end
	
	
	end
	
	if gClickPath then

				local pthstepper=gClickPath
				while true do
					setParticle_emitterInfo(unitMarkerEnemy, IG3D_POSITION, pthstepper.x, pthstepper.y, pthstepper.z)
					--if pthstepper.next==nil then setParticle_emitterInfo(unitMarkerEnemy, IG3D_START) end
                                                        setParticle_emitterInfo(unitMarkerEnemy, IG3D_START)
					pthstepper=pthstepper.next
					if pthstepper==nil then break end
				end
			
			
	
	end
	
	--[[
	for i=1,4,1 do	
				setParticle_emitterInfo(unitMarkerFriendly, IG3D_POSITION, nds3[i].x, nds3[i].y, nds3[i].z)
				setParticle_emitterInfo(unitMarkerFriendly, IG3D_SIZE, 1)
				if nds3[i]==gende then setParticle_emitterInfo(unitMarkerFriendly, IG3D_SIZE, 2) end
				setParticle_emitterInfo(unitMarkerFriendly, IG3D_START)
				
	end
	--]]
	setParticle_emitterInfo(unitMarkerFriendly, IG3D_SIZE, 2)
	setParticle_emitterInfo(unitMarkerFriendly, IG3D_POSITION, ganfang.x, ganfang.y, ganfang.z)
	setParticle_emitterInfo(unitMarkerFriendly, IG3D_START)
	setParticle_emitterInfo(unitMarkerFriendly, IG3D_SIZE, 1)
	
	for i=1,#ganfang.scs,1 do	
		setParticle_emitterInfo(unitMarkerFriendly, IG3D_POSITION, ganfang.scs[i].x, ganfang.scs[i].y, ganfang.scs[i].z)
		setParticle_emitterInfo(unitMarkerFriendly, IG3D_START)				
	end
	
	if key("#","n") then
		game_func=handle_udg_astartest
	end
	
	fltk_update()
	udg_handle_camera()
	gDoVelocityClamp=false
end