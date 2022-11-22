function fight_enemy_order(obj, target) 
	if target.alive==false then 
		obj.task.id=object_action_idle
		obj.task.objInQuestion=obj
		obj.order=nil
		return
	end
	
	if obj.vehicle then
		drive_to_obj(obj, target, 10)
		return
	end
	
	
		if objdistance(obj,target) < obj.meleeDistance then
			obj.task.id=object_action_melee
			obj.task.objInQuestion=target
		else
			if objdistance(obj,target) > obj.farDistance or obj.gun==nil or obj.gun.shots<=0 then
				obj.task.id=object_action_runto
				obj.task.objInQuestion=target
				obj.farDistance=4.0
			else
				if obj.task.id~=object_action_shootat then
					obj.nextGunAttack=time()+obj.gunInterval
				end
				obj.task.id=object_action_shootat
				obj.task.objInQuestion=target
				obj.farDistance=7.0
			end
		
		end	
		
end


function run_to_vehicle(obj, target) 
	
	if obj.vehicle==nil then
		obj.task.id=object_action_runto
		obj.task.objInQuestion=target
	else
		drive_to_obj(obj, target, 0)
		return
	end
	
	if objdistance(obj,target) < 3.0 and target.driver==nil then
			setObjectInfo(target.cObj, IG3D_ANIMATION, "OpenDoor", 0, false)
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
	
	if obj.vehicle==nil then
		obj.task.id=object_action_runto
		obj.task.objInQuestion=target
	else
		drive_to_obj(obj, target, 0)
	end
	
	setObjectInfo(obj.cObj, IG3D_IGNORE_COLL, true, ig3d_object, target.cObj)
	if objdistance(obj,target) < 2.5 then
		obj.task.id=object_action_idle
		obj.task.objInQuestion= obj
		obj.order=nil
	end
end 

function eat_dead_human(obj, target) 
	
	if objdistance(obj,target) > 0.6 then
		obj.task.id=object_action_goto
		obj.task.objInQuestion= target
	else
		obj.task.id=object_action_eat
		obj.task.objInQuestion=target
	end
	
end 

function run_to_spot(obj, target)
	
	local x,y,z=getObjectInfo(obj.cObj, IG3D_POSITION)
	
	local ds=vecLength(obj.order.x-x, 0, obj.order.z-z)
	if ds<0.6 then
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
	if ds<0.6 then
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
	local tolerance=0.6
	if obj.vehicle then tolerance=3.5 end
	
	local ds=vecLength(obj.pth.x-x, 0, obj.pth.z-z)
	if ds<tolerance then
		if obj.pth.next==nil then
			obj.pth=nil
			obj.order=nil
		else
			obj.pth=obj.pth.next
		end
	end
	
	
	obj.task.x=obj.pth.x
	obj.task.y=obj.pth.y-0.5
	obj.task.z=obj.pth.z
	obj.order.x=obj.pth.x
	obj.order.y=obj.pth.y-0.5
	obj.order.z=obj.pth.z
	
	if not obj.vehicle then
		obj.task.id=object_action_runtospot
	else
		
		drive_to_spot(obj, obj.pth.x, obj.pth.y-0.5, obj.pth.z)
	end
end

