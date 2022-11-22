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
-- requires gameroot.."Data/Scripts/Functions/Default/Base/math_functions.lua"
-- requires /RTS_Functions/".."Senses","Vehicles","Weapons","Orders","Utilities"





gSensesInterval=0.7 --handle object senses in this time interval
gSensesTime=0.0
gRelevantActingDistance=50.0
gZoomDistance=8.0
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
gDanger=nil

function computeLODModelName(obj)
	local name=getObjectInfo(obj.cObj, IG3D_NAME)
	local pth=ig3d_GetObjectModelPath_s_s(name)
	return string.sub(pth,#gameroot+10,-5).."low.wtf"
end

function computeShadowModelName(obj)
	local name=getObjectInfo(obj.cObj, IG3D_NAME)
	local pth=ig3d_GetObjectModelPath_s_s(name)
	return string.sub(pth,#gameroot+10,-5).."shadow.wtf"
end

function handle_senses(obj)
	handle_object_eyes(obj)
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
		prio=0--absolutely unimportant... was 0
		if obj.sensed[i].seenFlag then
			--seen somebody -> important
			prio=prio+2
		end
		
		if obj.sensed[i].heardFlag then
			--heard somebody -> not that important
			prio=prio+1
		end
		
		if obj.sensed[i].team== (1-obj.team) and obj.sensed[i].alive then
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
object_action_sidestep=15
object_action_cry=16
object_action_kick=17
object_action_hit=18
object_action_punchair=19
object_action_stab=20
object_action_reloadgun=21
object_action_fightfurniture=22
object_action_throwgrenade=23
object_action_keep=24
object_action_jump=25
object_action_headshot=26
object_action_chestshot=27

function handle_behaviour(obj)
	obj.behaviour(obj)
end

function handle_health(obj)
	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)
	if obj.health<=0 and obj.driver then
		obj.driver.health=-10
		obj.driver.selected=false
		obj.driver.vehicle=nil
		obj.driver.behaviour=default_behaviour
		obj.driver.task.anim="fell from car"
		setObjectInfo(obj.driver.cObj, IG3D_COLL, true)
		setObjectInfo(obj.driver.cObj, IG3D_POSITION, a41+a31, a42+1.2+a32, a43+a33)
		setObjectInfo(obj.driver.cObj, IG3D_VELOCITY, a31*5, a32*5, a33*5)
		setObjectInfo(obj.driver.cObj, IG3D_OMEGA, 0,0,0)
		setObjectInfo(obj.driver.cObj, IG3D_GRAVITY_MULTIPLIER, 1)

		drive_car_around(obj, false,false,true,true,0,0)
		obj.driver=nil
		--setObjectInfo(obj.cObj, IG3D_VEHICLE, false)		
		setSound_emitterInfo(obj.skidSndEmt, IG3D_STOP)
		setSound_emitterInfo(obj.engineSndEmt, IG3D_STOP)
		--setObjectInfo(obj.cObj, IG3D_COLL, false)
		--setObjectInfo(obj.cObj, IG3D_GRAVITY_MULTIPLIER, 0)
		--obj.freezeTime=time()+5.0
	end
	
	
	
	
	
	if obj.health<=0 and obj.alive then
		
		obj.deathCount=obj.deathCount-1
		if obj.headshot then
			obj.deathCount=0
			obj.headshot=false
		end
		
		if obj.vehicle then
			drive_car_around(obj.vehicle, false,false,true,true,0,0)
			obj.vehicle.driver=nil
			obj.vehicle.health=-10
			setSound_emitterInfo(obj.vehicle.skidSndEmt, IG3D_STOP)
			setSound_emitterInfo(obj.vehicle.engineSndEmt, IG3D_STOP)
			obj.vehicle=nil
		end
		obj.alive=false
		
		
		
		--people that die throw a grenade into the air, if they have one!
		if obj.numGrenades>0 and obj.team==0 then
			throw_grenade(a41,a42+0.6,a43, 0,1,0)
		end
		--
		
		setObjectInfo(obj.cObj, IG3D_IGNORE_OBJECT_COLLS, true)--true
		setObjectInfo(obj.cObj, IG3D_ANIMATION, "STOP", 0, false)
		setObjectInfo(obj.cObj, IG3D_RAGDOLL, true)
		obj.freezeTime=time()+3
		obj.order=nil
		obj.selected=false
		obj.event=nil
		if obj.gun then
			resetCollisionToDefault(obj.gun)
			setObjectInfo(obj.gun.cObj, IG3D_GRAVITY_MULTIPLIER, 1)
			setObjectInfo(obj.gun.cObj, IG3D_COLL, true)
			setObjectInfo(obj.gun.cObj, IG3D_IGNORE_OBJECT_COLLS, true)
			setObjectInfo(obj.gun.cObj, IG3D_VELOCITY, 1,5,1)
			obj.gun=nil
			obj.task.id=object_action_idle
			obj.task.objInQuestion=obj
		end
		
		if obj.meleeWeapon then
			resetCollisionToDefault(obj.meleeWeapon)
			setObjectInfo(obj.meleeWeapon.cObj, IG3D_GRAVITY_MULTIPLIER, 1)
			setObjectInfo(obj.meleeWeapon.cObj, IG3D_COLL, true)
			setObjectInfo(obj.meleeWeapon.cObj, IG3D_IGNORE_OBJECT_COLLS, true)
			setObjectInfo(obj.meleeWeapon.cObj, IG3D_VELOCITY, 1,5,1)
			obj.meleeWeapon =nil
			obj.task.id=object_action_idle
			obj.task.objInQuestion=obj
		end
		
		if obj.impulse then
			setObjectInfo(obj.cObj, IG3D_IMPULSE, obj.impulse[1],obj.impulse[2],obj.impulse[3],obj.impulse[4],obj.impulse[5],obj.impulse[6])
			obj.impulse=nil
		end
		
		if obj.team==1 then
			obj.mayRush=false
		end
		
		if obj.team==0 and obj~=gObjects[playerBox] then 
			obj.team=1
			obj.behaviour= gZombieBehaviour
			obj.meleeDelay=0.5
			--obj.freezeTime=time()+7.0
		end
	end
	
	if obj.health<=0 and obj.house then
		if obj.team==windowTeam or obj.glass then
			play_glass_break_sound(obj)
		end
		destroyDoor(obj)
	end
	
	
	
	if obj.health<=0 then
		rts_update_living_and_dead_counts()
	
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
	if tsk.id==object_action_sidestep then str="Steps sideways away from " end
	if tsk.id==object_action_cry then str="Cries " end
	if tsk.id==object_action_kick then str="Kicks head of " end
	if tsk.id==object_action_hit then str="Was hit by " end
	if tsk.id== object_action_punchair then str="Punches air " end
	if tsk.id== object_action_stab then str="Stabs " end
	if tsk.id== object_action_reloadgun then str="Reloads gun " end
	if tsk.id== object_action_fightfurniture then str="Fights windmills " end
	if tsk.id== object_action_throwgrenade then str="Throws grenade at " end
	if tsk.id== object_action_keep then str="Continues his animation " end
	if tsk.id== object_action_jump then str="Jumps over " end
	if tsk.id== object_action_headshot then str="Was shot in the head by " end
	if tsk.id== object_action_chestshot then str="Was shot in the chest by " end
	
	local n
	if tsk.objInQuestion==nil then n="nil" else	n=getObjectInfo(tsk.objInQuestion.cObj, IG3D_NAME) end
	return str..n	
end



function try_to_reach_object(obj, target)
	local ox,oy,oz=getObjectInfo(obj.cObj, IG3D_POSITION)
	local lx,ly,lz=getObjectInfo(target.cObj, IG3D_POSITION)
--b11,b12,b13,b14, b21,b22,b23,b24, b31,b32,b33,b34, b41,b42,b43,b44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)
	local dx,dy,dz=normalized(lx-ox,0,lz-oz)
	local sidex,sidey,sidez=normalized(cross(dx,dy,dz, 0,1,0))
	lx=lx-dx*0.15
	lz=lz-dz*0.15
	
	
	--This code is essential
	if objdistance(obj,target)<3 then
		if not lineCollision(ox-dx,oy-0.3-dy,oz-dz, lx,oy-0.3,lz, true) and not lineCollision(ox+sidex*0.31-dx,oy-0.3-dy,oz+sidez*0.31-dz, lx+0.31*sidex,oy-0.3,lz+0.31*sidez, true) and not lineCollision(ox-sidex*0.31-dx,oy-0.3-dy,oz-sidez*0.31-dz, lx-0.31*sidex,oy-0.3,lz-0.31*sidez, true) then
			obj.task.x=lx
			obj.task.y=ly
			obj.task.z=lz
			return
		end
	end
	
	
	--otherwise use paths
	if obj.pth then
		--only set new path if the target position differs much
		if not obj.lastpath or vecLength(obj.lastpath.last.x-lx, 0, obj.lastpath.last.z-lz)>objdistance(obj,target)/2 then --gGridSize
			obj.pth, success =generateAStarPathBetweenPositions(target, ox,oy,oz, lx,ly,lz, 0)
			if success then
				obj.lastpath=obj.pth
			else
				--game_func=handle_udg_astartest
				--print("Exception \"Cannot reach object\":", obj.cObj, target.cObj)
				obj.lastpath=nil
			end
		end
	else
		obj.pth, success =generateAStarPathBetweenPositions(target, ox,oy,oz, lx,ly,lz, 0)
		if success then
			obj.lastpath=obj.pth
		else
			--game_func=handle_udg_astartest
			--print("Exception \"Cannot reach object\":", obj.cObj, target.cObj)
			obj.lastpath=nil
		end
		
	end
	
	
	
	obj.task.x=obj.pth.x
	obj.task.y=obj.pth.y
	obj.task.z=obj.pth.z
	
	--dont merge these two if blocks!! it makes sense!
	if obj.pth then
		local ds=vecLength(obj.pth.x-ox, 0, obj.pth.z-oz)
		if ds < gReachedTolerance then
			obj.pth=obj.pth.next	
		end
	end

	

end

function do_task(obj)


    	local prx,pry,prz=getObjectInfo(obj.cObj,IG3D_POSITION)
    	--posstring="   Y= "..math.ceil(pry)
    	if pry<-15 then
    		--probably out of level...kill
    		obj.health=-10
    		obj.deathCount=0
    		--[[
    		setObjectInfo(obj.cObj, IG3D_POSITION, prx,pry+15,prz)
    		putObjectOnGround(obj)
    		RTS_print(getObjectInfo(obj.cObj, IG3D_NAME))
    		--]]
    	end

	
	
	--zombies have their own anims
	if obj.team==1 then
		obj.animPickTable=zombieAnims
	end
		
	obj.oldanimname=obj.anim.name
	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)
	
	if obj.task.id==object_action_cry then
		turn_towards(obj, obj.task.objInQuestion)
		obj.anim.name="Cry"
		obj.anim.vx=0
		obj.anim.vy=0
		obj.anim.vz=0
		obj.anim.link=false
		return	
	end
	
	if obj.task.id== object_action_reloadgun then
		turn_towards(obj, obj.task.objInQuestion)
		obj.anim.name="ReloadGun"
		obj.anim.vx=0
		obj.anim.vy=0
		obj.anim.vz=0
		obj.anim.link=false
		return	
	end
	
	if obj.task.id== object_action_fightfurniture then
		--turn_towards(obj, obj.task.objInQuestion)
		obj.anim.name="Punch"
		obj.anim.vx=0
		obj.anim.vy=0
		obj.anim.vz=0
		obj.anim.link=false
		return
	end
	
	if obj.task.id== object_action_jump then
		--turn_towards(obj, obj.task.objInQuestion)
		if obj.oldanimname~="Walk" and obj.oldanimname~="Run" then
			obj.anim.name="JumpOverSomething"
		end
		obj.anim.vx=obj.task.x
		obj.anim.vy=obj.task.y
		obj.anim.vz=obj.task.z
		obj.anim.link=false
		setObjectInfo(obj.cObj, IG3D_OMEGA, 0,0,0)
		return
	end
	
	if obj.task.id== object_action_throwgrenade then
		local px,py,pz=getObjectInfo(obj.task.objInQuestion.cObj, IG3D_POSITION)
		local dx,dy,dz=normalized(px-a41,py+0.5-a42,pz-a43)
		turn_towards(obj, obj.task.objInQuestion)
		if obj.numGrenades>0 and time()>obj.nextGunAttack then
			throw_grenade(a41+dx,a42+dy+0.2,a43+dz, dx,dy,dz)
			obj.numGrenades=obj.numGrenades-1
			obj.nextGunAttack=time()+2
		end
		obj.anim.name="Punch"
		obj.anim.vx=0
		obj.anim.vy=0
		obj.anim.vz=0
		obj.anim.link=false
		return	
	end
	
	
	
	if obj.task.id==object_action_kick then
		turn_towards(obj, obj.task.objInQuestion)
		obj.anim.name="Kick"
		obj.anim.vx=0
		obj.anim.vy=0
		obj.anim.vz=0
		obj.anim.link=false
		return	
	end
	
	
	
	if obj.task.id==object_action_stab then
		turn_towards(obj, obj.task.objInQuestion)
		obj.anim.name="PunchWithTwoHandedWeapon"
		obj.anim.vx=0
		obj.anim.vy=0
		obj.anim.vz=0
		obj.anim.link=false
		return	
	end
	
	if obj.task.id==object_action_hit then
		turn_towards(obj, obj.task.objInQuestion)
		obj.anim.name="Pushed"
		obj.anim.vx=-a31*obj.task.x
		obj.anim.vy=-a32*obj.task.y
		obj.anim.vz=-a33*obj.task.z
		obj.anim.link=false
		return
	end
	
	if obj.task.id==object_action_headshot then
		--turn_towards(obj, obj.task.objInQuestion)
		obj.anim.name="Headshot"
		obj.anim.vx=0
		obj.anim.vy=0
		obj.anim.vz=0
		obj.anim.link=false
		return
	end
	
	if obj.task.id==object_action_chestshot then
		--turn_towards(obj, obj.task.objInQuestion)
		obj.anim.name="ChestShot"--"Headshot"
		obj.anim.vx=0
		obj.anim.vy=0
		obj.anim.vz=0
		obj.anim.link=false
		return
	end
	
	if obj.task.id==object_action_punchair then
		turn_towards(obj, obj.task.objInQuestion)
		obj.anim.name="Punch"
		obj.anim.vx=0
		obj.anim.vy=0
		obj.anim.vz=0
		obj.anim.link=false
		return	
	end
	
	if obj.task.id==object_action_goto then
		--turn_towards(obj, obj.task.objInQuestion)
		try_to_reach_object(obj, obj.task.objInQuestion)
		turn_towards_spot(obj, obj.task.x, obj.task.y, obj.task.z)
		obj.anim.name="Walk"
		obj.anim.vx=1.2*a31
		obj.anim.vy=1.2*a32
		obj.anim.vz=1.2*a33
		obj.anim.link=false
		return	
	end
	
	if obj.task.id==object_action_runoff then
		turn_away_from(obj, obj.task.objInQuestion)
		obj.anim.name="Run"
		local runspeed=2
		if obj.team==1 then runspeed=1.8 end
		obj.anim.vx= runspeed*a31
		obj.anim.vy= runspeed*a32
		obj.anim.vz= runspeed*a33
		obj.anim.link=false
		return
	end
	
	if obj.task.id==object_action_runto then
		--turn_towards(obj, obj.task.objInQuestion)
		try_to_reach_object(obj, obj.task.objInQuestion)
		turn_towards_spot(obj, obj.task.x, obj.task.y, obj.task.z)
		local x,y,z=getObjectInfo(obj.cObj, IG3D_POSITION)
		local dx,dy,dz=normalized(obj.task.x-x, 0, obj.task.z-z)
		local mult=math.max(0.5, dot(dx,dy,dz,a31,a32,a33))
		if true then
			dx=dx*mult
			dy=dy*mult
			dz=dz*mult
		end
		obj.anim.name="Run"
		local runspeed=2
		if obj.team==1 then runspeed=1.8 end
		obj.anim.vx= runspeed*dx
		obj.anim.vy= runspeed*dy
		obj.anim.vz= runspeed*dz
		obj.anim.link=false
		return
	end
	
	if obj.task.id==object_action_runtospot then
		
		turn_towards_spot(obj, obj.task.x, obj.task.y, obj.task.z)
		local x,y,z=getObjectInfo(obj.cObj, IG3D_POSITION)
		local dx,dy,dz=normalized(obj.task.x-x, 0, obj.task.z-z)
		local mult=math.max(0.5, dot(dx,dy,dz,a31,a32,a33))
		if true then
			dx=dx*mult
			dy=dy*mult
			dz=dz*mult
		end
		obj.anim.name="Run"
		local runspeed=2
		if obj.team==1 then runspeed=1.8 end
		obj.anim.vx= runspeed*dx
		obj.anim.vy= runspeed*dy
		obj.anim.vz= runspeed*dz
		obj.anim.link=false
		return
	end
	
	
	
	if obj.task.id==object_action_walktospot then
		turn_towards_spot(obj, obj.task.x, obj.task.y, obj.task.z)
		local x,y,z=getObjectInfo(obj.cObj, IG3D_POSITION)
		local dx,dy,dz=normalized(obj.task.x-x, 0, obj.task.z-z)
		local mult=math.max(0.5, dot(dx,dy,dz,a31,a32,a33))
		if true then
			dx=dx*mult
			dy=dy*mult
			dz=dz*mult
		end
		obj.anim.name="Walk"
		obj.anim.vx=1.2*dx
		obj.anim.vy=1.2*dy
		obj.anim.vz=1.2*dz
		obj.anim.link=false
		return
	end
	
	
	
	if obj.task.id==object_action_shootat then
		turn_towards(obj, obj.task.objInQuestion)
		obj.noise=1 --shots can be heard
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
			--bullets fly at speed 20
			local vx,vy,vz=getObjectInfo(obj.task.objInQuestion.cObj, IG3D_VELOCITY)
			local dist=objdistance(obj, obj.task.objInQuestion)
			local offsetx=vx*dist/20.0
			local offsety=vy*dist/20.0
			local offsetz=vz*dist/20.0
			
			x2=x2-0.1+math.random()*0.2 + offsetx
			y2=y2+0.1+math.random()*0.3 + offsety
			z2=z2-0.1+math.random()*0.2 + offsetz
			local dx,dy,dz=normalized(x2-x, y2-y, z2-z)

			--if not aimingAtFriendlyObject(obj, x,y,z, x2,y2,z2) then
				--try to reduce friendly fire
				
				setParticle_emitterInfo(gGunEmitter, IG3D_POSITION, x,y,z)
				setParticle_emitterInfo(gGunEmitter, IG3D_ROTATION, dirToAngles(dx,dy,dz))
				setParticle_emitterInfo(gGunEmitter, IG3D_START)
				setSound_emitterInfo(obj.gunSndEmt, IG3D_POSITION, x,y,z)
				setSound_emitterInfo(obj.gunSndEmt, IG3D_LOOP, false)
				setSound_emitterInfo(obj.gunSndEmt, IG3D_START)
				
				GunLightSix(x,y,z)  ;-- see UDG_Lights.lua
				obj.nextGunAttack=time()+obj.gun.interval  -obj.gun.intervalDeviation*0.5 + math.random()*obj.gun.intervalDeviation
				setParticle_emitterInfo(muzzleFlash, IG3D_POSITION, x,y,z)
				setParticle_emitterInfo(muzzleFlash, IG3D_START)

				obj.gun.shots=obj.gun.shots-1
				if obj.gun.shots<= 0 then
					obj.gun.shots=obj.gun.recharge[2]--recharge gun
					obj.event={fn=reloadgun_event, target=obj.task.objInQuestion, timeOut=time()+3.0}
				end
			--end
			
		end
		return
	end
	
	if obj.task.id==object_action_melee then
	
		
		--if team==1 then obj.behaviour=zombie_behaviour end--reset behaviour
		--triple -> really focus that enemy
		turn_towards(obj, obj.task.objInQuestion)
		local ox,oy,oz=getObjectInfo(obj.cObj, IG3D_POSITION)
		local x,y,z=getBoneInfo(get(ig3d_bone, obj.task.objInQuestion.cObj, "chest"), IG3D_POSITION)
		local dx,dy,dz=normalized(x-ox, y-oy, z-oz)
		
		obj.anim.name="Punch"
		obj.anim.vx=0
		obj.anim.vy=0
		obj.anim.vz=0
		
		local dmg=20--cause damage 20
		if obj.meleeWeapon or obj.gun then
			obj.anim.name="PunchWithTwoHandedWeapon"
			dmg=10000
		end
		
		
		
		
		if obj.team==0 then
			if obj.mayStunThisCombat then--kill or true
				if math.random(1,2)==1 then--kill or true
					dmg=0
					obj.event={fn= kickhead_event, target=obj.task.objInQuestion, timeOut=time()+0.9}
					obj.task.objInQuestion.event={fn=waitforhitbad_event, target=obj, timeOut=time()+0.35}
					obj.task.objInQuestion.impulse={a41,a42+0.3,a43,a31*3,a32,a33*3}
					
					if not obj.meleeWeapon and not obj.gun then
						obj.order=nil --better run!
					end
					
				end
				
				obj.mayStunThisCombat=false
				obj.mayStunAgainTime=time()+3
			end	
		end
		
		
		if obj.team==0 and isFemale(obj) and not obj.meleeWeapon and not obj.gun then
			obj.anim.name="Scared"
			obj.anim.vx=-dx*0.5
			obj.anim.vy=-dy*0.5
			obj.anim.vz=-dz*0.5
		end
		
		if obj.team==1 and obj.task.objInQuestion.health<dmg and obj.task.objInQuestion.team<=1 then
			obj.event={fn= fly_event, target=obj.task.objInQuestion, timeOut=time()+0.23}
			obj.anim.name="ZombieAttack"
			obj.anim.vx,obj.anim.vy,obj.anim.vz=getObjectInfo(obj.cObj, IG3D_VELOCITY)
			obj.anim.link=false
			obj.impulse={a41,a42,a43, dx*2, 0, dz*2}
			obj.meleeDelay=0.2
		end
		
		
		if obj.oldanimname~=obj.anim.name then
			--last fight was long ago
			obj.nextMeleeAttack=time()+obj.meleeDelay
			obj.startEatingTime=obj.nextMeleeAttack+0.2
		end
		
		
		if time()>obj.nextMeleeAttack then
			obj.meleeDelay=math.max(obj.meleeDelay, 0.5)
			obj.task.objInQuestion.health=obj.task.objInQuestion.health-dmg
			
			
			obj.nextMeleeAttack=time()+obj.meleeInterval
			
			if obj.task.objInQuestion.team<=1 then
				if play_hit_sound then play_hit_sound(obj.task.objInQuestion) end
			else
				if play_hit_sound_solid then play_hit_sound_solid(obj) end
			end
			
			--human won combat, may stun again
			if obj.task.objInQuestion.health<=0 and obj.team==0 then
				obj.mayStunThisCombat=true
				obj.event={fn=finishhim_event, target=obj.task.objInQuestion, timeOut=time()+1.0}--+5.0
				obj.order=nil
			end
		
			--zombie won combat, death scream of human...
			if obj.task.objInQuestion.health<=0 and obj.team==1 then
					if obj.task.objInQuestion.alive then
						obj.task.objInQuestion.killer=obj--set the killer
						local px,py,pz=getObjectInfo(obj.cObj, IG3D_POSITION)
						local qx,qy,qz=getObjectInfo(obj.task.objInQuestion.cObj, IG3D_POSITION)
						local dx,dy,dz=normalized(qx-px,qy-py,qz-pz)
						obj.task.objInQuestion.impulse={px-dx,py+0.2,pz-dz, dx*3,0.5,dz*3}
						play_get_eaten_sound(obj.task.objInQuestion)--wild
						
						if obj.task.objInQuestion==gObjects[playerBox] then
							--setObjectInfo(gObjects[playerBox].cObj, IG3D_COLLBOX_MULTIPLIERS, 0.3, 1.0, 0.3)
							--setObjectInfo(gObjects[playerBox].cObj, IG3D_VECTOR_CONSTRAINT, 0,0,0)
							--setObjectInfo(gObjects[playerBox].cObj, IG3D_TORQUE, 400,0,0)
						end
					end			
			end
			
			
			--fight doors and windows...
			if obj.task.objInQuestion.team>1 then				
				if obj.task.objInQuestion.health<=0 then
					a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)
					b11,b12,b13,b14, b21,b22,b23,b24, b31,b32,b33,b34, b41,b42,b43,b44=getObjectInfo(obj.task.objInQuestion.cObj, IG3D_ROTATION_MATRIX)
					local sx,bx,sy,by,sz,bz=getObjectInfo(obj.task.objInQuestion.cObj, IG3D_BOUNDS)
					local dx=b11
					local dy=b12
					local dz=b13
					if bx-sx > bz-sz then
						dx=b31
						dy=b32
						dz=b33
					end
					local dt=dot(dx,dy,dz, a31,a32,a33)
					local dirx,diry,dirz=normalized(dx*dt, dy*dt, dz*dt)
					obj.task.objInQuestion.impulse={b41-dirx,b42+0.3,b43-dirz,dirx*4,0,dirz*4}
					obj.order=nil
					obj.pth=nil
					obj.event=nil
					obj.task.id=object_action_idle
					
				end	
			end
			
		end
		
		--eat
		if obj.task.objInQuestion.health<=0 and obj.team==1 and obj.task.objInQuestion.team<=1 then
			obj.pth=nil
			obj.order={fn=eat_dead_human, target=obj.task.objInQuestion, targetBone1="rForeArm", targetBone2="rHand", eatingStart=time()}
			obj.nextMeleeAttack=time()+1.0			
		end
		
		--remember fights
		if obj.task.objInQuestion.health > 0 and obj.health>0 and obj.task.objInQuestion.team<=1 then
			obj.task.objInQuestion.pth=nil
			obj.task.objInQuestion.lastpath=nil
			obj.task.objInQuestion.order={fn=fight_enemy_order, target=obj, x=0,y=0,z=0}--must fight this one now
			unique_mind_insert(obj.task.objInQuestion.mind, {o=obj, seenFlag=true, heardFlag=true})--remember people that fight me
		end
		return	
	end
	
	if obj.task.id==object_action_idle then
		--obj.anim.name="PunchWithTwoHandedWeapon"
		setObjectInfo(obj.cObj, IG3D_OMEGA, 0,0,0)
		obj.anim.name="Stand"
		obj.anim.vx=0
		obj.anim.vy=0
		obj.anim.vz=0
		obj.anim.link=true
		return
	end
	
	
	if obj.task.id==object_action_lookat then
		turn_towards(obj, obj.task.objInQuestion)
		obj.anim.name="Look"
		obj.anim.vx=0
		obj.anim.vy=0
		obj.anim.vz=0
		obj.anim.link=false
		return
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
		
		
		a=steer_aim(obj.vehicle, obj.targetCrossing[1],obj.targetCrossing[2],obj.targetCrossing[3])
		
		--brake?
		if obj.brakeToVelocity~= nil then
			if vmag<=obj.brakeToVelocity then 
				obj.brakeToVelocity=nil
			else
				a[2]=false
				a[4]=true
			end
		end
		
		--accelerate?...
		if obj.brakeToVelocity== nil then
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
		return
	end
	
	if obj.task.id==object_action_reanimate then
		obj.anim.name="Stand"
		obj.anim.vx=0
		obj.anim.vy=0
		obj.anim.vz=0
		obj.anim.link=false
		obj.mind={} --tabularasa
		if time()>= obj.reanimateTime then
			local x,y,z=getObjectInfo(obj.cObj, IG3D_POSITION)
			local xlow,xhigh,ylow,yhigh,zlow,zhigh=getObjectInfo(obj.cObj, IG3D_BOUNDS)
				
			--setObjectInfo(obj.cObj, IG3D_POSITION, x,-ylow,z)--test
			obj.behaviour= gZombieBehaviour
			play_zombie_idle_sound(obj)
			rts_update_living_and_dead_counts()
		end
		return
	end
	
	
	if obj.task.id==object_action_eat then
		obj.behaviour= gZombieBehaviour--quit any rush
		
		if not obj.order.targetBone1 then obj.order.targetBone1="rForeArm"; obj.order.targetBone2="rHand"; end
		
		
		turn_towards_obj_bone(obj, obj.task.objInQuestion, obj.order.targetBone1)
		obj.anim.name="Eat"
		obj.anim.vx=0
		obj.anim.vy=0
		obj.anim.vz=0
		
		local bn1=get(ig3d_bone, obj.cObj, "head")
		local bn2=get(ig3d_bone, obj.task.objInQuestion.cObj, obj.order.targetBone1)
		local px,py,pz=getBoneInfo(bn1, IG3D_POSITION)
		local qx,qy,qz=getBoneInfo(bn2, IG3D_POSITION)
		if vecLength(qx-px,qy-py,qz-pz)>0.3 then--hmmm
			obj.anim.vx=(qx-px)*2
			obj.anim.vy=(qy-py)*2
			obj.anim.vz=(qz-pz)*2
		else
			obj.anim.vx=(qx-px)*2
			obj.anim.vy=(qy-py)*2
			obj.anim.vz=(qz-pz)*2
		end
		
		
		obj.anim.link=false

		if time()>obj.nextMeleeAttack then
			if not obj.order.eatingStart then obj.order.eatingStart=time() end
			
			local bn1=get(ig3d_bone, obj.cObj, "head")
			
			
			obj.task.objInQuestion.bloodBone=obj.order.targetBone1
			
			obj.nextMeleeAttack=time()+0.2
			local dx,dy,dz=getBoneInfo(bn1, IG3D_POSITION)
			local tx,ty,tz=getBoneInfo(bn2, IG3D_POSITION)
			--local result,x,y,z,u,v,m=getObjectInfo(obj.task.objInQuestion.cObj, IG3D_EXACT_COLLISION_DATA, dx-0.2+math.random()*0.4,dy+1,dz-0.2+math.random()*0.4,dx-0.2+math.random()*0.4,dy-1,dz-0.2+math.random()*0.4)
			local result,x,y,z,u,v,m=getObjectInfo(obj.task.objInQuestion.cObj, IG3D_EXACT_COLLISION_DATA, dx-0.1+math.random()*0.2,dy,dz-0.1+math.random()*0.2,tx-0.1+math.random()*0.2,ty,tz-0.1+math.random()*0.2)

			
			if result then
				drawToTexture( getMaterialInfo(m, IG3D_TEXTURE, 3), "Data/Images/Decals/bloodpencil"..(math.random(1,3))..".png",u,v, IG3D_ADD, IG3D_REPEAT)
				obj.blood=true
			end
			setParticle_emitterInfo(bloodParticles, IG3D_POSITION, dx,dy,dz)
			setParticle_emitterInfo(bloodParticles, IG3D_ROTATION, getObjectInfo(obj.cObj, IG3D_ROTATION))
			--setParticle_emitterInfo(bloodParticles, IG3D_START)
			
			if getSound_emitterInfo(obj.voiceSndEmt, IG3D_STOP) then 
				play_eat_sound(obj)
				obj.mayRush=true
			end
			
			--[[
			if obj.order.eatingStart>=12 then			
				local bn2=get(ig3d_bone, obj.task.objInQuestion.cObj, obj.order.targetBone2)
				setBoneInfo(bn2, IG3D_ENABLED, false)
			end
			
			if obj.order.eatingStart>=25 then
				local bn2=get(ig3d_bone, obj.task.objInQuestion.cObj, obj.order.targetBone1)
				setBoneInfo(bn2, IG3D_ENABLED, false)
			end
			--]]
			
			
			
			if time()-obj.order.eatingStart >= 7.0 then
				obj.order=nil
				--obj.task.objInQuestion.team=1
				--obj.task.objInQuestion.behaviour=zombie_behaviour
				--obj.task.objInQuestion.freezeTime=time()+4.0
			end

		end
		return
	end
	
	if obj.task.id==object_action_sidestep then
		--obj.anim.name="Walk"
		obj.anim.name=obj.oldanimname
		obj.anim.vx=obj.task.x
		obj.anim.vy=obj.task.y
		obj.anim.vz=obj.task.z
		obj.anim.link=false
		setObjectInfo(obj.cObj, IG3D_OMEGA, 0,0,0)
		return
	end
	
	if obj.task.id==object_action_keep then
		--obj.anim.name="Walk"
		obj.anim.name=obj.oldanimname
		obj.anim.vx,obj.anim.vy,obj.anim.vz=getObjectInfo(obj.cObj, IG3D_VELOCITY)
		obj.anim.link=false
		return
	end
	
	
	
end

function run_task_animation(obj)
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
	
	if not obj.mayStunThisCombat and time()>obj.mayStunAgainTime then
		obj.mayStunThisCombat=true
	end

	if obj.event~=nil then
		obj.event.fn(obj, obj.event.target)
		return
	end

	if obj.order~=nil then
		obj.order.fn(obj, obj.order.target)
		return
	end
	
	
	handle_behaviour(obj)
end


function handle_senses_and_remembering(obj)
	for i=1,#obj.sensed,1 do
		table.remove(obj.sensed)
	end
	
	handle_senses(obj)
	forget_corpses(obj) -- forget about dead ones
	handle_object_remembering(obj, false)  --remember objects we perceived
	
	sort_perceived_objects_by_priority(obj)
end


function handle_ai(obj)

	
	if gDanger then
		--ig3d_SetMode_i(1)
		--print("Task of "..getObjectInfo(gDanger.cObj, IG3D_NAME)..": "..task_to_string(gDanger.task) )
		--print(gDangerO)
	end
	gDanger = obj
	gDangerO = obj.pth
	
	
	
	handle_order_and_behaviour(obj)--orders override behaviours
	
	gDanger=nil
	
end




