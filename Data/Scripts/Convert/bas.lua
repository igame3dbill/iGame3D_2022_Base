gBas_statements={"CALL" ,"CASEELSE_CASEVALUE" ,"CHDIR_MKDIR" ,"CLEAR" ,"CLOSE" ,"CLS" ,"COLOR" ,"DATA" ,"DEFFN_DEFPROC_FUNCTION_SUB" ,"DEC_INC" ,"DEFINT_DEFDBL_DEFSTR" ,"DELETE" ,"DIM" ,"DISPLAY" ,"DO" ,"DOWHILE" ,"EDIT" ,"ELSE_ELSEIFELSE" ,"END" ,"ENDIF" ,"ENDFN" ,"ENDPROC_SUBEND" ,"ENDSELECT" ,"ENVIRON" ,"COLON_EOL" ,"QUOTE_REM" ,"EQ_FNRETURN_FNEND" ,"ERASE" ,"EXITDO" ,"EXITFOR" ,"FIELD" ,"FOR" ,"GET_PUT" ,"GOSUB" ,"RESUME_GOTO" ,"KILL" ,"LET" ,"LINEINPUT" ,"LIST_LLIST" ,"LOAD" ,"LOCAL" ,"LOCATE" ,"LOCK_UNLOCK" ,"LOOP" ,"LOOPUNTIL" ,"LSET_RSET" ,"IDENTIFIER" ,"IF_ELSEIFIF" ,"INPUT" ,"MAT" ,"MATINPUT" ,"MATPRINT" ,"MATREAD" ,"MATREDIM" ,"NAME" ,"NEW" ,"NEXT" ,"ON" ,"ONERROR" ,"ONERRORGOTO0" ,"ONERROROFF" ,"OPEN" ,"OPTIONBASE" ,"OPTIONRUN" ,"OPTIONSTOP" ,"OUT_POKE" ,"PRINT_LPRINT" ,"RANDOMIZE" ,"READ" ,"COPY_RENAME" ,"RENUM" ,"REPEAT" ,"RESTORE" ,"RETURN" ,"RUN" ,"SAVE" ,"SELECTCASE" ,"SHELL" ,"SLEEP" ,"STOP" ,"SUBEXIT" ,"SWAP" ,"SYSTEM" ,"TROFF" ,"TRON" ,"TRUNCATE" ,"UNNUM" ,"UNTIL" ,"WAIT" ,"WHILE" ,"WEND" ,"WIDTH" ,"WRITE" ,"XREF",
 "ZONE"} 
 
 gBas_tokens={ "ACCESS_READ" ,"ACCESS_READ_WRITE" ,"ACCESS_WRITE" ,"AND" ,"AS" ,"CALL" ,"CASEELSE" ,"CASEVALUE" ,"CHANNEL" ,"CHDIR" ,"CLEAR" ,"CLOSE" ,"CLS" ,"COLON" ,"COLOR" ,"COMMA" ,"CON" ,"COPY" ,"CP" ,"DATA" ,"DATAINPUT" ,"DEC" ,"DEFDBL" ,"DEFFN" ,"DEFINT" ,"DEFPROC" ,"DEFSTR" ,"DELETE" ,"DIM" ,"DISPLAY" ,"DIV" ,"DO" ,"DOWHILE" ,"EDIT" ,"ELSE" ,"ELSEIFELSE" ,"ELSEIFIF" ,"END" ,"ENDFN" ,"ENDIF" ,"ENDPROC" ,"ENDSELECT" ,"ENVIRON" ,"EOL" ,"EQ" ,"EQV" ,"ERASE" ,"EXITDO" ,"EXITFOR" ,"FIELD" ,"FNEND" ,"FNRETURN" ,"FOR" ,"FOR_INPUT" ,"FOR_OUTPUT" ,"FOR_APPEND" ,"FOR_RANDOM" ,"FOR_BINARY" ,"FUNCTION" ,"GE" ,"GET" ,"GOSUB" ,"GOTO" ,"GT" ,"HEXINTEGER" ,"IDENTIFIER" ,"IDIV" ,"IDN" ,"IF" ,"IMP" ,"INC" ,"INPUT" ,"INTEGER" ,"INV" ,"JUNK" ,"KILL" ,"LE" ,"LET" ,"LINEINPUT" ,"LIST" ,"LLIST" ,"LOAD" ,"LOCAL" ,"LOCATE" ,"LOCK" ,"LOCK_READ" ,"LOCK_WRITE" ,"LOOP" ,"LOOPUNTIL" ,"LPRINT" ,"LSET" ,"LT" ,"MAT" ,"MATINPUT" ,"MATPRINT" ,"MATREAD" ,"MATREDIM" ,"MINUS" ,"MKDIR" ,"MOD" ,"MULT" ,"NAME" ,"NE" ,"NEW" ,"NEXT" ,"NOT" ,"ON" ,"ONERROR" ,"ONERRORGOTO0" ,"ONERROROFF" ,"OP" ,"OPEN" ,"OPTIONBASE" ,"OPTIONRUN" ,"OPTIONSTOP" ,"OR" ,"OUT" ,"PLUS" ,"POKE" ,"POW" ,"PRINT" ,"PUT" ,"QUOTE" ,"RANDOMIZE" ,"READ" ,"REAL" ,"REM" ,"RENAME" ,"RENUM" ,"REPEAT" ,"RESTORE" ,"RESUME" ,"RETURN" ,"RSET" ,"RUN" ,"SAVE" ,"SELECTCASE" ,"SEMICOLON" ,"SHARED" ,"SHELL" ,"SLEEP" ,"SPC" ,"STEP" ,"STOP" ,"STRING" ,"SUB" ,"SUBEND" ,"SUBEXIT" ,"SWAP" ,"SYSTEM" ,"TAB" ,"THEN" ,"TO" ,"TRN" ,"TROFF" ,"TRON" ,"TRUNCATE" ,"UNLOCK" ,"UNNUM" ,"UNNUMBERED" ,"UNTIL" ,"USING" ,"WAIT" ,"WEND" ,"WHILE" ,"WIDTH" ,"WRITE" ,"XOR" ,"XREF" ,"ZER" ,"ZONE" }
 
 
 gAquarius_tokens={"CLEAR" , "ABS" , "CLOAD" , "ASC" , "CONT" , "CHR$" , "COPY" , "COS" , "CSAVE" , "EXP" , "DATA" , "FRE" , "DIM" , "INKEY$" , "END" , "INT" , "FOR","NEXT" , "LEFT$" , "GOSUB" , "LEN" , "GOTO" , "LOG" , "IF","THEN" , "MID$" , "INPUT" , "PEEK" , "LET" , "POINT" , "LIST" , "POS" , "LLIST" , "RIGHT$" , "LPRINT" , "RND" , "NEW" , "SGN" , "ON" , "SIN" , "POKE" , "SPC" , "PRESET" , "SQR" , "PRINT" , "STR$" , "PSET" , "TAB" , "READ" , "TAN" , "REM" , "USR" , "RESTORE" , "VAL" , "RETURN" , "RETYPE" , "RUN" , "SOUND" , "STOP" , "STPLST" , "ATN" , "CLS" , "EDIT" , "LINE" , "CIRCLE" , "DRAW" , "LOCATE" , "GET" , "PUT" , "MENU" , "DEF" , "POKE" }
 gBas_match = {}
 function matchBAS()
 	for   i=1,#gAquarius_tokens,1 do
 		for n =1 ,#gBas_tokens,1 do 
 		a=gAquarius_tokens[i]
 		b=gBas_tokens[n]
 		c=string.gmatch(a,b)
		 	if c ~= nil then 
 			print(a) 
 			table.insert(gBas_match,a)
 			break
		 	end
 		end
 	 end 
end --matchBAS
 if #gBas_match < 1 then 
  gBas_match={"CLEAR" , "ABS" , "CLOAD" , "ASC" , "CONT" , "CHR$" , "COPY" , "COS" , "CSAVE" , "EXP" , "DATA" , "FRE" , "DIM" , "INKEY$" , "END" , "INT" , "FOR" , "NEXT" , "LEFT$" , "GOSUB" , "LEN" , "GOTO" , "LOG" , "IF" , "THEN" , "MID$" , "INPUT" , "PEEK" , "LET" , "POINT" , "LIST" , "POS" , "LLIST" , "RIGHT$" , "LPRINT" , "RND" , "NEW" , "SGN" , "ON" , "SIN" , "POKE" , "SPC" , "PRESET" , "SQR" , "PRINT" , "STR$" , "PSET" , "TAB" , "READ" , "TAN" , "REM" , "USR" , "RESTORE" , "VAL" , "RETURN" , "RETYPE" , "RUN" , "SOUND" , "STOP" , "STPLST" , "ATN" , "CLS" , "EDIT" , "LINE" , "CIRCLE" , "DRAW" , "LOCATE" , "GET" , "PUT" , "MENU" , "DEF" , "POKE"}
  end
  
  function basictolua(s)
  enl="end; -".."- \n"
  sls="-"
  basicLineNumbers = "\n%d+ "
  pin="%("
  dimensionalArrays= "%(+"
  o=""
for n in string.gfind(s,basicLineNumbers) do
a,o=string.find(s,n)
h,t=string.sub(s,1,a),string.sub(s,o+1,-1)
lin=string.sub(n,2,-2)
s=h.."basic["..lin.."]="..t
end

for n  in string.gfind(s,dimensionalArrays) do
a,o=string.find(s,n)
h,t=string.sub(s,1,a),string.sub(s,o+1,-1)
lin=string.sub(n,1,-1)
lin=string.gsub(lin,"%(","[")
lin=string.gsub(lin,"%)","]")
s=h..lin..t
end

b=string.gsub(s,"IF","if")
b=string.gsub(b,"THEN","then")
b=string.gsub(b,"FOR","for")
b=string.gsub(b,"NEXT",enl)
b=string.gsub(b,"<>","~=")
--b=string.gsub(b,"GOTO"," BRANCH(")
b=string.gsub(b,"END",enl)
b=string.gsub(b," TO ",",")
b=string.gsub(b,"REM ",sls..sls.."REM")
--b=string.gsub(b,"%s%a+%(","%s%a%[")
--b=string.gsub(b,"%) = ","]=")
b=string.gsub(b,"PRINT","PRINTOUT=PRINTOUT..")

print(b)
return b
end


basst=[[970 FOR M=3 TO P 
980   IF T = 0 THEN 1010
990     PRINT "."; 
1000   GOTO 1020 
1010     PRINT "_"; 
1020   T=1-T 
1030 NEXT M 
1040 PRINT 
1050 U=3 
1060 V=200+P 
1070 N=V+P 
1080 IF U > W THEN 1760
1090   T=1 
1100   FOR M=1 TO P 
1110     N=N+1 
1120     V=V+1 
1130     IF T <> 0 THEN 1190
1140       IF Z(N) = 1 THEN 1170
1150         PRINT " "; 
1160       GOTO 1230 
1170         PRINT "_"; 
1180     GOTO 1230 
1190       IF Z(V) = 1 THEN 1220
1200         PRINT "."; 
1210       GOTO 1230 
1220         PRINT "!"; 
1230     T=1-T 
1240   NEXT M 
1250   PRINT 
1260   U=U+2 
1270   N=N+P 
1280   V=V+P 
1290 GOTO 1080  ]]

  basictolua(basst)
  