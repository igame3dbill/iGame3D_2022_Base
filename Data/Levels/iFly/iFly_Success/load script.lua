-- Begin of auto-script
loadMesh("Data/WTF/rollfield.wtf")
loadTexture("Data/Images/Foliage/rollfield.PNG")
loadTexture("Data/Images/Foliage/grass.PNG")
loadTexture("Data/Images/Vehicles/drewjetfighter.png")

loadTexture("Data/FontPngs/default32_1.png")
loadTexture("Data/FontPngs/default32_2.png")
loadFont("Data/FontPngs/default32_1.png", "Data/FontPngs/default32_2.png")
setCameraInfo(IG3D_POSITION, -8.4157161712646, 12.151944160461, 33.785339355469)
setCameraInfo(IG3D_ROTATION, 68.999984741211, 108.66681671143, 0)
gObjects={}
gNumObjects=2
gObjects[1]={}
gObjects[1].cObj=make(ig3d_object, "avatarp1.wtf")
setObjectInfo(gObjects[1].cObj, IG3D_NAME, "avatarp11")
setObjectInfo(gObjects[1].cObj, IG3D_POSITION, -2.580305, 0.645846, 26.402679)
setObjectInfo(gObjects[1].cObj, IG3D_ROTATION, 0.000000, 70.000000, 0.000000)
setObjectInfo(gObjects[1].cObj, IG3D_SIZE, 100.000000,100.000000,100.000000)
gObjects[2]={}
gObjects[2].cObj=make(ig3d_object, "avatarp1.wtf")
setObjectInfo(gObjects[2].cObj, IG3D_NAME, "avatarp12")
setObjectInfo(gObjects[2].cObj, IG3D_POSITION, 1.468737, 3.5, 9.254176)
setObjectInfo(gObjects[2].cObj, IG3D_ROTATION, 0.000000, 0.000000, 0.000000)
setObjectInfo(gObjects[2].cObj, IG3D_SIZE, 100.000000,100.000000,100.000000)
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
setText_boxInfo(gTextboxes[1], IG3D_SIZE, 14)
setText_boxInfo(gTextboxes[1], IG3D_COLOR, 1.000000, 1.000000, 1.000000, 1.000000)
setSceneInfo(IG3D_TINT_COLOR, 1.000000,1.000000,1.000000)
setSceneInfo(IG3D_FOG, false,0.500000,0.500000,0.500000,0.000000,200.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.650000,0.650000,0.650000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, -0.500000,2.000000,-1.000000,0.000000)
setLightInfo(1, IG3D_AMBIENT, 0.400000,0.400000,0.400000,1.000000)
setLightInfo(1, IG3D_DIFFUSE, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(1, IG3D_SPECULAR, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(1, IG3D_CONSTANT_ATTENUATION, 1.000000)
setLightInfo(1, IG3D_LINEAR_ATTENUATION, 0.000000)
setLightInfo(1, IG3D_QUADRATIC_ATTENUATION, 0.000000)
setLightInfo(1, IG3D_SPOTLIGHT, 0.000000,0.000000,0.000000,180.000000,0.000000)
setLightInfo(2, IG3D_ENABLED, false)
setLightInfo(3, IG3D_ENABLED, false)
setLightInfo(4, IG3D_ENABLED, false)
setLightInfo(5, IG3D_ENABLED, false)
setLightInfo(6, IG3D_ENABLED, false)
setLightInfo(7, IG3D_ENABLED, false)
setLightInfo(8, IG3D_ENABLED, false)
-- End of auto-script

f=io.open(getSceneInfo(IG3D_ROOT).."Data/Levels/iFly/iFly_name.txt","r")
playerName=f:read("*line")
f:close()


briefing="MISSION ACCOMPLISHED\n\nGood work, "..playerName.."!\nA positive note will be added to your record.\n\nSpecialists are currently analizing the cargo.\nYour next mission depends on what they will find.\nNow it is time for you to recover at first.\n\nDismiss"


setText_boxInfo(gTextboxes[1], IG3D_TEXT, briefing)


setSceneInfo(IG3D_RECEIVE_SHADOW, true)
setObjectInfo(gObjects[1].cObj, IG3D_CAST_SHADOW, true, "avatarp1shadow.wtf")
setObjectInfo(gObjects[2].cObj, IG3D_CAST_SHADOW, true, "avatarp1shadow.wtf")
setLightInfo(2, IG3D_POSITION, 1,1,0,0)

setObjectInfo(gObjects[2].cObj, IG3D_VELOCITY, 0,-2,10)

theLevel="Data/Levels/iFly/iFly_Title"
loadtime=0

setSceneInfo(IG3D_MOUSE_VIEW, true)

function loop()
if loadtime~=0 then
if time()>=loadtime then
loadLevel(theLevel)
end
else




if click("n") then
loadtime=time()
end
end
end

function land(obj, x,y,z)
x,y,z=getObjectInfo(obj.cObj, IG3D_VELOCITY)
setObjectInfo(obj.cObj, IG3D_VELOCITY, 0,0,z)
setObjectInfo(obj.cObj, IG3D_OMEGA, 0,0,0)
setObjectInfo(obj.cObj, IG3D_FORCE, 0,-3,0)
--coll_o_m=nil
end


coll_o_m=land

game_func=loop