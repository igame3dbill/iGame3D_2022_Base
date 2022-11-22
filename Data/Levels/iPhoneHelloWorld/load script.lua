-- Begin of auto-script
loadMesh("Data/Levels/iPhoneHelloWorld/iPhoneHelloWorld_level_mesh.wtf")
gSoundFiles={"Data/Sounds/zombie_eating.ogg"}
for i=1,#gSoundFiles,1 do
	loadSound(gSoundFiles[i])
end
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, -0.528696, 1.315456, -0.005495)
setCameraInfo(IG3D_ROTATION, 45.000019, 142.333344, -0.000000)
gObjects={}
gObjectWTFs={"Characters/tomdrinman1_3kslimed.wtf","Characters/jackytrueboneszombie"}
gObjectNames={"tomdrinman1_3kslimed1","chick"}
gObjectPositions={{0.000000,0.900000,-0.800000},{1.000000,0.900000,-0.800000}}
gObjectRotations={{0.000000,0.000000,0.000000},{0.000000,0.000000,0.000000}}
gObjectSizes={{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000}}
gObjectColls={true,true}
gObjectHUDs={false,false}
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
gSoundEmitterNames={"zombie eat"}
gSoundEmitterPositions={{-0.096607,0.608349,-0.565226}}
gSoundEmitterSamples={"Data/Sounds/zombie_eating.ogg"}
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
setLightInfo(1, IG3D_POSITION, 0.000000,0.000000,10.000000,1.000000)
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

--setSound_emitterInfo(gSoundEmitters[1], IG3D_POSITION, getCameraInfo(IG3D_POSITION))
--setSound_emitterInfo(gSoundEmitters[1], IG3D_START)

--ig3d_ReadAnimationsFromFileIntoCache_si(gameroot.."Data/WTF/Characters/truebonesmaster.wtf", 25179)

setLightInfo(1, IG3D_POSITION, 0,0,10,1)
setObjectInfo(gObjects[1].cObj, IG3D_ANIMATION, "Walk",0, true)
setObjectInfo(gObjects[1].cObj, IG3D_VECTOR_CONSTRAINT, 0,1,0);
setObjectInfo(gObjects[1].cObj, IG3D_GRAVITY_MULTIPLIER, 1)
setObjectInfo(gObjects[2].cObj, IG3D_ANIMATION, "Walk",0, true)
setObjectInfo(gObjects[2].cObj, IG3D_VECTOR_CONSTRAINT, 0,1,0);
setObjectInfo(gObjects[2].cObj, IG3D_GRAVITY_MULTIPLIER, 1)

--setSceneInfo(IG3D_RECEIVE_SHADOW, true)
--setObjectInfo(gObjects[1].cObj, IG3D_CAST_SHADOW, true)
--setObjectInfo(gObjects[2].cObj, IG3D_CAST_SHADOW, true)
--setLightInfo(2, IG3D_POSITION, 0,10,0,1)
--setLightInfo(1, IG3D_POSITION, 0,10,0,1)

oldX=0
oldY=0
oldZ=0
obj=nil
oldclick=0
lastcoll=0

function movethezomb()
	
	x,y,z=getObjectInfo(gObjects[1].cObj, IG3D_POSITION)
	--setObjectInfo(gObjects[1].cObj, IG3D_POSITION, x,y,z-passed())
	x,y,z=getCameraInfo(IG3D_POSITION)
	setLightInfo(1, IG3D_POSITION, x,y,z,1)
	
	if click("-") then
		c,x,y,z,o=lineCollision(getSceneInfo(IG3D_MOUSE_LINE))
		
		if click("n") then
			if c==2 then
				setObjectInfo(o.cObj, IG3D_RAGDOLL, true)
				obj=o
				oldX=x
				oldY=y
				oldZ=z
				setObjectInfo(obj.cObj, IG3D_IMPULSE, x,y,z,0,5,0)
				b=get(ig3d_bone, obj.cObj, "chest")
				x2,y2,z2=getBoneInfo(b, IG3D_POSITION)
				x,y,z=getCameraInfo(IG3D_POSITION)
				setCameraInfo(IG3D_ROTATION, dirToAngles(x2-x,y2-y,z2-z))
			else
				if time()-oldclick < 0.2 then
					loadLevel("Data/Levels/iPhoneHelloWorld")
				end
			end
		end
		
		if obj and c>0 then
			a,b,c,d,e,f=getSceneInfo(IG3D_MOUSE_LINE)
			c,x,y,z,o=lineCollision(d,e,f,a,b,c)
			if c > 0 then
				--x2,y2,z2=getObjectInfo(obj.cObj, IG3D_POSITION)
				b=get(ig3d_bone, obj.cObj, "chest")
				x2,y2,z2=getBoneInfo(b, IG3D_POSITION)
				dx=x-x2
				dy=y-y2
				dz=z-z2
				d=vecLength(dx,dy,dz)
				if d>0.1 then
					dx=(dx/d)*0.1
					dy=(dy/d)*0.1
					dz=(dz/d)*0.1
				else
					dx=0
					dy=0
					dz=0
				end
				--if y2<0.75 then dy=dy+0.2 end
				setObjectInfo(obj.cObj, IG3D_IMPULSE, x2,y2,z2,dx*5,dy*5,dz*5)
			end
			oldX=x
			oldY=y
			oldZ=z
		end
		
		oldclick=time()
	end
	
	
	
	--if click("o") then
	if not click("-") then
		if obj then
			b=get(ig3d_bone, obj.cObj, "chest")
			x2,y2,z2=getBoneInfo(b, IG3D_POSITION)
			x,y,z=getCameraInfo(IG3D_POSITION)
			setCameraInfo(IG3D_ROTATION, dirToAngles(x2-x,y2-y,z2-z))
			--y2=y
			d=vecLength(x2-x,y2-y,z2-z)
			dx,dy,dz=normalized(x2-x,y2-y,z2-z)
			
			if d>1 then
				setCameraInfo(IG3D_POSITION, x+dx*(d-1), math.max(1,y+dy*(d-1)), z+dz*(d-1))
			end
			if d<0.2 then
				setCameraInfo(IG3D_POSITION, x-dx*(0.2-d), math.max(1,y-dy*(0.2-d)), z-dz*(0.2-d))
			end
		end
		--obj=nil
	end
	
	
			
end


game_func= movethezomb