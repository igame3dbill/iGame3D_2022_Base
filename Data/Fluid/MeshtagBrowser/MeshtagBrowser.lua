--function make_window()
--globals
selectedTagName=""
selectedTagNum=0
extractedTagName={}
taglistfirstrun = true
if  nTagNumber == nil then  nTagNumber = 0 end
-- extractTagName(selectedTagName)
function extractTagName(s)
local tx,ty,tt,tw 
if string.find(s,"_") ~= nil then
 sb = string.match(s,"%d+%_%d+")
 tx=tonumber(string.sub(sb,1, string.find(sb,"_")-1) )
 ty=tonumber(string.sub(sb, string.find(sb,"_")+1,-1) )
 ss = string.match(s,"%a+")
	if ss ~= nil then
	
	return tx,ty,ss
	end
end

end
-- listUsedTags
function listUsedTags()
local ss = ig3d_GetMesh_tagsList__s()
local s=ss
local n = 0
local tt=1

nTagNumber=getlinecount(ss)
 	for i =1,nTagNumber,1 do
 	local ok = true
	ig3d_SelectMesh_tagVertices_ib(i,true)
	local x,y,z=ig3d_GetMeshCentroid__3f()
	if x+y+z==0 then 
	ig3d_SetMeshPosition_3f(1.0,1.0,1.0)
	local ab,cd,ef=ig3d_GetMeshCentroid__3f()
		if (ab + cd + ef) == 0 then 
		ig3d_DeleteMesh_tag_i(i)
		ok = false
		else
		ig3d_SetMeshPosition_3f(x,y,z)
		ok = true
		end
 	end
 	
 		if ok == true then
 		sb=getlineof(ss,i)
 		table.insert(meshTagListTable,sb)
 		end
	end
end
 
 function fillmeshTagList()
 MeshTagBrowser:redraw()
fltk_update()
 local ss = ig3d_GetMesh_tagsList__s()
	nTagNumber=getlinecount(ss)
 	for i =1,nTagNumber,1 do
 	table.insert(meshTagListTable,getlineof(ss,i))
 	end
 end
-- listMeshTagBrowser






function listMeshTagBrowser()
local ss = ig3d_GetMesh_tagsList__s()
meshMatListTable={}
local s=ss
local n = 0
local tt=1
 MeshtagListBrowser:clear()
 	for i =1,#meshTagListTable,1 do 
	MeshtagListBrowser:add(meshTagListTable[i])
	MeshtagListBrowser:redraw()
	MeshTagBrowser:redraw()

	end
if selectedTagNum == nill or selectedTagNum > #meshTagListTable then selectedTagNum = 1 end
nTagNumber  = #meshTagListTable
MeshtagListBrowser:select(selectedTagNum)
MeshtagListBrowser:select(selectedTagNum,selectedTagNum)
MeshtagListBrowser:value(selectedTagNum)
MeshtagListBrowser:redraw()
MeshTagBrowser:redraw()
fltk_update()
end

function matinlist(w)
local ss = ig3d_GetMeshMaterialsList__s ()
meshMatListTable={}
local s=ss
local n = 0
 nmat=0
for i in string.gmatch(ss,"\n") do
n=string.find(s,"\n")
if n == nil then n = 0 end
nmat=nmat+1
sb=string.sub(s,1,n-1)
if w == s then return true,nmat end
end

return false,0
end
-- meshtaglistbrowsercb
function meshTagListBrowserCB(w)
if w:value() == nil or w:value() == 0 then return end
local n = w:value()
selectedTagNum = n
ig3d_SelectMesh_tagVertices_ib(selectedTagNum,true)
selectedTagName = meshTagListTable[selectedTagNum]



if cameraTagSnapBtn:value() == 1 then
local tmx,tmy,tmz=ig3d_GetMeshCentroid__3f()
local cx,cy,cz=getCameraInfo(IG3D_POSITION)

setCameraInfo(IG3D_POSITION,tmx+1.8,cy,tmz+1.8)
camera_face_xyz(tmx,tmy,tmz)
end

end
-- PNG BROWSER
mtPNGBrowserPath=gameroot.."Data/Images/"
mtPNGBrowserFiles={}
mtPNGLastSelection = ""
function mtlistPNGFiles()
mtPNGBrowserFiles={}
    mtPNGFileBrowser:clear()
    for file in lfs.dir(mtPNGBrowserPath) do
        if string.sub(file, 1,1)~="." or file==".." then
            local f = mtPNGBrowserPath..'/'..file
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
             if attr.mode == "file" and string.sub(file, -4,-1)==".png" then 
             	local a={file, "file"}
             	table.insert(mtPNGBrowserFiles, a)
             	mtPNGFileBrowser:add(file)
             end   
           if attr.mode == "directory" then 
           local a={file, "directory"}
             table.insert(mtPNGBrowserFiles, a)
             mtPNGFileBrowser:add(file.."     ->")
	   end  
        end
     end
     
end
function updatemtPNGPreviewBox(name)
MeshTagBrowser:make_current()
	fltk.fl_register_images()
	local a=mtPNGBrowserPath 
	local b=string.sub(name, 1,-5)..".png"
	local img = Fl_Shared_Image.get(a..b)
	mtPNGPreviewBox:color(40)
	if img==nil then
		img=Fl_Shared_Image.get(gameroot.."Data/Images/Colors/white.png")
	end
	mtPNGPreviewBox:image(img,128,128)
	mtPNGPreviewBox:redraw()
	MeshTagBrowser:redraw()
	fltk_update()
end
function mtPNGLoad(w)
	MeshTagBrowser:make_current()
	if mtPNGFileBrowser:value()==0 then return end
	local theFile=mtPNGBrowserFiles[tonumber(mtPNGFileBrowser:value())]
	if theFile[2]=="directory" then return end
	local c=#(gameroot)+1
	loadTexture( string.sub(mtPNGBrowserPath..theFile[1],c,-1))
	gCatchTexturePath = string.sub(mtPNGBrowserPath..theFile[1],c,-1)
	wp = fileShortNameFromPath(gCatchTexturePath)
	local mc,ms,ws,lst
	local mato = ""
	local rtc=0
	nmbool,mc=matinlist(selectedTagName)
	if nmbool == true then
	ms=ig3d_GetMeshMaterialInfo_i_s(mc)
	else
	ig3d_CreateMaterial_s(selectedTagName.."_mat")
	mc=getlinecount(ig3d_GetMeshMaterialsList__s())
	ms=ig3d_GetMeshMaterialInfo_i_s(mc)
	end
		if ms ~= nil then
		local ss=ms
			tname=getlineof(ms,1)
			tcount=tonumber(getlineof(ms,2))+1
			tox,toy=string.find(ms,"smooth")
			
		if string.find(ms,"texture")== nil then
		ms=ms.."\n".."texture=1,"..gCatchTexturePath
		mato = tname.."\n"..tcount.."\n"..string.sub(ms,tox,-1)
		
			else
			for ws in string.gmatch(ms,"\n") do
			rtp=string.find(ss,"\n")
			if rtp ~= nil then 
			rtc=rtc+1
			lst=string.sub(ss,1,rtp-1) 
			if rtc == 2 then lst=tonumber(lst)+1 end
			if string.find(lst,"texture=") ~=nil then lst="texture=1,"..gCatchTexturePath end
			mato=mato..lst.."\n"
			ss = string.sub(ss,rtp+1,-1)
			end
			end
			end
		
		ig3d_SetMeshMaterialInfo_is(mc,mato)
		ig3d_SetMaterialForSelectedMesh_i(mc) 
		end
	
	
end
function mtPNGbrowserControlDoubleClicked(w)
	--
	local theFile=mtPNGBrowserFiles[tonumber(w:value())]
	if theFile[2]=="directory" then
		if theFile[1]==".." then 
			mtPNGBrowserPath=goDirsUp(mtPNGBrowserPath, 1)
		else
			mtPNGBrowserPath=mtPNGBrowserPath..theFile[1].."/"
		end
		mtlistPNGFiles()
	end
end
function mtPNGbrowserControlClicked(w)
	if w:value()==0 then return end
	local theFile=mtPNGBrowserFiles[tonumber(w:value())]
	if theFile[2]=="file" then
		updatemtPNGPreviewBox(theFile[1])
	end
	
	local t=time()
	
	if t-gLastBrowserControlClick < 0.4 and w:value()==mtPNGLastSelection then
		mtPNGbrowserControlDoubleClicked(w)
		gLastBrowserControlClick=0
	else
		gLastBrowserControlClick=time()
	end
	mtPNGLastSelection=w:value()
	
end
--getnextXtag
function getnextXtag()
local e={{}}

local x,y,wf=extractTagName(selectedTagName)

if x== nil then return end
x=tonumber(x)
 
print(x,y,wf)




	for i =1,#meshTagListTable,1 do 
	btnsx,bw,btnfac = extractTagName(meshTagListTable[i])
	
	if btnsx > x and btnfac==wf then 
	local btnm=btnsx.."_"..y.."_"..wf
	selectedTagName = btnm
	selectedTagNum = i
	ig3d_SelectMesh_tagVertices_ib(selectedTagNum,true)
	selectedTagName=getlineof(ig3d_GetMesh_tagsList__s(),selectedTagNum)
	MeshtagListBrowser:select(selectedTagNum)
	MeshtagListBrowser:select(selectedTagNum,selectedTagNum)
	MeshtagListBrowser:value(selectedTagNum)
	MeshtagListBrowser:redraw()
	MeshTagBrowser:redraw()
	
		if cameraTagSnapBtn:value() == 1 then
		local tmx,tmy,tmz=ig3d_GetMeshCentroid__3f()
		local cx,cy,cz=getCameraInfo(IG3D_POSITION)
		setCameraInfo(IG3D_POSITION,tmx+1.8,cy,tmz+1.8)
		camera_face_xyz(tmx,tmy,tmz)
		end
	
	return 
	end
	
	 
	end  
	
end
do MeshTagBrowser= fltk:Fl_Double_Window(0,0,0,0,"")
MeshTagBrowser:resize(150,200,270,421)
--MeshTagBrowser:show()
do MeshtagListBrowser= fltk:Fl_Browser(0,0,0,0,"")
MeshtagListBrowser:callback(meshTagListBrowserCB)
MeshtagListBrowser:resize(0,0,135,390)
MeshtagListBrowser:type(2)
MeshtagListBrowser:labelsize(10)
MeshtagListBrowser:textsize(10)
end

do pngBrowserGroup= fltk:Fl_Group(0,0,0,0,"")
pngBrowserGroup:resize(140,1,129,389)
do mtPNGPreviewBox= fltk:Fl_Box(0,0,0,0,"")
mtPNGPreviewBox:resize(140,1,128,128)
mtPNGPreviewBox:box(fltk.FL_FLAT_BOX)
mtPNGPreviewBox:color(40)
mtPNGPreviewBox:align(16)
end

do mtPNGFileBrowser= fltk:Fl_Browser(0,0,0,0,"")
mtPNGFileBrowser:callback(mtPNGbrowserControlClicked)
mtPNGFileBrowser:resize(140,155,128,235)
mtPNGFileBrowser:type(2)
mtPNGFileBrowser:labelsize(10)
mtPNGFileBrowser:when(3)
mtPNGFileBrowser:textsize(10)
end

do mtLoadButton= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Load Image")
mtLoadButton:label(gLabelTable[#gLabelTable])
mtLoadButton:callback(mtPNGLoad)
mtLoadButton:resize(140,132,128,20)
mtLoadButton:labelsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do cameraTagSnapBtn= fltk:Fl_Check_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Camera Snap")
cameraTagSnapBtn:label(gLabelTable[#gLabelTable])
cameraTagSnapBtn:resize(10,400,90,15)
cameraTagSnapBtn:down_box(fltk.FL_DOWN_BOX)
cameraTagSnapBtn:labelsize(11)
end
end
MeshTagBrowser:show()

MeshTagBrowser:show()
MeshTagBrowser:redraw()



mtlistPNGFiles()
MeshTagBrowser:redraw()
if meshTagListTable then
listMeshTagBrowser()
else
fillmeshTagList()
listMeshTagBrowser()
end
ig3d_SetMeshTool_i(2)
MeshTagBrowser:redraw()
fltk_update()
--end
Fl:run()
