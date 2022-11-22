function RTSCamera()
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
	setLightInfo(1, IG3D_POSITION, x,y,z,1)
	setLightInfo(1, IG3D_CONSTANT_ATTENUATION, 1)
	setLightInfo(1, IG3D_LINEAR_ATTENUATION, 0)
	setLightInfo(1, IG3D_QUADRATIC_ATTENUATION, 0.000816326)
	setLightInfo(2, IG3D_POSITION, 150,150,150,0)--for the shadows

end