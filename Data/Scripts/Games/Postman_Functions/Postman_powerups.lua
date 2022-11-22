function drink_coffee()
	gPlayer.speed=20
end

function normal_speed()
	gPlayer.speed=10
end

function talk_to_grandma()
	gPlayer.speed=0
end


gCoffeeEmitter=gParticleEmitters[1]
setParticle_emitterInfo(gCoffeeEmitter, IG3D_POSITION, 6,1,6)


gPowerUps={}


gCoffee={ fn1=drink_coffee, fn2=normal_speed, pickupTime=0, timeout=20, str="Yeah, du hast Kaffee getrunken und\nbewegst dich doppelter Geschwindigkeit!" }
gGrandma={ fn1=talk_to_grandma, fn2=normal_speed, pickupTime=0, timeout=10, str="Oh nein! Du hast eine Oma getroffen, die dir\neine Frikadelle ans Ohr quatscht!"}

gPowerUpsInTheField={}
cup1={powerup=gCoffee, x=6, y=0.1, z=gRoads[1].offset, emt=gParticleEmitters[1]}
table.insert(gPowerUpsInTheField, cup1)


function pickup_powerup(powerup)
	if #gPowerUps > 0 then
		if gPowerUps[1]==gGrandma and powerup==gGrandma then return end
	end
	gPowerUps={}--remove everything
	table.insert(gPowerUps, powerup)
	powerup.pickupTime=time()
	powerup.fn1()
end

function handle_powerups()
	for i=#gPowerUps,1,-1 do
		if time()>gPowerUps[i].timeout+gPowerUps[i].pickupTime then
			gPowerUps[i].fn2()
			table.remove(gPowerUps, i)
		end
	end
	
	for i=#gPowerUpsInTheField,1,-1 do
		setParticle_emitterInfo(gPowerUpsInTheField[i].emt, IG3D_POSITION, gPowerUpsInTheField[i].x,gPowerUpsInTheField[i].y,gPowerUpsInTheField[i].z)
		setParticle_emitterInfo(gPowerUpsInTheField[i].emt, IG3D_START)
		local px,py,pz=getObjectInfo(gPlayer.cObj, IG3D_POSITION)
		if vecLength(px-gPowerUpsInTheField[i].x, 0, pz-gPowerUpsInTheField[i].z)<2 then
			pickup_powerup(gPowerUpsInTheField[i].powerup)
			table.remove(gPowerUpsInTheField,i)
		end
	end
	
end

function getPowerUpsString()
	str=""
	for i=1,#gPowerUps,1 do
		str=str..gPowerUps[i].str.."\n"
		if gPowerUps[i]==gGrandma then
			str=str.."Noch "..tostring(math.floor(gPowerUps[i].pickupTime+gPowerUps[i].timeout-time())).." Sekunden warten\n"
		end
		if gPowerUps[i]==gCoffee then
			str=str.."Wirkt noch "..tostring(math.floor(gPowerUps[i].pickupTime+gPowerUps[i].timeout-time())).." Sekunden"
		end
	end
	return str
end