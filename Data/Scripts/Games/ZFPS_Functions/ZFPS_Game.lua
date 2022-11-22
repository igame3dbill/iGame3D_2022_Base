function objectAgainstParticlesZFPS(obj, bone, emt, x,y,z)
	
	--if obj.team~=1 then return end

	if obj.team==1 then
	--handle furniture kicks!
	if emt~="Bullets" and emt~="fpsgun" and emt~="Grenade" and obj.alive and obj.event==nil then
		local eatingOrder=false
		if obj.order then
			if obj.order.fn==eat_dead_human or obj.task.id==object_action_melee then
				eatingOrder=true
			end
		end
		
		if not eatingOrder then
			p=get(ig3d_particle_emitter, emt)
			--local i=udg_get_nearest_particle_to_position(p, x,y,z)
			obj.event={fn=kick_furniture_event, target=obj, timeOut=time()+0.5, emt=p, x=0, y=0, z=0}
			return
		end
	end
	end
	
	
	--Enable next line for instant detonations
	--if emt=="Grenade" then udg_explode_nearest_grenade_to_position(x,y,z) end
	
	if emt =="Grenade" then
		if time()> gNextGrenadeDropSound and vecLength(x-gMostRecentGrenadePosition[1],y-gMostRecentGrenadePosition[2],z-gMostRecentGrenadePosition[3])>0.6 then
			gNextGrenadeDropSound=time()+ gGrenadeDropSoundDelay
			setSound_emitterInfo(grenadeDropSound, IG3D_POSITION, x,y,z)
			setSound_emitterInfo(grenadeDropSound, IG3D_SAMPLE, "Data/Sounds/dropgrenade.ogg")
			setSound_emitterInfo(grenadeDropSound, IG3D_LOOP, false)
			setSound_emitterInfo(grenadeDropSound, IG3D_START)
			local i= get_nearest_grenade_to_position(x,y,z)
			
			if i>0 then
				local curlifetime=getParticleInfo(grenadeEmitter, i, IG3D_LIFE_TIME)
				setParticleInfo(grenadeEmitter, i, IG3D_LIFE_TIME, math.min(curlifetime, 0.4))
			end
		end
		
		
		gMostRecentGrenadePosition={x,y,z}
	end
	
	
	
	if (emt=="Bullets" or emt=="fpsgun") then--and obj.alive then
		local bn=get(ig3d_bone, obj.cObj, bone)
		local bnname=getBoneInfo(bn, IG3D_NAME)
		obj.health=obj.health - (100+math.random(20))
		

		
		if obj.blood==false then --and obj.alive then
			--if math.random(4)==1 then bnname="head" end--remove
			if bnname=="head" then --or bname=="neck" or bname=="neckDummy" then
				
				obj.health=-10
				
				--obj.headshot=true
				--if math.random(5)==1 then
				--	bn=get(ig3d_bone, obj.cObj, "head")
				--	setBoneInfo(bn, IG3D_RAGDOLL, false)
				--	setParticle_emitterInfo(bloodParticles, IG3D_POSITION, getBoneInfo(bn, IG3D_POSITION))
				--	setParticle_emitterInfo(bloodParticles, IG3D_ROTATION, -90,0,0)
				--	setParticle_emitterInfo(bloodParticles, IG3D_START)
				--end
				
			end
			
			
			
			
			
		
			play_hit_sound(obj)
			setParticle_emitterInfo(bloodParticles, IG3D_POSITION, x,y,z)
			setParticle_emitterInfo(bloodParticles, IG3D_ROTATION, 0,0,0)
			setParticle_emitterInfo(bloodParticles, IG3D_START)
			
			
			--shot is targeting inside
			
			local ox,oy,oz=getObjectInfo(obj.cObj, IG3D_POSITION)
			--local ox,oy,oz=getBoneInfo(bn, IG3D_POSITION)
			--dy=y
			local dx,dy,dz
			dx=ox-x
			dy=oy-y
			dz=oz-z
			dx,dy,dz=normalized(dx,dy,dz)
			
			
			local sx=x-dx
			local sy=y-dy
			local sz=z-dz
			local fx=ox+dx
			local fy=oy+dy
			local fz=oz+dz
			
			
			result,x,y,z,u,v,m,nx,ny,nz=getObjectInfo(obj.cObj, IG3D_EXACT_COLLISION_DATA, sx,sy,sz,fx,fy,fz)
			if result then
				drawToTexture( getMaterialInfo(m, IG3D_TEXTURE, 3), "Data/Images/Decals/bloodpencil"..(math.random(1,3))..".png",u,v, IG3D_ADD, IG3D_REPEAT)
				
				local headPosX,headPosY,headPosZ=getBoneInfo(get(ig3d_bone, obj.cObj, "head"), IG3D_POSITION)
				local chestPosX,chestPosY,chestPosZ=getBoneInfo(get(ig3d_bone, obj.cObj, "chest"), IG3D_POSITION)
			
				if vecLength(x-headPosX, y-headPosY, z-headPosZ) < vecLength(x-chestPosX, y-chestPosY, z-chestPosZ) then
					obj.event={fn=headshot_event, target=obj, timeOut=time()+0.2}
				else
					obj.event={fn=chestshot_event, target=obj, timeOut=time()+0.15}
				end
				
				a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44=getCameraInfo(IG3D_ROTATION_MATRIX)
				setObjectInfo(obj.cObj, IG3D_IMPULSE, x,y,z,a31*1,0,a33*1)
				
			end
			obj.blood=true
		
		end
		
		
	end
end




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
function zfps_handle_camera()
	
	if not gObjects[playerBox].alive then
		tx,ty,tz=getBoneInfo(get(ig3d_bone, gObjects[playerBox].cObj, "head"), IG3D_POSITION)
		sx,sy,sz=getCameraInfo(IG3D_POSITION)
		setCameraInfo(IG3D_ROTATION, dirToAngles(tx-sx, ty-sy, tz-sz))
		return
	end
	
	
	
	
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


function zfps_delayed_rush()
	for i=1,#gObjects,1 do
		if gObjects[i].team==1 then
			if gObjects[i].delayedRush then
				if time()>gObjects[i].delayedRush then
					gObjects[i].delayedRush=nil
					gObjects[i].pth=nil
					gObjects[i].behaviour=zombie_rush_behaviour
					--gObjects[i].behaviour= zombie_fps_rush_behaviour
				end
			else
				if gNumHumans>0 then
					gObjects[i].delayedRush=time()+math.random()*0.5
				end
			end
		end
	end
end




function zfps_handle_target_click_selection()
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
					if success then zfps_play_zombie_acknowledge_sound(zomb); zomb.lastpath=zomb.pth; zomb.behaviour= gZombieBehaviour; else zfps_play_zombie_impossible_sound(zomb) end
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
						if success then zfps_play_zombie_acknowledge_sound(zomb); zomb.lastpath=zomb.pth; zomb.behaviour= gZombieBehaviour; else zfps_play_zombie_impossible_sound(zomb) end
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
						if success then zfps_play_zombie_acknowledge_sound(zomb); zomb.lastpath=zomb.pth; zomb.behaviour= gZombieBehaviour; else 
							zfps_play_zombie_impossible_sound(zomb); 
														
						end
					end
		
		end
		
	end
	rts_update_living_and_dead_counts()
end



function zfps_check_game_end_condition()
	rts_update_living_and_dead_counts()
	gStatusString=""--clear that damn string
	if gNumHumans==0 or gObjects[playerBox].alive==false then
		return ig3d_GetLevelName__s(),"\nThe Undead are victorius!!\n\nPress space bar to restart scenario."
	end
	if gNumZombies==0 then
		return ig3d_GetLevelName__s(),"\nThe Undead have been defeated!!\n\nPress space bar to continue."
	end
	
	return nil,""
end


coll_o_p= objectAgainstParticlesZFPS--haha!
function zfps_handle_weapons()

	if not gObjects[playerBox].alive then return end -- don't shoot when dead
	
	--setParticle_emitterInfo(gGunEmitter, IG3D_MASS, 0.06)
	
	if click("n") then
		--setObjectInfo(gGunArm, IG3D_ANIMATION, "Shoot",0,true)
	end
	
	if click("o") then
		--setObjectInfo(gGunArm, IG3D_ANIMATION, "Shoot",0,false)
	end
	
	if click("-") and time()> gLastPlayerGunshot + gPlayerGuns[gCurPlayerGun].interval then
		local sx,sy,sz,bx,by,bz=getSceneInfo(IG3D_MOUSE_LINE)
		local dx=bx-sx
		local dy=by-sy
		local dz=bz-sz
		

		
		gLastPlayerGunshot=time()
		
		
		--New: move the arm, play gun sound and do muzzle flash
		setObjectInfo(gGunArm, IG3D_ANIMATION, "STOP", 0, true)
		setObjectInfo(gGunArm, IG3D_ANIMATION, "Shoot",0,false)
		setSound_emitterInfo(gPlayerGun, IG3D_POSITION, sx,sy,sz)
		setSound_emitterInfo(gPlayerGun, IG3D_LOOP, false)
		setSound_emitterInfo(gPlayerGun, IG3D_START)
		PlayerLightSeven(sx,sy,sz)  ;-- see UDG_Lights.lua
		
		local a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getCameraInfo(IG3D_ROTATION_MATRIX)
		local px,py,pz=getBoneInfo(get(ig3d_bone, gGunArm, "muzzle"), IG3D_POSITION);
		local pxt=-a11*px+a21*py-a31*pz+a41
		local pyt=-a12*px+a22*py-a32*pz+a42
		local pzt=-a13*px+a23*py-a33*pz+a43
		
		setParticle_emitterInfo(muzzleFlash, IG3D_POSITION, pxt, pyt, pzt)
		setParticle_emitterInfo(muzzleFlash, IG3D_START)
		setParticle_emitterInfo(gGunEmitter, IG3D_POSITION, pxt, pyt, pzt)
		
		setParticle_emitterInfo(gGunEmitter, IG3D_ROTATION, dirToAngles(dx,dy,dz))
		setParticle_emitterInfo(gGunEmitter, IG3D_START)
	end
	
	if key("g","-") and time()> gLastPlayerGrenadeThrow + 0.5 then
		local sx,sy,sz,bx,by,bz=getSceneInfo(IG3D_MOUSE_LINE)
		local dx=bx-sx
		local dy=by-sy
		local dz=bz-sz
		dx,dy,dz=normalized(dx,dy,dz)
		
		gLastPlayerGrenadeThrow =time()
		
		throw_grenade(sx,sy,sz,dx,dy,dz) ;  --see ZFPS_Grenade.lua
	end
	
end


function zfps_handle_scrollwheel()
	local dx,dy=getSceneInfo(IG3D_WHEEL_DELTA)
	gOldGameSpeed =math.min(math.max(gOldGameSpeed-dy*0.07, 0.1), 1)
	setSceneInfo(IG3D_SPEED, gOldGameSpeed)
	gInverseGameSpeed=1.0/gOldGameSpeed
end

function deDollObjects()

end

gDoVelocityClamp=false

function handle_zfps()
	
	if gObjects[playerBox].health<=0 and gObjects[playerBox].alive then
		setObjectInfo(gGunArm, IG3D_POSITION, 1000,1000,-1000)
		setObjectInfo(crosshair.cObj, IG3D_POSITION,  1000,1000,-1000)
		setObjectInfo(gObjects[playerBox].cObj, IG3D_MODEL, "Characters/fatscifisoldierTB.wtf")
		--setObjectInfo(gObjects[playerBox].cObj, IG3D_RAGDOLL, true)
		--ig3d_SetMode_i(1)
	end
	
	for i=1,#gObjects,1 do
		if gObjects[i].team==1 then
			if gObjects[i].alive and gObjects[i].health<=0 then
				gObjects[i].nextSoundTime=time()-0.1
				--play_zombie_idle_sound(gObjects[i])
			end
			gObjects[i].distPenalty=math.max(gObjects[i].distPenalty-passed()*100, 0)
		end
	end
	zfps_game_light() -- ;see ZFPS_Lights.lua	
	

	
	zfps_game_keyboard() ; -- see ZFPS_Keyboard.lua

	
	--Killed the following line because it was for some reason causing trouble on windows, I cant tell why, doesnt look like it could harm anything....
	--zfps_editor_keys() ;-- see ZFPS_Editor.lua

	zfps_handle_camera()

	zfps_handle_weapons()	

	--zfps_handle_target_click_selection() -- no zombie commanding in FPS
	
	zfps_delayed_rush()--handle delayed rushers
	
	zfps_handle_music()--handle music
	
	zfps_handle_scrollwheel()

			
	--set the blood flags to false and see if paths need to be rebuilt
	for i=1,#gObjects,1 do
		gObjects[i].blood=false
		if gObjects[i].redoPath and gObjects[i].pth then
			local cx,cy,cz=getObjectInfo(gObjects[i].cObj, IG3D_POSITION)
			gObjects[i].pth,success= generateAStarPathBetweenPositions(target, cx,cy,cz, gObjects[i].pth.last.x,gObjects[i].pth.last.y,gObjects[i].pth.last.z, 0)
			gObjects[i].redoPath=false
		end
	end



-- this is toggled in game amazing FPS boost!
if gHandle_ZFPSAI == true then 
	handle_ZFPSAI() ;-- see ZFPS_AI.lua
end


	--zfps_zombies_follow() -- no zombie following in FPS
	
	gActivateStartSounds=false
	zfps_handle_zombie_idle_sounds()
	zfps_update_object_sounds()	
	--something new: grenades!!!
	zfps_handle_grenates()
	---
	
	if #doors > 0 then handle_ZFPS_Doors() end
	--handle game end check
	if not gNextGameEndCheckTime or time()>gNextGameEndCheckTime then
		gNextGameEndCheckTime=time()+2.5
		
		gNextZFPSLevel,gNextZFPSLevelString=zfps_check_game_end_condition()
		
		gStatusString=gStatusString..gNextZFPSLevelString
		-------write level stats of next level
		if gNextZFPSLevel and not gWonThisLevel and gNextZFPSLevel~="Data/Levels/ZFPS/ZFPS_MainMenu" then
			
			gWonThisLevel=true
			--print(gameroot..gNextZFPSLevel.."/levelstats.lua")
			local levelstatsofnextlevel=io.open(gameroot..gNextZFPSLevel.."/levelstats.lua","w")
			if levelstatsofnextlevel then
				levelstatsofnextlevel:write(gNextZFPSLevel)
				levelstatsofnextlevel:close()
			end
		end
		--------------------------
		
	end
	
	gStatusString=gNextZFPSLevelString
	zfps_display_FPS() ; -- see ZFPS_Utilties.lua
	
	
	if gTestLight then
		zfps_test_light_tint_fog()
	end


	gInverseGameSpeed=1.0 / getSceneInfo(IG3D_SPEED) --calculate inverse of game speed
	
	
	if currentText then
		zfps_display_levelText(3,3)
		if currentText>#levelText then currentText=nil end
	end

		if gDisplayLoading== true and gNextZFPSLevel ~= nil then
			setText_boxInfo(3, IG3D_TEXT, "")
			gTimeBeforeLoad = gTimeBeforeLoad +passed()	
			gTimeBeforeLoad=0		 
			zfps_all_sounds_stop()--good idea
			coll_o_m=nil
			coll_o_p=nil
			coll_o_o=nil
			coll_p_m=nil
			setSound_emitterInfo(gZFPSMusic, IG3D_STOP)
			setSound_emitterInfo(gZFPSMusicAction, IG3D_STOP)
			gZFPSMusic=nil
			gZFPSMusicAction=nil
			loadLevel(gNextZFPSLevel)
			gNextZFPSLevel=nil
			gNextZFPSLevelString=""
			gStatusString=""
			gNextGameEndCheckTime=nil
		end
	
		

		fltk_update()
end



gClickPath=nil
function handle_zfps_astartest()
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
	
	--[[
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
	--]]
	
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
		game_func=handle_zfps_astartest
	end
	
	fltk_update()
	zfps_handle_camera()
	gDoVelocityClamp=false
end