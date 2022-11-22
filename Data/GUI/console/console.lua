--function make_window()
-- myprint
function myprint(...)
if console == nil then
print = oldprint

return
end

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
	local l_offset=#consoleOut_buf:text()
	consoleOut:insert_position(l_offset)
	consoleOut:insert(str.."\n")
	consoleOut:show_insert_position()
	consoleOut:textfont(4)
	consoleOut:textsize(10)
end
-- consoleRun
function consoleRun(w)
	--tell igame3d that the input field has the focus
	ig3d_TellFocus_b(true)
	if Fl:event_key() ~= fltk.FL_Enter and Fl:event_key() ~= fltk.FL_KP_Enter then return end
	
	local str=consoleIn:value()
	local code,error=loadstring(str)
	print(str)
	if code== nil then
		print(error)
	else
		code()
	end
	
	consoleIn:value("");
	consoleOut:show_insert_position()
end

--in iGame3D we use our own console!!! :
oldprint = print
print=myprint

---fluid code ahead---
do console= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Console")
console:label(gLabelTable[#gLabelTable])
console:resize(35,178,382,186)
Fl_Group:current():resizable(console)
console:size_range(375,181,513,495)
--console:show()
do consoleIn= fltk:Fl_Input(0,0,0,0,"")
consoleIn:callback(consoleRun)
consoleIn:resize(10,145,315,25)
consoleIn:color(51)
consoleIn:when(3)
consoleIn:textfont(4)
consoleIn:textsize(11)
end

do consoleRun_btn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Run")
consoleRun_btn:label(gLabelTable[#gLabelTable])
consoleRun_btn:callback(consoleRun)
consoleRun_btn:resize(330,145,40,25)
consoleRun_btn:labelsize(11)
end

do consoleOut= fltk:Fl_Text_Display(0,0,0,0,"")
consoleOut:resize(10,2,360,137)
consoleOut:color(52)
consoleOut:labelsize(10)
consoleOut:when(0)
consoleOut:textfont(4)
consoleOut:textsize(8)
Fl_Group:current():resizable(consoleOut)
consoleOut_buf = fltk:Fl_Text_Buffer();
consoleOut:buffer(consoleOut_buf);
end
end
console:show()

consoleIn:when(11)	--enter key + changed
--end
Fl:run()
