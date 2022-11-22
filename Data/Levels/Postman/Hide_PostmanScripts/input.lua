--Wir brauchen wahrscheinlich mehr Textboxes für die Adressen
while #gTextboxes<#gLetters+5 do
	gNumTextboxes=gNumTextboxes+1
	gTextboxes[gNumTextboxes]=make(ig3d_text_box, gTextboxFonts[2])
end
northArrow=gTextboxes[gNumTextboxes-3]
southArrow=gTextboxes[gNumTextboxes-2]
eastArrow=gTextboxes[gNumTextboxes-1]
westArrow=gTextboxes[gNumTextboxes]
setText_boxInfo(northArrow, IG3D_FONT, "Data/FontPngs/iphonecarsprites32_1.png")
setText_boxInfo(southArrow, IG3D_FONT, "Data/FontPngs/iphonecarsprites32_1.png")
setText_boxInfo(eastArrow, IG3D_FONT, "Data/FontPngs/iphonecarsprites32_1.png")
setText_boxInfo(westArrow, IG3D_FONT, "Data/FontPngs/iphonecarsprites32_1.png")
setText_boxInfo(northArrow, IG3D_SIZE, 32)
setText_boxInfo(southArrow, IG3D_SIZE, 32)
setText_boxInfo(eastArrow, IG3D_SIZE, 32)
setText_boxInfo(westArrow, IG3D_SIZE, 32)


function northControlDown(s)
	if gNativeOS=="iphone" then
		for j=1,16,1 do
			if touch(s,j) then
				a,b,c,d,e,f=getSceneInfo(IG3D_TOUCH_LINE,j)
				g,h,i=getSceneInfo(IG3D_WINDOW_COORDS, d,e,f)
				boxLeft,boxTop,boxRight,boxBottom=getText_boxInfo(northArrow, IG3D_BOUNDS)
				if mouseInBox(boxLeft-30,boxTop-30, boxRight+30,boxBottom+30, g,h) then
					return true
				end
			end
		end
	end
	
	if gNativeOS~="iphone" then
		return key("w",s)
	end
	
	return false
end

function southControlDown(s)
	if gNativeOS=="iphone" then
		for j=1,16,1 do
			if touch(s,j) then
				a,b,c,d,e,f=getSceneInfo(IG3D_TOUCH_LINE,j)
				g,h,i=getSceneInfo(IG3D_WINDOW_COORDS, d,e,f)
				boxLeft,boxTop,boxRight,boxBottom=getText_boxInfo(southArrow, IG3D_BOUNDS)
				if mouseInBox(boxLeft-30,boxTop-30, boxRight+30,boxBottom+30, g,h) then
					return true
				end
			end
		end
	end
	
	if gNativeOS~="iphone" then
		return key("s",s)
	end
	
	return false
end

function eastControlDown(s)
	if gNativeOS=="iphone" then
		for j=1,16,1 do
			if touch(s,j) then
				a,b,c,d,e,f=getSceneInfo(IG3D_TOUCH_LINE,j)
				g,h,i=getSceneInfo(IG3D_WINDOW_COORDS, d,e,f)
				boxLeft,boxTop,boxRight,boxBottom=getText_boxInfo(eastArrow, IG3D_BOUNDS)
				if mouseInBox(boxLeft-30,boxTop-30, boxRight+30,boxBottom+30, g,h) then
					return true
				end
			end
		end
	end
	
	if gNativeOS~="iphone" then
		return key("d",s)
	end
	
	return false
end

function westControlDown(s)
	if gNativeOS=="iphone" then
		for j=1,16,1 do
			if touch(s,j) then
				a,b,c,d,e,f=getSceneInfo(IG3D_TOUCH_LINE,j)
				g,h,i=getSceneInfo(IG3D_WINDOW_COORDS, d,e,f)
				boxLeft,boxTop,boxRight,boxBottom=getText_boxInfo(westArrow, IG3D_BOUNDS)
				if mouseInBox(boxLeft-30,boxTop-30, boxRight+30,boxBottom+30, g,h) then
					return true
				end
			end
		end
	end
	
	if gNativeOS~="iphone" then
		return key("a",s)
	end
	
	return false
end


function drawControlsTextboxes()
	
	a,b,c,d=ig3d_GetWindowBounds__4i()
	setText_boxInfo(northArrow, IG3D_TEXT, "a")
	setText_boxInfo(northArrow, IG3D_POSITION, a+(c-a)/2, 15)
	setText_boxInfo(northArrow, IG3D_COLOR, 1,1,1,1)
	setText_boxInfo(southArrow, IG3D_TEXT, "b")
	setText_boxInfo(southArrow, IG3D_POSITION, a+(c-a)/2, d-55)
	setText_boxInfo(southArrow, IG3D_COLOR, 1,1,1,1)
	setText_boxInfo(eastArrow, IG3D_TEXT, "e")
	setText_boxInfo(eastArrow, IG3D_POSITION, c-55, b+(d-b)/2)
	setText_boxInfo(eastArrow, IG3D_COLOR, 1,1,1,1)
	setText_boxInfo(westArrow, IG3D_TEXT, "f")
	setText_boxInfo(westArrow, IG3D_POSITION, 15, b+(d-b)/2)
	setText_boxInfo(westArrow, IG3D_COLOR, 1,1,1,1)
	
	if northControlDown("-") then
		setText_boxInfo(northArrow, IG3D_COLOR, 0,1,0,1)
	end
	
	if southControlDown("-") then
		setText_boxInfo(southArrow, IG3D_COLOR, 0,1,0,1)
	end
	
	if eastControlDown("-") then
		setText_boxInfo(eastArrow, IG3D_COLOR, 0,1,0,1)
	end
	
	if westControlDown("-") then
		setText_boxInfo(westArrow, IG3D_COLOR, 0,1,0,1)
	end
end
