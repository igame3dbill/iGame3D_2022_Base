load = false
setSceneInfo(IG3D_BACKGROUND_COLOR, 0,0,0)
loadFont("Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png")
explanation=make(ig3d_text_box, "Data/FontPngs/default32_1.png")
setText_boxInfo(explanation, IG3D_POSITION, 0, 0)
setText_boxInfo(explanation, IG3D_SIZE, 12)
setText_boxInfo(explanation, IG3D_COLOR, 0.400000, 0.400000, 1.000000, 1.000000)
setText_boxInfo(explanation, IG3D_TEXT, "Click on the control you wish to configure and then hit the key you want to use")

acc=make(ig3d_text_box, "Data/FontPngs/default32_1.png")
setText_boxInfo(acc, IG3D_POSITION, 0, 50)
setText_boxInfo(acc, IG3D_SIZE, 24)
setText_boxInfo(acc, IG3D_COLOR, 0.400000, 0.400000, 1.000000, 1.000000)
setText_boxInfo(acc, IG3D_TEXT, "Accelerate: w")

decc=make(ig3d_text_box, "Data/FontPngs/default32_1.png")
setText_boxInfo(decc, IG3D_POSITION, 0, 75)
setText_boxInfo(decc, IG3D_SIZE, 24)
setText_boxInfo(decc, IG3D_COLOR, 0.400000, 0.400000, 1.000000, 1.000000)
setText_boxInfo(decc, IG3D_TEXT, "Deccelerate: s")

rollleft=make(ig3d_text_box, "Data/FontPngs/default32_1.png")
setText_boxInfo(rollleft, IG3D_POSITION, 0, 100)
setText_boxInfo(rollleft, IG3D_SIZE, 24)
setText_boxInfo(rollleft, IG3D_COLOR, 0.400000, 0.400000, 1.000000, 1.000000)
setText_boxInfo(rollleft, IG3D_TEXT, "Roll left: q")

rollright=make(ig3d_text_box, "Data/FontPngs/default32_1.png")
setText_boxInfo(rollright, IG3D_POSITION, 0, 125)
setText_boxInfo(rollright, IG3D_SIZE, 24)
setText_boxInfo(rollright, IG3D_COLOR, 0.400000, 0.400000, 1.000000, 1.000000)
setText_boxInfo(rollright, IG3D_TEXT, "Roll right: e")

strafeleft=make(ig3d_text_box, "Data/FontPngs/default32_1.png")
setText_boxInfo(strafeleft, IG3D_POSITION, 0, 150)
setText_boxInfo(strafeleft, IG3D_SIZE, 24)
setText_boxInfo(strafeleft, IG3D_COLOR, 0.400000, 0.400000, 1.000000, 1.000000)
setText_boxInfo(strafeleft, IG3D_TEXT, "Strafe left: a")

straferight=make(ig3d_text_box, "Data/FontPngs/default32_1.png")
setText_boxInfo(straferight, IG3D_POSITION, 0, 175)
setText_boxInfo(straferight, IG3D_SIZE, 24)
setText_boxInfo(straferight, IG3D_COLOR, 0.400000, 0.400000, 1.000000, 1.000000)
setText_boxInfo(straferight, IG3D_TEXT, "Strafe right: d")


start=make(ig3d_text_box, "Data/FontPngs/default32_1.png")
setText_boxInfo(start, IG3D_POSITION, 200, 250)
setText_boxInfo(start, IG3D_SIZE, 36)
setText_boxInfo(start, IG3D_COLOR, 0.400000, 0.400000, 1.000000, 1.000000)
setText_boxInfo(start, IG3D_TEXT, "Back")

mspeed=make(ig3d_text_box, "Data/FontPngs/default32_1.png")
setText_boxInfo(mspeed, IG3D_POSITION, 0, 200)
setText_boxInfo(mspeed, IG3D_SIZE, 24)
setText_boxInfo(mspeed, IG3D_COLOR, 0.400000, 0.400000, 1.000000, 1.000000)
setText_boxInfo(mspeed, IG3D_TEXT, "Mouse Sensitivity: -------")

gNumBoxes=6
gSelBox=0

gMouseSpeed=7
gMouseMin=1
gMouseMax=10
gMSpeed=false

load=false

boxes={}
boxes[1]=acc
boxes[2]=decc
boxes[3]=rollleft
boxes[4]=rollright
boxes[5]=strafeleft
boxes[6]=straferight

texts={"Accelerate: ","Deccelerate: ","Roll left: ","Roll right: ","Strafe left: ","Strafe right: "}
keys={"w","s","q","e","a","d"}


i=1
for line in io.lines(getSceneInfo(IG3D_ROOT).."Data/Levels/iFly/iFly_controls.txt","r") do
if i % 2 == 1 then
keys[(i-1)/2 +1]=line
else
if i/2 <= gNumBoxes then
setText_boxInfo(boxes[i/2], IG3D_TEXT, line)
end

end
i=i+1
end





function numberToMinusSigns(n)
local str=""
for i=1,n,1 do
str=str.."-"
end
return str
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





gMouseSpeed=keys[7]
setText_boxInfo(mspeed, IG3D_TEXT, "Mouse Sensitivity: "..numberToMinusSigns(gMouseSpeed))



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


char,code,name=input(false)
if char~=nil then
if gSelBox>0 then
setText_boxInfo(boxes[gSelBox], IG3D_TEXT, texts[gSelBox]..name)
keys[gSelBox]=code
else
if gMSpeed == true then
if name=="Up arrow" or name=="Right arrow" then
gMouseSpeed=math.min(gMouseSpeed+1, gMouseMax)
end
if name=="Down arrow" or name=="Left arrow" then
gMouseSpeed=math.max(gMouseSpeed-1, gMouseMin)
end
setText_boxInfo(mspeed, IG3D_TEXT, "Mouse Sensitivity: "..numberToMinusSigns(gMouseSpeed))
end
end
end


if click("n") then
x,y=mouseCoords()
gSelBox=0
setText_boxInfo(mspeed, IG3D_COLOR, 0.4,0.4,1,1)
gMSpeed=false
for i=1,gNumBoxes,1 do
x1,y1=getText_boxInfo(boxes[i], IG3D_POSITION)
x2=x1+200
y2=y1+24
if mouseInBox(x1,y1, x2,y2, x,y) then
setText_boxInfo(boxes[i], IG3D_COLOR, 1,0,0,1)
gSelBox=i
else
setText_boxInfo(boxes[i], IG3D_COLOR, 0.4,0.4,1,1)
end
end

if mouseInBox(0,200,250,225,x,y) then
--check if we clicked the mouse sensitivity control
setText_boxInfo(mspeed, IG3D_COLOR, 1,0,0,1)
gMSpeed=true
end



if mouseInBox(200,250,300,286,x,y) then

cfile=io.open(getSceneInfo(IG3D_ROOT).."Data/Levels/iFly/iFly_controls.txt","w")
for i=1,6,1 do
cfile:write( keys[i].."\n"..getText_boxInfo(boxes[i], IG3D_TEXT).."\n")
end
cfile:write(gMouseSpeed.."\nMouse Speed:\n")
cfile:close()
setText_boxInfo(start, IG3D_COLOR, 1,0,0,1)
load=true
end


end
end



game_func=loop