gDangerFlag=false
RTS_console=1
function handle_FPSAI()
	setText_boxInfo(RTS_console, IG3D_TEXT, "")	
	local fps=getSceneInfo(IG3D_FPS)
	setSceneInfo(IG3D_LOD_DISTANCE, 5,50,50,50)--5
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
	-- handle car engines
	play_car_sounds() ; -- see RTS_Vehicles.lua
	-- check health
	for i=1,#gObjects,1 do
		--needs to be here
		if gObjectNames[i] ~= "playerbox" then	handle_health(gObjects[i]) end-- see RTS_AI.lua
	end	
	-- object AI
	local i
	for i=1,#gObjects,1 do
	if gObjectNames[i] ~= "playerbox" and string.find(gObjectNames[i],"window") == nil and string.find(gObjectNames[i],"door") == nil then
		if gObjects[i].alive then
			if gObjects[i].relevant then
				handle_ai(gObjects[i], dosenses)
			else
				handle_ai(gObjects[i], dosenses)
			end
		end		
			-- freezetime
			if gObjects[i].freezeTime then
				if time()>= gObjects[i].freezeTime and not gObjects[i].freeze then
					setObjectInfo(gObjects[i].cObj, IG3D_RAGDOLL, false)
				
					setObjectInfo(gObjects[i].cObj, IG3D_COLL, false)
					setObjectInfo(gObjects[i].cObj, IG3D_GRAVITY_MULTIPLIER, 0) -- ?
					x,y,z=getObjectInfo(gObjects[i].cObj, IG3D_POSITION)
					y=0.02
					setParticle_emitterInfo(bloodonfloor, IG3D_POSITION, x,y,z)
					setParticle_emitterInfo(bloodonfloor, IG3D_START)
				
					gObjects[i].freeze=true
					gObjects[i].freezeTime=time()+6.0			
				end
			end
			-- frozen
			if gObjects[i].freeze then
				----IMPORTANT: In the following line dont replace team==1 with a gTeamSelect literal, since this is explicitly concerning zombies only!!
				if time()>= gObjects[i].freezeTime and gObjects[i].team==1 and gObjects[i].headshot==false and gObjects[i].behaviour==zombie_behaviour then
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
					--if rts_play_zombie_ambient_sound then rts_play_zombie_ambient_sound(gObjects[i])  end					--
					setObjectInfo(gObjects[i].cObj, IG3D_ROTATION, 0,0,0)--trying stuff
					setObjectInfo(gObjects[i].cObj, IG3D_GRAVITY_MULTIPLIER, 1)
					setObjectInfo(gObjects[i].cObj, IG3D_VECTOR_CONSTRAINT, 0,1,0)
					setObjectInfo(gObjects[i].cObj, IG3D_LINK_MAIN_BONE_TO_VELOCITY, false)
				end	
			end	
		end
	end
-- keyboard time controls 	
bulletTimeKey("b") ; 
 -- tab key = 314, slows time to .00001
stopTimeKey(314) ; 
	
-- 		char,code,name=input(false)
-- 		if char~= nil then RTS_print(code) end; 
	
	fltk_update()
end
