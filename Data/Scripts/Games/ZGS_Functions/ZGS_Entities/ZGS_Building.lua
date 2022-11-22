buildings={}
walls={}
--table.insert(buildings, gObjects[19])
local i,ii,shortname,checkName
for i=1,#gObjects,1 do
	checkName=string.sub(getObjectInfo(gObjects[i].cObj, IG3D_NAME),1,5)
	local shortname = string.sub(checkName, 1,5)
	
	if shortname== "build"   or shortname== "house" or shortname== "domic" or shortname == "shelt" then
	table.insert(buildings, gObjects[i])
	--print(getObjectInfo(gObjects[i].cObj, IG3D_NAME))
	end
	if string.sub(checkName, 1,4)== "wall"   then
	table.insert(walls, gObjects[i])
	
	--print(getObjectInfo(gObjects[i].cObj, IG3D_NAME))
	end
	
end
	
for i=1,#buildings,1 do
	setObjectInfo(gObjects[i].cObj, IG3D_GRAVITY_MULTIPLIER, 1)
		setObjectInfo(gObjects[i].cObj, IG3D_VECTOR_CONSTRAINT, 0,1,0)
	setObjectInfo(buildings[i].cObj, IG3D_MASS, 0,0,0,0)
	
	setObjectInfo(buildings[i].cObj, IG3D_CAST_SHADOW, gDoShadows)
	buildings[i].house=true
	buildings[i].alive=false
	buildings[i].team=4
end

if #walls > 1 then 
for i=1,#walls,1 do
	setObjectInfo(gObjects[i].cObj, IG3D_GRAVITY_MULTIPLIER, 1)
		setObjectInfo(gObjects[i].cObj, IG3D_VECTOR_CONSTRAINT, 0,1,0)
	setObjectInfo(walls[i].cObj, IG3D_MASS, 0,0,0,0)
	
	setObjectInfo(walls[i].cObj, IG3D_CAST_SHADOW, false)
	walls[i].house=false
	walls[i].alive=false
	walls[i].team=5
end
end

print("# buildings=",#buildings)