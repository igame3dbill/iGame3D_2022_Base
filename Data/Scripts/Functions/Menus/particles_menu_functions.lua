-- PARTICLES MENU FUNCTIONS
ParticlesMenuIndex={}
ParticlesMenuText={}
ParticlesMenuText.Source={"Make", "Save","Duplicate"}
ParticlesMenuText.Control={"Run","Stop","Clear"}

function fillParticlesSourceMenu()
if ParticleBrowser == nil then return end;
	for  i=1,#ParticlesMenuText.Source,1 do
	menuLine="Emitters/"..ParticlesMenuText.Source[i]
	ParticlesMenu:add(menuLine);
	table.insert(ParticlesMenuIndex,menuLine)
	end
ParticlesMenu:add("");
table.insert(ParticlesMenuIndex,"")
ParticlesMenu:redraw()
end 

function fillParticlesControlMenu()
if ParticleBrowser == nil then return end;
for  i=1,#ParticlesMenuText.Control,1 do
	menuLine="Current/"..ParticlesMenuText.Control[i]
	ParticlesMenu:add(menuLine);
	table.insert(ParticlesMenuIndex,menuLine)
	end
ParticlesMenu:add("");
table.insert(ParticlesMenuIndex,"")
ParticlesMenu:add("");
table.insert(ParticlesMenuIndex,"")
--All
for  i=1,#ParticlesMenuText.Control,1 do
	menuLine="All/"..ParticlesMenuText.Control[i]
	ParticlesMenu:add(menuLine);
	table.insert(ParticlesMenuIndex,menuLine)
	end



ParticlesMenu:redraw()
end


function particlesCurrentPick(tPick)
if gSelectedParticle == nil then return end;
runningParticle = get(ig3d_particle_emitter, gSelectedParticle)
		if tPick == "Clear" then
		setParticle_emitterInfo (runningParticle, IG3D_STOP) 
		setParticle_emitterInfo (runningParticle, IG3D_CLEAR_PARTICLES) 
		render()
		end
		
		if tPick == "Run" then		
		setParticle_emitterInfo (runningParticle, IG3D_START)  
		render()
		end
		
		if tPick == "Stop" then		
		setParticle_emitterInfo (runningParticle, IG3D_STOP)  
		render()
		end
end

function particlesAllMenuPick(tPick)
	plist= ig3d_GetParticle_emittersList__s()
	if plist ~= nil then 
	pcount =  getlinecount(plist)
		if pcount ~= nil then 
			if tPick == "Stop" then 
			for i=1,pcount,1 do stopParticle(i)end	
			end
		
			if tPick == "Clear" then
			for i=1,pcount,1 do 
			clearParticle(i) 
			render()
			end;	
			end
			if tPick == "Run" then 
				for i=1,pcount,1 do 
				runParticle(i)
				render()
				end	
			end
		end
		end
end

function particlesEmittersMenuPick(tPick)
if ParticleBrowser == nil then return end;
CurParticleInfo()	
if tPick == "Save" then 
PickedParticleAttribute(2)
EmissionInputGroup:hide()
EmitterSourceGroup:hide()
EmitterValueGroup:hide()
EmitterTextureGroup:hide()
EmitterSaveAsGroup:show()
end

if tPick == "Make" then
emtFileBrowser:label(tPick)
gSourceRequest = tPick
PickedParticleAttribute(1)
ValueListBrowser:clear()
EmissionInputGroup:hide()
EmitterSourceGroup:show()
EmitterValueGroup:hide()
EmitterTextureGroup:hide()
EmitterSaveAsGroup:hide()
emitterSourceList()
ParticleBrowserWindowUpdate("SourceList") --
end		
if tPick == "Duplicate" then MakeEmitter() end;

end




function particles_menu_callback(w)
if ParticleBrowser == nil then return end;
tMenu = w:label()
tVal = w:value()
tPick = w:text()
tIndex = ParticlesMenuIndex[tVal]
tIndex1 = ParticlesMenuIndex[tVal-1]
tIndex2 = ParticlesMenuIndex[tVal+1]

	if tIndex ~=nil  then 
	ParticlesmenuHead=item(1,tIndex,"/")

 		if ParticlesmenuHead == "Emitters" then particlesEmittersMenuPick(tPick) end;
 		if ParticlesmenuHead == "Current" then particlesCurrentPick(tPick) end;
 		if ParticlesmenuHead == "All" 	then  particlesAllMenuPick(tPick) end;
 		
 	 end 
 	 if tIndex1 == "All/Clear" then particlesAllMenuPick("Clear") end
 	 if tIndex1 == "Current/Clear" then particlesCurrentPick("Clear") end
  Fl:check();
   io.flush();
end

function particles_MenuBarFill()
if ParticleBrowser == nil then return end;
fillParticlesSourceMenu()
fillParticlesControlMenu()
end

