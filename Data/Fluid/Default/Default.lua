--function make_window()
if gDefaultFluidWindow ~= nil then 
gDefaultFluidWindow:hide()
gDefaultFluidWindow= nil
end
currentBrowserList={}
-- Scripteditor code -----------------------


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
	if string.find(str,"\r") ~= 0 then 
	for c in string.gmatch(str,"\r") do
	str = string.gsub(str,"\r", "") 
	end
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
-- fillbrowser
function fillbrowser(t)
defaultBrowser:clear()
	local mfn=#gDefault_MenuFunctions
	local dfn=#gDefault_Functions
	local uifn=#gDefault_UIFunctions
	local initn=#gInit_Function_Paths
	defaultBrowser:clear()
	funcBrowser:clear()
	if t==nil then t="gDefault_MenuFunctions" end
	viewDefaults=false
	
	if t=="gDefault_MenuFunctions" then 
	lstart = 1
	lstop = mfn
	viewDefaults=true
	end
	
	if t=="gDefault_Functions" then
	lstart = mfn+1
	lstop = mfn+dfn
	viewDefaults=true
	end
	
	if t=="gDefault_UIFunctions" then
	lstart=mfn+dfn+1
	lstop = lstart+uifn-1
	viewDefaults=true
	end
	
	
	if t=="default_Globals" then
	openScript("Data/Scripts/Default/default_Globals.lua")
	end
	
	if viewDefaults == true then
	currentBrowserList={}
		for i =lstart,lstop,1 do 
		table.insert(currentBrowserList,gInit_Function_Paths[i][2])
		defaultBrowser:add(gInit_Function_Paths[i][2]) 
		end 
	end
	
	if viewDefaults == false then
	
	
	end
	
	if t=="game script" then openScript("Data/game script.lua") end
	if t=="core" then
	openScript("Data/Scripts/core.lua")
	end
	
defaultBrowser:label(t)
end
-- showFile
function showFile(w)
selectedText = w:text(w:value())
n=w:value()
t=defaultBrowser:label()

if n>#currentBrowserList or n <1 then 
n=#currentBrowserList
selectedText = currentBrowserList[n]
defaultBrowser:select(n,1)
end


	local mfn=#gDefault_MenuFunctions
	local dfn=#gDefault_Functions
	local uifn=#gDefault_UIFunctions
	local initn=#gInit_Function_Paths
	
	if t==nil then t="gDefault_MenuFunctions" end
	if t=="gDefault_MenuFunctions" then 
	lstart = 1
	lstop = mfn
	end
	if t=="gDefault_Functions" then
	lstart = mfn+1
	lstop = mfn+dfn
	end
	
	if t=="gDefault_UIFunctions" then
	lstart=mfn+dfn+1
	lstop = lstart+uifn
	end
	
	
	if t=="default_Globals" then
	pathToFile = gameroot.."Data/Scripts/Default/default_Globals.lua"
	else
	pathToFile = gInit_Function_Paths[n+lstart-1][1]
	end

if t=="core" then pathToFile = gameroot.."Data/Scripts/core.lua" end
if t=="game script" then pathToFile = gameroot.."Data/game script.lua" end
print(pathToFile)
	
	local f=io.open(pathToFile, "r")
	local tText=f:read("*a")
	
	editor_buf:text("")
	editorPrint(tText)
	f:close()
	closer:activate()

	path:value(pathToFile)
	gFunctionsInFile={}
	funcBrowser:clear()
	defaultBrowser:select(n,1)
	parseScriptsForFunctions(pathToFile)
	for i = 1,#gFunctionsInFile,1 do
	funcBrowser:add(gFunctionsInFile[i])
	end
	

	
end
--viewFiles
function viewFiles(w)
selectedText = w:text(w:value())
n=w:value()
funcBrowser:clear()

editor_buf:text("")
fillbrowser(selectedText)


if selectedText=="default_Globals" then
	pathToFile = gameroot.."Data/Scripts/Default/default_Globals.lua"
	end

if selectedText=="core" then pathToFile = gameroot.."Data/Scripts/core.lua" end
if selectedText=="game script" then pathToFile = gameroot.."Data/game script.lua" end
if pathToFile ~= nil then 
	path:value(pathToFile)
	gFunctionsInFile={}
	
	defaultBrowser:select(n,1)
	parseScriptsForFunctions(pathToFile)
	for i = 1,#gFunctionsInFile,1 do
	funcBrowser:add(gFunctionsInFile[i])
	end
	end
	
end
function browseFilesFunctions(t)

	if t=="default_Globals" then
	pathToFile = gameroot.."Data/Scripts/Default/default_Globals.lua"
	end

    	if t=="core" then 
    	pathToFile = gameroot.."Data/Scripts/core.lua" 
    	end
    	
	if t=="game script" then 
	pathToFile = gameroot.."Data/game script.lua" 
	end
print(pathToFile)
	gFunctionsInFile={}
	funcBrowser:clear()	
	parseScriptsForFunctions(pathToFile)
	for i = 1,#gFunctionsInFile,1 do
	funcBrowser:add(gFunctionsInFile[i])
	end
	
end
function printit(w)
selectedText = w:text(w:value())
n=w:value()
print(n, selectedText)

end
do gDefaultFluidWindow= fltk:Fl_Double_Window(0,0,0,0,"")
gDefaultFluidWindow:resize(239,50,797,726)
Fl_Group:current():resizable(gDefaultFluidWindow)
gDefaultFluidWindow:size_range(810,588,810,588)
--gDefaultFluidWindow:show()
do editor= fltk:Fl_Text_Editor(0,0,0,0,"")
editor:callback(editorChangedContents)
editor:resize(195,36,585,650)
editor:when(1)
editor:textfont(4)
editor:textsize(12)
Fl_Group:current():resizable(editor)
end

do path= fltk:Fl_Output(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Current File:")
path:label(gLabelTable[#gLabelTable])
path:resize(260,10,500,20)
path:labelsize(11)
path:textsize(12)
end

do defaultBrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Files")
defaultBrowser:label(gLabelTable[#gLabelTable])
defaultBrowser:callback(showFile)
defaultBrowser:resize(10,155,175,195)
defaultBrowser:type(1)
defaultBrowser:labelsize(11)
defaultBrowser:align(5)
defaultBrowser:textsize(11)
end

do funcBrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Functions:")
funcBrowser:label(gLabelTable[#gLabelTable])
funcBrowser:resize(10,364,175,317)
funcBrowser:type(1)
funcBrowser:labelsize(11)
funcBrowser:align(5)
funcBrowser:textsize(11)
end

do ScriptEditorButtonsGroup= fltk:Fl_Group(0,0,0,0,"")
ScriptEditorButtonsGroup:resize(10,550,750,170)
do saver= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Save")
saver:label(gLabelTable[#gLabelTable])
saver:callback(saveScriptC)
saver:resize(600,695,55,25)
--unknown attribute: deactivate
end

do newer= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "New")
newer:label(gLabelTable[#gLabelTable])
newer:callback(newScriptC)
newer:resize(385,695,60,25)
end

do closer= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Close")
closer:label(gLabelTable[#gLabelTable])
closer:callback(closeScriptC)
closer:resize(530,695,65,25)
--unknown attribute: deactivate
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Run")
widget:label(gLabelTable[#gLabelTable])
widget:callback(runScriptC)
widget:resize(675,695,85,25)
end

do opener= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Open...")
opener:label(gLabelTable[#gLabelTable])
opener:callback(openScriptC)
opener:resize(455,695,68,25)
end
Fl_Group:current(Fl_Group:current():parent())
end

do initLoadOrderBrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Load Order")
initLoadOrderBrowser:label(gLabelTable[#gLabelTable])
initLoadOrderBrowser:callback(viewFiles)
initLoadOrderBrowser:resize(10,25,175,115)
initLoadOrderBrowser:type(1)
initLoadOrderBrowser:labelsize(11)
initLoadOrderBrowser:align(5)
initLoadOrderBrowser:textsize(11)
end
end
gDefaultFluidWindow:show()

gDefaultFluidWindow:show()

for i = 1,#gInit_LoadOrder,1 do
initLoadOrderBrowser:add(gInit_LoadOrder[i])
end


editor_buf = fltk:Fl_Text_Buffer();
editor:buffer( editor_buf );
gDefaultFluidWindow:make_current();
fillbrowser()
closer:deactivate();
saver:deactivate();
gDefaultFluidWindow:redraw()
--end
Fl:run()
