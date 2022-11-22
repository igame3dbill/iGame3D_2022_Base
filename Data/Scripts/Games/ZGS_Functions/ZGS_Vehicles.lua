

function getEnginePitchForCar(obj)
	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)
	local velx,vely,velz=getObjectInfo(obj.cObj, IG3D_VELOCITY)
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



function handle_car_sounds(obj)
	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)
	setSound_emitterInfo(obj.engineSndEmt, IG3D_POSITION, getObjectInfo(obj.cObj, IG3D_POSITION))
	setSound_emitterInfo(obj.engineSndEmt, IG3D_PITCH, getEnginePitchForCar(obj))
	setSound_emitterInfo(obj.engineSndEmt, IG3D_VOLUME, 5)--5=25
	local skidvalue
	local velx,vely,velz=getObjectInfo(obj.cObj, IG3D_VELOCITY)
	if vecLength(velx,vely,velz)>4 then
		velx,vely,velz=normalized(velx,vely,velz)
		skidvalue=math.abs(dot(a11,a12,a13, velx,vely,velz))
		
		if skidvalue>0.2 then
			ox,oy,oz=getCameraInfo(IG3D_ROTATION)
			local lx,ly,lz=cross(a21,a22,a23, velx,vely,velz)
			setCameraInfo(IG3D_ROTATION_MATRIX, lx,ly,lz,0, velx,vely,velz,0, -a21,-a22,-a23,0, 0,0,0,1)

			setParticle_emitterInfo(tireTraces, IG3D_PARTICLE_PLANE, true, getCameraInfo(IG3D_ROTATION))
			setCameraInfo(IG3D_ROTATION, ox,oy,oz)
			px,py,pz=getBoneInfo(get(ig3d_bone, obj.cObj, "RightRearWheel"),IG3D_POSITION)
			setParticle_emitterInfo(tireTraces, IG3D_POSITION, px,py-0.2,pz)
			setParticle_emitterInfo(tireTraces, IG3D_START)
	
			px,py,pz=getBoneInfo(get(ig3d_bone, obj.cObj, "LeftRearWheel"),IG3D_POSITION)
			setParticle_emitterInfo(tireTraces, IG3D_POSITION, px,py-0.2,pz)
			setParticle_emitterInfo(tireTraces, IG3D_START)
		end
	else
		skidvalue=math.abs(dot(a11,a12,a13, velx,vely,velz))/4
	end
	
	if getSceneInfo(IG3D_SPEED)~= 1 then
		skidvalue=0
	end
	setSound_emitterInfo(obj.skidSndEmt, IG3D_VOLUME, 25*skidvalue*skidvalue)--25=100
	setSound_emitterInfo(obj.skidSndEmt, IG3D_PITCH, 130)
	setSound_emitterInfo(obj.skidSndEmt, IG3D_POSITION, getObjectInfo(obj.cObj, IG3D_POSITION))
	
end



-- in game car engine idling
function play_car_sounds()
	for i=1,#gObjects,1 do
		if getObjectInfo(gObjects[i].cObj, IG3D_VEHICLE) == true then
			if gObjects[i].driver~= nil then
				handle_car_sounds(gObjects[i])
			end
		end
	end
end


-- steer_aim
function steer_aim(obj, x,y,z)
	obj.x,obj.y,obj.z=getObjectInfo(obj.cObj, IG3D_POSITION)
	local dx,dy,dz=normalized(x-obj.x,0,z-obj.z)
	
	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)
	d=dot(a31,a32,a33, dx,dy,dz)
	
	
	d=math.max(0,d)--uh oh
	d=math.min((1-d)*3,1)
	steerr=0
	steerl=d
	if dot(a11,a12,a13,dx,dy,dz)<dot(-a11,-a12,-a13,dx,dy,dz) then
		--turn... but in what direction?
		steerr=d
		steerl=0
	end
	steerr=math.min(0.999999, math.max(-0.999999,steerr))
	steerl=math.min(0.999999, math.max(-0.999999,steerl))
	return {time()+0.2, true, false, false, false, steerr, steerl }	
end

function drive_car_around(obj, forw, backw, brake, hbrake, steerr, steerl)
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
	--CAMARO FRONT BRAKING
	--front braking  
	--m=get(ig3d_material, obj.cObj, 6)
	--if brake then
	--	setBoneInfo(fr, IG3D_BRAKE,1)
	--	setBoneInfo(fl, IG3D_BRAKE,1)
	--	setMaterialInfo(m, IG3D_TEXTURE, 1, "Data/Images/Vehicles/Cmro_texbrake.png")
	--	setMaterialInfo(m, IG3D_EMISSION, 1,0,0,1)
	--else
	--	setBoneInfo(fr, IG3D_BRAKE,0)
	--	setBoneInfo(fl, IG3D_BRAKE,0)
	--	setMaterialInfo(m, IG3D_TEXTURE, 1, "Data/Images/Vehicles/Cmro_tex.png")
	--	setMaterialInfo(m, IG3D_EMISSION, 0,0,0,1)
	--end
	
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



function init_car(obj)
	local fr=get(ig3d_bone, obj.cObj, "RightFrontWheel")
	local fl=get(ig3d_bone, obj.cObj, "LeftFrontWheel")
	local rr=get(ig3d_bone, obj.cObj, "RightRearWheel")
	local rl=get(ig3d_bone, obj.cObj, "LeftRearWheel")
	setBoneInfo(rr, IG3D_BRAKE, 1)
	setBoneInfo(rl, IG3D_BRAKE, 1)
end


function nearestCrossing(x,y,z, gridSize)
	local i=math.floor(x/gridSize)
	local remainder=x - (i*gridSize)
	if remainder > gridSize*0.5 then i=i+1 end
	local j=math.floor(z/gridSize)
	remainder=z - (j*gridSize)
	if remainder > gridSize*0.5 then j=j+1 end
	
	local dx=i*gridSize
	local dy=y
	local dz=j*gridSize
	
	
	return dx,dy,dz
end

function headingInWhatDirection(x,y,z, dx,dy,dz)
	local xmag=math.abs(x-dx)
	local zmag=math.abs(z-dz)
	
	if x<dx and xmag>zmag then
		return "east"
	end
	
	if x>dx and xmag>zmag then
		return "west"
	end
	
	if z<dz and zmag>xmag then
		return "south"
	end
	
	if z>dz and zmag>xmag then
		return "north"
	end
end


function getNextCrossingPosition(x,y,z, dx,dy,dz, curveType)
	local dir=headingInWhatDirection(x,y,z,dx,dy,dz)
	dx,dy,dz= nearestCrossing(dx,dy,dz,64)
	
	if dir=="east" then
		if curveType=="right" then
			dz=dz+64
		end
		if curveType=="left" then
			dz=dz-64
		end
		if curveType=="uturn" then
			dx=dx-64
		end
		if curveType=="straight" then
			dx=dx+64
		end
	end
	
	if dir=="west" then
		if curveType=="right" then
			dz=dz-64
		end
		if curveType=="left" then
			dz=dz+64
		end
		if curveType=="uturn" then
			dx=dx+64
		end
		if curveType=="straight" then
			dx=dx-64
		end
	end
	
	if dir=="south" then
		if curveType=="right" then
			dx=dx-64
		end
		if curveType=="left" then
			dx=dx+64
		end
		if curveType=="uturn" then
			dz=dz-64
		end
		if curveType=="straight" then
			dz=dz+64
		end
	end
	
	if dir=="north" then
		if curveType=="right" then
			dx=dx+64
		end
		if curveType=="left" then
			dx=dx-64
		end
		if curveType=="uturn" then
			dz=dz+64
		end
		if curveType=="straight" then
			dz=dz-64
		end
	end
	
	
	return dx,dy,dz
end


function correctCrossingPosition(x,y,z, dx,dy,dz, curveType)
	local dir=headingInWhatDirection(x,y,z,dx,dy,dz)
	
	if dir=="east" then
		if curveType=="right" or curveType=="straight" or curveType=="uturn" then
			dx=dx-4
			dz=dz+4
		end
		if curveType=="left" then
			dx=dx+4
			dz=dz+4
		end
	end
	
	if dir=="west" then
		if curveType=="right" or curveType=="straight" or curveType=="uturn" then
			dx=dx+4
			dz=dz-4
		end
		if curveType=="left" then
			dx=dx-4
			dz=dz-4
		end
	end
	
	if dir=="south" then
		if curveType=="right" or curveType=="straight" or curveType=="uturn" then
			dx=dx-4
			dz=dz-4
		end
		if curveType=="left" then
			dx=dx-4
			dz=dz+4
		end
	end
	
	if dir=="north" then
		if curveType=="right" or curveType=="straight" or curveType=="uturn" then
			dx=dx+4
			dz=dz+4
		end
		if curveType=="left"  then
			dx=dx+4
			dz=dz-4
		end
	end
	
	return dx,dy,dz
end

function car_stuck(obj)
	if obj.stuckCheck==nil then
		obj.stuckCheck=time()+2.0
		obj.sx,obj.sy,obj.sz=getObjectInfo(obj.cObj, IG3D_POSITION)
		obj.stuck=false
		return false
	end
	
	if time() > obj.stuckCheck then
		local x,y,z=getObjectInfo(obj.cObj, IG3D_POSITION)
		if vecLength(x-obj.sx, y-obj.sy, z-obj.sz)<0.5 then
			obj.stuck=not obj.stuck
		else
			obj.stuck=false
		end
		obj.sx=x
		obj.sy=y
		obj.sz=z
		obj.stuckCheck=time()+2.0
	end
	return obj.stuck
end

function car_flipped(obj)
	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)
	return dot(a21,a22,a23, 0,1,0)<=0.0
end

function stepOutOfCar(obj)
		obj.vehicle.health=-10
		obj.behaviour=default_behaviour
		setObjectInfo(obj.cObj, IG3D_COLL, true)
		a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)
		setObjectInfo(obj.cObj, IG3D_POSITION, a41+a11, a42+a12, a43+a13)
		putObjectOnGround(obj)
		setObjectInfo(obj.cObj, IG3D_OMEGA, 0,0,0)
		setObjectInfo(obj.cObj, IG3D_GRAVITY_MULTIPLIER, 1)

		drive_car_around(obj.vehicle, false,false,true,true,0,0)
		setSound_emitterInfo(obj.vehicle.skidSndEmt, IG3D_STOP)
		setSound_emitterInfo(obj.vehicle.engineSndEmt, IG3D_STOP)
		obj.vehicle.driver=nil
		obj.vehicle=nil
		--setObjectInfo(obj.cObj, IG3D_VEHICLE, false)
end
