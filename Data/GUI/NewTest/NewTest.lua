--function make_window()
do window= fltk:Fl_Double_Window(0,0,0,0,"")
window:resize(205,228,120,100)
--window:show()
do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "button")
widget:label(gLabelTable[#gLabelTable])
widget:resize(25,25,64,20)
end
end
window:show()

print("Hello, World!\n");
window:show()
--end
Fl:run()
