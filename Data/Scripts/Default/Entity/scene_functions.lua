-- sky="iGame3D background color red,green,blue"
function sky(r,g,b)
setSceneInfo(IG3D_BACKGROUND_COLOR, r,g,b)
return getSceneInfo(IG3D_BACKGROUND_COLOR)
end 

-- fadeto="fade iGame3D background color to red,green,blue"
function fadeto(r,g,b)
x,y,z=getSceneInfo(IG3D_BACKGROUND_COLOR)
while math.abs(x-r) ~=0 do 
x=x+((x-r)*passed())
setSceneInfo(IG3D_BACKGROUND_COLOR, x,y,z)
render()
end
while math.abs(y-g) ~=0 do
 y=y+((y-g)*passed())
setSceneInfo(IG3D_BACKGROUND_COLOR, x,y,z)
render()
end
while math.abs(z-b) ~=0 do
 z=z+((z-b)*passed())
setSceneInfo(IG3D_BACKGROUND_COLOR, x,y,z)
render()
 end
end

function create_titles(wtf)
if wtf==nil then wtf="square" end;
setSceneInfo(IG3D_BACKGROUND_COLOR, 0,0,0)
theTitle=make(ig3d_object, "square")
setObjectInfo(a, IG3D_ROTATION, 90,0,0)
setObjectInfo(a, IG3D_POSITION, 0,0,-145)
setObjectInfo(a, IG3D_SIZE, 380,100,280)
end


RedBack,GreenBack,BlueBack,rb,gb,bb=0.05,0.05,0.05,1,0,0

function colorcyclebackground()
RedBack=RedBack+rb*.001 
GreenBack=GreenBack+gb*.001
BlueBack=BlueBack+bb*.001
if RedBack>=1  then
rb=rb*-1
gb=1
end
if GreenBack>=1 then
gb=gb*-1
bb=1
end
if BlueBack>=1 then
bb=-1
rb=1
end
setSceneInfo(IG3D_BACKGROUND_COLOR, RedBack,GreenBack,BlueBack)
end