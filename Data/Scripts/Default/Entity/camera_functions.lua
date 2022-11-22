
-- lookaround & camera_WASDRFSpaceLoop
cxa=0
cya=180
cza=0
speed=15
st=time()
selectedobject={}

-- lookbutton
function lookbutton()
editingModeSwitch("lookaround")
end

function cameraKey(n)
if n==nil then
 n=cameraKeyCount
n=n+1
cameras.cx[n],cameras.cy[n],cameras.cz[n]=getCameraInfo(IG3D_POSITION)
cameras.cxa[n],cameras.cxa[n],cameras.ccza[n]=getCameraInfo(IG3D_ROTATION)
cameraKeyCount=n
else
cx,cy,cz=cameras.x[n],cameras.x[n],cameras.z[n]
cxa,cya,ccza=cameras.xa[n],cameras.xa[n],cameras.cza[n]
return cx,cy,cz,cxa,cya,ccza
end
end



function faceObj(whoToface,faceWhichObj)
if whoToface==nil then whoToface = "camera" end;
if faceWhichObj==nil then faceWhichObj=gObjects[1].cObj end;
if whoToface=="camera" then 
x,y,z=getObjectInfo(faceWhichObj, IG3D_POSITION)
x2,y2,z2=getCameraInfo(IG3D_POSITION)
dx=x-x2
dy=y-y2
dz=z-z2
setCameraInfo(IG3D_ROTATION, dirToAngles(dx,dy,dz))
else
x,y,z=getObjectInfo(faceWhichObj, IG3D_POSITION)
x2,y2,z2=getObjectInfo(whoToface, IG3D_POSITION)
dx=x-x2
dy=y-y2
dz=z-z2
setObjectInfo(whoToface, IG3D_ROTATION, dirToAngles(dx,dy,dz))
end;
end;


function camera_faceObj(objName)
if objName==nil then objName=gObjects[1].cObj end
local x,y,z=getObjectInfo(objName, IG3D_POSITION)
local x2,y2,z2=getCameraInfo(IG3D_POSITION)
local dx=x-x2
local dy=y-y2
local dz=z-z2
setCameraInfo(IG3D_ROTATION, dirToAngles(dx,dy,dz))
end

function camera_face_xyz(x,y,z)
if x == nil then x,y,z=ig3d_GetMeshCentroid__3f() end
local x2,y2,z2=getCameraInfo(IG3D_POSITION)
local dx=x-x2
local dy=y-y2
local dz=z-z2
setCameraInfo(IG3D_ROTATION, dirToAngles(dx,dy,dz))
end


function lookaround()
char,code,name=input(false)
if click("n") then
nearx,neary,nearz, farx,fary,farz= getSceneInfo(IG3D_MOUSE_LINE)
coltype,cx,cy,cz,collObj=lineCollision(nearx,neary,nearz, farx,fary,farz)
-- print(coltype,cx,cy,cz,collObj)
end

 ig3d_TellFocus_b(false) --igame3d has the keyboard
 setSceneInfo(IG3D_MOUSE_VIEW, true, 1)
a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44=getCameraInfo(IG3D_ROTATION_MATRIX)

dx,dy=getSceneInfo(IG3D_MOUSE_DELTA)

if time() > (st+1.0) then

cya=cya-dx*0.2
if cya>180 then
cya=cya-360
end
if cya<-180 then
cya=cya+360
end

cxa=cxa+dy*0.2
if cxa>180 then
cxa=cxa-360
end
if cxa<-180 then
cxa=cxa+360
end

mx=0
my=0
mz=0
if key("w","-") then
mx=mx+a31*passed()*speed
my=my+a32*passed()*speed
mz=mz+a33*passed()*speed
end

if key("s","-") then
mx=mx-a31*passed()*speed
my=my-a32*passed()*speed
mz=mz-a33*passed()*speed
end

if key("a","-") then
mx=mx+a11*passed()*speed
my=my+a12*passed()*speed
mz=mz+a13*passed()*speed
end

if key("d","-") then
mx=mx-a11*passed()*speed
my=my-a12*passed()*speed
mz=mz-a13*passed()*speed
end

if key("r","-") then
my=my+1*passed()*speed
end

if key("f","-") then
my=my-1*passed()*speed
end

cx,cy,cz=getCameraInfo(IG3D_POSITION)
setCameraInfo(IG3D_ROTATION, cxa,cya,cza)
setCameraInfo(IG3D_POSITION, cx+mx, cy+my, cz+mz)
default_escapekey()

else
firstFrame=false
end

end

-- control camera while space bar down
function camera_WASDRFSpaceLoop() 
default_escapekey()
if gMouse==true then lookaround() end;
          
      end -- camera_WASDRFSpaceLoop

function facetitles()
setSceneInfo(IG3D_MOUSE_VIEW, false)
setCameraInfo(IG3D_POSITION, 0,0,10)
setCameraInfo(IG3D_ROTATION, 0,180,0)
end
selectedobject={}
selectedobject.x=0
selectedobject.y=0
selectedobject.z=0

function camera_followObject(selectedobject)
if selectedobject == nil then return end
local a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(selectedobject, IG3D_ROTATION_MATRIX)

local x,y,z=getCameraInfo(IG3D_POSITION)
local tx=a11*x+a12*y+a13*z
local ty=a21*x+a22*y+a23*z
local tz=a31*x+a32*y+a33*z

local x,y,z=getCameraInfo(IG3D_POSITION)
local dx=selectedobject.x-a31*2.5+a21 -x
local dy=selectedobject.y-a32*2.5+a22 -y
local dz=selectedobject.z-a33*2.5+a23 -z

local vx,vy,vz=getObjectInfo(selectedobject, IG3D_VELOCITY)
local vmag=vecLength(vx, vy, vz)
local vx,vy,vz=normalized(vx,vy,vz)

local dmag=vecLength(dx,dy,dz)
--what part of the camera move direction is aligned with velocity?
local mag=dot(vx,vy,vz, dx,dy,dz)
--calculate lateral component
local lx=dx-vx*mag
local ly=dy-vy*mag
local lz=dz-vz*mag
local longmag=1
local latmag=0.15
--longitudinal part
local x=x+dx*longmag-lx
local y=y+dy*longmag-ly
local z=z+dz*longmag-lz
--lateral part
local x=x +lx *latmag
local y=y +ly *latmag
local z=z +lz *latmag
--setCameraInfo(IG3D_ROTATION, getObjectInfo(selectedobject, IG3D_ROTATION) )
setCameraInfo(IG3D_POSITION, x,y,z)
--setLightInfo(2, IG3D_POSITION, selectedobject.x-a31*50, selectedobject.y+50 -a32*50, selectedobject.z-a33*50, 1)
end  --camera_WASD


-- toggleQuadView
function toggleQuadView()
gFourView=not gFourView
ig3d_SetFourViews_b(gFourView)  
end

