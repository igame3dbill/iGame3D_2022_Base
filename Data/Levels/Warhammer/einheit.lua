dofile(gameroot.."Data/Levels/Warhammer/tools/mathe.lua")
-------------	Einheit
Einheit={}
function Einheit:new(n,gs)
	local instance={modelle={}, name=n, gliederstaerke=gs, baseL=1, baseB=1}
	setmetatable(instance, self)
	self.__index=self
	return instance
end

function Einheit:anzahlGlieder()
	return math.ceil(self:anzahl() / self.gliederstaerke)
end

function Einheit:gliederbonus()
	if self.gliederstaerke<5 then return 0 end	--Keine Glieder mit weniger als 5 modellen
	local g=math.floor(self:anzahl() / self.gliederstaerke)-1
	if self:anzahl() % self.gliederstaerke >= 5 then
		g=g+1 --unvollständiges letztes Glied mit mind. 5 Modellen zählt mit
	end
	return math.min(g,3)	--Gliederbonus von 3 wird nicht überschritten
end

function Einheit:anzahl()
	return #self.modelle
end

function Einheit:printName()
	print(self.name)
end

function Einheit:hinzu(obj)
	table.insert(self.modelle, obj)
	local i
	for i=1,#self.modelle-1,1 do
		setObjectInfo(self.modelle[#self.modelle].cObj, IG3D_IGNORE_COLL, true, ig3d_object, self.modelle[i].cObj)
	end
end

function Einheit:weg(obj)
	local i
	for i=1,#self.modelle,1 do
		if self.modelle[i]==obj then table.remove(self.modelle, i) break end
	end
end

function Einheit:formieren(x,y,z, xa,ya,za)
	local i

	setObjectInfo(self.modelle[1].cObj, IG3D_ROTATION, xa,ya,za)
	setObjectInfo(self.modelle[1].cObj, IG3D_POSITION, x,y,z)
	local mat=build4x4matrix(self.modelle[1])
	
	local tx=0
	local tz=0
	for i=1,#self.modelle,1 do
		local dx,dy,dz=matrixtransform(mat, -tx,0,tz)
		setObjectInfo(self.modelle[i].cObj, IG3D_ROTATION, xa,ya,za)
		setObjectInfo(self.modelle[i].cObj, IG3D_POSITION, dx,dy,dz)
		setObjectInfo(self.modelle[i].cObj, IG3D_VELOCITY, 0,0,0)
		setObjectInfo(self.modelle[i].cObj, IG3D_OMEGA, 0,0,0)
		setObjectInfo(self.modelle[i].cObj, IG3D_GRAVITY_MULTIPLIER, 1)
		setObjectInfo(self.modelle[i].cObj, IG3D_VECTOR_CONSTRAINT, 0,1,0)
		tx=tx+self.baseB
		if ( i % self.gliederstaerke == 0) then 
			tz=tz-self.baseL
			tx=0 
		end
	end
end


function Einheit:regimentWerteSetzen()
	for i=1,#self.modelle,1 do
		self.modelle[i].b=self.b
		self.modelle[i].kg=self.kg
		self.modelle[i].bf=self.bf
		self.modelle[i].s=self.s
		self.modelle[i].w=self.w
		self.modelle[i].lp=self.lp
		self.modelle[i].i=self.i
		self.modelle[i].a=self.a
		self.modelle[i].mw=self.mw
		self.modelle[i].rw=self.rw
		self.modelle[i].rew=self.rew
		self.modelle[i].UNUSED1=self.UNUSED1
		self.modelle[i].UNUSED2=self.UNUSED2
		self.modelle[i].es=self.es
	end
end

-------------	Plänkler
Plaenkler=Einheit:new("")	--Plänkler ist sub-klasse von Einheit
function Plaenkler:new(n)
	local instance=Einheit:new(n)
	setmetatable(instance, self)
	self.__index=self
	return instance
end

function Plaenkler:m()
	beep()
end


-------------	Kundschafter
Kundschafter=Einheit:new("")	--Kundschafter ist sub-klasse von Einheit
function Kundschafter:new(n)
	local instance=Einheit:new(n)
	setmetatable(instance, self)
	self.__index=self
	return instance
end

function Kundschafter:m()
	beep()
end



dofile(gameroot.."Data/Levels/Warhammer/xmlladen.lua")