--function make_window()
gameroot=getSceneInfo(IG3D_ROOT)
print(gameroot)
if game_func==nil then dofile(gameroot.."/Data/game script.lua") end

dofile(gameroot.."Data/Levels/default/default_Globals.lua")
counter = 0
nTagNumber=0
qx=0;qy=0;cubeqx=0;cubeqy=0;
qflip = false
meshx, meshy, meshz =0,0,0
quads={}
cubes={}

vgridwidth=10
vgridlength=10
vcubewidth=10
vcubelength=10
vcubeheight=10

gridSize,cubeSize=10,10
gridSize,quadSize=10,10

widthHalf=math.floor(vgridwidth/2)
lengthHalf=math.floor(vgridlength/2)

cubeWidthHalf=math.floor(vcubewidth/2)
cubeLengthHalf=math.floor(vcubelength/2)
cubeHeightHalf=math.floor(vcubeheight/2)

quadHalf=cubeWidthHalf
gridSize=vgridwidth
cubeSize=vcubewidth
quadSize=cubeSize
qs=quadSize
drawquads=true
drawcubes=false

function quadactivate()
drawquads=true
drawcubes=false
end

function cubeactivate()
drawquads=false
drawcubes=true
end
--insideRECT
-- from /Data/Scripts/Functions/math_functions.lua
function insideRECT(locx,locy,Left,Top,Right,Bottom)
result=0
if locx >= Left and locx <= Right then result=result+1  end
if locy >= Top and locy <= Bottom then result=result+1  end
if result==2 then 
return true
end
end
function gridMouseXY()
  flmousex=Fl:event_x()
  flmousey=Fl:event_y()
  MouseX=(math.floor((flmousex+(vcubewidth/2))/vgridwidth)*vgridwidth)-1
 MouseY =(math.floor((flmousey+(vcubelength/2))/vgridlength)*vgridlength)-1
return MouseX,MouseY
end
function drawrectF(cubeqx,cubeqy)
color_cycle(1,255,5)
l,t =cubeqx-widthHalf,cubeqy-lengthHalf
fltk.fl_rectf(l,t,vgridwidth,vgridlength)
end
---mouseDown_quads
function mouseDown_quads()
quadqx,quadqy=gridMouseXY() 

if  Fl:event()==5 or Fl:event()==1 then 
doQuad=true 
-- do not draw in the same place twice
for i=0,table.getn(quads),1 do
if  (quadqx..","..quadqy) == quads[i]  then doQuad=false end
end
end
if flmousex<(10+widthHalf) or flmousex>(330-vcubewidth) then doQuad=false end
if flmousey<(80+lengthHalf) or flmousey>(400-vcubelength) then doQuad=false end
qx,qy=quadqx,quadqy
if doQuad==true then drawQuad(quadqx,quadqy) end
end   ---mouseDown_quads*
---mouseDown_cubes

function mouseDown_cubes()
cubeqx,cubeqy=gridMouseXY()
-- FL_DRAG =flevent 5 FL_PUSH =flevent 1,
if  Fl:event()==5 or Fl:event()==1 then 
docube=true 
-- donot draw in the same place twice
for i=0,table.getn(cubes),1 do
if  (cubeqx..","..cubeqy) == cubes[i]  then docube=false end
end
end
if flmousex<(10+widthHalf) or flmousex>(330-vcubewidth) then docube=false end
if flmousey<(80+lengthHalf) or flmousey>(400-vcubelength) then docube=false end

if docube==true then drawcube(cubeqx,cubeqy) end
end   ---mouseDown_cubes*
function idrawcube(cubeqx,cubeqy)
nTagNumber=nTagNumber+1
savedmode=ig3d_GetMode__i()
cubetag="cube_"..nTagNumber 
ig3d_CreateMesh_tag_s(cubetag)
ig3d_SetMode_i(1) --select object
ig3d_SetMeshTool_i(1) --Line Tool
 ig3d_SetDefaultMesh_tag_i(nTagNumber)
ig3d_PushMeshToUndoCache()
drawVertex(9999,-9999,9999)
drawLine(-9999,-9999,9999)
drawLine(-9999,-9999,-9999)
drawLine(9999,-9999,-9999)
drawLine(9999,-9999,9999)
drawLine(-9999,-9999,-9999)
 ig3d_SetFacePos_b3f((true),(cubeqx),(-99999),(cubeqy))
   ig3d_SelectMesh_tagVertices_ib(nTagNumber,false)
ig3d_SetMeshPositionNoUndo_3f(0.0,0.0,0.0)
 ig3d_ScaleSelectedMeshTo_3f((vcubewidth),(1),(vcubelength))
ig3d_SetMeshPositionNoUndo_3f((cubeqx-160),(0.0),(cubeqy-160))
 meshx, meshy, meshz = ig3d_GetMeshCentroid__3f()
 ig3d_ExtrudeSelectedMesh_fb(vcubeheight, true)
 ig3d_SetMode_i(savedmode)
  end



function drawcube(cubeqx,cubeqy)

l,t,r,b=cubeqx-widthHalf,cubeqy-lengthHalf,cubeqx+cubeWidthHalf,cubeqy+cubeLengthHalf
color_cycle(1,255,5)
      fltk.fl_rectf(l,t,vcubewidth,vcubelength)
   cubeCount=table.getn(cubes)+1
   cubes[cubeCount]=(cubeqx..","..cubeqy)
  idrawcube(cubeqx,cubeqy);
 
   docube=false    
end ---drawcube


function color_cycle(baseColor,counterLimit,counterStep)
      counter=counter+counterStep
     if counter > counterLimit then counter=counterStep end
      fltk.fl_color(baseColor+counter)   
end ---color_cycle
function idrawquad(qx,qy)
savedmode=ig3d_GetMode__i()
nTagNumber=nTagNumber+1
quadtag="quad_"..nTagNumber 
ig3d_CreateMesh_tag_s(quadtag)
ig3d_SetMode_i(1) --select object
ig3d_SetMeshTool_i(1) --Line Tool
 ig3d_SetDefaultMesh_tag_i(nTagNumber)
ig3d_PushMeshToUndoCache()
drawVertex(9999,-9999,9999)
drawLine(-9999,-9999,9999)
drawLine(-9999,-9999,-9999)
drawLine(9999,-9999,-9999)
drawLine(9999,-9999,9999)
drawLine(-9999,-9999,-9999)
 ig3d_SetFacePos_b3f((true),(qx),(-99999),(qy))
   ig3d_SelectMesh_tagVertices_ib(nTagNumber,false)
ig3d_SetMeshPositionNoUndo_3f(0.0,0.0,0.0)
 ig3d_ScaleSelectedMeshTo_3f((vcubewidth),(1),(vcubelength))
ig3d_SetMeshPositionNoUndo_3f((qx-160),(0.0),(qy-160))
 meshx, meshy, meshz = ig3d_GetMeshCentroid__3f()
 ig3d_SetMode_i(savedmode)
  end

function drawQuad(qx,qy)
l,t,r,b=qx-widthHalf,qy-lengthHalf,qx+widthHalf,qy+lengthHalf
color_cycle(1,255,5)
-- --draw diagonal vector dependant on mouse movements      
   if qflip==false then 
     fltk.fl_loop(l,t,r,t,r,b)
      color_cycle(1,255,5)
      fltk.fl_loop(l,b,l,t,r,b)     
   else 
      fltk.fl_loop(l,t,l,b,r,t)
      color_cycle(1,255,5)
      fltk.fl_loop(l,b,r,b,r,t)
   end
   qflip=not qflip
   quadCount=table.getn(quads)+1
   quads[quadCount]=(qx..","..qy)
  idrawquad(qx,qy);
   doQuad=false    
end ---drawQuad


function color_cycle(baseColor,counterLimit,counterStep)
      counter=counter+counterStep
     if counter > counterLimit then counter=counterStep end
      fltk.fl_color(baseColor+counter)   
end ---color_cycle
--input update_values


function input_value_updates()
vgridwidth=gridwidth:value()
vgridlength=gridlength:value()
vcubewidth=cubewidth:value()
vcubelength=cubelength:value()
vcubeheight=cubeheight:value()

widthHalf=math.floor(vgridwidth/2)
lengthHalf=math.floor(vgridlength/2)

cubeWidthHalf=math.floor(vcubewidth/2)
cubeLengthHalf=math.floor(vcubelength/2)
cubeHeightHalf=math.floor(vcubeheight/2)

quadHalf=cubeWidthHalf
gridSize=vgridwidth
cubeSize=vcubewidth
quadSize=cubeSize
end
function cubemap_callback()
  
  	if drawingrect then 
  	
	local Left,Top = drawingrect:x(), drawingrect:y()
	local Right,Bottom = drawingrect:w()+Left, drawingrect:h()+Top
 	flmousex = Fl:event_x()
  	flmousey = Fl:event_y()
  
		if insideRECT(flmousex,flmousey,Left,Top,Right,Bottom) == true then
cubemap:make_current();
 			input_value_updates()
 
 			if drawquads==true then
 				mouseDown_quads();
			else
				mouseDown_cubes();
			end


		end
	end
end
-- cubemapclose
function cubemapclose()
--if oldGame then game_func=oldGame end
--if oldEdit then edit_func=oldEdit end
--if UIMainTools then  UIMainTools:hide() end
dofile(gameroot.."Data/Levels/default/default_Globals.lua")
cubemap:hide()
cubemap = nil


--if UIMainTools then 
--UIMainTools:save_levelMesh()
--end

end
do cubemap= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "cubemap")
cubemap:label(gLabelTable[#gLabelTable])
cubemap:callback(cubemapClose)
cubemap:resize(85,393,338,422)
cubemap:color(7)
cubemap:when(1)
Fl_Group:current():resizable(cubemap)
cubemap:size_range(339,370,339,370)
--cubemap:show()
do quadon= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "quad")
quadon:label(gLabelTable[#gLabelTable])
quadon:callback(quadactivate)
quadon:resize(10,10,70,20)
quadon:labelsize(11)
end

do cubeon= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "cube")
cubeon:label(gLabelTable[#gLabelTable])
cubeon:callback(cubeactivate)
cubeon:resize(85,10,70,20)
cubeon:labelsize(11)
end

do drawingrect= fltk:Fl_Box(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "+")
drawingrect:label(gLabelTable[#gLabelTable])
drawingrect:callback(cubemap_callback)
drawingrect:resize(10,81,320,320)
drawingrect:box(fltk.FL_BORDER_BOX)
drawingrect:labelsize(11)
drawingrect:when(1)
Fl_Group:current():resizable(drawingrect)
end

do gridgroup= fltk:Fl_Group(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Grid")
gridgroup:label(gLabelTable[#gLabelTable])
gridgroup:resize(185,13,25,37)
gridgroup:labelsize(9)
do gridwidth= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "W:")
gridwidth:label(gLabelTable[#gLabelTable])
gridwidth:callback(input_value_updates)
gridwidth:resize(185,13,25,17)
gridwidth:labelsize(10)
gridwidth:textsize(11)
end

do gridlength= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "L:")
gridlength:label(gLabelTable[#gLabelTable])
gridlength:callback(input_value_updates)
gridlength:resize(185,33,25,17)
gridlength:labelsize(10)
gridlength:textsize(11)
end
Fl_Group:current(Fl_Group:current():parent())
end

do objectdimensionsgroup= fltk:Fl_Group(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Object")
objectdimensionsgroup:label(gLabelTable[#gLabelTable])
objectdimensionsgroup:resize(245,13,25,57)
objectdimensionsgroup:labelsize(9)
do cubewidth= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "W:")
cubewidth:label(gLabelTable[#gLabelTable])
cubewidth:callback(input_value_updates)
cubewidth:resize(245,13,25,17)
cubewidth:labelsize(10)
cubewidth:textsize(11)
end

do cubelength= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "L::")
cubelength:label(gLabelTable[#gLabelTable])
cubelength:callback(input_value_updates)
cubelength:resize(245,53,25,17)
cubelength:labelsize(10)
cubelength:textsize(11)
end

do cubeheight= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "H:")
cubeheight:label(gLabelTable[#gLabelTable])
cubeheight:callback(input_value_updates)
cubeheight:resize(245,33,25,17)
cubeheight:labelsize(10)
cubeheight:textsize(11)
end
Fl_Group:current(Fl_Group:current():parent())
end
end
cubemap:show()

gridwidth:value(10)
gridlength:value(10)
cubewidth:value(10)
cubelength:value(10)
cubeheight:value(10)
drawingrect:when(11)
cubemap:show()----FLTK WINDOW
cubemap:color(55)
cubemap:labelsize(9)
  
  


oldGame=game_func
oldEdit=edit_func

setCameraInfo(IG3D_POSITION, 0.0,50.0,90.0)
setCameraInfo(IG3D_ROTATION,57.0,-180.0,0.0)


--function clickCube()
--if cubemap then 
--cubemap_callback() 
--if oldGame~=nil then oldGame() end
--if oldEdit~=nil then oldEdit() end
--end 
--end
--game_func=clickCube
--edit_func=clickCube
while cubemap~= nil do 
Fl:check();

cubemap_callback()
end
--end
Fl:run()
