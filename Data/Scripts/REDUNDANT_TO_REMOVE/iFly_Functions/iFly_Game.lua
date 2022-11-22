-- ifly_game.lua 

------ game ------

function airforce()

char, code, name=input(false)
if name=="Escape" then
gTimedLevel="Data/Levels/iFly/iFly_Title"
gTimedLevelLoad=true
gTimedLevelLoadTime=time()
end




setSceneInfo(IG3D_MOUSE_VIEW, true, 1.0)
setSceneInfo(IG3D_FULLSCREEN, true)
updateFromAllVisualObjects()
updateFromVisualCamera()


--engine sound
setSound_emitterInfo(engineSnd, IG3D_POSITION, camera.x, camera.y, camera.z)
setSound_emitterInfo(gunSnd, IG3D_POSITION, camera.x, camera.y, camera.z)

--handle enemy AI
handle_enemies()

--handle friendly AI
handle_friends()


if firstFrame== true then
firstFrame=false
setSound_emitterInfo(engineSnd, IG3D_LOOP, true)
setSound_emitterInfo(engineSnd, IG3D_START)
gStartTime=time()
return
end


if options[gShadows]== "YES" then
setObjectInfo(water.cObj, IG3D_RECEIVE_SHADOW, true)
setObjectInfo(mother.cObj, IG3D_RECEIVE_SHADOW, true)
setObjectInfo(ship.cObj, IG3D_CAST_SHADOW, true, "Vehicles_air/avatarp1shadow.wtf")
setSceneInfo(IG3D_RECEIVE_SHADOW, true)
end

if ship.active==true then



handle_powerups()

x,y,z=getObjectInfo(ship.cObj, IG3D_VELOCITY)
setSound_emitterInfo(engineSnd, IG3D_PITCH, 75.0+vecLength(x,y,z))

--is ship dying?
if ship.life<= 0 then
ship.active=false
setObjectInfo(ship.cObj, IG3D_FORCE, 0,0,0)
if ship.watercoll == true then
setParticle_emitterInfo(splash, IG3D_POSITION, getObjectInfo(ship.cObj, IG3D_POSITION))
setParticle_emitterInfo(splash, IG3D_START)
else
setParticle_emitterInfo(shrabnel, IG3D_BONE_TRAVERSAL, true, 0)
setParticle_emitterInfo(shrabnel, IG3D_POSITION, getObjectInfo(ship.cObj, IG3D_POSITION))
setParticle_emitterInfo(shrabnel, IG3D_ROTATION, getObjectInfo(ship.cObj, IG3D_ROTATION))
setParticle_emitterInfo(shrabnel, IG3D_VELOCITY, getObjectInfo(ship.cObj, IG3D_VELOCITY))
setParticle_emitterInfo(shrabnel, IG3D_FORCE, 0,-6,0)
setParticle_emitterInfo(shrabnel, IG3D_TORQUE, 0,0,-70)
setParticle_emitterInfo(bigFire, IG3D_POSITION, getObjectInfo(ship.cObj, IG3D_POSITION))
setParticle_emitterInfo(bigFire, IG3D_VELOCITY, getObjectInfo(ship.cObj, IG3D_VELOCITY))
setParticle_emitterInfo(bigFire, IG3D_START)
setParticle_emitterInfo(shrabnel, IG3D_START)
end

x,y,z=getObjectInfo(ship.cObj, IG3D_POSITION)
setObjectInfo(ship.cObj, IG3D_POSITION, x,y-10000,z)--move ship out of view
setSound_emitterInfo(engineSnd, IG3D_STOP)
setSound_emitterInfo(engineSnd, IG3D_SAMPLE, "Data/Sounds/exp.ogg")
setSound_emitterInfo(engineSnd, IG3D_PITCH, 100)
setSound_emitterInfo(engineSnd, IG3D_START, true)
setSound_emitterInfo(gunSnd, IG3D_LOOP, false)
setSound_emitterInfo(engineSnd, IG3D_LOOP, false)


setParticle_emitterInfo(gun, IG3D_STOP)
gTimedLevel="Data/Levels/iFly"
gTimedLevelLoad=true
gTimedLevelLoadTime=time()+4.0
return
end


m=get(ig3d_material, ship.cObj, 2)--get the muzzle flash material

--handle player input etc.
if click("n") then
	setParticle_emitterInfo(gun, IG3D_START)
	setMaterialInfo(m, IG3D_COLOR, 1,1,1,muzzle)
	muzzlestart=time()+0.025
	muzzle=1
	setSound_emitterInfo(gunSnd, IG3D_LOOP, true)
	setSound_emitterInfo(gunSnd, IG3D_START)
end

if click("o") then
	setParticle_emitterInfo(gun, IG3D_STOP)
	setSound_emitterInfo(gunSnd, IG3D_LOOP, false)
	setMaterialInfo(m, IG3D_COLOR, 1,1,1,0)
end

if click("-") then
	if time()>=muzzlestart then
		muzzle=1-muzzle
		muzzlestart=time()+0.025
		setMaterialInfo(m, IG3D_COLOR, 1,1,1,muzzle)
	end
end



ship.throttle=10
if key(controls[1],"-") then
	ship.throttle=120
	--ship.throttle=ship.throttle+50*passed()	
end

if key(controls[2],"-") then
	ship.throttle=0
	--ship.throttle=ship.throttle-50*passed()	
end

--handle atom bomb
if atomtime>0 and time()>atomtime then
	--setParticle_emitterInfo(atomic2, IG3D_START)
	atomtime=-1
end
-------

--handle player strafing (available through power-up)
ship.sidethrottle=0
if ship.strafing > 0 then
if key(controls[5],"-") then
	ship.sidethrottle=gMaxThrottle
	--ship.strafing=ship.strafing-1
end
if key(controls[6],"-") then
	ship.sidethrottle=-gMaxThrottle
	--ship.strafing=ship.strafing-1
end
end

---allow rolling
ship.roll=0
ship.rolling=false
if key(controls[3],"-") then
	ship.rolling=true
	ship.roll=ship.roll-2
end
if key(controls[4],"-") then
	ship.rolling=true
	ship.roll=ship.roll+2
end



if ship.throttle<gMinThrottle then
--ship.throttle=gMinThrottle
end

if ship.throttle>gMaxThrottle then
ship.throttle=gMaxThrottle
end

if time()>gStartTime+0.5 then
ship.yaw,ship.pitch=getSceneInfo(IG3D_MOUSE_DELTA)
ship.pitch=ship.pitch*gMouseSpeed
ship.yaw=ship.yaw*gMouseSpeed
end

--all the magic is in this function here now:
apply_plane_physicsnew(ship, ship.sidethrottle, 0, ship.throttle, ship.pitch, ship.yaw, ship.roll)--30

--apply_plane_physicsnew(ship, ship.sidethrottle*0.02, 0, ship.throttle*0.02, ship.pitch, ship.yaw, ship.roll)--30


ship.dx=a31
ship.dy=a32
ship.dz=a33


--camera transformations:
position_camera()


--position the board gun
b=get(ig3d_bone, ship.cObj, "Gun")
setParticle_emitterInfo(gun, IG3D_POSITION, getBoneInfo(b, IG3D_POSITION))
--setParticle_emitterInfo(gun, IG3D_POSITION, getObjectInfo(ship.cObj, IG3D_POSITION))
setParticle_emitterInfo(gun, IG3D_ROTATION, getObjectInfo(ship.cObj, IG3D_ROTATION) )
setParticle_emitterInfo(gun, IG3D_VELOCITY, getObjectInfo(ship.cObj, IG3D_VELOCITY))


b=get(ig3d_bone, ship.cObj, "Contrail")
setParticle_emitterInfo(smoke, IG3D_POSITION, getBoneInfo(b, IG3D_POSITION))
setParticle_emitterInfo(smoke, IG3D_LIFE_TIME, math.min( (100/ship.life)*(100/ship.life) * 0.3, 3))
setParticle_emitterInfo(smoke, IG3D_SIZE, math.min( (100/ship.life) * 0.5, 1))
--setParticle_emitterInfo(smoke, IG3D_START)

else

dx=ship.x-camera.x
dy=ship.y+10000-camera.y
dz=ship.z-camera.z
--setCameraInfo(IG3D_ROTATION, dirToAngles(dx,dy,dz))

setParticle_emitterInfo(shrabnel, IG3D_TORQUE, 0,0,0)
x=vecLength(dx,dy,dz)
dx,dy,dz=normalized(dx,dy,dz)

end--controllable part


--position and rotate player afterburner and setup its transparency
setObjectInfo(ship.afterburner.cObj, IG3D_POSITION, getBoneInfo(get(ig3d_bone, ship.cObj, "Contrail"), IG3D_POSITION))
setObjectInfo(ship.afterburner.cObj, IG3D_ROTATION, getObjectInfo(ship.cObj, IG3D_ROTATION))
m=get(ig3d_material, ship.afterburner.cObj, 1)
setMaterialInfo(m, IG3D_DIFFUSE, 1,1,1, math.min(0.01* vecLength(getObjectInfo(ship.cObj, IG3D_VELOCITY)), 1.0) )
setMaterialInfo(m, IG3D_COLOR, 1,1,1, math.min(0.01* vecLength(getObjectInfo(ship.cObj, IG3D_VELOCITY)), 1.0) )

setText_boxInfo(gTextboxes[1], IG3D_TEXT, "FPS:"..getSceneInfo(IG3D_FPS).."\nTIME:"..formattedTime(math.ceil(time()-gStartTime)).."\nLIFE:"..ship.life)


if gTimedLevelLoad==true then
if time() > gTimedLevelLoadTime then
	gTimedLevelLoad=false
	setSound_emitterInfo(engineSnd, IG3D_STOP)
	game_func=nil
	loadLevel(gTimedLevel)
	return
end
end

end


function particlesAgainstMesh(psys, x,y,z)
if y<-0.1 then
setParticle_emitterInfo(lilsplash, IG3D_POSITION,x,y,z)
setParticle_emitterInfo(lilsplash, IG3D_START)
else
setParticle_emitterInfo(fire, IG3D_POSITION,x,y,z)
setParticle_emitterInfo(fire, IG3D_VELOCITY, 0,0,0)
setParticle_emitterInfo(fire, IG3D_START)
end


if psys=="abomb" then
setParticle_emitterInfo(atomic1, IG3D_POSITION, x,y,z)
setParticle_emitterInfo(atomic1, IG3D_START)
atomtime=time()+0.5
end

end

function objectsAgainstMesh(obj, bone, x,y,z)
if obj.active==true then
setParticle_emitterInfo(fire, IG3D_POSITION,x,y,z)
setParticle_emitterInfo(fire, IG3D_VELOCITY, 0,0,0)
setParticle_emitterInfo(fire, IG3D_START)

setSound_emitterInfo(hitSnd, IG3D_POSITION, x,y,z)
setSound_emitterInfo(hitSnd, IG3D_START)
obj.life=obj.life-100
if y<-0.1 then
--obj.watercoll=true
end

end
end

function objectsAgainstParticles(obj, bone, psys, x,y,z)
if obj.active==true then
setParticle_emitterInfo(fire, IG3D_POSITION, x,y,z)
setParticle_emitterInfo(fire, IG3D_VELOCITY, getObjectInfo(obj.cObj, IG3D_VELOCITY))
setParticle_emitterInfo(fire, IG3D_START)

setSound_emitterInfo(hitSnd, IG3D_POSITION, x,y,z)
setSound_emitterInfo(hitSnd, IG3D_START)

if obj==mother then
--handle mothership
if bone~= 0 then
b=get(ig3d_bone, obj.cObj, bone)
local str=getBoneInfo(b, IG3D_NAME)
if string.sub(str, 1,6) == "Turret" then
len=#str
n=string.sub(str, 7, len)+0 --the +0 makes n an integer
mother.turretlifes[n]=mother.turretlifes[n]-1
if mother.turretlifes[n]<=0 then
setBoneInfo(b, IG3D_ENABLED, false)
setBoneInfo(b, IG3D_COLL, false)
setObjectInfo(mother.cObj, IG3D_MASS, 20000,20000,20000,20000)
setParticle_emitterInfo(bigFire, IG3D_POSITION, x,y,z)
setParticle_emitterInfo(bigFire, IG3D_VELOCITY, getObjectInfo(obj.cObj, IG3D_VELOCITY))
setParticle_emitterInfo(bigFire, IG3D_START)
end
end
end
else
--handle other objects
obj.life=obj.life-1
end
end
end

function objectsAgainstObjects(obj1, bone1, obj2, bone2, x,y,z)
if obj1==mother or obj2==mother or obj1==water or obj2==mother then
setParticle_emitterInfo(fire, IG3D_POSITION, x,y,z)
setParticle_emitterInfo(fire, IG3D_VELOCITY, 0,0,0)
setParticle_emitterInfo(fire, IG3D_START)
setSound_emitterInfo(hitSnd, IG3D_POSITION, x,y,z)
setSound_emitterInfo(hitSnd, IG3D_START)
if obj1.life ~= nil then
obj1.life=obj1.life-5
end
if obj2.life ~= nil then
obj2.life=obj2.life-5
end
end
end
