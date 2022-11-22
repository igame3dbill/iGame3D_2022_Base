gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"},{"Data/FontPngs/Shlop32_1.png","Data/FontPngs/Shlop32_2.png"},{"Data/FontPngs/CRAMPS32_1.png","Data/FontPngs/CRAMPS32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end

gTextboxFonts={"Data/FontPngs/default32_1.png","Data/FontPngs/default32_1.png","Data/FontPngs/Shlop32_1.png","Data/FontPngs/CRAMPS32_1.png"}
gTextboxPositions={}
gTextboxSizes={}
gTextboxColors={}
gDebugOutput=false

for i =1,5,1 do 
table.insert(gTextboxFonts,"Data/FontPngs/Shlop32_1.png")
table.insert(gTextboxFonts,"Data/FontPngs/CRAMPS32_1.png")
table.insert(gTextboxPositions,{50,12*i})
table.insert(gTextboxPositions,{50,24*i})
table.insert(gTextboxPositions,{50,36*i})
table.insert(gTextboxSizes,12)
table.insert(gTextboxSizes,12)
table.insert(gTextboxSizes,12)
table.insert(gTextboxColors, {math.random(0,1), math.random(0,1), math.random(0,1)})
table.insert(gTextboxColors, {math.random(0,1), math.random(0,1), math.random(0,1)})
table.insert(gTextboxColors, {math.random(0,1), math.random(0,1), math.random(0,1)})
end
gTextboxes={}

for i=1,#gTextboxFonts,1 do
	gTextboxes[i]=make(ig3d_text_box, gTextboxFonts[i])
	setText_boxInfo(gTextboxes[i], IG3D_POSITION, gTextboxPositions[i][1],gTextboxPositions[i][2])
	setText_boxInfo(gTextboxes[i], IG3D_SIZE, gTextboxSizes[i])
	setText_boxInfo(gTextboxes[i], IG3D_COLOR, gTextboxColors[i][1],gTextboxColors[i][2],gTextboxColors[i][3], gTextboxColors[i][4])
end
gNumTextboxes=#gTextboxFonts



function zfps_clear_textboxes()
for i=1,#gTextboxFonts,1 do
	gTextboxes[i]=make(ig3d_text_box, gTextboxFonts[i])
	setText_boxInfo(gTextboxes[i], IG3D_TEXT, "")
	end
end


function center_text_box(tb)
	local left,top,right,bottom=ig3d_GetWindowBounds__4i()
	setText_boxInfo(tb, IG3D_SIZE, (right-left)/20)
	local left2,top2,right2,bottom2=getText_boxInfo(tb, IG3D_BOUNDS)
	local boffsetx=0.5*(right2-left2)
	local boffsety=0.5*(bottom2-top2)
	local wcenterx=0.5*(right-left)
	local wcentery=0.5*(bottom-top)
	setText_boxInfo(tb, IG3D_POSITION, wcenterx-boffsetx, wcentery-boffsety)
end

function zfps_showControlsWindow(boxn)
	local left,top,right,bottom=ig3d_GetWindowBounds__4i()
	setText_boxInfo(boxn, IG3D_TEXT, gControlsScreenText)
	setText_boxInfo(boxn, IG3D_SIZE,(right-left)/50)
	local left2,top2,right2,bottom2=getText_boxInfo(boxn, IG3D_BOUNDS)
	local boffsetx=0.5*(right2-left2)
	local boffsety=0.5*(bottom2-top2)
	local wcenterx=0.5*(right-left)
	local wcentery=0.5*(bottom-top)
	setText_boxInfo(boxn, IG3D_COLOR, 1,0,0,1)
	setText_boxInfo(boxn, IG3D_POSITION, wcenterx-boffsetx, wcentery-boffsety)
	setText_boxInfo(boxn, IG3D_FONT, "Data/FontPngs/default32_1.png")
end


lastTexti = 0
currentText = nil
textalphamult=1
textalpha=0

function zfps_display_levelText(boxn,fontn)
if currentText == nil then return end
if currentText < 1 then return end

if passed()>2 then return end

if textalpha>2.5 then
	textalphamult=textalphamult*-1
end


if textalpha < -0.1 then
	currentText=currentText+1
	textalphamult=textalphamult*-1
	if currentText>#levelText then
		currentText=nil
		setText_boxInfo(boxn, IG3D_TEXT, "")
		return
	end
end

textalpha = textalpha +passed()* textalphamult


local x,y = 50,350
local r,g,b = 1,0,0
local font = gTextboxFonts[fontn]
local tText = levelText[currentText][2]
local size = 22
gSelectedTextBoxNum = boxn
ig3d_SetTextboxInfo_4i4f2s(gSelectedTextBoxNum,size,x,y,r,g,b,textalpha,font,"\n\n\n\n\n"..tText)
local left,top,right,bottom=ig3d_GetWindowBounds__4i()
	--setText_boxInfo(tb, IG3D_SIZE, (right-left)/20)
	local left2,top2,right2,bottom2=getText_boxInfo(boxn, IG3D_BOUNDS)
	local boffsetx=0.5*(right2-left2)
	local boffsety=0.5*(bottom2-top2)
	local wcenterx=0.5*(right-left)
	local wcentery=0.5*(bottom-top)
	setText_boxInfo(boxn, IG3D_POSITION, wcenterx-boffsetx, wcentery-boffsety)
	setText_boxInfo(boxn,IG3D_TEXT,"\n\n\n\n\n\n\n\n"..tText)
end


function zfps_display_FPS()

setText_boxInfo(RTS_console, IG3D_POSITION, 8,8)
if gHideHUD==true then setText_boxInfo(RTS_console, IG3D_POSITION, -800,8) end
setText_boxInfo(RTS_console, IG3D_COLOR, 1,1,1,1)
setText_boxInfo(RTS_console, IG3D_SIZE, 12)
setText_boxInfo(RTS_console, IG3D_TEXT, "")
if gDebugOutput then
	local fps=getSceneInfo(IG3D_FPS)
	RTS_print(fps)
	RTS_print(getSceneInfo(IG3D_DRAWN_FACES))
end
	RTS_print(gStatusString)	
end



function showLevelLoading(tLevel,state)
setText_boxInfo(gTextboxes[1], IG3D_TEXT, tLevel.."\nLoading\n"..state) 
setText_boxInfo(gTextboxes[1], IG3D_SIZE, 24) 
setText_boxInfo(gTextboxes[1], IG3D_FONT, gTextboxFonts[3]) 
setText_boxInfo(gTextboxes[1], IG3D_POSITION, 40) 
setText_boxInfo(gTextboxes[1], IG3D_COLOR, 1,0,0) 
render()
end



function init_loading_textbox()

table.insert(gFontFiles,{"Data/FontPngs/Shlop32_1.png","Data/FontPngs/Shlop32_2.png"})
loadFont(gFontFiles[#gFontFiles][1],gFontFiles[#gFontFiles][2])
table.insert(gTextboxFonts,"Data/FontPngs/Shlop32_1.png")
gNumTextboxes=#gTextboxFonts
local i = #gTextboxFonts
---dirty hack..... get rid of last item in the tables
table.remove(gTextboxPositions)
table.remove(gTextboxSizes)
table.remove(gTextboxColors)
--
table.insert(gTextboxPositions,{612,394})
table.insert(gTextboxSizes,73)
table.insert(gTextboxColors,{0.500000,0.200000,0.200000,1.000000})
table.insert(gTextboxes, make(ig3d_text_box, gTextboxFonts[i]))
gLoadingTextBoxNum = #gTextboxes -- ?? dirty hack

end


function zfps_loading_text(tText)
gHideHUD=true
if not gLoadingTextBoxNum then gLoadingTextBoxNum=1 end
local i =gLoadingTextBoxNum
setText_boxInfo(gTextboxes[i], IG3D_TEXT, tText)
setText_boxInfo(gTextboxes[i], IG3D_COLOR, 1.0,0.0,0.0,1.0)
center_text_box(gTextboxes[i])

gTimeBeforeLoad=0
render()
end
init_loading_textbox()
