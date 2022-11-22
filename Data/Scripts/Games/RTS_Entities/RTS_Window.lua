windows={}

--table.insert(windows, gObjects[19])
local i,ii,shortname,checkName
for i=1,#gObjects,1 do
	local checkName=string.sub(getObjectInfo(gObjects[i].cObj, IG3D_NAME),1,5)
	local shortname = string.sub(checkName, 1,5)
	if string.find(checkName,"window") ~= nil then 
	table.insert(windows, gObjects[i])
	--print(getObjectInfo(gObjects[i].cObj, IG3D_NAME))
	end
end
	
for i=1,#windows,1 do
	setObjectInfo(windows[i].cObj, IG3D_GRAVITY_MULTIPLIER, 1)
	setObjectInfo(windows[i].cObj, IG3D_MASS, 0,0,0,0)
	setObjectInfo(windows[i].cObj, IG3D_CAST_SHADOW, gDoShadows, computeShadowModelName(windows[i]))
	windows[i].house=true
	windows[i].alive=true
	windows[i].team=windowsTeam
	windows[i].life=2
end
--print("# windows=",#windows)