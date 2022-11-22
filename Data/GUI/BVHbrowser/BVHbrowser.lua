--function make_window()
gBVHLastBrowserControlClick=time()
gBVHLastSelection=-1

gBVHBrowserPath=gameroot.."Data/BVH/"
gBVHBrowserFiles={}

function listBVHFiles()
gBVHBrowserFiles={}
    bvhFileBrowser:clear()
    for file in lfs.dir(gBVHBrowserPath) do
        if string.sub(file, 1,1)~="." or file==".." then
            local f = gBVHBrowserPath..'/'..file
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
             if attr.mode == "file" and (string.sub(file, -4,-1)==".bvh" or string.sub(file, -4,-1)==".BVH") then 
             	local a={file, "file"}
             	table.insert(gBVHBrowserFiles, a)
             	bvhFileBrowser:add(file)
             end   
           if attr.mode == "directory" then 
           local a={file, "directory"}
             table.insert(gBVHBrowserFiles, a)
             bvhFileBrowser:add(file.."     ->")
	   end  
        end
     end
     
end



function bvhRunAnimClicked(w)
	if bvhFileBrowser:value()==0 then return end
	local theFile=gBVHBrowserFiles[tonumber(bvhFileBrowser:value())]
	if theFile[2]=="directory" then return end
	
	loadBVHFile(gBVHBrowserPath..theFile[1], false)
	--convertButtonClicked()
	
end

function bvhspeedControlClicked(w)
	gBVHSpeedCoefficient=w:value()*0.01
	
end




function bvhbrowserControlDoubleClicked(w)
	--
	local theFile=gBVHBrowserFiles[tonumber(w:value())]
	
	if theFile[2]=="directory" then
		if theFile[1]==".." then 
			gBVHBrowserPath=goDirsUp(gBVHBrowserPath, 1)
		else
			gBVHBrowserPath=gBVHBrowserPath..theFile[1].."/"
		end
		listBVHFiles()
	else
		bvhRunAnimClicked(w)
	end
	
end

function bvhbrowserControlClicked(w)
	if w:value()==0 then return end
	local theFile=gBVHBrowserFiles[tonumber(w:value())]
	
	
	local t=time()
	
	if t-gBVHLastBrowserControlClick < 0.4 and w:value()==gBVHLastSelection then
		bvhbrowserControlDoubleClicked(w)
		gBVHLastBrowserControlClick=0
	else
		gBVHLastBrowserControlClick=time()
	end
	gBVHLastSelection=w:value()
	
end
function convertButtonClicked(w)
	if bvhFileBrowser:value()==0 then return end
	local theFile=gBVHBrowserFiles[tonumber(bvhFileBrowser:value())]
	if theFile[2]=="directory" then return end
	
	loadBVHFile(gBVHBrowserPath..theFile[1], false)
	
	local step=0.1
	
	local lStart=0
	local lFrm=1
	local bn
	local a
	local objname=getObjectInfo(1, IG3D_NAME)
	
	fh=io.open(gameroot.."Data/BVH/Conversions/"..theFile[1]..".txt","w")
	
	local t=math.floor(#poses*gFrameTime / step)*20 ---better count bones and dont assume 20
	fh:write(theFile[1].."\n"..t.."\n")
	
	local at=0
	
	while lFrm<#poses do
		lStart=lStart+step
		lFrm=math.floor( lStart/gFrameTime)
		if lFrm<=#poses and lFrm>0 and at < t then
			
			at=at+20
			
			rootBone.itrtr=string.gmatch(poses[lFrm], "[^\n	 ]+")
			
			createLocalMatricesForBVHFrame(rootBone, rootBone.itrtr)
			
			for i=0,19,1 do
				bn=get(ig3d_bone, 1, i)
				a=getBoneInfo(bn, IG3D_NAME)
				local bonx,bony,bonz,bonxa,bonya,bonza=ig3d_GetObjectBoneInfo_2s_6f(objname,a)
				fh:write((lStart-step)..","..lStart.."\n")
				fh:write("morph="..i..","..bonx..","..bony..","..bonz..","..bonxa..","..bonya..","..bonza.."\n")					
			end
			
			
			
		end
	end
	
	fh:close()
	
	
end
do BVHBrowser= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "BVH Browser")
BVHBrowser:label(gLabelTable[#gLabelTable])
BVHBrowser:resize(723,50,295,321)
BVHBrowser:labelsize(12)
--BVHBrowser:show()
do bvhFileBrowser= fltk:Fl_Browser(0,0,0,0,"")
bvhFileBrowser:callback(bvhbrowserControlClicked)
bvhFileBrowser:resize(0,0,285,255)
bvhFileBrowser:type(2)
bvhFileBrowser:labelsize(10)
bvhFileBrowser:when(3)
bvhFileBrowser:textsize(10)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Run Animation")
widget:label(gLabelTable[#gLabelTable])
widget:callback(bvhRunAnimClicked)
widget:resize(5,260,105,25)
end

do widget= fltk:Fl_Value_Slider(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Speed in perc.")
widget:label(gLabelTable[#gLabelTable])
widget:callback(bvhspeedControlClicked)
widget:resize(85,290,205,25)
widget:type(1)
widget:labelsize(12)
widget:align(4)
widget:maximum(200)
widget:step(1)
widget:value(100)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Convert to iGame3D animation")
widget:label(gLabelTable[#gLabelTable])
widget:callback(convertButtonClicked)
widget:resize(115,260,170,25)
widget:labelsize(10)
end
end
BVHBrowser:show()

BVHBrowser:show()



listBVHFiles()
--end
Fl:run()
