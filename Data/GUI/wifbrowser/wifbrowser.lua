--function make_window()
if wifBrowser then
wifBrowser:hide()
wifBrowser = nil
end

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
gSourceAnimsList={{name="NewAnim", markers={} }}
gCurAnim=1
gObjName=getObjectInfo(1, IG3D_NAME)
gSelector=nil
 orig_edit_func=nil
 wifBrowser=nil
 filad={"Walk","Idle","Fight"}
 wifFileList={}
 sourcelist={}
function updateObjListBrowser()
	objListBrowser:clear()
	n = nil 
	for i=1,#gObjectNames,1 do
		objListBrowser:add(gObjectNames[i])
		
		if gObjectNames[i]==gObjName then n = i end
		if gObjectNames[i]== gAnimSourceModel then nn = i end
	end	
	if n ~= nil then 
	print(gCurSel)
	 objListBrowser:select(n,n)
	 objListBrowser:value(n)
	  objListBrowser:selected(n)
	  end
	 
	  
end
function updateAnimListBrowser()
	animListBrowser:clear()
	for i=1,#gAnimsList,1 do
		animListBrowser:add(gAnimsList[i].name)
	end
	animListBrowser:value(gCurAnim-1)
	
end
function modelAnimOffset(p)
local rall = io.open(p,"r")
	local altx = rall:read("*a")
	rall:close()
	if altx~=nil then
	animSt,animEn=string.find(altx,"#Animations")
	end
	return animSt-1
end

function ModelAnimationList(w)
gAnimSourceModel = sourcelist[w:value()]
print(gAnimSourceModel)
if gAnimSourceModel == nil then gAnimSourceModel = gObjName end

	p=ig3d_GetObjectModelPath_s_s(gAnimSourceModel)
	p=gameroot.."Data/WTF/WIF/"..gAnimSourceModel
	offs=modelAnimOffset(p)
	local tmp=io.open(p,"r")
	if tmp== nil then return end
	gAnimsList={}
	--tmp:seek("set",ig3d_GetObjectModelAnimOffset_s_i(gAnimSourceModel))
	tmp:seek("set",offs)
	local n=tmp:read("*l")	--read chunk name
	print("n=",n)
	n=tonumber(tmp:read("*l"))		--how many animations?
	print("n=",n)
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
	
	p=gameroot.."Data/WTF/WIF/"..gAnimSourceModel
	offs=modelAnimOffset(p)
	--offst=ig3d_GetObjectModelAnimOffset_s_i(gAnimSourceModel)
	ig3d_ReadModelAnimationsFromFile_2si(gObjName, p, offs)
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
function refillpick()

sourceListBrowser:clear()
pickedfill = filad[fillpick:value()+1]
print(pickedfill)
WifinDir=gameroot.."Data/WTF/WIF/"
wifFileList={}
sourcelist={}
 wifFileList=listFiles(WifinDir)
	 for i = 1,#wifFileList,1 do
	 print(wifFileList[i])
	 
	 if string.sub(wifFileList[i],1,4) == string.sub(pickedfill,1,4) then
	 sourceListBrowser:add(string.sub(wifFileList[i],1,-5))
	 table.insert(sourcelist,wifFileList[i])
end
end
end
function handle_wif_browser()
fltk_update()
if orig_edit_func==handle_wif_browser then orig_edit_func=nil end
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
     			
     			if wifBrowser:label()~=gObjName then	
     				updateObjListBrowser()
     			end
     			gObjName=lobje
     			wifBrowser:label(gObjName)
     			
     			
		end
		gOldSel=gCurSel
	end
	
     			
	
end
do wifBrowser= fltk:Fl_Double_Window(0,0,0,0,"")
wifBrowser:callback(wClose)
wifBrowser:resize(287,188,321,239)
wifBrowser:labelsize(10)
--wifBrowser:show()
do fillpick= fltk:Fl_Choice(0,0,0,0,"")
fillpick:callback(refillpick)
fillpick:resize(100,200,87,20)
fillpick:down_box(fltk.FL_BORDER_BOX)
fillpick:labeltype(fltk.FL_NO_LABEL)
fillpick:labelsize(11)
fillpick:when(1)
fillpick:textsize(11)
end

do animListBrowser= fltk:Fl_Browser(0,0,0,0,"")
animListBrowser:callback(runAnim)
animListBrowser:resize(190,15,125,180)
animListBrowser:type(3)
animListBrowser:labelsize(10)
animListBrowser:textsize(10)
end

do objListBrowser= fltk:Fl_Browser(0,0,0,0,"")
objListBrowser:callback(objListBrowserCallback)
objListBrowser:resize(0,15,95,215)
objListBrowser:type(3)
objListBrowser:labelsize(10)
objListBrowser:textsize(10)
end

do sourceListBrowser= fltk:Fl_Browser(0,0,0,0,"")
sourceListBrowser:callback(ModelAnimationList)
sourceListBrowser:resize(95,15,95,180)
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
stopControl:resize(195,200,45,20)
stopControl:labelsize(10)
end

do animLoopControl= fltk:Fl_Check_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Looped")
animLoopControl:label(gLabelTable[#gLabelTable])
animLoopControl:resize(245,200,60,20)
animLoopControl:down_box(fltk.FL_DOWN_BOX)
animLoopControl:labelsize(10)
end

do widget= fltk:Fl_Box(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Select")
widget:label(gLabelTable[#gLabelTable])
widget:resize(0,0,110,15)
widget:labelsize(10)
end

do widget= fltk:Fl_Box(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Anim Source")
widget:label(gLabelTable[#gLabelTable])
widget:resize(95,0,75,15)
widget:labelsize(10)
end

do widget= fltk:Fl_Box(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Animations")
widget:label(gLabelTable[#gLabelTable])
widget:resize(195,0,110,15)
widget:labelsize(10)
end
end
wifBrowser:show()

for i = 1,#filad,1 do fillpick:add(filad[i]) end
fillpick:label("")
fillpick:value(0)

wifBrowser:label("")
wifBrowser:show()
wifBrowser:make_current()
refillpick()
updateObjListBrowser()
orig_edit_func=edit_func
edit_func=handle_wif_browser
--end
Fl:run()
