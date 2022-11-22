gGrenadeDistance=2
gNadeThrowDelay=0.5

grenadeSound= assign_free_sound_emitter()
grenadeDropSound=assign_free_sound_emitter()
grenadeThrowSound=assign_free_sound_emitter()
loadSound("Data/Sounds/grenade.ogg")--need a grenade sound
loadSound("Data/Sounds/dropgrenade.ogg")
loadSound("Data/Sounds/throw_whoosh.ogg")

gNextGrenadeDropSound=time()
gGrenadeDropSoundDelay=1
gMostRecentGrenadePosition={0,0,0}

--setup grenade emitter
grenadeEmitter = get(ig3d_particle_emitter, "Grenade")
if grenadeEmitter==nil then
	i=#gParticleEmitters +1
	gParticleEmitters[i]=make(ig3d_particle_emitter, "Grenade","Data/Emitters/grenade.emt")
	grenadeEmitter= gParticleEmitters[i]
end
setParticle_emitterInfo(grenadeEmitter, IG3D_FORCE, 0,-0.981,0)

--setup grenade explosion emitter
grenadeExplosionEmitter = get(ig3d_particle_emitter, "Explosion")
if grenadeExplosionEmitter ==nil then
	i=#gParticleEmitters +1
	gParticleEmitters[i]=make(ig3d_particle_emitter, "Explosion","Data/Emitters/grenadeexplosion.emt")
	grenadeExplosionEmitter = gParticleEmitters[i]
end

function udg_throw_grenade(x,y,z, dx,dy,dz)
	setParticle_emitterInfo(grenadeEmitter, IG3D_POSITION, x,y,z)
	setParticle_emitterInfo(grenadeEmitter, IG3D_ROTATION, dirToAngles(dx,dy,dz))
	setParticle_emitterInfo(grenadeEmitter, IG3D_START)
	setSound_emitterInfo(grenadeThrowSound, IG3D_POSITION, x,y,z)
	setSound_emitterInfo(grenadeThrowSound, IG3D_SAMPLE, "Data/Sounds/throw_whoosh.ogg")
	setSound_emitterInfo(grenadeThrowSound, IG3D_START)
end

function grenadeExplodesAt(x,y,z)
	udg_GunLightSix(x,y+1,z)

	y=0
	setSound_emitterInfo(grenadeSound, IG3D_POSITION, x,y,z)
	setSound_emitterInfo(grenadeSound, IG3D_SAMPLE, "Data/Sounds/grenade.ogg")
	setSound_emitterInfo(grenadeSound, IG3D_START)
	setSound_emitterInfo(grenadeSound, IG3D_VOLUME, 100)
	setParticle_emitterInfo(grenadeExplosionEmitter, IG3D_POSITION, x,y,z)
	setParticle_emitterInfo(grenadeExplosionEmitter, IG3D_START)
	
	for i=1,#gObjects,1 do
		
		local lx,ly,lz=getObjectInfo(gObjects[i].cObj, IG3D_POSITION)
		local dx,dy,dz=normalized(lx-x, ly-y, lz-z)
		local dst=vecLength(lx-x, 0, lz-z)
		--local mult=math.max( (gGrenadeDistance-dst)*2, 2.0)
		mult=2

		if dst<gGrenadeDistance and gObjects[i].cObj~=playerBox then
		
			if gObjects[i].health>0 and getObjectInfo(gObjects[i].cObj, IG3D_COLL) then
				--[[
				if gObjects[i].team<=1 then
					local result,cx,cy,cz,u,v,m,nx,ny,nz=getObjectInfo(gObjects[i].cObj, IG3D_EXACT_COLLISION_DATA, x,y,z,x+dx*5,y+dy*5,z+dz*5)
					if result then
						drawToTexture( getMaterialInfo(m, IG3D_TEXTURE, 3), "Data/Images/Decals/bloodpencil"..(math.random(1,3))..".png",u,v, IG3D_ADD, IG3D_REPEAT)
					end
				end
				--]]
				
				gObjects[i].impulse={x,y,z,dx*mult,10,dz*mult}
				gObjects[i].health=-10
				if math.random(1,2)==1 then gObjects[i].deathCount=0 end
				--[[
				bonesToTakeOff={"head"}
				local a=get(ig3d_bone, gObjects[i].cObj, "None")
				local bnnum=math.random(1,#bonesToTakeOff)
				local bn=get(ig3d_bone, gObjects[i].cObj, bonesToTakeOff[bnnum])
				
				if a~=bn and gObjects[i].deathCount<=1 then
					--setBoneInfo(get(ig3d_bone, gObjects[i].cObj, bonesToTakeOff[bnnum]), IG3D_RAGDOLL, false)
					--setBoneInfo(get(ig3d_bone, gObjects[i].cObj, bonesToTakeOff[bnnum]), IG3D_ENABLED, false)
				end
				--]]
			else
				gObjects[i].deathCount=0
			end
		end
	end
	
	for i=1,#gParticleEmitters,1 do
			local lx,ly,lz=getParticle_emitterInfo(gParticleEmitters[i], IG3D_POSITION)
			local dx,dy,dz=normalized(lx-x, ly-y, lz-z)
			local dst=vecLength(lx-x, ly-y, lz-z)
			local mult=math.max(gGrenadeDistance-dst, 4.0)

			if dst<gGrenadeDistance then
				setParticle_emitterInfo(gParticleEmitters[i], IG3D_IMPULSE, x,y,z,dx*mult,10,dz*mult)
			end
	end

end


function udg_get_nearest_grenade_to_position(x,y,z)
	local dst=-1
	local i
	local nearest=-1
	local numNadesInGame=getParticle_emitterInfo(grenadeEmitter, IG3D_COUNT)
	for i=1,numNadesInGame,1 do
		if getParticleInfo(grenadeEmitter, i, IG3D_LIFE_TIME)>0.1 then
			local gx,gy,gz=getParticleInfo(grenadeEmitter, i, IG3D_POSITION)
			local thisdst=vecLength(gx-x,gy-y,gz-z)
			if thisdst<dst or dst==-1 then
				nearest=i
				dst=thisdst
			end	
		end
	end
	
	return nearest
end

function udg_explode_nearest_grenade_to_position(x,y,z)
	local nearest= udg_get_nearest_grenade_to_position(x,y,z)
	if nearest>0 then
		grenadeExplodesAt(getParticleInfo(grenadeEmitter, nearest, IG3D_POSITION))
		setParticleInfo(grenadeEmitter, nearest, IG3D_LIFE_TIME, 0) --die next frame
	end
end



function udg_handle_grenates()
	
	local i
	local numNadesInGame=getParticle_emitterInfo(grenadeEmitter, IG3D_COUNT)
	for i=1,numNadesInGame,1 do
		if getParticleInfo(grenadeEmitter, i, IG3D_LIFE_TIME)<0.1 and getParticleInfo(grenadeEmitter, i, IG3D_LIFE_TIME)>0 then
			grenadeExplodesAt(getParticleInfo(grenadeEmitter, i, IG3D_POSITION))
			setParticleInfo(grenadeEmitter, i, IG3D_LIFE_TIME, 0) --die next frame
		end
	end
end


function SoldiersWithGrenades()
	for i=1,#humans,1 do
		if getObjectInfo(humans[i].cObj, IG3D_MODEL)=="Characters/soldierboyTB.wtf" then
			--humans[i].numGrenades=20
			humans[i].farDistance=8.5
		end
	end
end


