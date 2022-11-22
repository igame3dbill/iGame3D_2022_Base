-- ZGS_Game
gLastClick=0
gDoubleClickInterval=0.4

function handle_clicks()

	if gDraggingSelRect then handle_selection_box() end; -- see ZGS_Utilities.lua
	
	if click("n") then
		
		--handle double-clicks
		if gLastClick~= 0 then
			if time()-gLastClick<gDoubleClickInterval*getSceneInfo(IG3D_SPEED) then
				for i=1,#gObjects,1 do
					if gObjects[i].selected and gObjects[i].vehicle~=nil then stepOutOfCar(gObjects[i]) end
				end
				gLastClick=0
			else
				gLastClick=time()
			end
		else
			gLastClick=time()
		end
		--
	
	
		for i=1,#gObjects,1 do
			gObjects[i].oldSelected=gObjects[i].selected
			
		end
		
		local c,lx,ly,lz,o=lineCollision(getSceneInfo(IG3D_MOUSE_LINE))
		local boxPopUp=false
		
		--clicked, but didnt hit an object:
		if c~=2 then
			if somethingSelected() then
				
				for i=1,#gObjects,1 do
					if gObjects[i].selected then
					
					local ox,oy,oz=getObjectInfo(gObjects[i].cObj, IG3D_POSITION)--wuhu
					gObjects[i].pth= generateAStarPathBetweenPositions(ox,oy,oz, lx,ly,lz)--what mess is this again
					gObjects[i].order={fn=walk_on_path, target=nil, x=lx, y=ly, z=lz}
					--if gObjects[i].team == 1 then
					--gObjects[i].order={fn=walk_to_spot, target=nil, x=lx, y=ly, z=lz}; 
					--else
					--gObjects[i].order={fn=run_to_spot, target=nil, x=lx, y=ly, z=lz}; 
					--end
					gTrackingLights[1][2] = nil
					lightN = gTrackingLights[1][1]
         			setLightInfo(lightN,IG3D_POSITION,lx,ly,lz,1)
					end
				end
				return
			else
				
				boxPopUp=true
			end
		end
		
		
		if c==2 and not somethingSelected() then
			if o.team~=gTeamSelect then boxPopUp=true end
			if o.alive==false then boxPopUp=true end
		end
		
		--should a selection box pop up?
		if boxPopUp then
			if key(310,"-")==false then unselectAllObjects() end
			handle_selection_box()
		else
			
			if key(310,"-") == false and o.team== gTeamSelect and getObjectInfo(o.cObj, IG3D_VEHICLE)==false and not o.house then unselectAllObjects() end
			--IMPORTANT: Dont touch following line
			if o.team==1-gTeamSelect then 
				local i
				for i=1,#gObjects,1 do
					if gObjects[i].selected then 
						gObjects[i].order={fn=fight_enemy_order, target=o}; o.blinkingRed=1.0; 
						gTrackingLights[1][2]=o
					end
				end
			else
				if getObjectInfo(o.cObj, IG3D_VEHICLE) then
					for i=1,#gObjects,1 do
						if gObjects[i].selected then
						gTrackingLights[1][2]=o
							if gObjects[i].team == 1 then
								local lx,ly,lz = getObjectInfo(o.cObj,IG3D_POSITION)
								gObjects[i].order={fn=walk_to_spot, target=nil, x=lx, y=ly, z=lz}; 
							else
								gObjects[i].order={fn=run_to_vehicle, target=o}; o.blinkingRed=1.0; 
							end												
						end
					end
				else
					if o.house then
						for i=1,#gObjects,1 do
							if gObjects[i].selected then
								gTrackingLights[1][2]=o 
								if gObjects[i].team == 1 then
									local lx,ly,lz = getObjectInfo(o.cObj,IG3D_POSITION)
									gObjects[i].order={fn=walk_to_spot, target=nil, x=lx, y=ly, z=lz}; 
								else
									gObjects[i].order={fn=run_to_house, target=o}; o.blinkingRed=1.0;
								end							 				
							end
						end
					else
						o.selected=true
						gTrackingLights[1][2]=o
						
					end
				end
			end
			
		end
		
		
	end
	
	if not click("-") then
		gSelectionRect.left=0
		gSelectionRect.top=0
		gSelectionRect.right=0
		gSelectionRect.bottom=0
		gDraggingSelRect=false
	end


end


function handle_RTS()
	setText_boxInfo(zgs_console, IG3D_TEXT, "")	
	
	local fps=getSceneInfo(IG3D_FPS)
	
	--setSceneInfo(IG3D_LOD_DISTANCE, 5,25,40,50)
	setSceneInfo(IG3D_LOD_DISTANCE, 5,50,50,50)
	zgs_print(fps)
	zgs_print(getSceneInfo(IG3D_DRAWN_FACES))
    zgsEntityCount="#humans= "..#humans.."\n".."#zombies="..#zombies.."\n".."#cars= "..#cars.."\n".."#buildings= "..#buildings
	zgs_print(zgsEntityCount)



	-- timed senses
	local dosenses=false
	if time()>=gSensesTime then
		-- is it time to handle the senses?
		gSensesTime=time()+gSensesInterval
		dosenses=true
	end

	buildDistancesTable(dosenses)--calculate distance between objects and distances to camera thus determining the relevant objects
	-- hilite marked objects
	hiliteMarkedObjects() ; -- see ZGS_Utilties.lua
	-- position held guns
	rightHandedPistols(); -- see ZGS_Weapons.lua
	-- handle car engines
	play_car_sounds() ; -- see ZGS_Vehicles.lua
	-- check health
	for i=1,#gObjects,1 do
		--needs to be here
		handle_health(gObjects[i]) -- see ZGS_AI.lua
	end
	if key("l","n") then
	if gTrackLightEnabled == true then
	gTrackLightEnabled = false
	else
	gTrackLightEnabled = true
	end
	end 
		
	if key("z","n") then
		if gTeamSelect == 1 then  
			tabThroughObjects() 
		else
			gTeamSelect = 1
			unselectAllObjects() -- zgs_keyboard.lua
		end
	end
	if key("h","n") then       
		if gTeamSelect == 0 then  
			tabThroughObjects() 
		else
			gTeamSelect = 0
			unselectAllObjects() -- zgs_keyboard.lua
		end
	end
	
	 
	-- object AI
	local i
	for i=1,#gObjects,1 do
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
					setObjectInfo(gObjects[i].cObj, IG3D_GRAVITY_MULTIPLIER, 0)
				
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
					setObjectInfo(gObjects[i].cObj, IG3D_COLL, true)
					setObjectInfo(gObjects[i].cObj, IG3D_GRAVITY_MULTIPLIER, 1)
					gObjects[i].alive=true
					gObjects[i].health=math.random(500,1000)
					gObjects[i].anim.name="ragdoll"
					gObjects[i].reanimateTime=time()+0.5
					gObjects[i].behaviour=zombie_reanimate_behaviour
					setSound_emitterInfo(gObjects[i].zombieSndEmt, IG3D_START)
					--
					setObjectInfo(gObjects[i].cObj, IG3D_ROTATION, 0,0,0)--trying stuff
					setObjectInfo(gObjects[i].cObj, IG3D_GRAVITY_MULTIPLIER, 1)
					setObjectInfo(gObjects[i].cObj, IG3D_VECTOR_CONSTRAINT, 0,1,0)
					setObjectInfo(gObjects[i].cObj, IG3D_LINK_MAIN_BONE_TO_VELOCITY, false)
				end
				
			end
			
		
		
	end

	
-- keyboard time controls 	
bulletTimeKey("b") ; 
 -- tab key = 314, slows time to .00001
stopTimeKey(314) ; 
	
-- 		char,code,name=input(false)
-- 		if char~= nil then zgs_print(code) end; 


		
     	
	
	handle_clicks()
	
	
	
	if key(" ","n") then
		unselectAllObjects()
	end

	
	if key("	","n") then
		tabThroughObjects() -- zgs_keyboard.lua
	end
	
	-- 8 Eight key
	if key(56,"-") then	trackLightsKey("-1") end
	-- 9 Nine Key
	if key(57,"-") then	trackLightsKey("1") end

	--gTrackingLights[2][2]=gObjects[gTrackedObject]
	-- nLight=  2
	gTrackingLights[1][2]=gObjects[gTrackedObject]
	nLight=1	 
				
	trackLightsKey("0")

	
	local h,v=getSceneInfo(IG3D_WHEEL_DELTA)
	gZoomDistance=math.max( math.min(gZoomDistance+v*0.2, 8.0), 0.5)
	
	
	if key("r","-") then
		gZoomDistance=math.max( math.min(gZoomDistance+passed()*8*gInverseGameSpeed, 8.0), 0.5)
    end
        
    if key("f","-") then
    	gZoomDistance=math.max( math.min(gZoomDistance-passed()*8*gInverseGameSpeed, 8.0), 0.5)
    end
	
	
	if key("a","-") then--"a"
		gLookAround=gLookAround+passed()*90*gInverseGameSpeed
	end
	
	if key("d","-") then--"d"
		gLookAround=gLookAround-passed()*90*gInverseGameSpeed
	end
	



	
	-- camera rotation
	tx=0
	ty=0
	tz=0
	
	if key("q","-") then
		a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getCameraInfo(IG3D_ROTATION_MATRIX)
tx=tx+a11*passed()*gZoomDistance*3*gInverseGameSpeed
ty=ty+a12*passed()*gZoomDistance*3*gInverseGameSpeed
tz=tz+a13*passed()*gZoomDistance*3*gInverseGameSpeed
end

if key("e","-") then
	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getCameraInfo(IG3D_ROTATION_MATRIX)
tx=tx-a11*passed()*gZoomDistance*3*gInverseGameSpeed
ty=ty-a12*passed()*gZoomDistance*3*gInverseGameSpeed
tz=tz-a13*passed()*gZoomDistance*3*gInverseGameSpeed
end

		
	if key("w","-") then
		a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getCameraInfo(IG3D_ROTATION_MATRIX)
		a31,a32,a33=normalized(a31,a32,a33)
		tx=tx+a31*passed()*gZoomDistance*3*gInverseGameSpeed
	--	ty=ty+passed()*gZoomDistance*3*gInverseGameSpeed
		tz=tz+a33*passed()*gZoomDistance*3*gInverseGameSpeed
	end
	if key("s","-") then
		a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getCameraInfo(IG3D_ROTATION_MATRIX)
		a31,a32,a33=normalized(a31,0,a33)
		tx=tx-a31*passed()*gZoomDistance*3*gInverseGameSpeed
		--ty=ty-a32*passed()*gZoomDistance*3*gInverseGameSpeed
		
		tz=tz-a33*passed()*gZoomDistance*3*gInverseGameSpeed
	end
	
	
	gTrackedPosition.x=gTrackedPosition.x+tx
	gTrackedPosition.y=gTrackedPosition.y+ty
	gTrackedPosition.z=gTrackedPosition.z+tz
		
	--a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(gObjects[gTrackedObject].cObj,IG3D_ROTATION_MATRIX)
	--camera tracking
	a11=1
	a12=0
	a13=0
	a31=0
	a32=0
	a33=1

	x2= gTrackedPosition.x
	y2= gTrackedPosition.y
	z2= gTrackedPosition.z
	
	local rtd=180.0/3.1515
	local mx=a31*math.cos(gLookAround/rtd)+a11*math.sin(gLookAround/rtd)
	local my=a32*math.cos(gLookAround/rtd)+a12*math.sin(gLookAround/rtd)+1
	local mz=a33*math.cos(gLookAround/rtd)+a13*math.sin(gLookAround/rtd)
	
	local x3=x2+mx*gZoomDistance
	local y3=y2+my*gZoomDistance
	local z3=z2+mz*gZoomDistance
	local x,y,z=getCameraInfo(IG3D_POSITION)
	
	local dx=x3-x
	local dy=y3-y
	local dz=z3-z
	ds=vecLength(dx,dy,dz)
	dx,dy,dz=normalized(dx,dy,dz)
	local t=math.min(1, passed()*3*gInverseGameSpeed)
	t=1
	x=x+dx* t * ds
	y=y+dy* t * ds
	z=z+dz* t * ds
	setCameraInfo(IG3D_POSITION, x,y,z)
	
	dx=gTrackedPosition.x-(x+dx * (1-t)*ds)
	dy=gTrackedPosition.y-(y+dy * (1-t)*ds)
	dz=gTrackedPosition.z-(z+dz * (1-t)*ds)

	setCameraInfo(IG3D_ROTATION, dirToAngles(dx,dy,dz))
	
	gInverseGameSpeed=1.0 / getSceneInfo(IG3D_SPEED) --calculate inverse of game speed
	gActivateStartSounds=false
	
	

	
	
	setLightInfo(1, IG3D_POSITION, x,y,z,1)
	setLightInfo(1, IG3D_CONSTANT_ATTENUATION, 1)
	setLightInfo(1, IG3D_LINEAR_ATTENUATION, 0)
	setLightInfo(1, IG3D_QUADRATIC_ATTENUATION, 0.000816326)
	
	setSelectionRect(gSelectionRect.left, gSelectionRect.top, gSelectionRect.right, gSelectionRect.bottom)
	fltk_update()
end

handle_ZGS=handle_RTS
--dofile(gameroot.."Data/Fluid/console/console.fl")
