windows={}

--table.insert(windows, gObjects[19])
local i,ii,shortname,checkName
for i=1,#gObjects,1 do
	local checkName=string.sub(getObjectInfo(gObjects[i].cObj, IG3D_NAME),1,-1)
	local shortname = string.sub(checkName, 1,5)
	if string.find(checkName,"window") ~= nil or string.find(checkName,"glasscube")~=nil then 
	--print(checkName)
	table.insert(windows, gObjects[i])
	windows[#windows].objectnum=i
	windows[#windows].position={gObjectPositions[i][1],gObjectPositions[i][2],gObjectPositions[i][3]}
	windows[#windows].rotation={gObjectRotations[i][1],gObjectRotations[i][2],gObjectRotations[i][3]}
	--print(getObjectInfo(gObjects[i].cObj, IG3D_NAME))
	end
end
	
for i=1,#windows,1 do
	windows[i].glass=true
	windows[i].house=true
	windows[i].alive=false
	windows[i].team=windowTeam
	windows[i].health=10
	windows[i].noiseSndEmt=assign_free_sound_emitter()
	setObjectInfo(windows[i].cObj, IG3D_SHAPE, ig3d_box)
	setObjectInfo(windows[i].cObj, IG3D_MASS, 0,0,0,0)
	setObjectInfo(windows[i].cObj, IG3D_COLLBOX_MULTIPLICATORS, 1,1,1)--brave new world!
end
--print("# windows=",#windows)

function udg_SnipersAlleyWindows()
for i=1,#windows,1 do
	windows[i].glass=true
	windows[i].house=true
	windows[i].alive=false
	windows[i].team=windowTeam
	windows[i].health=500
	windows[i].noiseSndEmt=assign_free_sound_emitter()
	setObjectInfo(windows[i].cObj, IG3D_SHAPE, ig3d_box)
	setObjectInfo(windows[i].cObj, IG3D_MASS, 0,0,0,0)
	setObjectInfo(windows[i].cObj, IG3D_COLLBOX_MULTIPLICATORS, 1,1,1)--brave new world!
end
--print("# windows=",#windows)
end



function handle_UDG_Windows()
for i = 1,#windows,1 do
n = windows[i].objectnum
if windows[i].health>0 then
	local x,y,z = windows[i].position[1], windows[i].position[2], windows[i].position[3]
	local xa,ya,za = windows[i].rotation[1], windows[i].rotation[2], windows[i].rotation[3]
	setObjectInfo(windows[i].cObj,IG3D_POSITION,x,y,z)
	setObjectInfo(windows[i].cObj,IG3D_ROTATION,xa,ya,za)
end
end
end