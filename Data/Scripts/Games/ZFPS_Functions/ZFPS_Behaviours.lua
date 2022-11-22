function zombie_fps_rush_behaviour(obj)
	local lx,ly,lz
	if #obj.sensed>0 then
		if obj.sensed[1].team==1-obj.team and obj.sensed[1].alive and obj.sensed[1].seenFlag then
			lx,ly,lz=getObjectInfo(obj.sensed[1].cObj, IG3D_POSITION)
			obj.order={fn=fight_enemy_order_aware, target=obj.sensed[1], x=lx, y=ly, z=lz}
		end
	end
	
	local targetObj=getNearestEnemy(obj)
	--targetObj=gObjects[playerBox]
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