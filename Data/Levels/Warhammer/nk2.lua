
function bitAnd(zahl,stelle)
tmp = zahl%math.pow(2,(stelle))	
return ( tmp/math.pow(2,(stelle-1))>=1)	
end

function blub()
	print("blub")
end

function alleObjekteInnerhalbRadius(objectnumber,radius)

objekteInReichweite={}
for i=1,#gObjects do
	k=getObjectInfo(gObjects[objectnumber].cObj, IG3D_CLOSEST_POINTS, gObjects[i].cObj)
	if objectnumber == i then
		objekteInReichweite[i]=0
	
	elseif (k <= radius) then
		objekteInReichweite[i]=1
	else 	
	 	objekteInReichweite[i]=0
	end
end

return objekteInReichweite
end






function regimentsWerteAnModell(reg)


	for i=reg.start,reg.ende do
		gObjects[i].b=reg.b
		gObjects[i].origb=reg.b
		gObjects[i].kg=reg.kg
		gObjects[i].bf=reg.bf
		gObjects[i].s=reg.s-3
		gObjects[i].w=reg.w
		gObjects[i].lp=reg.lp
		gObjects[i].i=reg.i
		gObjects[i].a=reg.a
		gObjects[i].mw=reg.mw
		gObjects[i].rw=4 --//ruestungswurf 
		gObjects[i].rew=6 --//rettungswurf
		gObjects[i].team=reg.team
		gObjects[i].regiment=reg.index
		
		gObjects[i].modi={NKAngriff={},NKErstePhase={}, NKBasis={}, NKVerteidigung={} }
		gObjects[i].modi["NKAngriff"].s =4
		
		gObjects[i].modi.NKBasis.RBrechend = 1
		
		gObjects[i].charging = true
	end
end



function wuerfeln(anz,aufDie)
erfolge=0	
	for i=1,anz do
		--r=math.ceil(math.random(1,6))
		r=math.random(1,6)
		if r>=aufDie then
			erfolge=erfolge+1
		end
	end
return erfolge
end

function muenze()
return (math.random(1,2)%2)==1 
end


function treffenNahkampf(attacken,kg1,kg2)
	
	if kg1 <= (kg2 - kg1 - 1) then
		aufDie = 5
	elseif kg1 <= kg2 then
		aufDie = 4 
	else 
		aufDie = 3
	end
	
	
return wuerfeln(attacken,aufDie)
end


function ruestungswurf(verwundungen,effektiveS,rw)
return (verwundungen - wuerfeln(verwundungen,rw + effektiveS - 3))
end

function rettungswurf(verwundungen,rew)
return (verwundungen - wuerfeln(verwundungen,rew))
end

function verwunden(anz,s,w)
	if s >= w+2 then
		aufDie = 2
	elseif s == w+1 then
		aufDie = 3
	elseif s == w then
		aufDie = 4
	elseif s == w-1 then
		aufDie = 5
	elseif s == w-2 then
		aufDie = 6
	else 
		aufDie = 42
	end
return wuerfeln(anz,aufDie)
end


function nahkampfgegner(objectindex)
	i=objectindex
	nkgegner = {}
	for j=1,#gObjects,1 do
			
		k,x,y,z,x2,y2,z2,nx,ny,nz=getObjectInfo(gObjects[i].cObj, IG3D_CLOSEST_POINTS, gObjects[j].cObj)
		if gObjects[i].regiment ~= gObjects[j].regiment then	
			d=distance3d(x,y,z, x2,y2,z2)
					
			if (d <= 0.2) and  (gObjects[i].team ~= gObjects[j].team)  then 
				table.insert(nkgegner,j)
			end
		end
	end
return nkgegner
end



	function blub() 
print("blub")
end


function nahkampf(reg, nahkampfphase)
nahkampfphase = nahkampfphase or "NKBasis"
	for i=reg.start,reg.ende do
		local nkgegner = nahkampfgegner(i)
		if #nkgegner ~=0 then
			
						
			local feind = nkgegner[1]  -- hier sollte spaeter ausgewaehlt werden duerfen
			local kg1 = gObjects[i].kg
			local kg2 = gObjects[feind].kg
			local s   = gObjects[i].s
			local w   = gObjects[feind].w
			local rw  = gObjects[feind].rw		
			local rew  = gObjects[feind].rew
			local attacken = gObjects[i].a
			--print("vor charging if ",s )
			if (gObjects[i].charging) then
				
				if gObjects[i].modi[nahkampfphase].s ~= nil then s = s + gObjects[i].modi[nahkampfphase].s end
				if gObjects[i].modi[nahkampfphase].a ~= nil then attacken = attacken + gObjects[i].modi[nahkampfphase].a end
				
				local anzTreffer      = treffenNahkampf(attacken,kg1,kg2)
				local anzWunden       = verwunden(anzTreffer,s,w)
				if gObjects[i].modi[nahkampfphase].RBrechend ~= nil then s = s + gObjects[i].modi[nahkampfphase].RBrechend end
				local lpVerluste      = ruestungswurf(anzWunden,s,rw)
				local lpVerlusteFinal = rettungswurf(lpVerluste,rew)
				print("Modell ",i," hat bei ",attacken," Attacken ", anzTreffer, "Treffer und ",anzWunden," Wunden verursacht,", lpVerluste," LP-Verluste nach RW,",lpVerlusteFinal," LP-Verluste nach ReW")			
			--print("nach charging if ",s)
			end
		else
		print("Modell ",i," ist nicht im Nahkampf")		
		end
	end
	
end



--[[ zum testen mit
1= Speere, 2 = schw. Ruestung, 3 = zweihandwaffen, 4 = armbrust
]]
--[[
function regimentAusruesten(reg,
gObjects[i]

end
--]]









function test()
print("vorher")

einheitenAusXmlLaden(gameroot.."Data/testarmybuilder.xml")
print("nachher")
end


