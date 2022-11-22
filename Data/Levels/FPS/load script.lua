-- Begin of auto-script
loadMesh("Data/Levels/FPS/mesh.wtf")
gTextureFiles={"Data/Images/Decals/bloodpencil1.png","Data/Images/Decals/bloodpencil2.png","Data/Images/Decals/bloodpencil3.png","Data/Images/Decals/crosshair.png"}
for i=1,#gTextureFiles,1 do
	loadTexture(gTextureFiles[i])
end
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, -3.047818, 1.149616, 2.796964)
setCameraInfo(IG3D_ROTATION, 8.931063, 130.666794, 0.000000)
gObjects={}
gObjectWTFs={"Characters/mrchief.wtf","Cubes/kiste.wtf","Characters/bumpywoman.wtf","Characters/skeleton.wtf","Characters/fighterMan.wtf","Characters/jacky.wtf","Characters/greenalien.wtf","Reticule/crosshair.wtf"}
--gObjectWTFs={"terrorist.wtf","kiste.wtf","greenalien.wtf","fleshbeast.wtf","fleshbeast.wtf","skeleton.wtf","skeleton.wtf","crosshair.wtf"}
gObjectNames={"terrorist1","kiste1","bumpywoman1","terrorist2","fighter1","jacky1","bumpywoman21","crosshair1"}
gObjectPositions={{-1.442945,0.696556,1.936761},{-3.047818,0.499616,2.796964},{0.812376,0.499999,2.779201},{-1.704506,0.539498,-0.535485},{1.171124,0.526353,0.925551},{-2.259820,0.499368,-0.564937},{-1.502013,2.978446,-0.475851},{0.000000,0.000000,-0.100000}}
gObjectRotations={{-0.155183,-75.000877,0.131458},{0.017463,-0.007309,0.024048},{-0.060752,-42.000385,0.002131},{-0.035395,38.500099,-0.006200},{-0.014576,-79.999947,-0.034831},{-0.000001,0.000000,0.008944},{0.047951,-0.114466,0.012678},{0.000000,-0.000000,0.000000}}
gObjectSizes={{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000},{100.000000,100.000000,100.000000}}
gObjectColls={true,true,true,true,true,true,true,false}
gObjectHUDs={false,false,false,false,false,false,false,true}
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
gParticleNamesAndEMTs={{"Gun","Data/Emitters/slowbullet.emt"}}
gParticlePositions={{-3.122750,1.165140,2.861340}}
gParticleRotations={{8.931063,130.666794,0.000000}}
gParticleEmitters={}
for i=1,#gParticleNamesAndEMTs,1 do
	gParticleEmitters[i]=make(ig3d_particle_emitter, gParticleNamesAndEMTs[i][1], gParticleNamesAndEMTs[i][2])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_POSITION, gParticlePositions[i][1],gParticlePositions[i][2],gParticlePositions[i][3])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_ROTATION, gParticleRotations[i][1],gParticleRotations[i][2],gParticleRotations[i][3])
end
gNumParticleEmitters=#gParticleNamesAndEMTs
gGroups={}
gNumGroups=0
setSceneInfo(IG3D_TINT_COLOR, 1.000000,1.000000,1.000000)
setSceneInfo(IG3D_FOG, false,0.500000,0.500000,0.500000,0.000000,200.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.300000,0.300000,0.900000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, -12.000000,60.000000,50.000000,0.000000)
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
gun=gParticleEmitters[1]

first=true
player=gObjects[2]

for i=1,#gObjects-1,1 do
	gObjects[i].hit=false
	gObjects[i].dedoll=0
	setObjectInfo(gObjects[i].cObj, IG3D_VECTOR_CONSTRAINT, 0,1,0)
	setObjectInfo(gObjects[i].cObj, IG3D_GRAVITY_MULTIPLIER, 1)
	setObjectInfo(gObjects[i].cObj, IG3D_MASS, 1,1,1,1)
end
looker=get(ig3d_bone, player.cObj, "None")
setBoneInfo(looker, IG3D_ENABLED, false)
setObjectInfo(player.cObj, IG3D_VECTOR_CONSTRAINT, 0,1,0)
setObjectInfo(player.cObj, IG3D_GRAVITY_MULTIPLIER, 0.1)
setObjectInfo(player.cObj, IG3D_IGNORE_COLL, true, ig3d_particle_emitter, gun)
setParticle_emitterInfo(gun, IG3D_IGNORE_COLL, true, ig3d_particle_emitter, gun)--dont collide bullets with bullets
setObjectInfo(player.cObj, IG3D_SHAPE, ig3d_sphere)
xa,ya,za=getCameraInfo(IG3D_ROTATION)

setLightInfo(2, IG3D_POSITION, 0,5,7,1)
--setSceneInfo(IG3D_RECEIVE_SHADOW, true)
--setObjectInfo(gObjects[1].cObj, IG3D_CAST_SHADOW, true)
--setObjectInfo(gObjects[3].cObj, IG3D_CAST_SHADOW, true)
--setObjectInfo(gObjects[4].cObj, IG3D_CAST_SHADOW, true)
--setObjectInfo(gObjects[5].cObj, IG3D_CAST_SHADOW, true)
--setObjectInfo(gObjects[6].cObj, IG3D_CAST_SHADOW, true)

--[[
gObjects[4].hit=true
setObjectInfo(gObjects[4].cObj, IG3D_RAGDOLL,true)
b=get(ig3d_bone, gObjects[4].cObj, "Head")
x,y,z=getBoneInfo(b, IG3D_POSITION)
test=make(ig3d_joint, gObjects[4].cObj, nil, IG3D_BALL, x,y,z)
gObjects[6].hit=true
setObjectInfo(gObjects[6].cObj, IG3D_RAGDOLL,true)
b=get(ig3d_bone, gObjects[6].cObj, "Head")
x,y,z=getBoneInfo(b, IG3D_POSITION)
j=make(ig3d_joint, gObjects[6].cObj, nil, IG3D_BALL, x,y,z)
--]]


function normalized(x,y,z)
local l=math.sqrt(x*x+y*y+z*z)
if l==0 then l=1 end
return x/l,y/l,z/l
end

setSceneInfo(IG3D_MOUSE_VIEW, true,1)
function thefps()
	
	if not first then
		local dx,dy=getSceneInfo(IG3D_MOUSE_DELTA)
		xa=xa+dy
		ya=ya-dx
		setCameraInfo(IG3D_ROTATION, xa,ya,za)
	end
	
	
	
	for i=1,#gObjects,1 do
		if gObjects[i].becomeDoll then
			setObjectInfo(gObjects[i].cObj, IG3D_RAGDOLL,true)
			
			gObjects[i].becomeDoll=false
			gObjects[i].dedoll=time()+6
			
		end
		
		if gObjects[i].hit and gObjects[i].dedoll<= time() then
			--delete(ig3d_joint, j)
			--setObjectInfo(gObjects[i].cObj, IG3D_RAGDOLL, false)
			--setObjectInfo(gObjects[i].cObj, IG3D_MASS, 0,0,0,0)
			--gObjects[i].hit=false
		end
	end
	
	a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44=getCameraInfo(IG3D_ROTATION_MATRIX)
	
	x=0
	y=0
	z=0
	forw={a31,a32,a33}
	forw[2]=0
	forw[1],forw[2],forw[3]=normalized(forw[1],forw[2],forw[3])
	
	if key(" ","n") then
		loadLevel("Data/Levels/FPS")
	end
	
	if key("w","-") then
		x=x+forw[1]
		y=y+forw[2]
		z=z+forw[3]
	end
	
	if key("s","-") then
		x=x-forw[1]
		y=y-forw[2]
		z=z-forw[3]
	end
	
	if key("a","-") then
		x=x+a11
		y=y+a12
		z=z+a13
	end
	
	if key("d","-") then
		x=x-a11
		y=y-a12
		z=z-a13
	end
	
	

	dx,dy,dz=getObjectInfo(player.cObj, IG3D_VELOCITY)
	setObjectInfo(player.cObj, IG3D_FORCE, x*5-dx,y*5-dy,z*5-dz)
	x,y,z=getObjectInfo(player.cObj, IG3D_POSITION)
	y=y+0.65
	setCameraInfo(IG3D_POSITION, x,y,z)
	
	setParticle_emitterInfo(gun, IG3D_POSITION, x-a31*0.1,y-a32*0.1,z-a33*0.1)
	setParticle_emitterInfo(gun, IG3D_ROTATION, getCameraInfo(IG3D_ROTATION))
	if click("n") then
		setParticle_emitterInfo(gun, IG3D_START)
	end
	if click("o") then
		setParticle_emitterInfo(gun, IG3D_STOP)
	end
	
	setSceneInfo(IG3D_MOUSE_VIEW, true, 1)
	default_escapekey()
	first=false
	
	for i=1,#gObjects,1 do
		gObjects[i].blood=false
	end
end

function objpart(obj, bone, emitter, x,y,z)
	if obj.blood==false then
		local sx,sy,sz=getParticle_emitterInfo(get(ig3d_particle_emitter, emitter), IG3D_POSITION)
		dx=sx+(x-sx)*2
		dy=sy+(y-sy)*2
		dz=sz+(z-sz)*2
		
		result,x,y,z,u,v,m=getObjectInfo(obj.cObj, IG3D_EXACT_COLLISION_DATA, sx,sy,sz,dx,dy,dz)
		if result then
			if obj.hit==false then
				obj.becomeDoll=true
				obj.hit=true
			end
			drawToTexture( getMaterialInfo(m, IG3D_TEXTURE, 3), "Data/Images/Decals/bloodpencil"..(math.random(3))..".png",u,v, IG3D_ADD, IG3D_CLAMP)
			obj.blood=true
		else
			--setObjectInfo(obj.cObj, IG3D_VELOCITY, 0,0,0)
			--setObjectInfo(obj.cObj, IG3D_OMEGA,0,0,0)
		end
		
	end
	
	
		--local b=get(ig3d_bone, obj.cObj, tonumber(bone))
		--if getBoneInfo(b, IG3D_NAME)=="Head" then
		--	setBoneInfo(b, IG3D_ENABLED,false)
		--	setBoneInfo(b, IG3D_COLL, false)
		--end

		--[[
		b=get(ig3d_bone, obj.cObj, "RightArm")
		setBoneInfo(b, IG3D_ENABLED,false)
		setBoneInfo(b, IG3D_COLL, false)
		b=get(ig3d_bone, obj.cObj, "LeftArm")
		setBoneInfo(b, IG3D_ENABLED,false)
		setBoneInfo(b, IG3D_COLL, false)
			--]]
		
		
				
		
	
	
end
game_func=thefps
coll_o_p=objpart

--Lade die Blutstempel
loadTexture("Data/Images/Decals/bloodpencil1.png")
loadTexture("Data/Images/Decals/bloodpencil2.png")
loadTexture("Data/Images/Decals/bloodpencil3.png")

--Gebe jedem Material in jedem Objekt eine neue Textur
for i=1,#gObjects,1 do
	j=1
	m=get(ig3d_material, gObjects[i].cObj, j)
	while m ~= nil do
		setMaterialInfo(m, IG3D_TEXTURE, 3, make(ig3d_texture, getObjectInfo(gObjects[i].cObj, IG3D_NAME)..(os.time()).."tempblood"..(j)..".png",64,64))
		if getSceneInfo(IG3D_FRAGMENT_SHADER_SUPPORTED)==false then
			--no bumppass shader and no normal map in texture unit 2
			setMaterialInfo(m, IG3D_SHADER, nil)
			setMaterialInfo(m, IG3D_TEXTURE, 2, nil)
		end
		j=j+1
		m=get(ig3d_material, gObjects[i].cObj, j)
	end	
end

setObjectInfo(gObjects[1].cObj, IG3D_ANIMATION, "LookAround", 0, true)--SitAndWait
setObjectInfo(gObjects[3].cObj, IG3D_ANIMATION, "SitAndWait", 0, true)
setObjectInfo(gObjects[4].cObj, IG3D_ANIMATION, "LookAround", 0, true)
setObjectInfo(gObjects[5].cObj, IG3D_ANIMATION, "SitAndWait", 0, true)
setObjectInfo(gObjects[6].cObj, IG3D_ANIMATION, "LookAround", 0, true)
setObjectInfo(gObjects[7].cObj, IG3D_ANIMATION, "LookAround", 0, true)

setObjectInfo(gObjects[3].cObj, IG3D_CAST_SHADOW, true)
setObjectInfo(gObjects[1].cObj, IG3D_CAST_SHADOW, true, "Characters/mrchief2.wtf")--1
--setObjectInfo(gObjects[6].cObj, IG3D_CAST_SHADOW, true, "Characters/jacky2.wtf")--1

setSceneInfo(IG3D_RECEIVE_SHADOW, true)