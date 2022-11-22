-- Begin of auto-script
loadMesh("Data/Levels/Pong/Pong_level_mesh.wtf")
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, -0.057068, 11.022240, 10.389338)
setCameraInfo(IG3D_ROTATION, 44.000053, -178.666626, 0.000000)
gObjects={}
gObjectWTFs={"Spheres/kugel.wtf","Cubes/paddle.wtf","Cubes/paddle.wtf"}
gObjectNames={"kugel1","paddle1","paddle2"}
gObjectPositions={{0.138054,5.246071,-0.142509},{-11.044768,3.206302,0.057160},{12.107390,3.205650,-0.380851}}
gObjectRotations={{5.240863,-38.723015,178.294052},{0.000000,-0.000000,0.000000},{0.000000,-0.000000,0.000000}}
gObjectSizes={{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000}}
gObjectColls={true,true,true}
gObjectHUDs={false,false,false}
for i=1,#gObjectWTFs,1 do
	gObjects[i]={}
gObjects[i].cObj=make(ig3d_object, gObjectWTFs[i])
	setObjectInfo(gObjects[i].cObj, IG3D_NAME, gObjectNames[i])
	setObjectInfo(gObjects[i].cObj, IG3D_POSITION, gObjectPositions[i][1],gObjectPositions[i][2],gObjectPositions[i][3])
	setObjectInfo(gObjects[i].cObj, IG3D_ROTATION, gObjectRotations[i][1],gObjectRotations[i][2],gObjectRotations[i][3])
	setObjectInfo(gObjects[i].cObj, IG3D_SIZE, gObjectSizes[i][1],gObjectSizes[i][2],gObjectSizes[i][3])
	setObjectInfo(gObjects[i].cObj, IG3D_COLL, gObjectColls[i])
	setObjectInfo(gObjects[i].cObj, IG3D_HUD, gObjectHUDs[i])
end
gNumObjects=#gObjectWTFs
gSoundEmitterNames={}
gSoundEmitterPositions={}
gSoundEmitterSamples={}
gSoundEmitters={}
for i=1,#gSoundEmitterNames,1 do
	gSoundEmitters[i]=make(ig3d_sound_emitter, gSoundEmitterNames[i])
	setSound_emitterInfo(gSoundEmitters[i], IG3D_POSITION, gSoundEmitterPositions[i][1],gSoundEmitterPositions[i][2],gSoundEmitterPositions[i][3])
	setSound_emitterInfo(gSoundEmitters[i], IG3D_SAMPLE, gSoundEmitterSamples[i])
end
gNumSoundEmitters=#gSoundEmitterNames
gGroups={}
gNumGroups=0
setSceneInfo(IG3D_TINT_COLOR, 1.000000,1.000000,1.000000)
setSceneInfo(IG3D_FOG, false,0.500000,0.500000,0.500000,0.000000,200.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.650000,0.650000,0.650000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, -0.500000,2.000000,-1.000000,0.000000)
setLightInfo(1, IG3D_AMBIENT, 0.400000,0.400000,0.400000,1.000000)
setLightInfo(1, IG3D_DIFFUSE, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(1, IG3D_SPECULAR, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(1, IG3D_CONSTANT_ATTENUATION, 1.000000)
setLightInfo(1, IG3D_LINEAR_ATTENUATION, 0.000000)
setLightInfo(1, IG3D_QUADRATIC_ATTENUATION, 0.000000)
setLightInfo(1, IG3D_SPOTLIGHT, 0.000000,0.000000,0.000000,180.000000,0.000000)
setLightInfo(2, IG3D_ENABLED, false)
setLightInfo(3, IG3D_ENABLED, false)
setLightInfo(4, IG3D_ENABLED, false)
setLightInfo(5, IG3D_ENABLED, false)
setLightInfo(6, IG3D_ENABLED, false)
setLightInfo(7, IG3D_ENABLED, false)
setLightInfo(8, IG3D_ENABLED, false)
-- End of auto-script
math.randomseed(os.time())
sx=-1
sz=math.random(1,10)-1


for i=1,gNumObjects,1 do
setObjectInfo(gObjects[i].cObj, IG3D_GRAVITY_MULTIPLIER,2.0)
--setObjectInfo(gObjects[i].cObj, IG3D_VECTOR_CONSTRAINT, 0,1,0)
end
pongBall = gObjects[1].cObj
leftPaddle = gObjects[2].cObj
rightPaddle = gObjects[3].cObj

lox,loy,loz = getObjectInfo(leftPaddle,IG3D_POSITION)
rox,roy,roz = getObjectInfo(rightPaddle,IG3D_POSITION)

setObjectInfo (leftPaddle, IG3D_COLLBOX_MULTIPLICATORS, 1.5,1,1.5) 
setObjectInfo (rightPaddle, IG3D_COLLBOX_MULTIPLICATORS, 1.5,1,1.5) 
rx,ry,rz=getObjectInfo(gObjects[2].cObj,IG3D_ROTATION)
setObjectInfo (pongBall, IG3D_SHAPE, ig3d_sphere) 
 px,py,pz=getObjectInfo(gObjects[1].cObj,IG3D_POSITION)
setObjectInfo (pongBall, IG3D_IMPULSE, px,py,pz, 8,0,8) 
setObjectInfo (pongBall, IG3D_VELOCITY, 20,.01,0)
setObjectInfo (pongBall, IG3D_FORCE, sx,0,sz) 

leftXDir=0

function playPong()
delta_x, delta_y = getSceneInfo (IG3D_WHEEL_DELTA)
ox,oy,oz=getObjectInfo(gObjects[2].cObj,IG3D_POSITION)
if delta_y~= 0 then leftXDir=delta_y*4 end

setObjectInfo (leftPaddle, IG3D_VELOCITY, 0,0,leftXDir) 
setObjectInfo (rightPaddle, IG3D_VELOCITY, 0,0,leftXDir) 

setObjectInfo (rightPaddle, IG3D_ROTATION, rx,ry,rz) 
setObjectInfo (leftPaddle, IG3D_ROTATION, rx,ry,rz) 

x,y,loz = getObjectInfo(leftPaddle,IG3D_POSITION)
x,y,roz = getObjectInfo(rightPaddle,IG3D_POSITION)

setObjectInfo (leftPaddle, IG3D_POSITION, lox,loy,loz) 
setObjectInfo (rightPaddle, IG3D_POSITION, rox,roy,roz) 
--fl.check()
end

game_func=playPong
edit_func=default_escapekey


