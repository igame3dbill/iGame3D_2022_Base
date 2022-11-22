scenery={}


local i,ii,shortname,checkName
for i=1,#gObjects,1 do
	local checkName=string.sub(getObjectInfo(gObjects[i].cObj, IG3D_NAME),1,-1)
	local shortname = string.sub(checkName, 1,5)
	if string.find(checkName,"scenery") ~= nil then 
	table.insert(scenery, gObjects[i])
	

	scenery[#scenery].objectnum=i
	scenery[#scenery].position={gObjectPositions[i][1],gObjectPositions[i][2],gObjectPositions[i][3]}
	scenery[#scenery].rotation={gObjectRotations[i][1],gObjectRotations[i][2],gObjectRotations[i][3]}
	
	end
end
	
for i=1,#scenery,1 do

	setObjectInfo(scenery[i].cObj, IG3D_GRAVITY_MULTIPLIER, 1)
	setObjectInfo(scenery[i].cObj, IG3D_MASS, 0,0,0,0)
		
	--setObjectInfo(scenery[i].cObj, IG3D_CAST_SHADOW, gDoShadows, computeShadowModelName(scenery[i]))
	scenery[i].house=false
	scenery[i].alive=false
	scenery[i].team=sceneryTeam
	scenery[i].life=4000
	setObjectInfo(scenery[i].cObj, IG3D_SHAPE, ig3d_box)
	setObjectInfo(gObjects[i].cObj, IG3D_COLLBOX_MULTIPLICATORS, 1,1,1)--brave new world!
	
end
--print("# scenery=",#scenery)
