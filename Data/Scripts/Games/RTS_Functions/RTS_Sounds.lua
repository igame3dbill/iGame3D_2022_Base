-- RTS_Sounds.lua
setSceneInfo(IG3D_SOUND_DAMPING, 0, 0, 0, 0) -- full damping
setSceneInfo(IG3D_SOUND_DAMPING, 0, 0.0, 0.05, 100.0)
--setSceneInfo(IG3D_SOUND_DAMPING, 0, 0, 0.05, 100.0)  
gSoundEmittersHighwaterMark=1

function assign_free_sound_emitter()
		--make sure there are enough sound emitters
		if gSoundEmittersHighwaterMark>#gSoundEmitters then
			local i
			for i=1,5,1 do
				gSoundEmitters[#gSoundEmitters+1]=make(ig3d_sound_emitter, "emt"..gSoundEmittersHighwaterMark)
			end
		end

		local r=gSoundEmitters[gSoundEmittersHighwaterMark]
		setSound_emitterInfo(r, IG3D_STOP)--important
		setSound_emitterInfo(r, IG3D_LOOP,false)
		setSound_emitterInfo(r, IG3D_SAMPLE, "")
		
		
		gSoundEmittersHighwaterMark=gSoundEmittersHighwaterMark+1
		return r
end


function rts_play_zombie_ambient_sound(obj)
	
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_STOP)
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_PITCH, 100)
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_VOLUME, 100)--3

	if isFemale(obj) then
		setSound_emitterInfo(obj.voiceSndEmt, IG3D_PITCH, 200)		
	end
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_SAMPLE, "Data/Sounds/zombie.ogg")
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_LOOP, true)	
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_START)
end