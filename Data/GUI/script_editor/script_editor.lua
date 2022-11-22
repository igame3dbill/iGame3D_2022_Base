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
do scriptEditor= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Script Editor")
scriptEditor:label(gLabelTable[#gLabelTable])
scriptEditor:resize(414,126,479,482)
Fl_Group:current():resizable(scriptEditor)
scriptEditor:size_range(470,474,2048,2048)
--scriptEditor:show()
do editor= fltk:Fl_Text_Editor(0,0,0,0,"")
editor:callback(editorChangedContents)
editor:resize(5,41,455,392)
editor:when(1)
editor:textfont(4)
editor:textsize(12)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Run")
widget:label(gLabelTable[#gLabelTable])
widget:callback(runScriptC)
widget:resize(380,445,85,25)
end

do opener= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Open...")
opener:label(gLabelTable[#gLabelTable])
opener:callback(openScriptC)
opener:resize(75,445,75,25)
end

do path= fltk:Fl_Output(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Current File:")
path:label(gLabelTable[#gLabelTable])
path:resize(75,15,390,20)
path:labelsize(11)
path:textsize(12)
end

do saver= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Save")
saver:label(gLabelTable[#gLabelTable])
saver:callback(saveScriptC)
saver:resize(225,445,55,25)
--unknown attribute: deactivate
end

do newer= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "New")
newer:label(gLabelTable[#gLabelTable])
newer:callback(newScriptC)
newer:resize(10,445,60,25)
end

do closer= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Close")
closer:label(gLabelTable[#gLabelTable])
closer:callback(closeScriptC)
closer:resize(155,445,65,25)
--unknown attribute: deactivate
end
end
scriptEditor:show()

scriptEditor:show();
editor_buf = fltk:Fl_Text_Buffer();
editor:buffer( editor_buf );
scriptEditor:make_current();
closer:deactivate();
saver:deactivate();
--end
Fl:run()
