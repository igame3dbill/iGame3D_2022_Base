--function make_window()
function removeDuplicateEdgesClicked(w)
	ig3d_RemoveDuplicateEdges()
end

function selectNextBadEdgeClicked(w)
	ig3d_SelectUnclosedEdges()
end

function removeDoubleSidedFacesAndFixFacingsClicked(w)
	ig3d_RemoveDoubleSidedFacesAndFixFacings()
end
do ShadowFixingUtilities= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Shadow Fixing Utilities")
ShadowFixingUtilities:label(gLabelTable[#gLabelTable])
ShadowFixingUtilities:resize(385,385,462,438)
--ShadowFixingUtilities:show()
do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Delete duplicate edges")
widget:label(gLabelTable[#gLabelTable])
widget:callback(removeDuplicateEdgesClicked)
widget:resize(25,25,290,25)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Select next bad edge")
widget:label(gLabelTable[#gLabelTable])
widget:callback(selectNextBadEdgeClicked)
widget:resize(25,50,290,25)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Remove double sided faces and fix facings")
widget:label(gLabelTable[#gLabelTable])
widget:callback(removeDoubleSidedFacesAndFixFacingsClicked)
widget:resize(25,75,290,25)
end
end
ShadowFixingUtilities:show()

--end
Fl:run()
