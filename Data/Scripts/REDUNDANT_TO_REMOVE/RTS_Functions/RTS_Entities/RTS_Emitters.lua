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