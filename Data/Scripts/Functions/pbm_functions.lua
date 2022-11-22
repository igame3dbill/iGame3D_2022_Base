pbmtable={}
pbmtableoutput = ""
fileList={}
textArray={}
btnListXY={}
textmapXY={}
btnList={}
quadwalls={}
CBI=string.char(123)
CBO=string.char(125)
 Q='"'
 pbmtable={}
function listFiles(path)
local fileList={}
--print(path)
    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            local f = path.."/"..file
           -- print(f)
            local attr = lfs.attributes(f)
            assert (type(attr) == "table")
             if attr.mode == "file" then 
             if file ~= ".DS_Store"  then
             table.insert(fileList, file)
             end
           -- print(file)
           end   
        end
     end
    return fileList
end


-- item="returns item n of a string"
function item(n,ofwhatString,itemDelimiter)
if itemDelimiter==nil then itemDelimiter="," end
if string.find(ofwhatString,itemDelimiter) == nil then return ofwhatString end
local itemResults={}
local delimitedString = ofwhatString..itemDelimiter
local counter=1
local numofitems=1
for itemN in string.gfind(delimitedString, itemDelimiter) do
-- subset is shortened string
subset =string.sub(delimitedString, counter, -1) 
-- find delimiter in subset
delimiterstart, delimiterend =string.find(subset, itemN) 
-- char 1 to delimiter-1 of subset
subresult = string.sub(subset, 1, delimiterend-1) 
if subresult ~= nil then
itemResults[numofitems]=subresult
numofitems = numofitems+1
counter = counter + delimiterend
end
end
--handle negative numbers
if n <= 0 and numofitems >= 1 then  return itemResults[numofitems+(n)] end
--handle positive numbers
if n <= numofitems then return itemResults[n] end
end


function fileNameFromPath(theFilepath)
return item(-1,theFilepath,"/")
end
function fileShortNameFromPath(theFilepath)
local name = item(-1,theFilepath,"/")
if name == nil or string.find(name,".") == nil then return "untitled" end
return string.sub(name,1,-5)
end



function read_pbm(tfile)
if tfile==nil then return end
local f = io.open(tfile,"r")
if f == nil then return end
pbmdata=f:read("*a")
io.close(f)
if pbmdata == nil then return end
local shortfile = string.sub(fileNameFromPath(tfile),-7,-5)
shortfile=tostring(tonumber(shortfile))
pbmhead=string.match(pbmdata,"%a%d")
pbmgrid = string.match(pbmdata,"%d%s%d%c")

s,e = string.find(pbmdata,pbmgrid)
pbmdata = string.sub(pbmdata,e,-1)
pbmdata = string.gsub(pbmdata, "%s%c", "")
pbmdata = string.gsub(pbmdata, "%s", "")
--print(shortfile)
--print(pbmhead)
--print(pbmgrid)
local s = ""
local ss = ""
pbmtable[shortfile]={}
findit="%d%c"
findtwo = string.rep("%d",8)
findit=findtwo
for i,v in string.gmatch(pbmdata,findit) do
if string.len(i) == 8 then 
s = s .. i.."\n" 
--ss=ss..Q..i..Q..","
table.insert(pbmtable[shortfile],i)
end
--print(i)
if string.len(s)==64+8 then
s =  string.sub(s,1,-2)
	table.insert(pbmtable[shortfile],s)
	s=""
	end
end
end

function pbms_to_table(tpath)
fileList=listFiles(tpath)
table.sort(fileList)
local sb=""
chr={}
prechr={}
	for i,v in pairs(fileList) do
	read_pbm(tpath.."/"..v)
	end
	for i,v in pairs(pbmtable) do
	
	s=tostring(i)
	chr[tonumber(i)]=Q..pbmtable[i][9]..Q
	
	end
	
	
	
	for i =1,#chr,1 do
	sb=sb.."chr["..i.."]="..Q..chr[i]..Q.."\n\n"
	end
	sb = "chr={}\n"..sb
	f=io.open("/AquariusCharactersPMB.lua","w")
	f:write(sb)
	io.close(f)
end


function parsePBM2Map(charn)
local sb=""
textArray={}
btnListXY={}
textmapXY={}
btnList={}
quadwalls={}
local schc=""
y=1
local sb = ""
local bs=""
pbms_to_table("/AQAURIUS8x8PBM")
	s=tostring(charn)
	pbmblock=pbmtable[s]
for i = 1,#pbmblock-1, 1 do
	sc=pbmblock[i]
	--print(sc)
	sb=sb..sc.."\n"
	for c=1,string.len(sc),1 do
	--floor
	QFloor = string.sub(sc,c,c) 
	QEast = string.sub(sc,c+1,c+1)
	QWest = string.sub(sc,c-1,c-1)
	schc=schc..QWest 
	table.insert(textArray,QFloor)	
	if QFloor ~= "0" then
	table.insert(textmapXY,{c,y}) 
 	table.insert(btnListXY,{c,y})
 	xys=(tostring(c)..","..tostring(y))
	table.insert(btnList,xys) 
	-- using quadwalls for roof and floor
 	table.insert(quadwalls,{c,y,"floor"})	
	end	
	end	
	y=y+1
	end									
end

function write_pbmMeshMapstoFile()
local s =""
local ss = "chrXY={}"
local sb=""
nTagNumber=0

vgridwidth=1
vgridlength=1
vcubewidth=1
vcubelength=1
vcubeheight=1
gridSize,cubeSize=1,1
gridSize,quadSize=1,1
gFloorWTF="Floors/1x1whitefloor.wtf"
meshdone = false
for ii=0,255,1 do
parsePBM2Map(ii)
gMeshObjectWTFs={}
gMeshObjectNames={}
gMeshObjectPositions={}
gMeshObjectRotations={}
gMeshObjectSizes={}
for i=1,#textmapXY,1 do
	sb=sb..CBI..textmapXY[i][1]..","..textmapXY[i][2]..CBO..","
	local 	x=textmapXY[i][1]*gridSize
	local y=textmapXY[i][2]*gridSize
	iBuildMeshObjectTables(x,y)
	end
	s="chrXY".."["..Q..ii..Q.."]={"..string.sub(sb,1,-2).."}"
	ss=ss.."\n"..s
	sb=""
	if meshdone == true then ig3d_DeleteMesh_b(true) end
	nTagNumber=0
	for ik=getlinecount(ig3d_GetMesh_tagsList__s()),1,-1 do
	ig3d_DeleteMesh_tag_i(ik)
	end
	meshdone = convertMeshObjectsTablesToMeshFile("Data/WTF/AquaChar/chr"..ii..".wtf")
end


tFile = io.open("/AquariusXY.lua","w")
	if tFile ~= nil then 
	tFile:write(ss)
	io.close(tFile)		
	end
end

makepbms=write_pbmMeshMapstoFile

pbmSequentialTable={}
pbmlinelength=8
pbmlinedepth=8
pbmscreenshottable={}
shortPBMfile=""
function read_pbm_screenshot(tfile)
if tfile==nil then return end
local f = io.open(tfile,"r")
if f == nil then return end
pbmdata=f:read("*a")
io.close(f)
if pbmdata == nil then return end
 shortPBMfile = string.sub(fileNameFromPath(tfile),-7,-5)
shortPBMfile=tostring(tonumber(shortPBMfile))
pbmhead=string.match(pbmdata,"%a%d")
pbmgrid = string.match(pbmdata,"%d+%s%d+%c")
pbmlinelength = tonumber(string.sub(pbmgrid,1,string.find(pbmgrid,"%s")-1)) 
pbmlinedepth = tonumber(string.sub(pbmgrid,string.find(pbmgrid," ")+1,-1)) 
s,e = string.find(pbmdata,pbmgrid)
pbmdata = string.sub(pbmdata,e,-1)
pbmdata = string.gsub(pbmdata, "%s%c", "")
pbmdata = string.gsub(pbmdata, "%s", "")
--print(shortfile)
--print(pbmhead)
--print(pbmgrid)
local s = ""
local ss = ""
pbmscreenshottable[shortPBMfile]={}
findit="%d%c"
findtwo = string.rep("%d",pbmlinelength)
findit=findtwo
for i,v in string.gmatch(pbmdata,findit) do
if string.len(i) == pbmlinelength then 
s = s .. i.."\n" 
--ss=ss..Q..i..Q..","
table.insert(pbmscreenshottable[shortPBMfile],i)
--print(i)
for ii=1,string.len(i),1 do
table.insert(pbmSequentialTable,string.sub(i,ii,ii))
end
end

if string.len(s)==(pbmlinelength*pbmlinedepth)+pbmlinedepth then
s =  string.sub(s,1,-2)
	table.insert(pbmscreenshottable[shortPBMfile],s)
	s=""
	end
end

end

function read_pbmScreenXY(x,y)
local s=""
local sb=""
colstart=x
colend=x+7
rowstart=y
rowend=rowstart+7
for r =rowstart,rowend, 1 do
s=s..string.sub(pbmscreenshottable[shortPBMfile][r],colstart,colend)
if string.len(s) == 8 then
sb=sb..s.."\n"
s=""
end
end
if string.len(sb) ==64+8 then
--print(sb)
return string.sub(sb,1,-2)
end
end
Aquariuspeeks={}
function setpeeks()
for ii=1,pbmlinedepth-7,9 do
for i=1,pbmlinelength-7,9 do
local zerosorones = read_pbmScreenXY(i,ii)
--print(zerosorones)
--print()
if zerosorones ~= nil then
table.insert(Aquariuspeeks,zerosorones)
end
end
end
end

function peek(n)
return Aquariuspeeks[n]
end

function doit()
pbms_to_table("/AQAURIUS8x8PBM")
local sout=""
local shs=""
local s=""
local n = 1
local c=1
local cc=0
setpeeks()
for i = 1,#Aquariuspeeks,1 do 
s=Aquariuspeeks[i] 
foundchar = 33
for ii=0,255,1 do
	ss=tostring(ii)
	pbmblock=pbmtable[ss][9]
--	print(pbmblock)

if s == pbmblock  then
foundchar=ii +1
end
end
--print(ii)
--if foundchar ~= nil then
--if string.find(s,"1") ~= nil and string.find(s,"0") ~= nil then 
--print(i,ii)
--print(s); 
--print() 
shs=shs..i..","..(foundchar-1)..","
cc=cc+1
c=c+1
--end

if c > 5 or i==#Aquariuspeeks then

n=n+1
sout=sout..(n*100).." DATA "..string.sub(shs,1,-2).."\r"
c=1
shs=""
end


end
sout = "10 for i =1 to".. (cc-2).."\r 20 read p,c\r 30 poke 12327+p,c\r 40 next i\r"..sout.."cls:run\r"
tpfile="/Users/williamgriffin/Applications/CrossOver/VirtualAquarius/quicktyp/pokeout.txt"
tFile = io.open(tpfile,"w")
	if tFile ~= nil then 
	tFile:write(sout)
	io.close(tFile)		
	end
end

read_pbm_screenshot("/AquaScreensPBM/screenshot_0011.pbm")