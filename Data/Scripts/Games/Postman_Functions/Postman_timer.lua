gTimer={ duration=80, timeLeft=80 }

function getTimeLeftString()
	local minutes=math.floor(gTimer.timeLeft/60)
	local seconds=math.floor(gTimer.timeLeft-minutes*60)
	local timeString=tostring(minutes)..":"..tostring(seconds)
	if seconds==0 then
		timeString=timeString.."0"
	end
	if seconds>0 and seconds <10 then
		timeString=tostring(minutes)..":0"..tostring(seconds)
	end
	return timeString
end

function handle_timer()
	gTimer.timeLeft =gTimer.timeLeft-passed()
end