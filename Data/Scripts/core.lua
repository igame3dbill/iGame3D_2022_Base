--iGame3D Lua core code
gNumObjects=0
gObjects={}
gOLT={}

gNumLights=8
gLights={}

for i=1,8 do
gLights[i]={}
gLights[i].number=i
gLights[i].ambient={}
gLights[i].diffuse={}
gLights[i].specular={}
gLights[i].attenuation={}
gLights[i].spot={}
gLights[i].spot.dir={}
end


--this is becoming the material structure to transfer material data between Lua and the C objects
mtrl={}
mtrl.ambient={}
mtrl.diffuse={}
mtrl.specular={}
mtrl.emission={}
mtrl.color={}
mtrl.cMat={}



camera={x=0, y=0, z=0, xang=0, yang=180, zang=0}

--entity types
ig3d_camera=1
ig3d_object=2
ig3d_light=3
ig3d_particle_emitter=4
ig3d_sound_emitter=5
ig3d_group=6
ig3d_path=7
ig3d_bone=8
ig3d_material=9
ig3d_scene=10
ig3d_text_box=11
ig3d_joint=12
ig3d_texture=13

--entity (object) shapes
ig3d_box=0
ig3d_cylinder=1
ig3d_sphere=2

--entity attributes
IG3D_AMBIENT=1
IG3D_DIFFUSE=2
IG3D_SPECULAR=3
IG3D_COLOR=4
IG3D_EMISSION=5
IG3D_TEXTURE=6
IG3D_TRANSPARENT=7
IG3D_SMOOTH=8
IG3D_SPOTLIGHT=9
IG3D_CONSTANT_ATTENUATION=10
IG3D_LINEAR_ATTENUATION=11
IG3D_QUADRATIC_ATTENUATION=12
IG3D_SHININESS=13
IG3D_LUX=14
IG3D_WIRE=15
IG3D_ENABLED=16
IG3D_POSITION=17
IG3D_ROTATION=18
IG3D_NAME=19
IG3D_TORQUE=20
IG3D_IMPULSE=21
IG3D_SAMPLE=22
IG3D_PITCH=23
IG3D_VOLUME=24
IG3D_PAUSE=25
IG3D_START=26
IG3D_LOOP=27
IG3D_STOP=28
IG3D_TINT_COLOR=29
IG3D_FOG=30
IG3D_FOV=31
IG3D_ORTHO=32
IG3D_MOUSE_VIEW=33
IG3D_BACKGROUND_COLOR=34
IG3D_SIZE=35
IG3D_MOUSE_LINE=36
IG3D_FPS=37
IG3D_LIFE_TIME=38
IG3D_FADE_TIME=39
IG3D_EMISSION_RATE=40
IG3D_SPEED=41
IG3D_AREA=42
IG3D_SIZE_VARIANCE=43
IG3D_AMOUNT=44
IG3D_ANIMATION=45
IG3D_MASS=46
IG3D_ROTATION_MATRIX=47
IG3D_PARTICLE_MOVEMENT=48
IG3D_PARTICLE_EXPLOSION=49
IG3D_PARTICLE_SCALE=50
IG3D_PARTICLE_ROTATION=51
IG3D_PARTICLE_PLANE=52
IG3D_GROUP_ADD=53
IG3D_GROUP_REMOVE=54
IG3D_HUD=55
IG3D_VECTOR_CONSTRAINT=56
IG3D_VELOCITY=57
IG3D_FORCE=58
IG3D_LEVEL_MESH=59
IG3D_FULLSCREEN=60
IG3D_FACE=61
IG3D_IN=62
IG3D_OUT=63
IG3D_OMEGA=64
IG3D_MOUSE_DELTA=65
IG3D_DEPTH=66
IG3D_COLL=67
IG3D_SKYBOX=68
IG3D_FONT=69
IG3D_TEXT=70
IG3D_DRAWN_FACES=71
IG3D_NUM_SWAPS=72
IG3D_TRANSFORMED_POSITION=73
IG3D_COUNT=74
IG3D_ROOT=75
IG3D_SHADER=76
IG3D_SHADER_PARAM=77
IG3D_COLL_DESTROY=78
IG3D_BONE_TRAVERSAL=79
IG3D_IGNORE_COLL=80
IG3D_BONE_COLL=81
IG3D_WINDOW_COORDS=82
IG3D_REPEAT=83
IG3D_CAST_SHADOW=84
IG3D_RECEIVE_SHADOW=85
IG3D_BILLBOARD_X=86
IG3D_BILLBOARD_Y=87
IG3D_BILLBOARD_Z=88
IG3D_SHAPE=89
IG3D_GRAVITY_MULTIPLIER=90
IG3D_RUN_IN_BACKGROUND=91
IG3D_UV_TRANSFORMATION=92
IG3D_WHEEL_DELTA=93
IG3D_BALL=94
IG3D_HINGE=95
IG3D_SLIDER=96
IG3D_CORKSCREW=97
IG3D_UNIVERSAL=98
IG3D_CLEAR_PARTICLES=99
IG3D_CLOSEST_POINTS=100
IG3D_BOUNDS=101
IG3D_RAGDOLL=102
IG3D_EXACT_COLLISION_DATA=103
IG3D_CLAMP=104
IG3D_MODULATE=105
IG3D_REPLACE=106
IG3D_ADD=107
IG3D_FRAGMENT_SHADER_SUPPORTED=108
IG3D_VEHICLE=109
IG3D_BRAKE=110
IG3D_STEERING_ANGLE=111
IG3D_LINK_MAIN_BONE_TO_VELOCITY=112
IG3D_SOUND_DAMPING=113
IG3D_LOD_DISTANCE=114
IG3D_LOD_MODEL=115
IG3D_IGNORE_OBJECT_COLLS=116
IG3D_COLLBOX_MULTIPLICATORS=117
IG3D_CAMERA_DROP=118
IG3D_MODEL=119
IG3D_ACCELEROMETER_VALUES=120
IG3D_TOUCH_LINE=121
IG3D_NUM_TOUCHES=122

FLUID_Normal=0
FLUID_Vertical=0
FLUID_Dot=0
FLUID_Integer=0
FLUID_normal=0
FLUID_No_Select=0
FLUID_BOTH=0
FLUID_Toggle=1
FLUID_Horizontal=1
FLUID_Simple=1
FLUID_Line=1
FLUID_Float=1
FLUID_popup1=1
FLUID_Select=1
FLUID_HORIZONTAL=1
FLUID_Vert_Fill=2
FLUID_Fill=2
FLUID_Int=2
FLUID_popup2=2
FLUID_Hold=2
FLUID_VERTICAL=2
FLUID_Horz_Fill=3
FLUID_popup3=3
FLUID_Multi=3
FLUID_Vert_Knob=4
FLUID_Multiline=4
FLUID_popup12=4
FLUID_Horz_Knob=5
FLUID_Secret=5
FLUID_popup23=5
FLUID_HORIZONTAL_ALWAYS=5
FLUID_popup13=6
FLUID_VERTICAL_ALWAYS=6
FLUID_popup123=7
FLUID_BOTH_ALWAYS=7
FLUID_Radio=102


game_func=nil -- must be defined in the game
coll_o_m=nil -- can be defined in the game
coll_o_o=nil -- can be defined in the game
coll_o_p=nil -- can be defined in the game
coll_p_p=nil -- can be defined in the game
coll_p_m=nil -- can be defined in the game


function updateFromVisualCamera()
camera.x,camera.y,camera.z=getCameraInfo(IG3D_POSITION)
camera.xang,camera.yang,camera.zang=getCameraInfo(IG3D_ROTATION)
end


function updateToVisualCamera()
setCameraInfo(IG3D_POSITION, camera.x, camera.y, camera.z)
setCameraInfo(IG3D_ROTATION, camera.xang, camera.yang, camera.zang)
end


function go(cObj, dist)
local matrix={}

matrix[1],matrix[2],matrix[3],matrix[4],matrix[5],matrix[6],matrix[7],matrix[8],matrix[9],matrix[10],matrix[11],matrix[12],matrix[13],matrix[14],matrix[15],matrix[16]=getObjectInfo(cObj, IG3D_ROTATION_MATRIX)

setObjectInfo(cObj, IG3D_IMPULSE, matrix[9]*dist, matrix[10]*dist, matrix[11]*dist)

end

function go_humanoid(cObj, dist)
local matrix={}


matrix[1],matrix[2],matrix[3],matrix[4],matrix[5],matrix[6],matrix[7],matrix[8],matrix[9],matrix[10],matrix[11],matrix[12],matrix[13],matrix[14],matrix[15],matrix[16]=getObjectInfo(cObj, IG3D_ROTATION_MATRIX)

local a,b,c=getObjectInfo(cObj, IG3D_VELOCITY)
setObjectInfo(cObj, IG3D_VELOCITY, matrix[9]*dist, b, matrix[11]*dist)

end



function updateToVisualObject(obj)
--function to update the actual C object from Lua data
setObjectInfo(obj.cObj, IG3D_NAME, obj.name)
setObjectInfo(obj.cObj, IG3D_POSITION, obj.x, obj.y, obj.z)
setObjectInfo(obj.cObj, IG3D_ROTATION, obj.xang, obj.yang, obj.zang)
end


function updateFromVisualObject(obj)
--fill in Lua data with actual values of the C object
obj.name=getObjectInfo(obj.cObj, IG3D_NAME)
obj.x,obj.y,obj.z=getObjectInfo(obj.cObj, IG3D_POSITION)
obj.xang,obj.yang,obj.zang=getObjectInfo(obj.cObj, IG3D_ROTATION)
end

function printObjectData(obj)
--output object data to stdout
updateFromVisualObject(obj)
print("Name:", obj.name)
print("Position:", obj.x, obj.y, obj.z)
print("Orientation:", obj.xang, obj.yang, obj.zang)
end



function create(modelname, idle_func)
local myobj= {cObj=make(ig3d_object, modelname), idlefunc=idle_func }

updateFromVisualObject(myobj) -- get C object data
updateToVisualObject(myobj) -- get C object data
gNumObjects=gNumObjects+1
gObjects[gNumObjects]=myobj

return myobj
end



function updateFromAllVisualObjects()
for i=1,gNumObjects,1 do
updateFromVisualObject(gObjects[i]) -- set C object data
end
end




function updateAllVisualObjects()
for i=1,gNumObjects,1 do
updateToVisualObject(gObjects[i]) -- set C object data
end
end

function getObjectByItsID(id)
if id==nil then
return nil
end
for i=1,gNumObjects,1 do

if gObjects[i].cObj==id then
return gObjects[i]
end
end
return nil
end


function game_idle()
if game_func ~= nil then
game_func()
end
end

function edit_idle()
if edit_func ~= nil then
edit_func()
end
end


--COLLIDERS
function coll_obj_obj(objA, boneA, objB, boneB, x,y,z)
if coll_o_o ~= nil then
coll_o_o(objA, boneA, objB, boneB, x,y,z)
end
end

function coll_obj_mesh(obj, bone, x,y,z)
if coll_o_m ~= nil then
coll_o_m(obj, bone, x,y,z)
end
end

function coll_obj_prtcl(obj, bone, psys, x,y,z)
if coll_o_p ~= nil then
coll_o_p(obj, bone, psys, x,y,z)
end
end

function coll_prtcl_prtcl(psysA, psysB, x,y,z)
if coll_p_p ~= nil then
coll_p_p(psysA, psysB, x,y,z)
end
end

function coll_prtcl_mesh(psys, x,y,z)
if coll_p_m ~= nil then
coll_p_m(psys, x,y,z)
end
end


if murgaLua == nil then
	gNativeOS="iphone"
	Fl={}
else
	gNativeOS=murgaLua.getHostOsName()
end


function fltk_update()
	if gNativeOS =="macos" then
	if not click("-") then
		Fl:wait(0)
	end
	else
	Fl:wait(0)
	end

end


	dofile(getSceneInfo(IG3D_ROOT).."Data/Scripts/Convert/cxxToiGame3DLua.lua")-- import cxx converter
	
	ig3d_AddFileToLoadedList_s("Data/Scripts/Convert/cxxToiGame3DLua.lua")--add this one manually, because dofile has not been overwritten yet to remember all files, the rest of the files come in automatically
if gNativeOS~="iphone" then
	function luasocket_init()
		dofile(getSceneInfo(IG3D_ROOT).."Data/Scripts/LuaSocket/ltn12.lua")
		dofile(getSceneInfo(IG3D_ROOT).."Data/Scripts/LuaSocket/socket.lua")
		dofile(getSceneInfo(IG3D_ROOT).."Data/Scripts/LuaSocket/mime.lua")
		dofile(getSceneInfo(IG3D_ROOT).."Data/Scripts/LuaSocket/socket/tp.lua")
		dofile(getSceneInfo(IG3D_ROOT).."Data/Scripts/LuaSocket/socket/url.lua")
		dofile(getSceneInfo(IG3D_ROOT).."Data/Scripts/LuaSocket/socket/ftp.lua")
		dofile(getSceneInfo(IG3D_ROOT).."Data/Scripts/LuaSocket/socket/http.lua")
		dofile(getSceneInfo(IG3D_ROOT).."Data/Scripts/LuaSocket/socket/smtp.lua")
	end

	luasocket_init()
	---- end iGame3D luasocket init
end
 

--- kill Fl:run()
function Fl:run()
	-- do nothing (i.e. don't stall iGame3D when called)
end