function buildDistancesTable(all)
	--first calculate the relevant people
	local i,j,x,y,z,x2,y2,z2,ds
	local cx,cy,cz=getCameraInfo(IG3D_POSITION)
	
	for i=1,#gObjects,1 do
		if all then
			gObjects[i].relevant=true
		else
			x,y,z=getObjectInfo(gObjects[i].cObj, IG3D_POSITION)
			ds=vecLength(cx-x,cy-y,cz-z)
			if ds>20 then gObjects[i].relevant=false else gObjects[i].relevant=true end
		end
	end
	

	
	if gDistances==nil then
		gDistances={}
		for i=1,#gObjects,1 do
			gDistances[i]={}
		end
	end	
	
	for i=1,#gObjects,1 do
		if gObjects[i].relevant then
			for j=i,#gObjects,1 do
				if gObjects[j].relevant then
					if i==j then
						gDistances[i][i]=0
					else
						x,y,z=getObjectInfo(gObjects[i].cObj, IG3D_POSITION)
						x2,y2,z2=getObjectInfo(gObjects[j].cObj, IG3D_POSITION)
						ds=vecLength(x2-x,y2-y,z2-z)
						gDistances[i][j]=ds
						gDistances[j][i]=ds
					end
				end
			end
		end
	end
end

function objdistance(o1,o2)
	return gDistances[o1.cObj][o2.cObj]
end


function handle_object_eyes(obj)
	local bn=get(ig3d_bone, obj.cObj, "head")
	local x,y,z=getBoneInfo(bn, IG3D_POSITION)
	local i
	local x2,y2,z2
	local dx,dy,dz
	local dp
	local oldcoll=getObjectInfo(obj.cObj, IG3D_COLL)
	
	a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)
	
	
	setObjectInfo(obj.cObj, IG3D_COLL, false)--need to disable this for the picking (ie dont pick self)
	if obj.vehicle~= nil then
		ox,oy,oz=getObjectInfo(obj.vehicle.cObj, IG3D_POSITION)
		setObjectInfo(obj.vehicle.cObj, IG3D_POSITION, 1000,1000,1000)
	end
	
	for i=1,#gObjects,1 do	
		
		
		if gObjects[i]~= obj then
			--only handle other objects
			gObjects[i].seenFlag=false
			
			x2,y2,z2=getObjectInfo(gObjects[i].cObj, IG3D_POSITION)
			dx=x2-x
			dy=y2-y
			dz=z2-z
			dx,dy,dz=normalized(dx,dy,dz)
			dp=dot(a31,a32,a33, dx,dy,dz)
			--first check if the object is in the 90 degree field of view
			if dp>=0.707 then
				--print(getObjectInfo(gObjects[i].cObj, IG3D_NAME).." is in line of sight")
				
				local c,px,py,pz,o=lineCollision(x,y,z, x2,y2,z2)
				
				
				if c==2 and o==gObjects[i] then--an object was hit by the picking line
					table.insert(obj.sensed, gObjects[i])
					gObjects[i].seenFlag=true
					--print(getObjectInfo(gObjects[i].cObj, IG3D_NAME).." is seen")
				else
					--print(getObjectInfo(gObjects[i].cObj, IG3D_NAME).." is occluded")
				end
			
			end
			
		end
		
	end
	
	setObjectInfo(obj.cObj, IG3D_COLL, oldcoll)--reset collidability
	if obj.vehicle~=nil then
		setObjectInfo(obj.vehicle.cObj, IG3D_POSITION, ox,oy,oz)
	end
end


function handle_object_ears(obj)
	
	
	for i=1,#gObjects,1 do	
		
		
		if gObjects[i]~= obj then
			--only handle other objects
			gObjects[i].heardFlag=false
			
			
			if objdistance(obj,gObjects[i]) <= obj.hearingDistance * gObjects[i].noise then
				--print(getObjectInfo(gObjects[i].cObj, IG3D_NAME).." can be heard")
				gObjects[i].heardFlag=true
				if gObjects[i].seenFlag==false then
					--ie not in table yet
					table.insert(obj.sensed, gObjects[i])
				end 
			end
			
		end
		
	end
	
end

function unique_mind_insert(tbl, thng)
	local i
	for i=1,#tbl,1 do
		if tbl[i].o==thng.o then 
			if thng.seenFlag then tbl[i].seenFlag=true end
			if thng.heardFlag then tbl[i].heardFlag = true end
			return
		end
	end
	table.insert(tbl,thng)
end

function handle_object_remembering(obj)
	local i
	for i=1,#obj.mind,1 do
		if obj.mind[i].heardFlag then obj.mind[i].o.heardFlag=obj.mind[i].heardFlag end
		if obj.mind[i].seenFlag then obj.mind[i].o.seenFlag=obj.mind[i].seenFlag end
		table.insert(obj.sensed, obj.mind[i].o)
	end
end
