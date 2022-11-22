if ig3d_GetLevelName__s()~="Data/Levels/UDG/UDG_MainMenu" then
	if gUDGMusic then setSound_emitterInfo(gUDGMusic, IG3D_STOP) end
end
if not gUDGMusic then gUDGMusic=assign_free_sound_emitter() end

--gSongs={"Data/Sounds/drivingrock.ogg","Data/Sounds/marcokittel_track.ogg","Data/Sounds/intenserock.ogg"}

gSongs={"Data/Sounds/action_track.ogg","Data/Sounds/marcokittel_track.ogg","Data/Sounds/sanctuary.ogg","Data/Sounds/intenserock.ogg","Data/Sounds/drivingrock.ogg"}
gActionSongs={"Data/Sounds/intenserock.ogg"}-- action_track.ogg"}

gMusicOn=true
gNextPossibleMusicChange =time()
gUDGMusicAction=assign_free_sound_emitter()
gActionMan=nil
gUDGActionMusicVolume=0

for i=1,#gSongs,1 do
	loadSound(gSongs[i])
end

if ig3d_GetLevelName__s()~= "Data/Levels/UDG/UDG/MainMenu" then
	setSound_emitterInfo(gUDGMusic, IG3D_STOP)
	setSound_emitterInfo(gUDGMusic, IG3D_SAMPLE, "Data/Sounds/marcokittel_track.ogg")
end
setSound_emitterInfo(gUDGMusicAction, IG3D_SAMPLE, gActionSongs[math.random(1,#gActionSongs)])

function udg_handle_music()
	if gUDGMusic and gMusicOn then
		
		--keep the music playing
		if getSound_emitterInfo(gUDGMusic, IG3D_STOP) then
			setSound_emitterInfo(gUDGMusic, IG3D_START)
		end
		
		
		if getSound_emitterInfo(gUDGMusicAction, IG3D_STOP) then
			setSound_emitterInfo(gUDGMusicAction, IG3D_START)
		end
		
		rts_update_living_and_dead_counts()
		
		if gNumHumans==0 and gNumZombies>0 and getSound_emitterInfo(gUDGMusic, IG3D_SAMPLE)~="Data/Sounds/drivingrock.ogg" then
			setSound_emitterInfo(gUDGMusic, IG3D_STOP)
			setSound_emitterInfo(gUDGMusic, IG3D_SAMPLE, "Data/Sounds/drivingrock.ogg")
			setSound_emitterInfo(gUDGMusic, IG3D_START)
		end
		
		if gNumZombies==0 and gNumHumans>0 and getSound_emitterInfo(gUDGMusic, IG3D_SAMPLE)~="Data/Sounds/sanctuary.ogg" then
			setSound_emitterInfo(gUDGMusic, IG3D_STOP)
			setSound_emitterInfo(gUDGMusic, IG3D_SAMPLE, "Data/Sounds/sanctuary.ogg")
			setSound_emitterInfo(gUDGMusic, IG3D_START)
		end
		
		if udg_there_are_rushers() then
			if gUDGActionMusicVolume~=100 then
				gUDGActionMusicVolume=100
				setSound_emitterInfo(gUDGMusicAction, IG3D_STOP)
				setSound_emitterInfo(gUDGMusicAction, IG3D_START)
			end
		else
			gUDGActionMusicVolume= math.max(gUDGActionMusicVolume-passed()*30,0)
		end
		
		
			
		
		
		
		--setSound_emitterInfo(gUDGMusic, IG3D_VOLUME, math.max(gUDGMainMusicVolume-gMusicPenalty,0))
		setSound_emitterInfo(gUDGMusicAction, IG3D_VOLUME, gUDGActionMusicVolume)
		setSound_emitterInfo(gUDGMusic, IG3D_VOLUME, 100-gUDGActionMusicVolume -30)
		
		setSound_emitterInfo(gUDGMusic, IG3D_POSITION, getCameraInfo(IG3D_POSITION))
		setSound_emitterInfo(gUDGMusicAction, IG3D_POSITION, getCameraInfo(IG3D_POSITION))
	end
end


function udg_there_are_rushers()
	--case 1: A human has just sighted zombies (remember that guy as gActionMan)
	
	for i=1,#gObjects,1 do
		if gObjects[i].team==1 and gObjects[i].behaviour==zombie_rush_behaviour and gObjects[i].alive then
			return true
		end
	end
	return false
end

function udg_lots_of_action_happening()
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