-- BrickFun
-- Simple demonstration of the power of iGame3D Player and murgaLua
-- @Author: Chrimo
-- @Menthor: Tobias, Bill
-- @Project: NXTpbLuaSim
-- @Change: every day, learning by doing
--
-- @Todo: 
-- moving objects
-- controlling by keys
-- controlling by lua program
--
intupp=0
gNumObjects=0
dofile(gameroot.."Data/Levels/default/default_globals.lua")
function colorswap()
intupp=math.random(gNumObjects)
r=math.random(0,1)
g=math.random(0,1)
b=math.random(0,1)
m=get(ig3d_material, gObjects[intupp].cObj, 1)
setMaterialInfo(m, IG3D_COLOR, r,g,b)
testFloor=math.random(100)
if testFloor<=70 then 
setObjectInfo(gObjects[intupp].cObj,IG3D_SIZE,100.0,100.0,100.0)
xpos,ypos,zpos=getObjectInfo(gObjects[intupp].cObj,IG3D_POSITION)
setObjectInfo(gObjects[intupp].cObj,IG3D_POSITION,xpos,0.0,zpos)
else
scalit=math.random(1000)-500
xsiz,ysiz,zsiz=getObjectInfo(gObjects[intupp].cObj,IG3D_SIZE)
setObjectInfo(gObjects[intupp].cObj,IG3D_SIZE,xsiz,ysiz+scalit,zsiz)
updown=(math.random(10)-5)*.2
xpos,ypos,zpos=getObjectInfo(gObjects[intupp].cObj,IG3D_POSITION)
setObjectInfo(gObjects[intupp].cObj,IG3D_POSITION,xpos,ypos+updown,zpos)
end

default_escapekey()
end

--fltk_update
function NXTFloor()
gTimedLevelLoad="Data/Levels/NXTpbLuaSim"
-- set my own camera position
setCameraInfo(IG3D_POSITION, 100.000000, 45.00000, -40.000000)

-- set my own camera view direction
setCameraInfo(IG3D_ROTATION, 0.000000, 0.000000, 0.000000)

-- gObjects table arry
gObjects={}

xpos={}
ypos={}
zpos={}

-- gObject WTF template 
gObjectWTFs={"Shapes/legostein.wtf"}

-- gObject name
gObjectNames={"brick"}

-- defaults for my new world
-- setSceneInfo(IG3D_BACKGROUND_COLOR, r,g,b) 
setSceneInfo(IG3D_BACKGROUND_COLOR, 0,0.25,0.50)

-- creating all gObjecty loop
xdir=0;ydir=0;zdir=0;

i=0
for col=1,24 do
i=i+1
for row=1,8 do
-- 2rd dimension array
i=i+1
gObjects[i]={} 


xpos[col]={}
xpos[col][row]={} 
xpos[col][row]=col*8;

ypos[col]={}
ypos[col][row]={} 
ypos[col][row]=0

zpos[col]={}
zpos[col][row]={} 
zpos[col][row]=row*16

print("row:"..row.." col:"..col.."\n");

-- creating object
gObjects[i].cObj=make(ig3d_object, gObjectWTFs[1])

-- set gObject name
setObjectInfo(gObjects[i].cObj, IG3D_NAME, gObjectNames[1])

-- set gObject position x,y,z
setObjectInfo(gObjects[i].cObj,IG3D_POSITION,xpos[col][row],ypos[col][row],zpos[col][row])

-- set gObject direction x,y,z
setObjectInfo(gObjects[i].cObj, IG3D_ROTATION, xdir,ydir,zdir)

-- set gObject size x,y,z
setObjectInfo(gObjects[i].cObj, IG3D_SIZE, 100,100,100)

-- colorize brick by random
r=math.random()
g=math.random()
b=math.random()
print(i)
setMaterialInfo(get(ig3d_material, gObjects[i].cObj, 1), IG3D_COLOR, r,g,b)
end
end
gNumObjects=i
end

NXTFloor();


game_func=colorswap
edit_func=colorswap
