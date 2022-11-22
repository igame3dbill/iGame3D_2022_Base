levelexit={}


local i,ii,shortname,checkName
for i=1,#gObjects,1 do
	local checkName=string.sub(getObjectInfo(gObjects[i].cObj, IG3D_NAME),1,-1)
	local shortname = string.sub(checkName, 1,5)
	if string.find(checkName,"levelexit") ~= nil then 
	table.insert(levelexit, gObjects[i])
	levelexit[#levelexit].objectnum=i
	levelexit[#levelexit].position={gObjectPositions[i][1],gObjectPositions[i][2],gObjectPositions[i][3]}
	levelexit[#levelexit].rotation={gObjectRotations[i][1],gObjectRotations[i][2],gObjectRotations[i][3]}
	end
end
	
for i=1,#levelexit,1 do
	setObjectInfo(levelexit[i].cObj, IG3D_GRAVITY_MULTIPLIER, 1)
	setObjectInfo(levelexit[i].cObj, IG3D_MASS, 0,0,0,0)
	--setObjectInfo(levelexit[i].cObj, IG3D_CAST_SHADOW, gDoShadows, computeShadowModelName(levelexit[i]))
	levelexit[i].house=false
	levelexit[i].alive=false
	levelexit[i].levelexit=true
	levelexit[i].team=levelexitTeam
	levelexit[i].life=4000
	setObjectInfo(levelexit[i].cObj, IG3D_SHAPE, ig3d_box)
	setObjectInfo(gObjects[i].cObj, IG3D_COLLBOX_MULTIPLICATORS, 1,1,1)--brave new world!
end
--print("# levelexit=",#levelexit)
