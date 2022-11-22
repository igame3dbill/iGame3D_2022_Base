-- RTS_Human.lua

gHumanNames={"jacky","masterchief","officer1","officer2","anita","mcTr","true","human","fighter","chick"}
humans={}
gTrackingLights={}
gTrackingLight= 2
local i,ii,shortCheckName,checkName
for i=1,#gObjects,1 do
	checkName = string.sub(getObjectInfo(gObjects[i].cObj, IG3D_NAME),1,4)
	for ii=1,#gHumanNames,1 do
	
	local shortCheckName = string.sub(gHumanNames[ii], 1,4)
		if checkName == shortCheckName  then
		
		--additional repositioning, a house could have been placed above a human...
		putObjectOnGround(gObjects[i])
		
		table.insert(humans, gObjects[i])
		
		
		if gTrackingLight < 9 then
		table.insert(gTrackingLights,{gTrackingLight,gObjects[i]})
		gTrackingLight = gTrackingLight + 1
		end
		
		end
	end
end
gTrackingLight= 2
--print("# humans=",#humans)

