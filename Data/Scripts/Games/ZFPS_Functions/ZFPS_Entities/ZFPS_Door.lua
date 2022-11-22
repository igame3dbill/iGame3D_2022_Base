doors={}
alldoorsopen = false
lastdoorstate = false
--table.insert(doors, gObjects[19])
local i,ii,shortname,checkName
for i=1,#gObjects,1 do
	local checkName=string.sub(getObjectInfo(gObjects[i].cObj, IG3D_NAME),1,-1)
	local shortname = string.sub(checkName, 1,5)
	if string.find(checkName,"door") ~= nil then 
		table.insert(doors, gObjects[i])
		doors[#doors].objectnum=i
		doors[#doors].position={gObjectPositions[i][1],gObjectPositions[i][2],gObjectPositions[i][3]}
		doors[#doors].rotation={gObjectRotations[i][1],gObjectRotations[i][2],gObjectRotations[i][3]}
		doors[#doors].open =true
		if string.find(checkName, "glass")~=nil then
			doors[#doors].glass=true
			doors[#doors].noiseSndEmt=assign_free_sound_emitter()
		end
	--print(getObjectInfo(gObjects[i].cObj, IG3D_NAME))
	end
end
	
for i=1,#doors,1 do
	--setObjectInfo(doors[i].cObj, IG3D_GRAVITY_MULTIPLIER, 1)
	--setObjectInfo(doors[i].cObj, IG3D_MASS, 0,0,0,0)
	--setObjectInfo(doors[i].cObj, IG3D_CAST_SHADOW, gDoShadows, computeShadowModelName(doors[i]))
	doors[i].house=true
	doors[i].alive=false
	doors[i].team=doorTeam
	doors[i].health=60
	doors[i].open=false
	doors[i].timetoclose=0
	doors[i].noiseSndEmt=assign_free_sound_emitter()
	setObjectInfo(doors[i].cObj, IG3D_MASS, 0,0,0,0)
	setObjectInfo(doors[i].cObj, IG3D_SHAPE, ig3d_box)
	setObjectInfo(doors[i].cObj, IG3D_BONE_COLL, false)
	--scale the box so that its smallest dimension gets scaled to 0.8 units
	local sx,bx,sy,by,sz,bz=getObjectInfo(doors[i].cObj, IG3D_BOUNDS)
	local xsize=bx-sx
	local zsize=bz-sz
	local xmult=1
	local zmult=1
	if zsize>xsize then
		xmult=0.8/xsize
	else
		zmult=0.8/zsize
	end
	setObjectInfo(doors[i].cObj, IG3D_COLLBOX_MULTIPLICATORS, xmult,1,zmult)--brave new world!
	
	
	setObjectInfo(doors[i].cObj, IG3D_COLL, true)--brave new world!
end
--print("# doors=",#doors)


function closedoors(obj)
if obj.open == true then
setObjectInfo (obj.cObj, IG3D_ANIMATION, "STOP", 0, true)
setObjectInfo(obj.cObj, IG3D_COLL, true)
obj.open=false
obj.timetoclose=0
end
end

function handle_ZFPS_Doors()
for i = 1,#doors,1 do
local n = doors[i].objectnum
local x,y,z = doors[i].position[1], doors[i].position[2], doors[i].position[3]
local xa,ya,za = doors[i].rotation[1], doors[i].rotation[2], doors[i].rotation[3]
doors[i].timetoclose=doors[i].timetoclose+passed()
if doors[i].timetoclose > 2 then
closedoors(doors[i])

end
--if doors[i].health>0 then
--setObjectInfo(doors[i].cObj,IG3D_POSITION,x,y,z)
--setObjectInfo(doors[i].cObj,IG3D_ROTATION,xa,ya,za)
--[[
	if alldoorsopen == true and lastdoorstate == true then 
	setObjectInfo (doors[i].cObj, IG3D_ANIMATION, "OpenIn", 0, false)
	end
	--]]
	
--end
end
end


function opendoor(obj)
	if not obj.open then
	setObjectInfo(obj.cObj, IG3D_COLL, false)--open doors have coll false
	if math.random(1,2) == 1 then 
	
		setObjectInfo (obj.cObj, IG3D_ANIMATION, "OpenIn", 0, false)
		else
		setObjectInfo (obj.cObj, IG3D_ANIMATION, "OpenOut", 0, false)
		end
		
		obj.open=true
	end
end



