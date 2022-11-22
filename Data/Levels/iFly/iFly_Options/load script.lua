setSceneInfo(IG3D_BACKGROUND_COLOR, 0,0,0)

loadFont("Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png")
explanation=make(ig3d_text_box, "Data/FontPngs/default32_1.png")
setText_boxInfo(explanation, IG3D_POSITION, 0, 0)
setText_boxInfo(explanation, IG3D_SIZE, 12)
setText_boxInfo(explanation, IG3D_COLOR, 0.400000, 0.400000, 1.000000, 1.000000)
setText_boxInfo(explanation, IG3D_TEXT, "Click on the options to toggle.")

acc=make(ig3d_text_box, "Data/FontPngs/default32_1.png")
setText_boxInfo(acc, IG3D_POSITION, 0, 50)
setText_boxInfo(acc, IG3D_SIZE, 24)
setText_boxInfo(acc, IG3D_COLOR, 0.400000, 0.400000, 1.000000, 1.000000)
setText_boxInfo(acc, IG3D_TEXT, "Shadows: YES")

decc=make(ig3d_text_box, "Data/FontPngs/default32_1.png")
setText_boxInfo(decc, IG3D_POSITION, 0, 75)
setText_boxInfo(decc, IG3D_SIZE, 24)
setText_boxInfo(decc, IG3D_COLOR, 0.400000, 0.400000, 1.000000, 1.000000)
setText_boxInfo(decc, IG3D_TEXT, "Clouds: YES")

rollleft=make(ig3d_text_box, "Data/FontPngs/default32_1.png")
setText_boxInfo(rollleft, IG3D_POSITION, 0, 100)
setText_boxInfo(rollleft, IG3D_SIZE, 24)
setText_boxInfo(rollleft, IG3D_COLOR, 0.400000, 0.400000, 1.000000, 1.000000)
setText_boxInfo(rollleft, IG3D_TEXT, "Particle effects: YES")

rollright=make(ig3d_text_box, "Data/FontPngs/default32_1.png")
setText_boxInfo(rollright, IG3D_POSITION, 0, 125)
setText_boxInfo(rollright, IG3D_SIZE, 24)
setText_boxInfo(rollright, IG3D_COLOR, 0.400000, 0.400000, 1.000000, 1.000000)
setText_boxInfo(rollright, IG3D_TEXT, "High quality models: YES")

strafeleft=make(ig3d_text_box, "Data/FontPngs/default32_1.png")
setText_boxInfo(strafeleft, IG3D_POSITION, 0, 150)
setText_boxInfo(strafeleft, IG3D_SIZE, 24)
setText_boxInfo(strafeleft, IG3D_COLOR, 0.400000, 0.400000, 1.000000, 1.000000)
setText_boxInfo(strafeleft, IG3D_TEXT, "Sound effects: YES")

straferight=make(ig3d_text_box, "Data/FontPngs/default32_1.png")
setText_boxInfo(straferight, IG3D_POSITION, 0, 175)
setText_boxInfo(straferight, IG3D_SIZE, 24)
setText_boxInfo(straferight, IG3D_COLOR, 0.400000, 0.400000, 1.000000, 1.000000)
setText_boxInfo(straferight, IG3D_TEXT, "Music: YES")


start=make(ig3d_text_box, "Data/FontPngs/default32_1.png")
setText_boxInfo(start, IG3D_POSITION, 200, 250)
setText_boxInfo(start, IG3D_SIZE, 36)
setText_boxInfo(start, IG3D_COLOR, 0.400000, 0.400000, 1.000000, 1.000000)
setText_boxInfo(start, IG3D_TEXT, "Back")

gNumBoxes=6
gSelBox=0

load=false

boxes={}
boxes[1]=acc
boxes[2]=decc
boxes[3]=rollleft
boxes[4]=rollright
boxes[5]=strafeleft
boxes[6]=straferight

texts={"Shadows: ","Clouds: ","Particle effects: ","High quality models: ","Sound effects: ","Music: "}
vals={"YES","YES","YES","YES","YES","YES"}


i=1
for line in io.lines(getSceneInfo(IG3D_ROOT).."Data/Levels/iFly/iFly_options.txt","r") do
if i % 2 == 1 then
vals[(i-1)/2 +1]=line
else
setText_boxInfo(boxes[i/2], IG3D_TEXT, line)
end
i=i+1
end



function mouseInBox(x1,y1, x2,y2, mx,my)
if mx>=x1 and mx<=x2 and my>=y1 and my<=y2 then
return true
end
return false
end

function mouseCoords()
local x,y,z=getSceneInfo(IG3D_MOUSE_LINE)
x,y,z=getSceneInfo(IG3D_WINDOW_COORDS, x,y,z)
return x,y,z
end

function toggled(b)
if b == "YES" then
return "NO"
else
return "YES"
end
end


function loop()

if load== true then
  load = false
  gTextboxes={}
for i=1,#gTextboxFonts,1 do
	gTextboxes[i]=make(ig3d_text_box, gTextboxFonts[i])
	setText_boxInfo(gTextboxes[i], IG3D_TEXT, "")
  end
loadLevel("Data/Levels/iFly/iFly_Title")
end


if click("n") then
x,y=mouseCoords()
gSelBox=0

for i=1,gNumBoxes,1 do
x1,y1=getText_boxInfo(boxes[i], IG3D_POSITION)
x2=x1+200
y2=y1+24
if mouseInBox(x1,y1, x2,y2, x,y) then
setText_boxInfo(boxes[i], IG3D_COLOR, 1,0,0,1)
gSelBox=i

vals[i]=toggled(vals[i])
setText_boxInfo(boxes[i], IG3D_TEXT, texts[i]..vals[i])


else
setText_boxInfo(boxes[i], IG3D_COLOR, 0.4,0.4,1,1)
end
end

if mouseInBox(200,250,300,286,x,y) then

cfile=io.open(getSceneInfo(IG3D_ROOT).."Data/Levels/iFly/iFly_options.txt","w")
for i=1,6,1 do
cfile:write( vals[i].."\n"..getText_boxInfo(boxes[i], IG3D_TEXT).."\n")
end
cfile:close()
setText_boxInfo(start, IG3D_COLOR, 1,0,0,1)
load=true
end


end
end

game_func=loop