--function make_window()
gFoldersFound={}
WTFCategories={}
gameroot=getSceneInfo(IG3D_ROOT)
Lastpathout=""
WTFFolderPath=gameroot.."Data/WTF"
wtfsaveFile=""
ChosenCategory=""
function dirandsubdirs(tPath)
	for file in lfs.dir(tPath) do
		if string.sub(file, 1,1) ~= "."    then
		local f = tPath..'/'..file
            	local attr = lfs.attributes(f)
            	assert (type(attr) == "table")
             		if attr.mode == "directory" then 
           		local a={file, "directory"}
           		f =string.gsub(f,"//","/")
			table.insert(gFoldersFound, f)
			end 
		end
	end
	
end
function WTFcategorybrowserClick(w)
if w:value() == nil or w:value() <= 1 then return end
n=w:value()
Lastpathout = WTFCategories[n]
WTFname=WTFnameinput:value()
pathoutfield:value(Lastpathout.."/"..WTFname)


end
function fillWTFcategoryInputChoice()
gFoldersFound={}
--WTFcategorybrowser:clear()
CategoryInputChoice:clear()
dirandsubdirs(WTFFolderPath)

for i,v in pairs(gFoldersFound) do 
print(v)
table.insert(WTFCategories,v)
o=string.gsub(v,WTFFolderPath.."/","")
--WTFcategorybrowser:add(o)
CategoryInputChoice:add(o)
end
CategoryInputChoice:redraw()
--WTFcategorybrowser:redraw()
end
function updateWTFpathout(w)
if Lastpathout=="" then return end
a=w:value()
a=string.gsub(a,".wtf","")
o=Lastpathout.."/"..a..".wtf"

pathoutfield:value(o)
ExportWTFWindow:redraw()
wtfsaveFile=o
end
function CancelExportWTF()

ExportWTFWindow:hide()
ExportWTFWindow=nil
end
function SaveWTF_MouseUp()
if wtfsaveFile ~= nil then
a=""
for i,v in pairs(gFoldersFound) do
a=a..v.." "
end
if string.find(a,ChosenCategory)== nil then
ig3d_CreateDirectory_s(WTFFolderPath.."/"..ChosenCategory)
end
ig3d_SaveMeshAsWTF_sf(wtfsaveFile,100)
end
end
function CategoryInputChoice_cb(w)

pathoutfield:value("")
a=w:value()
ChosenCategory=a
WTFname=WTFnameinput:value()
a=w:value()
--a=string.gsub(a,".wtf","")
o=WTFFolderPath.."/"..a.."/"..WTFname..".wtf"
Lastpathout=WTFFolderPath.."/"..a
if WTFname ~= "" then 


pathoutfield:value(o)
ExportWTFWindow:redraw()
 end
wtfsaveFile=o


end
do ExportWTFWindow= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Export WTF")
ExportWTFWindow:label(gLabelTable[#gLabelTable])
ExportWTFWindow:callback(CancelExportWTF)
ExportWTFWindow:resize(12,50,445,75)
ExportWTFWindow:size_range(288,142,288,142)
--ExportWTFWindow:show()
do WTFnameinput= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Name:")
WTFnameinput:label(gLabelTable[#gLabelTable])
WTFnameinput:callback(updateWTFpathout)
WTFnameinput:resize(125,36,215,23)
WTFnameinput:labelsize(11)
WTFnameinput:align(5)
WTFnameinput:when(1)
WTFnameinput:textsize(11)
end

do buttonsgroup= fltk:Fl_Group(0,0,0,0,"")
buttonsgroup:resize(350,10,90,50)
do OkSaveWTFButton= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Save")
OkSaveWTFButton:label(gLabelTable[#gLabelTable])
OkSaveWTFButton:callback(SaveWTF_MouseUp)
OkSaveWTFButton:resize(350,35,85,25)
OkSaveWTFButton:labelsize(12)
end
Fl_Group:current(Fl_Group:current():parent())
end

do CategoryInputChoice= fltk:Fl_Input_Choice(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Path:")
CategoryInputChoice:label(gLabelTable[#gLabelTable])
CategoryInputChoice:callback(CategoryInputChoice_cb)
CategoryInputChoice:resize(5,35,115,24)
CategoryInputChoice:labelsize(11)
CategoryInputChoice:align(5)
CategoryInputChoice:textsize(11)
end

do pathoutfield= fltk:Fl_Output(0,0,0,0,"")
pathoutfield:resize(5,1,419,19)
pathoutfield:box(fltk.FL_NO_BOX)
pathoutfield:textsize(10)
end
end
ExportWTFWindow:show()

ExportWTFWindow:show()
fillWTFcategoryInputChoice()
--end
Fl:run()
