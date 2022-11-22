  --globals up here
counter = 0
quads={}
cubes={}
AqAddress={}
AqPoked={}
Aqbox={}
fltk.fl_register_images()
pickedChar=255

if murgaLua_ExePath == nil then murgaLua_ExePath = lfs.currentdir() end

if murgaLua.getHostOsName()=="windows" then
 SEP="\\" 
 tfindinpath="(.*)"..SEP..".*"
pathToMurgaLua = string.gsub(murgaLua_ExePath,tfindinpath,"%1")
 else
 SEP="/" 
 pathToMurgaLua = string.gsub(murgaLua_ExePath,"(.*)/.*","%1")
  end

pDataIconsPath = "Data"..SEP.."Aquarius16x16"..SEP
CharZeroPath =pDataIconsPath.."aquarius_chr_000.png"
pickedChar = 255

AppPathImage = pathToMurgaLua..CharZeroPath
CurDirImage = lfs.currentdir() ..CharZeroPath
gameroot = pathToMurgaLua..SEP
if lfs.attributes(AppPathImage) ~= nil then  gameroot = pathToMurgaLua.. SEP end
if lfs.attributes(CurDirImage) ~= nil  then gameroot = lfs.currentdir() ..SEP  end
print("GAMEROOT = "..gameroot)
iconPath = gameroot..pDataIconsPath
AquaDrawChar=Fl_Shared_Image.get(iconPath.."aquarius_chr_255.png")
pokeoutPath=gameroot.."Data"..SEP.."AQBASIC"..SEP
chrten = string.char (13)
  function writeafterURL(myFileName,whatText)
myFile = io.open(myFileName, "a")
 myFile:write(string.char (13))
 myFile:write(whatText)
 --myFile:write(string.char (13))
 io.close(myFile)
end
  function pokeoutpathUpdate(pokeoutfile)
if pokeoutfile == nil then pokeoutfile = pokeoutPathInput:value()..pokeoutFileName:value().."_"..".txt" end
if lfs.attributes(pokeoutfile) == nil then 
writeafterURL(pokeoutfile,"new"..chrten.."cls"..chrten)
end
end
  -- gridMouseXY
function gridMouseXY()
  flmousex=Fl:event_x()
  flmousey=Fl:event_y()
  MouseX=(math.floor((flmousex+(vcubewidth/2))/vgridwidth)*vgridwidth)-1
 MouseY =(math.floor((flmousey+(vcubelength/2))/vgridlength)*vgridlength)-1
 
return MouseX,MouseY	
end
  psetmouseXYstore={}
psetmousecount=1
function psetMouseXY()
 qx=Fl:event_x()
  qy=Fl:event_y()
--qx,qy=gridMouseXY() 
 cgridSize=8
  rgridSize=4.3125
local sl,st = drawingrect:x(),drawingrect:y()
local sr,sb= sl+drawingrect:w(),st+drawingrect:h()
    PsetMouseX=math.floor((qx-sl)/cgridSize)
  PsetMouseY=math.floor((qy-st)/rgridSize)
  if PsetMouseX > 79 then PsetMouseX=79 end
  if PsetMouseY > 69 then PsetMouseY=69 end
return PsetMouseX,PsetMouseY
end
  function RAMPOKE(qx,qy)
local l,t,r,b=qx-widthHalf,qy-lengthHalf,qx+widthHalf,qy+lengthHalf
 quadCount=table.getn(quads)+1
   quads[quadCount]=(qx..","..qy)
     AqPoked[currentPoke]= pickedChar
     
if Aqbox[currentPoke] ~= nil then 
	w= Aqbox[currentPoke]
	w:show()
else
	w= fltk.Fl_Button(l,t,r,b,"")
	pokemap:add(w)
	Aqbox[currentPoke]=w
end
 local psx , psy= psetMouseXY()
 psetmousecount=#psetmouseXYstore+1
 psetmouseXYstore[psetmousecount]=(psx..","..psy)

w:labelsize(1)
w:box(fltk.FL_FLAT_BOX)
imageFile=AquaDrawChar

w:resize(l,t,gridSize,gridSize);
w:image(imageFile,14,14)
w:redraw();

--print((currentPoke).." , "..pickedChar)
    
end ---drawQuad
  function savePSets()
  pokeoutfile = pokeoutPathInput:value()..pokeoutFileName:value().."psets.txt"
   if lfs.attributes(pokeoutfile) == nil then pokeoutpathUpdate(pokeoutfile) end
local n=10
for index,value in pairs(psetmouseXYstore)   do
print(index,value)
if index == "row" or index == "col" then break  end
   n=n+1
 BasicLine=(n)*10
  Basicout=(BasicLine.." Pset(" .. psetmouseXYstore[index]..")")
   writeafterURL(pokeoutfile,Basicout)   
end
  writeafterURL(pokeoutfile,"cls:run")
   writeafterURL(pokeoutfile,"")
end


function savePsetReads()
     pokeoutfile = pokeoutPathInput:value()..pokeoutFileName:value().."pset.txt"
   if lfs.attributes(pokeoutfile) == nil then pokeoutpathUpdate(pokeoutfile) end
local n=900
local i =5
bigDataLine=(n*10).."REM "
AQNPum=0
for index,value in pairs(psetmouseXYstore)   do

if index == "row" or index == "col" then break  end
i=i+1
AQNPum=AQNPum+1
if i > 5 then 
   n=n+1
 BasicLine=(n)*10
 bigDataLine = bigDataLine..chrten..BasicLine.."Data "..psetmouseXYstore[index]
  i=1
  else
  bigDataLine=bigDataLine..","..psetmouseXYstore[index]
  end  
end





psetsDim="10 dim m("..AQNPum.."),c("..AQNPum..")"
psetsFr="20 for r = o to "..(AQNPum-1)..":read m(r),c(r): next r"
Psetsheader="40 for a = 0 to ".. (AQNPum-1)..": pset(m(a),c(a)):next a"

writeafterURL(pokeoutfile,"5 cls")
writeafterURL(pokeoutfile,psetsDim)
writeafterURL(pokeoutfile,psetsFr)
writeafterURL(pokeoutfile,Psetsheader)
 writeafterURL(pokeoutfile,bigDataLine)
  writeafterURL(pokeoutfile,"cls:run")
   writeafterURL(pokeoutfile,"")
end


function savePokes()
     pokeoutfile = pokeoutPathInput:value()..pokeoutFileName:value()..".txt"
   if lfs.attributes(pokeoutfile) == nil then pokeoutpathUpdate(pokeoutfile) end
local n=10
for index,value in pairs(AqPoked)   do
print(index,value)
if index == "row" or index == "col" then break  end
   n=n+1
 BasicLine=(n)*10
  Basicout=(BasicLine.." POKE "..index..","..AqPoked[index])
   writeafterURL(pokeoutfile,Basicout)
    
end
  writeafterURL(pokeoutfile,"cls:run")
   writeafterURL(pokeoutfile,"")
   savePSets()
end


function saveReads()
     pokeoutfile = pokeoutPathInput:value()..pokeoutFileName:value()..".txt"
   if lfs.attributes(pokeoutfile) == nil then pokeoutpathUpdate(pokeoutfile) end
local n=900
local i =4
bigDataLine=(n*10).."REM "
AQNum=0
for index,value in pairs(AqPoked)   do
--print(index,value)
if index == "row" or index == "col" then break  end
i=i+1
AQNum=AQNum+1
if i > 4 then 
   n=n+1
 BasicLine=(n)*10
 bigDataLine = bigDataLine..chrten..BasicLine.."Data "..index..","..AqPoked[index]
  i=1
  else
  bigDataLine=bigDataLine..","..index..","..AqPoked[index]
  end  
end
RunImag="5 for r = 1 to "..AQNum..":read m,c:pokem,c:next r"
writeafterURL(pokeoutfile,RunImag)
 writeafterURL(pokeoutfile,bigDataLine)
  writeafterURL(pokeoutfile,"cls:run")
   writeafterURL(pokeoutfile,"")
   savePsetReads()
end







function clsButton()
for index,value in pairs(AqPoked)   do
print(index,value)
if index == "row" or index == "col" then break  end
   Aqbox[index]:hide()
end

savePSets()
end
  function QuadInDrawRect(qx,qy)
local l,t,r,b= qx-widthHalf,qy-lengthHalf,qx+widthHalf,qy+lengthHalf
local sl,st = drawingrect:x(),drawingrect:y()
local sr,sb= sl+drawingrect:w(),st+drawingrect:h()-widthHalf
doQuad=true 
if l < sl-1 or r > sr  then doQuad=false end
if t < st-2 or b > sb  then doQuad=false end
--if doQuad == false then print(l,t,r,b.."\n"..sl,st,sr,sb) end
 return doQuad
end
  --   input update_values


function input_value_updates()

vgridwidth=16 --gridwidth:value()
vgridlength=16--gridlength:value()
vcubewidth=16 --cubewidth:value()
vcubelength=16 -- cubelength:value()
vcubeheight=16  --cubeheight:value()


widthHalf=math.floor(vgridwidth/2)
lengthHalf=math.floor(vgridlength/2)

cubeWidthHalf=math.floor(vcubewidth/2)
cubeLengthHalf=math.floor(vcubelength/2)
cubeHeightHalf=math.floor(vcubeheight/2)

quadHalf=cubeWidthHalf
gridSize=vgridwidth
cubeSize=vcubewidth
quadSize=cubeSize

qx,qy=gridMouseXY() 
local sl,st = drawingrect:x(),drawingrect:y()
local sr,sb= sl+drawingrect:w(),st+drawingrect:h()
  xyout:label(qx..","..qy)
  AQX=math.floor((qx-sl)/gridSize)
  AQY=math.floor((qy-st)/gridSize)
  currentPoke=(12288+AQX+(AQY*40))
  pokeout:label("POKE "..currentPoke)
  ColRowOut:label(AQX..","..AQY)

 

PsetMouseX,PsetMouseY=psetMouseXY();
PsetOut:label(PsetMouseX..","..PsetMouseY)
end; --   input update_values
  --- mouseDown_quads
function mouseDown_quads()

quadqx,quadqy=gridMouseXY() 
if  Fl:event()==5 or Fl:event()==1 then
 doQuad=QuadInDrawRect(quadqx,quadqy)
		
if doQuad==true then  RAMPOKE(quadqx,quadqy)     end
end --fleventcheck
end   ---mouseDown_quads*
  -- pokemapclose
function pokemapClose()
os.exit()
end
  function pokemap_callback()
pokemap:make_current();
 input_value_updates()
mouseDown_quads();
  Fl:check();
end
  do pokemap = fltk:Fl_Double_Window(675, 523, "pokemap");
    pokemap:color(fltk.FL_BACKGROUND2_COLOR);
    pokemap:callback(pokemapClose);
    pokemap:when(fltk.FL_WHEN_CHANGED);
    do label = fltk:Fl_Button(10, 475, 70, 20, "Mouse");
      label:box(fltk.FL_NO_BOX);
      label:labelsize(11);
    end -- Fl_Button* label
    do label1 = fltk:Fl_Button(160, 475, 70, 20, "Col,Row");
      label1:box(fltk.FL_NO_BOX);
      label1:labelsize(11);
    end -- Fl_Button* label1
    do label2 = fltk:Fl_Button(230, 475, 70, 20, "POKE");
      label2:box(fltk.FL_NO_BOX);
      label2:labelsize(11);
    end -- Fl_Button* label2
    do label3 = fltk:Fl_Button(325, 475, 70, 20, "Char");
      label3:box(fltk.FL_NO_BOX);
      label3:labelsize(11);
    end -- Fl_Button* label3
    do label4 = fltk:Fl_Button(82, 475, 70, 20, "PSET");
      label4:box(fltk.FL_NO_BOX);
      label4:labelsize(11);
    end -- Fl_Button* label4
    do xyout = fltk:Fl_Button(10, 490, 70, 20, "0,0");
      xyout:box(fltk.FL_NO_BOX);
      xyout:labelsize(11);
    end -- Fl_Button* xyout
    do ColRowOut = fltk:Fl_Button(160, 495, 70, 20, "0");
      ColRowOut:box(fltk.FL_NO_BOX);
      ColRowOut:labelsize(11);
    end -- Fl_Button* ColRowOut
    do pokeout = fltk:Fl_Button(230, 495, 70, 20, "0");
      pokeout:box(fltk.FL_NO_BOX);
      pokeout:labelsize(11);
    end -- Fl_Button* pokeout
    do charout = fltk:Fl_Button(325, 495, 70, 20, "0");
      charout:box(fltk.FL_NO_BOX);
      charout:labelsize(11);
    end -- Fl_Button* charout
    do PsetOut = fltk:Fl_Button(83, 495, 70, 20, "0,0");
      PsetOut:box(fltk.FL_NO_BOX);
      PsetOut:labelsize(11);
    end -- Fl_Button* PsetOut
    do drawingrect = fltk:Fl_Box(10, 65, 640, 400, "+");
      drawingrect:box(fltk.FL_BORDER_BOX);
      drawingrect:labelsize(11);
      drawingrect:callback(mouseDown_quads);
      drawingrect:when(fltk.FL_WHEN_CHANGED);
    end -- Fl_Box* drawingrect
    do pokeoutFileName = fltk:Fl_Input(55, 10, 146, 20, "File Name:");
      pokeoutFileName:labelsize(9);
      pokeoutFileName:textsize(9);
    end -- Fl_Input* pokeoutFileName
    do pokeoutPathInput = fltk:Fl_Input(257, 11, 375, 19, "File Path:");
      pokeoutPathInput:labelsize(9);
      pokeoutPathInput:textsize(9);
    end -- Fl_Input* pokeoutPathInput
    do local object = fltk:Fl_Button(95, 40, 70, 20, "Save Pokes");
      object:labelsize(10);
      object:callback(savePokes);
    end -- Fl_Button* o
    do local object = fltk:Fl_Button(175, 40, 70, 20, "Save Read");
      object:labelsize(10);
      object:callback(saveReads);
    end -- Fl_Button* o
    do local object = fltk:Fl_Button(15, 40, 70, 20, "Clear");
      object:labelsize(10);
      object:callback(clsButton);
    end -- Fl_Button* o
    pokemap:size_range(339, 370, 663, 443);
    Fl_Group:current(Fl_Group:current():parent());
    pokemap:resizable(pokemap);
  end

  
  pokeoutFileName:value("Pokeout_")
pokeoutPathInput:value(pokeoutPath)
pokemap:show()----FLTK WINDOW
pokemap:color(55)
pokemap:labelsize(9)
drawingrect:when(1)

while pokemap ~= nil do
pokemap_callback()
end
  
  pokemap:show();
  ig3d_RebuildMacMenubar();
  if game_func==nil then
  	function runner()
      	fltk_update();
  	end
  	game_func=runner;
  end
  Fl:scheme("plastic")
--Fl:run();
