-- ZGS_Sounds.lua
setSceneInfo(IG3D_SOUND_DAMPING, 0, 0, 0, 0) -- full damping
setSceneInfo(IG3D_SOUND_DAMPING, 0, 0.006667, 0.106667, 100.0)
setSceneInfo(IG3D_SOUND_DAMPING, 0, 0, 0.05, 100.0)  
gSoundEmittersHighwaterMark=1

function assign_free_sound_emitter()
		local r=gSoundEmitters[gSoundEmittersHighwaterMark]
		gSoundEmittersHighwaterMark=gSoundEmittersHighwaterMark+1
		if gSoundEmittersHighwaterMark>#gSoundEmitters then
			gSoundEmittersHighwaterMark=1
		end
		return r
end


