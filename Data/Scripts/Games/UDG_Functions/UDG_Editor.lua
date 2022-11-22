  function udg_makeDoor() 
  local x,y,z=getCameraInfo(IG3D_POSITION)
  local xa,ya,za=getCameraInfo(IG3D_ROTATION)
  table.insert(gObjectWTFs,"Building_parts/hoteldoor.wtf")
  table.insert(gObjectNames,"door"..#doors+1)
  
 table.insert(gObjectPositions,{x,y,z})
  table.insert(gObjectRotations,{xa,ya,za})
  gObjects[#gObjects+1]={}
  local i = #gObjects
 -- print(i)
  gObjects[i].cObj = make(ig3d_object,gObjectWTFs[#gObjectWTFs])
  table.insert(doors,gObjects[i])
  	setObjectInfo(gObjects[i].cObj, IG3D_NAME, gObjectNames[i])
	setObjectInfo(gObjects[i].cObj, IG3D_POSITION, {x,y,z})
	setObjectInfo(gObjects[i].cObj, IG3D_ROTATION, {xa,ya,za})
	setObjectInfo(gObjects[i].cObj, IG3D_SIZE, 100,100,100)
	setObjectInfo(gObjects[i].cObj, IG3D_COLL, true)
	setObjectInfo(gObjects[i].cObj, IG3D_HUD, false)
  end 
 textMarkerPositions={}
 

  function udg_makeTextMarker()
  cx,cy,cz=getCameraInfo(IG3D_POSITION)
  table.insert(textMarkerPositions,{cx,cy,cz})
  end
  
  function udg_writeTextMarkers()
  local s = ""
  local tmp=textMarkerPositions
  for i = 1,#tmp,1 do
 	s=s.. "table.insert[textMarkerPositions,{"..tmp[i][2]..","..tmp[i][2]..","..tmp[i][3].."})\n"
  end
  f=io.open(gameroot..ig3d_GetLevelName__s().."textMarkers.lua")
  if f ~= nil then
  f:write("textMarkerPositions={}\n"..s.."\n")
  io.close(f)
  end
  
  end

function udg_makeScenery()
end

function udg_makeWoman()
end

function udg_makeMan()
end

function udg_makeGun()
end



function udg_editor_keys()
--char,code,name=input(true)
--if key(311,"-") or key(462,"-") then
  if key("1","n") then udg_makeDoor()  
  elseif key("2","n") then udg_makeScenery() 
  elseif key("3","n") then udg_makeWoman()
  elseif key("4","n") then udg_makeMan() 
  elseif key("5","n") then udg_makeGun() 
  elseif key("h","n") then udg_makeTextMarker()  
  elseif key("j","n") then udg_writeTextMarkers()  
  end
--end
end

