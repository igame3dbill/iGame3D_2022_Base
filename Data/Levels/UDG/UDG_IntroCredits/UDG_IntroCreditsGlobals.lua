--UDG_Credits Level Credits Show and Road Globals

	startVolume=20
	ig3d_ReadAnimationsFromFileIntoCache_si(gameroot.."Data/WTF/Characters/truebonesmaster.wtf", 25179)
	gCameraFollowCarNow=false
--{45.305626,0.475983,-45.309250}
	setSceneInfo(IG3D_BACKGROUND_COLOR, 0.0,0.0,0.0)
	gAlpha=0
	gFadeStartColor={r=1, g=1, b=1, a=0}
	gFadeMult=1
	gCreditTexts1={"iGame3D presents","For uDevGames 2008\nwww.udevgames.com"}
	gCreditTexts2={"Programming\n Tobias Opfermann\n\nDesign\n William Griffin","Executive Producer\n  Amy Griffin\n\nAssociate Producer \n  Alisa Griffin","Additonal Models & Textures:\n Felix Gonsior\n  TurboSquid\n   cgTextures\n    Exchange3D","Music by\n Marco Kittel\n  PodsafeProduction\n   entropymusic"}
	gCreditTexts3={""}--might contain useful information later
	gCurCredit=1
	gCreditTexts= gCreditTexts1
	gRadioIsPlaying=false
	blendQuad=gObjects[4]
	gUDGMusic=gSoundEmitters[1]
	skid=gSoundEmitters[2]
	
	snow=gParticleEmitters[1]
	blizzard1=gParticleEmitters[5]
	blizzard2=gParticleEmitters[6]
	
	car=gObjects[1]
	gLastDistance=1000
	playerBox=gObjects[5]
	
	oilonfloor=gParticleEmitters[2]
	oilonfloor2=gParticleEmitters[3]
	oil=gParticleEmitters[4]

	local m,ix,iy,iz=getObjectInfo(car.cObj, IG3D_MASS)
	setObjectInfo(car.cObj, IG3D_MASS, 20*m,20*ix,20*iy,20*iz)
	setObjectInfo(car.cObj, IG3D_VEHICLE, true)
	setParticle_emitterInfo(oil, IG3D_FORCE, 0,-9.81,0)
	setObjectInfo(gObjects[6].cObj, IG3D_IGNORE_OBJECT_COLLS, true)
	setObjectInfo(gObjects[7].cObj, IG3D_IGNORE_OBJECT_COLLS, true)
	setObjectInfo(gObjects[6].cObj, IG3D_RAGDOLL, true)
	setObjectInfo(gObjects[7].cObj, IG3D_RAGDOLL, true)
	setObjectInfo(gObjects[2].cObj, IG3D_MASS, 0,0,0,0)
	setObjectInfo(gObjects[3].cObj, IG3D_MASS, 0,0,0,0)
	local m=get(ig3d_material, blendQuad.cObj, 1)
	setMaterialInfo(m, IG3D_COLOR, 0,0,0,1)	
	setMaterialInfo(m, IG3D_TEXTURE, 1, nil)
for i=1,7,1 do
	if i~=4 and i~=5 then setObjectInfo(gObjects[i].cObj, IG3D_CAST_SHADOW, true) end
end
	setSceneInfo(IG3D_RECEIVE_SHADOW, true)
	setLightInfo(2, IG3D_POSITION, 0,50,0,0)
	--set fading color
	setText_boxInfo(gTextboxes[1], IG3D_COLOR, gFadeStartColor.r, gFadeStartColor.g, gFadeStartColor.b, gFadeStartColor.a)
	setCameraInfo(IG3D_POSITION, 1000,1000,1000)
	setCameraInfo(IG3D_ROTATION, -90,0,0)
	setParticle_emitterInfo(snow, IG3D_POSITION, getCameraInfo(IG3D_POSITION))
	
	

		
