doors={}

--table.insert(doors, gObjects[19])
local i,ii,shortname,checkName
for i=1,#gObjects,1 do
	local checkName=string.sub(getObjectInfo(gObjects[i].cObj, IG3D_NAME),1,5)
	local shortname = string.sub(checkName, 1,5)
	if string.find(checkName,"door") ~= nil then 
	table.insert(doors, gObjects[i])
	--print(getObjectInfo(gObjects[i].cObj, IG3D_NAME))
	end
end
	
for i=1,#doors,1 do
	setObjectInfo(doors[i].cObj, IG3D_GRAVITY_MULTIPLIER, 1)
	setObjectInfo(doors[i].cObj, IG3D_MASS, 0,0,0,0)
	setObjectInfo(doors[i].cObj, IG3D_CAST_SHADOW, gDoShadows, computeShadowModelName(doors[i]))
	doors[i].house=true
	doors[i].alive=true
	doors[i].team=doorsTeam
	doors[i].life=20
end
--print("# doors=",#doors)