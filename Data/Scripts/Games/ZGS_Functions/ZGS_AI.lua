--[[ Attempt of designing AI

Every object manages a task priority queue.

In every game frame do the following for every thinking and living object in the scene (called the "active object" in the following):
1. Handle the active object's sences:
	- Eyes: Collect list of all visible objects (field of view and occlusion checking)
	- Ears: Add to the list of visible objects all objects that can be heard by performing range checks.
	

2. Sort the list of perceived objects by priority
	The priority depends on the team of the perceived object, its distance to the active object, whether it is alive or not and other not yet specified parameters.
	Note that the queue is not completely redone every frame because that would remove objects that are "hiding" from the mind of the active object. Only corpses with nothing left to pick up from are removed from the queue and not considered to be added again.

3. Analyse the list of perceived objects and the tasks of the active object:
	- Check if the object on top of the priority queue is so important that the active object needs to stop its task and deal with it.
		If that is the case, create a task considering this object and put it on top of the task queue

4. Handle the top task in the task priority queue, delete tasks that are done
--]]
-- requires gameroot.."Data/Scripts/Default/Base/math_functions.lua"
-- requires /ZGS_Functions/".."Senses","Vehicles","Weapons","Orders","Utilities"





gSensesInterval=0.7 --handle object senses in this time interval
gSensesTime=0.0
gRelevantActingDistance=50.0
gZoomDistance=4.0
gLookAround=180.0
gTrackedObject=1--12
gInverseGameSpeed=1.0
gSpeedResetTime=0.0
gOldGameSpeed=1.0
gActivateStartSounds=true
gTrackedPosition={x=0,y=0,z=0}
gObjects[gTrackedObject].selected=true
gTrackedPosition.x,gTrackedPosition.y,gTrackedPosition.z=getObjectInfo(gObjects[gTrackedObject].cObj, IG3D_POSITION)
gSelectionRect={clickleft=0, clicktop=0, left=0,top=0,right=0,bottom=0}
gDraggingSelRect=false

function computeLODModelName(obj)
	local name=getObjectInfo(obj.cObj, IG3D_NAME)
	local pth=ig3d_GetObjectModelPath_s_s(name)
	return string.sub(pth,#gameroot+10,-5).."low.wtf"
end


function handle_senses(obj)
	
	
	
	--handle_object_eyes(obj)
	handle_object_ears(obj)
	-- .... handle other senses
end


function comparePriorities(a,b)
	return a.prio>b.prio
end

function sort_perceived_objects_by_priority(obj)
	local i
	local prio

	for i=1,#obj.sensed,1 do
		--calculate priorities of perceived objects (high numbers are high priorities)
		prio=0--absolutely unimportant
		if obj.sensed[i].seenFlag then
			--seen somebody -> important
			prio=prio+2
		end
		
		if obj.sensed[i].heardFlag then
			--heard somebody -> not that important
			prio=prio+1
		end
		
		if obj.sensed[i].team~= obj.team and obj.sensed[i].alive then
			--sensed an enemy -> very important
			prio=prio+3
		end
		
		
		prio=prio * math.max( gRelevantActingDistance-objdistance(obj,obj.sensed[i]), 1.0)
		obj.sensed[i].prio=math.floor(prio)
		
		--remember the object
		unique_mind_insert(obj.mind, {o=obj.sensed[i], heardFlag=obj.sensed[i].heardFlag, seenFlag=obj.sensed[i].seenFlag})
	end
	
	table.sort(obj.sensed, comparePriorities)

	
end
	
	
--a list of object to object actions follows. Depending on the behaviour such actions can be put into a task
object_action_goto=1
object_action_runoff=2
object_action_shootat=3
object_action_enter=4 --like a house or vehicle
object_action_pickup=5 --an item like a weapon or health pack
object_action_idle=6 --do anything
object_action_lookat=7
object_action_runto=8
object_action_melee=9
object_action_drive=10
object_action_reanimate=11
object_action_runtospot=12
object_action_eat=13
object_action_walktospot=14

function handle_behaviour(obj)
	obj.behaviour(obj)
end

function handle_health(obj)
	if obj.health<=0 and obj.driver then
		obj.driver.health=-10
		obj.driver.selected=false
		obj.driver.vehicle=nil
		obj.driver.behaviour=default_behaviour
		obj.driver.task.anim="fell from car"
		setObjectInfo(obj.driver.cObj, IG3D_COLL, true)
		a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)
		setObjectInfo(obj.driver.cObj, IG3D_POSITION, a41+a31, a42+1.2+a32, a43+a33)
		setObjectInfo(obj.driver.cObj, IG3D_VELOCITY, a31*5, a32*5, a33*5)
		setObjectInfo(obj.driver.cObj, IG3D_OMEGA, 0,0,0)
		setObjectInfo(obj.driver.cObj, IG3D_GRAVITY_MULTIPLIER, 1)

		drive_car_around(obj, false,false,true,true,0,0)
		obj.driver=nil
		--setObjectInfo(obj.cObj, IG3D_VEHICLE, false)		
		setSound_emitterInfo(obj.skidSndEmt, IG3D_STOP)
		setSound_emitterInfo(obj.engineSndEmt, IG3D_STOP)
		--setObjectInfo(obj.cObj, IG3D_RAGDOLL, true)
		--setObjectInfo(obj.cObj, IG3D_COLL, false)
		--setObjectInfo(obj.cObj, IG3D_GRAVITY_MULTIPLIER, 0)
		--obj.freezeTime=time()+5.0
	end
	
	if obj.health<=0 and obj.alive then
		if obj.vehicle then
			drive_car_around(obj.vehicle, false,false,true,true,0,0)
			obj.vehicle.driver=nil
			obj.vehicle.health=-10
			setSound_emitterInfo(obj.vehicle.skidSndEmt, IG3D_STOP)
			setSound_emitterInfo(obj.vehicle.engineSndEmt, IG3D_STOP)
			obj.vehicle=nil
		end
		obj.alive=false
		setObjectInfo(obj.cObj, IG3D_ANIMATION, "STOP", 0, false)
		setObjectInfo(obj.cObj, IG3D_RAGDOLL, true)
		obj.freezeTime=time()+5.0
		obj.order=nil
		obj.selected=false
		
		if obj.team==1 then
			setSound_emitterInfo(obj.zombieSndEmt, IG3D_STOP)
		end
	end
end


function task_to_string(tsk)
	local str
	if tsk.id==object_action_goto then str="Go to " end
	if tsk.id==object_action_runoff then str="Run away from " end
	if tsk.id==object_action_shootat then str="Shoot at " end
	if tsk.id==object_action_enter then str="Enter building/vehicle " end
	if tsk.id==object_action_pickup then str="Pickup " end
	if tsk.id==object_action_idle then str="Idling " end
	if tsk.id==object_action_lookat then str="Looking at " end
	if tsk.id==object_action_runto then str="Running towards " end
	if tsk.id==object_action_melee then str="Doing melee combat against " end
	if tsk.id==object_action_drive then str="Driving vehicle " end
	if tsk.id==object_action_reanimate then str="Reanimating " end
	if tsk.id==object_action_runtospot then str="Running to " end
	if tsk.id==object_action_eat then str="Eating " end
	if tsk.id==object_action_walktospot then str="Walking to " end
	
	return str..getObjectInfo(tsk.objInQuestion.cObj, IG3D_NAME)	
end




function do_task(obj)
		--zgs_print("Task of "..getObjectInfo(obj.cObj, IG3D_NAME)..": "..task_to_string(obj.task) )
	
	
		
    	local prx,pry,prz=getObjectInfo(obj.cObj,IG3D_POSITION)
    	posstring="   Y= "..math.ceil(pry)
    	if pry<-15 then
    		--putObjectOnGround(obj)
    		beep()
    		ig3d_SetMode_i(1)
    		zgs_print(getObjectInfo(obj.cObj, IG3D_NAME))
    	end
   -- if click("-") then
      -- zgs_print("Task of "..getObjectInfo(obj.cObj, IG3D_NAME)..": "..task_to_string(obj.task)..posstring )
    
--	end
		
		
	obj.oldanimname=obj.anim.name
	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)
	
	if obj.task.id==object_action_goto then
		turn_towards(obj, obj.task.objInQuestion)
		obj.anim.name="Walk"
		obj.anim.vx=1.2*a31
		obj.anim.vy=1.2*a32
		obj.anim.vz=1.2*a33
		obj.anim.link=false		
	end
	
	if obj.task.id==object_action_runoff then
		turn_away_from(obj, obj.task.objInQuestion)
		obj.anim.name="Run"
		obj.anim.vx=2*a31
		obj.anim.vy=2*a32
		obj.anim.vz=2*a33
		obj.anim.link=false
	end
	
	if obj.task.id==object_action_runto then
		turn_towards(obj, obj.task.objInQuestion)
		obj.anim.name="Run"
		obj.anim.vx=2*a31
		obj.anim.vy=2*a32
		obj.anim.vz=2*a33
		obj.anim.link=false
	end
	
	if obj.task.id==object_action_runtospot then
		turn_towards_spot(obj, obj.task.x, obj.task.y, obj.task.z)
		obj.anim.name="Run"
		obj.anim.vx=2*a31
		obj.anim.vy=2*a32
		obj.anim.vz=2*a33
		obj.anim.link=false
	end
	
	if obj.task.id==object_action_walktospot then
		turn_towards_spot(obj, obj.task.x, obj.task.y, obj.task.z)
		obj.anim.name="Walk"
		obj.anim.vx=1.2*a31
		obj.anim.vy=1.2*a32
		obj.anim.vz=1.2*a33
		obj.anim.link=false		
	end
	
	
	
	if obj.task.id==object_action_shootat then
		turn_towards(obj, obj.task.objInQuestion)
		obj.anim.name="Shoot"
		obj.anim.vx=0
		obj.anim.vy=0
		obj.anim.vz=0
		obj.anim.link=true
		if time()>obj.nextGunAttack and obj.gun~=nil then
			
			local x,y,z=getObjectInfo(obj.gun.cObj, IG3D_POSITION)--gun
			x=x+a31*0.2
			y=y+a32*0.2
			z=z+a33*0.2
			local x2,y2,z2=getObjectInfo(obj.task.objInQuestion.cObj, IG3D_POSITION)
			x2=x2-0.1+math.random()*0.2
			y2=y2-0.1+math.random()*0.45
			z2=z2-0.1+math.random()*0.2
			local dx,dy,dz=normalized(x2-x, y2-y, z2-z)

			if dot(a31,a32,a33, dx,dy,dz) > 0.707 and not aimingAtFriendlyObject(obj,x-dx,y-dy,z-dz, x2,y2,z2) then
				
				setParticle_emitterInfo(gGunEmitter, IG3D_POSITION, x,y,z)
				setParticle_emitterInfo(gGunEmitter, IG3D_ROTATION, dirToAngles(dx,dy,dz))
				setParticle_emitterInfo(gGunEmitter, IG3D_START)
				setSound_emitterInfo(obj.gunSndEmt, IG3D_POSITION, x,y,z)
				setSound_emitterInfo(obj.gunSndEmt, IG3D_START)
				obj.nextGunAttack=time()+obj.gunInterval
				setParticle_emitterInfo(muzzleFlash, IG3D_POSITION, x,y,z)
				setParticle_emitterInfo(muzzleFlash, IG3D_START)
				obj.gun.shots=obj.gun.shots-1
				if obj.gun.shots<= 0 then
					obj.order=nil
					obj.behaviour=default_behaviour
				end
			end
			
		end
		
	end
	
	if obj.task.id==object_action_melee then
		turn_towards(obj, obj.task.objInQuestion)
		obj.anim.name="Punch"
		obj.anim.vx=0
		obj.anim.vy=0
		obj.anim.vz=0
		obj.anim.link=true
		if time()>obj.nextMeleeAttack then
			obj.task.objInQuestion.health=obj.task.objInQuestion.health-(10+math.random(20))
			obj.nextMeleeAttack=time()+obj.meleeInterval
			if obj.task.objInQuestion.health<0 and obj.team==1 then
				obj.order={fn=eat_dead_human, target=obj.task.objInQuestion, bonesEaten=0}
				obj.nextMeleeAttack=time()+3.0
			end
			
			unique_mind_insert(obj.task.objInQuestion.mind, {o=obj, seenFlag=true, heardFlag=true})--remember people that fight me
		end
	end
	
	if obj.task.id==object_action_idle then
		obj.anim.name="Stand"
		obj.anim.vx=0
		obj.anim.vy=0
		obj.anim.vz=0
		obj.anim.link=true
	end
	
	
	if obj.task.id==object_action_lookat then
		turn_towards(obj, obj.task.objInQuestion)
		obj.anim.name="Stand"
		obj.anim.vx=0
		obj.anim.vy=0
		obj.anim.vz=0
		obj.anim.link=false
	end
	
	if obj.task.id==object_action_drive then
		obj.anim.name="Drive"
		obj.anim.vx=0
		obj.anim.vy=0
		obj.anim.vz=0
		obj.anim.link=false
		
		local x,y,z=getObjectInfo(obj.vehicle.cObj, IG3D_POSITION)
		local a={0.5, false,false,true,false,0,0} -- brake by default
		
		dirs={"right","left","uturn","straight"};
		--Are we too fast?...
		local vx,vy,vz=getObjectInfo(obj.vehicle.cObj, IG3D_VELOCITY)
		local vmag=vecLength(vx,vy,vz)
		if vmag>10 then
			obj.footOnGas=false
		else
			local fr=get(ig3d_bone, obj.vehicle.cObj, "RightFrontWheel")
			local strgnl=getBoneInfo(fr, IG3D_STEERING_ANGLE)
			if math.abs(strgnl)<0.5 or vmag<4 then
				obj.footOnGas=true
			else
				obj.footOnGas=false
			end
		end
		
		
		--do we have a target crossing yet?...
		if obj.targetCrossing==nil then
			local dx,dy,dz
			dx,dy,dz= nearestCrossing(x,y,z,64)
			obj.nextTurn=dirs[math.random(1,4)]
			if math.abs(dx)>=192 or math.abs(dz)>=192 then
				obj.nextTurn="uturn"
			end
			
			dx,dy,dz= correctCrossingPosition(x,y,z,dx,dy,dz, obj.nextTurn)
			obj.targetCrossing={dx,dy,dz}
		end

		---are we reaching the crossing...
		local dst=vecLength(x-obj.targetCrossing[1],y-obj.targetCrossing[2],z-obj.targetCrossing[3])
		if dst<15 then
			obj.brakeToVelocity=6
		end
		if dst<6 then
			obj.brakeToVelocity=4
		end
		
		if dst<5 then
			dx,dy,dz=getNextCrossingPosition(x,y,z, obj.targetCrossing[1],obj.targetCrossing[2],obj.targetCrossing[3], obj.nextTurn)
			obj.nextTurn=dirs[math.random(1,4)]
			if math.abs(dx)>=192 or math.abs(dz)>=192 then
				obj.nextTurn="uturn"
			end
			obj.targetCrossing[1],obj.targetCrossing[2],obj.targetCrossing[3]= correctCrossingPosition(x,y,z,dx,dy,dz,obj.nextTurn)
		end
		
		--brake?
		if obj.brakeToVelocity~= nil then
			if vmag<=obj.brakeToVelocity then obj.brakeToVelocity=nil end
		end
		
		--accelerate?...
		if obj.brakeToVelocity== nil then
			a=steer_aim(obj.vehicle, obj.targetCrossing[1],obj.targetCrossing[2],obj.targetCrossing[3])
			a[2]=obj.footOnGas
		end
		
		local thecar=obj.vehicle
		if car_stuck(obj.vehicle) then
			a[2]=false
			a[3]=true
			a[4]=false
			a[5]=false
			a[6]=0
			a[7]=0
			if car_flipped(obj.vehicle) then
				a[2]=false
				a[3]=false
				a[4]=true
				a[5]=true
				a[6]=0
				a[7]=0
				obj.vehicle.health=-10
				setObjectInfo(obj.cObj, IG3D_ROTATION, 0,0,0)
				local x,y,z=getObjectInfo(obj.cObj, IG3D_POSITION)
				setObjectInfo(obj.cObj, IG3D_POSITION, x,y+10,z)
				putObjectOnGround(obj)
				obj.vehicle.driver=nil
				setSound_emitterInfo(obj.vehicle.skidSndEmt, IG3D_STOP)
				setSound_emitterInfo(obj.vehicle.engineSndEmt, IG3D_STOP)
				obj.vehicle=nil
				obj.order=nil
				obj.behaviour=default_behaviour
				setObjectInfo(obj.cObj, IG3D_COLL, true)
				setObjectInfo(obj.cObj, IG3D_GRAVITY_MULTIPLIER, 1)
			end
		end
		--handle the car
		drive_car_around(thecar, a[2], a[3], a[4], a[5], a[6], a[7])
		
	end
	
	if obj.task.id==object_action_reanimate then
		obj.anim.name="Stand"
		obj.anim.vx=0
		obj.anim.vy=0
		obj.anim.vz=0
		obj.anim.link=false
		
		if time()>= obj.reanimateTime then
			obj.behaviour=zombie_behaviour
		end
	end
	
	if obj.task.id==object_action_eat then
		turn_towards_obj_bone(obj, obj.task.objInQuestion, "head")
		obj.anim.name="Eat"
		obj.anim.vx=0
		obj.anim.vy=0
		obj.anim.vz=0
		obj.anim.link=false
		if time()>obj.nextMeleeAttack then
			obj.order.bonesEaten=obj.order.bonesEaten+1
			local bn1=get(ig3d_bone, obj.cObj, "head")
			
			local bn=get(ig3d_bone, obj.task.objInQuestion.cObj, obj.order.bonesEaten)
			--setBoneInfo(bn, IG3D_ENABLED, false)
			obj.nextMeleeAttack=time()+0.4
			local dx,dy,dz=getBoneInfo(bn1, IG3D_POSITION)
			local result,x,y,z,u,v,m=getObjectInfo(obj.task.objInQuestion.cObj, IG3D_EXACT_COLLISION_DATA, dx-0.2+math.random()*0.4,dy+1,dz-0.2+math.random()*0.4,dx-0.2+math.random()*0.4,dy-1,dz-0.2+math.random()*0.4)
			if result then
				drawToTexture( getMaterialInfo(m, IG3D_TEXTURE, 3), "Data/Images/Decals/bloodpencil"..(math.random(1,3))..".png",u,v, IG3D_ADD, IG3D_REPEAT)
				obj.blood=true
			end
			setParticle_emitterInfo(bloodParticles, IG3D_POSITION, dx,dy,dz)
			setParticle_emitterInfo(bloodParticles, IG3D_ROTATION, getObjectInfo(obj.cObj, IG3D_ROTATION))
			setParticle_emitterInfo(bloodParticles, IG3D_START)
			if obj.order.bonesEaten==50 then
				obj.order=nil
				obj.task.objInQuestion.team=1
				obj.task.objInQuestion.behaviour=zombie_behaviour
				obj.task.objInQuestion.freezeTime=time()+4.0
					
						
						table.insert(zombies,objInQuestion)
						table.remove(humans,objInQuestion)
						
					
			end
			
		end
	end
	
	
	-----run the animation and set velocity

	if obj.anim.name~=obj.oldanimname then
		local altAnim
		altAnim, obj.anim.link=getRandomAnimationOfStyle(obj.animPickTable, obj.anim.name, obj.anim.link)
		obj.anim.link=false--REMOVE ME OR IMPROVE ME
		setObjectInfo(obj.cObj, IG3D_LINK_MAIN_BONE_TO_VELOCITY, obj.anim.link)
		setObjectInfo(obj.cObj, IG3D_ANIMATION, altAnim,0,true)
	end
	local vx,vy,vz=getObjectInfo(obj.cObj, IG3D_VELOCITY)
	if obj.anim.vx~=0 or obj.anim.vz~=0 then

		setObjectInfo(obj.cObj, IG3D_VELOCITY, obj.anim.vx*obj.pace, vy, obj.anim.vz*obj.pace)
	end
end


---replace the behaviour task with the order task if there is one
function handle_order_and_behaviour(obj)
	if obj.order~=nil then
		obj.order.fn(obj, obj.order.target)
		if obj.order==nil then -- the order might have killed itself!!!
			handle_behaviour(obj)
		end
	else
		handle_behaviour(obj)
	end

end


function handle_ai(obj, dosenses)
	--zgs_print("--Handling "..getObjectInfo(obj.cObj, IG3D_NAME))
	
	for i=1,#obj.sensed,1 do
		table.remove(obj.sensed)
	end
	
	if dosenses then
		handle_senses(obj)
	end
	handle_object_remembering(obj)
	sort_perceived_objects_by_priority(obj)
	handle_order_and_behaviour(obj)--orders override behaviours
	do_task(obj)
end




