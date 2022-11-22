--function make_window()
gObjName=""
gOldSel=""
gCurSel=""
gBoneName=""
gMarkers={}
gAnimSourceModel=""
lastPushed=nil
storedSingleSelect=0
dragged=false
gAnimOffset=0
gAnimsList={{name="NewAnim", markers={} }}
gCurAnim=1
gObjName=getObjectInfo(1, IG3D_NAME)
gSelector=nil
 orig_edit_func=nil
 animBrowser=nil
function updateObjListBrowser()
	objListBrowser:clear()
	
	sourceListBrowser:clear()
	n = nil
	nn = nil 
	for i=1,#gObjectNames,1 do
		objListBrowser:add(gObjectNames[i])
		sourceListBrowser:add(gObjectNames[i])
		if gObjectNames[i]==gObjName then n = i end
		if gObjectNames[i]== gAnimSourceModel then nn = i end
	end	
	if n ~= nil then 
	print(gCurSel)
	 objListBrowser:select(n,n)
	 objListBrwoser:value(n)
	  objListBrowser:selected(n)
	  end
	  if nn ~= nil then 
	  sourceListBrowser:select(nn,nn)
	 sourceListBrowser:value(nn)
	  sourceListBrowser:selected(nn)
	  end
	  
end
function updateAnimListBrowser()
	animListBrowser:clear()
	for i=1,#gAnimsList,1 do
		animListBrowser:add(gAnimsList[i].name)
	end
	animListBrowser:value(gCurAnim-1)
	
end
function ModelAnimationList(w)
gAnimSourceModel = gObjectNames[w:value()]
print(animSourceModel)
if gAnimSourceModel == nil then gAnimSourceModel = gObjName end

	p=ig3d_GetObjectModelPath_s_s(gAnimSourceModel)
	local tmp=io.open(p,"r")
	if tmp== nil then return end
	gAnimsList={}
	tmp:seek("set",ig3d_GetObjectModelAnimOffset_s_i(gAnimSourceModel))
	local n=tmp:read("*l")	--read chunk name
	n=tonumber(tmp:read("*l"))		--how many animations?
	
	if n >= 1 then 
	for i=1,n,1 do
	print("i=",i,"n=",n)
		local newAnim={markers={} }
		newAnim.name=tmp:read("*l")
		local an=tonumber(tmp:read("*l"))
		if an ~= nil then 
		for j=1,an,1 do
			local m={cntrl=nil}
			tims=tmp:read("*l")
			morphs=tmp:read("*l")
			end
			
			table.insert(gAnimsList, newAnim)		
		print(newAnim.name)
		end
		end
		
		else
		print("no animations")
		end
		
		tmp:close()
		
		updateAnimListBrowser()
end
function runAnim(w)
if w:value() ~= nil then 
	local o=get(ig3d_object, gObjName)
	local b=false
	if animLoopControl:value()==1 then b=true end
	
	
	offst=ig3d_GetObjectModelAnimOffset_s_i(gAnimSourceModel)
	ig3d_ReadModelAnimationsFromFile_2si(gObjName, ig3d_GetObjectModelPath_s_s(gAnimSourceModel), offst)
	ig3d_SetAutoBoneUpdating_b(true)
	setObjectInfo(o, IG3D_ANIMATION, gAnimsList[w:value()].name, 0, b)
	end
end

function stopAnim(w)
	local o=get(ig3d_object, gObjName)
	setObjectInfo(o, IG3D_ANIMATION, "STOP", 0, false)
end
function objListBrowserCallback(w)
gObjName = gObjectNames[w:value()]
ig3d_SetSelection_s(gObjName)
print(a)
end
function handle_animation_browser()
if orig_edit_func==handle_animation_browser then orig_edit_func=nil end
if orig_edit_func~=nil then orig_edit_func() end;

	
	if click("o") then
		--The selection might have been changed, see what happened
		gCurSel=ig3d_GetSelection__s()
		if gCurSel=="" then return end
		if gCurSel~=gOldSel then
			
			for w in string.gmatch(gCurSel, "[^\n]+") do
			
				--if string.sub(w,1,5)=="bone " then gBoneName=string.sub(w, 6,-1) else end
				 gObjName=w

     			end
     		
     			
     			local lobje=string.sub(gObjName, 1,-1)
     			
     			if animBrowser:label()~=gObjName then
     		
     				
     				updateObjListBrowser()
     			end
     			gObjName=lobje
     			animBrowser:label(gObjName)
     			
     			
		end
		gOldSel=gCurSel
	end
	
     			fltk_update()
	
end
do animBrowser= fltk:Fl_Double_Window(0,0,0,0,"")
animBrowser:callback(wClose)
animBrowser:resize(287,188,372,237)
animBrowser:labelsize(10)
--animBrowser:show()
do animListBrowser= fltk:Fl_Browser(0,0,0,0,"")
animListBrowser:callback(runAnim)
animListBrowser:resize(250,25,115,180)
animListBrowser:type(3)
animListBrowser:labelsize(10)
animListBrowser:textsize(10)
end

do objListBrowser= fltk:Fl_Browser(0,0,0,0,"")
objListBrowser:callback(objListBrowserCallback)
objListBrowser:resize(20,25,115,180)
objListBrowser:type(3)
objListBrowser:labelsize(10)
objListBrowser:textsize(10)
end

do sourceListBrowser= fltk:Fl_Browser(0,0,0,0,"")
sourceListBrowser:callback(ModelAnimationList)
sourceListBrowser:resize(135,25,115,180)
sourceListBrowser:type(3)
sourceListBrowser:labelsize(10)
sourceListBrowser:when(4)
sourceListBrowser:textsize(10)
end

do stopControl= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Stop")
stopControl:label(gLabelTable[#gLabelTable])
stopControl:callback(stopAnim)
stopControl:resize(255,210,45,20)
stopControl:labelsize(10)
end

do animLoopControl= fltk:Fl_Check_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Looped")
animLoopControl:label(gLabelTable[#gLabelTable])
animLoopControl:resize(305,210,60,20)
animLoopControl:down_box(fltk.FL_DOWN_BOX)
animLoopControl:labelsize(10)
end

do widget= fltk:Fl_Box(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Select")
widget:label(gLabelTable[#gLabelTable])
widget:resize(20,10,110,15)
widget:labelsize(10)
end

do widget= fltk:Fl_Box(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Anim Source")
widget:label(gLabelTable[#gLabelTable])
widget:resize(135,10,110,15)
widget:labelsize(10)
end

do widget= fltk:Fl_Box(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Animations")
widget:label(gLabelTable[#gLabelTable])
widget:resize(250,10,110,15)
widget:labelsize(10)
end
end
animBrowser:show()

animBrowser:label("")
animBrowser:show()
animBrowser:make_current()
orig_edit_func=edit_func
edit_func=handle_animation_browser
--end
Fl:run()
