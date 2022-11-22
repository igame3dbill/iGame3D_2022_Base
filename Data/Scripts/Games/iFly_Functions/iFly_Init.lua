-- iFly_Init.lua
math.randomseed(os.time())
--includings
dofile(getSceneInfo(IG3D_ROOT).."Data/Scripts/Games/iFly_Functions/iFly_math.lua") --contains some common math
dofile(getSceneInfo(IG3D_ROOT).."Data/Scripts/Games/iFly_Functions/iFly_plane.lua")

--setup controls:
controls={}
i=1
for line in io.lines(getSceneInfo(IG3D_ROOT).."Data/Levels/iFly/iFly_controls.txt","r") do
if i % 2 == 1 then
controls[(i-1)/2 +1]=line
end
i=i+1
end
--setup options:
options={}
i=1
for line in io.lines(getSceneInfo(IG3D_ROOT).."Data/Levels/iFly/iFly_options.txt","r") do
if i % 2 == 1 then
options[(i-1)/2 +1]=line
end
i=i+1
end

gShadows=1
gClouds=2
gMouseSpeed=controls[7]*0.007

-- Global variables and constants
gPowerUpsStart=3
gPowerUpsEnd=3
gPickupDistance=2
gReachDistance=10	--052206: distance to the path point to make the point considered "reached"
gProtectionDistance=250--350
gMaxThrottle=60
gMinThrottle=10
gEnemyThrottle=20
gTimeToImpact=20
gNumDeadEnemies=0
gCamVector={x=0,y=1.3,z=-4}
gCamRot={x=10,y=0,z=0}
gNumAttackPaths=3
gNumDefendPaths=3
gTimedLevelLoad=false
gTimedLevelLoadTime=0
firstFrame=true


dofile(gameroot.."Data/Scripts/Games/iFly_Functions/iFly_AI.lua")

------ init ------
cloudpath=get(ig3d_path, -1, "p1")
muzzle=0
muzzlestart=0
--ship.afterburner=gObjects[7]
ship.dx=0
ship.dy=0
ship.dz=0
ship.active=true
ship.life=100
ship.rolling=false --if true, rolling is performed
--the 4 power-ups are: strafing, repair, stealth, wing gun
ship.strafing=10
ship.stealth=false
ship.winggun=false
ship.sidethrottle=0
--hitSnd=gSoundEmitters[1]
--engineSnd=gSoundEmitters[2]
--gunSnd=gSoundEmitters[21]
setObjectInfo(mother.cObj, IG3D_BONE_COLL, true)
setObjectInfo(mother.cObj, IG3D_MASS, 20000,20000,20000,20000)
setObjectInfo(ship.afterburner.cObj, IG3D_COLL, false)
setObjectInfo(ship.afterburner.cObj, IG3D_SIZE, 40,40,40)



mother.active=true
mother.life=2000
mother.turretlifes={15,15}
setParticle_emitterInfo(motherengine, IG3D_START)

setObjectInfo(ship.cObj, IG3D_IGNORE_COLL, true, ig3d_particle_emitter, gun) --dont shoot self
setObjectInfo(mother.cObj, IG3D_IGNORE_COLL, true, ig3d_particle_emitter, abomb) --dont shoot self

setParticle_emitterInfo(gun, IG3D_BILLBOARD_Z, true)


setSound_emitterInfo(hitSnd, IG3D_SAMPLE, "Data/Sounds/planehit.ogg")
setSound_emitterInfo(engineSnd, IG3D_SAMPLE, "Data/Sounds/planefly.ogg")

setSound_emitterInfo(gunSnd, IG3D_SAMPLE, "Data/Sounds/turret.ogg")
setSound_emitterInfo(engineSnd, IG3D_POSITION, getObjectInfo(ship.cObj, IG3D_POSITION))

setObjectInfo(water.cObj, IG3D_REPEAT, true)--oh oh
setObjectInfo(water.cObj, IG3D_MASS, 0,0,0,0)--infinite mass





if options[gClouds]=="YES" then
for i=1,10,1 do
--near clouds
s=math.random()*2.0
make_cloud(cloudpath, clouds, -250+math.random(500),450+math.random(300),-250+math.random(500),s,s,s)
end
end



updateFromVisualCamera()

camera.oldxang=camera.xang
camera.oldyang=camera.yang
camera.oldzang=camera.zang


init_plane(ship)
init_enemies()
init_friends()
gObjects[2].powerup=gObjects[11] --remove

dofile(gameroot.."Data/Scripts/Games/iFly_Functions/iFly_Game.lua")


