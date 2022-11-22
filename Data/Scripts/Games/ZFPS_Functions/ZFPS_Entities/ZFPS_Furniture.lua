furniture={}

--table.insert(furniture, gObjects[19])
local i,ii,shortname,checkName
for i=1,#gObjects,1 do
	local x,y,z=getObjectInfo(gObjects[i].cObj, IG3D_POSITION)--
		setObjectInfo(gObjects[i].cObj, IG3D_POSITION, x,y+3000,z)--
		putObjectOnGround(gObjects[i])
local longname = gObjectWTFs[i]
	local checkName=string.sub(getObjectInfo(gObjects[i].cObj, IG3D_NAME),1,-1)
	local shortname = string.sub(checkName, 1,5)
	if string.find(longname,"Furniture") or string.find(longname,"Foliage") ~= nil or string.find(checkName,"furniture") or  string.find(checkName,"foliage") or  string.find(checkName,"game") ~= nil  or  string.find(checkName,"barrel") ~= nil  then 
	--print(checkName)
	table.insert(furniture, gObjects[i])
	furniture[#furniture].objectnum=i
	furniture[#furniture].position={gObjectPositions[i][1],gObjectPositions[i][2],gObjectPositions[i][3]}
	furniture[#furniture].rotation={gObjectRotations[i][1],gObjectRotations[i][2],gObjectRotations[i][3]}
	--print(getObjectInfo(gObjects[i].cObj, IG3D_NAME))
	end
end
	
for i=1,#furniture,1 do
	--quick hack to avoid intersecting object in the start
	

	furniture[i].house=true
	furniture[i].alive=false
	furniture[i].team=windowTeam
	furniture[i].health=1
	setObjectInfo(furniture[i].cObj, IG3D_SHAPE, ig3d_box)
	setObjectInfo(furniture[i].cObj, IG3D_MASS, 0,0,0,0)
	setObjectInfo(furniture[i].cObj, IG3D_COLLBOX_MULTIPLICATORS, 1,1,1)--brave new world!
end
--print("# furniture=",#furniture)
