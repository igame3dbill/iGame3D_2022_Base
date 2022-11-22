--function make_window()
gLastBrowserControlClick=time()
gLastSelection=-1

gBrowserPath=gameroot.."Data/Images/"
gBrowserFiles={}
function listPNGFiles()
gBrowserFiles={}
    pngFileBrowser:clear()
    for file in lfs.dir(gBrowserPath) do
        if string.sub(file, 1,1)~="." or file==".." then
            local f = gBrowserPath..'/'..file
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
             if attr.mode == "file" and string.sub(file, -4,-1)==".png" then 
             	local a={file, "file"}
             	table.insert(gBrowserFiles, a)
             	pngFileBrowser:add(file)
             end   
           if attr.mode == "directory" then 
           local a={file, "directory"}
             table.insert(gBrowserFiles, a)
             pngFileBrowser:add(file.."     ->")
	   end  
        end
     end
     
end
function updatePNGPreviewBox(name)
	fltk.fl_register_images()
	local a=gBrowserPath 
	local b=string.sub(name, 1,-5)..".png"
	local img = Fl_Shared_Image.get(a..b)
	pngPreviewBox:color(40)
	if img==nil then
		img=Fl_Shared_Image.get(gameroot.."Data/Images/Colors/white.png")
		
	else
		
	end
	
	pngPreviewBox:image(img)
	pngPreviewBox:redraw()
end
function pngLoad(w)
	if pngFileBrowser:value()==0 then return end
	local theFile=gBrowserFiles[tonumber(pngFileBrowser:value())]
	if theFile[2]=="directory" then return end
	
	local c=#(gameroot)+1
	local newObj={}
	table.insert(gObjects, newObj)
	local n=#gObjects
	loadTexture( string.sub(gBrowserPath..theFile[1],c,-1))
	gCatchTexturePath = string.sub(gBrowserPath..theFile[1],c,-1)
	if ParticleBrowser ~= nil then updateTexture() end
	PNGBrowserNew:make_current()
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
		listPNGFiles()
	end
end
function browserControlClicked(w)
	if w:value()==0 then return end
	local theFile=gBrowserFiles[tonumber(w:value())]
	if theFile[2]=="file" then
		updatePNGPreviewBox(theFile[1])
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
do PNGBrowserNew= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "PNG Browser")
PNGBrowserNew:label(gLabelTable[#gLabelTable])
PNGBrowserNew:callback(wClose)
PNGBrowserNew:resize(94,184,141,400)
Fl_Group:current():resizable(PNGBrowserNew)
--unknown attribute: noborder
PNGBrowserNew:size_range(143,403,192,680)
--PNGBrowserNew:show()
do pngPreviewBox= fltk:Fl_Box(0,0,0,0,"")
pngPreviewBox:resize(5,2,128,128)
pngPreviewBox:box(fltk.FL_FLAT_BOX)
pngPreviewBox:color(40)
pngPreviewBox:align(16)
end

do pngFileBrowser= fltk:Fl_Browser(0,0,0,0,"")
pngFileBrowser:callback(browserControlClicked)
pngFileBrowser:resize(5,156,128,235)
pngFileBrowser:type(2)
pngFileBrowser:labelsize(10)
pngFileBrowser:when(3)
pngFileBrowser:textsize(10)
Fl_Group:current():resizable(pngFileBrowser)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Load Image")
widget:label(gLabelTable[#gLabelTable])
widget:callback(pngLoad)
widget:resize(5,133,128,20)
widget:labelsize(10)
end
end
PNGBrowserNew:show()

PNGBrowserNew:show()



listPNGFiles()
--end
Fl:run()
