-- particles
gGunEmitter=get(ig3d_particle_emitter, "Bullets")
tireTraces=get(ig3d_particle_emitter, "TireTraces")
bloodParticles=get(ig3d_particle_emitter, "Blood")
muzzleFlash=get(ig3d_particle_emitter, "MuzzleFlash")
unitMarkerFriendly=get(ig3d_particle_emitter, "Unitmarker")
unitMarkerEnemy=get(ig3d_particle_emitter, "Unitmarker2")
if gGunEmitter==nil then print("Missing \"Bullets\" emitter\n") end
if tireTraces ==nil then print("Missing \"TireTraces\" emitter\n") end
if bloodParticles ==nil then print("Missing \"Blood\" emitter\n") end
if muzzleFlash ==nil then print("Missing \"MuzzleFlash\" emitter\n") end
if unitMarkerFriendly ==nil then print("Missing \"Unitmarker\" emitter\n") end
if unitMarkerEnemy ==nil then print("Missing \"Unitmarker2\" emitter\n") end

function zfps_get_nearest_particle_to_position(emt, x,y,z)
	local dst=-1
	local i
	local nearest=-1
	local numParticlesInGame=getParticle_emitterInfo(emt, IG3D_COUNT)
	for i=1,numParticlesInGame,1 do
		if getParticleInfo(emt, i, IG3D_LIFE_TIME)>0.1 then
			local gx,gy,gz=getParticleInfo(emt, i, IG3D_POSITION)
			local thisdst=vecLength(gx-x,gy-y,gz-z)
			if thisdst<dst or dst==-1 then
				nearest=i
				dst=thisdst
			end	
		end
	end
	return nearest
end