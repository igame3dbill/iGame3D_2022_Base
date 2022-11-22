gPlayer=gObjects[1]
gPlayer.speed=10
gPlayer.lives=3
gStatusText=gTextboxes[1]
gStartTime=nil

for i=1,#gObjects,1 do
	setObjectInfo(gObjects[i].cObj, IG3D_GRAVITY_MULTIPLIER, 1)
	setObjectInfo(gObjects[i].cObj, IG3D_COLLBOX_MULTIPLIERS, 0.5,1,0.5)
end
gArrow=gObjects[get(ig3d_object, "arrow1")]

function handle_player_movement()
	local moveNorth=false
	local moveEast=false
	local moveSouth=false
	local moveWest=false
	
	
	if northControlDown("-") then
		moveNorth=true
	end
	
	if southControlDown("-") then
		moveSouth=true
	end
	
	if eastControlDown("-") then
		moveEast=true
	end
	
	if westControlDown("-") then
		moveWest=true
	end
	
	local velx=0
	local vely=0
	local velz=0
	if moveNorth then
		velz=velz+gPlayer.speed
	end
	if moveSouth then
		velz=velz-gPlayer.speed
	end
	if moveEast then
		velx=velx-gPlayer.speed
	end
	if moveWest then
		velx=velx+gPlayer.speed
	end
	
	local vx,vy,vz=getObjectInfo(gPlayer.cObj, IG3D_VELOCITY)
	setObjectInfo(gPlayer.cObj, IG3D_VELOCITY, velx,math.min(vely,0),velz)
	setObjectInfo(gPlayer.cObj, IG3D_OMEGA, 0,0,0)
	setObjectInfo(gPlayer.cObj, IG3D_ROTATION, 0,0,0)
	if velx+vely+velz~=0 then
		
		--setObjectInfo(gPlayer.cObj, IG3D_ROTATION, dirToAngles(velx,vely,velz))
	end

end

function handle_textboxes()
	local roadText=getNearestRoad(getObjectInfo(gPlayer.cObj, IG3D_POSITION)).name
	local timeText= getTimeLeftString()
	local lettersText = getLettersString()
	local powerUpsText= getPowerUpsString()
	setText_boxInfo(gStatusText, IG3D_TEXT, roadText.."\n"..timeText.."\n"..lettersText.."\n"..powerUpsText)
	drawLetterAdressTextboxes()
	drawControlsTextboxes()
end

function handle_camera()
	--local cx,cy,cz=getCameraInfo(IG3D_POSITION)
	local px,py,pz=getObjectInfo(gPlayer.cObj, IG3D_POSITION)
	setCameraInfo(IG3D_POSITION, px,py+10,pz)
	setCameraInfo(IG3D_ROTATION, 90,0,0)
end

function handle_arrow()
	local px,py,pz=getObjectInfo(gPlayer.cObj, IG3D_POSITION)
	local lx,ly,lz
	local nearestLetter=1
	if #gLetters > 0 then
		local dst=-1
		for i=1,#gLetters,1 do
			lx,ly,lz= computeLetterAddressPosition(gLetters[i])
			if dst== -1 or vecLength(px-lx, py-ly, pz-lz)<dst then
				nearestLetter=i
				dst=vecLength(px-lx, py-ly, pz-lz)
			end
		end	
	end
	lx,ly,lz= computeLetterAddressPosition(gLetters[nearestLetter])
	
	setObjectInfo(gArrow.cObj, IG3D_ROTATION, dirToAngles(lx-px, 0, lz-pz))
	setObjectInfo(gArrow.cObj, IG3D_POSITION, px,py+7,pz+0.5)
end

function handle_postman_won()
	setText_boxInfo(gTextboxes[1], IG3D_TEXT, "Alle Briefe verteilt!\nSaubere Arbeit! Klicken zum Fortfahren...")
	for i=2,gNumTextboxes,1 do
		setText_boxInfo(gTextboxes[i], IG3D_TEXT, "")
	end
	if click("n") then
		loadLevel("Data/Levels/Postman")
	end
end

function handle_postman_lost()
	setText_boxInfo(gTextboxes[1], IG3D_TEXT, "Du Versager hast es nicht geschafft,\ndie Post auszutragen! Klicken zum Wiederholen...")
	for i=2,gNumTextboxes,1 do
		setText_boxInfo(gTextboxes[i], IG3D_TEXT, "")
	end
	if click("n") then
		loadLevel("Data/Levels/Postman")
	end
end

function handle_game_status()
	if gTimer.timeLeft<=0 and #gLetters>0 then
		game_func=handle_postman_lost
	end
	
	if gTimer.timeLeft>0 and #gLetters==0 then
		game_func=handle_postman_won
	end
end




function handle_postman_game()
	handle_player_movement()
	handle_camera()
	handle_letter_distribution()
	handle_grandmas()
	handle_textboxes()
	handle_timer()
	handle_powerups()
	handle_game_status()
	handle_arrow()
	fltk_update()
end

function handle_getready_postman_game()
	if not gStartTime then gStartTime=time()+5 end
	setText_boxInfo(gTextboxes[1], IG3D_TEXT, "Mach dich bereit, das Spiel beginnt in "..tostring(math.floor(gStartTime-time())).." Sekunden...")
	setObjectInfo(gArrow.cObj, IG3D_POSITION, 5000,5000,5000)
	if time()>gStartTime then
		game_func=handle_postman_game
	end
	fltk_update()
end


