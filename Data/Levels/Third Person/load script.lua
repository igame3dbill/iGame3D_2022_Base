

loadMesh("Data/Levels/Third Person/thirdpersonmesh.wtf")

player=make(ig3d_object, "Characters/Squiggy")
setObjectInfo(player, IG3D_POSITION, 0,1,0)
setObjectInfo(player, IG3D_SIZE, 40,40,40)
setObjectInfo(player, IG3D_VECTOR_CONSTRAINT, 0,1,0)
setSceneInfo(IG3D_MOUSE_VIEW, true, 1)
speed=6
jump=0
--dofile(gameroot.."Data/Fluid/console/console.cxx")

setObjectInfo(player, IG3D_GRAVITY_MULTIPLIER, 0.4)
b=get(ig3d_bone, player, "base")
--setBoneInfo(b, IG3D_ENABLED, false)
c=get(ig3d_bone, player, "None")
setObjectInfo(player, IG3D_BONE_COLL, true)
setBoneInfo(c, IG3D_COLL, true)

setSceneInfo(IG3D_RECEIVE_SHADOW, true)
setObjectInfo(player, IG3D_CAST_SHADOW, true)
setLightInfo(2, IG3D_POSITION, 20,20,20,0)



function airborne(obj)
	x1,x2,y1,y2,z1,z2=getObjectInfo(obj, IG3D_BOUNDS)
	x,y,z=getObjectInfo(obj, IG3D_POSITION)
	local ct,x3,y3,z3,o=lineCollision(x,y+y1-0.3,z, x,y,z)
	if ct==1 then return false else return true end
end


function the_game()
a11,a12,a13,a14, a21,a22,a23,a34, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(player, IG3D_ROTATION_MATRIX)

mx,my=getSceneInfo(IG3D_MOUSE_DELTA)

if focus_y==nil then
focus_y=0
else
focus_y=focus_y-my*0.01
end

dx=0
dy=0
dz=0

local ab=airborne(player)

if key("w","-") and not ab then
dx=dx+a31
dy=dy+a32
dz=dz+a33
end

if key("s","-") and not ab then
dx=dx-a31
dy=dy-a32
dz=dz-a33
end

if key("a","-") and not ab then
dx=dx+a11
dy=dy+a12
dz=dz+a13
end

if key("d","-") and not ab then
dx=dx-a11
dy=dy-a12
dz=dz-a13
end

ox,oy,oz=getObjectInfo(player, IG3D_VELOCITY)
if ab then
	ox=0
	oy=0
	oz=0
end

if key(" ","n")  and not ab and jump==0 then
jump=15
end

jump=jump-passed()*20

if jump< 0 or not key(" ","-") then jump=0 end


setObjectInfo(player, IG3D_FORCE, dx*speed-ox,dy*speed-oy+jump,dz*speed-oz)
setObjectInfo(player, IG3D_OMEGA, 0,-mx*0.3,0)

px,py,pz=getObjectInfo(player, IG3D_POSITION)
setCameraInfo(IG3D_POSITION, px-a31,1+py-a32,pz-a33)
setCameraInfo(IG3D_ROTATION, dirToAngles(a31,focus_y-1+a32,a33))

setSceneInfo(IG3D_MOUSE_VIEW, true, 1)
default_escapekey()
end



game_func=the_game