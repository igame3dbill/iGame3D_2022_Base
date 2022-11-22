--Load some additional sounds
loadSound("Data/Sounds/punchsolid.ogg")
loadSound("Data/Sounds/glassbreaking.ogg")

gNumFootstepSounds=0

gGlobalSoundEmitter=assign_free_sound_emitter()
setSound_emitterInfo(gGlobalSoundEmitter, IG3D_VOLUME, 100)--3

function udg_handle_zombie_idle_sounds()
	local i
	for i=1,#gObjects,1 do
		if gObjects[i].team==1 and gObjects[i].alive then
			--udg_play_zombie_idle_sound(gObjects[i])
		end
	end

end



function udg_update_object_sounds()
	for i=1,#gObjects,1 do
		local x,y,z=getObjectInfo(gObjects[i].cObj, IG3D_POSITION)
		setSound_emitterInfo(gObjects[i].noiseSndEmt, IG3D_POSITION, x,y,z)
		setSound_emitterInfo(gObjects[i].voiceSndEmt, IG3D_POSITION, x,y,z)
		udg_play_footsteps_sound(gObjects[i])
	end
end

function udg_set_gender_specific_pitch(obj)
	if isFemale(obj) then 
		setSound_emitterInfo(obj.voiceSndEmt, IG3D_PITCH, 200)
	else
		setSound_emitterInfo(obj.voiceSndEmt, IG3D_PITCH, 100)
	end
end

function udg_play_scared_sound(obj)


	setSound_emitterInfo(obj.voiceSndEmt, IG3D_STOP)
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_LOOP,false)
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_PITCH, 100)
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_POSITION, getObjectInfo(obj.cObj, IG3D_POSITION))
	gScreamer=obj
	
	local smplname="male_scream"
	if isFemale(obj) then
		smplname="fe"..smplname
	end
	smplname="Data/Sounds/"..smplname..tostring(math.random(1,2))..".ogg"
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_SAMPLE, smplname)
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_START)
end

function udg_play_get_eaten_sound(obj)
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_STOP)
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_LOOP,false)
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_PITCH, 100)
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_POSITION, getObjectInfo(obj.cObj, IG3D_POSITION))
	local smplname="male_eaten.ogg"
	if isFemale(obj) then
		smplname="fe"..smplname
	end
	smplname="Data/Sounds/"..smplname
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_SAMPLE, smplname)
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_START)
	gScreamX,gScreamY,gScreamZ = nil,nil,nil
	gScreamer=nil
end


function udg_play_eat_sound(obj)
	obj.nextSoundTime=time()+0.5
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_STOP)
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_PITCH, 100)
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_POSITION, getObjectInfo(obj.cObj, IG3D_POSITION))
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_SAMPLE, "Data/Sounds/zombie_eating.ogg")
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_LOOP, false)
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_START)
end

function udg_play_hit_sound(obj)
	obj.nextSoundTime=time()+0.5
	setSound_emitterInfo(obj.noiseSndEmt, IG3D_STOP)
	setSound_emitterInfo(obj.noiseSndEmt, IG3D_PITCH, 100)
	setSound_emitterInfo(obj.noiseSndEmt, IG3D_POSITION, getObjectInfo(obj.cObj, IG3D_POSITION))
	setSound_emitterInfo(obj.noiseSndEmt, IG3D_SAMPLE, "Data/Sounds/bodyhit.ogg")
	setSound_emitterInfo(obj.noiseSndEmt, IG3D_LOOP, false)
	setSound_emitterInfo(obj.noiseSndEmt, IG3D_START)
end

function udg_play_hit_solid_sound(obj)
	obj.nextSoundTime=time()+0.5
	setSound_emitterInfo(obj.noiseSndEmt, IG3D_STOP)
	setSound_emitterInfo(obj.noiseSndEmt, IG3D_PITCH, 100)
	setSound_emitterInfo(obj.noiseSndEmt, IG3D_POSITION, getObjectInfo(obj.cObj, IG3D_POSITION))
	setSound_emitterInfo(obj.noiseSndEmt, IG3D_SAMPLE, "Data/Sounds/punchsolid.ogg")
	setSound_emitterInfo(obj.noiseSndEmt, IG3D_LOOP, false)
	setSound_emitterInfo(obj.noiseSndEmt, IG3D_START)
end

function udg_play_glass_break_sound(obj)
	obj.nextSoundTime=time()+0.5
	setSound_emitterInfo(obj.noiseSndEmt, IG3D_STOP)
	setSound_emitterInfo(obj.noiseSndEmt, IG3D_PITCH, 100)
	setSound_emitterInfo(obj.noiseSndEmt, IG3D_POSITION, getObjectInfo(obj.cObj, IG3D_POSITION))
	setSound_emitterInfo(obj.noiseSndEmt, IG3D_SAMPLE, "Data/Sounds/glassbreaking.ogg")
	setSound_emitterInfo(obj.noiseSndEmt, IG3D_LOOP, false)
	setSound_emitterInfo(obj.noiseSndEmt, IG3D_START)
end

function udg_play_zombie_acknowledge_sound(obj)
	obj.nextSoundTime=time()+0.5
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_STOP)
	udg_set_gender_specific_pitch(obj)
	--setSound_emitterInfo(obj.voiceSndEmt, IG3D_POSITION, getObjectInfo(obj.cObj, IG3D_POSITION))
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_POSITION, getCameraInfo(IG3D_POSITION))
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_SAMPLE, "Data/Sounds/zombie_yes.ogg")
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_LOOP, false)
	setSound_emitterInfo(obj.voiceSndEmt, IG3D_START)
end


function udg_play_zombie_impossible_sound(obj)
	obj.nextSoundTime=time()+0.5
	setSound_emitterInfo(gGlobalSoundEmitter, IG3D_STOP)
	setSound_emitterInfo(gGlobalSoundEmitter, IG3D_PITCH, 100)
	local x,y,z=getCameraInfo(IG3D_POSITION)
	setSound_emitterInfo(gGlobalSoundEmitter, IG3D_POSITION, x,y+1,z)
	setSound_emitterInfo(gGlobalSoundEmitter, IG3D_SAMPLE, "Data/Sounds/no_way.ogg")
	setSound_emitterInfo(gGlobalSoundEmitter, IG3D_LOOP, false)
	setSound_emitterInfo(gGlobalSoundEmitter, IG3D_START)
end

gZombieIdleSamples={"Data/Sounds/zombie_idle1.ogg","Data/Sounds/zombie_idle2.ogg","Data/Sounds/zombie_idle3.ogg","Data/Sounds/zombie_idle4.ogg"}
function udg_play_zombie_idle_sound(obj)

		obj.nextSoundTime=time()+0.5

	
	if time()>obj.nextSoundTime then
		setSound_emitterInfo(obj.voiceSndEmt, IG3D_STOP)
		udg_set_gender_specific_pitch(obj)
		setSound_emitterInfo(obj.voiceSndEmt, IG3D_POSITION, getObjectInfo(obj.cObj, IG3D_POSITION))
		setSound_emitterInfo(obj.voiceSndEmt, IG3D_SAMPLE, gZombieIdleSamples[math.random(1,#gZombieIdleSamples)])
		setSound_emitterInfo(obj.voiceSndEmt, IG3D_LOOP, false)
		setSound_emitterInfo(obj.voiceSndEmt, IG3D_START)
		obj.nextSoundTime=time()+3.0+math.random()*15.0
	end
end


function udg_play_footsteps_sound(obj)
	if obj.health>0 and time()>obj.nextSoundTime then
	if obj.anim.name=="Walk" and not obj.isWalking then
		obj.isWalking=true
		obj.isRunning=false
		--setSound_emitterInfo(obj.noiseSndEmt, IG3D_STOP)
		--setSound_emitterInfo(obj.noiseSndEmt, IG3D_POSITION, getObjectInfo(obj.cObj, IG3D_POSITION))
		--setSound_emitterInfo(obj.noiseSndEmt, IG3D_SAMPLE, "Data/Sounds/footsteps_walk.ogg")
		--setSound_emitterInfo(obj.noiseSndEmt, IG3D_LOOP, true)
		--setSound_emitterInfo(obj.noiseSndEmt, IG3D_START)
	end
	
	if obj.anim.name=="Run" and not obj.isRunning and gNumFootstepSounds<3 then
		obj.isWalking=false
		obj.isRunning=true
		setSound_emitterInfo(obj.noiseSndEmt, IG3D_STOP)
		setSound_emitterInfo(obj.noiseSndEmt, IG3D_POSITION, getObjectInfo(obj.cObj, IG3D_POSITION))
		setSound_emitterInfo(obj.noiseSndEmt, IG3D_SAMPLE, "Data/Sounds/footsteps_run.ogg")
		setSound_emitterInfo(obj.noiseSndEmt, IG3D_LOOP, true)
		setSound_emitterInfo(obj.noiseSndEmt, IG3D_START)
		gNumFootstepSounds=gNumFootstepSounds+1
	end
	
	end
	
	if obj.anim.name~="Run" and obj.anim.name~="Walk" then
		obj.isWalking=false
		obj.isRunning=false
		local smpl=getSound_emitterInfo(obj.noiseSndEmt, IG3D_SAMPLE)
		if smpl=="Data/Sounds/footsteps_walk.ogg" or smpl=="Data/Sounds/footsteps_run.ogg" then
			if not getSound_emitterInfo(obj.noiseSndEmt, IG3D_STOP) then 
				gNumFootstepSounds=gNumFootstepSounds-1
				setSound_emitterInfo(obj.noiseSndEmt, IG3D_STOP)
			end
		end
	end
end

function udg_all_sounds_stop()
	for i=1,#gObjects,1 do
		if gObjects[i].noiseSndEmt then setSound_emitterInfo(gObjects[i].noiseSndEmt, IG3D_STOP) end
		if gObjects[i].voiceSndEmt then setSound_emitterInfo(gObjects[i].voiceSndEmt, IG3D_STOP) end
	end
	if gUDGMusic then setSound_emitterInfo(gUDGMusic, IG3D_STOP) end
	if gUDGMusicAction then setSound_emitterInfo(gUDGMusicAction, IG3D_STOP) end
end
