-- setMeshTool
function setMeshTool(w)
hideAllGroups()
Translate:show()
local t = w:label() 
if t == nil then t = "Materials" end

--print(t)
gEditingMode = t
if t == "meshtoolBones" then bonesgroup:show()
elseif t == "UV" then uvmappinggroup:show()
elseif t == "Materials" then materialsgroup:show()
elseif t == "Magic" then magicgroup:show()
end

if t == "meshtool1" then ig3d_SetMeshTool_i(1)
elseif t == "meshtool2" then ig3d_SetMeshTool_i(2)
elseif t == "meshtool3" then ig3d_SetMeshTool_i(3)
elseif t == "meshtool4" then ig3d_SetMeshTool_i(4)
elseif t == "meshtool5" then ig3d_SetMeshTool_i(5)
elseif t == "meshtool6" then ig3d_SetMeshTool_i(6)
elseif t == "meshtoolpath" then ig3d_SetMeshTool_i(99)
end
end


-- December 22 2008 works!

  --loadFloors
--gFloorMesh = "Data/WTF/Floors/ponchocofloor2x2.wtf"
-- gFloorMesh = "Data/WTF/Floors/MARBLE3floor2x2.wtf"
--gEWWallMesh= "Data/Wtf/Walls/EWwall2x2ponchoco.wtf"
--gNSWallMesh= "Data/Wtf/Walls/NSwall2x2ponchoco.wtf"

gFloorMesh = "Data/WTF/Floors/snowfloor2x2.wtf"
gEWWallMesh= "Data/WTF/Walls/NSwall2x2snow.wtf"
gNSWallMesh= "Data/WTF/Walls/EWwall2x2snow.wtf"

 function loadTheFloor(f)
  theMesh = gameroot..gFloorMesh
  nTagNumber=nTagNumber+1
	TheFloor=nTagNumber
	table.insert(meshTagListTable,"THEFLOOR"..nTagNumber) 
	ig3d_CreateMesh_tag_s("THEFLOOR"..nTagNumber )
	 ig3d_SetDefaultMesh_tag_i(nTagNumber)
	ig3d_SetMesh_tagName_is(nTagNumber,TheFloor)
  if ig3d_LoadMesh_sf_b(theMesh,100) == true then
  ig3d_SelectMesh_tagVertices_ib(nTagNumber,true)
	ig3d_SetMeshPositionNoUndo_3f(0.0,0.0,0.0)
 	ig3d_ScaleSelectedMeshTo_3f((vcubewidth),(1),(vcubelength))
 	ig3d_SelectMesh_tagVertices_ib(nTagNumber,true)
 	ig3d_SetMeshPositionNoUndo_3f((-2),(0.0),(-2))
 	meshx, meshy, meshz = ig3d_GetMeshCentroid__3f()
 	ig3d_SetMode_i(savedmode)
 	else
 	TheFloor = nil
 end
 	return TheFloor
 end
 -- loadTheWalls
--Data/Wtf/Walls/EWwall2x2.wtf
 function loadTheWalls(face)
  
  nTagNumber=nTagNumber+1 
  local quadtag = string.upper(face)
	ig3d_CreateMesh_tag_s(quadtag)
	 ig3d_SetDefaultMesh_tag_i(nTagNumber)
	  ig3d_SetMesh_tagName_is(nTagNumber,quadtag)
	table.insert(meshTagListTable,quadtag) 
	 if face == "west" or face=="east" then
	theMesh=gameroot..gEWWallMesh
	WEWall = nTagNumber
	end
	if face == "north" or face == "south" then
	theMesh=gameroot..gNSWallMesh
	NSWall = nTagNumber
	end 
  if ig3d_LoadMesh_sf_b(theMesh,100) == true then
  ig3d_SelectMesh_tagVertices_ib(nTagNumber,true)
  ig3d_SetMeshPositionNoUndo_3f(0.0,0.0,0.0)

 	ig3d_SetMeshPositionNoUndo_3f((-2),(0.0),(-2))
 	meshx, meshy, meshz = ig3d_GetMeshCentroid__3f()
 	ig3d_SetMode_i(savedmode)
 	else
 	if face == "west" or face=="east" then
	WEWall = nil
	end
	
	if face == "north" or face == "south" then
	NSWall = nil
	end	
 end
 if face == "north" or face == "south" then
	return NSWall
	else return WEWall
	end
 	
 end
 
 
 
 
--mesh_drawQuad
function mesh_drawQuad(qx,qy)
  QX=(math.floor((qx+(vcubewidth/2))/vgridwidth)*vgridwidth)-1
 QY =(math.floor((qy+(vcubelength/2))/vgridlength)*vgridlength)-1
	savedmode=ig3d_GetMode__i()
	nTagNumber=nTagNumber+1
	local quadtag=tostring(qx.."_"..qy.."_quad") 
	ig3d_CreateMesh_tag_s(quadtag)
	table.insert(meshTagListTable,quadtag) 
	ig3d_SetMode_i(1) --select object
	ig3d_SetMeshTool_i(1) --Line Tool
	 ig3d_SetDefaultMesh_tag_i(nTagNumber)
	 ig3d_SetMesh_tagName_is(nTagNumber,quadtag)
	ig3d_PushMeshToUndoCache()
	drawVertex(9999,-9999,9999)
	drawLine(-9999,-9999,9999)
	drawLine(-9999,-9999,-9999)
	drawLine(9999,-9999,-9999)
	drawLine(9999,-9999,9999)
	drawLine(-9999,-9999,-9999)
 	ig3d_SetFacePos_b3f((true),(QX),(-99999),(QY))
  	 ig3d_SelectMesh_tagVertices_ib(nTagNumber,false)
	ig3d_SetMeshPositionNoUndo_3f(0.0,0.0,0.0)
 	ig3d_ScaleSelectedMeshTo_3f((vcubewidth),(1),(vcubelength))
	ig3d_SetMeshPositionNoUndo_3f((QX),(0.0),(QY))
 	meshx, meshy, meshz = ig3d_GetMeshCentroid__3f()
 	ig3d_SetMode_i(savedmode)
  end
  
  -- idrawWallZ
 function idrawWallZ(qx,qy,face)
wallstring={"north","west","east","south"}
if face == "north" or face == nil then
  QX=(math.floor((qx+(vcubewidth/2))/vgridwidth)*vgridwidth)-1
 QY =qy+(vcubelength/vgridwidth)-vcubelength
 end
 
 if face == "south"  then
  QX=(math.floor((qx+(vcubewidth/2))/vgridwidth)*vgridwidth)-1
 QY =qy+(vcubelength/vgridwidth) 
 end
 
 if face == "east" then
 QX =qx+(vcubewidth/vgridwidth)
 QY =(math.floor((qy+(vcubewidth/2))/vgridwidth)*vgridwidth)-1
 end
 
 if face == "west" then
  QX =qx+(vcubelength/vgridwidth)-vcubelength
 QY =(math.floor((qy+(vcubewidth/2))/vgridwidth)*vgridwidth)-1
 end
	savedmode=ig3d_GetMode__i()
	nTagNumber=nTagNumber+1
	quadtag=tostring(qx.."_"..qy.."_poly_"..face)
	ig3d_CreateMesh_tag_s(quadtag)
	table.insert(meshTagListTable,quadtag) 
	ig3d_SetMode_i(1) --select object
	ig3d_SetMeshTool_i(1) --Line Tool
	 ig3d_SetDefaultMesh_tag_i(nTagNumber)
	ig3d_PushMeshToUndoCache()
	
	wallstring["north"]=[[
	drawVertex(9999,9999,-9999)
	drawLine(9999,-9999,-9999)
	drawLine(-9999,-9999,-9999)
	drawLine(-9999,9999,-9999)
	drawLine(9999,9999,-9999)
	drawLine(-9999,-9999,-9999)]]
	
	wallstring["west"]=[[
	drawVertex(-9999,9999,9999)
	drawLine(-9999,-9999,9999)
	drawLine(-9999,-9999,-9999)
	drawLine(-9999,9999,-9999)
	drawLine(-9999,9999,9999)
	drawLine(-9999,-9999,-9999)]]
	
	if face == "west" or face=="east" then	
	local a =loadstring(wallstring["west"])
	a()
	end
	
	if face == "north" or face == "south" then	
	local a =loadstring(wallstring["north"])
	a()
	end
 	ig3d_SetFacePos_b3f((true),(QX),(-99999),(QY))
  	 ig3d_SelectMesh_tagVertices_ib(nTagNumber,false)
	ig3d_SetMeshPositionNoUndo_3f(0.0,0.0,0.0)
 	ig3d_ScaleSelectedMeshTo_3f((vcubewidth),(vcubeheight),(vcubelength))
	ig3d_SetMeshPositionNoUndo_3f((QX),(vcubeheight/2),(QY))
 	meshx, meshy, meshz = ig3d_GetMeshCentroid__3f()
 	ig3d_SetMode_i(savedmode)
  end

function icopyFloors(qx,qy)
	if TheFloor == nil then return end
	ig3d_SelectMesh_tagVertices_ib(TheFloor,true)
	savedmode=ig3d_GetMode__i()
	nTagNumber=nTagNumber+1
	local quadtag=tostring(qx.."_"..qy.."_floor")
	ig3d_CreateMesh_tag_s(quadtag)
	  table.insert(meshTagListTable,quadtag)       
	 ig3d_SetDefaultMesh_tag_i(nTagNumber)
	  ig3d_SetMesh_tagName_is(nTagNumber,quadtag)
	  ig3d_PushMeshToUndoCache()
          ig3d_DuplicateMesh()
          ig3d_RemoveFromMesh_tag_i(TheFloor) 
          ig3d_AddToMesh_tag_i(nTagNumber) 
QX=(math.floor((qx+(vcubewidth/2))/vgridwidth)*vgridwidth)
QY =(math.floor((qy+(vcubelength/2))/vgridlength)*vgridlength)
	ig3d_SetMeshPositionNoUndo_3f(0.0,0.0,0.0)
 	ig3d_ScaleSelectedMeshTo_3f((vcubewidth),(1),(vcubelength))
 	ig3d_SetMeshPositionNoUndo_3f((QX),(0.0),(QY)) 	
 	meshx, meshy, meshz = ig3d_GetMeshCentroid__3f()
 	ig3d_SetMode_i(savedmode)
  end 
  function icopyRoofs(qx,qy)
  if TheFloor == nil then return end
	ig3d_SelectMesh_tagVertices_ib(TheFloor,true)
	savedmode=ig3d_GetMode__i()
	nTagNumber=nTagNumber+1
	local quadtag=tostring(qx.."_"..qy.."_roof")
	ig3d_CreateMesh_tag_s(quadtag)      	
	 ig3d_SetDefaultMesh_tag_i(nTagNumber)
	 ig3d_SetMesh_tagName_is(nTagNumber,quadtag)
     ig3d_DuplicateMesh()
     ig3d_RemoveFromMesh_tag_i(TheFloor) 
     ig3d_AddToMesh_tag_i(nTagNumber) 
 	 QX=(math.floor((qx+(vcubewidth/2))/vgridwidth)*vgridwidth)
	 QY =(math.floor((qy+(vcubelength/2))/vgridlength)*vgridlength)	 
 	 ig3d_SetMeshPositionNoUndo_3f((QX),(vcubeheight),(QY))
 	 ig3d_InvertMeshFaces() 
 	 meshx, meshy, meshz = ig3d_GetMeshCentroid__3f()
 	ig3d_SetMode_i(savedmode)
 end
  function icopyWalls(qx,qy,face)
	if WEWall == nil then return end
	if NSWall == nil then return end
	 if face == nil then return end
 	if face == "west" or face=="east" then ig3d_SelectMesh_tagVertices_ib(WEWall,true) end
	if face == "north" or face == "south" then ig3d_SelectMesh_tagVertices_ib(NSWall,true) end
	savedmode=ig3d_GetMode__i()
	nTagNumber=nTagNumber+1
	local	quadtag=tostring(qx.."_"..qy.."_"..face)	
	ig3d_CreateMesh_tag_s(quadtag) 
	 ig3d_SetDefaultMesh_tag_i(nTagNumber)
	   ig3d_SetMesh_tagName_is(nTagNumber,quadtag)
	  table.insert(meshTagListTable,quadtag) 
          ig3d_DuplicateMesh()
           if face == "west" or face=="east" then
          ig3d_RemoveFromMesh_tag_i(WEWall) 
          else
            ig3d_RemoveFromMesh_tag_i(NSWall) 
          end   
          ig3d_AddToMesh_tag_i(nTagNumber) 
		ig3d_SelectMesh_tagVertices_ib(nTagNumber,true)
if face == "north"  then
  QX=(math.floor((qx+(vcubewidth/2))/vgridwidth)*vgridwidth)
 QY =qy+(vcubelength/vgridwidth)-vcubelength
 end
 if face == "south"  then
  QX=(math.floor((qx+(vcubewidth/2))/vgridwidth)*vgridwidth)
 QY =qy+(vcubelength/vgridwidth) 
  ig3d_InvertMeshFaces() 
 end
 if face == "east" then
 QX =qx+(vcubewidth/vgridwidth)
 QY =(math.floor((qy+(vcubewidth/2))/vgridwidth)*vgridwidth)
 ig3d_InvertMeshFaces() 
 end
 if face == "west" then
  QX =qx+(vcubelength/vgridwidth)-vcubelength
 QY =(math.floor((qy+(vcubewidth/2))/vgridwidth)*vgridwidth)
 end
	ig3d_SetMeshPositionNoUndo_3f(0.0,0.0,0.0)
 	if face == "north" or face=="south" then 
--ig3d_ScaleSelectedMeshTo_3f((vcubewidth),(vcubeheight),(1))
 end
ig3d_SetMeshPositionNoUndo_3f((QX),(vcubeheight/2),(QY))
 meshx, meshy, meshz = ig3d_GetMeshCentroid__3f()
 ig3d_SetMode_i(savedmode)	
  end 
  
  
  	theDropMeshTagNumber = nil
   function loadAModelTemplate(theDropMesh)
  if theDropMesh == nil then theDropMesh = gameroot..gNSWallMesh end
  if string.find(theDropMesh,"Data/WTF/") == nil then  theDropMesh = "Data/WTF/"..theDropMesh end
  if string.find(theDropMesh,gameroot) == nil then theMesh = gameroot..theDropMesh end
  nTagNumber=nTagNumber+1
	theDropMeshTagNumber=nTagNumber
	table.insert(meshTagListTable,"DropMesh"..nTagNumber) 
	ig3d_CreateMesh_tag_s("DropMesh"..nTagNumber )
	 ig3d_SetDefaultMesh_tag_i(nTagNumber)
	ig3d_SetMesh_tagName_is(nTagNumber,TheFloor)
  	if ig3d_LoadMesh_sf_b(theMesh,100) == true then
  	ig3d_SelectMesh_tagVertices_ib(nTagNumber,true)
	ig3d_SetMeshPositionNoUndo_3f(0.0,0.0,0.0)
 	ig3d_ScaleSelectedMeshTo_3f((vcubewidth),(1),(vcubelength))
 	ig3d_SelectMesh_tagVertices_ib(nTagNumber,true)
 	ig3d_SetMeshPositionNoUndo_3f((-2),(0.0),(-2))
 	meshx, meshy, meshz = ig3d_GetMeshCentroid__3f()
 	ig3d_SetMode_i(savedmode)
 	else
 	theDropMeshTagNumber = nil
 end
 	return theDropMeshTagNumber
 end
 

 function iCopyWTFXY(qx,qy,face)
 --ignore face?
 if theDropMeshTagNumber == nil then return end
	ig3d_SelectMesh_tagVertices_ib(theDropMeshTagNumber,true)
	savedmode=ig3d_GetMode__i()
	nTagNumber=nTagNumber+1
	local quadtag=tostring("x"..qx.."y"..qy..face)
	ig3d_CreateMesh_tag_s(quadtag)      
	 ig3d_SetDefaultMesh_tag_i(nTagNumber)
	 ig3d_SetMesh_tagName_is(nTagNumber,quadtag) 
     ig3d_DuplicateMesh()
    ig3d_RemoveFromMesh_tag_i(theDropMeshTagNumber) 
    ig3d_AddToMesh_tag_i(nTagNumber) 
    ig3d_SetMeshPositionNoUndo_3f(0.0,0.0,0.0)
    ig3d_ScaleSelectedMeshTo_3f((vcubewidth),(vcubeheight),(vcubelength))
 	QX=(math.floor((qx+(vcubewidth)/2)/vgridwidth)*vgridwidth)
	QY =(math.floor((qy+(vcubelength)/2)/vgridlength)*vgridlength)	 
 	ig3d_SetMeshPositionNoUndo_3f((QX),(vcubeheight/2),(QY))
 	--ig3d_InvertMeshFaces() 
 	meshx, meshy, meshz = ig3d_GetMeshCentroid__3f()
 	ig3d_SetMode_i(savedmode)
 end
   
   
   
   
   
function loadCubeWalls(face)
  nTagNumber=nTagNumber+1 
  local quadtag = string.upper(face)
	ig3d_CreateMesh_tag_s(quadtag)
	 ig3d_SetDefaultMesh_tag_i(nTagNumber)
	  ig3d_SetMesh_tagName_is(nTagNumber,quadtag)
	table.insert(meshTagListTable,quadtag) 
	 if face == "west" or face=="east" then
	theMesh=gameroot..gEWWallMesh
	WEWall = nTagNumber
	end
	if face == "north" or face == "south" then
	theMesh=gameroot..gNSWallMesh 
	NSWall = nTagNumber
	end 
  if ig3d_LoadMesh_sf_b(theMesh,100) == true then
  ig3d_SelectMesh_tagVertices_ib(nTagNumber,true)
  ig3d_SetMeshPositionNoUndo_3f(0.0,0.0,0.0)
 
 	ig3d_SetMeshPositionNoUndo_3f((-2),(0.0),(-2))
 	meshx, meshy, meshz = ig3d_GetMeshCentroid__3f()
 	ig3d_SetMode_i(savedmode)
 	else
 	
 	if face == "west" or face=="east" then
	WEWall = nil
	end
	
	if face == "north" or face == "south" then
	NSWall = nil
	end	
 end
 if face == "north" or face == "south" then
	return NSWall
	else return WEWall
	end
 	
 end
 
 
   
  function icopyCubeWalls(qx,qy,face)
	if WEWall == nil then return end
	if NSWall == nil then return end
	 if face == nil then return end
 	if face == "west" or face=="east" then ig3d_SelectMesh_tagVertices_ib(WEWall,true) end
	if face == "north" or face == "south" then ig3d_SelectMesh_tagVertices_ib(NSWall,true) end 

	savedmode=ig3d_GetMode__i()
	nTagNumber=nTagNumber+1
	local	quadtag=tostring(qx.."_"..qy.."_"..face)
	
	ig3d_CreateMesh_tag_s(quadtag) 
	 ig3d_SetDefaultMesh_tag_i(nTagNumber)
	   ig3d_SetMesh_tagName_is(nTagNumber,quadtag)
	  table.insert(meshTagListTable,quadtag) 
          ig3d_DuplicateMesh()
           if face == "west" or face=="east" then
          ig3d_RemoveFromMesh_tag_i(WEWall) 
          else
            ig3d_RemoveFromMesh_tag_i(NSWall) 
          end   
          ig3d_AddToMesh_tag_i(nTagNumber) 
		ig3d_SelectMesh_tagVertices_ib(nTagNumber,true)
		
		 ig3d_SetMeshPositionNoUndo_3f(0.0,0.0,0.0)
		if face == "south" or face == "east" then ig3d_RotateSelectedMesh_6f(0,180,0,0,0,0) end
		
if face == "north"  then
  QX=(math.floor((qx+(vcubewidth/2))/vgridwidth)*vgridwidth)
 QY =qy+(vcubelength/vgridwidth)-vcubelength
 
 end
 if face == "south"  then
  QX=(math.floor((qx+(vcubewidth/2))/vgridwidth)*vgridwidth)
 QY =qy+(vcubelength/vgridwidth) 
 -- ig3d_InvertMeshFaces() 
 end
 if face == "east" then
 QX=(math.floor((qx+(vcubewidth)/2)/vgridwidth)*vgridwidth)
 QY =(math.floor((qy+(vcubewidth/2))/vgridwidth)*vgridwidth)
--ig3d_InvertMeshFaces() 
 end
 if face == "west" then
 QX=(math.floor((qx+(vcubewidth)/2)/vgridwidth)*vgridwidth)
 QY =(math.floor((qy+(vcubewidth/2))/vgridwidth)*vgridwidth)
 end
  ig3d_ScaleSelectedMeshTo_3f((vcubewidth),(vcubeheight),(vcubelength))
	ig3d_SetMeshPositionNoUndo_3f(0.0,0.0,0.0)
 	if face == "north" or face=="south" then 
--ig3d_ScaleSelectedMeshTo_3f((vcubewidth),(vcubeheight),(1))
 end
ig3d_SetMeshPositionNoUndo_3f((QX),(vcubeheight/2),(QY))
 meshx, meshy, meshz = ig3d_GetMeshCentroid__3f()
 ig3d_SetMode_i(savedmode)
 	
  end

 
 
 Q=string.char(34)
 -----
 function convertLevelObjectsToMesh(whichLevel,whichobject)
 whichobjectonly = true
 local f=io.open(gameroot.."Data/Levels/"..whichLevel.."/load script.lua","r")
 if  f== nil then return end
 local gText=f:read("*a")
 io.close()
 local st = string.find(gText,"gObjects=")
 local en =  string.find(gText,"gObjectColls=")
 if st == nil or en == nil then return end
 local zText = string.sub(gText,st,en-1)
 local zText = string.gsub(zText,"gObject","zObject")
 initzObjects=loadstring(zText)
 initzObjects()
 local ti = "table.insert("
 local sb=""
 	for i=1,#zObjectWTFs,1 do
 	if whichobject ~= nil then
 	if  string.find(zObjectWTFs[i],whichobject) ~= nil or string.find(zObjectNames[i],whichobject) ~= nil		then 
 	whichobjectonly = true
 	else
 	whichobjectonly = false
 	end
 	end
 	
 	if string.find(gMeshExclusionList,zObjectNames[i]) == nil and whichobjectonly == true then 
 	nTagNumber=nTagNumber+1
 	local QX,QY,QZ =zObjectPositions[i][1],zObjectPositions[i][2],zObjectPositions[i][3]
	local SX,SY,SZ =zObjectSizes[i][1],zObjectSizes[i][2],zObjectSizes[i][3]
	local AX,AY,AZ = zObjectRotations[i][1],zObjectRotations[i][2],zObjectRotations[i][3]
	sb=sb..ti.."gObjectNames,"..Q..zObjectNames[i]..Q..")\n"
	sb=sb..ti.."gObjectWTFs,"..Q..zObjectWTFs[i]..Q..")\n"
	sb =sb..ti.."gObjectPositions,{"..QX..","..QY..","..QZ.."})\n"
	sb =sb..ti.."gObjectSizes,{"..SX..","..SY..","..SZ.."})\n"
	sb =sb..ti.."gObjectRotations,{"..AX..","..AY..","..AZ.."})\n"
	sb =sb..ti.."gObjectColls,true)\n"
	sb =sb..ti.."gObjectHUDs,false)\n\n"
	
	ig3d_CreateMesh_tag_s(zObjectNames[i])
	ig3d_SetDefaultMesh_tag_i(nTagNumber)
	b = ig3d_LoadMesh_sf_b(gameroot.."Data/WTF/"..zObjectWTFs[i],100)
		if b == true then 
		ig3d_AddToMesh_tag_i(nTagNumber)
		ig3d_SetMeshPositionNoUndo_3f(0.0,0.0,0.)
		ig3d_ScaleSelectedMesh_3f(SX,SY,SZ)
		ig3d_RotateSelectedMesh_6f(AX,AY,AZ,0.0,0.0,0.0)
		ig3d_SetMeshPositionNoUndo_3f(QX,QY,QZ)
		render()
		ig3d_MakeInvisible() 
		end
		end --stringcheck
	end
	ig3d_ShowAll()
	 ig3d_SaveMesh_sf_b(gameroot.."Data/Levels/"..whichLevel.."/"..whichobject.."x"..nTagNumber.."_WTF2Mesh.wtf",100)
	 
	 local f = io.open(gameroot.."Data/Levels/"..whichLevel.."/"..whichobject.."_ExtractedtoMesh.lua","w")
	 if f ~= nil then 
	f:write(sb)
	io.close(f)
	end
	  
 end
 
 function convertMeshObjectsTableToMesh(whichLevel)
if whichLevel==nil then whichLevel = item(-1,ig3d_GetLevelName__s(),"/") end
--nTagNumber=nTagNumber+1 	
	--ig3d_CreateMesh_tag_s("zero")
	--ig3d_SetDefaultMesh_tag_i(nTagNumber)
	--drawVertex(0,1,1) 
	-- ig3d_AddToMesh_tag_i(nTagNumber)
	-- zeropointtagnumber = nTagNumber
for i=1,#gMeshObjectWTFs,1 do
 	if string.find(gMeshExclusionList,gMeshObjectNames[i]) == nil then 
 	nTagNumber=nTagNumber+1 	
	ig3d_CreateMesh_tag_s(gMeshObjectNames[i])
	ig3d_SetDefaultMesh_tag_i(nTagNumber)
	b = ig3d_LoadMesh_sf_b(gameroot.."Data/WTF/"..gMeshObjectWTFs[i],100)
		if b == true then 
		ig3d_AddToMesh_tag_i(nTagNumber)
		ig3d_SetMeshPositionNoUndo_3f(0.0,0.0,0.)
		ig3d_ScaleSelectedMesh_3f(gMeshObjectSizes[i][1],gMeshObjectSizes[i][2],gMeshObjectSizes[i][3])
		ig3d_RotateSelectedMesh_6f(gMeshObjectRotations[i][1],gMeshObjectRotations[i][2],gMeshObjectRotations[i][3],0.0,0.0,0.0)
		ig3d_SetMeshPositionNoUndo_3f(gMeshObjectPositions[i][1],gMeshObjectPositions[i][2],gMeshObjectPositions[i][3])
		ig3d_SelectWholeMesh () 
ig3d_InvertMeshSelection() 
	render()
		end
		end --stringcheck
	end
	ig3d_ShowAll()
	 ig3d_SaveMesh_sf_b(gameroot.."Data/Levels/"..whichLevel.."/"..whichLevel.."map_mesh.wtf",100) 
 end
 
 l2m = convertLevelObjectsToMesh
 
 
 
 
  function convertMeshObjectsTablesToMeshFile(whichfile)
--nTagNumber=nTagNumber+1 	
	--ig3d_CreateMesh_tag_s("zero")
	--ig3d_SetDefaultMesh_tag_i(nTagNumber)
	--drawVertex(0,0,0) 
	 --ig3d_AddToMesh_tag_i(nTagNumber)
	-- zeropointtagnumber = nTagNumber
for i=1,#gMeshObjectWTFs,1 do
 	
 	nTagNumber=nTagNumber+1 	
	ig3d_CreateMesh_tag_s(gMeshObjectNames[i])
	ig3d_SetDefaultMesh_tag_i(nTagNumber)
	local b = ig3d_LoadMesh_sf_b(gameroot.."Data/WTF/"..gMeshObjectWTFs[i],100)
		if b == true then 
		ig3d_AddToMesh_tag_i(nTagNumber)
		ig3d_SetMeshPositionNoUndo_3f(0.0,0.0,0.)
		ig3d_ScaleSelectedMesh_3f(gMeshObjectSizes[i][1],gMeshObjectSizes[i][2],gMeshObjectSizes[i][3])
		ig3d_RotateSelectedMesh_6f(gMeshObjectRotations[i][1],gMeshObjectRotations[i][2],gMeshObjectRotations[i][3],0.0,0.0,0.0)
		--print("y=",gMeshObjectPositions[i][2])
		ig3d_SetMeshPositionNoUndo_3f(gMeshObjectPositions[i][1],gMeshObjectPositions[i][2],gMeshObjectPositions[i][3])
		ig3d_SelectMesh_tagVertices_ib(nTagNumber,true)
	local	meshx, meshy, meshz = ig3d_GetMeshCentroid__3f()
	
	--if meshy ~= 0 then ig3d_SetMeshPositionNoUndo_3f(meshx,0,meshz) end
	drawVertex(meshx, meshy, meshz)
	camera_face_xyz(meshx, meshy, meshz)
	boneName=string.match(gMeshObjectNames[i],"%a%d+%a%d+")
	ig3d_MakeBoneFromVertex_2s(boneName,"None")
	ig3d_SelectMesh_tagVertices_ib(nTagNumber,true)
	ig3d_AttachVertexToBone_s (boneName) 
		ig3d_SelectWholeMesh() 
ig3d_InvertMeshSelection() 
		
		end --stringcheck
	end
	ig3d_ShowAll()
	
		--for ik=getlinecount(ig3d_GetMesh_tagsList__s()),1,-1 do
		--print(ik)
	--ig3d_SelectMesh_tagVertices_ib(ik,true)
	--render()
	--local	meshx, meshy, meshz = ig3d_GetMeshCentroid__3f()
	--if meshy ~= 0 then ig3d_SetMeshPositionNoUndo_3f(meshx,0,meshz) end
	--end
	ig3d_SelectWholeMesh() 
	ig3d_SetMeshPositionNoUndo_3f(0,0,0)
	render() 
	ig3d_CombineEqualMeshMaterials() 
	meshdone = ig3d_SaveMesh_sf_b(gameroot..whichfile,100) 
	return meshdone
 end