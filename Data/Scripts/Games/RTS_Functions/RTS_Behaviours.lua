gReachedTolerance=0.6

function randomWalking(obj)
	--note: The randomWalking is replaced by walk_between_safe_places in UDG, look there if you debug
	local cx,cy,cz = getObjectInfo(obj.cObj, IG3D_POSITION)
	
	if not obj.pth then obj.pth,tmp=generateAStarPathBetweenPositions(nil, cx, cy, cz, math.random(-150,150), cy, math.random(-150,150),0) end
        
   
    local ds=vecLength(obj.pth.x-cx, 0, obj.pth.z-cz)
	if ds< gReachedTolerance then
		if obj.pth.next==nil then
			obj.pth,tmp=generateAStarPathBetweenPositions(nil, cx, cy, cz, math.random(-150,150), cy, math.random(-150,150),0)
		end
		obj.pth=obj.pth.next
	end
	
	if obj.pth then
		obj.task.x=obj.pth.x
		obj.task.y=obj.pth.y-0.5
		obj.task.z=obj.pth.z
	
		obj.task.id=object_action_walktospot
    	obj.task.objInQuestion=obj
    else
    	obj.task.id=object_action_idle
    	obj.task.objInQuestion=obj
    	obj.task.x=0
    	obj.task.y=0
    	obj.task.z=0
    
    end
end

function flee_to_safe_place(obj)
	local needNewPath=false
	
	if obj.lastFleeRouteSet ==nil then obj.lastFleeRouteSet =0 end--this must have a value
	
	
	if obj.afraidOf~=obj.sensed[1] and time()>obj.lastFleeRouteSet+3.0 then needNewPath=true end
	if not obj.pth then needNewPath = true end


	obj.afraidOf=obj.sensed[1]
	
	
				
	local ox,oy,oz=getObjectInfo(obj.cObj, IG3D_POSITION)
	local px,py,pz=getObjectInfo(obj.afraidOf.cObj, IG3D_POSITION)
	local dx,dy,dz=normalized(px-ox,0,pz-oz)
	


	--now cast a ray from way off the map into the mesh, wherever it collides will be where we can flee
	--needNewPath=true
	if needNewPath then
		obj.lastFleeRouteSet=time()
		--construct 3 paths
		--1: away from the enemy:
		c,x,y,z,o=lineCollision(ox-dx*1000, oy, oz-dz*1000, ox,oy,oz)
		--print(x,y,z)
		x,y,z=getNearestSafePlacePosition(x,y,z)
		--print(x,y,z)
		local dstToDestination1=vecLength(ox-x, oy-y, oz-z)
		local pth1,tmp=generateAStarPathBetweenPositions(nil, ox,oy,oz, x,y,z, 0)
		--print(tmp)
		local dst1,dst2,dst3
		if pth1.x==pth1.last.x and pth1.y==pth1.last.y and pth1.z==pth1.last.z then
			dst1=-dstToDestination1
		else
			dst1=vecLength(px-pth1.x, 0, pz-pth1.z)
		end
		
		--2: to the left
		dx,dy,dz=cross(dx,dy,dz,0,1,0)
		c,x,y,z,o=lineCollision(ox-dx*1000, oy, oz-dz*1000, ox,oy,oz)
		x,y,z=getNearestSafePlacePosition(x,y,z)
		local dstToDestination2=vecLength(ox-x, oy-y, oz-z)
		local pth2,tmp=generateAStarPathBetweenPositions(nil, ox,oy,oz, x,y,z, 0)
		local dst2=vecLength(px-pth2.x, 0, pz-pth2.z)
		if pth2.x==pth2.last.x and pth2.y==pth2.last.y and pth2.z==pth2.last.z then
			dst2=-dstToDestination2
		else
			dst2=vecLength(px-pth2.x, 0, pz-pth2.z)
		end
		
		
		--4: forward!!
		dx,dy,dz=cross(dx,dy,dz,0,1,0)
		c,x,y,z,o=lineCollision(ox-dx*1000, oy, oz-dz*1000, ox,oy,oz)
		x,y,z=getNearestSafePlacePosition(x,y,z)
		local dstToDestination4=vecLength(ox-x, oy-y, oz-z)
		local pth4,tmp=generateAStarPathBetweenPositions(nil, ox,oy,oz, x,y,z, 0)
		local dst4=vecLength(px-pth4.x, 0, pz-pth4.z)
		if pth4.x==pth4.last.x and pth4.y==pth4.last.y and pth4.z==pth4.last.z then
			dst4=-dstToDestination4
		else
			dst4=vecLength(px-pth4.x, 0, pz-pth4.z)
		end
		
		--3: to the right
		dx,dy,dz=cross(dx,dy,dz,0,1,0)
		c,x,y,z,o=lineCollision(ox-dx*1000, oy, oz-dz*1000, ox,oy,oz)
		x,y,z=getNearestSafePlacePosition(x,y,z)
		local dstToDestination3=vecLength(ox-x, oy-y, oz-z)
		local pth3,tmp=generateAStarPathBetweenPositions(nil, ox,oy,oz, x,y,z, 0)
		if pth3.x==pth3.last.x and pth3.y==pth3.last.y and pth3.z==pth3.last.z then
			dst3=-dstToDestination3
		else
			dst3=vecLength(px-pth3.x, 0, pz-pth3.z)
		end

		if not obj.route2Weight then
			obj.route2Weight=1
			obj.route3Weight=1
		end
		
		local useRoute1=dst1+2*math.min(dstToDestination1,10)
		local useRoute2=dst2+obj.route2Weight*math.min(dstToDestination2,10)
		local useRoute3=dst3+obj.route3Weight*math.min(dstToDestination3,10)
		
		local useBestRoute=useRoute1
		local dst=dst1
		obj.pth=pth1
		
		if useRoute2>useBestRoute then
			useBestRoute=useRoute2
			obj.pth=pth2
			dst=dst2
			obj.route2Weight=1.5
			obj.route3Weight=1
		else
			if useRoute3>useBestRoute then
				useBestRoute=useRoute3
				obj.pth=pth3
				dst=dst3
				obj.route2Weight=1
				obj.route3Weight=1.5
			end
		end
		
		
		
		if dst<=0 and dstToDestination1<1 then

			
			--no escape
			if getObjectInfo(obj.afraidOf.cObj, IG3D_RAGDOLL) then
				obj.pth=pth4
			else
				obj.oldbehaviour=obj.behaviour
				obj.behaviour=stand_and_cry
				obj.cryStart=time()
			end
		end
		
	end
	
	
	obj.task.x=obj.pth.x
	obj.task.y=obj.pth.y-0.5
	obj.task.z=obj.pth.z
	
	obj.task.id=object_action_runtospot
    obj.task.objInQuestion=obj	
	
    local ds=vecLength(obj.pth.x-ox, 0, obj.pth.z-oz)
	if ds< gReachedTolerance then
		obj.pth=obj.pth.next
	end
	
	
end

function stand_and_cry(obj)
	
	
	obj.task.id=object_action_cry
    obj.task.objInQuestion=obj.sensed[1]
    
    if time()>obj.cryStart+5.0 then
    	obj.behaviour=obj.oldbehaviour
    end
end

function walk_between_safe_places(obj)

	local c=#gSafePlaces
		
	local i=math.random(1,c)
	local lx=gSafePlaces[i][1]
	local ly=gSafePlaces[i][2]
	local lz=gSafePlaces[i][3]
				
	local ox,oy,oz=getObjectInfo(obj.cObj, IG3D_POSITION)
		
			
	if not obj.pth then
		obj.pth,tmp= generateAStarPathBetweenPositions(nil, ox,oy,oz, lx,ly,lz, 0) 
	end
	
	local ds=vecLength(obj.pth.x-ox, 0, obj.pth.z-oz)
	if ds< gReachedTolerance then
		obj.pth=obj.pth.next
	end
			
	
	if obj.pth then
		obj.task.x=obj.pth.x
		obj.task.y=obj.pth.y-0.5
		obj.task.z=obj.pth.z
	
		obj.task.id=object_action_walktospot
    	obj.task.objInQuestion=obj	
	else
		obj.task.id=object_action_idle
		obj.task.objInQuestion=obj
		obj.task.x=0
		obj.task.y=0
		obj.task.z=0
	end
end


function teamUp(obj)

	local targetObj=getNearestFriend(obj) or obj
	local ox,oy,oz=getObjectInfo(obj.cObj, IG3D_POSITION)
	local lx,ly,lz=getObjectInfo(targetObj.cObj, IG3D_POSITION)

	if not obj.pth then
			if vecLength(ox-lx,oy-ly,oz-lz)>5 then
				obj.pth,tmp=generateAStarPathBetweenPositions(nil, ox,oy,oz, lx,ly,lz, 0)
			else
				obj.pth=nil
			end	
	end

	if obj.pth and vecLength(ox-lx,oy-ly,oz-lz)>5 then
		obj.task.x=obj.pth.x
		obj.task.y=obj.pth.y-0.5
		obj.task.z=obj.pth.z
	
		obj.task.id=object_action_runtospot
    	obj.task.objInQuestion=obj
    	local ds=vecLength(obj.pth.x-ox, 0, obj.pth.z-oz)
		if ds<gReachedTolerance then
			obj.pth=obj.pth.next
		end
	else
		obj.task.id=object_action_idle
		obj.task.objInQuestion=obj
		obj.task.x=0
		obj.task.y=0
		obj.task.z=0
	end
end


function seekAndDestroy(obj)

	local ox,oy,oz=getObjectInfo(obj.cObj, IG3D_POSITION)

	if not obj.pth then
		local targetObj=getNearestEnemy(obj)
		if targetObj then	
			local lx,ly,lz=getObjectInfo(targetObj.cObj, IG3D_POSITION)
			obj.pth,tmp=generateAStarPathBetweenPositions(nil, ox,oy,oz, lx,ly,lz, 0)
		end		
	end

	if obj.pth then
		obj.task.x=obj.pth.x
		obj.task.y=obj.pth.y-0.5
		obj.task.z=obj.pth.z
	
		obj.task.id=object_action_runtospot
    	obj.task.objInQuestion=obj
    	local ds=vecLength(obj.pth.x-ox, 0, obj.pth.z-oz)
		if ds< gReachedTolerance then
			obj.pth=obj.pth.next
		end
	else
		obj.task.id=object_action_idle
		obj.task.objInQuestion=obj
		obj.task.x=0
		obj.task.y=0
		obj.task.z=0
	end
end

function civilian_with_melee_weapon_behaviour(obj)
	
	if #obj.sensed==0 then 
		seekAndDestroy(obj)
		return
	end
	
	if obj.sensed[1].team == (1-obj.team) and obj.sensed[1].alive then
		
			if obj.sensed[1].seenFlag or seenBefore(obj, obj.sensed[1]) then
				obj.scareDistance=6
				if objdistance(obj,obj.sensed[1]) > obj.farDistance then
					obj.task.id=object_action_runto
					obj.task.objInQuestion=obj.sensed[1]
					obj.farDistance=7.0
				else
					if obj.numGrenades>0 and objdistance(obj,obj.sensed[1])>3 and objdistance(obj,obj.sensed[1])<10  then
						--if has grenade, then throw it
						if obj.task.id~= object_action_throwgrenade then
							obj.nextGunAttack=time()+gNadeThrowDelay
						end
						obj.task.id= object_action_throwgrenade
						obj.task.objInQuestion=obj.sensed[1];
					else
						obj.order={fn=fight_enemy_order, target=obj.sensed[1], x=0, y=0, z=0}
						obj.task.id=object_action_runto
						obj.task.objInQuestion=obj.sensed[1];
						obj.farDistance=10.0
					end
				end
			end
			
		
			if not obj.sensed[1].seenFlag and not seenBefore(obj, obj.sensed[1]) then-- and obj.sensed[1].heardFlag then
				--turn around and look at source of sound
				--obj.task.id=object_action_lookat
				--obj.task.objInQuestion=obj.sensed[1];
				seekAndDestroy(obj)
			end
			
		
	else
		--print(getObjectInfo(obj.sensed[1].cObj, IG3D_NAME), #obj.sensed)
		seekAndDestroy(obj)
	end

end

function idle_until_zombie_in_sight(obj)
	--The default behaviour is to always run away from enemy objects. When a certain distance is reached to enemies, the behaviour changes in finding a vehicle
	
	obj.task.id=object_action_idle
	obj.task.objInQuestion=obj
	obj.task.x=0
	obj.task.y=0
	obj.task.z=0
	
	if #obj.sensed==0 then--remove or true
		return 
	end
	
	if obj.sensed[1].team == (1-obj.team) and obj.sensed[1].alive then
		if obj.sensed[1].seenFlag==true then
			if obj.gun then
				
				obj.behaviour=gunned_civilian_behaviour
			else
				if obj.meleeWeapon then
					obj.behaviour=civilian_with_melee_weapon_behaviour
				else
					obj.behaviour=default_behaviour
				end
			end
		else
			obj.task.id=object_action_lookat
			obj.task.objInQuestion=obj.sensed[1]
			
		end
	end
end

function default_behaviour(obj)
	

	--The default behaviour is to always run away from enemy objects.
	if #obj.sensed==0 then 
		--teamUp(obj)
		randomWalking(obj)
		return 
	end
	

	
	
	if obj.sensed[1].team == (1-obj.team) then
		
		if objdistance(obj,obj.sensed[1]) < obj.scareDistance then
			if not obj.scared then
				play_scared_sound(obj)
			end
			
			obj.scareDistance=6.0--15.0
			obj.scared=true
			standard_flee(obj)
			
		else
			obj.afraidOf=nil
			obj.scared=false
			obj.scareDistance=3.0--6.0
			--teamUp(obj)
			randomWalking(obj)
			
		end
		
		
	else
		randomWalking(obj)
		--teamUp(obj)
	end
end





--is pretty much the same as gunned_civilian_behaviour
--[[
function soldier_behaviour(obj)
	--soldiers
	if #obj.sensed==0 then 
		randomWalking(obj)
		return
	end
	
	if obj.sensed[1].team == (1-obj.team) and obj.sensed[1].alive then
	
		--what to do when a zombie is sighted??
		if obj.sensed[1].seenFlag then
			if obj.numGrenades>0 and objdistance(obj,obj.sensed[1])>3 and objdistance(obj,obj.sensed[1])<10  then
				--if has grenade, then throw it
				if obj.task.id~= object_action_throwgrenade then
					obj.nextGunAttack=time()+gNadeThrowDelay
				end
				obj.task.id= object_action_throwgrenade
				obj.task.objInQuestion=obj.sensed[1];
			else
				--shoot the hell out of the zombie!!!
				if obj.task.id~=object_action_shootat then
					if obj.gun~= nil then obj.nextGunAttack=time()+obj.gun.interval end
				end
				obj.task.id= object_action_shootat
				obj.task.objInQuestion=obj.sensed[1];
			end
		end	
		
		
		--what to do when a zombie was sighted, but is now out of view?
		if not obj.sensed[1].seenFlag and seenBefore(obj, obj.sensed[1]) then
			--run to that zombie
			obj.task.id=object_action_runto
			obj.task.objInQuestion=obj.sensed[1]
		end
		
		--what to do when no zombie is sighted but something is heard?
		if not obj.sensed[1].seenFlag and not seenBefore(obj, obj.sensed[1]) then-- and obj.sensed[1].heardFlag then
			--turn around and look at source of sound
			obj.task.id=object_action_lookat
			obj.task.objInQuestion=obj.sensed[1];
		end
		
	else
		randomWalking(obj)
	end
end
--]]


-- Sniper behavior, stay still and shoot
function sniper_behaviour(obj)

	
		obj.farDistance=30.0
		
	--Soldiers shoot at nearest enemy. If too far away they go closer for shooting. If enemy is very close, they do melee combat. 
	if #obj.sensed==0 then
		obj.task.id=object_action_idle
		obj.task.objInQuestion=obj
		obj.task.x=0
		obj.task.y=0
		obj.task.z=0
		return
	end
	
	if obj.sensed[1].team == (1-obj.team) and obj.sensed[1].alive and objdistance(obj, obj.sensed[1])<obj.farDistance then
		
			
				if obj.task.id~=object_action_shootat then
					if obj.gun~=nil then obj.nextGunAttack=time()+obj.gun.interval+math.random()*2 end
				end
				obj.task.id=object_action_shootat
				obj.task.objInQuestion=obj.sensed[1];
				obj.farDistance=40.0
	else
		obj.task.id=object_action_idle
		obj.task.objInQuestion=obj
		obj.task.x=0
		obj.task.y=0
		obj.task.z=0
			
	end
end 

function standard_flee(obj)
	obj.task.id=object_action_runoff
	obj.task.objInQuestion=obj.sensed[1];
	obj.scareDistance=10
end


function gunned_civilian_behaviour(obj)
	--gunned civs
	if #obj.sensed==0 then 
		seekAndDestroy(obj)
		return
	end
	
	if obj.sensed[1].team == (1-obj.team) and obj.sensed[1].alive then
	
		--what to do when a zombie is sighted??
		if obj.sensed[1].seenFlag then
			if obj.numGrenades>0 and objdistance(obj,obj.sensed[1])>3 and objdistance(obj,obj.sensed[1])<10  then
				--if has grenade, then throw it
				if obj.task.id~= object_action_throwgrenade then
					obj.nextGunAttack=time()+gNadeThrowDelay
				end
				obj.task.id= object_action_throwgrenade
				obj.task.objInQuestion=obj.sensed[1];
			else
				--shoot the hell out of the zombie!!!
				if obj.task.id~=object_action_shootat then
					if obj.gun~= nil then obj.nextGunAttack=time()+obj.gun.interval end
				end
				obj.task.id= object_action_shootat
				obj.task.objInQuestion=obj.sensed[1];
			end
		end	
		
		
		--what to do when a zombie was sighted, but is now out of view?
		if not obj.sensed[1].seenFlag and seenBefore(obj, obj.sensed[1]) then
			--run to that zombie
			obj.task.id=object_action_runto
			obj.task.objInQuestion=obj.sensed[1]
		end
		
		--what to do when no zombie is sighted but something is heard?
		if not obj.sensed[1].seenFlag and not seenBefore(obj, obj.sensed[1]) then-- and obj.sensed[1].heardFlag then
			--turn around and look at source of sound
			--obj.task.id=object_action_lookat
			--obj.task.objInQuestion=obj.sensed[1];
			seekAndDestroy(obj)
		end
		
	else
		seekAndDestroy(obj)
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
		if obj.sensed[i].isVehicle and obj.sensed[i].driver==nil and obj.sensed[i].health>0 then
			veh=obj.sensed[i]
			break
		end
	end
	
	
	if veh==nil or (obj.sensed[1].team == (1-obj.team) and objdistance(obj,obj.sensed[1]) < obj.scareDistance and objdistance(obj,obj.sensed[1])<objdistance(obj,veh)) then
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
	
	
	if house==nil or (obj.sensed[1].team == (1-obj.team) and objdistance(obj,obj.sensed[1]) < obj.scareDistance and objdistance(obj,obj.sensed[1])<objdistance(obj,house)) then
		obj.behaviour=default_behaviour
		obj.behaviour(obj)--do it
	else
		
		obj.task.id=object_action_runto
		obj.task.objInQuestion= house
		if objdistance(obj,house) < gReachedTolerance then
			--recharge guns in houses
			if obj.gun then
				obj.gun.shots=obj.gun.shots+math.random(obj.gun.recharge[1],obj.gun.recharge[2])
				obj.behaviour=gunned_civilian_behaviour
			end
			
			
			obj.task.id=object_action_idle
			obj.task.objInQuestion= obj
		end
		
		
	end
end


function always_idle(obj)
	obj.task.id=object_action_idle
	obj.task.objInQuestion=obj
	obj.task.x=0
	obj.task.y=0
	obj.task.z=0

end


function zombie_hold_behaviour(obj)
	
	obj.task.id=object_action_idle
	obj.task.objInQuestion=obj
	if #obj.sensed>0 then
		if obj.sensed[1].team==1-obj.team then
			obj.task.objInQuestion=obj.sensed[1]
			obj.task.id=object_action_lookat
		end
	end
	obj.task.x=0
	obj.task.y=0
	obj.task.z=0
end

function zombie_rush_behaviour(obj)
	local lx,ly,lz
	if #obj.sensed>0 then
		if obj.sensed[1].team==1-obj.team and obj.sensed[1].alive and obj.sensed[1].seenFlag then
			lx,ly,lz=getObjectInfo(obj.sensed[1].cObj, IG3D_POSITION)
			obj.order={fn=fight_enemy_order_aware, target=obj.sensed[1], x=lx, y=ly, z=lz}
		end
	end
	
	local targetObj=getNearestEnemy(obj)
	if not targetObj then
		targetObj=obj
		obj.behaviour=gZombieBehaviour
	else
		lx,ly,lz=getObjectInfo(targetObj.cObj, IG3D_POSITION)
		obj.order={fn=fight_enemy_order_aware, target=targetObj, x=lx, y=ly, z=lz}
	end
	
	
	--lx,ly,lz=getNearestSafePlacePosition(getObjectInfo(targetObj.cObj, IG3D_POSITION))
	lx,ly,lz=getObjectInfo(targetObj.cObj, IG3D_POSITION)			
	local ox,oy,oz=getObjectInfo(obj.cObj, IG3D_POSITION)
		
			
	if not obj.pth then
		obj.pth,success= generateAStarPathBetweenPositions(targetObj, ox,oy,oz, lx,ly,lz, 0)
		if not success then
			obj.pth=nil
			obj.order=nil
			obj.behaviour=gZombieBehaviour
			obj.health=-10--zombie cannot reach target, probably flew out of scene!
			
			--game_func=handle_udg_astartest
			--print("Exception \"Cannot reach object\":", obj.cObj, targetObj.cObj)
			obj.lastpath=nil
		end
	end
	
	
			
	
	if obj.pth then
		
	
		obj.task.x=obj.pth.x
		obj.task.y=obj.pth.y
		obj.task.z=obj.pth.z
		if obj.mayRush then
			obj.task.id=object_action_runtospot
		else
			obj.task.id=object_action_walktospot
		end
    	obj.task.objInQuestion=obj
    	local ds=vecLength(obj.pth.x-ox, 0, obj.pth.z-oz)
		if ds< gReachedTolerance then
			obj.pth=obj.pth.next
		end
	else
		--game_func=handle_udg_astartest
		obj.task.id=object_action_idle
		obj.task.objInQuestion=obj
		obj.task.x=0
		obj.task.y=0
		obj.task.z=0
	end
		
end

gOldPlayerPosX=0
gOldPlayerPosY=0
gOldPlayerPosZ=0
gPathsSet=true
function zombie_behaviour(obj)
	--setSound_emitterInfo(obj.voiceSndEmt, IG3D_POSITION, getObjectInfo(obj.cObj, IG3D_POSITION))
	--if gActivateStartSounds then setSound_emitterInfo(obj.voiceSndEmt, IG3D_START) end
	

	ox,oy,oz=getObjectInfo(obj.cObj, IG3D_POSITION)
	lx,ly,lz=getObjectInfo(playerBox, IG3D_POSITION)

			
				local needNewPath=false
				if (vecLength(gOldPlayerPosX-lx, gOldPlayerPosY-ly, gOldPlayerPosZ-lz)>2.5 and obj.task.id~= object_action_eat) then needNewPath = true end
				if not obj.nearPlayer and not obj.followPlayer then needNewPath= true end
				--if not obj.pth then needNewPath=true end
				
				if needNewPath and object_may_astar(obj) then
					local success
					obj.pth,tmp = generateAStarPathBetweenPositions(nil, ox,oy,oz, lx,ly,lz,0)
					obj.followPlayer=true
					gPathsSet=true
				end
			
			
	if obj.pth then		
  
    	local ds=vecLength(obj.pth.x-ox, 0, obj.pth.z-oz)
		if ds< gReachedTolerance then
		
			if obj.pth.next==nil or obj.nearPlayer then
				--randomWalking(obj)
				obj.task.id=object_action_idle
				obj.task.objInQuestion=obj
				--obj.followPlayer=false
				setObjectInfo(obj.cObj, IG3D_OMEGA, 0,0,0)
				return
			end
			obj.pth=obj.pth.next
		end
	
	
		obj.task.x=obj.pth.x
		obj.task.y=obj.pth.y-0.5
		obj.task.z=obj.pth.z
	
		obj.task.id=object_action_walktospot
    	obj.task.objInQuestion=obj
    else
    	obj.task.id=object_action_idle
		obj.task.objInQuestion=obj
		--obj.followPlayer=false
		setObjectInfo(obj.cObj, IG3D_OMEGA, 0,0,0)
    
    end
    
end
