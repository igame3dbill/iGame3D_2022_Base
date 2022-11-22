gLetters={}

--Lass uns ein paar Briefe generieren
howManyLetters=30
for i=1,howManyLetters,1 do
	rd=gRoads[math.random(1,#gRoads)];
	newLetter={road=rd, number=math.random(1,rd.numAddresses)}
	table.insert(gLetters, newLetter)
end

--Wir brauchen wahrscheinlich mehr Textboxes für die Adressen
while #gTextboxes<#gLetters+1 do
	gNumTextboxes=gNumTextboxes+1
	gTextboxes[gNumTextboxes]=make(ig3d_text_box, gTextboxFonts[1])
	setText_boxInfo(gTextboxes[gNumTextboxes], IG3D_POSITION, 0,0)
	setText_boxInfo(gTextboxes[gNumTextboxes], IG3D_SIZE, 14)
	setText_boxInfo(gTextboxes[gNumTextboxes], IG3D_COLOR, 1,1,1,1)
end


function getLettersString()
	if #gLetters==1 then
		return "Noch einen Brief zu verteilen"
	else
		if #gLetters==0 then
			return "Alle Breife verteilt. Super gemacht!"
		else
			return "Noch "..tostring(#gLetters).." Briefe zu verteilen"
		end
	end
end

function handle_letter_distribution()
	local px,py,pz=getObjectInfo(gPlayer.cObj, IG3D_POSITION)
	for i=1,#gLetters,1 do
		local lx,ly,lz=computeLetterAddressPosition(gLetters[i])
		if vecLength(lx-px,0,lz-pz)<2 then
			table.remove(gLetters, i)
			return
		end
	end
end

function computeLetterAddressPosition(letter)
	local x,y,z
	y=0
	if letter.road.type==1 then
		z=letter.road.offset
		x=letter.road.startCoord+((letter.road.endCoord-letter.road.startCoord)/letter.road.numAddresses)*(letter.number-0.5)	
	end
	if letter.road.type==2 then
		x=letter.road.offset
		z=letter.road.startCoord+((letter.road.endCoord-letter.road.startCoord)/letter.road.numAddresses)*(letter.number-0.5)	
	end
	return x,y,z
end

function drawLetterAdressTextboxes()
	for i=2,gNumTextboxes,1 do
		setText_boxInfo(gTextboxes[i], IG3D_TEXT, "")
	end
	for i=1,#gLetters,1 do
		local lx,ly,lz=computeLetterAddressPosition(gLetters[i])
		local wx,wy,wz=getSceneInfo(IG3D_WINDOW_COORDS, lx,ly,lz)

		setText_boxInfo(gTextboxes[i+1], IG3D_POSITION, wx,wy)
		setText_boxInfo(gTextboxes[i+1], IG3D_TEXT, gLetters[i].road.name.." "..tostring(gLetters[i].number))
	end
end