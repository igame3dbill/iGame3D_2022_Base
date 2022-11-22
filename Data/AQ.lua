--function make_window()
-- globals in here
if murgaLua_ExePath == nil then murgaLua_ExePath = lfs.currentdir() end

if murgaLua.getHostOsName()=="windows" then
 SEP="\\" 
 tfindinpath="(.*)"..SEP..".*"
pathToMurgaLua = string.gsub(murgaLua_ExePath,tfindinpath,"%1")

 else
 SEP="/" 
 pathToMurgaLua = string.gsub(murgaLua_ExePath,"(.*)/.*","%1")
  end
print("pathToMurgaLua= ",pathToMurgaLua)

pDataIconsPath = "Data"..SEP.."Icons"..SEP.."Aquarius16x16"..SEP 
CharZeroPath =pDataIconsPath.."aquarius_chr_000.png"
pickedChar = 255


AppPathImage = pathToMurgaLua..SEP..CharZeroPath
--CurDirImage = lfs.currentdir() ..CharZeroPath

gameroot = pathToMurgaLua..SEP
if lfs.attributes(AppPathImage) ~= nil then  gameroot = pathToMurgaLua.. SEP end
--if lfs.attributes(CurDirImage) ~= nil  then gameroot = lfs.currentdir() ..SEP  end
iconPath = gameroot..pDataIconsPath
print(iconPath)

print("GAMEROOT = "..gameroot)
 

counter = 0

fltk.fl_register_images()
AquaDrawChar=Fl_Shared_Image.get(iconPath.."aquarius_chr_255.png")
function writeafterURL(myFileName,whatText)
myFile = io.open(myFileName, "a")
 myFile:write(string.char (13))
 myFile:write(whatText)
 --myFile:write(string.char (13))
 io.close(myFile)
end
-- wClose
function wClose(w)
w:hide()
w=nil
end
-- CHOOSE FILE OR FOLDER

function chooseFolder(title,start_path)
-- fl_dir_chooser (function)
-- fltk.fl_dir_chooser(title,start_path,relative)
-- "relative" is a toggle. Non-zero means the filename returned will be a relative path, and zero returns absolute path. 
-- Using nil as start path will default to the previously chosen path,
-- or current directory if this is the first time the function is called
local relative=0
 local dirname=fltk.fl_dir_chooser(title,start_path,relative)
 if dirname then tFolder= replaceText(gameroot,"",dirname) end
 return tFolder 
end


function chooseFile(title,filename_filter,start_path)
-- fl_file_chooser (function)
-- fltk.fl_file_chooser(title,filename_filter,start_path,relative)
-- "relative" is a toggle. Non-zero means the filename returned will be a relative path, and zero returns absolute path. 
local relative=0
local filename=fltk.fl_file_chooser(title,filename_filter,start_path,relative)
 if filename then tFile= replaceText(gameroot,"",filename) end
 return tFile 
end
-- fix Icons
function fixIcons()

local sw=AquaTools:w()
local sh=AquaTools:h()
local sx=AquaTools:x()
local sy=AquaTools:y()

local x=5
local y=31
if #toolButton.button ~= 0 then 
for i=1,#toolButton.button,1 do
local w=toolButton.button[i]

local wimage=w:image()
local isw=w:image():w()
local ish=w:image():h()
local n=w:label()

if isw >= 23 or ish  >= 23 then 
w:image(w:image():copy(22,22));
end
if x>=sw-23 then x=5 
y=y+24 
end

w:resize(x,y,24,24);
w:redraw();
srh=y+32
x=x+24
end

AquaMenuBar:resize(0,0,AquaTools:w(),30)
AquaMenuBar:redraw();

if srh>sh then AquaTools:resize(sx,sy,sw,srh) end
AquaTools:redraw();
end
end
-- AquaToolsCB  
function AquaToolsCB(w)
--AquaTools:make_current();

fixIcons()
end
--  AquariusIconClick  --
function AquariusIconClick(w)

buttonID = w:label();

AquaDrawChar = w:image()

--print(buttonID)

local X,Y,W,H = w:x(),w:y(),w:w(),w:h()

w:box(fltk.FL_NO_BOX)

pickedChar=string.sub(buttonID,string.len("aquarius_char_"),-1)
if pokemap ~= nil then 
pokemap:make_current()
end


end --MainToolsClick
-- AQUA_MAIN_WINDOW
iconFiles={}

toolButton={}
toolButton.button={}
toolButton.file={}
toolSize=8

function AQUA_MAIN_WINDOW()
local i=1
local c=5
local r=31
print(iconPath)

do AquaTools= fltk:Fl_Double_Window(100,100,480,360,"")
AquaTools:label("AquaTools")
AquaTools:callback(wClose)
AquaTools:when(2)


  fltk.fl_color(7) -- white 
do ToolPickHilite = fltk.fl_rectf(0,0,toolSize,toolSize) end
siconPath=string.sub(iconPath,1,-2)

do buttonGroup = fltk:Fl_Scroll(5,5,266,266,"")
buttonGroup:box(fltk.FL_THIN_UP_BOX)
for file in lfs.dir(iconPath) do
print(file)
local ext=string.sub(file,-3,-1) 
if string.sub(file, 1, 1) ~= "." and file ~= nil and ext=="png" then 
ef=string.sub(file,1,string.len(file)-4)
iconFiles[i]=ef
if c<=4 then c=5 end
if r<=4 then r=5 end
if c > (toolSize*(toolSize*4)) then 
c=5
r=r+toolSize
end --ifc

do w = fltk:Fl_Button(c,r,toolSize,toolSize,"")
toolButton.button[i]=w
toolButton.file[i]=iconPath..file 
local buttonID = string.gsub(file,".png","")
imageFile = Fl_Shared_Image.get(toolButton.file[i])

fltk.fl_register_images()
w:label(buttonID)
w:labelsize(1)
w:box(fltk.FL_NO_BOX)
w:callback(AquariusIconClick)
w:when(11)
w:tooltip(buttonID)
w:resize(c,r,toolSize,toolSize);
w:image(imageFile,toolSize,toolSize)
--w:image(imageFile);
w:redraw();
Fl_Group:current(Fl_Group:current():parent())
end --dobutton

buttonGroup:add(w)
c=c+toolSize
i=i+1
end --ifstring
end --forfile
Fl_Group:current(Fl_Group:current():parent())


end -- buttongroup


do AquaMenuBar= fltk:Fl_Menu_Bar(0,0,0,0,"")
AquaMenuBar:callback()
AquaMenuBar:resize(0,0,680,30)
AquaMenuBar:labelsize(10)
AquaMenuBar:textsize(11)
Fl_Group:current(Fl_Group:current():parent())
end --AquaMenuBar

end --dowindow


AquaTools:size_range(120,120,c+98,r+98)
buttonGroup:resize(5,31,c,math.floor(r/8)+1)
AquaTools:resize(100,100,c+8,math.floor(r/8)+32)
AquaTools:resizable(buttonGroup)
AquaTools:show();
Fl:scheme("plastic");
AquaTools:make_current();
fixIcons();




end --   AquaToolsWINDO
--RUN

AQUA_MAIN_WINDOW();
--Fl:run();
print(gameroot)
dofile(gameroot.."Data"..SEP.."pokemap.lua")

while pokemap~=nil do 
pokemap:make_current()
pokemap_callback()
end
--end
