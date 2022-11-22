--function make_window()
gNumTextboxes = ig3d_GetNumberOfTextboxes__i()

if gNumTextboxes == 0 or gNumTextboxes == nil then
gTextboxPositions={}
gTextboxSizes={}
gTextboxColors={}
gTextboxes={}
gNumBoxes = 0
end


gTextboxes = {}
for i=1,gNumTextboxes,1 do
table.insert(gTextboxes,i)
end


if gTextboxFonts == nil then
gTextboxFonts={}
	for i=1,gNumTextboxes,1 do
 	table.insert(gTextboxFonts,"Data/FontPngs/default32_1.png") 
 	end
end

gSelectedTextBoxValues={}
TextboxAttListBrowserItems = {"size","position","color","font","text","bounds"}
gSelectedTextBox = gTextboxes[#gTextboxes]
gSelectedTextBoxNum = 1
gSelectedTextboxAttribute = 1


changed=false
-- textboxtexteditorPrint 
function textboxtexteditorPrint(...)
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
	local l_offset=#textboxtexteditor_buf:text()
	textboxtexteditor:insert_position(l_offset)
	textboxtexteditor:insert(str.."\n")
	textboxtexteditor:show_insert_position()
	textboxtexteditor:textfont(4)
	textboxtexteditor:textsize(11)
end
-- textboxtexteditorChangedContents
function textboxtexteditorChangedContents(w)
changed=true
tText = textboxtexteditor_buf:text()

local size,x,y,r,g,b,a,font,text = ig3d_GetTextboxInfo_i_3i4f2s(gSelectedTextBoxNum)
labels[gSelectedTextBoxNum] = tText

ig3d_SetTextboxInfo_4i4f2s(gSelectedTextBoxNum,size,x,y,r,g,b,a,font,tText)

end
-- TextBoxBrowserGroupHide
function TextBoxBrowserGroupHide()
TextboxValueGroup:hide()
TextboxSaveAsGroup:hide()
TextboxSourceGroup:hide()
TextboxInputGroup:hide()
TextboxFontPngsGroup:hide()
TextboxValInputA:hide()
TextboxValInputB:hide()
TextboxTextInputGroup:hide()
	TextboxValInputC:hide()
	TextboxValInputD:hide()
	TextboxBoolBtn:hide()	
	TextboxNameInput:hide()
	TextboxTextInputGroup:hide()
	
	
end
-- CurTextboxInfo
function CurTextboxInfo(n)
if n == nil then return end
 gSelectedTextBoxValues={}
gSelectedTextBox = gTextboxes[n]
local size,x,y,r,g,b,a,font,text = ig3d_GetTextboxInfo_i_3i4f2s(n)
if size == nil then size = 9 end
if x == nil then x = 1 end
if y ==  nil then y = 1 end
if r ==  nil then r = 1 end
if g ==  nil then g = 1 end
if b ==  nil then b = 1 end
if a ==  nil then a = 1 end

  gSelectedTextBoxSize = size;  		 -- getText_boxInfo(gSelectedTextBox, IG3D_SIZE)
 gSelectedTextBoxX,gSelectedTextBoxY = x,y;       --  getText_boxInfo(gSelectedTextBox, IG3D_POSITION)
  gSelectedTextBoxFont = font;    		 -- getText_boxInfo(gSelectedTextBox, IG3D_FONT)
 						-- getText_boxInfo(gSelectedTextBox, IG3D_COLOR)
 gSelectedTextBoxText = text;   			-- getText_boxInfo(gSelectedTextBox, IG3D_TEXT)
 local tp,lt,bt,rt = getText_boxInfo(n, IG3D_BOUNDS)
 if tp == nil then tp = 0 end
if lt ==  nil then lt = 0 end
if bt ==  nil then bt = 0 end
if rt ==  nil then rt = 0 end


 gCurrentTextboxInfo={}
table.insert(gCurrentTextboxInfo, {ig3d_GetTextboxInfo_i_3i4f2s(n)})
 for i = 1,#gCurrentTextboxInfo[1],1 do
 --print(gCurrentTextboxInfo[1][i])
 end

  	table.insert(gSelectedTextBoxValues,gSelectedTextBoxSize)
 	table.insert(gSelectedTextBoxValues,tostring(x..","..y))
      table.insert(gSelectedTextBoxValues,r..","..g..","..b..","..a)
      table.insert(gSelectedTextBoxValues,gSelectedTextBoxFont)
  	table.insert(gSelectedTextBoxValues,tostring(gSelectedTextBoxText))
        table.insert(gSelectedTextBoxValues,tostring(tp..","..lt..","..bt..","..rt))
        print(size,x,y,r,g,b,a,font,text)
        return size,x,y,r,g,b,a,font,text
         
end
-- listTextBoxes
function listTextBoxes()
TextboxBrowser:make_current()
TextboxListBrowser:clear()
gNumTextboxes = ig3d_GetNumberOfTextboxes__i()
gTextboxes = {}
for i=1,gNumTextboxes,1 do
table.insert(gTextboxes,i)
TextboxListBrowser:add(i)
TextboxListBrowser:redraw()
end

  TextboxAttListBrowser:clear()
   for i = 1,#TextboxAttListBrowserItems,1 do TextboxAttListBrowser:add(TextboxAttListBrowserItems[i]) end
   
fltk_update()
end
-- TextboxBrowserWindowUpdate
function TextboxBrowserWindowUpdate()

 TextboxValuesListBrowser:clear()
CurTextboxInfo(gSelectedTextBoxNum)
for i = 1,#gSelectedTextBoxValues,1 do TextboxValuesListBrowser:add(gSelectedTextBoxValues[i]) end

end
-- applyTextboxColor

function applyTextboxColor(red, green, blue)
local size,x,y,r,g,b,a,font,text = CurTextboxInfo(gSelectedTextBoxNum)	
	text = tostring(text)
	font = tostring(font)	
	ig3d_SetTextboxInfo_4i4f2s(gSelectedTextBoxNum,size,x,y,red,green,blue,a,font,text)
	
	TextboxBrowser:make_current()	
	TextboxValInputA:value(red)
	TextboxValInputB:value(green)
	TextboxValInputC:value(blue)
	TextboxBrowser:redraw()		
	 TextboxValuesListBrowser:clear()
	CurTextboxInfo(gSelectedTextBoxNum)
for i = 1,#gSelectedTextBoxValues,1 do TextboxValuesListBrowser:add(gSelectedTextBoxValues[i]) end


	 TextboxValuesListBrowser:selected(3,3)
	 TextboxValuesListBrowser:value(3)
	  TextboxValuesListBrowser:select(3)
	 
end
-- showColorChooser
function showColorChooser()
	size,x,y,r,g,b,a,font,text = CurTextboxInfo(gSelectedTextBoxNum)
	choosr,choosg,choosb= (r * 255) , (g * 255), (b *255)
	color_ok, choosr, choosg , choosb = fltk.fl_color_chooser(gColorEditMode,choosr,choosg,choosb)	
	if color_ok == 1 then -- color_ok represents the first value (exit status) returned by fl_color_chooser
	Fl:set_color(15,choosr,choosg,choosb) -- change color 15
 	TextRed, TextGreen, TextBlue = (choosr) / 255.0, (choosg) / 255.0, (choosb) / 255.0
 
	applyTextboxColor(TextRed, TextGreen, TextBlue )	
	end
end
-- PickedTextboxAttribute


function PickedTextboxAttribute(n)
gSelectedTextboxAttribute = n
TextBoxBrowserGroupHide()
local size,x,y,r,g,b,a,font,text = CurTextboxInfo(gSelectedTextBoxNum)
if n == 1 then 
TextboxValueGroup:show()
TextboxInputGroup:show()
TextboxValInputA:value(size)
TextboxValInputA:show()	
TextboxValInputA:label("size")
end

if n == 2 then 
TextboxValueGroup:show()
TextboxInputGroup:show()
TextboxValInputA:value(x)
TextboxValInputA:show()	
TextboxValInputB:show()	
TextboxValInputB:value(y)
TextboxValInputA:label("x")
TextboxValInputB:label("y")
end

if n == 4 then 
TextboxFontPngsGroup:show()
TextboxListFontPngs()
end

if n == 3 then 
TextboxValueGroup:show()
TextboxInputGroup:show()
	TextboxValInputA:value(r)
	TextboxValInputB:value(g)
	TextboxValInputC:value(b)
	TextboxValInputD:value(a)
	TextboxValInputA:show(r)
	TextboxValInputB:show(g)
	TextboxValInputC:show(b)
	TextboxValInputD:show(a)
	
	gColorAttribute = "Text Color"
	 showColorChooser()
end

if n == 5 then 
TextboxValueGroup:hide()
TextboxTextInputGroup:show()
textboxtexteditorPrint(text)
end

fltk_update()
end
-- TextboxListBrowserCallback
 function TextboxListBrowserCallback(w)
 if w:value()==0 then return end;
 TextBoxBrowserGroupHide()

 gSelectedTextBox = gTextboxes[tonumber(w:value())]

 gSelectedTextBoxNum = w:value()
 
 CurTextboxInfo(gSelectedTextBoxNum)
 TextboxBrowserWindowUpdate()


fltk_update()

end
-- TextboxAttPicked
function TextboxAttPicked(w)
if TextboxBrowser == nil then return end;
if w:value() == nil then return end
TextboxValueGroup:show()
n =w:value()
TextboxValuesListBrowser:value(n)
TextboxValuesListBrowser:select(n)
TextboxValuesListBrowser:selected(n,n)

TextboxAttListBrowser:value(n)
TextboxAttListBrowser:select(n)
TextboxAttListBrowser:selected(n,n)
--ModelsBrowserValueCatch()
PickedTextboxAttribute(n)
fltk_update()
end
-- TextboxFontPngs BROWSER CODE AHEAD 1129

FontPngsFileList={}
gFontPngsFilesShortNames={}
guFontPngsBrowserPath = gameroot.."Data/FontPngs/"
gFontPngsSourcePath =""


if not gFontFiles then
	gFontFiles={{}}
	end
	
-- TextboxFontPngsFontPngsSourceList
function TextboxListFontPngs()
TextboxBrowser:make_current()
FontPngsFileList={}
gFontPngsFilesShortNames={}
TextboxFontPngsFileBrowser:clear()
   for file in lfs.dir(guFontPngsBrowserPath) do
        if string.sub(file, 1,1)~="." or file==".." then
            local f = guFontPngsBrowserPath..'/'..file
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
            
             if attr.mode == "file" and string.sub(file, -5,-1)=="1.png" then 
             	local a={file, "file"}
             	table.insert(FontPngsFileList, a)
             	TextboxFontPngsFileBrowser:add(file)
             end   
             
           if attr.mode == "directory" then 
           local a={file, "directory"}
             table.insert(FontPngsFileList, a)
             TextboxFontPngsFileBrowser:add(file.."     ->")
	   end  
        end
     end
     

			 
end

-- TextboxFontPngsbrowserControlDoubleClicked
function uFontPngsbrowserControlDoubleClicked(w)
	--
	local theFile=FontPngsFileList[tonumber(w:value())]
	if theFile[2]=="directory" then
		if theFile[1]==".." then 
			guFontPngsBrowserPath=goDirsUp(guFontPngsBrowserPath, 1)
		else
			guFontPngsBrowserPath=guFontPngsBrowserPath..theFile[1].."/"
		end
		TextboxListFontPngs()
	end
		--print(gFontPngsSourcePath)

end

-- TextboxFontPngsbrowserControlClicked
function TextboxFontPngsbrowserControlClicked(w)
	if w:value()==0 then return end
	local theFile = FontPngsFileList[tonumber(w:value())]
	print(w:value()) 
	
	if theFile[2]=="file" then
	gFontPngsSourcePath = "Data/FontPngs/"..theFile[1]
	size,x,y,r,g,b,a,font,text = CurTextboxInfo(gSelectedTextBoxNum)
	
	text = tostring(text)
	print(gFontPngsSourcePath)
	local s=string.len(gameroot.."Data/FontPngs/n")
	FontPngsShortPath = string.sub(gFontPngsSourcePath,1,-6)
	       

	gSelectedFontPath = tostring(FontPngsShortPath.."1.png")
	loadTexture(FontPngsShortPath.."1.png")
	loadTexture(FontPngsShortPath.."2.png")
	loadFont(FontPngsShortPath.."1.png", FontPngsShortPath.."2.png")
	
	print(gSelectedTextBoxNum,size,x,y,r,g,b,a,gSelectedFontPath,text)		
	--getText_boxInfo (gSelectedTextBoxNum, IG3D_FONT, gSelectedFontPath)		
	ig3d_SetTextboxInfo_4i4f2s(gSelectedTextBoxNum,size,x,y,r,g,b,a,gSelectedFontPath,text)
	
	
	else
	gFontPngsSourcePath = nil
	end
	
	if gFontPngsSourcePath ~= nil then
	TextboxFontPngsLoadBtn:show()
	else
	TextboxFontPngsLoadBtn:hide()
	end
	
	local t=time()
	
	if t-gLastBrowserControlClick < 0.4 and w:value()==gLastSelection then
		TextboxFontPngsbrowserControlDoubleClicked(w)
		gLastBrowserControlClick=0
	else
		gLastBrowserControlClick=time()
	end
	gLastSelection=w:value()
	--print(gFontPngsSourcePath)
end
-- TextboxLoadFontPngsBtnClicked
function TextboxLoadFontPngsBtnClicked()
	size,x,y,r,g,b,a,font,text = CurTextboxInfo(gSelectedTextBoxNum)
	
	text = tostring(text)
	print(gFontPngsSourcePath)
	local s=string.len(gameroot.."Data/FontPngs/n")
	FontPngsShortPath = string.sub(gFontPngsSourcePath,1,-6)
	       

	gSelectedFontPath = tostring(FontPngsShortPath.."1.png")
	loadTexture(FontPngsShortPath.."1.png")
	loadTexture(FontPngsShortPath.."2.png")
	loadFont(FontPngsShortPath.."1.png", FontPngsShortPath.."2.png")
	
			
	--getText_boxInfo (gSelectedTextBoxNum, IG3D_FONT, gSelectedFontPath)		
	ig3d_SetTextboxInfo_4i4f2s(gSelectedTextBoxNum,size,x,y,r,g,b,a,gSelectedFontPath,text)
	
	   print(size,x,y,gSelectedFontPath,text,r,g,b,a)		
end
-- Textbox MENU FUNCTIONS
TextboxMenuIndex={}
TextboxMenuText={}
TextboxMenuText.Source={"Make", "Save","Duplicate"}
TextboxMenuText.Control={"Run","Stop","Clear"}
if gFontSize == nil then gFontSize = 14 end
function fillTextboxSourceMenu()
if TextboxBrowser == nil then return end;
	for  i=1,#TextboxMenuText.Source,1 do
	menuLine="Textbox/"..TextboxMenuText.Source[i]
	TextboxMenu:add(menuLine);
	table.insert(TextboxMenuIndex,menuLine)
	end
TextboxMenu:add("");
table.insert(TextboxMenuIndex,"")
TextboxMenu:redraw()
end 

function fillTextboxControlMenu()
if TextboxBrowser == nil then return end;
for  i=1,#TextboxMenuText.Control,1 do
	menuLine="Current/"..TextboxMenuText.Control[i]
	TextboxMenu:add(menuLine);
	table.insert(TextboxMenuIndex,menuLine)
	end
TextboxMenu:add("");
table.insert(TextboxMenuIndex,"")
TextboxMenu:add("");
table.insert(TextboxMenuIndex,"")
--All
for  i=1,#TextboxMenuText.Control,1 do
	menuLine="All/"..TextboxMenuText.Control[i]
	TextboxMenu:add(menuLine);
	table.insert(TextboxMenuIndex,menuLine)
	end



TextboxMenu:redraw()
fltk_update()
end


function TextboxCurrentPick(tPick)

		if tPick == "Clear" then
	
		render()
		end
		
		if tPick == "Run" then		
		
		render()
		end
		
		if tPick == "Stop" then		
	 
		render()
		end
end


function TextboxBrowsersMenuPick(tPick)
if TextboxBrowser == nil then return end;
CurTextboxInfo()	



if tPick == "Make" then
 gNumBoxes = #gTextboxes+1

 if gSelectedTextBoxFont ~= nil then table.insert(gTextboxFonts,gSelectedTextBoxFont) end
 gTextboxes[gNumBoxes]=make(ig3d_text_box, gTextboxFonts[#gTextboxFonts])
 --table.insert(gTextboxPositions,{1,1})
 --table.insert(gTextboxSizes,gFontSize)
 --table.insert(gTextboxColors,{1.0,1.0,1.0})
 
	setText_boxInfo(gTextboxes[gNumBoxes], IG3D_TEXT, "New Text")
	gSelectedTextBox = gTextboxes[gNumBoxes]
	gSelectedTextBoxNum = gNumBoxes
	listTextBoxes()
	TextboxBrowserWindowUpdate()
end		
if tPick == "Duplicate" then MakeTextbox() end;

end




function Textbox_menu_callback(w)
if TextboxBrowser == nil then return end;
tMenu = w:label()
tVal = w:value()
tPick = w:text()
tIndex = TextboxMenuIndex[tVal]
tIndex1 = TextboxMenuIndex[tVal-1]
tIndex2 = TextboxMenuIndex[tVal+1]

	if tIndex ~=nil  then 
	TextboxmenuHead=item(1,tIndex,"/")

 		if TextboxmenuHead == "Textbox" then TextboxBrowsersMenuPick(tPick) end;
 		if TextboxmenuHead == "Current" then TextboxCurrentPick(tPick) end;
 		if TextboxmenuHead == "All" 	then  TextboxAllMenuPick(tPick) end;
 		
 	 end 
 	 if tIndex1 == "All/Clear" then TextboxAllMenuPick("Clear") end
 	 if tIndex1 == "Current/Clear" then TextboxCurrentPick("Clear") end
  Fl:check();
   io.flush();
end

function Textbox_MenuBarFill()
if TextboxBrowser == nil then return end;
fillTextboxSourceMenu()
fillTextboxControlMenu()
end
-- TextboxValInput
function TextboxValInput()

local size,x,y,r,g,b,a,font,text = CurTextboxInfo(gSelectedTextBoxNum)
if n == 1 then 
size = TextboxValInputA:value()
end

if n == 2 then 
x = TextboxValInputA:value()
y =  TextboxValInputB:value()
end

if n == 5 then 
	r = TextboxValInputA:value()
	b = TextboxValInputB:value()
	g = TextboxValInputC:value()
	a = TextboxValInputD:value()
end
ig3d_SetTextboxInfo_4i4f2s(gSelectedTextBoxNum,size,x,y,r,g,b,a,font,text)
TextboxBrowserWindowUpdate()
fltk_update()
end
do TextboxBrowser= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Text Boxes")
TextboxBrowser:label(gLabelTable[#gLabelTable])
TextboxBrowser:callback(wClose)
TextboxBrowser:resize(137,185,266,260)
TextboxBrowser:color(40)
TextboxBrowser:labelsize(10)
--TextboxBrowser:show()
do TextboxTextInputGroup= fltk:Fl_Group(0,0,0,0,"")
TextboxTextInputGroup:resize(30,37,235,288)
do textboxtexteditor= fltk:Fl_Text_Editor(0,0,0,0,"")
textboxtexteditor:callback(textboxtexteditorChangedContents)
textboxtexteditor:resize(90,37,170,158)
textboxtexteditor:when(1)
textboxtexteditor:textfont(4)
textboxtexteditor:textsize(12)
end
Fl_Group:current(Fl_Group:current():parent())
end

do TextboxMenu= fltk:Fl_Menu_Bar(0,0,0,0,"")
menudir0=""
TextboxMenu:callback(Textbox_menu_callback)
TextboxMenu:resize(-2,0,371,22)
TextboxMenu:color(38)
TextboxMenu:labelsize(10)
TextboxMenu:textsize(10)
Fl_Group:current(Fl_Group:current():parent())
end

do TextboxSaveAsGroup= fltk:Fl_Group(0,0,0,0,"")
TextboxSaveAsGroup:resize(5,210,315,120)
do SourceNameInput= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Textbox Source File ")
SourceNameInput:label(gLabelTable[#gLabelTable])
SourceNameInput:callback(TextSaveButtonClick)
SourceNameInput:resize(5,210,210,25)
SourceNameInput:color(50)
SourceNameInput:labelsize(10)
SourceNameInput:align(1)
SourceNameInput:when(8)
SourceNameInput:textsize(10)
end

do PSaveControl= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Save")
PSaveControl:label(gLabelTable[#gLabelTable])
PSaveControl:callback(TextSaveButtonClick)
PSaveControl:resize(175,210,70,25)
PSaveControl:labelsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do TextboxSourceGroup= fltk:Fl_Group(0,0,0,0,"")
TextboxSourceGroup:resize(105,40,210,285)
do textFileBrowser= fltk:Fl_Browser(0,0,0,0,"")
textFileBrowser:callback(textFileBrowserCallback)
textFileBrowser:resize(107,40,153,158)
textFileBrowser:type(2)
textFileBrowser:labelsize(10)
textFileBrowser:align(1)
textFileBrowser:when(1)
textFileBrowser:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do TextboxInputGroup= fltk:Fl_Group(0,0,0,0,"")
TextboxInputGroup:resize(5,38,262,216)
TextboxInputGroup:box(fltk.FL_EMBOSSED_BOX)
TextboxInputGroup:color(50)
do TextboxNameInput= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Name:")
TextboxNameInput:label(gLabelTable[#gLabelTable])
TextboxNameInput:callback(RenameTextbox)
TextboxNameInput:resize(43,212,205,22)
TextboxNameInput:color(50)
TextboxNameInput:labelsize(10)
TextboxNameInput:textsize(10)
end

do TextboxBoolBtn= fltk:Fl_Check_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "button")
TextboxBoolBtn:label(gLabelTable[#gLabelTable])
TextboxBoolBtn:callback(TextBoolBtnPick)
TextboxBoolBtn:resize(240,212,19,23)
TextboxBoolBtn:down_box(fltk.FL_DOWN_BOX)
TextboxBoolBtn:align(4)
TextboxBoolBtn:when(1)
end

do TextboxValInputA= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "x")
TextboxValInputA:label(gLabelTable[#gLabelTable])
TextboxValInputA:callback(TextboxValInput)
TextboxValInputA:resize(30,212,46,22)
TextboxValInputA:color(51)
TextboxValInputA:labelsize(12)
TextboxValInputA:align(2)
TextboxValInputA:minimum(-1000)
TextboxValInputA:maximum(1000)
TextboxValInputA:step(1)
TextboxValInputA:textsize(10)
end

do TextboxValInputB= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "y")
TextboxValInputB:label(gLabelTable[#gLabelTable])
TextboxValInputB:callback(TextboxValInput)
TextboxValInputB:resize(83,212,46,22)
TextboxValInputB:color(51)
TextboxValInputB:labelsize(12)
TextboxValInputB:align(2)
TextboxValInputB:minimum(-1000)
TextboxValInputB:maximum(1000)
TextboxValInputB:step(1)
TextboxValInputB:textsize(10)
end

do TextboxValInputC= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "z")
TextboxValInputC:label(gLabelTable[#gLabelTable])
TextboxValInputC:callback(TextboxValInput)
TextboxValInputC:resize(136,212,46,22)
TextboxValInputC:color(51)
TextboxValInputC:labelsize(12)
TextboxValInputC:align(2)
TextboxValInputC:minimum(-1000)
TextboxValInputC:maximum(1000)
TextboxValInputC:step(1)
TextboxValInputC:textsize(10)
end

do TextboxValInputD= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "a")
TextboxValInputD:label(gLabelTable[#gLabelTable])
TextboxValInputD:callback(TextboxValInput)
TextboxValInputD:resize(190,212,46,22)
TextboxValInputD:color(51)
TextboxValInputD:labelsize(12)
TextboxValInputD:align(2)
TextboxValInputD:minimum(-1000)
TextboxValInputD:maximum(1000)
TextboxValInputD:step(1)
TextboxValInputD:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do TextboxRootGroup= fltk:Fl_Group(0,0,0,0,"")
TextboxRootGroup:callback(runButton)
TextboxRootGroup:resize(0,39,152,158)
do TextboxListBrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Box")
TextboxListBrowser:label(gLabelTable[#gLabelTable])
TextboxListBrowser:callback(TextboxListBrowserCallback)
TextboxListBrowser:resize(0,39,40,158)
TextboxListBrowser:type(3)
TextboxListBrowser:color(48)
TextboxListBrowser:labelsize(10)
TextboxListBrowser:align(1)
TextboxListBrowser:when(4)
TextboxListBrowser:textsize(10)
end

do TextboxAttListBrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Attributes:")
TextboxAttListBrowser:label(gLabelTable[#gLabelTable])
TextboxAttListBrowser:callback(TextboxAttPicked)
TextboxAttListBrowser:resize(39,39,51,158)
TextboxAttListBrowser:type(2)
TextboxAttListBrowser:color(48)
TextboxAttListBrowser:labelsize(10)
TextboxAttListBrowser:align(1)
TextboxAttListBrowser:when(4)
TextboxAttListBrowser:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do TextboxValueGroup= fltk:Fl_Group(0,0,0,0,"")
TextboxValueGroup:resize(90,38,270,243)
do CurValBrowser= fltk:Fl_Browser(0,0,0,0,"")
CurValBrowser:resize(106,38,154,158)
CurValBrowser:type(3)
CurValBrowser:color(50)
CurValBrowser:labelsize(10)
CurValBrowser:when(4)
CurValBrowser:textsize(10)
end

do TextboxValuesListBrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Values:")
TextboxValuesListBrowser:label(gLabelTable[#gLabelTable])
TextboxValuesListBrowser:callback(TextboxAttPicked)
TextboxValuesListBrowser:resize(90,38,170,158)
TextboxValuesListBrowser:type(2)
TextboxValuesListBrowser:color(50)
TextboxValuesListBrowser:labelsize(10)
TextboxValuesListBrowser:align(1)
TextboxValuesListBrowser:when(4)
TextboxValuesListBrowser:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do TextboxFontPngsGroup= fltk:Fl_Group(0,0,0,0,"")
TextboxFontPngsGroup:resize(25,37,295,298)
do TextboxFontPngsFileBrowser= fltk:Fl_Browser(0,0,0,0,"")
TextboxFontPngsFileBrowser:callback(TextboxFontPngsbrowserControlClicked)
TextboxFontPngsFileBrowser:resize(90,39,175,158)
TextboxFontPngsFileBrowser:type(2)
TextboxFontPngsFileBrowser:labelsize(10)
TextboxFontPngsFileBrowser:align(1)
TextboxFontPngsFileBrowser:when(1)
TextboxFontPngsFileBrowser:textsize(10)
end

do TextboxFontPngsLoadBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Load Font")
TextboxFontPngsLoadBtn:label(gLabelTable[#gLabelTable])
TextboxFontPngsLoadBtn:callback(TextboxLoadFontPngsBtnClicked)
TextboxFontPngsLoadBtn:resize(45,215,195,20)
TextboxFontPngsLoadBtn:labelsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end
end
TextboxBrowser:show()

TextboxBrowser:show()
textboxtexteditor_buf = fltk:Fl_Text_Buffer();
textboxtexteditor:buffer( textboxtexteditor_buf );

TextBoxBrowserGroupHide()
Textbox_MenuBarFill()
CurTextboxInfo()
listTextBoxes()

colorchooser=fltk:Fl_Button(1,1,10,10,"fl_color_chooser")
colorchooser:align(fltk.FL_ALIGN_BOTTOM)
colorchooser:color(15)
colorchooser:callback(showColorChooser)
--end
Fl:run()
