-- RTS_Collisions
function objectAgainstParticles(obj, bone, emt, x,y,z)
	
	if obj.team~=1 then return end

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
	
	
	
	--Enable next line for instant detonations
	--if emt=="Grenade" then udg_explode_nearest_grenade_to_position(x,y,z) end
	
	if emt =="Grenade" then
		if time()> gNextGrenadeDropSound and vecLength(x-gMostRecentGrenadePosition[1],y-gMostRecentGrenadePosition[2],z-gMostRecentGrenadePosition[3])>0.6 then
			gNextGrenadeDropSound=time()+ gGrenadeDropSoundDelay
			setSound_emitterInfo(grenadeDropSound, IG3D_POSITION, x,y,z)
			setSound_emitterInfo(grenadeDropSound, IG3D_SAMPLE, "Data/Sounds/dropgrenade.ogg")
			setSound_emitterInfo(grenadeDropSound, IG3D_LOOP, false)
			setSound_emitterInfo(grenadeDropSound, IG3D_START)
			local i= udg_get_nearest_grenade_to_position(x,y,z)
			
			if i>0 then
				local curlifetime=getParticleInfo(grenadeEmitter, i, IG3D_LIFE_TIME)
				setParticleInfo(grenadeEmitter, i, IG3D_LIFE_TIME, math.min(curlifetime, 0.4))
			end
		end
		
		
		gMostRecentGrenadePosition={x,y,z}
	end
	
	
	
	if (emt=="Bullets" or emt=="fpsgun") and obj.alive then
	
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
			
			
			
		
			udg_play_hit_sound(obj)
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
				--obj.blood=true
			end
			obj.blood=true
		
		end
		
		
	end
end


function particlesAgainstMesh(psys, x,y,z)
	if psys=="Grenade" then
		if time()> gNextGrenadeDropSound and vecLength(x-gMostRecentGrenadePosition[1],y-gMostRecentGrenadePosition[2],z-gMostRecentGrenadePosition[3])>0.6 then
			gNextGrenadeDropSound=time()+ gGrenadeDropSoundDelay
			setSound_emitterInfo(grenadeDropSound, IG3D_POSITION, x,y,z)
			setSound_emitterInfo(grenadeDropSound, IG3D_SAMPLE, "Data/Sounds/dropgrenade.ogg")
			setSound_emitterInfo(grenadeDropSound, IG3D_LOOP, false)
			setSound_emitterInfo(grenadeDropSound, IG3D_START)
			local i= udg_get_nearest_grenade_to_position(x,y,z)
			
			if i>0 then
				local curlifetime=getParticleInfo(grenadeEmitter, i, IG3D_LIFE_TIME)
				setParticleInfo(grenadeEmitter, i, IG3D_LIFE_TIME, math.min(curlifetime, 0.9))
			end
		end
		
		
		gMostRecentGrenadePosition={x,y,z}
	end

end

function objectAgainstObject(obj1, bone1, obj2, bone2, x,y,z)
	if obj1.isGun or obj2.isGun then return end --collision with gun object???? weird...
	
	local damage=vecLength(getObjectInfo(obj1.cObj, IG3D_VELOCITY))+vecLength(getObjectInfo(obj2.cObj, IG3D_VELOCITY))*5
	if obj1.isVehicle and obj2.isVehicle then
		 --a crash!! kazoom
		 
		if obj1.health>0 and obj2.health>0 then
			obj1.health=obj1.health-damage
			obj2.health=obj2.health-damage
		end
		return
	end
	
	if obj1.isVehicle then
		if obj1.driver~= nil and not obj2.alive then
			obj1.driver.curDrivingFrame=1
			obj1.driver.startDriving=time()-1
			--local rnd=math.random(#gCrazyDrives)
			--obj1.crazyDrive=gCrazyDrives[rnd]
			obj1.health=obj1.health-damage
			
		end
		if obj2.alive and obj2 ~= obj1.driver and obj1.driver~= nil then
			obj1.health=obj1.health-damage*0.3
			obj2.health=obj2.health-damage
			
			setSound_emitterInfo(obj2.noiseSndEmt, IG3D_POSITION, x,y,z)
			setSound_emitterInfo(obj2.noiseSndEmt, IG3D_START)
		end
		if obj2.house then obj2.health=obj2.health-damage end
	else
		if obj2.isVehicle then
			if obj2.driver~= nil and not obj1.alive then
				obj2.driver.curDrivingFrame=1
				obj2.driver.startDriving=time()-1
				--local rnd=math.random(#gCrazyDrives)
				--obj2.crazyDrive=gCrazyDrives[rnd]
				obj2.health=obj2.health-damage
				
			end
			if obj1.alive and obj1 ~= obj2.driver and obj2.driver~= nil then
				obj2.health=obj2.health-damage*0.3
				obj1.health=obj1.health-damage
				setSound_emitterInfo(obj1.noiseSndEmt, IG3D_POSITION, x,y,z)
				setSound_emitterInfo(obj1.noiseSndEmt, IG3D_START)
			end
			if obj1.house then obj1.health=obj1.health-damage end
		end
	end
	
	--handle doors
	if obj1.team==doorTeam and obj2.team==0 and obj1.health>0 then
		opendoor(obj1)
	end
	if obj2.team==doorTeam and obj1.team==0 and obj2.health>0 then
		opendoor(obj2)
	end
	
	if obj1.team==0 and obj2.team==windowTeam and obj2.health>0 then
		--beep()
		local x1,y1,z1=getObjectInfo(obj2.cObj, IG3D_POSITION)
		local x2,y2,z2=getObjectInfo(obj1.cObj, IG3D_POSITION)
		local dx,dy,dz=normalized(x2-x1,0,z2-z1)
		obj1.pth=nil
		if not obj1.event then
			obj1.event={fn=untangle_event, target=nil, x=dx*2, y=dy*2, z=dz*2, timeOut=time()+0.1}
		end
		if obj1.oldanimname=="Run"  then
			obj2.health=-10
		end
	end
	
	if obj2.team==0 and obj1.team==windowTeam and obj1.health>0 then
		--beep()
		local x1,y1,z1=getObjectInfo(obj1.cObj, IG3D_POSITION)
		local x2,y2,z2=getObjectInfo(obj2.cObj, IG3D_POSITION)
		local dx,dy,dz=normalized(x2-x1,0,z2-z1)
		obj2.pth=nil
		if not obj2.event then
			obj2.event={fn=untangle_event, target=nil, x=dx*2, y=dy*2, z=dz*2, timeOut=time()+0.1}
		end
		if obj2.oldanimname=="Run" then
			obj1.health=-10
		end
	end
	
	if obj1.team==1 and obj1.alive and (obj2.team==doorTeam or obj2.team==windowTeam) then
		
		obj1.order={fn=fight_enemy_order, target=obj2, x=0, y=0, z=0}
	end
	
	if obj2.team==1 and obj2.alive and (obj1.team==doorTeam or obj1.team==windowTeam) then

		obj2.order={fn=fight_enemy_order, target=obj1, x=0, y=0, z=0}
	end
	
	if obj1.alive and obj2.alive and obj1.team~=obj2.team then
	--when enemies collide -> fight
		if obj1.team==1 and obj1.task.id~=object_action_eat then
			if not obj1.order or obj1.order.fn~=eat_dead_human then
				obj1.order={fn=fight_enemy_order, target=obj2, x=0, y=0, z=0}
			end
		end
		if obj2.team==1 and obj2.task.id~=object_action_eat then
			if not obj2.order or obj2.order.fn~=eat_dead_human then
				obj2.order={fn=fight_enemy_order, target=obj1, x=0, y=0, z=0}
			end
		end
	end
	
	if obj1.alive and obj2.alive and obj1.team==obj2.team then
		
		local x1,y1,z1=getObjectInfo(obj1.cObj, IG3D_POSITION)
		local x2,y2,z2=getObjectInfo(obj2.cObj, IG3D_POSITION)
		local dx,dy,dz=normalized(x2-x1,0,z2-z1)
		local cx,cy,cz=normalized(cross(dx,dy,dz, 0,1,0))
		
		local v1=vecLength(getObjectInfo(obj1.cObj, IG3D_VELOCITY))
		local v2=vecLength(getObjectInfo(obj2.cObj, IG3D_VELOCITY))
		
		
		if obj1.order and obj1.task.id==object_action_melee and obj2.task.id~=object_action_melee then
			obj2.order={fn=obj1.order.fn, target=obj1.order.target, x=obj1.order.x, y=obj1.order.y, z=obj1.order.z}
		end
		
		if obj2.order and obj2.task.id==object_action_melee and obj1.task.id~=object_action_melee then
			obj1.order={fn=obj2.order.fn, target=obj2.order.target, x=obj2.order.x, y=obj2.order.y, z=obj2.order.z}
		end
		
		
		------------------------step slow zombies and eaters away
		if obj1.event==nil and obj1.order and not obj2.event and obj1.task~=object_action_eat then
			if (obj1.mayRush and not obj2.mayRush) or obj2.task.id==object_action_eat then
					a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44=getObjectInfo(obj1.cObj, IG3D_ROTATION_MATRIX)
					--obj2 is being pushed
					obj2.impulse={a41,a42,a43, a31*2,0,a33*2}
					obj2.event={fn= fly_event, target=obj2, timeOut=time()+0.3}
					
			end
		end
		if obj2.event==nil and obj2.order and not obj1.event and obj2.task~=object_action_eat then
			if (obj2.mayRush and not obj1.mayRush) or obj1.task.id==object_action_eat then
					a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44=getObjectInfo(obj2.cObj, IG3D_ROTATION_MATRIX)
					--obj1 is being pushed
					obj1.impulse={a41,a42,a43, a31*2,0,a33*2}
					obj1.event={fn= fly_event, target=obj1, timeOut=time()+0.3}
					
			end
		end
		--------------------------
		
		
	end
	
end



coll_o_p=objectAgainstParticles
coll_o_o=objectAgainstObject
coll_p_m=particlesAgainstMesh