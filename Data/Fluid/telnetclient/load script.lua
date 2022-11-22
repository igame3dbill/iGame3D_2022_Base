

if chatClient==nil then dofile(gameroot.."Data/Levels/ChatClient/chatclient.cxx") end



setSceneInfo(IG3D_RUN_IN_BACKGROUND, true) --server needs to be able to run in background


function clientLevel()
	local l_offset=#chatLog_buf:text()
	chatLog:insert_position(l_offset)
    
      if chatSocket ~=nil then
      	val,e=chatSocket:receive()
      	if val~= nil and e==nil then
      		chatLog:insert(val.."\n")
		chatLog:show_insert_position()
      	end
      	if e=="closed" then 
      		chatLog:insert("Host closed the connection.\n\n")
      		chatSocket=nil
      		chatSubmit:label("Connect To")
      		chatDisconnect:deactivate()
		chatLog:show_insert_position()
      	end
      end
      
     fltk_update()
end
game_func=clientLevel

