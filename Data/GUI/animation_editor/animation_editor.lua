--function make_window()
function updateMarker(w)
	timemarker:position(92+timeslide:value()*49.2, 17)
	animEd:redraw()
	
	if gObjName~="" then
		local o=get(ig3d_object, gObjName)
		--setObjectInfo(o, IG3D_ANIMATION, "STOP", 0, true)
		setObjectInfo(o, IG3D_ANIMATION, gAnims[gCurAnim].name, 0, false)
	
	
		ig3d_SetAutoBoneUpdating_b(false)
		ig3d_UpdateObjectBonesAtTime_si(gObjName, (time()+timeslide:value())*1000)
	end
end

function timeToMarkerPos(t)
	return 92+t*49.2
end

function markerPosToTime(p)
	return (p-92)/49.2
end


function recalculateAnimOffset()
	gAnimOffset=ig3d_GetObjectModelAnimOffset_s_i(gObjName)
end

function isMultiSelect()
	local c=0
	for i=1,#gMarkers,1 do
		if gMarkers[i].selected then c=c+1 end;
	end
	if c>1 then return true else return false end;
end

function unselectAllMarkers()
	for i=1,#gMarkers,1 do
		gMarkers[i].selected=false
		gMarkers[i].cntrl:color(gMarkers[i].color1)
		gMarkers[i].cntrl:selection_color(gMarkers[i].color1)
	end

end

function rememberMarkerSelections()
	for i=1,#gMarkers,1 do
		gMarkers[i].oldSelected=gMarkers[i].selected
	end	
end

function handleRectSelect()
	for i=1,#gMarkers,1 do
		local x1=timeToMarkerPos(gMarkers[i].bonstart)
		local y1=17+gMarkers[i].bone*11
		local x2=x1+gMarkers[i].bondur*49.2
		local y2=y1+10
		
		local pax=(x1+x2)*0.5
		local pay=(y1+y2)*0.5
		local pbx=gSelector.rx+0.5*gSelector.tx
		local pby=gSelector.ry+0.5*gSelector.ty
		local ax=(x2-x1)*0.5
		local ay=5
		local bx=gSelector.tx*0.5
		local by=gSelector.ty*0.5
		
		
		local tx=pbx-pax
		local ty=pby-pay
		gMarkers[i].selected=gMarkers[i].oldSelected
		
		if math.abs(tx)<= (ax+bx) then
			if math.abs(ty)<=(ay+by) then
				gMarkers[i].selected=not gMarkers[i].oldSelected
				selMarkerChanged=true
			end
		end
		
		if gMarkers[i].selected then
			gMarkers[i].cntrl:color(gMarkers[i].color2)
			gMarkers[i].cntrl:selection_color(gMarkers[i].color2)
		else
			gMarkers[i].cntrl:color(gMarkers[i].color1)
			gMarkers[i].cntrl:selection_color(gMarkers[i].color1)
		end
	end
	animEd:redraw()
end

function setMarkerDuration(w)
	for i=1,#gMarkers,1 do
		if gMarkers[i].selected== true then
			gMarkers[i].bondur=animDur:value()
			gMarkers[i].bonend=gMarkers[i].bonstart+gMarkers[i].bondur
			gMarkers[i].cntrl:size(gMarkers[i].bondur*49.2,10)
		end
	end
	animEd:redraw()
end

function dragSelectedMarkers()
	local dx,dy=getSceneInfo(IG3D_MOUSE_DELTA)
	if dx~= 0 or dy~= 0 then dragged=true end
	
	for i=1,#gMarkers,1 do
		if gMarkers[i].selected== true then
			local x=timeToMarkerPos(gMarkers[i].bonstart)
			local y=17+gMarkers[i].bone*11
			
			x=x+dx
			if markerPosToTime(x)<0 then x=timeToMarkerPos(0) end
			if markerPosToTime(x)+gMarkers[i].bondur>10 then x=timeToMarkerPos(10-gMarkers[i].bondur) end
				
			gMarkers[i].cntrl:position(x,y)
			gMarkers[i].bonstart=markerPosToTime(x)
			gMarkers[i].bonend=gMarkers[i].bonstart+gMarkers[i].bondur
		end
	end
end



function clearSelectedMarkers(w)
	for i=#gMarkers,1,-1 do
		if gMarkers[i].selected== true then
			gMarkers[i].cntrl:parent():remove(gMarkers[i].cntrl)
			gMarkers[i].cntrl=nil
			table.remove(gMarkers, i)	
		end
		
	end
	for i=1,#gMarkers,1 do
		gMarkers[i].cntrl:label(i)
	end
	selMarkerChanged=true
end

function clearMarkerControls()
	if gObjName~="" then
		for i=1,#gMarkers,1 do
			gMarkers[i].selected=false
			if gMarkers[i].cntrl~=nil then
				gMarkers[i].cntrl:parent():remove(gMarkers[i].cntrl)
				gMarkers[i].cntrl=nil
			end		
		end
	end
	animEd:redraw()
end

function createMarkerControls()
	Fl_Group:current(animEd)
	for i=1,#gMarkers,1 do
		gMarkers[i].selected=false
		
		gMarkers[i].cntrl=fltk:Fl_Button(timeToMarkerPos(gMarkers[i].bonstart), 17+gMarkers[i].bone*11, gMarkers[i].bondur*49.2, 10)
		gMarkers[i].cntrl:box(fltk.FL_FLAT_BOX);
      		gMarkers[i].cntrl:down_box(fltk.FL_FLAT_BOX);
      		gMarkers[i].cntrl:color(gMarkers[i].color1);
      		gMarkers[i].cntrl:selection_color(gMarkers[i].color1);
      		gMarkers[i].cntrl:label(i)
      		gMarkers[i].cntrl:labeltype(fltk.FL_NO_LABEL)
      		gMarkers[i].cntrl:type(1)
	end
	Fl_Group:current(animEd:parent())
	animEd:redraw()
end


function createMarkers(w)
	for i=1,#boneslist,1 do
		if boneslistcontrol:selected(i)==1 then
			Fl_Group:current(animEd)
			local boxy={ cntrl=fltk:Fl_Button(timeToMarkerPos(timeslide:value()), 6+i*11, animDur:value()*49.2, 10) }
      			boxy.cntrl:box(fltk.FL_FLAT_BOX);
      			boxy.cntrl:down_box(fltk.FL_FLAT_BOX);
      			n=#gMarkers+1
      			boxy.cntrl:label(n)
      			boxy.cntrl:labeltype(fltk.FL_NO_LABEL)
      			boxy.cntrl:type(1)
      			boxy.bonx,boxy.bony,boxy.bonz,boxy.bonxa,boxy.bonya,boxy.bonza=ig3d_GetObjectBoneInfo_2s_6f(gObjName,boneslistcontrol:text(i))
      			boxy.bonstart=timeslide:value()
      			boxy.bondur=animDur:value()
      			boxy.bonend=boxy.bonstart+boxy.bondur
      			boxy.bone=i-1
      			if morphControl:value()==1 then
      				boxy.type="morph"
      				boxy.color1=176
      				boxy.color2=239
      			else
      				boxy.type="set"
      				boxy.color1=fltk.FL_DARK_GREEN
      				boxy.color2=79
      			end
      			boxy.cntrl:color(boxy.color1);
      			boxy.cntrl:selection_color(boxy.color1)
      			boxy.selected=false    			
      			
      			table.insert(gMarkers, boxy)
		end
	
	end
	timeslide:value(timeslide:value()+animDur:value())
	updateMarker(nil)
	--animEd:redraw()	--implicit
end

function saveAnimsToModel(w)
	p=ig3d_GetObjectModelPath_s_s(gObjName)
	local tmp=io.open(p,"r+")
	local n=#gAnims
	
	tmp:seek("set",gAnimOffset)
	tmp:write("#Animations:\n"..n)
	
	for i=1,#gAnims,1 do
		n=#gAnims[i].markers
		tmp:write("\n"..gAnims[i].name.."\n"..n)
		for j=1,n,1 do
			tmp:write("\n"..gAnims[i].markers[j].bonstart..","..gAnims[i].markers[j].bonend.."\n")
			tmp:write(gAnims[i].markers[j].type.."="..gAnims[i].markers[j].bone..","..gAnims[i].markers[j].bonx..","..gAnims[i].markers[j].bony..","..gAnims[i].markers[j].bonz..","..gAnims[i].markers[j].bonxa..","..gAnims[i].markers[j].bonya..","..gAnims[i].markers[j].bonza)
		end
	end
	tmp:write("\nEND\n")
	tmp:flush()
	tmp:close()
	ig3d_ReadModelAnimationsFromFile_2si(gObjName, p, gAnimOffset)
end

function runAnim(w)
	local o=get(ig3d_object, gObjName)
	local b=false
	if animLoopControl:value()==1 then b=true end
	ig3d_SetAutoBoneUpdating_b(true)
	setObjectInfo(o, IG3D_ANIMATION, gAnims[gCurAnim].name, 0, b)
end

function stopAnim(w)
	local o=get(ig3d_object, gObjName)
	setObjectInfo(o, IG3D_ANIMATION, "STOP", 0, false)
end

function updateAnimListControl()
	animListControl:clear()
	for i=1,#gAnims,1 do
		animListControl:add(gAnims[i].name)
	end
	animListControl:value(gCurAnim-1)
end

function createNewAnim(w)
	local an={markers={}}
	
	an.name=fltk.fl_input("Please enter a name for this animation:")
	
	if an.name==nil then return end
	if an.name=="" then return end
	
	table.insert(gAnims, an)
	clearMarkerControls()
	gMarkers=an.markers
	gCurAnim=#gAnims
	updateAnimListControl()
end

function selectAnim(w)
	clearMarkerControls()
	gCurAnim=animListControl:value()+1
	gMarkers=gAnims[gCurAnim].markers
	createMarkerControls()
end

function deleteAnim(w)
	if #gAnims > 1 then
		clearMarkerControls()
		table.remove(gAnims, gCurAnim)
		gCurAnim=#gAnims
		updateAnimListControl()
		gMarkers=gAnims[gCurAnim].markers
		createMarkerControls()
	end
end

function renameAnim(w)
	local name=fltk.fl_input("Please enter a new name for this animation:")
	
	if name==nil then return end
	if name=="" then return end
	
	gAnims[gCurAnim].name=name
	updateAnimListControl()
end

function loadAnimsFromModel()
local oldobj=gObjName
	p=ig3d_GetObjectModelPath_s_s(gObjName)
	
	ig3d_ReadModelAnimationsFromFile_2si(gObjName, p, gAnimOffset)
	
	local tmp=io.open(p,"r")
	
	gAnims={}
	tmp:seek("set",gAnimOffset)
	
	local n=tmp:read("*l")	--read chunk name
	n=tonumber(tmp:read("*l"))		--how many animations?
	
	for i=1,n,1 do
		local newAnim={markers={} }
		newAnim.name=tmp:read("*l")
		local an=tonumber(tmp:read("*l"))
		for j=1,an,1 do
			local m={cntrl=nil}
			tims=tmp:read("*l")
			k=string.find(tims, ",")
			m.bonstart=string.sub(tims, 1,k-1)
			m.bonend=string.sub(tims, k+1,-1)
			m.bondur=m.bonend-m.bonstart
			
			morphs=tmp:read("*l")
			k=string.find(morphs, "=")
			m.type=string.sub(morphs, 1,k-1)
			
			if m.type=="morph" then
				m.color1=176
				m.color2=239
			else
				m.color1=fltk.FL_DARK_GREEN
				m.color2=79
			end
			
			morphs=string.sub(morphs, k+1,-1)
			
			k=string.find(morphs, ",")
			m.bone=string.sub(morphs, 1,k-1)
			morphs=string.sub(morphs, k+1,-1)
			
			k=string.find(morphs, ",")
			m.bonx=string.sub(morphs, 1,k-1)
			morphs=string.sub(morphs, k+1,-1)
			
			k=string.find(morphs, ",")
			m.bony=string.sub(morphs, 1,k-1)
			morphs=string.sub(morphs, k+1,-1)
			
			k=string.find(morphs, ",")
			m.bonz=string.sub(morphs, 1,k-1)
			morphs=string.sub(morphs, k+1,-1)
			
			k=string.find(morphs, ",")
			m.bonxa=string.sub(morphs, 1,k-1)
			morphs=string.sub(morphs, k+1,-1)
			
			k=string.find(morphs, ",")
			m.bonya=string.sub(morphs, 1,k-1)
			m.bonza=string.sub(morphs, k+1,-1)
			m.selected=false
			m.cntrl=nil
			
			table.insert(newAnim.markers, m)
		end
		table.insert(gAnims, newAnim)
	end
	
	tmp:close()
	if n==0 then
		local newAnim={markers={}, name="NewAnim" }
		table.insert(gAnims, newAnim)
	end
	
	gCurAnim=1
	updateAnimListControl()

	clearMarkerControls()
	
	Fl_Group:current(animEd:parent())

	gMarkers=gAnims[gCurAnim].markers
	
	createMarkerControls()
end

function resetBones(w)
	local o=get(ig3d_object, gObjName)
	setObjectInfo(o, IG3D_ANIMATION, "STOP", 0, true)
end

function listBones(w)
	boneslist={}
	boneslistcontrol:clear()
	if gObjName=="" then return end;
	bl=ig3d_GetObjectBonesList_s_s(gObjName)
	for w in string.gmatch(bl, "[^\n]+") do
		local spaceoffset=string.find(w, " ")
		local nam=string.sub(w, 1, spaceoffset-1)
		local num=string.sub(w, spaceoffset+1, -1)
		
		table.insert(boneslist, nam)
		boneslistcontrol:add(nam)
     	end

end

function selBoneByName(bn)
	boneslistcontrol:deselect()
	for i=1,#boneslist,1 do
		if boneslist[i]==bn then boneslistcontrol:value(i) end
	end
end


function morphControlUpdate(w)
	for i=1,#gMarkers,1 do
		if gMarkers[i].selected then
			if morphControl:value()==1 then
				gMarkers[i].type="morph"
				gMarkers[i].color1=176
				gMarkers[i].color2=239
			else
				gMarkers[i].type="set"
				gMarkers[i].color1=fltk.FL_DARK_GREEN
				gMarkers[i].color2=79
			end
			gMarkers[i].cntrl:color(gMarkers[i].color2)
			gMarkers[i].cntrl:selection_color(gMarkers[i].color2)
		end
	end
	animEd:redraw()
end
function recordAnimation()
	
	--automatic stopping
	if gStart then
		local frm=math.floor( (gStart+passed())/gFrameTime)
		if frm>#poses then 
			recordButton:label("Record")
			edit_func=gEditfuncBeforeRecord
			return
		end
	end
	
	
	gEditfuncBeforeRecord()
	if time()>=gNextRecord then
		createMarkers()
		gNextRecord=gNextRecord+animDur:value()
	end
	
end



function recordTheStuff(w)
	if recordButton:label()=="Record" then
		recordButton:label("Stop")
		gEditfuncBeforeRecord=edit_func
		edit_func=recordAnimation
		gNextRecord=time()
		--reset animation to the start
		if not key("w","-") then
			gStart=0
		end
		
	else
		recordButton:label("Record")
		edit_func=gEditfuncBeforeRecord

	end

end
do animEd= fltk:Fl_Double_Window(0,0,0,0,"")
animEd:callback(wClose)
animEd:resize(130,93,673,377)
animEd:labelsize(10)
--animEd:show()
do boneslistcontrol= fltk:Fl_Browser(0,0,0,0,"")
boneslistcontrol:resize(0,15,90,290)
boneslistcontrol:type(3)
boneslistcontrol:labelsize(10)
boneslistcontrol:textsize(10)
end

do createMarkersControl= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Create markers")
createMarkersControl:label(gLabelTable[#gLabelTable])
createMarkersControl:callback(createMarkers)
createMarkersControl:resize(165,310,115,25)
createMarkersControl:labelsize(10)
end

do timeslide= fltk:Fl_Value_Slider(0,0,0,0,"")
timeslide:callback(updateMarker)
timeslide:resize(55,0,535,15)
timeslide:type(1)
timeslide:labelsize(10)
timeslide:maximum(10)
timeslide:step(0.02)
end

do timemarker= fltk:Fl_Box(0,0,0,0,"")
timemarker:resize(92,17,1,289)
timemarker:box(fltk.FL_FLAT_BOX)
timemarker:color(1)
timemarker:labelsize(10)
end

do saveControl= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Save")
saveControl:label(gLabelTable[#gLabelTable])
saveControl:callback(saveAnimsToModel)
saveControl:resize(385,345,70,25)
saveControl:labelsize(10)
end

do animDur= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Duration")
animDur:label(gLabelTable[#gLabelTable])
animDur:callback(setMarkerDuration)
animDur:resize(60,310,35,25)
animDur:labelsize(10)
animDur:maximum(10)
animDur:step(0.02)
animDur:value(0.2)
animDur:textsize(10)
end

do animListControl= fltk:Fl_Choice(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Animations")
animListControl:label(gLabelTable[#gLabelTable])
animListControl:callback(selectAnim)
animListControl:resize(77,345,110,25)
animListControl:down_box(fltk.FL_BORDER_BOX)
animListControl:labelsize(10)
end

do clearMarkersControl= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Clear markers")
clearMarkersControl:label(gLabelTable[#gLabelTable])
clearMarkersControl:callback(clearSelectedMarkers)
clearMarkersControl:resize(280,310,110,25)
clearMarkersControl:labelsize(10)
end

do newControl= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "New...")
newControl:label(gLabelTable[#gLabelTable])
newControl:callback(createNewAnim)
newControl:resize(190,345,65,25)
newControl:labelsize(10)
end

do renameControl= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Rename")
renameControl:label(gLabelTable[#gLabelTable])
renameControl:callback(renameAnim)
renameControl:resize(255,345,65,25)
renameControl:labelsize(10)
end

do deleteControl= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Delete")
deleteControl:label(gLabelTable[#gLabelTable])
deleteControl:callback(deleteAnim)
deleteControl:resize(320,345,65,25)
deleteControl:labelsize(10)
end

do resetControl= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Reset Bones")
resetControl:label(gLabelTable[#gLabelTable])
resetControl:callback(resetBones)
resetControl:resize(545,350,110,20)
resetControl:labelsize(10)
end

do playControl= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Play")
playControl:label(gLabelTable[#gLabelTable])
playControl:callback(runAnim)
playControl:resize(475,330,70,20)
playControl:labelsize(10)
end

do stopControl= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Stop")
stopControl:label(gLabelTable[#gLabelTable])
stopControl:callback(stopAnim)
stopControl:resize(545,330,110,20)
stopControl:labelsize(10)
end

do animLoopControl= fltk:Fl_Check_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Looped")
animLoopControl:label(gLabelTable[#gLabelTable])
animLoopControl:resize(475,350,70,25)
animLoopControl:down_box(fltk.FL_DOWN_BOX)
animLoopControl:labelsize(10)
end

do morphControl= fltk:Fl_Check_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Morph")
morphControl:label(gLabelTable[#gLabelTable])
morphControl:callback(morphControlUpdate)
morphControl:resize(95,310,70,25)
morphControl:down_box(fltk.FL_DOWN_BOX)
morphControl:labelsize(10)
end

do selboxControl= fltk:Fl_Box(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "selbox")
selboxControl:label(gLabelTable[#gLabelTable])
selboxControl:resize(205,55,0,0)
selboxControl:box(fltk.FL_BORDER_FRAME)
selboxControl:color(56)
selboxControl:labeltype(fltk.FL_NO_LABEL)
selboxControl:labelsize(10)
end

do recordButton= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Record")
recordButton:label(gLabelTable[#gLabelTable])
recordButton:callback(recordTheStuff)
recordButton:resize(405,310,60,25)
end
end
animEd:show()

gObjName=""
gOldSel=""
gCurSel=""
gBoneName=""
gMarkers={}
lastPushed=nil
storedSingleSelect=0
selMarkerChanged=false
dragged=false
bondur=0.2
bonmorph=1
gAnimOffset=0
gAnims={{name="NewAnim", markers={} }}
gCurAnim=1

gSelector=nil

updateAnimListControl()
morphControl:value(1)
animEd:label("")

ig3d_SetMode_i(2)

ig3d_SetSelection_s("")
function handle_animation_editor()
	if orig_edit_func~=nil then orig_edit_func() end;

	
	if click("o") then
		--The selection might have been changed, see what happened
		gCurSel=ig3d_GetSelection__s()
		if gCurSel=="" then return end
		if gCurSel~=gOldSel then
			
			for w in string.gmatch(gCurSel, "[^\n]+") do
				if string.sub(w,1,5)=="bone " then gBoneName=string.sub(w, 6,-1) else gObjName=w end

     			end
     			
     			
     			listBones(nil)
     			selBoneByName(gBoneName)
     			
     			local lobje=string.sub(gObjName, 1,-1)
     			
     			if animEd:label()~=gObjName then
     				
     				recalculateAnimOffset()
     				loadAnimsFromModel()
     			end
     			gObjName=lobje
     			animEd:label(gObjName)
     			
     			
     			
		end
		gOldSel=gCurSel
	end
	
	
	local w=Fl:pushed()
	
	if gSelector~=nil then
		gSelector.sx=Fl:event_x()
		gSelector.sy=Fl:event_y()
		gSelector.tx=math.abs(gSelector.sx-gSelector.ox)
		gSelector.ty=math.abs(gSelector.sy-gSelector.oy)
		gSelector.rx=gSelector.ox
		gSelector.ry=gSelector.oy
		if gSelector.sx<gSelector.ox then gSelector.rx=gSelector.sx end
		if gSelector.sy<gSelector.oy then gSelector.ry=gSelector.sy end
		selboxControl:position(gSelector.rx,gSelector.ry)
		selboxControl:size(gSelector.tx,gSelector.ty)
		handleRectSelect()
	end
	
	
	if w~=nil and gSelector==nil then
	
	
		--if the window was clicked, unselect everything
		if w:label()==gObjName then
			if not key(310,"-") then unselectAllMarkers() end
			selMarkerChanged=true
			if gSelector==nil then
				gSelector={ ox=Fl:event_x(), oy=Fl:event_y(), sx=Fl:event_x(), sy=Fl:event_y()}
				selboxControl:position(gSelector.ox, gSelector.oy)
				selboxControl:size(0,0)
				rememberMarkerSelections()
			end
			
		end
		
		
		
		
		local idx=w:label()
		if idx~=nil then
			
			idx=tonumber(idx)
			if idx~=nil then
				
				
				
				if not key(310, "-")   then
					if not gMarkers[idx].selected then unselectAllMarkers() end
					storedSingleSelect=idx
				end
				
				if key(310, "-") then
					if lastPushed~=w:label() then gMarkers[idx].selected=not gMarkers[idx].selected end
				else
					gMarkers[idx].selected=true					
				end
				
				if gMarkers[idx].selected then
					w:color(gMarkers[idx].color2)
					w:selection_color(gMarkers[idx].color2)
				else
					w:color(gMarkers[idx].color1)
					w:selection_color(gMarkers[idx].color1)
				end
				
				dragSelectedMarkers()
				lastPushed=w:label()
				selMarkerChanged=true
				bondur=gMarkers[idx].bondur
				if gMarkers[idx].type=="morph" then bonmorph=1 else bonmorph=0 end
			end
		end
		
		
		
	end
	if not ig3d_IsMouseButtonDown__b() then 
		lastPushed=nil
		if storedSingleSelect>0 then
			if dragged == false then
				unselectAllMarkers()
				bondur=gMarkers[storedSingleSelect].bondur
				gMarkers[storedSingleSelect].selected=true
				gMarkers[storedSingleSelect].cntrl:color(gMarkers[storedSingleSelect].color2)
				gMarkers[storedSingleSelect].cntrl:selection_color(gMarkers[storedSingleSelect].color2)
			end
			
			storedSingleSelect=0
			selMarkerChanged=true
		end
		dragged=false
		if gSelector~=nil then selMarkerChanged=true end
		gSelector=nil
		selboxControl:size(0,0)
		animEd:redraw()
	end
	
	
	
	if selMarkerChanged == true then
		
		if not isMultiSelect() then
			animDur:value(bondur)
			animDur:activate()
			morphControl:value(bonmorph)
			morphControl:activate()
		else
			
			animDur:deactivate()
			morphControl:deactivate()
		end
		animEd:redraw();
		selMarkerChanged=false 
	end
		
	fltk_update()
end
orig_edit_func=edit_func
edit_func=handle_animation_editor

animEd:show()
animEd:make_current()
--end
Fl:run()
