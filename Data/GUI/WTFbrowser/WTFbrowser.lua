--function make_window()
-- WTF BROWSER CODE AHEAD 1015
gLastBrowserControlClick=time()
gLastSelection=-1
gDropObject = gameroot.."Data/WTF/Cubes/cube.wtf"
gBrowserPath=gameroot.."Data/WTF/"
gBrowserFiles={}
-- (left, top, right, bottom) 
gGLX,gGLY,gGLR,gGLB = ig3d_GetWindowBounds__4i()

function listWTFFiles()
gBrowserFiles={}
    wtfFileBrowser:clear()
    for file in lfs.dir(gBrowserPath) do
        if string.sub(file, 1,1)~="." or file==".." then
            local f = gBrowserPath..'/'..file
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
             if attr.mode == "file" and string.sub(file, -4,-1)==".wtf" then 
             	local a={file, "file"}
             	table.insert(gBrowserFiles, a)
             	wtfFileBrowser:add(file)
             end   
           if attr.mode == "directory" then 
           local a={file, "directory"}
             table.insert(gBrowserFiles, a)
             wtfFileBrowser:add(file.."     ->")
	   end  
        end
     end
     
end

function updateWTFPreviewBox(name)
	fltk.fl_register_images()
	local a=string.gsub(gBrowserPath, "/WTF/", "/WTFPreviews/")
	print("a= "..a)
	local b=string.sub(name, 1,-5).."_wtf.png"
	local img = Fl_Shared_Image.get(a..b)
	wtfPreviewBox:color(40)
	if img==nil then
		img=Fl_Shared_Image.get(gameroot.."Data/Images/Colors/white.png")
		wtfPreviewNote:label("No preview available")
	else
		wtfPreviewNote:label("")
	end
	
	WPW=wtfPreviewBox:w()
	WPH=wtfPreviewBox:h()
	wtfPreviewBox:image(img,WPW-8,WPH-8)
	--wtfPreviewBox:resize(90,3,WPW-8,WPH-8)
	wtfPreviewBox:redraw()
end

function wtfAddObjectClicked(w)
	if wtfFileBrowser:value()==0 then return end
	local theFile=gBrowserFiles[tonumber(wtfFileBrowser:value())]
	if theFile[2]=="directory" then return end
	
	local c=#(gameroot.."Data/WTF/")+1
	local newObj={}
	table.insert(gObjects, newObj)
	local n=#gObjects
	gDropObject = string.sub(gBrowserPath..theFile[1],c,-1)
	gObjects[n].cObj=make(ig3d_object, gDropObject)
	
end

function wtfPreviewLoadMesh(w)
	if wtfFileBrowser:value()==0 then return end
	local theFile=gBrowserFiles[tonumber(wtfFileBrowser:value())]
	if theFile[2]=="directory" then return end
	
	local c=#(gameroot)+1
	local newObj={}
	table.insert(gObjects, newObj)
	local n=#gObjects
	loadMesh( string.sub(gBrowserPath..theFile[1],c,-1))
end

function createPreviewsClicked(w)
	if wtfFileBrowser:value()==0 then return end
	local theFile=gBrowserFiles[tonumber(wtfFileBrowser:value())]
	local a=string.gsub(gBrowserPath, "/WTF/", "/WTFPreviews/")
	print("a= "..a)
	local b=string.sub(theFile[1], 1,-5).."_wtf.png"
	local c=#gameroot+1
	
	
	if theFile[2]=="file" then
		ig3d_CreateDirectory_s(goDirsUp(a..b,0))
		createWTFPreviewPNG(string.sub(gBrowserPath..theFile[1], c,-1), a..b)
		updateWTFPreviewBox(theFile[1])
	end
	
	if theFile[2]=="directory" then
		ig3d_CreateDirectory_s(a..theFile[1])
		batchPreviewsForFolder(string.sub(gBrowserPath..theFile[1].."/", c,-1), string.sub(a..theFile[1].."/", c,-1))
	end
	ig3d_SetWindowBounds_4i(gGLX,gGLY,gGLR,gGLB)
end


function browserControlDoubleClicked(w)
	--
	local theFile=gBrowserFiles[tonumber(w:value())]
	if theFile[2]=="directory" then
		if theFile[1]==".." then 
			gBrowserPath=goDirsUp(gBrowserPath, 1)
		else
			gBrowserPath=gBrowserPath..theFile[1].."/"
		end
		listWTFFiles()
	end
	
end

function browserControlClicked(w)
	if w:value()==0 then return end
	local theFile=gBrowserFiles[tonumber(w:value())]
	if theFile[2]=="file" then
		updateWTFPreviewBox(theFile[1])
	end
	
	local t=time()
	
	if t-gLastBrowserControlClick < 0.4 and w:value()==gLastSelection then
		browserControlDoubleClicked(w)
		gLastBrowserControlClick=0
	else
		gLastBrowserControlClick=time()
	end
	gLastSelection=w:value()
	
end
function createLowPolyClicked(w)

	if wtfFileBrowser:value()==0 then return end
	local theFile=gBrowserFiles[tonumber(wtfFileBrowser:value())]
	if theFile[2]=="directory" then return end
	
	local c=#(gameroot)+1
	local newObj={}
	table.insert(gObjects, newObj)
	local n=#gObjects
	local mp=string.sub(gBrowserPath..theFile[1],c,-1)
	loadMesh( mp )
	
	local bl=ig3d_GetMeshBonesList__s()
	
	for w in string.gmatch(bl, "[^\n]+") do
		local spaceoffset=string.find(w, " ")
		local nam=string.sub(w, 1, spaceoffset-1)
		--local num=string.sub(w, spaceoffset+1, -1)
		ig3d_SelectMeshBone_s(nam)
		ig3d_MakeInvisible()
     	end
     	ig3d_SelectWholeMesh()
     	ig3d_PolyReductionDownToVertexCount_i(lowpolynumvertices:value())
	ig3d_ShowAll()
	mp=string.sub(mp, 1, -5).."low.wtf"
	saveMesh(mp)
	ig3d_SelectWholeMesh()
	ig3d_DeleteMesh_b(false)
	
end
function batchBinariesForFolder(thefolder1)
	local allFiles=listFiles(thefolder1)
	local i
	local suffix
	
	for i=1,#allFiles,1 do
		suffix=string.sub(allFiles[i], -4,-1)
		if suffix==".wtf" then
			local filename=string.sub(thefolder1..allFiles[i], #gameroot+10, -1)
			--print(filename)
			a=make(ig3d_object, filename)
			delete(ig3d_object, a)
		end
	end
end


function createBinariesClicked(w)
	if wtfFileBrowser:value()==0 then return end
	local theFile=gBrowserFiles[tonumber(wtfFileBrowser:value())]
	local c=#gameroot+1
	
	
	if theFile[2]=="file" then
		local filename=string.sub(gBrowserPath..theFile[1], c+9, -1)
		a=make(ig3d_object, filename)
		delete(ig3d_object, a)
		
	end
	
	if theFile[2]=="directory" then
		batchBinariesForFolder(gameroot..string.sub(gBrowserPath..theFile[1].."/", c,-1))
	end
	
end
do WTFBrowserNew= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "WTF Catalog")
WTFBrowserNew:label(gLabelTable[#gLabelTable])
WTFBrowserNew:resize(101,181,421,305)
Fl_Group:current():resizable(WTFBrowserNew)
WTFBrowserNew:size_range(426,286,424,719)
--WTFBrowserNew:show()
do widget= fltk:Fl_Group(0,0,0,0,"")
widget:resize(0,1,336,49)
do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Add object")
widget:label(gLabelTable[#gLabelTable])
widget:callback(wtfAddObjectClicked)
widget:resize(169,12,80,19)
widget:labelsize(10)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Load mesh")
widget:label(gLabelTable[#gLabelTable])
widget:callback(wtfPreviewLoadMesh)
widget:resize(87,12,80,19)
widget:labelsize(10)
end

do lowpolybutton= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Create low-poly")
lowpolybutton:label(gLabelTable[#gLabelTable])
lowpolybutton:callback(createLowPolyClicked)
lowpolybutton:resize(253,12,80,19)
lowpolybutton:labelsize(10)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Create preview")
widget:label(gLabelTable[#gLabelTable])
widget:callback(createPreviewsClicked)
widget:resize(6,12,80,19)
widget:labelsize(10)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Create binary")
widget:label(gLabelTable[#gLabelTable])
widget:callback(createBinariesClicked)
widget:resize(5,31,80,19)
widget:labelsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do lowpolynumvertices= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Num vertices")
lowpolynumvertices:label(gLabelTable[#gLabelTable])
lowpolynumvertices:resize(338,12,73,19)
lowpolynumvertices:labelsize(10)
lowpolynumvertices:align(33)
lowpolynumvertices:minimum(1)
lowpolynumvertices:maximum(1000)
lowpolynumvertices:value(250)
lowpolynumvertices:textsize(10)
end

do wtfPreviewBox= fltk:Fl_Box(0,0,0,0,"")
wtfPreviewBox:resize(10,56,240,240)
wtfPreviewBox:box(fltk.FL_FLAT_BOX)
wtfPreviewBox:color(40)
wtfPreviewBox:align(16)
end

do wtfPreviewNote= fltk:Fl_Box(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "NO PREVIEW")
wtfPreviewNote:label(gLabelTable[#gLabelTable])
wtfPreviewNote:resize(10,59,240,16)
wtfPreviewNote:labelsize(10)
end

do wtfFileBrowser= fltk:Fl_Browser(0,0,0,0,"")
wtfFileBrowser:callback(browserControlClicked)
wtfFileBrowser:resize(255,56,160,241)
wtfFileBrowser:type(2)
wtfFileBrowser:labelsize(10)
wtfFileBrowser:when(3)
wtfFileBrowser:textsize(10)
Fl_Group:current():resizable(wtfFileBrowser)
end
end
WTFBrowserNew:show()

WTFBrowserNew:show()



listWTFFiles()
--end
Fl:run()
