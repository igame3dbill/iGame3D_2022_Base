--
-- NXT special function table
-- helper functions to do test with Lua
--
-- @Author: chrimo@moccy.xdsnet.de
-- @Date: 10.March 2007
--


nxt = {};
nxt._VERSION="pbLua API Beta 13o"; 
nxt.I2CGetStatus = function () end;

nxt.DisplayText = function (str) 
	if(nxt.debug == 1) then print ("Display:"..str) end;
	nxtdisplay:insert(str.."\n");
	nxt.GUIredraw();
end;

nxt.ButtonRead = function ()
	if(run == 0) then 
		return -1; 	
	else 
		return nxt.random(0,15);
	end;
end;

nxt.TimerRead = function () return 1000*os.time() end;
nxt.BatteryRead = function () return 7500 end;
nxt.PowerDown = function () exit() end;
nxt.Reflash = function () print ("tick tick tick") end;
nxt.random = function () return math.random(1000000) end;
nxt.abs = function (v) return math.abs(v) end;
nxt.min = function (string) return math.min(string) end; 	
nxt.max = function (string) return math.max(string) end; 	
nxt.sign = function (string) return math.sign(string) end; 	
nxt.bnot = function (x) return not x  end; 	
nxt.band = function (x,y) return  x and y end; 	
nxt.bor = function (x,y) return x or y end; 	
-- nxt.bxor = function (x,y) return  x xor y end; 	
nxt.tofloat = function (string) return (string) end; 
nxt.toint = function (string) return toint(string) end;
nxt.add = function () end; 	
nxt.sub = function () end; 	
nxt.mul = function () end; 	
nxt.div = function () end; 	
nxt.sin = function () end; 	
nxt.cos = function () end; 	
nxt.tan = function () end; 	
nxt.asin = function () end; 	
nxt.acos = function () end; 	
nxt.atan = function () end; 	
nxt.atan2 = function () end; 	
nxt.pi = function () return (3.14) end; 	
nxt.exp = function () end; 	
nxt.exp = function () end; 	
nxt.log = function () end; 	
nxt.log10 = function () end; 	
nxt.sqrt = function () end; 	
nxt.ceil = function () end; 	
nxt.floor = function () end; 	
nxt.DisplayClear = function () print ("") print ("CLS :D") end; 	
nxt.DisplayPixel = function (x,y) print ("x:"..x.." y:"..y) end; 	
nxt.DisplayGetPixel = function () return 0 end; 	
nxt.DisplayScroll = function () end; 	
nxt.SoundGetStatus = function () return 1 end; 	
nxt.SoundTone = function ()  print ("\b") end; 	
nxt.SoundMelody = function () print ("\b\b\b") end; 	
nxt.InputSetType = function () end; 	
nxt.InputSetDir = function () end; 	
nxt.InputSetState = function () end;
-- this works with SIM only, console should be added
nxt.InputGetState = function (port)
	if(port==3) then
		return S3slider:value();
	end
	if(port==2) then
		return S2slider:value();
	end
	if(port==1) then
		return S1slider:value();
	end
end; 	

nxt.I2CTimer = function () end; 	
nxt.I2CInitPins = function (x) end; 	
nxt.I2CSendData = function (x,y) end; 	

-- nxt.I2CReceiveData = function (x,y) return math.random(255) end; 	

nxt.I2CRecvData = function (x,y)
	return S4slider:value(); 
end; 	

nxt.I2CGetStatus = function () 
	return 0;
	-- return nxt.random(0,1); 
end; 	

nxt.RS485Enable = function () end; 	
nxt.RS485SendData = function () end; 	
nxt.RS485ReceiveData = function () end; 	
nxt.OutputSetRegulation = function () end; 	
nxt.OutputGetMotorStatus = function () return 0 end; 	
nxt.OutputResetTacho = function () end; 	
nxt.OutputSetPID = function () end; 	
nxt.OutputSetSpeed = function () end; 	
nxt.OutputSetTachoLimit = function () end; 	
nxt.SetTachoLimit = function () end;
nxt.BtFactoryReset = function () end; 	
nxt.BtPower = function () end; 	
nxt.BtGetStatus = function () return 0 end; 	
nxt.BtSearch = function () end; 	
nxt.BtGetDeviceEntry = function () return 0 end; 	
nxt.BtSetName = function () end; 	
nxt.BtSetPIN = function () end; 	
nxt.BtGetConnectEntry = function () return 0 end;
 	
nxt.BtConnect = function () end; 	
nxt.BtDisconnect = function () end; 	
nxt.BtDisconnectAll = function () end; 	
nxt.BtStreamMode = function () end; 	
nxt.BtStreamSend = function () end; 	
nxt.BtStreamRecv = function () end; 	


nxt.GUIredraw = function ()
	if(OS) then
		Fl:check();
		
		nxtpic:redraw();
		
		M1slider:redraw();
		M2slider:redraw();
		M3slider:redraw();
	
		S1slider:redraw();
		S2slider:redraw();
		S3slider:redraw();
		S4slider:redraw();
		
		nxtdisplay:redraw();
		
		NXTSprite:redraw();
		
		nxtwindow:redraw();
		ctrlwindow:redraw();
		simwindow:redraw();
		iowindow:redraw();
		Fl:check();
	else
	end
end

nxt.SimNewPositionCalc = function (x,y,dir)
	
	--calc new position
	v=1;
	dt=1;
	
	x=x+v*dt*math.sin(angle)
	y=y+v*dt*math.cos(angle)

	return x,y,dir
end

nxt.SimPositionDraw = function (x,y,dir)
	local X,Y,Dir;
	X=x;
	Y=y;
	Dir=dir	
	if(robot.debug==1) then print("RobotCurrentPosition: X="..X.." Y="..Y.." Dir="..Dir) end;
	
	-- check world out of range 
	if(X<0) then run=0 end
	if(Y<0) then run=0 end
	if(X>WorldX) then run=0 end
	if(Y>WorldY) then run=0 end

	--draw new
	NXTSprite:image(SpriteImage[Dir]);
	NXTSprite:position(X,Y);
    	NXTSprite:redraw();
	currDir=Dir;
	currX=X;
	currY=Y;	
	nxt.GUIredraw();	
end


nxt.SimPositionSet = function (x,y,dir)
	local X,Y,Dir;
	X=x;
	Y=y;
	Dir=dir	
	--print("SimPosSet X:"..X.." Y:"..Y.." Dir:"..Dir);
	-- check world range ?
	if(X<0) then run=0 end
	if(Y<0) then run=0 end
	if(X>WorldX) then run=0 end
	if(Y>WorldY) then run=0 end
	
	if(Dir>=5) then Dir=1 end;
	if(Dir<=-5) then Dir=-1 end;
	
	if((Dir>-1) and (Dir<1)) then Dir=dir end;
	
	--draw new
	if(robot.debug==1) then print("RobotCurrentPosition: X="..X.." Y="..Y.." Dir="..Dir) end;
	NXTSprite:image(SpriteImage[Dir]);
	NXTSprite:position(X,Y);
    	NXTSprite:redraw();
	currDir=Dir;
	currX=X;
	currY=Y;	
	nxt.GUIredraw();	
end

nxt.SimInit = function ()
	currX=math.floor(WorldX/2);
	currY=math.floor(WorldY/2);
	currDir=1;	
	print("InitialPosition: X="..currX.." Y="..currY.." Dir="..currDir);
	currDir=1;
	RobotLoopCount=0
end

nxt.SimAbort = function ()
	print ("Done. Program aborted.");
	nxt.GUIredraw();
end

nxt.idle = function (ms)
	-- sleep for some milliseconds
	local now=nxt.TimerRead();
	if(robot.debug == 1) then print ("Idle:"..ms); end
	while(nxt.TimerRead() <= (now + ms)) do
		nxt.GUIredraw();
		if(OS) then nxt.GUIredraw() end
	end;
end

nxt.RobotLoopCountView = function()
	RobotLoopCount=RobotLoopCount+1;
	print("RobotLoopCount:-->"..RobotLoopCount);
end

nxt.InitSinCosTable = function ()
	-- precalculated sin cos
	local angle;
	sin = {};
	cos = {};
	for angle=0,360,90 do
		sin[angle]=math.sin(angle);
		cos[angle]=math.cos(angle);
		print("Angle:"..angle.." sin:"..sin[angle].." cos:"..cos[angle]);
	end;
end

--pbLuaAPI by Chrimo.xdsnet.de
--created by script

nxt.I2CInitPins = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.BtConnect = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.OutputSetPID = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.fneg = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.RS485Enable = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.floor = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.max = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.sqrt = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.BtSetPIN = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.BtStreamRecv = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.mul = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.RS485SendData = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.pow = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.BatteryRead = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.atan = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.tofloat = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.BtGetStatus = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.tan = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.cos = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.BtGetDeviceEntry = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.ceil = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.PowerDown = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.bor = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.InputSetDir = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.asin = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.min = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.BtStreamSend = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.sin = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.add = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.OutputSetTachoLimit = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.BtGetConnectEntry = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.fabs = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.I2CSendData = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.InputSetState = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.random = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.I2CRecvData = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.pi = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.SoundGetStatus = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.div = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.DisplayScroll = function ()
	--replace with lua wrapper functions
	return 0
end

nxt._VERSION = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.MemInfo = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.InputSetType = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.BtStreamMode = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.I2CGetStatus = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.RS485RecvData = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.MemRead = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.exp = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.ButtonRead = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.SoundMelody = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.BtFactoryReset = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.acos = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.BtDisconnectAll = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.bnot = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.toint = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.atan2 = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.BtSearch = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.BtVisible = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.BtPower = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.DisplayPixel = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.OutputGetStatus = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.BtSetName = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.Reflash = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.OutputSetSpeed = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.sub = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.OutputResetTacho = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.DisplayText = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.DisplayClear = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.abs = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.MemWrite = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.InputGetState = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.TimerRead = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.bxor = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.DisplayGetPixel = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.OutputSetRegulation = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.log10 = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.sign = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.SoundTone = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.BtDisconnect = function ()
	--replace with lua wrapper functions
	return 0
end

nxt.band = function ()
	--replace with lua wrapper functions
	return 0
end

dofile("robotAPI.lua")

--[[
pbLua Beta 13o
> 
> -- printout all pbLua function
> -- just for testing or documentation
> function ListpbLuaFunctions (_index) 
>>    print(_index,nxt[_index]); 
>> end 
> 
> -- table.foreach(nxt,ListpbLuaFunctions);    
> table.foreach(nxt,ListpbLuaFunctions);
log     function:0x2034d8
I2CInitPins     function:0x205a68
BtConnect       function:0x205fc0
OutputSetPID    function:0x205cf8
fneg    function:0x2050b4
RS485Enable     function:0x205b68
floor   function:0x203548
max     function:0x203114
sqrt    function:0x203414
BtSetPIN        function:0x205ec4
BtStreamRecv    function:0x205f40
mul     function:0x2030dc
RS485SendData   function:0x205ba8
pow     function:0x203484
BatteryRead     function:0x2032ac
atan    function:0x205374
tofloat function:0x205290
BtGetStatus     function:0x205dc0
tan     function:0x2033dc
cos     function:0x203ed0
BtGetDeviceEntry        function:0x205e00
ceil    function:0x2053ac
PowerDown       function:0x20326c
bor     function:0x2051e8
InputSetDir     function:0x2059a8
asin    function:0x205304
min     function:0x20314c
BtStreamSend    function:0x205f00
sin     function:0x20344c
add     function:0x2031bc
OutputSetTachoLimit     function:0x205d78
BtGetConnectEntry       function:0x205e44
fabs    function:0x203580
I2CSendData     function:0x205aa8
InputSetState   function:0x2059e8
random  function:0x2050ec
I2CRecvData     function:0x205b28
pi      function:0x2034a0
SoundGetStatus  function:0x206174
div     function:0x203184
DisplayScroll   function:0x205864
_VERSION        pbLua Beta 13o
MemInfo function:0x2062a8
InputSetType    function:0x205a28
BtStreamMode    function:0x205f80
I2CGetStatus    function:0x205ae8
RS485RecvData   function:0x205be8
MemRead function:0x206230
exp     function:0x2035b8
ButtonRead      function:0x2032e8
SoundMelody     function:0x2061b4
BtFactoryReset  function:0x206134
acos    function:0x2052cc
BtDisconnectAll function:0x2060f0
bnot    function:0x205178
toint   function:0x205258
atan2   function:0x20533c
BtSearch        function:0x206074
BtVisible       function:0x206038
BtPower function:0x205ffc
DisplayPixel    function:0x2058e4
OutputGetStatus function:0x205c70
BtSetName       function:0x205e88
Reflash function:0x203230
OutputSetSpeed  function:0x205d38
sub     function:0x20515c
OutputResetTacho        function:0x205cb4
DisplayText     function:0x2058a4
DisplayClear    function:0x205824
abs     function:0x2031f4
MemWrite        function:0x20626c
InputGetState   function:0x205968
TimerRead       function:0x203324
bxor    function:0x205220
DisplayGetPixel function:0x205924
OutputSetRegulation     function:0x205c28
log10   function:0x203510
sign    function:0x205124
SoundTone       function:0x2061f4
BtDisconnect    function:0x2060b0
band    function:0x2051b0
--]]