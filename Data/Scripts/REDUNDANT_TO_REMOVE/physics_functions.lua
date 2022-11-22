function heavyball(n,gravity)
setObjectInfo(gObjects[n].cObj,IG3D_GRAVITY_MULTIPLIER, gravity)
setObjectInfo(gObjects[n].cObj, IG3D_SHAPE, ig3d_sphere)
end

function randImpulse()
seedtime = math.randomseed(os.time())
  theImpulsePower = math.random(1,3)-math.random(1,3)
  return theImpulsePower
end

function ballImpulse()
for hitballs = 1,gNumObjects,1 do
seedtime = math.randomseed(os.time())
miaX,miaY,miaZ= randImpulse(),randImpulse(),randImpulse()
setObjectInfo(gObjects[hitballs].cObj, IG3D_IMPULSE, miaX, -miaY, miaZ)
end
end

function snaptoY(YHeight)
for snapobj = 1,gNumObjects,1 do

ox,oy,oz=getObjectInfo(gObjects[snapobj].cObj,IG3D_POSITION)
cx,cy,cz=getCameraInfo(IG3D_POSITION)
cx=cx+snapobj*math.random(1,3)-1.5
cz=cz-snapobj*math.random(1,3)-1.5

setObjectInfo(gObjects[snapobj].cObj,IG3D_POSITION, cx, (cy-3), cz)

ax,ay,az=getCameraInfo(IG3D_ROTATION)

setObjectInfo(gObjects[snapobj].cObj,IG3D_ROTATION, ax,ay,az)

gravity = -1.5+math.random(1,3)
weightball = heavyball(snapobj,gravity)
ballsonthemove = ballImpulse()

end
end
