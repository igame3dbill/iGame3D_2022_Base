-- Begin of auto-script
loadMesh("Data/Levels/RagdollDebug/mesh.wtf")
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, 0.077179, 1.264324, 1.279321)
setCameraInfo(IG3D_ROTATION, 21.333332, 178.666672, 0.000000)
gObjects={}
gObjectWTFs={"Characters/tomdrinwoman5_3k.wtf"}
gObjectWTFs={"WIF/Walk_Zombie.wtf"}
gObjectWTFs={"Characters/ponchocorpgirl.wtf"}
--gObjectWTFs={"Characters/chick.wtf"}
gObjectNames={"chick"}
gObjectPositions={{0.000000,1.103647,0.000000}}
gObjectRotations={{0.000000,-0.000000,0.000000}}
gObjectSizes={{100.000000,100.000000,100.000000}}
gObjectColls={true}
gObjectHUDs={false}
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
gGroups={}
gNumGroups=0
setSceneInfo(IG3D_TINT_COLOR, 1.000000,1.000000,1.000000)
setSceneInfo(IG3D_FOG, false,0.500000,0.500000,0.500000,0.000000,200.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.650000,0.650000,0.650000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, -5.000000,20.000000,20.000000,1.000000)
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

--make(ig3d_object, "test.wtf")
--setObjectInfo(1, IG3D_POSITION, 0,15,0)
--setObjectInfo(1, IG3D_ROTATION, 0,0,45)
--[[
b=get(ig3d_bone, 1, "None")
setBoneInfo(b, IG3D_RAGDOLL, false)
b=get(ig3d_bone, 1, "wall1")
setBoneInfo(b, IG3D_RAGDOLL, false)
b=get(ig3d_bone, 1, "wall2")
setBoneInfo(b, IG3D_RAGDOLL, false)


b=get(ig3d_bone, 1, "wall3")
setBoneInfo(b, IG3D_RAGDOLL, false)
b=get(ig3d_bone, 1, "wall4")
setBoneInfo(b, IG3D_RAGDOLL, false)
b=get(ig3d_bone, 1, "ceiling")
setBoneInfo(b, IG3D_RAGDOLL, false)
--]]
house=gParticleEmitters[1]

setObjectInfo(1, IG3D_CAST_SHADOW, true, "Characters/humanoid_shadowlow.wtf")
setSceneInfo(IG3D_RECEIVE_SHADOW, true)
setLightInfo(2, IG3D_POSITION, 15,15,15,0)
--setSceneInfo(IG3D_LOD_DISTANCE, 0,0,0,50)

function myfunc()
	if key("w", "n") then
		
		
		
		
		
		local i=1
		while true do
			b=get(ig3d_bone, 1, i)
			--setBoneInfo(b, IG3D_RAGDOLL, false)
			if getBoneInfo(b, IG3D_NAME)=="None" then break end
			i=i+1
		end
		b=get(ig3d_bone, 1, "head")
		--setBoneInfo(b, IG3D_RAGDOLL, false)
		
		--setParticle_emitterInfo(house, IG3D_BONE_TRAVERSAL, true)
		setObjectInfo(1, IG3D_RAGDOLL, true)
		--setParticle_emitterInfo(house, IG3D_FORCE, 0,-10,0)
		--setParticle_emitterInfo(house, IG3D_POSITION, getObjectInfo(1, IG3D_POSITION))
		
		--setObjectInfo(1, IG3D_ANIMATION, "Collapse",0,true)
		--setObjectInfo(1, IG3D_MASS, 20,20,20,20)
		--setObjectInfo(1, IG3D_GRAVITY_MULTIPLIER, 1)
		--setObjectInfo(1, IG3D_FORCE, 0,-9.81,0)
		
		
	end
	
	if key(" ","n") then
		loadLevel("Data/Levels/RagdollDebug")
	end
	
	if key("s", "n") then
		--setParticle_emitterInfo(house, IG3D_BONE_TRAVERSAL, true)
		setObjectInfo(1, IG3D_RAGDOLL, false)
		--setParticle_emitterInfo(house, IG3D_FORCE, 0,-10,0)
		--setParticle_emitterInfo(house, IG3D_POSITION, getObjectInfo(1, IG3D_POSITION))
		
		--setObjectInfo(1, IG3D_ANIMATION, "Collapse",0,true)
		--setObjectInfo(1, IG3D_MASS, 20,20,20,20)
		--setObjectInfo(1, IG3D_GRAVITY_MULTIPLIER, 1)
		--setObjectInfo(1, IG3D_FORCE, 0,-9.81,0)
		
	end
	
end




game_func=myfunc

