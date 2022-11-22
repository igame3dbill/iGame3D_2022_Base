

function init_enemies()
for i=1,gNumEnemies,1 do
init_plane(gEnemies[i])
gEnemies[i].muzzlestart=0
gEnemies[i].muzzle=0
gEnemies[i].active=true
gEnemies[i].shooting=false
gEnemies[i].life=100
gEnemies[i].shootUpdate=0
gEnemies[i].defend=true
gEnemies[i].afterburner=gEnemyAfterburners[i]
gEnemies[i].emitter1=gEnemyParticleEmitters1[i]
gEnemies[i].emitter2=gEnemyParticleEmitters2[i]
gEnemies[i].snd=gEnemySndEmitters[i]
gEnemies[i].textbox=gEnemyTextboxes[i]
gEnemies[i].target=ship --target object
gEnemies[i].mothership=mother --mothership object
gEnemies[i].powerup=nil
gEnemies[i].primPath=get(ig3d_path, gEnemies[i].mothership.cObj, "defend"..math.random(gNumDefendPaths)) --set primary path
gEnemies[i].secPath=get(ig3d_path, gEnemies[i].target.cObj, "attack"..math.random(gNumAttackPaths)) --set secondary (attack path)
gEnemies[i].curDefendPoint=math.random(getPathInfo(gEnemies[i].primPath, IG3D_COUNT))
gEnemies[i].curAttackPoint=math.random(getPathInfo(gEnemies[i].secPath, IG3D_COUNT))

setParticle_emitterInfo(gEnemies[i].emitter1, IG3D_IGNORE_COLL, true, ig3d_particle_emitter, gEnemies[i].emitter1) --dont shoot self
setParticle_emitterInfo(gEnemies[i].emitter2, IG3D_IGNORE_COLL, true, ig3d_particle_emitter, gEnemies[i].emitter2) --dont shoot self
setParticle_emitterInfo(gEnemies[i].emitter1, IG3D_IGNORE_COLL, true, ig3d_particle_emitter, gEnemies[i].emitter2) --dont shoot self
setParticle_emitterInfo(gEnemies[i].emitter1, IG3D_BILLBOARD_Z, true)
setParticle_emitterInfo(gEnemies[i].emitter2, IG3D_BILLBOARD_Z, true)

setObjectInfo(gEnemies[i].cObj, IG3D_IGNORE_COLL, true, ig3d_particle_emitter, gEnemies[i].emitter1) --dont shoot self
setObjectInfo(gEnemies[i].cObj, IG3D_IGNORE_COLL, true, ig3d_particle_emitter, gEnemies[i].emitter2) --dont shoot self
setObjectInfo(gEnemies[i].afterburner.cObj, IG3D_COLL, false) --turret doesn't collide with anything
end
end

function enemies_in_range(obj)
	for i=1,gNumEnemies,1 do
		if distance_object_to_object(obj, gEnemies[i])<gProtectionDistance then
			return true
		end
	end
	return false
end


function friends_in_range(obj)

	if distance_object_to_object(obj, ship)<gProtectionDistance then
	return true
	end
	
	for i=1,gNumFriends,1 do
		if distance_object_to_object(obj, gFriends[i])<gProtectionDistance then
			return true
		end
	end
	return false
end


function init_friends()
local xstart=-10+gNumFriends*20.0
for i=1,gNumFriends,1 do
init_plane(gFriends[i])
gFriends[i].mothership=ship
gFriends[i].life=20
gFriends[i].active=true
gFriends[i].offset={x=xstart+(i-1)*20.0, y=-2+math.random()*4, z=50}
gFriends[i].snd=gFriendSndEmitters[i]
gFriends[i].emitter=gFriendParticleEmitters[i]
gFriends[i].shooting=false
setObjectInfo(gFriends[i].cObj, IG3D_IGNORE_COLL, true, ig3d_particle_emitter, gFriends[i].emitter)--dont shoot self
end
end



function handle_friends()
for i=1,gNumFriends,1 do
if gFriends[i].active== true then

if gFriends[i].life<=0 then
--does friendly plane die?
setSound_emitterInfo(gFriends[i].snd, IG3D_STOP)
setSound_emitterInfo(gFriends[i].snd, IG3D_POSITION, getObjectInfo(gFriends[i].cObj, IG3D_POSITION))
setSound_emitterInfo(gFriends[i].snd, IG3D_SAMPLE, "Data/Sounds/exp.ogg")
setSound_emitterInfo(gFriends[i].snd, IG3D_START, true)

if gFriends[i].watercoll == true then
setParticle_emitterInfo(splash, IG3D_POSITION, getObjectInfo(gFriends[i].cObj, IG3D_POSITION))
setParticle_emitterInfo(splash, IG3D_START)
else
setParticle_emitterInfo(friendshrabnel, IG3D_BONE_TRAVERSAL, true, 0)
setParticle_emitterInfo(friendshrabnel, IG3D_POSITION, getObjectInfo(gFriends[i].cObj, IG3D_POSITION))
setParticle_emitterInfo(friendshrabnel, IG3D_ROTATION, getObjectInfo(gFriends[i].cObj, IG3D_ROTATION))
setParticle_emitterInfo(friendshrabnel, IG3D_VELOCITY, getObjectInfo(gFriends[i].cObj, IG3D_VELOCITY))
setParticle_emitterInfo(friendshrabnel, IG3D_FORCE, 0,-6,0)
setParticle_emitterInfo(friendshrabnel, IG3D_TORQUE, 0,0,-70)
setParticle_emitterInfo(bigFire, IG3D_POSITION, getObjectInfo(gFriends[i].cObj, IG3D_POSITION))
setParticle_emitterInfo(bigFire, IG3D_VELOCITY, getObjectInfo(gFriends[i].cObj, IG3D_VELOCITY))
setParticle_emitterInfo(bigFire, IG3D_START)
setParticle_emitterInfo(friendshrabnel, IG3D_START)
end

setObjectInfo(gFriends[i].cObj, IG3D_POSITION, 0,-10000,0)
setObjectInfo(gFriends[i].cObj, IG3D_COLL, false)
gFriends[i].active=false
gFriends[i].shooting=false
setParticle_emitterInfo(gFriends[i].emitter, IG3D_STOP)
return
end

setParticle_emitterInfo(gFriends[i].emitter, IG3D_POSITION, getObjectInfo(gFriends[i].cObj, IG3D_POSITION))
setParticle_emitterInfo(gFriends[i].emitter, IG3D_ROTATION, getObjectInfo(gFriends[i].cObj, IG3D_ROTATION))
setParticle_emitterInfo(gFriends[i].emitter, IG3D_VELOCITY, getObjectInfo(gFriends[i].cObj, IG3D_VELOCITY))
if gFriends[i].shooting==false then
if enemies_in_range(gFriends[i]) then
gFriends[i].shooting=true
setParticle_emitterInfo(gFriends[i].emitter, IG3D_START)
end
end
if gFriends[i].shooting==true then
if enemies_in_range(gFriends[i]) == false then
gFriends[i].shooting=false
setParticle_emitterInfo(gFriends[i].emitter, IG3D_STOP)
end
end

--handle only active objects
if gFriends[i].mothership.active then
x,y,z=getObjectInfo(gFriends[i].mothership.cObj, IG3D_POSITION)
a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(gFriends[i].mothership.cObj, IG3D_ROTATION_MATRIX)

a21=0
a22=1
a23=0
a11,a12,a13=normalized(cross(a21,a22,a23, a31,a32,a33))
a21,a22,a23=normalized(cross(a11,a12,a13, a31,a32,a33))

x=x+a11*gFriends[i].offset.x+a21*gFriends[i].offset.y+a31*gFriends[i].offset.z
y=y+a12*gFriends[i].offset.x+a22*gFriends[i].offset.y+a32*gFriends[i].offset.z
z=z+a13*gFriends[i].offset.x+a23*gFriends[i].offset.y+a33*gFriends[i].offset.z

y=math.max(y, 50)

plane_control2(gFriends[i], x,y,z) -- control the plane in the correct direction
end
apply_plane_physicsnew(gFriends[i], 0,0, gFriends[i].throttle, gFriends[i].pitch, gFriends[i].yaw, gFriends[i].roll) -- set C object Data

end
end
end




function handle_enemies()

--make sure mothership does not turn or move in wrong direction after things collided with it
setObjectInfo(mother.cObj, IG3D_OMEGA, 0,0,0)
setObjectInfo(mother.cObj, IG3D_VELOCITY, 0,0,13)
b=get(ig3d_bone, mother.cObj, "Engine")
setParticle_emitterInfo(motherengine, IG3D_POSITION, getBoneInfo(b, IG3D_POSITION))

if gTimedLevelLoad==false then
if gNumDeadEnemies>=gNumEnemies then
mother.active=false
gTimedLevel="Data/Levels/iFly/iFly_Success"
gTimedLevelLoad=true
gTimedLevelLoadTime=time()+2.0
end
end

for i=1,gNumEnemies,1 do

--crazy positioning of the plane turret:
b=get(ig3d_bone, gEnemies[i].cObj, "Turret1")
setParticle_emitterInfo(gEnemies[i].emitter1, IG3D_POSITION, getBoneInfo(b, IG3D_POSITION))
setParticle_emitterInfo(gEnemies[i].emitter1, IG3D_ROTATION, getObjectInfo(gEnemies[i].cObj, IG3D_ROTATION))
setParticle_emitterInfo(gEnemies[i].emitter1, IG3D_VELOCITY, getObjectInfo(gEnemies[i].cObj, IG3D_VELOCITY))

b=get(ig3d_bone, gEnemies[i].cObj, "Turret2")
setParticle_emitterInfo(gEnemies[i].emitter2, IG3D_POSITION, getBoneInfo(b, IG3D_POSITION))
setParticle_emitterInfo(gEnemies[i].emitter2, IG3D_ROTATION, getObjectInfo(gEnemies[i].cObj, IG3D_ROTATION))
setParticle_emitterInfo(gEnemies[i].emitter2, IG3D_VELOCITY, getObjectInfo(gEnemies[i].cObj, IG3D_VELOCITY))
----------------------------------------



if gEnemies[i].active==true then


--position the textbox (used for crosshair triangle at the moment)
setText_boxInfo(gEnemies[i].textbox, IG3D_TEXT, "a")
--x,y,z=getSceneInfo(IG3D_WINDOW_COORDS, getBoneInfo(b, IG3D_POSITION))
x,y,z=getSceneInfo(IG3D_WINDOW_COORDS, gEnemies[i].x, gEnemies[i].y, gEnemies[i].z)
setText_boxInfo(gEnemies[i].textbox, IG3D_POSITION, x-15, y-32)
if z>1 then --ie behind camera
setText_boxInfo(gEnemies[i].textbox, IG3D_TEXT, "")
end



if friends_in_range(gEnemies[i])  then
---if there are one of our planes within the enemy range
--pick nearest target, if current target out of range
local d=distance_object_to_object(gEnemies[i], ship)
if ship.active then
gEnemies[i].target=ship
end
for j=1,gNumFriends,1 do
local d2=distance_object_to_object(gEnemies[i], gFriends[j])
if d2<d and gFriends[j].active then
d=d2
gEnemies[i].target=gFriends[j]
end
end
---
end





--does the object die?
if gEnemies[i].life<= 0 then
setText_boxInfo(gEnemies[i].textbox, IG3D_TEXT, "")
gEnemies[i].active=false
gEnemies[i].shooting=false

gNumDeadEnemies=gNumDeadEnemies+1
setSound_emitterInfo(gEnemies[i].snd, IG3D_STOP)
setSound_emitterInfo(gEnemies[i].snd, IG3D_POSITION, getObjectInfo(gEnemies[i].cObj, IG3D_POSITION))
setSound_emitterInfo(gEnemies[i].snd, IG3D_SAMPLE, "Data/Sounds/exp.ogg")
setSound_emitterInfo(gEnemies[i].snd, IG3D_START, true)
setParticle_emitterInfo(gEnemies[i].emitter1, IG3D_STOP)
setParticle_emitterInfo(gEnemies[i].emitter2, IG3D_STOP)

if gEnemies[i].watercoll == true then
setParticle_emitterInfo(splash, IG3D_POSITION, getObjectInfo(gEnemies[i].cObj, IG3D_POSITION))
setParticle_emitterInfo(splash, IG3D_START)
else
setParticle_emitterInfo(fshrabnel, IG3D_BONE_TRAVERSAL, true, 0)
setParticle_emitterInfo(fshrabnel, IG3D_POSITION, getObjectInfo(gEnemies[i].cObj, IG3D_POSITION))
setParticle_emitterInfo(fshrabnel, IG3D_ROTATION, getObjectInfo(gEnemies[i].cObj, IG3D_ROTATION))
setParticle_emitterInfo(fshrabnel, IG3D_VELOCITY, getObjectInfo(gEnemies[i].cObj, IG3D_VELOCITY))
setParticle_emitterInfo(fshrabnel, IG3D_FORCE, 0,-6,0)
setParticle_emitterInfo(fshrabnel, IG3D_TORQUE, 0,0,-70)
setParticle_emitterInfo(bigFire, IG3D_POSITION, getObjectInfo(gEnemies[i].cObj, IG3D_POSITION))
setParticle_emitterInfo(bigFire, IG3D_VELOCITY, getObjectInfo(gEnemies[i].cObj, IG3D_VELOCITY))
setParticle_emitterInfo(bigFire, IG3D_START)
setParticle_emitterInfo(fshrabnel, IG3D_START)
end


if gEnemies[i].powerup ~= nil then
setObjectInfo(gEnemies[i].powerup.cObj, IG3D_POSITION, getObjectInfo(gEnemies[i].cObj, IG3D_POSITION))
setObjectInfo(gEnemies[i].powerup.cObj, IG3D_COLL, false)
setObjectInfo(gEnemies[i].powerup.cObj, IG3D_FORCE, 0,-1,0)
setObjectInfo(gEnemies[i].powerup.cObj, IG3D_ROTATION, 0,0,0)
setObjectInfo(gEnemies[i].powerup.cObj, IG3D_TORQUE, 0,0,0)
end

setObjectInfo(gEnemies[i].cObj, IG3D_POSITION, 0,-10000,0)
setObjectInfo(gEnemies[i].cObj, IG3D_TORQUE, 0,0,0)
setObjectInfo(gEnemies[i].cObj, IG3D_FORCE, 0,-10,0)
setObjectInfo(gEnemies[i].afterburner.cObj, IG3D_POSITION, 0,-10000,0)

return
end
b=get(ig3d_bone, gEnemies[i].cObj, "Contrail")
setParticle_emitterInfo(smoke, IG3D_POSITION, getBoneInfo(b, IG3D_POSITION))
setParticle_emitterInfo(smoke, IG3D_LIFE_TIME, math.min( (100/gEnemies[i].life)*(100/gEnemies[i].life) * 0.3, 3))
setParticle_emitterInfo(smoke, IG3D_SIZE, math.min( (100/gEnemies[i].life) * 0.5, 1))
setParticle_emitterInfo(smoke, IG3D_START)



gEnemies[i].defend=true--default
if distance_object_to_object(gEnemies[i], gEnemies[i].target) < gProtectionDistance then
gEnemies[i].defend=false
end


--am I too far away from mothership?
if gEnemies[i].defend==true then
x,y,z=getPathInfo(gEnemies[i].primPath, IG3D_POSITION, gEnemies[i].curDefendPoint)
dx,dy,dz=getObjectInfo(gEnemies[i].mothership.cObj, IG3D_SIZE)
x=math.max(0.01*dx,1)*x+gEnemies[i].mothership.x
y=math.max(0.01*dy,1)*y+gEnemies[i].mothership.y
z=math.max(0.01*dz,1)*z+gEnemies[i].mothership.z
tx,ty,tz=getObjectInfo(gEnemies[i].mothership.cObj, IG3D_VELOCITY)


--pick next defend path point
if vecLength(gEnemies[i].x-x, gEnemies[i].y-y, gEnemies[i].z-z) < gReachDistance then
gEnemies[i].curDefendPoint =gEnemies[i].curDefendPoint +1
if gEnemies[i].curDefendPoint >getPathInfo(gEnemies[i].primPath, IG3D_COUNT) then
gEnemies[i].curDefendPoint =1
end
end
--
else
x,y,z=getPathInfo(gEnemies[i].secPath, IG3D_POSITION, gEnemies[i].curAttackPoint)
x=x+gEnemies[i].target.x
y=y+gEnemies[i].target.y
z=z+gEnemies[i].target.z

tx,ty,tz=getObjectInfo(gEnemies[i].target.cObj, IG3D_VELOCITY)
a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44=getObjectInfo(gEnemies[i].target.cObj, IG3D_ROTATION_MATRIX)
x=x+a31*10--+
y=y+a32*10
z=z+a33*10




--pick next attack path point
if vecLength(gEnemies[i].x-x, gEnemies[i].y-y, gEnemies[i].z-z) < gReachDistance then
gEnemies[i].curAttackPoint=gEnemies[i].curAttackPoint+1
if gEnemies[i].curAttackPoint >getPathInfo(gEnemies[i].secPath, IG3D_COUNT) then
gEnemies[i].curAttackPoint =1
end
end
--

end
-----



a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44=getObjectInfo(gEnemies[i].cObj, IG3D_ROTATION_MATRIX)
dx= x-gEnemies[i].x
dy= y-gEnemies[i].y
dz= z-gEnemies[i].z
dx,dy,dz=normalized(dx,dy,dz)


dist=distance_object_to_point(gEnemies[i], x,y,z)

t=math.min( math.max(dist, vecLength(tx,ty,tz)*1.1), 60)
setObjectInfo(gEnemies[i].cObj, IG3D_VELOCITY, a31*t, a32*t, a33*t)
tx,ty,tz=cross(a31,a32,a33, dx,dy,dz)
setObjectInfo(gEnemies[i].cObj, IG3D_OMEGA, tx*3,ty*3,tz*3)

setObjectInfo(gEnemies[i].afterburner.cObj, IG3D_POSITION, getBoneInfo(get(ig3d_bone, gEnemies[i].cObj, "Contrail"), IG3D_POSITION))
setObjectInfo(gEnemies[i].afterburner.cObj, IG3D_ROTATION, getObjectInfo(gEnemies[i].cObj, IG3D_ROTATION))--REMOVE


m=get(ig3d_material, gEnemies[i].cObj, 2)--get the muzzle flash material
if gEnemies[i].shooting == true then
if time()>=gEnemies[i].muzzlestart then
gEnemies[i].muzzle=1-gEnemies[i].muzzle
gEnemies[i].muzzlestart=time()+0.025
setMaterialInfo(m, IG3D_COLOR, 1,1,1,gEnemies[i].muzzle)
end
end


if distance_object_to_object(gEnemies[i], gEnemies[i].target) <= gProtectionDistance then


if time() >= gEnemies[i].shootUpdate then
if gEnemies[i].shooting~=true then
gEnemies[i].shooting=true
setParticle_emitterInfo(gEnemies[i].emitter1, IG3D_START)
setParticle_emitterInfo(gEnemies[i].emitter2, IG3D_START)
gEnemies[i].shootUpdate=time() + math.random()*4.0
gEnemies[i].muzzlestart=time()+0.05
gEnemies[i].muzzle=1
setMaterialInfo(m, IG3D_COLOR, 1,1,1,gEnemies[i].muzzle)
else
gEnemies[i].shooting=false
setParticle_emitterInfo(gEnemies[i].emitter1, IG3D_STOP)
setParticle_emitterInfo(gEnemies[i].emitter2, IG3D_STOP)
gEnemies[i].shootUpdate=time() + math.random()*1.0
setMaterialInfo(m, IG3D_COLOR, 1,1,1,0)
end

end
else
gEnemies[i].shooting=false
setParticle_emitterInfo(gEnemies[i].emitter1, IG3D_STOP)
setParticle_emitterInfo(gEnemies[i].emitter2, IG3D_STOP)
setMaterialInfo(m, IG3D_COLOR, 1,1,1,0)
end

end



end
end





function handle_powerups()
for i=gPowerUpsStart,gPowerUpsEnd,1 do
if distance_object_to_object(ship, gObjects[i]) < gPickupDistance then
ship.strafing=math.max(ship.strafing+10,10)
setObjectInfo(gObjects[i].cObj, IG3D_POSITION, 0,-10000,0)
end
end
end


function position_camera()
a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(ship.cObj, IG3D_ROTATION_MATRIX)


x,y,z=getCameraInfo(IG3D_POSITION)
tx=a11*x+a12*y+a13*z
ty=a21*x+a22*y+a23*z
tz=a31*x+a32*y+a33*z

--ship.x, ship.y, ship.z=getObjectInfo(ship.cObj, IG3D_POSITION)

x,y,z=getCameraInfo(IG3D_POSITION)
dx=ship.x-a31*2.5+a21 -x
dy=ship.y-a32*2.5+a22 -y
dz=ship.z-a33*2.5+a23 -z


local vx,vy,vz=getObjectInfo(ship.cObj, IG3D_VELOCITY)
local vmag=vecLength(vx, vy, vz)
vx,vy,vz=normalized(vx,vy,vz)

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
x=x+dx*longmag-lx
y=y+dy*longmag-ly
z=z+dz*longmag-lz


--lateral part
x=x +lx *latmag
y=y +ly *latmag
z=z +lz *latmag

setCameraInfo(IG3D_ROTATION, getObjectInfo(ship.cObj, IG3D_ROTATION) )
setCameraInfo(IG3D_POSITION, x,y,z)


--setLightInfo(2, IG3D_POSITION, 0,1.0,-0.5,0)
setLightInfo(2, IG3D_POSITION, ship.x-a31*50, ship.y+50 -a32*50, ship.z-a33*50, 1)
end


function formattedTime(n)
local m=math.floor(n/60)
local s=n-(m*60)
if s<10 then
s="0"..s
end
return m..":"..s
end

function make_cloud(path, emitter, x,y,z, xsize,ysize,zsize)
local px,py,pz
n=getPathInfo(path, IG3D_COUNT)
for i=1,n,1 do
px,py,pz=getPathInfo(path, IG3D_POSITION, i)
setParticle_emitterInfo(emitter, IG3D_POSITION, x+px*xsize, y+py*ysize, z+pz*zsize)
setParticle_emitterInfo(emitter, IG3D_SIZE, 7*xsize)--10*xsize
setParticle_emitterInfo(emitter, IG3D_START)
end
end
