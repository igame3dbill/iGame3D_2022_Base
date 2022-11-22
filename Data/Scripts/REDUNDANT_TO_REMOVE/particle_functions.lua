emt={}
emt.fireball={}
emt.flaming={}


function SETemitterStyle(whichEmitter,style)
doit="emitter=".."emt."..style
loadstring(doit)()
for i,v in pairs(emitter) do
emissionCommand= GETEmitterStyle(whichEmitter,style,i)
--print(emissionCommand)
loadstring(emissionCommand)()
end
end

function GETEmitterStyle(whichEmitter,style,what)
if whichEmitter == nil then style = "fireball" end
if what ~= nil then
emitter="m=".."emt."..style.."."..what
loadstring(emitter)()
result="setParticle_emitterInfo(".. whichEmitter..",IG3D_"..what..",".. m..")"
return result
endend

function setEmitters()
emt.flaming.AMOUNT=-1emt.flaming.EMISSION_RATE=0.10000emt.flaming.LIFE_TIME=12.000000emt.flaming.FADE_TIME=11.2000000emt.flaming.AREA=0.200000emt.flaming.SIZE=1.100000emt.flaming.SIZE_VARIANCE=2.000000emt.flaming.LUX="true"emt.flaming.MASS=-0.000100emt.flaming.PARTICLE_EXPLOSION="false,-0.060000"emt.flaming.PARTICLE_MOVEMENT="true,0.100000"emt.flaming.PARTICLE_SCALE="false,9.000000"emt.flaming.PARTICLE_ROTATION="false,-90.000000"emt.flaming.ANIMATION="false,0"emt.flaming.SPEED=1emt.flaming.ANIMATION="true,".."\"".."Images/fire-animated.mov".."\""

emt.fireball.TEXTURE="\"".."Images/fire-animated.mov".."\""emt.fireball.AMOUNT=-1emt.fireball.EMISSION_RATE=0.10000emt.fireball.LIFE_TIME=12.000000emt.fireball.FADE_TIME=11.2000000emt.fireball.AREA=0.200000emt.fireball.SIZE=1.100000emt.fireball.SIZE_VARIANCE=2.000000emt.fireball.LUX="true"emt.fireball.MASS=-0.000100emt.fireball.PARTICLE_EXPLOSION="false,-0.060000"emt.fireball.PARTICLE_MOVEMENT="true,0.100000"emt.fireball.PARTICLE_SCALE="false,9.000000"emt.fireball.PARTICLE_ROTATION="false,-90.000000"emt.fireball.ANIMATION="false,0"emt.fireball.SPEED=1emt.fireball.ANIMATION="true,".."\"".."Animations/fire-animated.mov".."\""
end
setEmitters()
SETemitterStyle("anyemitter","flaming")



firename,firepath = "fire001","Data/Emitters/firebig.emt"
function newEmitter(name,path)
local i = #gParticleNamesAndEMTs+1
if name == nil then 
name ="fire00"..i
path = "Data/Emitters/firebig.emt"
end
local cx,cy,cz = getCameraInfo(IG3D_POSITION)
table.insert(gParticleNamesAndEMTs,{name,path})
table.insert(gParticlePositions,{cx,cy,cz})
table.insert(gParticleRotations,{0,0,0})

gParticleEmitters[i]={}
gParticleEmitters[i]=make(ig3d_particle_emitter, gParticleNamesAndEMTs[i][1], gParticleNamesAndEMTs[i][2])

	setParticle_emitterInfo(gParticleEmitters[i], IG3D_POSITION, gParticlePositions[i][1],gParticlePositions[i][2],gParticlePositions[i][3])
	
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_ROTATION, gParticleRotations[i][1],gParticleRotations[i][2],gParticleRotations[i][3])
	runningParticle = get(ig3d_particle_emitter, name)
setParticle_emitterInfo(runningParticle, IG3D_START)
end

