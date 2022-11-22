--function make_window()
--Scripteditor code -----------------------


function editorPrint(...)
	local str=""
	local i=1
	while arg[i]~= nil do
		if str=="" then
			str=tostring(arg[i])
		else
			str=str.."	"..tostring(arg[i])
		end
		i=i+1
	end
	local l_offset=#editor_buf:text()
	editor:insert_position(l_offset)
	editor:insert(str.."\n")
	editor:show_insert_position()
	editor:textfont(4)
	editor:textsize(11)
end


function runScriptC()

	local str=editor_buf:text()	

	local code,error=loadstring(str)
	

	if code==nil then

		fltk.fl_message("The script you were attempting to run contains errors:\n"..error)

	else

		code()

	end

end



function openScript(tFile)


if changed then

	if not closeScript() then

		return false

	end

end
if tFile ==nil then

fileName = fltk.fl_file_chooser("Choose a script to open:", "Lua Files (*.{lua, ig3d})", nil, nil)
else
fileName = gameroot..tFile
end

if fileName~= nil then

print(fileName)
	local f=io.open(fileName, "r")
	local tText=f:read("*a")

	editorPrint(tText)

	f:close()

	closer:activate()

	path:value(fileName)

else

	return false

end
return true
end





function openScriptC()
closeScript()
	openScript()

end



function saveScript()

	if fileName == nil then

		fileName = fltk.fl_file_chooser("Please enter the filename:", "Lua Files (*.{lua, ig3d})", nil, nil)

		if fileName == nil then

			return false

		else

			path:value(fileName)

			closer:activate()

		end

	end

	

	local f=io.open(fileName, "w")

	f:write(editor_buf:text())

	f:close()

	changed=false

	saver:deactivate()

	return true

end



function saveScriptC()

	saveScript()

end









function editorChangedContents(w)
changed=true
saver:activate()
end





function closeScript()

	if changed then

		local r=fltk.fl_choice("Do you want to save your changes first?", "No", "Yes", "Cancel")

		if r == 2 then

			return false

		end

		

		if r == 1 then

			if not saveScript() then

				return false

			end

		end

	end

		

	editor_buf:text("")

	path:value("")

	changed=false

	fileName=nil

	closer:deactivate()

	saver:deactivate()

	return true

end



function closeScriptC()

	closeScript()

end





function newScript()

	if fileName~= nil or changed then

		if not closeScript() then

			return false

		end

	end

end



function newScriptC()

	newScript()

end



changed=false

fileName=nil



---------------------------------------------------------------------
do Data_Format_Window= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Data Format")
Data_Format_Window:label(gLabelTable[#gLabelTable])
Data_Format_Window:resize(577,142,374,429)
--unknown attribute: hide
do ExportCancel_group= fltk:Fl_Group(0,0,0,0,"")
ExportCancel_group:resize(5,1,355,409)
do export_button= fltk:Fl_Return_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Export")
export_button:label(gLabelTable[#gLabelTable])
export_button:resize(250,387,110,23)
export_button:labelsize(10)
end

do cancel_button= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Cancel")
cancel_button:label(gLabelTable[#gLabelTable])
cancel_button:resize(135,387,110,23)
cancel_button:labelsize(10)
end

do load_button= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Load")
load_button:label(gLabelTable[#gLabelTable])
load_button:resize(5,10,75,25)
load_button:labelsize(9)
end

do widget= fltk:Fl_File_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "file:")
widget:label(gLabelTable[#gLabelTable])
widget:resize(100,1,260,34)
widget:labelsize(9)
widget:textsize(9)
end
Fl_Group:current(Fl_Group:current():parent())
end

do tabs_group= fltk:Fl_Tabs(0,0,0,0,"")
tabs_group:resize(5,65,369,319)
tabs_group:labelsize(9)
do input_group= fltk:Fl_Group(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Input")
input_group:label(gLabelTable[#gLabelTable])
input_group:resize(10,95,350,267)
input_group:labelsize(10)
input_group:align(5)
--unknown attribute: hide
do input_textdisplay= fltk:Fl_Text_Display(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Input")
input_textdisplay:label(gLabelTable[#gLabelTable])
input_textdisplay:resize(10,260,340,100)
input_textdisplay:box(fltk.FL_BORDER_FRAME)
input_textdisplay:color(54)
input_textdisplay:labelsize(11)
input_textdisplay:textsize(9)
end

do input_prefix_group= fltk:Fl_Group(0,0,0,0,"")
input_prefix_group:resize(10,95,111,145)
do input_prefix1= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
input_prefix1:label(gLabelTable[#gLabelTable])
input_prefix1:resize(11,95,110,20)
input_prefix1:labelsize(11)
input_prefix1:align(16)
input_prefix1:textsize(11)
end

do input_prefix2= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
input_prefix2:label(gLabelTable[#gLabelTable])
input_prefix2:resize(11,120,110,20)
input_prefix2:labelsize(11)
input_prefix2:align(16)
input_prefix2:textsize(11)
end

do input_prefix3= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
input_prefix3:label(gLabelTable[#gLabelTable])
input_prefix3:resize(11,145,110,20)
input_prefix3:labelsize(11)
input_prefix3:align(16)
input_prefix3:textsize(11)
end

do input_prefix4= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
input_prefix4:label(gLabelTable[#gLabelTable])
input_prefix4:resize(11,170,110,20)
input_prefix4:labelsize(11)
input_prefix4:align(16)
input_prefix4:textsize(11)
end

do input_prefix5= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
input_prefix5:label(gLabelTable[#gLabelTable])
input_prefix5:resize(10,195,110,20)
input_prefix5:labelsize(11)
input_prefix5:align(16)
input_prefix5:textsize(11)
end

do input_prefix6= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
input_prefix6:label(gLabelTable[#gLabelTable])
input_prefix6:resize(11,220,110,20)
input_prefix6:labelsize(11)
input_prefix6:align(16)
input_prefix6:textsize(11)
end
Fl_Group:current(Fl_Group:current():parent())
end

do input_suffix_group= fltk:Fl_Group(0,0,0,0,"")
input_suffix_group:resize(240,95,110,145)
do input_suffix1= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
input_suffix1:label(gLabelTable[#gLabelTable])
input_suffix1:resize(240,95,110,20)
input_suffix1:labelsize(11)
input_suffix1:align(16)
input_suffix1:textsize(11)
end

do input_suffix2= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
input_suffix2:label(gLabelTable[#gLabelTable])
input_suffix2:resize(240,120,110,20)
input_suffix2:labelsize(11)
input_suffix2:align(16)
input_suffix2:textsize(11)
end

do input_suffix3= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
input_suffix3:label(gLabelTable[#gLabelTable])
input_suffix3:resize(240,145,110,20)
input_suffix3:labelsize(11)
input_suffix3:align(16)
input_suffix3:textsize(11)
end

do input_suffix4= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
input_suffix4:label(gLabelTable[#gLabelTable])
input_suffix4:resize(240,170,110,20)
input_suffix4:labelsize(11)
input_suffix4:align(16)
input_suffix4:textsize(11)
end

do input_suffix5= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
input_suffix5:label(gLabelTable[#gLabelTable])
input_suffix5:resize(240,195,110,20)
input_suffix5:labelsize(11)
input_suffix5:align(16)
input_suffix5:textsize(11)
end

do input_suffix6= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
input_suffix6:label(gLabelTable[#gLabelTable])
input_suffix6:resize(240,220,110,20)
input_suffix6:labelsize(11)
input_suffix6:align(16)
input_suffix6:textsize(11)
end
Fl_Group:current(Fl_Group:current():parent())
end

do input_menus_group= fltk:Fl_Group(0,0,0,0,"")
input_menus_group:resize(125,95,111,145)
do input_menu1= fltk:Fl_Menu_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "ID")
input_menu1:label(gLabelTable[#gLabelTable])
input_menu1:resize(126,95,110,20)
input_menu1:labelsize(10)
input_menu1:textsize(10)
end

do input_menu2= fltk:Fl_Menu_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Layer")
input_menu2:label(gLabelTable[#gLabelTable])
input_menu2:resize(125,120,110,20)
input_menu2:labelsize(10)
input_menu2:textsize(10)
end

do input_menu3= fltk:Fl_Menu_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Position")
input_menu3:label(gLabelTable[#gLabelTable])
input_menu3:resize(126,145,110,20)
input_menu3:labelsize(10)
input_menu3:textsize(10)
end

do input_menu4= fltk:Fl_Menu_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "-")
input_menu4:label(gLabelTable[#gLabelTable])
input_menu4:resize(125,170,110,20)
input_menu4:labelsize(10)
input_menu4:textsize(10)
end

do input_menu5= fltk:Fl_Menu_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "-")
input_menu5:label(gLabelTable[#gLabelTable])
input_menu5:resize(126,195,110,20)
input_menu5:labelsize(10)
input_menu5:textsize(10)
end

do input_menu6= fltk:Fl_Menu_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "-")
input_menu6:label(gLabelTable[#gLabelTable])
input_menu6:resize(125,220,110,20)
input_menu6:labelsize(10)
input_menu6:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end
Fl_Group:current(Fl_Group:current():parent())
end

do output_group= fltk:Fl_Group(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Output")
output_group:label(gLabelTable[#gLabelTable])
output_group:resize(15,95,345,280)
output_group:labelsize(10)
output_group:align(5)
--unknown attribute: hide
do prefix_group= fltk:Fl_Group(0,0,0,0,"")
prefix_group:resize(15,95,106,145)
do data_prefix1= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
data_prefix1:label(gLabelTable[#gLabelTable])
data_prefix1:resize(15,95,106,20)
data_prefix1:labelsize(11)
data_prefix1:align(16)
data_prefix1:textsize(11)
end

do data_prefix2= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
data_prefix2:label(gLabelTable[#gLabelTable])
data_prefix2:resize(15,120,106,20)
data_prefix2:labelsize(11)
data_prefix2:align(16)
data_prefix2:textsize(11)
end

do data_prefix3= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
data_prefix3:label(gLabelTable[#gLabelTable])
data_prefix3:resize(15,145,106,20)
data_prefix3:labelsize(11)
data_prefix3:align(16)
data_prefix3:textsize(11)
end

do data_prefix4= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
data_prefix4:label(gLabelTable[#gLabelTable])
data_prefix4:resize(15,170,106,20)
data_prefix4:labelsize(11)
data_prefix4:align(16)
data_prefix4:textsize(11)
end

do data_prefix5= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
data_prefix5:label(gLabelTable[#gLabelTable])
data_prefix5:resize(15,195,105,20)
data_prefix5:labelsize(11)
data_prefix5:align(16)
data_prefix5:textsize(11)
end

do data_prefix6= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
data_prefix6:label(gLabelTable[#gLabelTable])
data_prefix6:resize(15,220,106,20)
data_prefix6:labelsize(11)
data_prefix6:align(16)
data_prefix6:textsize(11)
end
Fl_Group:current(Fl_Group:current():parent())
end

do suffix_group= fltk:Fl_Group(0,0,0,0,"")
suffix_group:resize(240,95,110,145)
do data_suffix1= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
data_suffix1:label(gLabelTable[#gLabelTable])
data_suffix1:resize(240,95,110,20)
data_suffix1:labelsize(11)
data_suffix1:align(16)
data_suffix1:textsize(11)
end

do data_suffix2= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
data_suffix2:label(gLabelTable[#gLabelTable])
data_suffix2:resize(240,120,110,20)
data_suffix2:labelsize(11)
data_suffix2:align(16)
data_suffix2:textsize(11)
end

do data_suffix3= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
data_suffix3:label(gLabelTable[#gLabelTable])
data_suffix3:resize(240,145,110,20)
data_suffix3:labelsize(11)
data_suffix3:align(16)
data_suffix3:textsize(11)
end

do data_suffix4= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
data_suffix4:label(gLabelTable[#gLabelTable])
data_suffix4:resize(240,170,110,20)
data_suffix4:labelsize(11)
data_suffix4:align(16)
data_suffix4:textsize(11)
end

do data_suffix5= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
data_suffix5:label(gLabelTable[#gLabelTable])
data_suffix5:resize(240,195,110,20)
data_suffix5:labelsize(11)
data_suffix5:align(16)
data_suffix5:textsize(11)
end

do data_suffix6= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "prefix")
data_suffix6:label(gLabelTable[#gLabelTable])
data_suffix6:resize(240,220,110,20)
data_suffix6:labelsize(11)
data_suffix6:align(16)
data_suffix6:textsize(11)
end
Fl_Group:current(Fl_Group:current():parent())
end

do menus_group= fltk:Fl_Group(0,0,0,0,"")
menus_group:resize(125,95,111,145)
do data_menu1= fltk:Fl_Menu_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "ID")
data_menu1:label(gLabelTable[#gLabelTable])
data_menu1:resize(126,95,110,20)
data_menu1:labelsize(10)
data_menu1:textsize(10)
end

do data_menu2= fltk:Fl_Menu_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Layer")
data_menu2:label(gLabelTable[#gLabelTable])
data_menu2:resize(125,120,110,20)
data_menu2:labelsize(10)
data_menu2:textsize(10)
end

do input_menu3= fltk:Fl_Menu_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Position")
input_menu3:label(gLabelTable[#gLabelTable])
input_menu3:resize(126,145,110,20)
input_menu3:labelsize(10)
input_menu3:textsize(10)
end

do data_menu4= fltk:Fl_Menu_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "-")
data_menu4:label(gLabelTable[#gLabelTable])
data_menu4:resize(125,170,110,20)
data_menu4:labelsize(10)
data_menu4:textsize(10)
end

do data_menu5= fltk:Fl_Menu_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "-")
data_menu5:label(gLabelTable[#gLabelTable])
data_menu5:resize(126,195,110,20)
data_menu5:labelsize(10)
data_menu5:textsize(10)
end

do data_menu6= fltk:Fl_Menu_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "-")
data_menu6:label(gLabelTable[#gLabelTable])
data_menu6:resize(125,220,110,20)
data_menu6:labelsize(10)
data_menu6:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do output_textdisplay= fltk:Fl_Text_Display(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Output")
output_textdisplay:label(gLabelTable[#gLabelTable])
output_textdisplay:resize(15,260,335,100)
output_textdisplay:color(23)
output_textdisplay:labelsize(11)
output_textdisplay:textsize(9)
end
Fl_Group:current(Fl_Group:current():parent())
end

do properties_group= fltk:Fl_Group(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Properties")
properties_group:label(gLabelTable[#gLabelTable])
properties_group:resize(10,101,355,279)
properties_group:labelsize(10)
properties_group:align(5)
do widget= fltk:Fl_Scroll(0,0,0,0,"")
widget:resize(10,101,350,279)
do widget= fltk:Fl_Text_Editor(0,0,0,0,"")
widget:resize(10,101,350,279)
end
end
Fl_Group:current(Fl_Group:current():parent())
end
end
end
Data_Format_Window:show()

Data_Format_Window:show()
--end
Fl:run()
