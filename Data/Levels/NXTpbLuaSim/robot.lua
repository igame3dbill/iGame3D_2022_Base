-- Robot Demo1: ant.lua simple ant-brain-behaviour
--[[
console=0;

robot = {};
robot.console=0;
robot.direction=-1;

robot.collision=25;
robot.freedistance=50;

robot.highspeed=robot.direction*100;
robot.normalspeed=robot.direction*75;
robot.lowspeed=robot.direction*50;
robot.MotorA=1;
robot.MotorB=2;
robot.MotorC=3;
robot.Port1=1;
robot.Port2=2;
robot.Port3=3;
robot.Port4=4;


robot.radius=20;
robot.wheelradius=20;
robot.wheelcircumfence=2*nxt.pi()*robot.wheelradius;
robot.circumfence=2*nxt.pi()*robot.radius;


robot.print=function(mesg)
	if(0~=console) then	
		print(mesg) 
	else
		nxt.DisplayScroll();
		nxt.DisplayText(mesg);
	end
end

robot.forward=function(speed)
	robot.print("Forward("..speed..")");
	nxt.OutputSetSpeed(robot.MotorB,32,speed);
	nxt.OutputSetSpeed(robot.MotorC,32,speed);
	nxt.OutputSetTachoLimit(robot.MotorB,0);
	nxt.OutputSetTachoLimit(robot.MotorC,0);
end
robot.stop=function ()
	robot.print("Stop()");
	nxt.OutputSetSpeed(robot.MotorB,96,0);
	nxt.OutputSetSpeed(robot.MotorC,96,0);
end
robot.turn=function(degree)
	robot.print("Turn("..degree..")");
	--reset Tacho ?
	if(degree < 0) then
		nxt.OutputSetSpeed(robot.MotorB,32,robot.normalspeed);
		nxt.OutputSetSpeed(robot.MotorC,32,-1*robot.normalspeed);
	else
   		nxt.OutputSetSpeed(robot.MotorB,32,-1*robot.normalspeed);
		nxt.OutputSetSpeed(robot.MotorC,32,robot.normalspeed);

	end
	nxt.OutputSetTachoLimit(robot.MotorB,degree);
	nxt.OutputSetTachoLimit(robot.MotorC,degree);
end
robot.USRead=function (port)
	us=pollI2C(port,5,100)
	robot.print("US: "..us);
	return us;
end 
function busyWait(n)
	local t=nxt.TimerRead()
  	while t+n > nxt.TimerRead() do end
end
function setupI2C(port)
  	nxt.InputSetType(port,2)
  	nxt.InputSetDir(port,1,1)
  	nxt.InputSetState(port,1,1)
  	nxt.I2CTimer(3)
  	nxt.I2CInitPins(port)
end
function pollI2C(port,n,wait)
  	nxt.I2CSendData(port, string.char(0x02,0x41,0x02),3,0);
  	while( 0 ~= nxt.I2CGetStatus( port ) ) do 
  	end
  	nxt.I2CSendData( port, string.char( 0x02, 0x42), 2, 8 )
  	for i=1,n do
    	while( 0 ~= nxt.I2CGetStatus( port ) ) do end
    	s = nxt.I2CRecvData( port, 8 )
    	c1,c2,c3,c4,c5,c6,c7,c8 = string.byte(s,1,8)
    	nxt.I2CSendData( port, string.char( 0x02, 0x42), 2, 8 )
    	busyWait(wait)
  	end
  	return c1;
end

-- simple stupid sample from Leia and me to test robotAPI

robot.run=function()
	button=0;
	nxt.DisplayText("Press Button to stop");
	while (nxt.ButtonRead()==0) do
		us=robot.USRead(robot.Port1);robot.print("US===>"..us);
		if(us<=robot.collision)then
			robot.stop();
			robot.forward(-(robot.normalspeed));
			busyWait(1000);
			robot.turn(120);
		else 
			if(us>=robot.freedistance) then robot.forward(robot.highspeed);
			else robot.forward(robot.normalspeed)	end
		end;
	end;
	robot.stop();
end
--]]

setupI2C(robot.Port1);
robot.run();
-- Start program with robot.run()
