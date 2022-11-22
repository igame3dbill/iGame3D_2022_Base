function randomWalking(obj)
	local zmx,zmz = obj.locmem[1],obj.locmem[2]
	local cx,cy,cz = getObjectInfo(obj.cObj, IG3D_POSITION)
	if math.abs(cx-zmx) < 3 or math.abs(cz-zmz) < 3 then 
		obj.locmem={math.random(-150,150),math.random(-150,150)}
	end
        
    obj.task.id=object_action_walktospot
    obj.task.x=obj.locmem[1]
    obj.task.y=1.0
    obj.task.z=obj.locmem[2]
	obj.task.objInQuestion=obj
end

function default_behaviour(obj)
	--The default behaviour is to always run away from enemy objects. When a certain distance is reached to enemies, the behaviour changes in finding a vehicle
	if #obj.sensed==0 then 
	randomWalking(obj)
	return 
	end
	
	if obj.sensed[1].team ~= obj.team then
		
		if objdistance(obj,obj.sensed[1]) < obj.scareDistance then
			obj.task.id=object_action_runoff
			obj.task.objInQuestion=obj.sensed[1]
			obj.scareDistance=8.0
			obj.behaviour=find_house
		else
			--obj.task.id=object_action_lookat
			--obj.task.objInQuestion=obj.sensed[1];
			obj.scareDistance=4.0
			--obj.behaviour=find_house--find_vehicle_behaviour
			randomWalking(obj)
		end
		
		
	else
		randomWalking(obj)
		--obj.task.id=object_action_idle
		--obj.task.objInQuestion=obj;
	end
end

function soldier_behaviour(obj)
	--Soldiers shoot at nearest enemy. If too far away they go closer for shooting. If enemy is very close, they do melee combat. 
	if #obj.sensed==0 then 
		obj.task.id=object_action_idle
		obj.task.objInQuestion=obj
		return
	end
	
	if obj.sensed[1].team ~= obj.team and obj.sensed[1].alive then
		if objdistance(obj,obj.sensed[1]) < obj.meleeDistance then
			obj.task.id=object_action_melee
			obj.task.objInQuestion=obj.sensed[1];
		else
			if objdistance(obj,obj.sensed[1]) > obj.farDistance then
				obj.task.id=object_action_runto
				obj.task.objInQuestion=obj.sensed[1];
				obj.farDistance=4.0
			else
				if obj.task.id~=object_action_shootat then
					obj.nextGunAttack=time()+obj.gunInterval
				end
				obj.task.id=object_action_shootat
				obj.task.objInQuestion=obj.sensed[1];
				obj.farDistance=7.0
			end
		
		end		
		
	else
		obj.task.id=object_action_idle
		obj.task.objInQuestion=obj;
	end
end 


function gunned_civilian_behaviour(obj)
	--Gunned civilians shoot at nearest enemy. If enemy comes too near, they run off to a larger shooting distance. If there are no relevant enemies, they go to nearest friendly person (probably to say something stupid)
	if #obj.sensed==0 then 
		obj.task.id=object_action_idle
		obj.task.objInQuestion=obj
		return
	end
	
	if obj.sensed[1].team ~= obj.team and obj.sensed[1].alive then
		if objdistance(obj,obj.sensed[1]) < obj.scareDistance then
			obj.task.id=object_action_runoff
			obj.task.objInQuestion=obj.sensed[1];
			obj.scareDistance=4.5
		else
			obj.scareDistance=2.5
			if objdistance(obj,obj.sensed[1]) > obj.farDistance then
				obj.task.id=object_action_runto
				obj.task.objInQuestion=obj.sensed[1];
				obj.farDistance=4.0
			else
				if obj.task.id~=object_action_shootat then
					obj.nextGunAttack=time()+obj.gunInterval+math.random()*0.1
				end
				obj.task.id=object_action_shootat
				obj.task.objInQuestion=obj.sensed[1];
				obj.farDistance=7.0
			end
		
		end		
		
	else
		--print(getObjectInfo(obj.sensed[1].cObj, IG3D_NAME), #obj.sensed)
		obj.task.id=object_action_idle
		obj.task.objInQuestion=obj;
	end
end 


function zombie_behaviour(obj)
	--Zombies walk towards nearest enemy. If there are no relevant enemies, they just mummy around
	setSound_emitterInfo(obj.zombieSndEmt, IG3D_POSITION, getObjectInfo(obj.cObj, IG3D_POSITION))
	if gActivateStartSounds then setSound_emitterInfo(obj.zombieSndEmt, IG3D_START) end
	
	
	
	
	if #obj.sensed==0 then 
		randomWalking(obj)
		return 
	end
	
	
	
	if obj.sensed[1].team ~= obj.team and obj.sensed[1].alive then
		if objdistance(obj,obj.sensed[1]) < obj.meleeDistance then
			obj.task.id=object_action_melee
			obj.task.objInQuestion=obj.sensed[1];
		else
			obj.task.id=object_action_goto
			obj.task.objInQuestion=obj.sensed[1];
			obj.animPickTable=zombieAnims
		end
	else
		randomWalking(obj)
	end
end 


function zombie_reanimate_behaviour(obj)
	--Zombie gets up
	obj.task.id=object_action_reanimate
	obj.task.objInQuestion=obj
end 


function drive_vehicle(obj)
	if #obj.sensed==0 then 
		obj.task.id= object_action_drive
		obj.task.objInQuestion=obj.vehicle
		return	
	end
	
	obj.task.id=object_action_drive
	obj.task.objInQuestion=obj.vehicle
	local bn=get(ig3d_bone, obj.vehicle.cObj, "Driver")
	
	setObjectInfo(obj.cObj, IG3D_POSITION, getBoneInfo(bn, IG3D_POSITION))
	setObjectInfo(obj.cObj, IG3D_ROTATION, getObjectInfo(obj.vehicle.cObj, IG3D_ROTATION))
end

function find_vehicle_behaviour(obj)
	if #obj.sensed==0 then 
		obj.task.id=object_action_idle
		obj.task.objInQuestion=obj
		return
	end
	
	local i
	local veh=nil
	for i=1,#obj.sensed,1 do
		if getObjectInfo(obj.sensed[i].cObj, IG3D_VEHICLE) == true and obj.sensed[i].driver==nil and obj.sensed[i].health>0 then
			veh=obj.sensed[i]
			break
		end
	end
	
	
	if veh==nil or (obj.sensed[1].team ~= obj.team and objdistance(obj,obj.sensed[1]) < obj.scareDistance and objdistance(obj,obj.sensed[1])<objdistance(obj,veh)) then
		obj.behaviour=default_behaviour
		obj.behaviour(obj)--do it
	else
		
		obj.task.id=object_action_runto
		obj.task.objInQuestion= veh
		if objdistance(obj,veh) < 3.0 then
			setObjectInfo(veh.cObj, IG3D_ANIMATION, "OpenDoor", 0, false)
			--disappear in car
			--obj.alive=false
			obj.behaviour=drive_vehicle
			obj.vehicle=veh
			veh.driver=obj
			veh.health=10000
			setObjectInfo(obj.cObj, IG3D_COLL, false)
			setObjectInfo(obj.cObj, IG3D_GRAVITY_MULTIPLIER, 0)
			setObjectInfo(obj.cObj, IG3D_POSITION, getObjectInfo(obj.vehicle.cObj, IG3D_POSITION))
			setObjectInfo(obj.cObj, IG3D_ROTATION, getObjectInfo(obj.vehicle.cObj, IG3D_ROTATION))
			handle_car_sounds(veh)--good, put it here
			setSound_emitterInfo(veh.engineSndEmt, IG3D_START)
			setSound_emitterInfo(veh.skidSndEmt, IG3D_START)
			obj.task.id=object_action_drive
			obj.task.objInQuestion=obj.vehicle
			obj.curDrivingFrame =1
			obj.startDriving =time()
		end
		
		
	end
end



-----object is running into nearest house
function find_house(obj)
	if #obj.sensed==0 then
		randomWalking(obj)
		--obj.task.id=object_action_idle
		--obj.task.objInQuestion=obj
		return
	end
	
	local i
	local house=nil
	for i=1,#obj.sensed,1 do
		if obj.sensed[i].house == true then
			house=obj.sensed[i]
			setObjectInfo(obj.cObj, IG3D_IGNORE_COLL, true, ig3d_object, house.cObj)
			break
		end
	end
	
	
	if house==nil or (obj.sensed[1].team ~= obj.team and objdistance(obj,obj.sensed[1]) < obj.scareDistance and objdistance(obj,obj.sensed[1])<objdistance(obj,house)) then
		obj.behaviour=default_behaviour
		obj.behaviour(obj)--do it
	else
		
		obj.task.id=object_action_runto
		obj.task.objInQuestion= house
		if objdistance(obj,house) < 2.5 then

			obj.task.id=object_action_idle
			obj.task.objInQuestion= obj
		end
		
		
	end
end


