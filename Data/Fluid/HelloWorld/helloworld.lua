--function make_window()
do awindow= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Hello World")
awindow:label(gLabelTable[#gLabelTable])
awindow:resize(443,58,191,40)
--awindow:show()
do agroup= fltk:Fl_Group(0,0,0,0,"")
agroup:resize(0,15,190,20)
agroup:labelsize(11)
Fl_Group:current(Fl_Group:current():parent())
end
end
awindow:show()

awindow:label("Hello World")
agroup:label("Hello World")
awindow:show()
--end
Fl:run()
