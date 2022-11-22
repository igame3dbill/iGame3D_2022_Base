gTorqueMult=4
gBrakeMult= 4

function getEnginePitchForCar()
	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(car.cObj, IG3D_ROTATION_MATRIX)
	local velx,vely,velz=getObjectInfo(car.cObj, IG3D_VELOCITY)
	local vel=dot(velx,vely,velz,a31,a32,a33)*2

	if vel>35 then
		vel=vel-20
	end
	if vel>35 then
		vel=vel-15
	end
	
	if vel>35 then
		vel=vel-10
	end

	local pitch=75+math.abs(vel)
	return pitch
end



function handle_car_sounds()
	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(car.cObj, IG3D_ROTATION_MATRIX)
	setSound_emitterInfo(engine, IG3D_POSITION, getObjectInfo(car.cObj, IG3D_POSITION))
	setSound_emitterInfo(engine, IG3D_PITCH, getEnginePitchForCar())
	setSound_emitterInfo(engine, IG3D_VOLUME, 25)
	local skidvalue
	local velx,vely,velz=getObjectInfo(car.cObj, IG3D_VELOCITY)
	if vecLength(velx,vely,velz)>4 then
		velx,vely,velz=normalized(velx,vely,velz)
		skidvalue=math.abs(dot(a11,a12,a13, velx,vely,velz))
		
		
		local ox,oy,oz=getCameraInfo(IG3D_ROTATION)
		local ox2,oy2,oz2=getCameraInfo(IG3D_POSITION)
	setCameraInfo(IG3D_ROTATION_MATRIX, a11,a12,a13,a14, a31,a32,a33,a34, -a21,-a22,-a23,-a24, a41,a42,a43,a44) --this line is pretty wild, I cant remember why one wants to set a 4x4 matrix to a 3x3 matrix
	setParticle_emitterInfo(tireTraces, IG3D_PARTICLE_PLANE, true, getCameraInfo(IG3D_ROTATION))
	setCameraInfo(IG3D_ROTATION, ox,oy,oz)
	setCameraInfo(IG3D_POSITION, ox2,oy2,oz2)
	px,py,pz=getBoneInfo(get(ig3d_bone, car.cObj, "RightRearWheel"),IG3D_POSITION)
	setParticle_emitterInfo(tireTraces, IG3D_POSITION, px,py-0.2,pz)
	setParticle_emitterInfo(tireTraces, IG3D_START)
	
	px,py,pz=getBoneInfo(get(ig3d_bone, car.cObj, "LeftRearWheel"),IG3D_POSITION)
	setParticle_emitterInfo(tireTraces, IG3D_POSITION, px,py-0.2,pz)
	setParticle_emitterInfo(tireTraces, IG3D_START)
	else
		skidvalue=math.abs(dot(a11,a12,a13, velx,vely,velz))/4
	end
	
	
	setSound_emitterInfo(skid, IG3D_VOLUME, 100*skidvalue)
	setSound_emitterInfo(skid, IG3D_PITCH, 130)
	setSound_emitterInfo(skid, IG3D_POSITION, getObjectInfo(car.cObj, IG3D_POSITION))
	
	
		--[[
		px,py,pz=getBoneInfo(get(ig3d_bone, car.cObj, "RightFrontWheel"),IG3D_POSITION)
		setParticle_emitterInfo(tireTraces, IG3D_POSITION, px,py,pz)
		setParticle_emitterInfo(tireTraces, IG3D_START)
		
		px,py,pz=getBoneInfo(get(ig3d_bone, car.cObj, "LeftFrontWheel"),IG3D_POSITION)
		setParticle_emitterInfo(tireTraces, IG3D_POSITION, px,py,pz)
		setParticle_emitterInfo(tireTraces, IG3D_START)
		--]]
		
	
	
end

gLastDeltaYDirection=0
gLastDeltaYDirection=0
iphonekeyw=false
iphonekeys=false
iphonekeya=false
iphonekeyd=false
iphonekeyspace=false



steer=0
function handle_car_desktop_controls()
	local fr=get(ig3d_bone, car.cObj, "RightFrontWheel")
	local fl=get(ig3d_bone, car.cObj, "LeftFrontWheel")
	local rr=get(ig3d_bone, car.cObj, "RightRearWheel")
	local rl=get(ig3d_bone, car.cObj, "LeftRearWheel")

	gCameraBehind=5.0--5.0
	gCameraUp=2.0--2.0

	longmag=math.min(longmag+passed(), 1)
	latmag=math.min(latmag+passed()*0.1,0.1)
	

	local vx,vy,vz=getObjectInfo(car.cObj, IG3D_VELOCITY)
	local speed=math.sqrt(vx*vx+vy*vy+vz*vz)
	local torqueVal=gTorqueMult * (1.0 - speed / 25.0)
	--throttle
	if key("w","-") or iphonekeyw then--and speed<10 then
		setBoneInfo(fr, IG3D_TORQUE, torqueVal)
		setBoneInfo(fl, IG3D_TORQUE, torqueVal)
		--setBoneInfo(rr, IG3D_TORQUE, torqueVal)
		--setBoneInfo(rl, IG3D_TORQUE, torqueVal)
	else
		if key("s","-") or iphonekeys then--and speed < 10 then
			setBoneInfo(fr, IG3D_TORQUE, -torqueVal)
			setBoneInfo(fl, IG3D_TORQUE, -torqueVal)
			--setBoneInfo(rr, IG3D_TORQUE, -torqueVal)
			--setBoneInfo(rl, IG3D_TORQUE, -torqueVal)
		else
		
		setBoneInfo(fr, IG3D_TORQUE, 0)
		setBoneInfo(fl, IG3D_TORQUE, 0)
		setBoneInfo(rr, IG3D_TORQUE, 0)
		setBoneInfo(rl, IG3D_TORQUE, 0)
		end
	end
	
	--front braking
	m=get(ig3d_material, car.cObj, 6)
	if key(" ","-") or iphonekeyspace then
		setBoneInfo(fr, IG3D_BRAKE,1*gBrakeMult)
		setBoneInfo(fl, IG3D_BRAKE,1*gBrakeMult)
		setMaterialInfo(m, IG3D_TEXTURE, 1, "Data/Images/Vehicles/Cmro_texbrake.png")
		setMaterialInfo(m, IG3D_EMISSION, 1,0,0,1)
	else
		setBoneInfo(fr, IG3D_BRAKE,0)
		setBoneInfo(fl, IG3D_BRAKE,0)
		setMaterialInfo(m, IG3D_TEXTURE, 1, "Data/Images/Vehicles/Cmro_tex.png")
		setMaterialInfo(m, IG3D_EMISSION, 0,0,0,1)
	end
	
	
	--disabled hand brakes
	if gNativeOS=="iphone" then
		steer=math.max(-1, math.min(-gLastDeltaXDirection*0.1,1))
	else
	--hand brakes
	if click("-") then
		setBoneInfo(rr, IG3D_BRAKE, 1*gBrakeMult)
		setBoneInfo(rl, IG3D_BRAKE, 1*gBrakeMult)
	else
		setBoneInfo(rr, IG3D_BRAKE, 0)
		setBoneInfo(rl, IG3D_BRAKE, 0)
	end
	
	
	--steering
	
	
	if key("a","-") or iphonekeya then
		steer=math.min(steer+passed()*3,1)
	else
	
		if key("d","-") or iphonekeyd then
			steer=math.max(steer-passed()*3,-1)
		else
			if steer>0 then
				steer=math.max(steer-passed()*3,0)
			end
			if steer<0 then
				steer=math.min(steer+passed()*3,0)
			end
		end
	end
	end
	
	
	
	setBoneInfo(fr, IG3D_STEERING_ANGLE, steer)
	setBoneInfo(fl, IG3D_STEERING_ANGLE, steer)
end

function handle_car_iphone_controls()
	setSceneInfo(IG3D_MOUSE_VIEW, false)
	local fr=get(ig3d_bone, car.cObj, "RightFrontWheel")
	local fl=get(ig3d_bone, car.cObj, "LeftFrontWheel")
	local rr=get(ig3d_bone, car.cObj, "RightRearWheel")
	local rl=get(ig3d_bone, car.cObj, "LeftRearWheel")

	gCameraBehind=5.0--5.0
	gCameraUp=2.0--2.0

	longmag=math.min(longmag+passed(), 1)
	latmag=math.min(latmag+passed()*0.1,0.1)
	
	local ax,ay,az,bx,by,bz=getSceneInfo(IG3D_MOUSE_LINE)
	local wx,wy,wz=getSceneInfo(IG3D_WINDOW_COORDS, ax,ay,az)
	
	--print(wy)
	--local forwmultiplier= (wx-160) / 320
	if wx>160 then forwmultiplier=1 else forwmultiplier=-1 end
	
	local sidemultiplier=- (wy-240) / 240
	

	local vx,vy,vz=getObjectInfo(car.cObj, IG3D_VELOCITY)
	local speed=math.sqrt(vx*vx+vy*vy+vz*vz)
	local torqueVal=gTorqueMult * (1.0 - speed / 25.0)
	
	if click("-") then
		setBoneInfo(fr, IG3D_TORQUE, torqueVal*forwmultiplier)
		setBoneInfo(fl, IG3D_TORQUE, torqueVal*forwmultiplier)
		setBoneInfo(fr, IG3D_BRAKE,0)
		setBoneInfo(fl, IG3D_BRAKE,0)
		setMaterialInfo(m, IG3D_TEXTURE, 1, "Data/Images/Vehicles/Cmro_tex.png")
		setMaterialInfo(m, IG3D_EMISSION, 0,0,0,1)
	else
		setBoneInfo(fr, IG3D_TORQUE, 0)
		setBoneInfo(fl, IG3D_TORQUE, 0)
		setBoneInfo(fr, IG3D_BRAKE,1)
		setBoneInfo(fl, IG3D_BRAKE,1)
		setMaterialInfo(m, IG3D_TEXTURE, 1, "Data/Images/Vehicles/Cmro_texbrake.png")
		setMaterialInfo(m, IG3D_EMISSION, 1,0,0,1)
	end
	
	steer=math.max(-1, math.min(sidemultiplier,1))
	
	setBoneInfo(fr, IG3D_STEERING_ANGLE, steer)
	setBoneInfo(fl, IG3D_STEERING_ANGLE, steer)

end

function car_control()
	
	
	if gNativeOS =="iphone" then
		handle_car_iphone_controls()
	else
		handle_car_desktop_controls()
	end
	
	
	handle_car_sounds()
	
	for i=1,#aliens,1 do
		walk_away_from(aliens[i], car)
	end
	
	position_camera(car)
	
end