-- orders override behaviours!
-- events override orders!!

function stunned_event(obj, target)
	obj.task.id=object_action_lookat
	obj.task.objInQuestion=target
	obj.task.x=0
	obj.task.y=0
	obj.task.z=0
	--print(getObjectInfo(obj.cObj, IG3D_NAME), "stunned")
	if time()>obj.event.timeOut then
		obj.event=nil
	end	
end

function finishhim_event(obj, target)
	obj.task.id=object_action_stab
	obj.task.objInQuestion=target
	obj.task.x=0
	obj.task.y=0
	obj.task.z=0
	--print(getObjectInfo(obj.cObj, IG3D_NAME), "stunned")
	if time()>obj.event.timeOut then
		obj.event=nil
	end	
end

function fly_event(obj, target)
	obj.task.id=object_action_keep
	obj.task.objInQuestion=target
	
	if obj.impulse then
		setObjectInfo(obj.cObj, IG3D_IMPULSE, obj.impulse[1], obj.impulse[2], obj.impulse[3], obj.impulse[4], obj.impulse[5], obj.impulse[6])
	end
	obj.impulse=nil
	if time()>obj.event.timeOut then
		obj.event=nil
	end	
end



function kick_teammate_event(obj, target)
	obj.task.id=object_action_keep
	obj.task.objInQuestion=target
	obj.task.x=0
	obj.task.y=0
	obj.task.z=0
	--local px,py,pz=getParticle_emitterInfo(obj.event.emt, IG3D_POSITION)

	if time()>obj.event.timeOut then
		a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)
		target.impulse={a41,a42,a43, a31*2,0,a33*2}
		local t=target
		--target.event={fn=hitbad_event, target=t, timeOut=time()+1}
		target.event={fn= fly_event, target=t, timeOut=time()+1}
		--play_hit_sound(target)
		obj.event=nil
	end	
end

function kick_furniture_event(obj, target)
	obj.task.id= object_action_fightfurniture
	obj.task.objInQuestion=target
	obj.task.x=0
	obj.task.y=0
	obj.task.z=0
	--local px,py,pz=getParticle_emitterInfo(obj.event.emt, IG3D_POSITION)

	if time()>obj.event.timeOut then
		obj.numBoxesHit=obj.numBoxesHit+1
		a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)
		
		if obj.event.emt then
			setParticle_emitterInfo(obj.event.emt, IG3D_IMPULSE, a41,0,a43, a31*2,2.7,a33*2)
		else
			setObjectInfo(target.cObj, IG3D_IGNORE_OBJECT_COLLS, true)
			setObjectInfo(target.cObj, IG3D_IMPULSE, a41,0,a43, a31*2,2.7,a33*2)
		end	
			
		if obj.numBoxesHit >= 2 and time()-obj.firstBoxHitTime<3.5 then
			if obj.event.emt then
				setParticle_emitterInfo(obj.event.emt, IG3D_IGNORE_COLL, true, ig3d_object, obj.cObj)				
			end	
			
			obj.numBoxesHit=0
			obj.firstBoxHitTime=time()
		else
			if obj.numBoxesHit==0 then
				obj.firstBoxHitTime=time()
			else
				if time()-obj.firstBoxHitTime >= 3.5 then
					obj.numBoxesHit=0
					obj.firstBoxHitTime=time()
				end	
			end
		end
		--[[
		if getParticle_emitterInfo(obj.event.emt, IG3D_FADE_TIME)~=0.5 then
			setParticleInfo(obj.event.emt, obj.event.x, IG3D_LIFE_TIME, 1.0)
			setParticle_emitterInfo(obj.event.emt, IG3D_FADE_TIME, 0.5)
		end
		--]]
		play_hit_sound_solid(obj)
		obj.event=nil
	end	
end

function jump_over_something_event(obj, target)
	obj.task.id= object_action_jump
	obj.task.objInQuestion=target
	obj.task.x=obj.event.x
	obj.task.y=0
	obj.task.z=obj.event.z
	if obj.event.y~=0 then
		setObjectInfo(obj.cObj, IG3D_IGNORE_COLL, true, ig3d_object, target.cObj)
		a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)
		setObjectInfo(obj.cObj, IG3D_IMPULSE, a41,0,a43, obj.event.x,obj.event.y,obj.event.z)
		obj.event.y=0
	end
	
	if time()>obj.event.timeOut then
		setObjectInfo(obj.cObj, IG3D_IGNORE_COLL, false, ig3d_object, target.cObj)
		obj.event=nil
		--obj.pth=nil--forgot what to do
	end	
end

function untangle_event(obj, target)
	obj.task.id=object_action_sidestep
	obj.task.x=obj.event.x
	obj.task.y=obj.event.y
	obj.task.z=obj.event.z
	obj.task.objInQuestion=target
	
	if time()>obj.event.timeOut then
		obj.event=nil
	end
	if getObjectInfo(obj.cObj, IG3D_RAGDOLL) then
		obj.task.x=0
		obj.task.y=0
		obj.task.z=0
	end
end

function kickhead_event(obj, target)
	if obj.anim.name~="Punch" and obj.anim.name~="Kick" then
		if math.random(1,2)==1 then
			obj.task.id=object_action_punchair
		else
			obj.task.id=object_action_kick
		end
	end
	
	obj.task.objInQuestion=target
	obj.task.x=0
	obj.task.y=0
	obj.task.z=0
	--print(getObjectInfo(obj.cObj, IG3D_NAME), "stunned")
	if time()>obj.event.timeOut then
		obj.event=nil
	end
	
end


function waitforhitbad_event(obj, target1)
	obj.task.id=object_action_punchair
	obj.task.objInQuestion=target1
	obj.task.x=0
	obj.task.y=0
	obj.task.z=0
	
	--print(getObjectInfo(obj.cObj, IG3D_NAME), "stunned")
	if time()>obj.event.timeOut then
		obj.event=nil
		obj.event={fn=hitbad_event, target=target1, timeOut=time()+2.5}
		if play_hit_sound then play_hit_sound(obj) end
	end
end

function headshot_event(obj, target1)
	obj.task.id=object_action_headshot
	obj.task.objInQuestion=target1
	obj.task.x=0
	obj.task.y=0
	obj.task.z=0
	
	--print(getObjectInfo(obj.cObj, IG3D_NAME), "stunned")
	if time()>obj.event.timeOut then
		--obj.headshot=true
		obj.health=0
		obj.event=nil
	end
end

function chestshot_event(obj, target1)
	obj.task.id=object_action_chestshot
	obj.task.objInQuestion=target1
	obj.task.x=0
	obj.task.y=0
	obj.task.z=0
	
	--print(getObjectInfo(obj.cObj, IG3D_NAME), "stunned")
	if time()>obj.event.timeOut then
		obj.event=nil
	end
end

function reloadgun_event(obj, target1)
	obj.task.id=object_action_reloadgun
	obj.task.objInQuestion=target1
	obj.task.x=0
	obj.task.y=0
	obj.task.z=0
	
	if time()>obj.event.timeOut then
		obj.event=nil
	end
end


function hitbad_event(obj, target)
	obj.task.id=object_action_hit
	obj.task.objInQuestion=target
	obj.task.x=0--obj.event.timeOut-time()
	obj.task.y=0--obj.event.timeOut-time()
	obj.task.z=0--obj.event.timeOut-time()
	if not getObjectInfo(obj.cObj, IG3D_RAGDOLL) then
		obj.mayRush=false
		setObjectInfo(obj.cObj, IG3D_IGNORE_OBJECT_COLLS, true)
		setObjectInfo(obj.cObj, IG3D_RAGDOLL, true)
		if obj.impulse then
			setObjectInfo(obj.cObj, IG3D_IMPULSE, obj.impulse[1], obj.impulse[2], obj.impulse[3], obj.impulse[4], obj.impulse[5], obj.impulse[6])
		end
		obj.impulse=nil
	end

	if time()>obj.event.timeOut then
		
		setObjectInfo(obj.cObj, IG3D_RAGDOLL, false)
		setObjectInfo(obj.cObj, IG3D_IGNORE_OBJECT_COLLS, false)
		setObjectInfo(obj.cObj, IG3D_ROTATION, 0,0,0)
		setObjectInfo(obj.cObj, IG3D_VECTOR_CONSTRAINT, 0,1,0)
		obj.event=nil
		obj.order=nil --forget orders when hit like that
		obj.behaviour=gZombieBehaviour
	end
end