-- This code uses a time out of 0.0, which is a very bad approach, yet it works for testing until there are threads!
connections={}
numConnections=0
gTelnetServers=nil
host = "*"		--"localhost";
port = "8383";
ack = "\n";

function ig3d_telnetserver()
if gTelnetServers==nil then
io.flush()
print("iGame3D Telnet Test Program for "..socket._VERSION)
server = assert(socket.bind(host, port));
server:settimeout(0.0)
gTelnetServers=1
end
    control = server:accept();
    
    if control~=nil then
        numConnections = numConnections + 1
    print("User "..numConnections.. " connected!\n");
    connections[numConnections]=control;
    connections[numConnections]:settimeout(0.0)
    connections[numConnections]:send("Welcome to the server level!\n");
    end
    
    for i=1,numConnections,1 do
    	if connections[i]~= nil then
    		result,e =connections[i]:receive();
    		if result == nil then
    		if e == "closed" then
    			print("User "..i.." disconnected!\n");
    			connections[i]=nil
    		end
    		
    		else
    			for j=1,numConnections,1 do
    				if i~=j and connections[j]~= nil then
    					connections[j]:send("User "..i..": "..result.."\n");
    				end
    			end
    			print("User "..i..": "..result)
    		end
    	end
    end
    
end
