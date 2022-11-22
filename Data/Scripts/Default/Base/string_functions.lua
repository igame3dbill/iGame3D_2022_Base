cr = "\n"
itemDelimiter=","

function getlinecount(w)
lcn=0
if string.find(w,"\n") == nil then w=w.."\n" end
for ws in string.gmatch(w,"\n") do lcn=lcn+1 end
return lcn
end

function getlineof(s,n)
lcn=0
if string.find(s,"\n") == nil then s=s.."\n"   end
stemp=s
rtp=nil
 for ws in string.gmatch(s,"\n") do
 rtp=string.find(stemp,"\n")
		if rtp ~= nil then 
		lcn=lcn+1
		lst=string.sub(stemp,1,rtp-1) 
		end
		
		if lcn == n then return lst  end
		stemp = string.sub(stemp,rtp+1,-1)
 end
 return lsto
end

-- itemDel="set global  item delimiter"
function itemDel(what)
if what == nil then 
itemDelimiter = ","
else
 itemDelimiter = what
end
return itemDelimiter
end

-- numberofitems="returns the number of items in a string"
function numberofitems(itemList,itemDelimiter)
if itemDelimiter==nil then itemDelimiter="," end
DelimitedString = itemList
local numofitems =1
for itemN in string.gfind(DelimitedString, itemDelimiter) do
numofitems=numofitems+ 1
end
return numofitems
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

--return last item of filepath
function fileNameFromPath(theFilepath)
return item(-1,theFilepath,"/")
end
function fileShortNameFromPath(theFilepath)
local name = item(-1,theFilepath,"/")
if name == nil or string.find(name,".") == nil then return "untitled" end
return string.sub(name,1,-5)
end


-- listitems="print the string items of whatTable as list"
 function listitems(whatString,Delimiter)
 local itemList=""
 local  nItems = numberofitems(whatString,Delimiter)
 if nItems == nil then return end
 for eachitem=1, nItems,1 do
 itemN=item(eachitem,whatString,Delimiter)
 if itemN~=nil  then
 if  itemList ~="" then  
 itemList = itemList.."\n"..itemN 
 else
 itemList = itemN 
 end
 end
 end --for each item

 return itemList
 end
 
 -------------------------------------------

function deleteItems(text, Delimiter, nfirst, nlast)
	--deletes n items from the start of text
	local nItems= numberofitems(text,Delimiter)
    if nItems == nil  then return end
	local ret = ""		
	local i = 0; n = 0 ; nStart=nfirst ; nFin=nlast;	
	if nfirst >= 1 then nStart=nfirst 
	elseif nfirst <0 then nStart=nItems+nfirst
	end 
	if  nlast >= 1 then nFin = nlast
	elseif nlast <0 then nFin=nItems+nlast 
	end	
for i=1,nItems,1 do
	n=n+1
	local itemN = item(n,text,Delimiter)
	if itemN ~= nil then 
		if n < nStart or n > nFin then
			if ret=="" then
			ret=itemN
			else
			ret=ret..Delimiter..itemN
			end
		end
	end
end

	return ret
end


--fixes space in file paths with unix backslash
function unixpath(pathstring)
return string.gsub(pathstring," ", "\\ ")
end


-- tableindex ="print the index of a table"
function tableindex(oftable,delimiter)
local result=""
for tablekey,keyvalue in pairs(oftable) do
if delimiter==nil then
result= result..tablekey.." = "..keyvalue.."\n"
else
result=result..keyvalue..delimiter
end
end
if delimiter ~=nil then return string.sub(result,1,-2) end
return result
end

-- tabletostring="convert table to string"
function tabletostring(whatTable,delimiter)
if delimiter==nil then delimiter ="\n" end
local result=""
for tablekey,keyvalue  in pairs(whatTable) do 
result= result .. keyvalue..delimiter
end
return string.sub(result,1,-2)
end


-- tabletostring="convert string to table"
function stringtotable(str)
local t={}
	local lastOne=1
	local i=0
	while true do
		i=string.find(str.."\n", "\n", i+1)
		if i == nil then
			break
		else
			table.insert(t, string.sub(str, lastOne, i-1))
			lastOne=i+1
		end
	end
	return t
end



-------------------------------------------
function numberoflines(str)
	n=0
	local i=0
	while 1 do
		i=string.find(str.."\n", "\n", i+1)
		if i == nil then
			break
		else
			n=n+1
		end
	end
	return n
end

function removeLines(text, n)
text=text.."\n"
if n==nil then return text end
local counter=1
local textout=""
local countedLines=0
local totalLines=numberoflines(text)+1
for LineN in string.gfind(text, "\n") do
subset =string.sub(text, counter, -1) -- subset is shortened string
delimiterstart, delimiterend =string.find(subset, "\n")  -- find cr in subset
subresult=string.sub(subset, 1, delimiterend-1) -- result is char 1 to cr-1 of subset
counter=counter+ delimiterend
countedLines = countedLines +1
if subresult~=nil then
if  countedLines~=n and countedLines~=totalLines+n  then 
if textout=="" then
textout=subresult 
else
textout=textout.."\n"..subresult 
end
end
end
end
return textout
end
-------------------------------------------

--------------------------------------------
function extractVectorFromString(s)
i=string.find(s, ",", 1)
j=string.find(s, ",", i+1)
local x= string.sub(s, 1, i-1)
local y=string.sub(s, i+1, j-1)
local z=string.sub(s, j+1, -1)
return x,y,z
end
-------------------------------------------
function extractWords(str)
	local wordList={}
	local lastOne=1
	local i
	for word in str:gmatch("%w+") do
		table.insert(wordList, word)
	end
	return wordList
end
-------------------------------------------
-------------------------------------------
--NON ESSENTIAL AND TESTING
-------------------------------------------
-------------------------------------------
-- put="act as put command does in rev"
function put(arguments)
subresult="result="..arguments
loadstring(subresult)() 
print(result)
return result
end 

-- quoted="return the string enclosed in quotes"
function quoted(anystring) --"quoted what"
local result= "\""..anystring.."\""
return result
end 

-- replaceText ="replace text with string in source string"
function replaceText(textToReplace,withReplacementText,sourceString)
result=string.gsub(sourceString,textToReplace, withReplacementText) 
return result
end 


function hello(agreeting)
if agreeting==nil then agreeting="Hello " end
 print(os.date()," "..agreeting)
end

--- returns date as MMDDYY
    function todaysdate()
    date_args="%m%d%y" 
    today=os.date(date_args , os.time())
    return today
    end

 --- returns X,0,Z of line of a list of XY points
    function xzPoints(cnt,points)
      local pos = {}   
      pos = points[cnt]
      pointsLine=(pos.x)..",0.0,"..(pos.y)
      return pointsLine
    end --listPoints
-- escapechars="convert english string to LUA escape string"
function escapechars(whatWord)
if whatWord == "cr" then return "\n"
elseif whatWord == "lf" then return "\n"
elseif whatWord == "quote" then return "\""
elseif whatWord == "tab" then return "\t" 
elseif whatWord == "comma" then return "," --- horizontal tab
end 
return whatWord
end

-- es="convert english string to LUA escape string"
function es(whatword)
return escapechars(whatword)
end 

function commaSep(x,y,z)
result=string.format("%d%s%d%s%d",x,",",y,",",z)
print(result)
return result
end

function commaDelItems(a,b,c)
result=commaSep(a,b,c)
return result
end

-- getthe="returns table contents of the.what"
function getthe(what)
getLiteral="result=the."..what
loadstring(getLiteral)()
listitems(result)
end


--------------------------------------------
function GLText(boxnumber,text)
MaxLines=100 --arbitrary
if boxnumber==nil then boxnumber=1 end
	local tmp = getText_boxInfo(boxnumber, IG3D_TEXT).."\n"..text
	setText_boxInfo(1, IG3D_TEXT, removeLines(tmp, countLines(tmp)-MaxLines) )
	if text=="clear" then 
	setText_boxInfo(boxnumber, IG3D_TEXT, "" ) 
	end
end
