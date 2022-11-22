function fight_enemy_order(obj, target)

	if (target.health<=0 and (target.team>1 or objdistance(obj,target)>=obj.meleeDistance)) or obj==target then
		obj.task.id=object_action_idle
		obj.task.objInQuestion=obj
		obj.order=nil
		obj.pth=nil
		
		return
	end

	
	
	if obj.vehicle then
		drive_to_obj(obj, target, 10)
		return
	end
	
	
		if objdistance(obj,target) < obj.meleeDistance then--hmm
			obj.task.id=object_action_melee
			obj.task.objInQuestion=target
		else
			local hasNoGunOrGunIsEmpty=false
			if obj.gun then
				if obj.gun.shots<=0 then hasNoGunOrGunIsEmpty=true end
			else
				hasNoGunOrGunIsEmpty =true
			end
			
			if objdistance(obj,target) > obj.farDistance or hasNoGunOrGunIsEmpty then
				obj.task.id=object_action_runto
				obj.task.objInQuestion=target
				obj.farDistance=7.0
			else
				if target.seenFlag then
					if obj.task.id~=object_action_shootat then
						if obj.gun~=nil then obj.nextGunAttack=time()+obj.gun.interval end
					end
					obj.task.id=object_action_shootat
					obj.task.objInQuestion=target
					obj.farDistance=10.0
				else
					obj.task.id=object_action_runto
					obj.task.objInQuestion=target
					obj.farDistance=7.0
					
					
				end
					
			end
		
		end	
		
		
		if obj.task.id==object_action_runto and obj.team==1 then

				if not obj.mayRush then
					obj.task.id=object_action_goto
				end
			
		end
end


function fight_enemy_order_aware(obj, target)
	local newTargetAvailable=false --variable that determines if there are new targets in case we need to switch
	
	if #obj.sensed>0 then
		if obj.sensed[1].alive and obj.sensed[1].team==1-obj.team and obj.sensed[1]~= target then--and seenBefore(obj, obj.sensed[1]) then
			newTargetAvailable=true
		end
	end
	
	local chooseNewTarget=false --variable that determines if me choose a new target
	if target.health<=0 and objdistance(obj,target)>=1.5 and target.team<=1 then chooseNewTarget=true end
	if target.health<=0 and target.team>1 then chooseNewTarget=true end
	if target.health>0 and newTargetAvailable then chooseNewTarget=true end
	if target==obj then chooseNewTarget=true end
	
	
	if chooseNewTarget then
		if newTargetAvailable then
			obj.order.target=obj.sensed[1]
		else
			obj.task.id=object_action_keep
			obj.task.objInQuestion=obj
			obj.order=nil
			obj.pth=nil
			return
		end
	end
	
	
	if obj.vehicle then
		drive_to_obj(obj, target, 10)
		return
	end
	
	
	
	--dont interrupt throwing to floor and eat
	--[[
	if obj.team==1 then
		if obj.oldanimname=="ZombieAttack" or obj.oldanimname=="Punch" or obj.oldanimname=="Kick" or obj.oldanimname=="Scared" then
			obj.task.id=object_action_melee
			obj.task.objInQuestion=target
			return
		end
	end
	--]]
	
	
		if objdistance(obj,target) < obj.meleeDistance then
			obj.task.id=object_action_melee
			obj.task.objInQuestion=target
		else
			if objdistance(obj,target) > obj.farDistance or obj.gun==nil or obj.gun.shots<=0 then
				obj.task.id=object_action_runto
				obj.task.objInQuestion=target
				obj.farDistance=7.0
			else
				if target.seenFlag then
					if obj.task.id~=object_action_shootat then
						if obj.gun~=nil then obj.nextGunAttack=time()+obj.gun.interval end
					end
					obj.task.id=object_action_shootat
					obj.task.objInQuestion=target
					obj.farDistance=10.0
				else
					obj.task.id=object_action_runto
					obj.task.objInQuestion=target
					obj.farDistance=7.0
				
				end
					
			end
		
		end
		
		
		if obj.task.id==object_action_runto and obj.team==1 then
			if not obj.mayRush then
				obj.task.id=object_action_goto
			end	
		end
		
end


function run_to_vehicle(obj, target) 
	
	if obj.pth~=nil then
		run_on_path(obj, target)
	end
	if obj.pth then return end
	
	
	if obj.vehicle==nil then
		obj.task.id=object_action_runto
		obj.task.objInQuestion=target
	else
		drive_to_obj(obj, target, 0)
		return
	end
	
	if objdistance(obj,target) < 3.0 and target.driver==nil then
			setObjectInfo(target.cObj, IG3D_ANIMATION, "OpenDoor", 0, false)
			setObjectInfo(target.cObj, IG3D_VEHICLE, true)--uh oh
			setObjectInfo(target.cObj, IG3D_VELOCITY, 1,0,0)
			--disappear in car
			--obj.alive=false
			obj.order=nil--reached car, job done!
			obj.behaviour=drive_vehicle
			obj.vehicle=target
			target.driver=obj
			target.health=10000
			setObjectInfo(obj.cObj, IG3D_COLL, false)
			setObjectInfo(obj.cObj, IG3D_GRAVITY_MULTIPLIER, 0)
			setObjectInfo(obj.cObj, IG3D_POSITION, getObjectInfo(obj.vehicle.cObj, IG3D_POSITION))
			setObjectInfo(obj.cObj, IG3D_ROTATION, getObjectInfo(obj.vehicle.cObj, IG3D_ROTATION))
			handle_car_sounds(target)--good, put it here
			setSound_emitterInfo(target.engineSndEmt, IG3D_START)
			setSound_emitterInfo(target.skidSndEmt, IG3D_START)
			obj.task.id=object_action_drive
			obj.task.objInQuestion=obj.vehicle
			obj.curDrivingFrame =1
			obj.startDriving =time()
			
		end
		
end




function run_to_house(obj, target) 
	
	if obj.pth~=nil then
		run_on_path(obj, target)
	end
	if obj.pth then return end
	
		if obj.vehicle==nil then
			obj.task.id=object_action_runto
			obj.task.objInQuestion=target
		else
			drive_to_obj(obj, target, 10)
		end
	
		if obj.team==0 then setObjectInfo(obj.cObj, IG3D_IGNORE_COLL, true, ig3d_object, target.cObj) end
		if objdistance(obj,target) < gReachedTolerance then
			if obj.gun then
					obj.gun.shots=obj.gun.shots+math.random(obj.gun.recharge[1],obj.gun.recharge[2])
					obj.behaviour=gunned_civilian_behaviour
			end
			obj.task.id=object_action_idle
			obj.task.objInQuestion= obj
			obj.order=nil
		end
	
	
end 

function eat_dead_human(obj, target) 
	obj.task.id=object_action_eat
	obj.task.objInQuestion=target
end 

function run_to_spot(obj, target)
	
	local x,y,z=getObjectInfo(obj.cObj, IG3D_POSITION)
	
	local ds=vecLength(obj.order.x-x, 0, obj.order.z-z)
	if ds< gReachedTolerance then
		obj.order=nil
	end
	
	if obj.vehicle==nil then
		obj.task.id=object_action_runtospot
		obj.task.x=obj.order.x
		obj.task.y=obj.order.y
		obj.task.z=obj.order.z
	else
		drive_to_spot(obj, obj.order.x, obj.order.y, obj.order.z)
	end
end

function walk_to_spot(obj, target)
	
	local x,y,z=getObjectInfo(obj.cObj, IG3D_POSITION)
	
	local ds=vecLength(obj.order.x-x, 0, obj.order.z-z)
	if ds< gReachedTolerance then
		obj.order=nil
	end
	
	if obj.vehicle==nil then
		obj.task.id=object_action_walktospot
		obj.task.x=obj.order.x
		obj.task.y=obj.order.y
		obj.task.z=obj.order.z
	else
		drive_to_spot(obj, obj.order.x, obj.order.y, obj.order.z)
	end
end




function drive_to_obj(obj, target, offst)
	local x,y,z=getObjectInfo(target.cObj, IG3D_POSITION)
	local x2,y2,z2=getObjectInfo(obj.cObj, IG3D_POSITION)
	local dx,dy,dz=normalized(x-x2, y-y2, z-z2)
	drive_to_spot(obj, x+dx*offst,y+dy*offst,z+dz*offst)
end

function drive_to_spot(obj, x,y,z)
	obj.behaviour=drive_vehicle
	obj.targetCrossing={x, y, z}
	obj.nextTurn="straight"
	obj.task.id=object_action_drive
	obj.task.objInQuestion=obj.vehicle
	local bn=get(ig3d_bone, obj.vehicle.cObj, "Driver")
	setObjectInfo(obj.cObj, IG3D_POSITION, getBoneInfo(bn, IG3D_POSITION))
	setObjectInfo(obj.cObj, IG3D_ROTATION, getObjectInfo(obj.vehicle.cObj, IG3D_ROTATION))
end


function walk_on_path(obj, target)
	local x,y,z=getObjectInfo(obj.cObj, IG3D_POSITION)
	local tolerance= gReachedTolerance
	if obj.vehicle then tolerance=3.5 end
	
	
	obj.task.id=object_action_idle
	obj.task.objInQuestion=obj
	obj.task.x=0
	obj.task.y=0
	obj.task.z=0
	
	if obj.pth then
		local ds=vecLength(obj.pth.x-x, 0, obj.pth.z-z)
		if ds<tolerance then
		
			if obj.pth.next==nil then
				obj.order=nil
				return
			end
			
			obj.pth=obj.pth.next		
		end
	
	
		obj.task.x=obj.pth.x
		obj.task.y=obj.pth.y-0.5
		obj.task.z=obj.pth.z
		obj.order.x=obj.pth.x
		obj.order.y=obj.pth.y-0.5
		obj.order.z=obj.pth.z
	end
	
	if not obj.vehicle then
		obj.task.id=object_action_walktospot
	else
		
		drive_to_spot(obj, obj.pth.x, obj.pth.y-0.5, obj.pth.z)
	end
end

--[[
function hold_position_aware(obj,target)
	obj.task.id=object_action_idle
	obj.task.objInQuestion=obj
	obj.task.x=0
	obj.task.y=0
	obj.task.z=0
end
--]]
function run_on_path(obj, target)
	local x,y,z=getObjectInfo(obj.cObj, IG3D_POSITION)
	local tolerance= gReachedTolerance
	if obj.vehicle then tolerance=3.5 end
	
	
	obj.task.id=object_action_idle
	obj.task.objInQuestion=obj
	obj.task.x=0
	obj.task.y=0
	obj.task.z=0
	
	if obj.pth then
		local ds=vecLength(obj.pth.x-x, 0, obj.pth.z-z)
		if ds<tolerance then
		
			if obj.pth.next==nil then
				obj.order=nil
				return
			end
			
			obj.pth=obj.pth.next		
		end
	
	
		obj.task.x=obj.pth.x
		obj.task.y=obj.pth.y-0.5
		obj.task.z=obj.pth.z
		obj.order.x=obj.pth.x
		obj.order.y=obj.pth.y-0.5
		obj.order.z=obj.pth.z
	else
		obj.order=nil--Where did the path go? this order wont work
		return
	end
	
	
	
	if not obj.vehicle then
		
		obj.task.id=object_action_runtospot
		if obj.team==1 then
			if not obj.mayRush then
				obj.task.id=object_action_walktospot
			end
		end
	else
		
		drive_to_spot(obj, obj.pth.x, obj.pth.y-0.5, obj.pth.z)
	end
end





function attackHouseForSomeTime(obj, target)
	obj.task.id=object_action_melee
	obj.task.objInQuestion=target
	if time()>obj.order.continueTime or target.health<0 then
		obj.order=nil
	end
end


function pickup_gun(obj, target) 
	
	if obj.pth~=nil then
		run_on_path(obj, target)
	end
	if obj.pth then return end
	
		if obj.vehicle==nil then
			obj.task.id=object_action_runto
			obj.task.objInQuestion=target
		else
			drive_to_obj(obj, target, 0)
		end
	
		if objdistance(obj,target) < gReachedTolerance then
			if not obj.gun and obj.team==0 and getObjectInfo(target.cObj, IG3D_COLL) then
					
					obj.behaviour = gunned_civilian_behaviour
					obj.gunSndEmt = assign_free_sound_emitter()
					setSound_emitterInfo(obj.gunSndEmt, IG3D_SAMPLE, target.sample)
					obj.gun = target
					setObjectInfo(target.cObj, IG3D_COLL, false)
					setObjectInfo(target.cObj, IG3D_GRAVITY_MULTIPLIER, 0)
					target.shots=target.recharge[2]
					
			end
			obj.task.id=object_action_idle
			obj.task.objInQuestion= obj
			obj.order=nil
		end
	
	
end 