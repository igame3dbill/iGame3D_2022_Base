--function make_window()
if ig3d_GetMesh_tagsList__s() == nil then 
ig3d_CreateMesh_tag_s("hip")
ig3d_CreateMesh_tag_s("abdomen")
ig3d_CreateMesh_tag_s("chest")
ig3d_CreateMesh_tag_s("neckDummy")
ig3d_CreateMesh_tag_s("neck")
ig3d_CreateMesh_tag_s("head")
ig3d_CreateMesh_tag_s("lCollar")
ig3d_CreateMesh_tag_s("lShldr")
ig3d_CreateMesh_tag_s("lForeArm")
ig3d_CreateMesh_tag_s("lHand")
ig3d_CreateMesh_tag_s("rCollar")
ig3d_CreateMesh_tag_s("rShldr")
ig3d_CreateMesh_tag_s("rForeArm")
ig3d_CreateMesh_tag_s("rHand")
ig3d_CreateMesh_tag_s("lThigh")
ig3d_CreateMesh_tag_s("lShin")
ig3d_CreateMesh_tag_s("lFoot")
ig3d_CreateMesh_tag_s("rThigh")
ig3d_CreateMesh_tag_s("rShin")
ig3d_CreateMesh_tag_s("rFoot")
tagsloaded = ig3d_GetMesh_tagsList__s()
end
function addToTagList(w)
if Fl:event_key() ~= fltk.FL_Enter and Fl:event_key() ~= fltk.FL_KP_Enter then return end
local newtag = TagNameAddField:value()

if newtag ~=nil then
ig3d_CreateMesh_tag_s(newtag)
		updateTagBrowser()
		TagNameList:remove(TagNameList:size())
		TagNameList:bottomline(TagNameList:size())
		TagNameList:select(TagNameList:size(),1)
		end
	
end
function updateTagBrowser()
TagNameList:clear()
taglist= ig3d_GetMesh_tagsList__s()

local  nItems = numberofitems(taglist,"\n")
 local itemList=""
 if nItems ~= nil then 
 
 for eachitem=1, nItems,1 do
 itemN=item(eachitem,taglist,"\n")
 
 if itemN~=nil  then
 if  itemList ~="" then  itemList = itemList.."\n"..itemN end
 --print(itemN)
  TagNameList:add(itemN)
 end

 end --for each item
 
 end

TagNameList:remove(TagNameList:size())

end
function selectTagLine(w)
local tagSelection = ""
local n = 0
for i=1,w:size() do
if w:selected(i) ~= 0 then 
n=n+1
if n >= 2 then  
ig3d_SelectMesh_tagVertices_ib(i,false)
else
ig3d_SelectMesh_tagVertices_ib(i,true)
end
  tagSelection = tagSelection .. "\n"..w:text(i) 
 end
end

if tagSelection == nil then tagSelection = w:text(w:value()) end 
print(tagSelection)
end
function tagVerticesAction()
local tagSelection = ""

for i=1,TagNameList:size() do
if TagNameList:selected(i) ~= 0 then 
ig3d_AddToMesh_tag_i(i)
  tagSelection = tagSelection .. "\n"..TagNameList:text(i) 
 end
end
--if tagSelection == nil then tagSelection = w:text(w:value()) end 
print(tagSelection)
end
function selectTaggedAction()
local tagSelection = ""

for i=1,TagNameList:size() do
if TagNameList:selected(i) ~= 0 then 
ig3d_SelectMesh_tagVertices_ib(i,false)
  tagSelection = tagSelection .. "\n"..TagNameList:text(i) 
 end
end

print(tagSelection)
end
function showTaggedAction()
local tagSelection = ""
ig3d_ShowAll() 
for i=1,TagNameList:size() do
	if TagNameList:selected(i) == 0 then
 ig3d_SelectMesh_tagVertices_ib(i,true)
  ig3d_MakeInvisible () 
	 ig3d_SetMesh_tagVisibility_ib(i,false)
	 else
	 ig3d_SelectMesh_tagVertices_ib(i,true)
	 ig3d_SetMesh_tagVisibility_ib(i,true)
  	 tagSelection = tagSelection .. "\n"..TagNameList:text(i) 
 	end
 	
end
ig3d_SelectWholeMesh() 
print(tagSelection)

end
function hideTaggedAction()
local tagSelection = ""

for i=1,TagNameList:size() do
	if TagNameList:selected(i) ~= 0 then
 ig3d_SelectMesh_tagVertices_ib(i,true)
 ig3d_MakeInvisible() 
	 ig3d_SetMesh_tagVisibility_ib(i,false)

  	 tagSelection = tagSelection .. "\n"..TagNameList:text(i) 
 	end
end

print(tagSelection)

end
function removeFromTagsAction()
local tagSelection = ""

for i=1,TagNameList:size() do
	if TagNameList:selected(i) ~= 0 then
 --ig3d_SelectMesh_tagVertices_ib(i,true)
ig3d_RemoveFromMesh_tag_i(i) 
  	 tagSelection = tagSelection .. "\n"..TagNameList:text(i) 
 	end
end

print(tagSelection)

end
function exportTagsAction()
local tagSelection = ""
 local tagsout = ""
 
for i=1,TagNameList:size() do

if TagNameList:text(i) ~= nil then 
tagSelection = tagSelection .. "\n"..TagNameList:text(i),x,y,z 
ig3d_SelectMesh_tagVertices_ib(i,true)

local x,y,z = ig3d_GetMeshCentroid__3f()

  
  tagsout = tagsout .. "ig3d_CreateMesh_tag_s('"..TagNameList:text(i) .. "')\n".."drawVertex("..x..","..y..","..z..")\n".."ig3d_AddToMesh_tag_i("..i..")\n";
 end
 
end
print(tagsout)

end
do MeshtagsWindow= fltk:Fl_Double_Window(0,0,0,0,"")
MeshtagsWindow:label("Mesh Tags")
MeshtagsWindow:resize(240,576,262,297)
MeshtagsWindow:when(6)
--MeshtagsWindow:show()
do TagNameAddField= fltk:Fl_Input(0,0,0,0,"")
TagNameAddField:label("Add:")
TagNameAddField:callback(addToTagList)
TagNameAddField:resize(90,262,140,23)
TagNameAddField:labelsize(11)
TagNameAddField:textsize(11)
end

do TagNameList= fltk:Fl_Browser(0,0,0,0,"")
TagNameList:callback(selectTagLine)
TagNameList:resize(10,5,165,250)
TagNameList:type(3)
TagNameList:labelsize(11)
TagNameList:when(4)
TagNameList:textsize(11)
end

do TagVerticesButton= fltk:Fl_Button(0,0,0,0,"")
TagVerticesButton:label("Tag Vertices")
TagVerticesButton:callback(tagVerticesAction)
TagVerticesButton:resize(180,5,75,20)
TagVerticesButton:labelsize(11)
end

do SelectTaggedButton= fltk:Fl_Button(0,0,0,0,"")
SelectTaggedButton:label("Select Tagged")
SelectTaggedButton:callback(selectTaggedAction)
SelectTaggedButton:resize(180,58,75,20)
SelectTaggedButton:labelsize(11)
end

do ShowTagged= fltk:Fl_Button(0,0,0,0,"")
ShowTagged:label("Show")
ShowTagged:callback(showTaggedAction)
ShowTagged:resize(180,108,75,20)
ShowTagged:labelsize(11)
end

do HideTaggedButton= fltk:Fl_Button(0,0,0,0,"")
HideTaggedButton:label("Hide")
HideTaggedButton:callback(hideTaggedAction)
HideTaggedButton:resize(180,83,75,20)
HideTaggedButton:labelsize(11)
end

do UnTagVerticesButton= fltk:Fl_Button(0,0,0,0,"")
UnTagVerticesButton:label("Remove Tags")
UnTagVerticesButton:callback(removeFromTagsAction)
UnTagVerticesButton:resize(180,32,75,20)
UnTagVerticesButton:labelsize(11)
end

do ExportTags= fltk:Fl_Button(0,0,0,0,"")
ExportTags:label("Export Tags")
ExportTags:callback(exportTagsAction)
ExportTags:resize(180,135,75,20)
ExportTags:labelsize(11)
end
end
MeshtagsWindow:show()

TagNameAddField:when(11)
updateTagBrowser()
--end
Fl:run()
