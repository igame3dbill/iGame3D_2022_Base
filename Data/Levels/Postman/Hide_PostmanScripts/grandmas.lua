gGrandmaDirections={ {5,0}, {-5,0}, {0,5}, {0,-5} }

for i=1,#gObjects,1 do
	if getObjectInfo(gObjects[i].cObj, IG3D_MODEL)=="Characters/grandma.wtf" then
		local theDir= gGrandmaDirections[math.random(1,4)]
		gObjects[i].velx=theDir[1]
		gObjects[i].velz=theDir[2]
	end
end

function handle_grandmas()
	for i=1,#gObjects,1 do
		if getObjectInfo(gObjects[i].cObj, IG3D_MODEL)=="Characters/grandma.wtf" then
			
		
		
			local vx,vy,vz=getObjectInfo(gObjects[i].cObj, IG3D_VELOCITY)
			setObjectInfo(gObjects[i].cObj, IG3D_VELOCITY, gObjects[i].velx,math.min(vy,0),gObjects[i].velz)
			setObjectInfo(gObjects[i].cObj, IG3D_OMEGA, 0,0,0)
			setObjectInfo(gObjects[i].cObj, IG3D_ROTATION, 0,0,0)
		end
	end
end