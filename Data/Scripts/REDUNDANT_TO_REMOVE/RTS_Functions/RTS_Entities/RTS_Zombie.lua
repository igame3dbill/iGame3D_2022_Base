zombies={}
local i,ii,animSource,checkName
--zombiechick = gObjects[4]

-- zombie(s) = gObjects[x] depends on if name contains 'zomb'   see script portions below

--Bill's attempt to create zombie armies, cycle through models create zombies based on name
for i=1,#gObjects,1 do
	checkName=string.sub(getObjectInfo(gObjects[i].cObj, IG3D_NAME),1,4)
		

	animSource=getObjectInfo(master.cObj, IG3D_NAME)
	if checkName=="zomb" then
--print(getObjectInfo(gObjects[i].cObj, IG3D_NAME))
		gObjects[i].team=1 -- go team zombie for the gold!
		gObjects[i].health=math.random(500,1000) -- not all zombies are equal
		gObjects[i].behaviour = zombie_behaviour -- act like a zombie
		gObjects[i].voiceSndEmt=assign_free_sound_emitter()

		setSound_emitterInfo(gObjects[i].voiceSndEmt, IG3D_SAMPLE, "Data/Sounds/zombie.ogg")
		setSound_emitterInfo(gObjects[i].voiceSndEmt, IG3D_VOLUME, 100)--3
		
		if string.sub(getObjectInfo(gObjects[i].cObj, IG3D_NAME),1,11)=="zombiechick" then
			setSound_emitterInfo(gObjects[i].voiceSndEmt, IG3D_PITCH, 200)
		end
		
		setSound_emitterInfo(gObjects[i].voiceSndEmt, IG3D_LOOP, true)
		
		putObjectOnGround(gObjects[i])--additional repositioning, house could have been placed on zombie!
		
		table.insert(zombies,gObjects[i])--this is a zombie
	end
		
end



---- place in load script or anim_inits file
offstz=25315 -- common WIF offset. ig3d_GetObjectModelAnimOffset_s_i(gameroot.."Data/WTF/WIF/Walk_Zombie.wtf")
--now lets fill up the cache with some animations
ig3d_ReadAnimationsFromFileIntoCache_si(gameroot.."Data/WTF/WIF/Walk_Zombie.wtf", offstz)
offst=25179
ig3d_ReadAnimationsFromFileIntoCache_si(gameroot.."Data/WTF/Characters/truebonesmaster.wtf", offst)
-- temp testing of zombie anims
Characters={}
Characters.name={}
Characters.wif={}
Characters.anims={}
Characters.velocity={}
zombieAnims = { {name="Walk", anims={ {name="limp1", linked=false}, {name="limp2", linked=false} } },      {name="Stand", anims={ {name="Idle", linked=false},{name="Stand", linked=false} } } }

function getRandomAnimationOfStyle(animTable, style, linked)
	if animTable==nil then return style, linked end
	local i
	for i=1,#animTable,1 do
		if animTable[i].name==style then
			local rnd=math.random(#animTable[i].anims)
			return animTable[i].anims[rnd].name, animTable[i].anims[rnd].linked
		end
	end
	
	return style, linked
end

--print("# zombies=",#zombies)