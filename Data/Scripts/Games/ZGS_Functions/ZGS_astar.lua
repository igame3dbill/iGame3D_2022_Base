
-- Tobi's attempt of making Lua classes for lists and binary heaps
SimpleList = { list={ }}
SimpleList_mt = { __index = SimpleList }

function SimpleList:create()
	local new_inst={}
	setmetatable(new_inst, SimpleList_mt)
	return new_inst
end


function SimpleList:add(node)
	node.icl=true --in closed list = true
	table.insert(self.list, node)
end

function SimpleList:isEmpty()
	return #self.list == 0
end

function SimpleList:contains( what )
	return what.icl
end

function SimpleList:cleanup()
	local i
	for i=#self.list,1,-1 do
		self.list[i].heapEntry=nil
		self.list[i].icl=false
		table.remove(self.list)
	end	
end


SimpleMinHeap = { heap={} }
SimpleMinHeap_mt = { __index = SimpleMinHeap }

function SimpleMinHeap:create()
	local new_inst={}
	setmetatable(new_inst, SimpleMinHeap_mt)
	return new_inst
end


function SimpleMinHeap:insert(node, prio)
	table.insert(self.heap, {nd=node, f=prio})
	node.heapEntry=self.heap[#self.heap]
	self:heapify(#self.heap)
end

function SimpleMinHeap:extractMin()
	if #self.heap==0 then return nil end
	local mn=self.heap[1]
	self.heap[1]=self.heap[#self.heap]
	table.remove(self.heap)
	self:heapify(1)
	return mn.nd
end

function SimpleMinHeap:heapify(idx)
	if #self.heap == 0 then return end
	--phase 1
	while true do
		if idx==1 then
			break
		else
			local prnt
			if idx % 2 == 1 then prnt= (idx-1)/2 else prnt=idx/2 end
			
			if self.heap[idx].f < self.heap[prnt].f then
				local swp=self.heap[prnt]
				self.heap[prnt]=self.heap[idx]
				self.heap[idx]=swp
				idx=prnt
			else
				break
			end
		end
	end
	--phase 2
	while true do
		if idx*2 > #self.heap then 
			--ie has no children
			break 
		else
			--check children
			local smallestKid=idx*2
			if smallestKid+1 <= #self.heap then
				if self.heap[smallestKid+1].f<self.heap[smallestKid].f then
					smallestKid=smallestKid+1
				end
			end
			if self.heap[idx].f>self.heap[smallestKid].f then
				local swp=self.heap[smallestKid]
				self.heap[smallestKid]=self.heap[idx]
				self.heap[idx]=swp
				idx=smallestKid
			else
				break
			end
		end
	end
end

function SimpleMinHeap:contains( what )
	return what.heapEntry~= nil
end


function SimpleMinHeap:changeKey( what, val )
	local i
	for i=1,#self.heap,1 do
		if self.heap[i].nd==what then
			self.heap[i].f=val
			self:heapify(i)
			break
		end
	end	
end

function SimpleMinHeap:isEmpty()
	return #self.heap == 0
end

function SimpleMinHeap:cleanup()
	local i
	for i=#self.heap,1,-1 do
		self.heap[i].nd.icl=false
		self.heap[i].nd.heapEntry=nil
		table.remove(self.heap)
	end	
end




NoPathFound=0
PathFound=1


function a_star(startNode, destinationNode)
    -- Initialisierung der Open List, die Closed List ist noch leer
    -- (die Priorit‰t bzw. der f Wert des Startknotens ist unerheblich)
	openlist=SimpleMinHeap:create()
	openlist:insert(startNode,0)
	closedlist=SimpleList:create()

    -- diese Schleife wird durchlaufen bis entweder
    -- - die optimale Lˆsung gefunden wurde oder
    -- - feststeht, dass keine Lˆsung existiert


    while true do
        -- Knoten mit dem geringsten f Wert aus der Open List entfernen
        currentNode = openlist:extractMin()
        -- wurde das Ziel gefunden?
        if currentNode == destinationNode then
        	destinationNode.heapEntry=nil--IMPORTANT for cleanup
        	openlist:cleanup()
        	closedlist:cleanup()
            return PathFound
		end
        -- Nachfolgeknoten auf die Open List setzen
        
		expandNode(currentNode)

        -- der aktuelle Knoten ist nun abschlieﬂend untersucht
        closedlist:add(currentNode)
    	if openlist:isEmpty() then break end
    end
    -- die Open List ist leer, es existiert kein Pfad zum Ziel
    openlist:cleanup()
    closedlist:cleanup()
    return NoPathFound
end


function squareOf(x)
	return x*x
end

function astar_g(node)
	if node.heapEntry~= nil then
		return node.heapEntry.f
	else
		return 0
	end
end



function astar_c(node1,node2)
	--local c,x,y,z,o=lineCollision(node1.x,node1.y,node1.z, node2.x,node2.y,node2.z)
	--if c~=0 then return 100000 end --something blocking the way
	return math.sqrt(squareOf(node1.x-node2.x)+squareOf(node1.y-node2.y)+squareOf(node1.z-node2.z))
end

function astar_h(node)
	return math.sqrt(squareOf(node.x-destinationNode.x)+squareOf(node.y-destinationNode.y)+squareOf(node.z-destinationNode.z))
end


function expandNode(currentNode)
    local i
    	
	for i=1,#currentNode.successors,1 do
		
		local successor=currentNode.successors[i]
        	-- wenn der Nachfolgeknoten bereits auf der Closed List ist - tue nichts
        
        
        --Update state of node:
        flagNode(successor)--wow, time intensiv!!
        --That node is obstructed----
        if currentNode.inside==false and successor.inside==true then
        	closedlist:add(successor)
        end
        -----------------------------
        
		if not closedlist:contains(successor) then
			
      			-- f Wert für den neuen Weg berechnen: g Wert des Vorgängers plus die Kosten der
        		-- gerade benutzten Kante plus die geschätzten Kosten von Nachfolger bis Ziel
        		f = astar_g(currentNode) + astar_c(currentNode, successor) + astar_h(successor)
			-- wenn der Nachfolgeknoten bereits auf der Open List ist,
        		-- aber der neue Weg länger ist als der alte - tue nichts
        		
			if not openlist:contains(successor) or f <= successor.heapEntry.f then
            			
            		
        			-- Vorgä‰ngerzeiger setzen
        			successor.predecessor = currentNode
				
        			-- f Wert des Knotens in der Open List aktualisieren
        			-- bzw. Knoten mit f Wert in die Open List einfügen
        			if openlist:contains(successor) then
         	   			openlist:changeKey(successor, f)
        			else
         	   			openlist:insert(successor, f)
    				end
				
			end
			
		end
		
	end
end



function maybe_add_successor(node1, node2)
	--if node1.inside==node2.inside then
		table.insert(node1.successors, node2)
	--end
end

function createNodeGrid(xsize,zsize,xoffset,zoffset,gridsize)
	grid={}
	
	for i=1,xsize,1 do
		a={}
		for j=1,zsize,1 do
			local prx=i*gridsize+xoffset
			local pry=100
			local prz=j*gridsize+zoffset
			
			local c,x,y,z,o=lineCollision(prx,pry,prz,prx,pry-200,prz)
			if c~= 0 then
				pry=y+0.5
			else
				pry=0.5
			end
			
			table.insert(a, {name=i..","..j, x=prx,y=pry,z=prz, successors={}, icl=false, heapEntry=nil})
			flagNode(a[#a])--is inside a building or outside??
		end
		table.insert(grid, a)
	end

	for i=1,xsize,1 do
		for j=1,zsize,1 do
			if i<xsize then maybe_add_successor(grid[i][j], grid[i+1][j]) end
			if j<zsize then maybe_add_successor(grid[i][j], grid[i][j+1]) end
			if i>1 then maybe_add_successor(grid[i][j], grid[i-1][j]) end
			if j>1 then maybe_add_successor(grid[i][j], grid[i][j-1]) end
			
			if i<xsize and j<zsize then maybe_add_successor(grid[i][j], grid[i+1][j+1]) end
			if i<xsize and j>1 then maybe_add_successor(grid[i][j], grid[i+1][j-1]) end
			if i>1 and j<zsize then maybe_add_successor(grid[i][j], grid[i-1][j+1]) end
			if i>1 and j>1 then maybe_add_successor(grid[i][j], grid[i-1][j-1]) end
			
		end
	end

end


function getSurroundingNodesOfPosition(x,y,z)
	local nodes={}
		
	local i=math.min( math.max(math.floor((x-gXOffset)/gGridSize),1), gNumRowVertices)
	local j=math.min( math.max(math.floor((z-gZOffset)/gGridSize),1), gNumColumnVertices)
	table.insert(nodes, grid[i][j])
	
	local i=math.min( math.max(math.floor((x-gXOffset)/gGridSize),1), gNumRowVertices)
	local j=math.min( math.max(math.ceil((z-gZOffset)/gGridSize),1), gNumColumnVertices)
	table.insert(nodes, grid[i][j])

	local i=math.min( math.max(math.ceil((x-gXOffset)/gGridSize),1), gNumRowVertices)
	local j=math.min( math.max(math.floor((z-gZOffset)/gGridSize),1), gNumColumnVertices)
	table.insert(nodes, grid[i][j])
	
	local i=math.min( math.max(math.ceil((x-gXOffset)/gGridSize),1), gNumRowVertices)
	local j=math.min( math.max(math.ceil((z-gZOffset)/gGridSize),1), gNumColumnVertices)
	table.insert(nodes, grid[i][j])
	return nodes
end

function flagNode(nd)
	nd.inside=false
	for i=1,gNumObjects,1 do
		local blockingObject=false
		if gObjects[i].team>1 then
			blockingObject=true
			if gObjects[i].driver~= nil and gObjects[i].driver.selected==true then blockingObject=false end
		end
		
		if blockingObject then
			local x,y,z=getObjectInfo(gObjects[i].cObj, IG3D_POSITION)
			local xlow,xhigh,ylow,yhigh,zlow,zhigh=getObjectInfo(gObjects[i].cObj, IG3D_BOUNDS)
			xlow=xlow+x-1
			xhigh=xhigh+x+1
			zlow=zlow+z-1
			zhigh=zhigh+z+1
			if nd.x>xlow and nd.x<xhigh and nd.z>zlow and nd.z<zhigh then nd.inside=true; return; end
		end
	end
end


function mrnd(n)
	local rst=n-math.floor(n)
	if math.abs(rst)>=0.5 then return math.ceil(n) else return math.floor(n) end
end

function generateAStarPathBetweenPositions( x2,y2,z2, x1,y1,z1)
	
	
	local nds= getSurroundingNodesOfPosition(x1,y1,z1)
	local dst1=vecLength(x2-nds[1].x, y2-nds[1].y, z2-nds[1].z)
	local dst=dst1
	local dst2=vecLength(x2-nds[2].x, y2-nds[2].y, z2-nds[2].z)
	local dst3=vecLength(x2-nds[3].x, y2-nds[3].y, z2-nds[3].z)
	local dst4=vecLength(x2-nds[4].x, y2-nds[4].y, z2-nds[4].z)
	local nearestToStart=nds[1]
	if dst2<dst then nearestToStart=nds[2]; dst=dst2 end
	if dst3<dst then nearestToStart=nds[3]; dst=dst3 end
	if dst4<dst then nearestToStart=nds[4] end
	
	nds= getSurroundingNodesOfPosition(x2,y2,z2)
	dst1=vecLength(x2-nds[1].x, y2-nds[1].y, z2-nds[1].z)
	dst=dst1
	dst2=vecLength(x2-nds[2].x, y2-nds[2].y, z2-nds[2].z)
	dst3=vecLength(x2-nds[3].x, y2-nds[3].y, z2-nds[3].z)
	dst4=vecLength(x2-nds[4].x, y2-nds[4].y, z2-nds[4].z)
	local nearestToEnd=nds[1]
	if dst2<dst then nearestToEnd =nds[2]; dst=dst2 end
	if dst3<dst then nearestToEnd =nds[3]; dst=dst3 end
	if dst4<dst then nearestToEnd =nds[4] end
	nds=nil


	startNode={name="A", x=x1,y=y1,z=z1, successors={nearestToStart}, heapEntry=nil, icl=false }
	destinationNode={name="B", x=x2, y=y2, z=z2, successors={nearestToEnd}, heapEntry=nil, icl=false }
	table.insert(nearestToStart.successors, startNode)
	table.insert(nearestToEnd.successors, destinationNode)
	
	if nearestToStart.inside or nearestToEnd.inside then beep() end-- ok, think up something else

	

	if a_star(startNode, destinationNode)==1 then
		--is reachable
		
		local nd=destinationNode
		local pth_head={x=nd.x, y=nd.y, z=nd.z, next=nil}
		local pth=pth_head
		
		while nd~=nil do
			
			local tnd=nd.predecessor
			nd.predecessor=nil
			nd=tnd
			if nd~= nil then
				pth.next={x=nd.x, y=nd.y, z=nd.z, next=nil}
				pth=pth.next
			end
		end
		return pth_head
	else
		return {x=x2, y=y2, z=z2, next=nil}
	end
end







function crazyJumpBack()
	if time()>crazyJumpBackTime then
		ig3d_SetMode_i(4)
	end
end



function setupAStarGrid()
	local sx,bx,sy,by,sz,bz=ig3d_GetMeshBounds__6f()
	
	--gNumRowVertices=200
	--gNumColumnVertices=200
	gGridSize=2
	gNumRowVertices=math.ceil( (bx-sx)/gGridSize)
	gNumColumnVertices=math.ceil( (bz-sz)/gGridSize )

	
	gXOffset=-gGridSize*(gNumRowVertices/2)
	gZOffset=-gGridSize*(gNumColumnVertices/2)
	createNodeGrid(gNumRowVertices, gNumColumnVertices, gXOffset, gZOffset, gGridSize)
end

