-- Begin of auto-script
-- End of auto-script
-- Spielversion zum Testen, Problem SCOPING

-- NXTpbLuaSim
-- Simple demonstration of the power of iGame3D Player and murgaLua
-- @Author: Chrimo
-- @Menthor: Tobias, Bill
-- @Project: NXTpbLuaSim
-- @Change: every day, learning by doing
-- @Date: 2007-12-28 19:00
-- @Todo:
-- build a labyrith of bricks 
-- moving objects
-- controlling object by keys
-- controlling object by lua program
--

-- this avoids unwanted behaviours with wrong initialition
delete(ig3d_scene)
loadMesh("Data/WTF/Floors/floor180x180c.wtf")
--dofile(gameroot.."Data/Levels/default/default_globals.lua")
dofile(gameroot.."Data/Scripts/Games/iFly_Functions/iFly_math.lua")

--dofile(gameroot.."Data/Levels/NXTpbLuaSim/pbLuaAPI.lua")

brick_id=0
nxt_id=0

brick_x=0
brick_y=0
brick_z=0

max_x=2--20
max_y=2
max_z=1--10

brick_l=16
brick_h=8
brick_w=8

scale_x=100
scale_y=100
scale_z=100

brick_dir_x=0
brick_dir_y=0
brick_dir_z=0

nxt_scale_x=100
nxt_scale_y=100
nxt_scale_z=100

nxt_dir_x=0
nxt_dir_y=0
nxt_dir_z=0

col_r=0
col_g=0
col_b=0

loopcount=0
max_wholes=10

usDistanz=5
cosAlpha=0.707

-- why this ???
gTimedLevelLoad="Data/Levels/NXTpbLuaSim"

-- gObject WTF template 
gObjectWTFs={"Shapes/brick_4x2.wtf","Shapes/nxt_brick.wtf"}

-- gObject names
gObjectNames={"brick","NXT"}

function CameraSet()
	-- set my own camera position
	--setCameraInfo(IG3D_POSITION, max_x*brick_w/2, max_y*brick_h*3, -max_z-2*brick_h)
	setCameraInfo(IG3D_POSITION,82,54,-48)
	-- set my own camera view direction
	--setCameraInfo(IG3D_ROTATION, 40.000000, 0.000000, 0.000000)
	setCameraInfo(IG3D_ROTATION, 4.33, 0.66, 0.00)

end

function SimFloorSet()
	brick_y=0
	brick_z=1
	col_r=0;col_g=1;col_b=0
	while(brick_z <= max_z) do
		brick_x=1
		while(brick_x <= max_x) do 	
			brick_id=brick_id+1
			print("Debug Floor: BrickId "..brick_id.."\t"..brick_x.." "..brick_y.." "..brick_z.."\n")
			gObjects[brick_id]={}
			gObjects[brick_id].cObj=make(ig3d_object, gObjectWTFs[1])
			setObjectInfo(gObjects[brick_id].cObj, IG3D_NAME, gObjectNames[1])
			setObjectInfo(gObjects[brick_id].cObj,IG3D_POSITION,brick_x*brick_w,brick_y+brick_y*brick_h/2,brick_z*brick_l)
			setObjectInfo(gObjects[brick_id].cObj, IG3D_ROTATION, brick_dir_x,brick_dir_y,brick_dir_z)
			setObjectInfo(gObjects[brick_id].cObj, IG3D_SIZE, scale_x,scale_y,scale_z)
			setObjectInfo(gObjects[brick_id].cObj, IG3D_MASS, 0,0,0,0)
			setMaterialInfo(get(ig3d_material, gObjects[brick_id].cObj, 1), IG3D_COLOR, col_r,col_g,col_b)
			brick_x=brick_x+1
		end
		brick_z=brick_z+1
	end
	floor_range=brick_id
	print("Debug: floor_range "..floor_range.."\n")
end

function SimWallSet()

	scale_y=scale_y*1
	
	--BrickWall A Layer 1
	brick_x=1
	brick_y=1
	brick_z=1
	
	while(brick_z <= max_z) do	
		-- colorize brick by random
		col_r=math.random();col_g=math.random();col_b=math.random()
		brick_id=brick_id+1
		print("Debug Wall: BrickId "..brick_id.."\t"..brick_x.." "..brick_y.." "..brick_z.."\n")
		gObjects[brick_id]={}
		gObjects[brick_id].cObj=make(ig3d_object, gObjectWTFs[1])
		setObjectInfo(gObjects[brick_id].cObj, IG3D_NAME, gObjectNames[1])
		setObjectInfo(gObjects[brick_id].cObj,IG3D_POSITION,brick_x*brick_w,brick_y+brick_y*brick_h/2,brick_z*brick_l)
		setObjectInfo(gObjects[brick_id].cObj, IG3D_ROTATION, brick_dir_x,brick_dir_y,brick_dir_z)
		setObjectInfo(gObjects[brick_id].cObj, IG3D_SIZE, scale_x,scale_y,scale_z)
		setObjectInfo(gObjects[brick_id].cObj, IG3D_MASS, 0,0,0,0)
		setMaterialInfo(get(ig3d_material, gObjects[brick_id].cObj, 1), IG3D_COLOR, col_r,col_g,col_b)
		brick_z=brick_z+1
	end
		
	-- BrickWall B
	brick_x=max_x
	brick_y=1
	brick_z=1
	while(brick_z<=max_z) do
		-- colorize brick by random
		col_r=math.random();col_g=math.random();col_b=math.random()
		brick_id=brick_id+1
		print("Debug Wall: BrickId "..brick_id.."\t"..brick_x.." "..brick_y.." "..brick_z.."\n")
		gObjects[brick_id]={}
		gObjects[brick_id].cObj=make(ig3d_object, gObjectWTFs[1])
		setObjectInfo(gObjects[brick_id].cObj, IG3D_NAME, gObjectNames[1])
		setObjectInfo(gObjects[brick_id].cObj,IG3D_POSITION,brick_x*brick_w,brick_y+brick_y*brick_h/2,brick_z*brick_l)
		setObjectInfo(gObjects[brick_id].cObj, IG3D_ROTATION, brick_dir_x,brick_dir_y,brick_dir_z)
		setObjectInfo(gObjects[brick_id].cObj, IG3D_SIZE, scale_x,scale_y,scale_z)
		setObjectInfo(gObjects[brick_id].cObj, IG3D_MASS, 0,0,0,0)
		setMaterialInfo(get(ig3d_material, gObjects[brick_id].cObj, 1), IG3D_COLOR, col_r,col_g,col_b)
		brick_z=brick_z+1
	end

	-- BrickWall C
	brick_x=2
	brick_y=1
	brick_z=1	
	brick_dir_y=90
	while(brick_x<=max_x-2) do
		-- colorize brick by random
		col_r=math.random();col_g=math.random();col_b=math.random()
		brick_id=brick_id+1
		print("Debug Wall: BrickId "..brick_id.."\t"..brick_x.." "..brick_y.." "..brick_z.."\n")
		gObjects[brick_id]={}
		gObjects[brick_id].cObj=make(ig3d_object, gObjectWTFs[1])
		setObjectInfo(gObjects[brick_id].cObj, IG3D_NAME, gObjectNames[1])
		setObjectInfo(gObjects[brick_id].cObj,IG3D_POSITION,brick_x*brick_w+brick_w/4+2,brick_y+brick_y*brick_h/2,brick_z*brick_l-brick_w/2)
		setObjectInfo(gObjects[brick_id].cObj, IG3D_ROTATION, brick_dir_x,brick_dir_y,brick_dir_z)
		setObjectInfo(gObjects[brick_id].cObj, IG3D_SIZE, scale_x,scale_y,scale_z)
		setObjectInfo(gObjects[brick_id].cObj, IG3D_MASS, 0,0,0,0)
		setMaterialInfo(get(ig3d_material, gObjects[brick_id].cObj, 1), IG3D_COLOR, col_r,col_g,col_b)
		brick_x=brick_x+2
	end
	
	-- BrickWall D
	brick_x=2
	brick_y=1
	brick_z=max_z
	brick_dir_y=90
	while(brick_x<=max_x-2) do
		-- colorize brick by random
		col_r=math.random();col_g=math.random();col_b=math.random()
		brick_id=brick_id+1
		print("Debug Wall: BrickId "..brick_id.."\t"..brick_x.." "..brick_y.." "..brick_z.."\n")
		gObjects[brick_id]={}
		gObjects[brick_id].cObj=make(ig3d_object, gObjectWTFs[1])
		setObjectInfo(gObjects[brick_id].cObj, IG3D_NAME, gObjectNames[1])
		setObjectInfo(gObjects[brick_id].cObj,IG3D_POSITION,brick_x*brick_w+brick_w/4+2,brick_y+brick_y*brick_h/2,brick_z*brick_l+brick_w/2)
		setObjectInfo(gObjects[brick_id].cObj, IG3D_ROTATION, brick_dir_x,brick_dir_y,brick_dir_z)
		setObjectInfo(gObjects[brick_id].cObj, IG3D_SIZE, scale_x,scale_y,scale_z)
		setObjectInfo(gObjects[brick_id].cObj, IG3D_MASS, 0,0,0,0)
		setMaterialInfo(get(ig3d_material, gObjects[brick_id].cObj, 1), IG3D_COLOR, col_r,col_g,col_b)
		brick_x=brick_x+2
	end
	wall_range=brick_id
end

function SimWallDoorSet()
	door=math.random(floor_range,wall_range)
	ig3d_DeleteObject_i (gObjects[door].cObj) 	
	print("Debug Door Obj:"..gObjects[door].cObj..":"..door.."\n")
end

function SimFloorWholeSet()
	local i
	for i=1,max_wholes do
		whole=math.random(1,floor_range)
		ig3d_DeleteObject_i (gObjects[whole].cObj) 	
		print("Debug Whole Obj:"..gObjects[whole].cObj..":"..whole.."\n")
	end
end

function SimFloorHillSet()
end

function SimNXTSet()
	brick_id=brick_id+1
	gObjects[brick_id]={}
	print("Debug NXT: BrickId "..brick_id.."\t"..nxt_x.." "..nxt_y.." "..nxt_z.."\n")			
	gObjects[brick_id].cObj=make(ig3d_object, gObjectWTFs[2])
	setObjectInfo(gObjects[brick_id].cObj, IG3D_NAME, gObjectNames[2])
	setObjectInfo(gObjects[brick_id].cObj,IG3D_POSITION,nxt_x,nxt_y,nxt_z)
	setObjectInfo(gObjects[brick_id].cObj, IG3D_ROTATION, nxt_dir_x,nxt_dir_y,nxt_dir_z)
	setObjectInfo(gObjects[brick_id].cObj, IG3D_SIZE, nxt_scale_x,nxt_scale_y,nxt_scale_z)
	setObjectInfo(gObjects[brick_id].cObj, IG3D_GRAVITY_MULTIPLIER, 1) -- Schwerkraft an
	nxt_id=brick_id			
end

function SimNXTTurn(nxt_id)
	print("Debug NXT: NXTId "..brick_id.."\t"..nxt_x.." "..nxt_y.." "..nxt_z.."\n")
	setObjectInfo(gObjects[nxt_id].cObj,IG3D_POSITION,nxt_x,nxt_y,nxt_z) 
	setObjectInfo(gObjects[nxt_id].cObj, IG3D_ROTATION, nxt_dir_x,nxt_dir_y,nxt_dir_z)
end

function wait(s)
	-- stupid fake
	t=os.time()
	while(t==os.time()) do end
end

function SimTextBoxSet()
	gTextboxFonts={"Data/FontPngs/default32_1.png"}
	gTextboxPositions={{5,5}} 
	gTextboxSizes={12} 
	gTextboxColors={{1.000000,0.000000,0.000000,1.000000}} 
	gTextboxes={}
	gTextboxes[1]=make(ig3d_text_box, gTextboxFonts[1])
	setText_boxInfo(gTextboxes[1], IG3D_POSITION, gTextboxPositions[1][1],gTextboxPositions[1][2])
	setText_boxInfo(gTextboxes[1], IG3D_SIZE, gTextboxSizes[1])
	setText_boxInfo(gTextboxes[1], IG3D_COLOR, gTextboxColors[1][1],gTextboxColors[1][2],gTextboxColors[1][3], gTextboxColors[1][4])
end

function SimNXTUltrasonicScan()
	for i=1,gNumObjects,1 do
		if gObjects[i]~=woman then
			disjunct, ax,ay,az, bx,by,bz, nx,ny,nz=getObjectInfo (woman.cObj, IG3D_CLOSEST_POINTS, gObjects[i].cObj)
			if disjunct==1 then
				local dist=vecLength(ax-bx,ay-by,az-bz)
				r=0
				g=1
				b=0
				a=1
				m11,m12,m13,m14, m21,m22,m23,m24, m31,m32,m33,m34, m41,m42,m43,m44=getObjectInfo(woman.cObj, IG3D_ROTATION_MATRIX)
				
				if dot(nx,ny,nz, m31,m32,m33)>=cosAlpha then
					r=0
					g=0
					b=1
				end
				
				if dist<=usDistanz then
					r=1
					g=1
					b=0
				end
				
				if dot(nx,ny,nz, m31,m32,m33)>=cosAlpha and dist<=usDistanz then
					r=1
					g=0
					b=0
				end
				
				
				m=get(ig3d_material, gObjects[i].cObj, 1)
				setMaterialInfo(m, IG3D_COLOR, r,g,b,a)
				setMaterialInfo(m, IG3D_TEXTURE, 1, "")
			end
		end
	end
end

function SimTextBoxUpdate()
	local x,y,z,xd,yd,zd,dir
	x,y,z=getObjectInfo(gObjects[nxt_id].cObj,IG3D_POSITION)
	xd,yd,zd=getObjectInfo(gObjects[nxt_id].cObj,IG3D_ROTATION)
	dir=vecLength(xd,yd,zd)
	x=string.format("%f",x)
	y=string.format("%f",y)
	z=string.format("%f",z)
	dir=string.format("%f",dir)
	setText_boxInfo(gTextboxes[1], IG3D_TEXT, "NXTpbLuaSim powered by iGame3D and murgaLua\n"..
		"FPS "..getSceneInfo(IG3D_FPS).."   TIME "..formattedTime(math.ceil(time()-gStartTime))..
		"\nNXT Robot X="..x.." Y="..y.." Z="..z.." DirVec="..dir.."\n")
end

function gameLoop()
	print("DebugLoop"..nxt_id.."\n")
	SimTextBoxUpdate()
	WASD_pushObject(gObjects[nxt_id].cObj)
	camera_faceObj(gObjects[nxt_id].cObj)
	fltk_update()
	default_escapekey()
	--robot.run()	-- run the robot program at this location ???
end

-- Start Game
gStartTime=time()

CameraSet()
SimFloorSet()
SimWallSet()
SimWallDoorSet()
SimFloorWholeSet()
nxt_x=math.random(25,100);nxt_y=brick_h*2;nxt_z=math.random(15,55)
SimNXTSet()
SimTextBoxSet()
--dofile(gameroot.."Data/Levels/NXTpbLuaSim/robot.lua)
gameLoop() --just for tests
game_func=gameLoop
