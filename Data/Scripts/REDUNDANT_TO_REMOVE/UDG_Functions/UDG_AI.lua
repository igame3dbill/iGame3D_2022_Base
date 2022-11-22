gDangerFlag=false
-- handle_UDGAI copied from handle_FPSAI in FPS_Functions/FPS_AI.lua

gAISliceSize=1
gAISliceOffset=0
gAIInterval=0
gAITime=0

--we want to do 5 AIs handled in 0.1 seconds which yields to a slide size of 5 and a sensing interval of 0.1 seconds
--or slide size 1 with sensing interval 0.02

function handle_UDGAI()
	

	setSceneInfo(IG3D_LOD_DISTANCE, 7,10,10,10)--5
	if gFallbackMode then setSceneInfo(IG3D_LOD_DISTANCE, 1,10,10,10) end
			
	-- timed senses
	local dosenses=false
	if time()>=gSensesTime then
		-- is it time to handle the senses?
		gSensesTime=time()+gSensesInterval
		dosenses=true
	end
	
	
	
	buildDistancesTable(dosenses)--calculate distance between objects and distances to camera thus determining the relevant objects
	
	
	-- hilite marked objects
	hiliteMarkedObjects() ; -- see RTS_Utilties.lua
	-- position held guns
	rightHandedPistols(); -- see RTS_Weapons.lua
	-- position held melee weapons
	handle_melee_weapons(); -- see RTS_Weapons.lua
	

	-- check health
	for i=1,#gObjects,1 do
		--needs to be here
		handle_health(gObjects[i])-- see RTS_AI.lua
	end	
	
	
	if time()>=gAITime then
		gAITime=time()+gAIInterval
		-- object AI
		local i,j
		local numSensingPeople=0
		for j=gAISliceOffset, gAISliceOffset + #gObjects-1, 1 do
		
			i=(j % #gObjects) + 1
		
			if gObjects[i].alive then
				if numSensingPeople < gAISliceSize then
					handle_senses_and_remembering(gObjects[i])
					numSensingPeople = numSensingPeople+1
					gAISliceOffset=i--yeah!
				else
					handle_object_remembering(gObjects[i], true)
				end
				
					handle_ai(gObjects[i])
					do_task(gObjects[i])
					run_task_animation(gObjects[i])
			end	
		end		
	end
	
	
	-- stuff that happens to objects
	for i=1,#gObjects,1 do
		-- freezetime
			if gObjects[i].freezeTime then
				if time()>= gObjects[i].freezeTime and not gObjects[i].freeze then
					gObjects[i].massw,gObjects[i].massix,gObjects[i].massiy,gObjects[i].massiz=getObjectInfo(gObjects[i].cObj, IG3D_MASS)
					setObjectInfo(gObjects[i].cObj, IG3D_MASS, 0,0,0,0)
					setObjectInfo(gObjects[i].cObj, IG3D_RAGDOLL, false)
					setObjectInfo(gObjects[i].cObj, IG3D_COLL, false)--false
					setObjectInfo(gObjects[i].cObj, IG3D_GRAVITY_MULTIPLIER, 0) -- 0
					x,y,z=getObjectInfo(gObjects[i].cObj, IG3D_POSITION)
					if gObjects[i].bloodBone then
						local bn=get(ig3d_bone, gObjects[i].cObj, gObjects[i].bloodBone)
						x,y,z=getBoneInfo(bn, IG3D_POSITION)
						gObjects[i].bloodBone=nil
					end
					
					
				
					gObjects[i].freeze=true
					gObjects[i].freezeTime=time()+10.0
					if gObjects[i].deathCount==1 then
						gObjects[i].freezeTime=time()+1.0
					else
						local nearestNode= getNearestNodeOfPosition(x,y,z)
						y=nearestNode.y-0.03
						setParticle_emitterInfo(bloodonfloor, IG3D_POSITION, x,y,z)
						setParticle_emitterInfo(bloodonfloor, IG3D_START)
					end		
				end
			end
			-- frozen
			if gObjects[i].freeze then
				if time()>= gObjects[i].freezeTime and gObjects[i].team==1 and gObjects[i].deathCount>0 then
					setObjectInfo(gObjects[i].cObj, IG3D_MASS, gObjects[i].massw, gObjects[i].massix, gObjects[i].massiy, gObjects[i].massiz)				
					putObjectOnGround(gObjects[i])
					gObjects[i].freeze=false
					gObjects[i].freezeTime=nil
					setObjectInfo(gObjects[i].cObj, IG3D_IGNORE_OBJECT_COLLS, false)
					setObjectInfo(gObjects[i].cObj, IG3D_COLL, true)
					setObjectInfo(gObjects[i].cObj, IG3D_GRAVITY_MULTIPLIER, 1)
					gObjects[i].alive=true
					gObjects[i].health=math.random(500,1000)
					gObjects[i].anim.name="ragdoll"
					gObjects[i].reanimateTime=time()+0.5
					gObjects[i].behaviour=zombie_reanimate_behaviour
					gObjects[i].noise=0.2
					gObjects[i].hitFloor=false
					setObjectInfo(gObjects[i].cObj, IG3D_ROTATION, 0,0,0)--trying stuff
					setObjectInfo(gObjects[i].cObj, IG3D_GRAVITY_MULTIPLIER, 1)
					setObjectInfo(gObjects[i].cObj, IG3D_VECTOR_CONSTRAINT, 0,1,0)
					setObjectInfo(gObjects[i].cObj, IG3D_LINK_MAIN_BONE_TO_VELOCITY, false)
				end	
			end	
	end
	
	
	
	
end

function udg_zombies_in_touch_distance(z1, z2)
	if objdistance(z1, z2) < 2.5 then
		return true
	end
	
	return false
end

function udg_build_zombie_near_values()
	local i,j
	local nearSet={gObjects[playerBox]}
	local growing=true
	
	for i=1,#gObjects,1 do
		gObjects[i].nearPlayer=false
	end
	
	while growing do
		growing=false
		for i=1,#gObjects,1 do
			for j=1,#nearSet,1 do
				if gObjects[i].team==1 and gObjects[i].alive and not gObjects[i].nearPlayer then
				
					local result= udg_zombies_in_touch_distance(gObjects[i], nearSet[j])
					if result then
						gObjects[i].nearPlayer=true
						growing=true
						table.insert(nearSet, gObjects[i])
					end
				end
			end
		end
	end
	
	if key("k","n") then
	for i=1,#gObjects,1 do
		if gObjects[i].team==1 and gObjects[i].alive then
			--print(gObjects[i].nearPlayer)
		end
	end
	end
end

function udg_enemy_in_sight(obj)
	if #obj.sensed > 0 then
		if obj.sensed[1].team == 1-obj.team then
			return true
		end
	end
	return false
end

function udg_zombies_follow()
	udg_build_zombie_near_values()
	if gPathsSet then
		gOldPlayerPosX,gOldPlayerPosY,gOldPlayerPosZ=getObjectInfo(playerBox, IG3D_POSITION)
		gPathsSet=false
	end
end


function getupfromfloor(obj)
	obj.freeze=false
	obj.freezeTime=nil
					setObjectInfo(obj.cObj, IG3D_IGNORE_OBJECT_COLLS, false)
					setObjectInfo(obj.cObj, IG3D_COLL, true)
					setObjectInfo(obj.cObj, IG3D_GRAVITY_MULTIPLIER, 1)
					obj.alive=true
					obj.health=1
					obj.anim.name="ragdoll"
					obj.reanimateTime=time()+0.5
					obj.team=0
					obj.noise=0
					obj.hitFloor=false
					obj.order={fn=fight_enemy_order, target=obj.killer, x=0, y=0, z=0}
					obj.killer.order=nil
					--if rts_play_zombie_ambient_sound then rts_play_zombie_ambient_sound(gObjects[i])  end

					--
					setObjectInfo(obj.cObj, IG3D_ROTATION, 0,0,0)--trying stuff
					setObjectInfo(obj.cObj, IG3D_GRAVITY_MULTIPLIER, 1)
					setObjectInfo(obj.cObj, IG3D_VECTOR_CONSTRAINT, 0,1,0)
					setObjectInfo(obj.cObj, IG3D_LINK_MAIN_BONE_TO_VELOCITY, false)


end


function coll_obj_mesh_udg(obj, bone, x,y,z)
	if obj.team>1 then return end
	if getObjectInfo(obj.cObj, IG3D_RAGDOLL) and not obj.hitFloor then
			--check if head is near floor
			local hx,hy,hz=getBoneInfo(get(ig3d_bone, obj.cObj, "head"), IG3D_POSITION)
			if hy<0.4 then
				obj.hitFloor=true
				setSound_emitterInfo(obj.noiseSndEmt, IG3D_STOP)
				setSound_emitterInfo(obj.noiseSndEmt, IG3D_LOOP, false)
				setSound_emitterInfo(obj.noiseSndEmt, IG3D_VOLUME, 100)--3
				setSound_emitterInfo(obj.noiseSndEmt, IG3D_SAMPLE, "Data/Sounds/bodyhitfloor.ogg")
				setSound_emitterInfo(obj.noiseSndEmt, IG3D_POSITION, getObjectInfo(obj.cObj, IG3D_POSITION))
				setSound_emitterInfo(obj.noiseSndEmt, IG3D_START)
			end
	end


	ox,oy,oz=getObjectInfo(obj.cObj, IG3D_POSITION)
	if y>=oy-0.2 and obj.alive and obj~=gObjects[playerBox] then
		local dx,dy,dz=normalized(ox-x,0,oz-z)
		
		
		if obj.event==nil then
				
				if obj.task.id~= object_action_eat and obj.task.id~=object_action_melee then
					--obj.redoPath=true
					--commented out wall coll handling
					obj.event={fn=untangle_event, target=nil, x=dx*2, y=dy*2, z=dz*2, timeOut=time()+0.1}
				end
		end
		
		
	end
	
end

coll_o_m=coll_obj_mesh_udg