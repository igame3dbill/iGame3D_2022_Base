function printTable(_table,rek)
if type (_table) ~= "table" then
	print("Funktion printTable bekam Arg. vom Typ "..type(_table)..", Inhalt:")
	print(_table)
return
end

rek = rek or ""
	for index, inhalt  in pairs(_table) do
  		if type(_table[index]) == "table" then

			 printTable(_table[index], string.format("%s[%s]",rek,index))
		else
			output = "["..index.."]".." = "..tostring(inhalt)
			output = string.format("%s%s",rek,output)
			print("table"..output)
		end  	
  	end
end


--alle mit gleichem counter_top_level gehören zum selben regiment
--counter_regimenter = 1 -> basisregiment; counter_regiment>1 ->boss, pferde etc.
function einheitenAusXmlLaden(pfad)


	xmldata=murgaLua.importXmlFile(pfad)
	--printTable(xmldata)

	local roster=murgaLua.findXmlNode(xmldata, "document/roster")
	if roster==nil then print("Der roster ist leer, scheint kein armybuilder file an der angegeben Stelle (pfad) zu sein") return end

	einheiten={}
	counter_top_level=1
	
	--größte "Einheit" bei AB
	while murgaLua.findNextXmlNode(roster, "top_level",counter_top_level)~= nil do
		top_level=murgaLua.findNextXmlNode(roster, "top_level",counter_top_level)
		
		regimentsAttribute = {mw=0,b=0}
	
		--einmal eingerückt
		for counter_regimenter=1,42 do
		
		sub_regimenter = false
		counter_sub_regimenter = 1
			
			--zweimal eingerückt, z.b. charakter auf streitwagen
			repeat
			
				local regiment=murgaLua.findNextXmlNode(top_level, "regiment")
				if counter_regimenter ~= 1 then
					regiment=murgaLua.findNextXmlNode(regiment, "regiment",counter_regimenter-1)
				end
				
				regiment_vor_sub = regiment
				if sub_regimenter == true and regiment ~=nil then
					regiment=murgaLua.findNextXmlNode(regiment, "regiment",counter_sub_regimenter)
					counter_sub_regimenter = counter_sub_regimenter +1	
				end
							
				
				
				if (regiment == nil and counter_sub_regimenter == 1) then break end 
				
				
			
				local e=Einheit:new("",5)
				
				e.ausruestung = {}
				e.auswahl_nahkampfwaffen = {}
				e.sonderregeln = {}
				e.modi = {nkAngriff={},nkErstePhase={}, nkBasis={}, nkVerteidigung={}, fkBasis ={} }
				e.fk ={}
				
				--"mutterregimentstable"
				e.regimentsAttribute = {}
				setmetatable(e.regimentsAttribute, {__index = regimentsAttribute})
				setmetatable(e.regimentsAttribute, {__newindex = regimentsAttribute}) 

				--print(i,murgaLua.findXmlNode(top_level, "regiment/regiment"))		
				
				
							
				
				
				local anzahl = regiment["attr"]["model_count"]
				
				
				for i=1,anzahl,1 do
					obj={index=#gObjects+1}
					obj.cObj=make(ig3d_object, "Characters/Squiggy")
					setObjectInfo(obj.cObj, IG3D_POSITION, 0,-10000,0)
					table.insert(gObjects, obj )
					e:hinzu(obj)
				end
				
				
				e.name=murgaLua.findNextXmlNode(regiment, "name")[1]
				notes = murgaLua.findNextXmlNode(regiment, "notes")[1] or ""
				--print(e.name)
				
				
				--allgemeine sonderregeln
				if string.find(notes,"Skirmish") then 
					e.sonderregeln.skirmish=true
				end
				if string.find(notes,"Stubborn") then 
					e.sonderregeln.stubborn=true 
				end
				if string.find(notes,"Swarm") then 
					e.sonderregeln.swarm=true 
				end
				if string.find(notes,"Immune to Psychology") then 
					e.sonderregeln.immune_to_psychology=true 
				end
				if string.find(notes,"Animosity") then 
					e.sonderregeln.animosity=true 
				end
				if string.find(notes,"Fear") then 
					e.sonderregeln.fear=true 
				end
				if string.find(notes,"Regenerate") then 
					e.sonderregeln.regenerate=true 
				end
				if string.find(notes,"Stupid") then 
					e.sonderregeln.stupid=true 
				end
				if string.find(notes,"Large target") then 
					e.sonderregeln.large_target=true 
				end
				if string.find(notes,"Terror") then 
					e.sonderregeln.terror=true 
				end
				if string.find(notes,"Fly") then 
					e.sonderregeln.fly=true 
				end
				if string.find(notes,"Chariot") then 
					e.sonderregeln.chariot=true 
				end
				
				---------------------------armeespezifische sachen
				--orks und gemuese
				if string.find(notes,"Animosity") then 
					e.sonderregeln.animosity=true 
				end
				
				
				e.sonderregeln.text = notes
				
				
				e.b=murgaLua.findNextXmlNode(regiment, "stat")[1] or "-"
				local offset=string.find(e.b, "/")
				if offset~=nil then e.b=string.sub(e.b, 1,offset-1) end
				e.kg=murgaLua.findNextXmlNode(regiment, "stat",2)[1] or "-"
				e.bf=murgaLua.findNextXmlNode(regiment, "stat",3)[1] or "-"
				e.s=murgaLua.findNextXmlNode(regiment, "stat",4)[1] or "-"
				offset=string.find(e.s, "/")
				if offset~=nil then e.s=string.sub(e.s, 1,offset-1) end
				e.w=murgaLua.findNextXmlNode(regiment, "stat",5)[1] or "-"
				e.lp=murgaLua.findNextXmlNode(regiment, "stat",6)[1] or "-"
				e.i=murgaLua.findNextXmlNode(regiment, "stat",7)[1] or "-"
				e.a=murgaLua.findNextXmlNode(regiment, "stat",8)[1] or "-"
				offset=string.find(e.a, "/")
				if offset~=nil then e.a=string.sub(e.a, 1,offset-1) end
				e.mw=murgaLua.findNextXmlNode(regiment, "stat",9)[1] or "-"
				e.rw=murgaLua.findNextXmlNode(regiment, "stat",10)[1] or "-"
				--e.rw=string.sub(e.rw,1,1)
				e.rew=murgaLua.findNextXmlNode(regiment, "stat",11)[1] or "-"
				--e.rew=string.sub(e.rw,1,1)
				e.UNUSED1=murgaLua.findNextXmlNode(regiment, "stat",12)[1] or "-" 
				e.UNUSED2=murgaLua.findNextXmlNode(regiment, "stat",13)[1] or "-"
				e.es=murgaLua.findNextXmlNode(regiment, "stat",14)[1] or "-"
				
				--einheitenstaerke als indifikator ob modell beritten (ausnahme jezzails)
				e.mounted = (e.es == "2") and e.name ~="Warplock Jezzail teams"
				
				e:regimentWerteSetzen()
				
				
				counter_choice = 1
				--print("choice",murgaLua.findNextXmlNode(regiment, "choice",counter_choice))
				while murgaLua.findNextXmlNode(regiment, "choice",counter_choice) ~= nil do
					choice = murgaLua.findNextXmlNode(regiment, "choice",counter_choice)
					category = choice["attr"]["category"] or ""
					
					if category == "Priority" then
						table.insert(e.ausruestung,murgaLua.findNextXmlNode(choice, "name")[1])
						if murgaLua.findNextXmlNode(choice, "name")[1] == "General" then
							e.general = true
						end					
					end
					
					if category == "Standard" then
						table.insert(e.ausruestung,murgaLua.findNextXmlNode(choice, "name")[1])
						if murgaLua.findNextXmlNode(choice, "name")[1] == "Standard" then
							--e.regimentsAttribute.standard = true
						end					
					end
					
					if category == "First" then
						table.insert(e.ausruestung,murgaLua.findNextXmlNode(choice, "name")[1])
						if murgaLua.findNextXmlNode(choice, "name")[1] == "Frenzy" then
							e.sonderregeln.frenzy = true
							e.modi.nkBasis.a = (e.modi.nkBasis.a or 0) +1 
						end
						if murgaLua.findNextXmlNode(choice, "name")[1] == "Frenzy" then
							e.frenzy = true
						end					
					end
					
					if category == "Shield" then
						table.insert(e.ausruestung,murgaLua.findNextXmlNode(choice, "name")[1])
						if murgaLua.findNextXmlNode(choice, "name")[1] == "Shield" then
							e.shield = true
							e.modi.nkBasis.rw = (e.modi.nkBasis.rw or 0) + 1
						end					
					end
					
					if category == "Weapon" then
						table.insert(e.ausruestung,murgaLua.findNextXmlNode(choice, "name")[1])
						e.auswahl_nahkampfwaffen = e.ausruestung
						--print(murgaLua.findNextXmlNode(choice, "name")[1])
						if murgaLua.findNextXmlNode(choice, "name")[1] == "Spear" then
							if e.mounted then
								e.modi.nkAngriff.s = e.modi.nkAngriff.s or 1
							else
								e.modi.anz_attackierender_glieder = 2
							end
							
						end
						if murgaLua.findNextXmlNode(choice, "name")[1] == "Great Weapon" then
							if e.mounted then
								e.modi.nkAngriff.s = e.modi.nkAngriff.s or 1
							else
								e.modi.nkBasis.s = 2
							end
							e.initemp = 0 --zuletzt zuhauen
							
						end
						if murgaLua.findNextXmlNode(choice, "name")[1] == "Lance" then
							if e.mounted then
								e.modi.nkAngriff.s = e.modi.nkAngriff.s or 2
							end						
						end
						
						
					end
					
					
					if category == "Armour" then
						table.insert(e.ausruestung,murgaLua.findNextXmlNode(choice, "name")[1])
						if murgaLua.findNextXmlNode(choice, "name")[1] == "Heavy Armour" then
							e.modi.nkBasis.rw = (e.modi.nkBasis.rw or 0) + 2 
						end
						if murgaLua.findNextXmlNode(choice, "name")[1] == "Light Armour" then
							e.modi.nkBasis.rw = (e.modi.nkBasis.rw or 0) + 1 
						end
											
					end
				
					
					if category == "Missile" then
						table.insert(e.ausruestung,murgaLua.findNextXmlNode(choice, "name")[1])
						e.kann_schiessen = true
						--print(murgaLua.findNextXmlNode(choice, "name")[1])
						if murgaLua.findNextXmlNode(choice, "name")[1] == "Longbow" then
							e.fk.range = 30
							e.fk.s = 3
						end
						if murgaLua.findNextXmlNode(choice, "name")[1] == "Normal Bow" then
							e.fk.range = 24
							e.fk.s = 3
						end
						if murgaLua.findNextXmlNode(choice, "name")[1] == "Shortbow" then
							e.fk.range = 16
							e.fk.s = 3
						end
						if murgaLua.findNextXmlNode(choice, "name")[1] == "Pistol" then
							e.fk.range = 8
							e.fk.s = 4
							e.fk.no_range_penalty = true
							e.fk.no_move_penalty = true
							e.fk.ruestungsbrechend = true
							e.modi.nkBasis.a = 1 
						end
						if murgaLua.findNextXmlNode(choice, "name")[1] == "Crossbow" then
							e.fk.range = 30
							e.fk.s = 4
							e.fk.move_or_fire= true
						end
						
					end
					
					
					
				counter_choice = counter_choice+1
				end
				
				--aktuelle Waffe
				e.selWeapon = e.auswahl_nahkampfwaffen[1] or "Handweapon"
				
				print("\n"..e.name)
				--print("orig_b  "..e.b)
				--printTable(e)
				
				if e.mw == "-" then   mw_temp = "0" else  mw_temp = e.mw end
				if e.b == "-" then   b_temp = "0" else  b_temp = e.b end
				
				if tonumber(mw_temp) > regimentsAttribute.mw then regimentsAttribute.mw = tonumber(mw_temp) end
				if tonumber(b_temp) > regimentsAttribute.b then regimentsAttribute.b = tonumber(b_temp) end
					
				
				--print("mw "..regimentsAttribute.mw);print("b "..regimentsAttribute.b)
				
				
				
				table.insert(einheiten, e)
				
			
			
				if counter_regimenter ~= 1 and murgaLua.findNextXmlNode(regiment_vor_sub, "regiment",counter_sub_regimenter) ~= nil then
					sub_regimenter = true
				else
					sub_regimenter = false
				end
					
			until sub_regimenter == false	
			
		end
		--printTable(regimentsAttribute)
			
		counter_top_level = counter_top_level + 1
	end
	
end
