-----------------------------------
-- Robot-API for Lua
-- VERSION
-- @Author: chrimo@moccy.xdsnet.de
-- @DATE: May 2007
-- @LASTCHANGE: today
-----------------------------------

-- Check environment: pbLua or Lua

local status,err = pcall(function () v=nxt._VERSION end);
-- print (status,err,v);
if(v==nil) then
	print (_VERSION);
	print ("-loading nxt-api.lua");
	dofile("./NXTLuaSimPBLua.lua");
	print ("-success");
	-- OS Types:NXT pbLua=0, murgaLua=1
	OS=1;
else
	print (nxt._VERSION);
	OS=0;
end



-- printout all pbLua function
-- just for testing or documentation
function ListpbLuaFunctions (_index) 
   print(_index,nxt[_index]); 
end 

-- table.foreach(nxt,ListpbLuaFunctions);    

 
--
-- Robot for Beginners Project --
-- Simple framework for kids or young people without programming experience
-- function are filled up step by step
--

motorA=1; -- motor connected to portA
motorB=2; -- motor connected to portB
motorC=3; -- motor connected to portC

defaultDirection=-1; --NXTOffRoad forward correction

touchSensor=1;
soundSensor=2;
lightSensor=3;
usSensor=4;

wheelRadius=975 --NXTOffRoad;
nearDistance=100; -- Distances in mm
farDistance=300;
freeDistance=500;

run=1;

robot = {}
robot.debug = 1;


function help()
print ("pbLua API documentation");
print("http://www.hempeldesigngroup.com/lego/pbLua/nxtFunctionDefs.html");
print("");
print("Simple Robot Framework");
print("robot.info()");
print("robot.run()");
print("robot.forward(power)");
print("robot.backward(power)");
print("robot.left(power)");
print("robot.right(power)");
print("robot.stop()");
print("robot.off()");
print("robot.idle(miliseconds)");
print("robot.beep(count)");
end;

function robot.help ()
	function ListpbLuaRobotFunctions (_index) 
   		print(_index,robot[_index]); 
	end 
 	table.foreach(robot,ListpbLuaRobotFunctions);    
end

function robot.info ()
	-- display some informations
	nxt.DisplayClear();
	nxt.DisplayText("Robot 0.1.00",0,0);
	nxt.DisplayText("OS:"..nxt._VERSION,0,8);
	nxt.DisplayText("Lua:".._VERSION,0,16);
	nxt.DisplayText("Battery:"..nxt.BatteryRead(),0,24);

	print("Robot 1.00");
	print("OS:"..nxt._VERSION);
	print("Lua:".._VERSION);
	print("Battery:"..nxt.BatteryRead().."mV");
end

function robot.forward (speed)
	-- drive motors forwards
	local s=speed*defaultDirection;
	if(robot.debug == 1) then 
		if s > 0 then 
			print ("Backward:"..nxt.abs(s)); 
		else 
			print ("Forward:"..nxt.abs(s)); 
		end
	end
	
	nxt.OutputSetSpeed(motorB,32,s)
	nxt.OutputSetSpeed(motorC,32,s)
	
	local newX, newY, newDir;
	newX=currX;
	newY=currY;
	
	if(currDir==1) then
		if(s*defaultDirection<0) then
			newY=currY-(defaultDirection*AreaSize);
		end
		if(s*defaultDirection>0) then
			newY=currY+(defaultDirection*AreaSize);
		end
	end

	if(currDir==3) then
		if(s*defaultDirection>0) then
			newY=currY-(defaultDirection*AreaSize);
		end
		if(s*defaultDirection<0) then
			newY=currY+(defaultDirection*AreaSize);
		end
	end

	if(currDir==2) then
		if(s*defaultDirection<0) then
			newX=currX-(defaultDirection*AreaSize);
		end
		if(s*defaultDirection>0) then
			newX=currX+(defaultDirection*AreaSize);
		end
	end

	if(currDir==4) then
		if(s*defaultDirection>0) then
			newX=currX-(defaultDirection*AreaSize);
		end
		if(s*defaultDirection<0) then
			newX=currX+(defaultDirection*AreaSize);
		end
	end

	newDir=currDir;
	nxt.SimPositionSet(newX,newY,newDir);
	currX=newX;
	currY=newY;
	currDir=newDir;
	
	if(robot.debug == 1) then print("-Results X:"..newX.." Y:"..newY.." Dir:"..newDir) end
	
	if(OS) then nxt.GUIredraw() end
end

function robot.backward (speed)
	-- drive motors backwards
	local s=speed;
	-- robot.beep(3);
	robot.forward(-s);
	if(OS) then nxt.GUIredraw() end
end


function robot.right (speed)
	-- turn right
	local s=speed*defaultDirection;
	if(robot.debug ==1 ) then 
		if s < 0 then 
			print ("Right:"..nxt.abs(s));
			M1slider:value(nxt.abs(s));
		else 
			print ("Left:"..nxt.abs(s));
			M2slider:value(nxt.abs(s));
		end;
	end;
	if(OS) then nxt.GUIredraw() end
	-- robot.beep(1);
	nxt.OutputSetSpeed(motorA,0,0)
	nxt.OutputSetSpeed(motorB,0,0)
	nxt.OutputSetSpeed(motorA,32,(s))
	nxt.OutputSetSpeed(motorB,32,-(s))
	
	local newX, newY, newDir;

	newDir=currDir;
	newX=currX;
	newY=currY;
	nxt.SimPositionSet(newX,newY,newDir);
	currX=newX;
	currY=newY;
	currDir=newDir;
	
	
	if(OS) then nxt.GUIredraw() end

end

function robot.left (speed)
	-- turn left
	local s=speed;
	-- robot.beep(1);
	robot.right(-s);
	if(OS) then nxt.GUIredraw() end
end


function robot.stop ()
	-- stop all motors
	if(robot.debug == 1) then print ("Stop:"); end
	nxt.OutputSetSpeed(motorA,96,0)
	nxt.OutputSetSpeed(motorB,96,0)
	nxt.OutputSetSpeed(motorA,0,0)
	nxt.OutputSetSpeed(motorB,0,0)
	if(OS) then nxt.GUIredraw() end
end

function robot.turn (degree)
	-- turn robot +- degree
	
	if(robot.debug == 1) then print ("Turn:"..degree); end;
	local newX=currX;
	local newY=currY;
	local newDir=currDir;
	
	if(degree < 0) then neg=-1 else neg=1 end; 
	absdegree=math.abs(degree);
	
	if((absdegree >0) and (absdegree <= 90)) then newDir=currDir+1*neg end;
	if((absdegree >90) and (absdegree <= 180)) then newDir=currDir+2*neg end;
	if((absdegree >180) and (absdegree <= 270)) then newDir=currDir+3*neg end;
	if((absdegree >270) and (absdegree <= 360)) then newDir=currDir+4*neg end;
	
	if((degree >-1) and (degree < 1)) then newDir=currDir end

	
	
	nxt.SimPositionSet(newX,newY,newDir);
	if(OS) then nxt.GUIredraw() end
end

function robot.idle (ms)
	-- sleep for some milliseconds
	local now=nxt.TimerRead();
	if(robot.debug == 1) then print ("Idle:"..ms); end
	while(nxt.TimerRead() <= (now + ms)) do
		if(OS) then nxt.GUIredraw() end
	end;
end

function robot.beep (beepcount)
	-- simple beep, later as coroutine to avaid delays with motors or sensors
	local b=beepcount;
	local f1=880;
	local t1=250;
	local vol=1;
	local i=0;
	if(robot.debug ==1 ) then print ("Beep:"..b); end
	if beepcount==NIL then 
		beepcount=1;
	else
		for i=1,beepcount do
			while(nxt.SoundGetStatus() == 0) do end
			nxt.SoundTone(f1,t1,vol)
			robot.idle(250); -- 250 milliseconds
			if(OS) then nxt.GUIredraw() end
		end
	end
end

function robot.off ()
	-- power off the robot
	print("ByeBye");
	-- robot.beep(5);
	robot.idle(1000);
	nxt.PowerDown();
	if(OS) then nxt.GUIredraw() end
end

function robot.explore ()
	-- explore the world
	if(robot.debug ==1) then print ("Exploring:"); end
	if(OS) then nxt.GUIredraw() end
end

function robot.take ()
	-- take some goods with TriBot tools
	if(robot.debug == 1) then print ("Taking:"); end
	if(OS) then nxt.GUIredraw() end
end

function robot.findline (sec)
	-- find and follow lines for n seconds
	if(robot.debug == 1) then print ("Find line:"); end
	if(OS) then nxt.GUIredraw() end
end

function robot.play (signal)
	if(robot.debug == 1) then print ("Playing:"); end
	--play sound melody signal
	--seaship signals for moving change
	--SOS: ...---...
	--turn right signal
	--turn left signal ..
	--attention signal -
	--backwards signal ...
	--general problem signal ....
	if(OS) then nxt.GUIredraw() end
end

function robot.button ()
	-- return button state
	if(robot.debug == 1) then print ("Button:"); end
	local s=0;
	s=nxt.ButtonRead();
	if s== 0 then robot.nop() end --bla bla test
	if s== 1 then robot.nop() end
	if(OS) then nxt.GUIredraw() end
	return s
end

function robot.nop ()
	-- do nothing
end

function robot.calibrateIR ()
	-- calibrate the Lightsensor for bright and dark
	if(robot.debug == 1) then print ("CalibrateIR:"); end
	print("Put the Robot lightsensor at the brightest area and press a button <left>");
	print("Put the Robot lightsensor at the darkest area (line) and press a button <right>");
	robot.button()
	if(OS) then nxt.GUIredraw() end
end

function robot.calibrateUS ()
-- calibrate the Lightsensor for bright and dark
	if(robot.debug) then print ("CalibrateUS:"..s); end
	print("Put the Robot Ultrasonicsensor at the nearest destination and press a button <left>");
	print("Put the Robot Ultrasonicsensor at the farest destination target and press a button <right>");
	robot.button()
	if(OS) then nxt.GUIredraw() end
end

function robot.USRead (port)
	-- Read value from ultrasonic sensor
	if(OS) then nxt.GUIredraw() end
	local d;
	d=pollI2C(4,1,50);
	if(robot.debug == 1) then print ("USRead:"..d) end;
	return d;
end

function robot.LSRead (port)
	-- Read value from light sensor
	nxt.InputSetDir( port, 0, 0)
	local light = nxt.InputGetState(port)
	if(OS) then nxt.GUIredraw() end
	if(robot.debug == 1) then print ("LSRead:"..light) end;
	return light;
end

function robot.SSRead (port)
	-- Read value from sound sensor
	nxt.InputSetDir( port, 0, 0)
	local sound = nxt.InputGetState(port)
	if(OS) then nxt.GUIredraw() end
	if(robot.debug == 1) then print ("SSRead:"..sound) end;
	return sound;
end

function robot.BSRead (port)
	-- Read value from button sensor
	nxt.InputSetDir( port, 0, 0)
	local button = nxt.InputGetState(port)	
	if(OS) then nxt.GUIredraw() end
	if(robot.debug == 1) then print ("BSRead:"..button) end;
	return button;
end

function robot.I2CRead (port,address)
	-- Read value from I2C device
	if(OS) then nxt.GUIredraw() end
	return nxt.random(255);
end

function robot.I2CWrite (port,address,data)
	-- Write value to I2C device
	if(OS) then nxt.GUIredraw() end
	return 1;
end

function robot.RS485Read ()
	if(OS) then nxt.GUIredraw() end
	return nxt.randowm(255);
end

function robot.RS485Write (data)
	if(OS) then nxt.GUIredraw() end
	return (#data);
end


-- Working US-Code from Ralph Hempel (Test1)

function busyWait(n)
  local t=nxt.TimerRead()
  while t+n > nxt.TimerRead() do
  	if(OS) then nxt.GUIredraw() end
  end
end

function setupI2C(port)
  nxt.InputSetType(port,2)
  nxt.InputSetDir(port,1,1)
  nxt.InputSetState(port,1,1)

  nxt.I2CTimer(3)
  nxt.I2CInitPins(port)
end

function checkI2C(port)
  setupI2C(port);

  nxt.I2CSendData( port, string.char( 0x02, 0x00), 2, 8 )
  while( 0 ~= nxt.I2CGetStatus( port ) ) do
  end
  s = nxt.I2CRecvData( port, 8 )
  print( "Version " .. s )

  nxt.I2CSendData( port, string.char( 0x02, 0x08), 2, 8 )
  while( 0 ~= nxt.I2CGetStatus( port ) ) do
  end
  s = nxt.I2CRecvData( port, 8 )
  print( "Product ID " .. s )

  nxt.I2CSendData( port, string.char( 0x02, 0x10), 2, 8 )
  while( 0 ~= nxt.I2CGetStatus( port ) ) do
  end
  s = nxt.I2CRecvData( port, 8 )
  print( "SensorType " .. s )
end

function pollI2C(port,n,wait)
  -- checkI2C(port)
  local i,s;
  nxt.I2CSendData( port, string.char( 0x02, 0x41,0x02 ), 3, 0 )
  while( 0 ~= nxt.I2CGetStatus( port ) ) do
    end

  nxt.I2CSendData( port, string.char( 0x02, 0x42), 2, 8 )

  for i=1,n do
    while( 0 ~= nxt.I2CGetStatus( port ) ) do
      end
    s = nxt.I2CRecvData( port, 8 )
    c1 = string.byte(s,1,8)
    -- print( string.format( "I2C-Result: %3i", c1 ) )

    nxt.I2CSendData( port, string.char( 0x02, 0x42), 2, 8 )
    busyWait(wait)
  end
  -- return c1;
  return s;
end

