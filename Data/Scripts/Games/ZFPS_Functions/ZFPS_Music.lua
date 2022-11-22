if ig3d_GetLevelName__s()~="Data/Levels/ZFPS/ZFPS_MainMenu" then
	if gZFPSMusic then setSound_emitterInfo(gZFPSMusic, IG3D_STOP) end
end
if not gZFPSMusic then gZFPSMusic=assign_free_sound_emitter() end

--gSongs={"Data/Sounds/drivingrock.ogg","Data/Sounds/marcokittel_track.ogg","Data/Sounds/intenserock.ogg"}

gSongs={"Data/Sounds/action_track.ogg","Data/Sounds/marcokittel_track.ogg","Data/Sounds/sanctuary.ogg","Data/Sounds/intenserock.ogg","Data/Sounds/drivingrock.ogg"}
gActionSongs={"Data/Sounds/intenserock.ogg"}-- action_track.ogg"}

gMusicOn=true
gNextPossibleMusicChange =time()
gZFPSMusicAction=assign_free_sound_emitter()
gActionMan=nil
gZFPSActionMusicVolume=0

for i=1,#gSongs,1 do
	loadSound(gSongs[i])
end

if ig3d_GetLevelName__s()~= "Data/Levels/ZFPS/ZFPS/MainMenu" then
	setSound_emitterInfo(gZFPSMusic, IG3D_STOP)
	setSound_emitterInfo(gZFPSMusic, IG3D_SAMPLE, "Data/Sounds/marcokittel_track.ogg")
end
setSound_emitterInfo(gZFPSMusicAction, IG3D_SAMPLE, gActionSongs[math.random(1,#gActionSongs)])

function zfps_handle_music()
	if gZFPSMusic and gMusicOn then
		
		--keep the music playing
		if getSound_emitterInfo(gZFPSMusic, IG3D_STOP) then
			setSound_emitterInfo(gZFPSMusic, IG3D_START)
		end
		
		
		if getSound_emitterInfo(gZFPSMusicAction, IG3D_STOP) then
			setSound_emitterInfo(gZFPSMusicAction, IG3D_START)
		end
		
		rts_update_living_and_dead_counts()
		
		if gNumZombies==0 and gNumHumans>0 and getSound_emitterInfo(gZFPSMusic, IG3D_SAMPLE)~="Data/Sounds/drivingrock.ogg" then
			setSound_emitterInfo(gZFPSMusic, IG3D_STOP)
			setSound_emitterInfo(gZFPSMusic, IG3D_SAMPLE, "Data/Sounds/drivingrock.ogg")
			setSound_emitterInfo(gZFPSMusic, IG3D_START)
		end
		
		if (not gObjects[playerBox].alive or (gNumHumans==0 and gNumZombies>0)) and getSound_emitterInfo(gZFPSMusic, IG3D_SAMPLE)~="Data/Sounds/sanctuary.ogg" then
			setSound_emitterInfo(gZFPSMusic, IG3D_STOP)
			setSound_emitterInfo(gZFPSMusic, IG3D_SAMPLE, "Data/Sounds/sanctuary.ogg")
			setSound_emitterInfo(gZFPSMusic, IG3D_START)
		end
		
		--[[
		if zfps_there_are_rushers() then
			if gZFPSActionMusicVolume~=100 then
				gZFPSActionMusicVolume=100
				setSound_emitterInfo(gZFPSMusicAction, IG3D_STOP)
				setSound_emitterInfo(gZFPSMusicAction, IG3D_START)
			end
		else
			gZFPSActionMusicVolume= math.max(gZFPSActionMusicVolume-passed()*30,0)
		end
		--]]
		
			
		
		
		
		--setSound_emitterInfo(gZFPSMusic, IG3D_VOLUME, math.max(gZFPSMainMusicVolume-gMusicPenalty,0))
		setSound_emitterInfo(gZFPSMusicAction, IG3D_VOLUME, gZFPSActionMusicVolume)
		setSound_emitterInfo(gZFPSMusic, IG3D_VOLUME, 100-gZFPSActionMusicVolume -30)
		
		setSound_emitterInfo(gZFPSMusic, IG3D_POSITION, getCameraInfo(IG3D_POSITION))
		setSound_emitterInfo(gZFPSMusicAction, IG3D_POSITION, getCameraInfo(IG3D_POSITION))
	end
end


function zfps_there_are_rushers()
	--case 1: A human has just sighted zombies (remember that guy as gActionMan)
	
	for i=1,#gObjects,1 do
		if gObjects[i].team==1 and gObjects[i].behaviour==zombie_rush_behaviour and gObjects[i].alive then
			return true
		end
	end
	return false
end

function zfps_lots_of_action_happening()
	--case 2: Do we still have an old gActionMan??
	if gActionMan then
		if gActionMan.alive and gActionMan.team==0 then
			return true
		else
			gActionMan=nil
		end
	end

	--case 1: A human has just sighted zombies (remember that guy as gActionMan)
	
	for i=1,#gObjects,1 do
		if gObjects[i].team==0 and #gObjects[i].sensed>0 and gObjects[i].alive then
			if gObjects[i].sensed[1].team==1 and seenBefore(gObjects[i], gObjects[i].sensed[1]) then
				gActionMan=gObjects[i]
				return true
			end
		end
	end
	
	return false
end