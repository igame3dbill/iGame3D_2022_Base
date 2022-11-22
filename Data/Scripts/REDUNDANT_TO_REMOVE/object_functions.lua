

function makedefaultSquare()

selected_object=make(ig3d_object, "Billboards/square.wtf")
setObjectInfo(selected_object, IG3D_ROTATION, 90,0,0)
setObjectInfo(selected_object, IG3D_POSITION, 0,0,-1.)
setObjectInfo(selected_object, IG3D_SIZE, 40,20,40)
end



function RND_pushObject(selectedobject)
if selectedobject==nil then
selectedobject=gObjects[1].cObj
end
a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(selectedobject, IG3D_ROTATION_MATRIX)
dreh=0
krafthoch=0
kraftvorn=0

keyRandom = math.random(1,10)

if keyRandom==1 then
krafthoch=4
dreh=8
end

if keyRandom==2 then
dreh=-4
krafthoch=8
end

if keyRandom==4 then
kraftvorn=13
krafthoch=4
setObjectInfo(selectedobject, IG3D_OMEGA, 0)
dreh=0
end

if keyRandom==5 then
kraftvorn=4
krafthoch=13
setObjectInfo(selectedobject, IG3D_OMEGA, 0)
dreh=0
end

if keyRandom==6 then
krafthoch=-11
kraftvorn=2
setObjectInfo(selectedobject, IG3D_OMEGA, 0)
dreh=0
end
setObjectInfo(selectedobject,IG3D_FORCE, a31*kraftvorn, a32*kraftvorn+krafthoch, a33*kraftvorn)
setObjectInfo(selectedobject,IG3D_TORQUE, a21*dreh, a22*dreh, a23*dreh)
setObjectInfo(selectedobject,IG3D_VECTOR_CONSTRAINT, 0,1,0)
end




arrayObjects={}

function createBlockarray(wtfFile)if wtfFile == nil then wtfFile= "cube.wtf" endi=0--print(wtfFile)-- 1st dimension arrayfor col=1,10 doi=i+1-- 2nd dimension arrayfor row=1,10 doi=i+1gObjects[i]={} arrayObjects[i]={}gObjects[i].cObj=make(ig3d_object,wtfFile) -- create objectpObject=get(ig3d_object,gObjects[i].cObj)arrayObjects[col][row]=pObjectxcol=col*8yplane=0zrow=row*16-- set gObject position x,y,zsetObjectInfo(pObject,IG3D_POSITION,xcol,yplane,zrow)endendend


function meshifyObject(obj)
	local x,y,z=getObjectInfo(obj, IG3D_POSITION)
	local xa,ya,za=getObjectInfo(obj, IG3D_ROTATION)
	local xs,ys,zs=getObjectInfo(obj, IG3D_SIZE)
	local fileToLoad=string.sub(ig3d_GetObjectModelPath_s_s( getObjectInfo(obj, IG3D_NAME)), #gameroot+1, -1)
	
	loadMesh(fileToLoad)
	ig3d_ScaleSelectedMesh_3f(xs,ys,zs)
	ig3d_RotateSelectedMesh_6f(xa,ya,za, 0,0,0)
	ig3d_SetMeshPositionNoUndo_3f(x,y,z)
	delete(ig3d_object, obj)	
end





gFloorWTF = "Floors/snowfloor2x2.wtf"
gEWWallWTF = "Walls/EWwall2x2snow.wtf"
gNSWallWTF = "Walls/NSwall2x2snow.wtf"

 gDropMesh = nil
 function icopyModelFloors(qx,qz,face,gDropMesh)
  if gDropMesh == nil then gDropMesh = gFloorWTF end 
  if face == nil then face = "floor" end
  	local Q='"'
  	local rx,ry,rx=0,0,0
  	local QY =1
  	if face == "floor" then
	QX=(math.floor((qx+(vcubewidth/2))/vgridwidth)*vgridwidth)
	QY=0.0
	QZ =(math.floor((qz+(vcubelength/2))/vgridlength)*vgridlength)
	end
	
	
 		if face == "north"  then
 		QX=(math.floor((qx+(vcubewidth/2))/vgridwidth)*vgridwidth)
 		QZ =qz+(vcubelength/vgridwidth)-vcubelength
 		end
 
 		if face == "south"  then
 		QX=(math.floor((qx+(vcubewidth/2))/vgridwidth)*vgridwidth)
 		QZ =qz+(vcubelength/vgridwidth) 
 		ry=180
 		end
 
 		if face == "east" then
 		QX =qx+(vcubewidth/vgridwidth)
 		QZ =(math.floor((qz+(vcubewidth/2))/vgridwidth)*vgridwidth)
 		ry=180 
 		end
 
 		if face == "west" then
  		QX =qx+(vcubelength/vgridwidth)-vcubelength
 		QZ =(math.floor((qz+(vcubewidth/2))/vgridwidth)*vgridwidth)
 		end
	 table.insert(gObjectPositions,{QX,QY,QZ})
	 table.insert(gObjectRotations,{0.0,ry,0.0})
	 table.insert(gObjectColls,false)
	 table.insert(gObjectHUDs,false)
 	 table.insert(gObjectSizes,{(100),(100),(100)})
 	 table.insert(gObjectNames,"x"..QX.."z"..QZ.."F")
 	 table.insert(gObjectWTFs,gDropMesh)
 	 i=#gObjectWTFs
  	 gObjects[i]={}
  	 gObjects[i].cObj=make(ig3d_object, gObjectWTFs[i])
setObjectInfo(gObjects[i].cObj, IG3D_NAME, gObjectNames[i])
setObjectInfo(gObjects[i].cObj, IG3D_POSITION, gObjectPositions[i][1],gObjectPositions[i][2],gObjectPositions[i][3])
setObjectInfo(gObjects[i].cObj, IG3D_ROTATION, gObjectRotations[i][1],gObjectRotations[i][2],gObjectRotations[i][3])
setObjectInfo(gObjects[i].cObj, IG3D_SIZE, gObjectSizes[i][1],gObjectSizes[i][2],gObjectSizes[i][3])
setObjectInfo(gObjects[i].cObj, IG3D_COLL, gObjectColls[i])
setObjectInfo(gObjects[i].cObj, IG3D_HUD, gObjectHUDs[i])
  end
  
   function icopyModelWalls(qx,qz,face,gDropModel)
   if face == nil then face = "floor" end
  --if gDropMesh == nil then 
  if face == "east" or face == "west" then gDropModel = gEWWallWTF end
  if face == "north" or face == "south" then gDropModel = gNSWallWTF end
  if face == "floor" then gDropModel = gFloorWTF end 
	--end
  	local Q='"'
  	local rx,ry,rx=0,0,0
  	local QY =1
  	if face == "floor" or face == "floorlive" then
	QX=(math.floor((qx+(vcubewidth/2))/vgridwidth)*vgridwidth)
	QY=0.0
	QZ =(math.floor((qz+(vcubelength/2))/vgridlength)*vgridlength)
	end
 		if face == "north"  then
 		QX=(math.floor((qx+(vcubewidth/2))/vgridwidth)*vgridwidth)
 		QZ =qz+(vcubelength/vgridwidth)-vcubelength
 		end
 
 		if face == "south"  then
 		QX=(math.floor((qx+(vcubewidth/2))/vgridwidth)*vgridwidth)
 		QZ =qz+(vcubelength/vgridwidth) 
 		ry=180
 		end
 
 		if face == "east" then
 		QX =qx+(vcubewidth/vgridwidth)
 		QZ =(math.floor((qz+(vcubewidth/2))/vgridwidth)*vgridwidth)
 		ry=180 
 		end
 
 		if face == "west" then
  		QX =qx+(vcubelength/vgridwidth)-vcubelength
 		QZ =(math.floor((qz+(vcubewidth/2))/vgridwidth)*vgridwidth)
 		end
 		gDropx,gDropy,gDropz = QX,QY,QZ
	 table.insert(gObjectPositions,{QX,QY,QZ})
	 table.insert(gObjectRotations,{0.0,ry,0.0})
	 table.insert(gObjectColls,false)
	 table.insert(gObjectHUDs,false)
 	 table.insert(gObjectSizes,{(100),(100),(100)})
 	 table.insert(gObjectNames,"x"..QX.."z"..QZ.."F")
 	 table.insert(gObjectWTFs,gDropModel)
 	 i=#gObjectWTFs
  	 gObjects[i]={}
  	 gObjects[i].cObj=make(ig3d_object, gObjectWTFs[i])
setObjectInfo(gObjects[i].cObj, IG3D_NAME, gObjectNames[i])
setObjectInfo(gObjects[i].cObj, IG3D_POSITION, gObjectPositions[i][1],gObjectPositions[i][2],gObjectPositions[i][3])
setObjectInfo(gObjects[i].cObj, IG3D_ROTATION, gObjectRotations[i][1],gObjectRotations[i][2],gObjectRotations[i][3])
setObjectInfo(gObjects[i].cObj, IG3D_SIZE, gObjectSizes[i][1],gObjectSizes[i][2],gObjectSizes[i][3])
setObjectInfo(gObjects[i].cObj, IG3D_COLL, gObjectColls[i])
setObjectInfo(gObjects[i].cObj, IG3D_HUD, gObjectHUDs[i])
  end
 
 
 gMeshObjectWTFs={}
gMeshObjectNames={}
gMeshObjectPositions={}
gMeshObjectRotations={}
gMeshObjectSizes={}
 
 function iBuildMeshObjectTables(qx,qz,face,gDropModel)
   if face == nil then face = "floor" end
  --if gDropMesh == nil then 
  if face == "east" or face == "west" then gDropModel = gEWWallWTF end
  if face == "north" or face == "south" then gDropModel = gNSWallWTF end
  if face == "floor" then gDropModel = gFloorWTF end 
	--end   
  	local Q='"'
  	local rx,ry,rx=0,0,0
  	local QY =1
  	if face == "floor" or face == "floorlive" then
	QX=(math.floor((qx+(vcubewidth/2))/vgridwidth)*vgridwidth)
	QY=0.0
	QZ =(math.floor((qz+(vcubelength/2))/vgridlength)*vgridlength)
	end
 		if face == "north"  then
 		QX=(math.floor((qx+(vcubewidth/2))/vgridwidth)*vgridwidth)
 		QZ =qz+(vcubelength/vgridwidth)-vcubelength
 		end
 		if face == "south"  then
 		QX=(math.floor((qx+(vcubewidth/2))/vgridwidth)*vgridwidth)
 		QZ =qz+(vcubelength/vgridwidth) 
 		ry=180
 		end
 		if face == "east" then
 		QX =qx+(vcubewidth/vgridwidth)
 		QZ =(math.floor((qz+(vcubewidth/2))/vgridwidth)*vgridwidth)
 		ry=180 
 		end
 		if face == "west" then
  		QX =qx+(vcubelength/vgridwidth)-vcubelength
 		QZ =(math.floor((qz+(vcubewidth/2))/vgridwidth)*vgridwidth)
 		end
 		gDropx,gDropy,gDropz = QX,QY,QZ
	 table.insert(gMeshObjectPositions,{QX,QY,QZ})
	 table.insert(gMeshObjectRotations,{0.0,ry,0.0})
 	 table.insert(gMeshObjectSizes,{(100),(100),(100)})
 	 table.insert(gMeshObjectNames,"x"..QX.."z"..QZ.."F")
 	 table.insert(gMeshObjectWTFs,gDropModel)
  end
  
  
   gEmitterObjectWTFs={}
gEmitterObjectNames={}
gEmitterObjectPositions={}
gEmitterObjectRotations={}
gEmitterObjectSizes={}




Q ='"'

gWTFEMTHeader=[[texture=
amount=1
emission rate=0.000000
life=-1.000000
fade=0.000000
area=0.000000
size=1.000000
size variance=0.000000
size max=0.000000
speed=1.000000
lux=true
destroy=false
weight=1.700000
move=false
explode=false
scale=false
rotate=false
anim=false
plane=false
num_textures=1,1
model=]]


  function write_emitters_from_objects(whichLevel,whichobject)
  -- whichobject = the short name of the objects sought ie, scenery
  local nEmitterNumber=0
  local sout = ""
 whichobjectonly = true
 gText,st,en = read_load_script_text(whichLevel,"gObjects=","gObjectColls=")
 if st == nil or en == nil then return end
 local zText = string.sub(gText,st,en-1)
 local zText = string.gsub(zText,"gObject","zObject")
 initzObjects=loadstring(zText)
 initzObjects()
 	for i=1,#zObjectWTFs,1 do 	
 		if whichobject ~= nil then
 			if  string.find(zObjectNames[i],whichobject) ~= nil	or string.find(zObjectWTFs[i],whichobject) ~= nil then 
 			whichobjectonly = true
 			else
 			whichobjectonly = false
 			end
 		end
 	if whichobjectonly == true then 
 	EmitterFolderList = ListFolder(gameroot.."Data/Emitters/")
		WTFPathtofile =  string.sub(zObjectWTFs[i], 1 , string.find(zObjectWTFs[i],"/"))
		print("WTFPathtofile=",WTFPathtofile)
		
		emtFolderPath=gameroot.."Data/Emitters/"..WTFPathtofile
		print("emtFolderPath=",emtFolderPath)
		
		if string.find(EmitterFolderList,WTFPathtofile) == nil then ig3d_CreateDirectory_s(emtFolderPath) end
			
		EMTfromWTFfile= string.sub(zObjectWTFs[i],string.len(WTFPathtofile)+1,-5)..".emt"
		print("EMTfromWTFfile=",EMTfromWTFfile)
		
 		emtName = Q..zObjectNames[i].."emt"..Q
 		emtSource =Q..  "Data/Emitters/"..WTFPathtofile..EMTfromWTFfile..Q
 		
 		sout = sout .."table.insert(gParticleNamesAndEMTs,{"..emtName..","..emtSource.."})\n"
		sout = sout .."gParticleEmitters[#gParticleEmitters+1]=make(ig3d_particle_emitter,".. emtName..","..emtSource..")\n"
		sout = sout .."setParticle_emitterInfo(gParticleEmitters[#gParticleEmitters], IG3D_POSITION,".. zObjectPositions[i][1]..","..zObjectPositions[i][2]..","..zObjectPositions[i][3]..")\n"
		sout = sout .."setParticle_emitterInfo(gParticleEmitters[#gParticleEmitters] , IG3D_ROTATION,".. zObjectRotations[i][1]..","..zObjectRotations[i][2]..","..zObjectRotations[i][3]..")\n\n"
		
			
		   print(emtFolderPath..EMTfromWTFfile)		
			local f=io.open(emtFolderPath..EMTfromWTFfile,"w")
			if f ~= nil then
			emitterTextOut = gWTFEMTHeader..zObjectWTFs[i]
			f:write(emitterTextOut)
			io.close(f)
			end
		end --stringcheck
	end
	if string.find(whichLevel,"/") ~= nil then
	EmtLuaFileName= string.sub(whichLevel, string.find(whichLevel,"%/")+1,-1).."_WTF2EMT.lua" 
	else
	EmtLuaFileName = whichLevel.."_WTF2EMT.lua"
	end
	--print("dofile("..Q..gameroot.."Data/Levels/"..whichLevel.."/"..EmtLuaFileName..Q..")\n")
	local f=io.open(gameroot.."Data/Levels/"..whichLevel.."/"..EmtLuaFileName,"w")
	if f ~= nil then
	f:write(sout)
	io.close(f)
	end
  end


 



 
