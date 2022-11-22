
function activate_per_pixel_shader_for_each_material()
	if getSceneInfo(IG3D_FRAGMENT_SHADER_SUPPORTED) then
	--if nil then
	local j=1
	local m
	for i=1,#gObjects,1 do
		if getObjectInfo(gObjects[i].cObj, IG3D_HUD) == false then
			j=1
			while true do
				m=get(ig3d_material, gObjects[i].cObj, j)
				if not m then
					break
				else
					setMaterialInfo(m, IG3D_SHADER, "Data/Shaders/per_pixel_lighting/")
					setMaterialInfo(m, IG3D_TEXTURE, 2, nil)
				end
				j=j+1
			end
		end
	end
	
	j=1
	while true do
		local m=get(ig3d_material, -1, j)
		if not m then
			break
		else
			setMaterialInfo(m, IG3D_SHADER, "Data/Shaders/per_pixel_lighting/")
		end
		j=j+1
	end
	end
end

function spilloilovertheplace()
	x,y,z=getParticle_emitterInfo(oilonfloor2, IG3D_POSITION)
	local i
	for i=1,30,1 do
		--setParticle_emitterInfo(oilonfloor2, IG3D_POSITION, x-8+math.random()*16, 0.01, z-8+math.random()*16)
		--setParticle_emitterInfo(oilonfloor2, IG3D_START)
	end
	setParticle_emitterInfo(oil, IG3D_START)--start the oil rain
end

function center_text_box(tb)
	local left,top,right,bottom=ig3d_GetWindowBounds__4i()
	setText_boxInfo(tb, IG3D_SIZE, (right-left)/20)
	local left2,top2,right2,bottom2=getText_boxInfo(tb, IG3D_BOUNDS)
	local boffsetx=0.5*(right2-left2)
	local boffsety=0.5*(bottom2-top2)
	local wcenterx=0.5*(right-left)
	local wcentery=0.5*(bottom-top)
	setText_boxInfo(tb, IG3D_POSITION, wcenterx-boffsetx, wcentery-boffsety)
end


function fade_to_scene()
	local m=get(ig3d_material, blendQuad.cObj, 1)
	local r,g,b,a=getMaterialInfo(m, IG3D_COLOR)	
	
	a = a-passed()*0.5
	setMaterialInfo(m, IG3D_COLOR, r,g,b, a)
	setMaterialInfo(m, IG3D_TEXTURE, 1, nil)
	if a<= 0 then
		
		game_func=udg_display_igame3d_presents
		
	end
	
	
	
	udg_track_car_with_camera()
	position_car_lights()
	
	--escape key
	if key(27,"n") then
		setSceneInfo(IG3D_RECEIVE_SHADOW, false)
		--just to be sure
		if getSound_emitterInfo(gUDGMusic, IG3D_STOP) then gUDGMusic=nil end
		loadLevel("Data/Levels/UDG/UDG_MainMenu")
		return
	end
	
	fltk_update()
end



exploded=false	 
function fade_to_black()
	local m=get(ig3d_material, blendQuad.cObj, 1)
	if m then
		local r,g,b,a=getMaterialInfo(m, IG3D_COLOR)	
		if not exploded then 
			exploded = true 
			--newEmitter()
		end

		r = 0
		g = 0
		b = 0
		a = a+passed()*0.37
	
		setMaterialInfo(m, IG3D_COLOR, r,g,b, math.min(a,1))
		if a> 1 then
			if getSound_emitterInfo(gUDGMusic, IG3D_STOP) then gUDGMusic=nil end
			setSceneInfo(IG3D_RECEIVE_SHADOW, false)
			loadLevel("Data/Levels/UDG/UDG_MainMenu")
			return
		end
	end
	
	--escape key
	if key(27,"n") then
		setSceneInfo(IG3D_RECEIVE_SHADOW, false)
		loadLevel("Data/Levels/UDG/UDG_MainMenu")
		return
	end
	
	fltk_update()
end



function drive_car_around1(obj, forw, backw, brake, hbrake, steerr, steerl)
	local fr=get(ig3d_bone, obj.cObj, "RightFrontWheel")
	local fl=get(ig3d_bone, obj.cObj, "LeftFrontWheel")
	local rr=get(ig3d_bone, obj.cObj, "RightRearWheel")
	local rl=get(ig3d_bone, obj.cObj, "LeftRearWheel")

	--throttle
	if forw then
		setBoneInfo(fr, IG3D_TORQUE, 20)
		setBoneInfo(fl, IG3D_TORQUE, 20)
		
		setBoneInfo(rr, IG3D_TORQUE, 20)
		setBoneInfo(rl, IG3D_TORQUE, 20)
	else
		if backw then
			setBoneInfo(fr, IG3D_TORQUE, -15)
			setBoneInfo(fl, IG3D_TORQUE, -15)
			
			setBoneInfo(rr, IG3D_TORQUE, -15)
			setBoneInfo(rl, IG3D_TORQUE, -15)
		else
		
		setBoneInfo(fr, IG3D_TORQUE, 0)
		setBoneInfo(fl, IG3D_TORQUE, 0)
		
		setBoneInfo(rr, IG3D_TORQUE, 0)
		setBoneInfo(rl, IG3D_TORQUE, 0)
		end
	end
	
	--front braking
	m=get(ig3d_material, obj.cObj, 6)
	if brake then
		setBoneInfo(fr, IG3D_BRAKE,0.001)
		setBoneInfo(fl, IG3D_BRAKE,0.001)
		setMaterialInfo(m, IG3D_TEXTURE, 1, "Data/Images/Vehicles/Cmro_texbrake.png")
		setMaterialInfo(m, IG3D_EMISSION, 1,0,0,1)
	else
		setBoneInfo(fr, IG3D_BRAKE,0)
		setBoneInfo(fl, IG3D_BRAKE,0)
		setMaterialInfo(m, IG3D_TEXTURE, 1, "Data/Images/Vehicles/Cmro_tex.png")
		setMaterialInfo(m, IG3D_EMISSION, 0,0,0,1)
	end
	
	--hand brakes
	if hbrake then
		setBoneInfo(rr, IG3D_BRAKE, 1)
		setBoneInfo(rl, IG3D_BRAKE, 1)
	else
		setBoneInfo(rr, IG3D_BRAKE, 0)
		setBoneInfo(rl, IG3D_BRAKE, 0)
	end
	
	steer=steerl-steerr
	
	
	setBoneInfo(fr, IG3D_STEERING_ANGLE, steer)
	setBoneInfo(fl, IG3D_STEERING_ANGLE, steer)
end


function position_car_lights()
	--local x,y,z=getObjectInfo(car.cObj, IG3D_POSITION)
	local a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44= getObjectInfo(car.cObj, IG3D_ROTATION_MATRIX)
	setLightInfo(1, IG3D_POSITION, a41,3.6,a43+1,1)--+2
	local lx,ly,lz
	lx=a11*0+a21* (-0.507) + a31 * 0.5
	ly=a12*0+a22* (-0.507) + a32 * 0.5
	lz=a13*0+a23* (-0.507) + a33 * 0.5
	
	setLightInfo(1, IG3D_SPOTLIGHT, lx,ly,lz,180.000000,15.000000)
end

nextSteer=time()
gsr=0.8
gsl=0.2

function udg_track_car_with_camera()
	
	local x,y,z=getObjectInfo(car.cObj, IG3D_POSITION)
	local cx,cy,cz=getCameraInfo(IG3D_POSITION)

	
	
	
	local velx,vely,velz=getObjectInfo(car.cObj, IG3D_VELOCITY)
	if vecLength(velx,vely,velz)<5 and z<84 then
		drive_car_around1(car, true, false, false, false, 0, 0)
	else
		if z>84 then
			
			if not crashTheRadio and not gRadioOff then
				
				crashTheRadio=time()+1.6
				setSound_emitterInfo(skid, IG3D_POSITION, cx,cy,cz)
				setSound_emitterInfo(skid, IG3D_START)
			end
			if time()>nextSteer then
				gsr=1-gsr
				gsl=1-gsl
				nextSteer=time()+0.8
			end
			if crashTheRadio and time()>crashTheRadio then gsr=0; gsl=0 end
			drive_car_around1(car, false, false, true, false, gsr, gsl)
		else
			drive_car_around1(car, false, false, false, false, 0, 0)
		end
	end
	
	
	if crashTheRadio and time()>crashTheRadio then
		gRadioOff=true
		--setSound_emitterInfo(radio, IG3D_STOP)
		crashTheRadio=nil
	end
	
	
	
	local a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44= getObjectInfo(car.cObj, IG3D_ROTATION_MATRIX)
	setCameraInfo(IG3D_ROTATION, dirToAngles(a31,a32,a33))
	
		setCameraInfo(IG3D_POSITION, x+.11,y+0.4 ,z+.2)
		local cx,cy,cz=getCameraInfo(IG3D_POSITION)

	setParticle_emitterInfo(snow, IG3D_POSITION, x,y+1,z+4)
	setParticle_emitterInfo(blizzard1, IG3D_POSITION, x,y+1,z+6)
	setParticle_emitterInfo(blizzard2, IG3D_POSITION, x,y+1,z+5)
	
	
		--setParticle_emitterInfo(snow, IG3D_ROTATION, dirToAngles(x-cx,y-cy,z+cz))
	--setParticle_emitterInfo(blizzard1, IG3D_ROTATION, dirToAngles(cx,cy,cz))
	--setParticle_emitterInfo(blizzard2, IG3D_ROTATION, dirToAngles(cx,cy,cz))
	
	--setSceneInfo(IG3D_SOUND_DAMPING, 0, 0, 0.04, 100)
	--setCameraInfo(IG3D_ROTATION, dirToAngles(x-cx,y-cy+0.1,z+cz+1))
	
	setSound_emitterInfo(gUDGMusic, IG3D_POSITION, cx,cy,cz)
end

function udg_display_igame3d_presents()
	setSceneInfo(IG3D_MOUSE_VIEW, true, 1)
	if firstFrame then 
		firstFrame=false
		spilloilovertheplace()
	
		setParticle_emitterInfo(snow, IG3D_START)
		setParticle_emitterInfo(blizzard1, IG3D_START)
		setParticle_emitterInfo(blizzard2, IG3D_START)
		return
	end
	
	if not gRadioIsPlaying then
			setSound_emitterInfo(gUDGMusic, IG3D_VOLUME, 100)
			setSound_emitterInfo(gUDGMusic, IG3D_POSITION, getCameraInfo(IG3D_POSITION))
			setSound_emitterInfo(gUDGMusic, IG3D_START)
			setSound_emitterInfo(gUDGMusic, IG3D_LOOP, false)
			gRadioIsPlaying=true
		end
	setText_boxInfo(gTextboxes[1], IG3D_TEXT, gCreditTexts[gCurCredit])
	center_text_box(gTextboxes[1])
	local r,g,b,a= getText_boxInfo(gTextboxes[1], IG3D_COLOR)	
	gAlpha = gAlpha +passed()*gFadeMult
	if gAlpha >=1.8 then
		gAlpha =1
		gFadeMult=-gFadeMult
		
	end
	
	if gAlpha < -0.8 then
		gFadeMult=-gFadeMult
		gAlpha =0
		gCurCredit=gCurCredit+1
		if gCurCredit >2 then gCameraFollowCarNow=true end
		
		
		if gCurCredit > #gCreditTexts then
			if gCreditTexts==gCreditTexts1 then
				gCurCredit=1
				gCreditTexts= gCreditTexts2
				
				setCameraInfo(IG3D_POSITION, 46.181679, 3.412938, 39.368523)
				game_func=fade_to_scene
			else
				if gCreditTexts==gCreditTexts2 then
					gCurCredit=1
					gCreditTexts=gCreditTexts3
					
					--loadLevel("Data/Levels/UDG/UDG_LivingInn")
				else
					if gCreditTexts==gCreditTexts3 then
						gCurCredit=1
						local m=get(ig3d_material, blendQuad.cObj, 1)
						setMaterialInfo(m, IG3D_COLOR, 0,0,0,0)
						setMaterialInfo(m, IG3D_TEXTURE, 1, nil)
						game_func=fade_to_black
						return
					end
				end
			end
		end
	end
	
	
	
	setText_boxInfo(gTextboxes[1], IG3D_COLOR, r,g,b,math.max(0, math.min(gAlpha,1)))
		-- gRadioIsPlaying is now gCameraFollowCarNow
	if gCameraFollowCarNow then
		udg_track_car_with_camera()
		position_car_lights()
	end
	
	--escape key
	if key(27,"-") then
		setSceneInfo(IG3D_RECEIVE_SHADOW, false)
		loadLevel("Data/Levels/UDG/UDG_MainMenu")
		return
	end
	
	fltk_update()
	
end

function cammovestraightforward()
	--local a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getCameraInfo(IG3D_ROTATION_MATRIX)
	local x,y,z=getCameraInfo(IG3D_POSITION)
	--local cx,cy,cz=getObjectInfo(playerBox.cObj, IG3D_POSITION)
	local cx=47.919269561768
	local cy=1.4337348937988
	local cz=87.655166625977
			

	local dx,dy,dz=normalized(cx-x,cy-y,cz-z)
	
	setCameraInfo(IG3D_POSITION, x+dx*passed()*2, y+dy*passed()*2, z+dz*passed()*2)
	
	if vecLength(x-cx,y-cy,z-cz)<1 then
		cammovement=nil
		gSpillCameraTime=time()+10.0
	end
	
end

function stopcaroncollision(obj1, bone1, obj2, bone2, x,y,z)
--[[
	setObjectInfo(obj1.cObj, IG3D_VELOCITY, 0,0,0)
	setObjectInfo(obj2.cObj, IG3D_VELOCITY, 0,0,0)
	setObjectInfo(obj1.cObj, IG3D_OMEGA, 0,0,0)
	setObjectInfo(obj2.cObj, IG3D_OMEGA, 0,0,0)
	setObjectInfo(obj1.cObj, IG3D_VEHICLE, false)
	setObjectInfo(obj2.cObj, IG3D_VEHICLE, false)
	setObjectInfo(obj1.cObj, IG3D_COLL, false)
	setObjectInfo(obj2.cObj, IG3D_COLL, false)
	setObjectInfo(obj1.cObj, IG3D_GRAVITY_MULTIPLIER, 0)
	setObjectInfo(obj2.cObj, IG3D_GRAVITY_MULTIPLIER, 0)
	--]]
end

function particle_mesh_collides(emt, x,y,z)
	if emt=="oil" then
		setParticle_emitterInfo(oilonfloor, IG3D_POSITION, x,y+0.01,z)
		setParticle_emitterInfo(oilonfloor, IG3D_START)
	end
end

activate_per_pixel_shader_for_each_material()--uh oh

coll_o_o= stopcaroncollision
coll_p_m=particle_mesh_collides
game_func= udg_display_igame3d_presents
firstFrame=true


