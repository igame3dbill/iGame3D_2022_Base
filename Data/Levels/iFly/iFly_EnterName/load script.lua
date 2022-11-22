-- Begin of auto-script
loadTexture("Data/FontPngs/default32_1.png")
loadTexture("Data/FontPngs/default32_2.png")
loadFont("Data/FontPngs/default32_1.png", "Data/FontPngs/default32_2.png")
setCameraInfo(IG3D_POSITION, 0.000000, 1.000000, 0.000000)
setCameraInfo(IG3D_ROTATION, 0.000000, 180.000000, 0.000000)
gObjects={}
gNumObjects=0
gParticleEmitters={}
gNumParticleEmitters=0
gSoundEmitters={}
gNumSoundEmitters=0
gGroups={}
gNumGroups=0
gTextboxes={}
gNumTextboxes=1
gTextboxes[1]=make(ig3d_text_box, "Data/FontPngs/default32_1.png")
setText_boxInfo(gTextboxes[1], IG3D_POSITION, 20, 20)
setText_boxInfo(gTextboxes[1], IG3D_SIZE, 16)
setText_boxInfo(gTextboxes[1], IG3D_COLOR, 0.400000, 0.400000, 1.000000, 1.000000)
setSceneInfo(IG3D_TINT_COLOR, 1.000000,1.000000,1.000000)
setSceneInfo(IG3D_FOG, false,0.500000,0.500000,0.500000,0.000000,200.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.000000,0.000000,0.000000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, -0.500000,2.000000,-1.000000,0.000000)
setLightInfo(1, IG3D_AMBIENT, 0.400000,0.400000,0.400000,1.000000)
setLightInfo(1, IG3D_DIFFUSE, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(1, IG3D_SPECULAR, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(1, IG3D_CONSTANT_ATTENUATION, 1.000000)
setLightInfo(1, IG3D_LINEAR_ATTENUATION, 0.000000)
setLightInfo(1, IG3D_QUADRATIC_ATTENUATION, 0.000000)
setLightInfo(1, IG3D_SPOTLIGHT, 0.000000,0.000000,0.000000,0.000000,0.000000)
setLightInfo(2, IG3D_ENABLED, false)
setLightInfo(3, IG3D_ENABLED, false)
setLightInfo(4, IG3D_ENABLED, false)
setLightInfo(5, IG3D_ENABLED, false)
setLightInfo(6, IG3D_ENABLED, false)
setLightInfo(7, IG3D_ENABLED, false)
setLightInfo(8, IG3D_ENABLED, false)
-- End of auto-script


str="Please enter your name:\n\n"

insmark="|"

tim=time()+0.3

setSceneInfo(IG3D_MOUSE_VIEW, true)

function loop()

setText_boxInfo(gTextboxes[1], IG3D_TEXT, str..insmark)

char,code,name=input(true)
if char~=nil then
str=str..char
end


char,code,name=input(false)
if char~=nil then
if name=="Delete" then
if #str>25 then
str=string.sub(str, 1,#str-1)
end
end

if name=="Return" or name=="Enter" then
if #string.sub(str, 26, #str)>0 then
f=io.open(getSceneInfo(IG3D_ROOT).."Data/Levels/iFly/iFly_name.txt","w")
f:write( string.sub(str, 26,#str))
f:close()
loadLevel("Data/Levels/iFly/iFly_Briefing")
else
beep()
end
end

end

if time()>tim then
if insmark=="|" then
insmark=""
else
insmark="|"
end
tim=time()+0.3
end

end

game_func=loop