function init_plane(obj)
obj.pitch=0
obj.yaw=0
obj.roll=0
obj.throttle=gEnemyThrottle
obj.rolling=false
obj.watercoll=false
end

function plane_control(obj, x,y,z)
--for enemy planes
a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)
m=getObjectInfo(obj.cObj, IG3D_MASS)
dx,dy,dz=normalized(x-obj.x, y-obj.y, z-obj.z)


rx=a11*dx+a12*dy+a13*dz
ry=a21*dx+a22*dy+a23*dz
rz=a31*dx+a32*dy+a33*dz

d=math.acos(dot( a31,a32,a33, dx, dy, dz ))
if rx>0 then
d=-d
end

obj.yaw=d
obj.pitch=-dot( a21, a22, a23, dx, dy, dz)
obj.roll=-dot(a11,a12,a13, 0,1,0)

if obj.defend==true then
obj.throttle=math.min(math.max(distance_object_to_point(obj, x,y,z)*2.5, gMinThrottle), gMaxThrottle)
else
--obj.throttle=math.min(math.max(distance_object_to_point(obj, x,y,z)*2.5, gMinThrottle), gMaxThrottle)
end

--obj.throttle=ship.throttle*1.2--hack

if obj.throttle==0 then
--obj.throttle=gMinThrottle
end
end


function plane_control2(obj, x,y,z)
--for friendly planes
a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)
m=getObjectInfo(obj.cObj, IG3D_MASS)
dx,dy,dz=normalized(x-obj.x, y-obj.y, z-obj.z)


obj.yaw=-math.min(dot( a11,a12,a13, dx, dy, dz ),1)*1
obj.pitch=-math.min(dot( a21, a22, a23, dx, dy, dz),1)*1
obj.roll=-dot(a11,a12,a13, 0,1,0)*4*passed()

d=distance_object_to_point(obj, x,y,z)
d=d*d*0.0005*obj.mothership.throttle
obj.throttle=math.min(math.max(d, obj.mothership.throttle), gMaxThrottle)
--obj.throttle=math.min(math.max(distance_object_to_point(obj, x,y,z)*2.5, gMinThrottle), gMaxThrottle)
end





pi=3.1415


FORCE_EQUALIZER_COEFFICIENT=0.2 --0.2
TORQUE_EQUALIZER_COEFFICIENT=0.7
MIN_TORQUE_COMPONENT=-10.0
MAX_TORQUE_COMPONENT=10.0
MIN_TORQUE_MAGNITUDE=10.0
MAX_TORQUE_MAGNITUDE=30.0--3.0
CAMERA_TIGHTNESS=0.3
TORQUE_COEFFICIENT=0.15


function apply_plane_physicsnew(obj, thrustx, thrusty, thrustz, pitch, yaw, roll)
a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)

dx,dy,dz=getObjectInfo(obj.cObj, IG3D_VELOCITY)

setObjectInfo(obj.cObj, IG3D_FORCE, a11*thrustx+a21*thrusty+a31*thrustz-dx*FORCE_EQUALIZER_COEFFICIENT, a12*thrustx+a22*thrusty+a32*thrustz-dy*FORCE_EQUALIZER_COEFFICIENT +math.min(-800*passed()+vecLength(dx,0,dz), 0), a13*thrustx+a23*thrusty+a33*thrustz-dz*FORCE_EQUALIZER_COEFFICIENT)


local dmag=vecLength(dx,dy,dz)
dmag=math.max(MIN_TORQUE_MAGNITUDE, math.min(dmag, MAX_TORQUE_MAGNITUDE)) * TORQUE_COEFFICIENT
dx,dy,dz=normalized(dx,dy,dz)
dx=dx*dmag
dy=dy*dmag
dz=dz*dmag

pitch=math.max(MIN_TORQUE_COMPONENT, math.min(MAX_TORQUE_COMPONENT, pitch))
yaw=math.max(MIN_TORQUE_COMPONENT, math.min(MAX_TORQUE_COMPONENT, yaw))
roll=math.max(MIN_TORQUE_COMPONENT, math.min(MAX_TORQUE_COMPONENT, roll))

local tpitch={}
tpitch.x=a11*dmag
tpitch.y=a12*dmag
tpitch.z=a13*dmag

local tyaw={}
tyaw.x=-a21*dmag
tyaw.y=-a22*dmag
tyaw.z=-a23*dmag

local troll={}

troll.x=a31*dmag
troll.y=a32*dmag
troll.z=a33*dmag

dx,dy,dz=getObjectInfo(obj.cObj, IG3D_OMEGA)
--setObjectInfo(obj.cObj, IG3D_TORQUE, tpitch.x*pitch + tyaw.x*yaw + troll.x*roll -dx*TORQUE_EQUALIZER_COEFFICIENT, tpitch.y*pitch + tyaw.y*yaw + troll.y*roll -dy*TORQUE_EQUALIZER_COEFFICIENT, tpitch.z*pitch + tyaw.z*yaw + troll.z*roll -dz*TORQUE_EQUALIZER_COEFFICIENT)

t=TORQUE_EQUALIZER_COEFFICIENT
if passed()>0 then
--t=1.0/passed() *0.001
--t=1
end

setObjectInfo(obj.cObj, IG3D_TORQUE, tpitch.x*pitch + tyaw.x*yaw + troll.x*roll -dx*t, tpitch.y*pitch + tyaw.y*yaw + troll.y*roll -dy*t, tpitch.z*pitch + tyaw.z*yaw + troll.z*roll -dz*t)

end
