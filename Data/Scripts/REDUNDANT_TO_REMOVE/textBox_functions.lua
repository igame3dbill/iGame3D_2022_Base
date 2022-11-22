tFontSize=24 ;-- bug  somewhere 10/22/2008 ?
function displayText(winx,winy,winz,boxnumber,charcount,fontsize,fontleading,leadingmod,indentmod,tText)
x,y,z=getSceneInfo(IG3D_WINDOW_COORDS, winx, winy, winz)
textX=x-charcount+(indentmod)
textY=winy-(0.12*y)+(boxnumber*(fontleading+leadingmod))
setText_boxInfo(boxes[boxnumber], IG3D_POSITION, textX , textY)
setText_boxInfo(boxes[boxnumber], IG3D_SIZE, fontsize)
setText_boxInfo(boxes[boxnumber], IG3D_TEXT, tText)
end


function resetTextBoxes()
for i=1,gNumBoxes,1 do
setText_boxInfo(i, IG3D_COLOR, gTextRed,gTextGreen,gTextBlue,gTextAlpha)
setText_boxInfo(i, IG3D_FONT, "Data/FontPngs/default32_1.png")
end
end




function titleMenu()
colorcyclebackground()
if load== false then
glw,glh=GlRect("w,h")
adjustFontSize()
if gFourView==false then
gFontSize=(glh/((gNumBoxes)*2))+FontSizeMod
textRowBase=6
else
gFontSize=(glh/((gNumBoxes)*4))+FontSizeMod 
textRowBase=-6
end
--gFontLeading=gFontSize+(gFontSize*0.0187)
for i=1,gNumBoxes,1 do
tFontSize = getText_boxInfo(boxes[i], IG3D_SIZE)
if tFontSize == nil then return end
gFontLeading=tFontSize+(tFontSize*0.0187)
textColumn=textColumn+textColumnMod
if textColumn<-12.5 then textColumnMod=0.0003 end
if textColumn>2 then textColumnMod=-0.0003 end

textRowMod=(math.sin(textColumn))*1.5
textRow=textRowBase-textRowMod+(i*2)
textIndent=textRowMod*i

displayText(textColumn,textRow,-10,i,(#labels[i]),tFontSize,gFontLeading,1.0128,textIndent,labels[i])
--if i~=gSelBox then
--setText_boxInfo(boxes[i], IG3D_COLOR, 1.0,1.0,1.0,1)
--end
end
else
if clickedLevel~=nil then 
load=false

loadLevel(clickedLevel)
 end
end

if click("n") then
mouseX,mouseY=mouseCoords()
gSelBox=0
clickedLevel=""
for i=1,gNumBoxes,1 do
boxLeft,boxTop,boxRight,boxBottom=getText_boxInfo(boxes[i], IG3D_BOUNDS)

if mouseInBox(boxLeft,boxTop, boxRight,boxBottom, mouseX,mouseY) then
setText_boxInfo(boxes[i], IG3D_COLOR, 1,0,0,1)

gSelBox=i;
if levels[gSelBox]~= ""  then
clickedLevel = "Data/Levels/"..levels[gSelBox];
--startScript = gameroot.."Data/Levels/"..levels[gSelBox].."/load script.lua";
load=true;
end 
end
end
end
end
-----------END--TITLEMENU


 
function titleWait()
default_escapekey()
 cx,cy,cz=getCameraInfo(IG3D_POSITION)
 titleMenu()
-- camera_faceObj(square1) end
 fltk_update()
end
----------------------------
function labels_folders(whatPath,stripChars,tFont)
folders=ListFolder(whatPath,"t")
numberOfFolders=#folders
newLabel = folders[i]
levels[i]= newLabel
if stripChars ~= nil then  newLabel  = string.sub(newLabel,string.len(stripChars)+1,-1) end
labels[i]=newLabel
end


function textBox_folders(whatPath,stripChars,tFont)
if tFont == nil then tFont = gDefaultFontA end
levelBoxes=0
if gTextboxes == nil then
gTextboxes={}
gTextboxPositions={}
gTextboxSizes={}
gTextboxColors={}
end
if gTextboxFonts== nil then gTextboxFonts={"Data/FontPngs/default32_1.png"} end
folders=ListFolder(whatPath,"t")
numberOfFolders=#folders

for i=1,numberOfFolders,1 do
boxes[i]=make(ig3d_text_box, tFont)

setText_boxInfo(boxes[i], IG3D_COLOR, 1.0,1.0,1.0,1)
setText_boxInfo(boxes[i], IG3D_SIZE, gFontSize)
newLabel = folders[i]
levels[i]= newLabel
if stripChars ~= nil then  newLabel  = string.sub(newLabel,string.len(stripChars)+1,-1) end
labels[i]=newLabel
--if string.find(whatPath,gameroot.."Data/Levels/") then
 
--end
end
gNumBoxes=numberOfFolders
end --textBox_folders





function TextBox_Levels_Menu()
--setSceneInfo(IG3D_BACKGROUND_COLOR, 0,0,0)
--makedefaultSquare()
if gEditingMode~="lookaround" then facetitles() end
textColumn=-12
textColumnMod=0.0003
textRow=-6
FontSizeMod=0
textBox_folders((gameroot.."Data/Levels/"))
for i = 1,#boxes,1 do
table.insert(gTextboxes,boxes[i])
end
if game_func ~= nil then
titleWait();
else
game_func = titleWait
end
edit_func = default_escapekey
ig3d_SetMode_i(4)  --- play game!
end



function useFont(aFont)
fontpath="Data/FontPngs/"
fontexists=false
for file in lfs.dir(gameroot..fontpath) do
if file == aFont.."32_1.png" then fontexists=true end
end
if fontexists==true then 
gDefaultFontA=fontpath..aFont.."32_1.png"
gDefaultFontB=fontpath..aFont.."32_2.png"
loadTexture(gDefaultFontA)
loadTexture(gDefaultFontB)
loadFont(gDefaultFontA, gDefaultFontB)
for i=1,#boxes,1 do
setText_boxInfo(boxes[i], IG3D_FONT, gDefaultFontA)
end
else
print("no such font"..fontpath..aFont.."32_1.png")
end
end

function toggleText(viewstatus,n)
	if viewstatus ~= nil then
	showFonts = viewstatus
	else

		if showFonts ~= nil then 
		showFonts = not showFonts 
		viewstatus = showFonts
		else
		viewstatus = true 
		showFonts = viewstatus
		end
	end

	if showFonts == false then 
	offsetYtext= 10000
	else
	offsetYtext = -10000
	end	
if n == nil then n=0 end
	if n > 1 then 
    textX , textY = getText_boxInfo(boxes[n], IG3D_POSITION);
	setText_boxInfo(boxes[n], IG3D_POSITION, textX , (textY+offsetYtext));
	else
		for i=1,#boxes,1 do
		textX , textY = getText_boxInfo(boxes[i], IG3D_POSITION);
		setText_boxInfo(boxes[i], IG3D_POSITION, textX , (textY+offsetYtext));
		end
	end
	
end --togglefonts
showFonts=true

