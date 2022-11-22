documentation={}
documentation.func={}
documentation.doc={}
documentation.vars={}
documentation.rtrns={}
documentation.outp={}
function makeHelpTables()

f=io.open(gameroot.."Data/Help/reference.txt", "r")
if f~=nil then
 rText=f:read("*a")
 f:close()
 f=io.open(gameroot.."Data/Help/scripting.txt", "r")
 sText=f:read("*a")
 f:close()
 allText=rText.."\n"..sText
srchText=allText
 oldst,olden=0,-1 ;paran="%\(" ; paranc="%\)"; output=""; docString = "" ; cs=-1
allNames,allFound="",""
else
srchText=""
end
while string.len(srchText) > 2 do 
--for lines in string.gmatch(allText,"%\n")  do
	-- find line endings
 	s,e=string.find(srchText,".\n")
 		if s==nil then  	
		srchText =0
		else
 		-- get space between last line ending and new line ending
 		ssText = string.sub(srchText,oldst+1,s)
 		oldst,olden=s,e
 		-- saved  text = e to end of text
 		srchText=string.sub(srchText,e,-1) 
 		-- find "func: " in the document
  		ss,ee=string.find(ssText,"func: ");
		ds,de=string.find(srchText,"docs: ");
	if ds~=nil then 
	eds,ede=string.find(srchText,".\n")
	docString = string.sub(srchText,de,ede) 
	srchText=string.sub(srchText,ede,-1) 
	oldst,olden=eds,ede	
	end
	end
		
if ss ~= nil then
--get whole function line
FuncString=string.sub(ssText,ee,-1);		
sss,eee=string.find(FuncString,paran);  
 ess,eee=string.find(FuncString,paranc)  
 if sss~= nil then 
 FunName=string.sub(FuncString,1,sss-1)
 tVars=string.sub(FuncString,sss,ess)
 cs,coe=string.find(FuncString,"%:")
	if cs ~= nil then 
	tRtrns=string.sub(FuncString,cs+2,-2) 
	else
	tRtrns=""
	end
	else
FunName=FuncString
 end --sssnotnil
 end --ssnotnil
 
if  FunName ~= nil and docString ~= nil then	
fchk=FunName..tVars.." : "..tRtrns
 chs,che= string.find(allNames,fchk)
	--if chs == nil then
	
	allNames = fchk.." "..allNames
	documentation.func[#documentation.func+1] = FunName
	documentation.doc[#documentation.doc+1] = docString
	documentation.vars[#documentation.vars+1] = tVars
	documentation.rtrns[#documentation.rtrns+1] = tRtrns
	FunName = nil
	docString = nil
	--end --ifchs
 end -- iffunname
 
 end --forloop
end --ig3dReference



function getHelp(tFilter,getData)
documentation.found={}
documentation.outp={}
for i = 1,#documentation.func do
	FunName = documentation.func[i]
	totabl=true
if tFilter ~= nil  then 
ts,te=string.find(string.lower(FunName),string.lower(tFilter)) 	 
if ts == nil then totabl=false end
end			
if totabl == true then documentation.found[#documentation.found+1]= i 	end
end --for
	OC=0
for i=1,#documentation.found do
	n=documentation.found[i]
	FunName = documentation.func[n]
	varsout = documentation.vars[n]
	docs = documentation.doc[n]
	tRtrns = documentation.rtrns[n]
	lc=#documentation.outp
	OC=lc+1
	if getData == nil then print(FunName) end
	if getData == "c" and tRtrns ~= ""  then documentation.outp[OC]= tRtrns.." = "..FunName..varsout end
	if getData == "v" then documentation.outp[OC]= FunName..varsout end
	if getData == "d" then documentation.outp[OC]= FunName..varsout.." : "..tRtrns.."\n"..docs end
if #documentation.outp == OC then print(OC,documentation.outp[OC]) end
	end
end --func


	
function help(tFilter,getData)
getHelp(tFilter,getData)
end
makeHelpTables()

c=help

	