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



function pointInObjectBoundingBox(obj, x,y,z)
	--have to rotate the position into the object's local coordinate system, then check if it is within the oriented bounding box
	local sx,bx,sy,by,sz,bz=getObjectInfo(obj.cObj, IG3D_BOUNDS)
	local a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)
	x=x-a41
	y=y-a42
	z=z-a43
	sx=sx-1
	bx=bx+1
	sy=sy-1
	by=by+1
	sz=sz-1
	bz=bz+1

	local tx=x*a11 + y*a12 + z*a13
	local ty=x*a21 + y*a22 + z*a23
	local tz=x*a31 + y*a32 + z*a33

	--if tx>sx and tx<bx and ty>sy and ty<by and tz>sz and tz<bz then return true end
	if tx>sx and tx<bx and tz>sz and tz<bz then return true end
	return false
end



NoPathFound=0
PathFound=1


function a_star(startNode, destinationNode)
    -- Initialisierung der Open List, die Closed List ist noch leer
    -- (die Priorität bzw. der f Wert des Startknotens ist unerheblich)
	openlist=SimpleMinHeap:create()
	openlist:insert(startNode,0)
	closedlist=SimpleList:create()

    -- diese Schleife wird durchlaufen bis entweder
    -- - die optimale Lösung gefunden wurde oder
    -- - feststeht, dass keine Lösung existiert


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

        -- der aktuelle Knoten ist nun abschließend untersucht
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



function astar_c(node1,node2,i)
	return math.sqrt(squareOf(node1.x-node2.x)+squareOf(node1.z-node2.z)) --maybe dont need to use the square root

	--if i<= 4 then return gGridSize else return gGridSize*1.414214 end
	--straight or diagonal move
end

function astar_h(node)
	--return math.sqrt(squareOf(node.x-destinationNode.x)+squareOf(node.y-destinationNode.y)+squareOf(node.z-destinationNode.z))
	return math.sqrt(squareOf(node.x-destinationNode.x)+squareOf(node.z-destinationNode.z))
end


function expandNode(currentNode)
    local i
    	
    	--reason for outcommenting: no dynamic change of node flags
     flagNode(currentNode)--wow, time intensiv!!
    
	for i=1,#currentNode.scs,1 do
		
		local successor=currentNode.scs[i]
        	-- wenn der Nachfolgeknoten bereits auf der Closed List ist - tue nichts
        
        
							
        --Update state of node:
        flagNode(successor)--wow, time intensiv!!
        --That node is obstructed----
       	if currentNode.inside==false and successor.inside==true then
        	closedlist:add(successor)--why outcommented?? its good!
        end
        -----------------------------
        
		if not closedlist:contains(successor) then
			
      			-- f Wert fr den neuen Weg berechnen: g Wert des Vorgngers plus die Kosten der
        		-- gerade benutzten Kante plus die geschtzten Kosten von Nachfolger bis Ziel
        		--f = astar_g(currentNode) + astar_c(currentNode, successor, i) + astar_h(successor)
        		f = astar_g(currentNode) + gGridSize + astar_h(successor)
			-- wenn der Nachfolgeknoten bereits auf der Open List ist,
        		-- aber der neue Weg lnger ist als der alte - tue nichts
        		
			if not openlist:contains(successor) or f <= successor.heapEntry.f then
            			
            		
        			-- Vorgängerzeiger setzen
        			successor.predecessor = currentNode
				
        			-- f Wert des Knotens in der Open List aktualisieren
        			-- bzw. Knoten mit f Wert in die Open List einfgen
        			if openlist:contains(successor) then
         	   			openlist:changeKey(successor, f)
        			else
         	   			openlist:insert(successor, f)
    				end
				
			end
			
		end
		
	end
end




function pick_best_matching_floor(node, y)
	local i
	local k=1
	local theAbs=10000.0
	
	for i=1,#node,1 do
		if math.abs(node[i].y-y)<theAbs then
			theAbs=math.abs(node[i].y-y)
			k=i
		end
	end

	return node[k]
end


function maybe_add_successor_primitive_nodes(node1, node2, sideCheck)
	local toTheSideConst=0.25
	

	
	--if node1.y>node2.y then yToCheck=node1.y+0.1 end
	
	
	if lineCollision(node1.x,node1.y+0.1,node1.z, node2.x, node2.y+0.1, node2.z, true) then
		return
	end
	
	if lineCollision(node1.x,node1.y+0.1,node1.z, node2.x, node2.y+0.3, node2.z, true) then
		return
	end
	
	if lineCollision(node1.x,node1.y+0.1,node1.z, node2.x, node2.y+0.65, node2.z, true) then
		return
	end
	
	local dx=node2.x-node1.x
	local dy=node2.y-node1.y
	local dz=node2.z-node1.z
	dx,dy,dz=normalized(dx,dy,dz)
	dx,dy,dz=cross(dx,dy,dz, 0,1,0)
	
	if sideCheck then
		if lineCollision(node1.x-dx* toTheSideConst,node1.y-dy* toTheSideConst +0.1,node1.z-dz* toTheSideConst, node2.x-dx* toTheSideConst, node2.y+0.1-dy*toTheSideConst, node2.z-dz* toTheSideConst, true) then
			return
		end
	
		if lineCollision(node1.x+dx* toTheSideConst,node1.y+dy* toTheSideConst +0.1,node1.z+dz* toTheSideConst, node2.x+dx* toTheSideConst, node2.y+0.1 +dy* toTheSideConst, node2.z+dz* toTheSideConst, true) then
			return
		end
	end
	
	if node2.y-node1.y > 0.30 then return end --0.25
	
	table.insert(node1.scs, node2)
end


function maybe_add_successor(nodes1, nodes2, sideCheck)
	local i,j
	
	for i=1,#nodes1,1 do
		for j=1,#nodes2,1 do
			maybe_add_successor_primitive_nodes(nodes1[i],nodes2[j], sideCheck)
		end
	end
	
end


--big change, this is 3D-table now, since there might be multiple floors at a certain 2D-position
function createNodeGrid(xsize,zsize,xoffset,zoffset,gridsize)
	grid={}
	
	for i=1,xsize,1 do
		a={}
		for j=1,zsize,1 do
		
			local prx=i*gridsize+xoffset
			local pry=200
			local prz=j*gridsize+zoffset
			
			local c=1
			local x,y,z,o
			local floors={}
			while c>0 do
				c,x,y,z,o=lineCollision(prx,pry-0.1,prz,prx,pry-500,prz)
				--if y<-0.2 then break end
				if c~= 0 then
					pry=y
					table.insert(floors, {name=i..","..j..","..(#floors+1), x=prx, y=pry+0.05, z=prz, scs={}, icl=false, heapEntry=nil, idx0=i, idx1=j, idx2=(#floors+1)})
					flagNode(floors[#floors])
				end
				
			end			
			
			
			if #floors == 0 then
				table.insert(floors, {name=i..","..j..","..(#floors+1), x=prx, y=250, z=prz, scs={}, icl=false, heapEntry=nil, idx0=i, idx1=j, idx2=(#floors+1)})
				flagNode(floors[#floors])
			end
			
			table.insert(a, floors)
		end
		table.insert(grid, a)
	end

	for i=1,xsize,1 do
		for j=1,zsize,1 do
			if i<xsize then maybe_add_successor(grid[i][j], grid[i+1][j], true) end--1
			--if i<xsize and j>1 then maybe_add_successor(grid[i][j], grid[i+1][j-1], true) end--6
			if j>1 then maybe_add_successor(grid[i][j], grid[i][j-1], true) end--4
			--if i>1 and j>1 then maybe_add_successor(grid[i][j], grid[i-1][j-1], true) end--8
			if i>1 then maybe_add_successor(grid[i][j], grid[i-1][j], true) end--3
			--if i>1 and j<zsize then maybe_add_successor(grid[i][j], grid[i-1][j+1], true) end--7
			if j<zsize then maybe_add_successor(grid[i][j], grid[i][j+1], true) end--2
			--if i<xsize and j<zsize then maybe_add_successor(grid[i][j], grid[i+1][j+1], true) end--5
			
			--isolate nodes inside walls!!
			local k
			for k=1,#grid[i][j],1 do
				--[[
				if #grid[i][j][k].scs>0 then
					if lineCollision(grid[i][j][k].x, grid[i][j][k].y, grid[i][j][k].z, grid[i][j][k].x-gGridSize*0.5, grid[i][j][k].y, grid[i][j][k].z, true) then
						if lineCollision(grid[i][j][k].x, grid[i][j][k].y, grid[i][j][k].z, grid[i][j][k].x+gGridSize*0.5, grid[i][j][k].y, grid[i][j][k].z, true) then
							grid[i][j][k].scs={}
						end
					end
				end
				
				if #grid[i][j][k].scs>0 then
					if lineCollision(grid[i][j][k].x, grid[i][j][k].y, grid[i][j][k].z, grid[i][j][k].x, grid[i][j][k].y, grid[i][j][k].z-gGridSize*0.5, true) then
						if lineCollision(grid[i][j][k].x, grid[i][j][k].y, grid[i][j][k].z, grid[i][j][k].x, grid[i][j][k].y, grid[i][j][k].z+gGridSize*0.5, true) then
							grid[i][j][k].scs={}
						end
					end
				end
				--]]
				
				--also get rid of nodes that are too near the walls
				if #grid[i][j][k].scs>0 then
					if lineCollision(grid[i][j][k].x, grid[i][j][k].y, grid[i][j][k].z, grid[i][j][k].x, grid[i][j][k].y, grid[i][j][k].z-0.25, true) then
						grid[i][j][k].scs={}
					end
				end
				
				if #grid[i][j][k].scs>0 then
					if lineCollision(grid[i][j][k].x, grid[i][j][k].y, grid[i][j][k].z, grid[i][j][k].x, grid[i][j][k].y, grid[i][j][k].z+0.25, true) then
						grid[i][j][k].scs={}
					end
				end
				
				if #grid[i][j][k].scs>0 then
					if lineCollision(grid[i][j][k].x, grid[i][j][k].y, grid[i][j][k].z, grid[i][j][k].x-0.25, grid[i][j][k].y, grid[i][j][k].z, true) then
						grid[i][j][k].scs={}
					end
				end
				
				if #grid[i][j][k].scs>0 then
					if lineCollision(grid[i][j][k].x, grid[i][j][k].y, grid[i][j][k].z, grid[i][j][k].x+0.25, grid[i][j][k].y, grid[i][j][k].z, true) then
						grid[i][j][k].scs={}
					end
				end
				
			end
			--quite a cool approach!
			
		end
	end
	
end




function getNearestNodeOfPosition(x,y,z)
	local i=math.min( math.max(math.floor((x-gXOffset)/gGridSize),1), gNumRowVertices)
	local j=math.min( math.max(math.floor((z-gZOffset)/gGridSize),1), gNumColumnVertices)
	
	local mindst=vecLength(grid[i][j][1].x-x, 0, grid[i][j][1].z-z)
	local dst
	local compNode
	local theNode= pick_best_matching_floor( grid[i][j], y)
	
	i=math.min( math.max(math.floor((x-gXOffset)/gGridSize),1), gNumRowVertices)
	j=math.min( math.max(math.ceil((z-gZOffset)/gGridSize),1), gNumColumnVertices)
	compNode=pick_best_matching_floor( grid[i][j], y)
	dst=vecLength(compNode.x-x, 0, compNode.z-z)
	if dst<mindst then
		mindst=dst
		theNode=compNode
	end

	i=math.min( math.max(math.ceil((x-gXOffset)/gGridSize),1), gNumRowVertices)
	j=math.min( math.max(math.floor((z-gZOffset)/gGridSize),1), gNumColumnVertices)
	compNode=pick_best_matching_floor( grid[i][j], y)
	dst=vecLength(compNode.x-x, 0, compNode.z-z)
	if dst<mindst then
		mindst=dst
		theNode=compNode
	end
	
	i=math.min( math.max(math.ceil((x-gXOffset)/gGridSize),1), gNumRowVertices)
	j=math.min( math.max(math.ceil((z-gZOffset)/gGridSize),1), gNumColumnVertices)
	compNode=pick_best_matching_floor( grid[i][j], y)
	dst=vecLength(compNode.x-x, 0, compNode.z-z)
	if dst<mindst then
		mindst=dst
		theNode=compNode
	end
	
	return theNode
end

function getSurroundingNodesOfPosition(x,y,z)
	local nodes={}
	
	local i=math.min( math.max(math.floor((x-gXOffset)/gGridSize),1), gNumRowVertices)
	local j=math.min( math.max(math.floor((z-gZOffset)/gGridSize),1), gNumColumnVertices)
	table.insert(nodes, pick_best_matching_floor(grid[i][j],y) )
	
	local i=math.min( math.max(math.floor((x-gXOffset)/gGridSize),1), gNumRowVertices)
	local j=math.min( math.max(math.ceil((z-gZOffset)/gGridSize),1), gNumColumnVertices)
	table.insert(nodes, pick_best_matching_floor(grid[i][j],y) )

	local i=math.min( math.max(math.ceil((x-gXOffset)/gGridSize),1), gNumRowVertices)
	local j=math.min( math.max(math.floor((z-gZOffset)/gGridSize),1), gNumColumnVertices)
	table.insert(nodes, pick_best_matching_floor(grid[i][j],y) )
	
	local i=math.min( math.max(math.ceil((x-gXOffset)/gGridSize),1), gNumRowVertices)
	local j=math.min( math.max(math.ceil((z-gZOffset)/gGridSize),1), gNumColumnVertices)
	table.insert(nodes, pick_best_matching_floor(grid[i][j],y) )
	
	return nodes
end

function flagNode(nd)

	if nd.flagTime==nil or time()-nd.flagTime > 3.0 then --reflag nodes only every three seconds if possible
		nd.flagTime=time()
		nd.inside=false
		
		--if nd.y>2 then nd.inside=true end
		
		for i=1,gNumObjects,1 do
			local blockingObject=false
			
			--if gObjects[i].selected==true then
			--	blockingObject=false
			--end
			
			--if gObjects[i].driver~= nil and gObjects[i].driver.selected==true then blockingObject=false end
			
			if gObjects[i].team==9 then
				blockingObject=true --reenable if there is scenery
			end
			
			
			if blockingObject then
				--[[
				local x,y,z=getObjectInfo(gObjects[i].cObj, IG3D_POSITION)
				local xlow,xhigh,ylow,yhigh,zlow,zhigh=getObjectInfo(gObjects[i].cObj, IG3D_BOUNDS)

				local maxsidehalf=math.max(xhigh-xlow, zhigh-zlow)*0.5
				xlow=x-maxsidehalf---0.5
				xhigh=x+ maxsidehalf-- +0.5
				zlow=z-maxsidehalf---0.5
				zhigh=z+ maxsidehalf --+0.5
				if nd.x>xlow and nd.x<xhigh and nd.z>zlow and nd.z<zhigh then nd.inside=true; return; end
				--]]
				if pointInObjectBoundingBox(gObjects[i], nd.x, nd.y, nd.z) then nd.inside=true; return; end
			end
			
		end
		
	end
end

function flagNodeExtended(x,y,z, nd)
	--reason for outcommenting: no dynamic change of node flags
	
	
	flagNode(nd)
	
	if nd.y==250 then nd.insideE=true; return end; --magic number
	
	--local dx,dy,dz=normalized(nd.x-x,0,nd.z-z)
	nd.insideE=lineCollision(x,y+0.3,z, nd.x, y+0.3,nd.z, true)
	if not nd.insideE then
		nd.insideE=lineCollision(x,y,z, nd.x, y,nd.z, true)
		if not nd.insideE then
			nd.insideE=lineCollision(x,y-0.3,z, nd.x, y-0.3,nd.z, true)
		end
	end
	
	
	--nd.insideE=lineCollision(x+0.05*dx,0.2,z+0.05*dz, nd.x, 0.2,nd.z, true)
	if #nd.scs== 0 then
		--isolated nodes are bad for starting a path with
		nd.insideE=true
	end
end

function maybe_step_forward(pth, x,y,z)
	--while true do
		if pth.next==nil then return pth end
		if not lineCollision(pth.next.x,pth.next.y,pth.next.z, x,y,z, true) then
			pth=pth.next
		else
			--break
		end
	--end
	return pth
end


function mrnd(n)
	local rst=n-math.floor(n)
	if math.abs(rst)>=0.5 then return math.ceil(n) else return math.floor(n) end
end


function getNearestOutsideNode(nd, x,y,z)

	local cx=nd.x
	local cy=y
	local cz=nd.z
	local dx,dy,dz=normalized(x-cx,0,z-cz)
	local ndnew
	local c=0

	
	while true do
	
		cx=cx+dx
		cy=cy+dy
		cz=cz+dz
	
		ndnew=getNearestNodeOfPosition(cx,cy,cz)
		flagNode(ndnew)
		
		local dx2,dy2,dz2=normalized(x-ndnew.x,0,z-ndnew.z)
		if dot(dx,dy,dz, dx2,dy2,dz2)<0 then
			--senseless to move, this would be wrong direction	
			return nil
		end
	
	
		if not ndnew.inside and nd~=ndnew then return ndnew end
	end
end

function getNearestOutsideNode2(nd, x,y,z)

	local cx=nd.x
	local cy=y
	local cz=nd.z
	local dx,dy,dz=normalized(x-cx,0,z-cz)
	local ndnew
	local c=0

	
	while true do
	
		cx=cx+dx
		cy=cy+dy
		cz=cz+dz
	
		ndnew=getNearestNodeOfPosition(cx,cy,cz)
		flagNode(ndnew)
		
		
	
		if not ndnew.inside and nd~=ndnew then return ndnew end
	end
end


function drawSuccessors(x,y,z,depth)
	local node=getNearestNodeOfPosition(x,y,z)
	for i=1,#node.scs,1 do
			drawVertex(node.x, 0.2, node.z)
			drawLine(node.scs[i].x, 0.2, node.scs[i].z)
			if depth<5 then
				drawSuccessors(node.scs[i].x, 0.2, node.scs[i].z, depth+1)
			end
	end
end

function checkPathForDuplicates(pth)
	local pth_stepper=pth

	while pth_stepper do
		if pth_stepper.next then
			if pth_stepper.x==pth_stepper.next.x and pth_stepper.z==pth_stepper.next.z then 
				pth_stepper.next=pth_stepper.next.next
				--return true
		 	end
		 end
		pth_stepper=pth_stepper.next
	end
	return false
end


function threeLinesCollision(sx,sy,sz,tx,ty,tz)
	if lineCollision(sx,sy,sz, tx,ty,tz, true) then return true end
	
	local toTheSideConst=0.25
	local dx=tx-sx
	local dy=ty-sy
	local dz=tz-sz
	dx,dy,dz=normalized(dx,dy,dz)
	dx,dy,dz=cross(dx,dy,dz, 0,1,0)
	
	if lineCollision(sx-dx*toTheSideConst,sy-dy*toTheSideConst,sz-dz*toTheSideConst, tx-dx*toTheSideConst, ty-dy*toTheSideConst, tz-dz*toTheSideConst, true) then
		return true
	end
			
	if lineCollision(sx+dx* toTheSideConst,sy+dy* toTheSideConst,sz-dz* toTheSideConst, tx+dx* toTheSideConst, ty+dy* toTheSideConst, tz+dz* toTheSideConst, true) then
		return true
	end
				
	return false
end

function generateAStarPathBetweenPositions(target, x1,y1,z1, x2,y2,z2, maxAdditionalPasses)

	--[[
	--perfom line of sight checks with three parallel lines, if none collides we are free to go
	dx=x1-x2
	dz=z1-z2
	dx,dy,dz=normalized(dx,0,dz)
	local c,x,y,z,o= lineCollision(x2,y2+0.5,z2, x1,y1+0.5,z1) 
	local wayIsFree=true
	
	if c==1 or (c==2 and o~=target) then
            wayIsFree=false
        else
            local ax,ay,az=cross(dx,dy,dz, 0,1,0)
            ax=ax*0.5
            ay=0
            az=az*0.5
            c,x,y,z,o= lineCollision(x2+ax,y2+0.5+ay,z2+az, x1+ax,y1+0.5+ay,z1+az)
            if c==1 or (c==2 and o~=target) then
                wayIsFree=false
            else
                c,x,y,z,o= lineCollision(x2-ax,y2+0.5-ay,z2-az, x1-ax,y1+0.5-ay,z1-az)
                if c==1 or (c==2 and o~=target) then
                    wayIsFree=false
                end
            end
        end
	
	if wayIsFree and target~=nil then return nil end -- no need for a star here!
	
	
	
	if wayIsFree then
		--no occluders, cool, now just walk there
                return {x=x2, y=y2, z=z2, next={x=x1, y=y1+0.5, z=z1, next=nil} }
	else
		local ds=vecLength(x1-x,y1+0.5-y,z1-z)
		if ds/gGridSize > 0 then
			--a star too expensive
			--print("a star too expensive, doing heuristic")
			x2=x
			y2=y
			z2=z
		end
		
	end

	
	--]]
	
	
	--y1=y1 -0.4--quick hack, y1 is the position of the object that moves most of the time!
	y2=y1--quick hack 2, dont climb floors
	
	--determine outside node in the area
	nds=getSurroundingNodesOfPosition(x1,y1,z1)
	nds2=nds
	
	--y1=nds[1].y[#nds[1].y]--hack
	flagNodeExtended(x1,y1,z1,nds[1])
	flagNodeExtended(x1,y1,z1,nds[2])
	flagNodeExtended(x1,y1,z1,nds[3])
	flagNodeExtended(x1,y1,z1,nds[4])
	
	--nds[1].insideE=false
	--nds[2].insideE=false
	--nds[3].insideE=false
	--nds[4].insideE=false
	
	local foundOutside1=false
	local dsts1={0,0,0,0}
	dsts1[1]=vecLength(x1-nds[1].x, 0, z1-nds[1].z)
	local dst=1000
	dsts1[2]=vecLength(x1-nds[2].x, 0, z1-nds[2].z)
	dsts1[3]=vecLength(x1-nds[3].x, 0, z1-nds[3].z)
	dsts1[4]=vecLength(x1-nds[4].x, 0, z1-nds[4].z)
	if nds[1].inside then dsts1[1]=dsts1[1]+2000 end--penalty
	if nds[2].inside then dsts1[2]=dsts1[2]+2000 end
	if nds[3].inside then dsts1[3]=dsts1[3]+2000 end
	if nds[4].inside then dsts1[4]=dsts1[4]+2000 end
	if nds[1].insideE then dsts1[1]=dsts1[1]+1000 end--penalty
	if nds[2].insideE then dsts1[2]=dsts1[2]+1000 end
	if nds[3].insideE then dsts1[3]=dsts1[3]+1000 end
	if nds[4].insideE then dsts1[4]=dsts1[4]+1000 end
	local nearestToStart
	nearestToStart=nds[1]; dst=dsts1[1];
	if dsts1[2]<dst then nearestToStart=nds[2]; dst=dsts1[2]; end
	if dsts1[3]<dst then nearestToStart=nds[3]; dst=dsts1[3]; end
	if dsts1[4]<dst then nearestToStart=nds[4]; dst=dsts1[4]; end


	
	
	--determine outside node in the area
	nds=nil
	nds= getSurroundingNodesOfPosition(x2,y2,z2)
	nds3=nds
	flagNodeExtended(x2,y2,z2,nds[1])
	flagNodeExtended(x2,y2,z2,nds[2])
	flagNodeExtended(x2,y2,z2,nds[3])
	flagNodeExtended(x2,y2,z2,nds[4])
	
	local foundOutside2=false
	local dsts2={0,0,0,0}
	dsts2[1]=vecLength(x2-nds[1].x, 0, z2-nds[1].z)
	dst=1000
	dsts2[2]=vecLength(x2-nds[2].x, 0, z2-nds[2].z)
	dsts2[3]=vecLength(x2-nds[3].x, 0, z2-nds[3].z)
	dsts2[4]=vecLength(x2-nds[4].x, 0, z2-nds[4].z)
	
	if nds[1].inside then dsts2[1]=dsts2[1]+2000 end--penalty
	if nds[2].inside then dsts2[2]=dsts2[2]+2000 end
	if nds[3].inside then dsts2[3]=dsts2[3]+2000 end
	if nds[4].inside then dsts2[4]=dsts2[4]+2000 end
	if nds[1].insideE then dsts2[1]=dsts2[1]+1000 end--penalty
	if nds[2].insideE then dsts2[2]=dsts2[2]+1000 end
	if nds[3].insideE then dsts2[3]=dsts2[3]+1000 end
	if nds[4].insideE then dsts2[4]=dsts2[4]+1000 end
	local nearestToEnd
	nearestToEnd =nds[1]; dst=dsts2[1];
	if dsts2[2]<dst then nearestToEnd =nds[2]; dst=dsts2[2]; end
	if dsts2[3]<dst then nearestToEnd =nds[3]; dst=dsts2[3]; end
	if dsts2[4]<dst then nearestToEnd =nds[4]; dst=dsts2[4]; end
	
	gende=nearestToEnd
	ganfang=nearestToStart

	dx,dy,dz=normalized(x1-x2,0, z1-z2)
	
	
--nearestToEnd= getNearestNodeOfPosition(x2,y2,z2)--uh oh	
	
y1=nearestToStart.y
y2=nearestToEnd.y

--code to disable A*

--[[
	if true then 
		
local pth_tail = {x= nearestToEnd.x, y= nearestToEnd.y, z= nearestToEnd.z, next=nil }
		pth_tail.last=pth_tail
		local pth_head={x= nearestToStart.x, y= nearestToStart.y, z= nearestToStart.z, last=pth_tail, next=pth_tail}
		local pth=pth_head 
		return pth_head,true
end
--]]	
	
	local aStarSuccessful=true


	
	startNode=nearestToStart
	destinationNode=nearestToEnd
	
	
	
	
	
	--first try: try to get inside
	if a_star(startNode, destinationNode)==1 and aStarSuccessful then
		--success
		aStarSuccessful=true
	else
		--failed! second try: try to reach a point outside
		local i
		aStarSuccessful=false
		
		if maxAdditionalPasses > 0 then
			local lim=math.floor(vecLength(x1-x2,0,z1-z2))+1
			lim=math.min(lim, maxAdditionalPasses)
			for i=1,lim,1 do
				local nr=getNearestOutsideNode(startNode, x1,y1,z1) --returns nil if no meaningful movement possible
				if nr==nil then
					aStarSuccessful =false
					break
				else
					startNode=nr
					if a_star(startNode, destinationNode)==1 then
						aStarSuccessful=true
						break
					end
				end
			end
		end
		
		
	end


	if aStarSuccessful then
		--is reachable
		
		local nd=destinationNode
		
		local pth_tail = {x= destinationNode.x, y= destinationNode.y, z= destinationNode.z, next=nil, prev=nil }
		pth_tail.last=pth_tail
		local pth_head={x=startNode.x, y= startNode.y, z= startNode.z, last=pth_tail, next=nil, prev=nil}
		local pth=pth_tail
		
		while nd~=nil do
			local tnd=nd.predecessor
			nd.predecessor=nil
			nd=tnd
			if nd~= nil then
				
				pth.prev={x=nd.x, y=nd.y, z=nd.z, last=pth_tail, next=pth, prev=nil}
				pth=pth.prev
					
				if nd.x==pth_head.x and nd.z==pth_head.z then 
					pth.prev=pth_head
					pth_head.next=pth
					break
				end --this is already the end, ignore any spare nodes
				
			end
		end
		
		
		
		--now check if another point in reach is the second point on the path, in this case we picked a bad start node and can go directly to this one node (if it didnt get "initially unreachable" penalty)
		
		local goOut=true
		while goOut==true do
			goOut=false
			dst=-1
			if pth_head.next then
				local j
				for j=1,4,1 do
					if pth_head.next.x==nds2[j].x and pth_head.next.z==nds2[j].z and dsts1[j]<1000 then
						if pth_head.next.x~=pth_head.x or pth_head.next~=pth_head.z then
							if dst==-1 or dsts1[j]<dst then
								--eliminate bad start nodes!!
								pth_head.x=nds2[j].x
								pth_head.y=nds2[j].y
								pth_head.z=nds2[j].z
								dst=dsts1[j]
								goOut=true
							end
						end
					end
				end
				if goOut then pth_head=pth_head.next end
			end
		end
		
		
		
		local pth=pth_head
		while pth do
			pth.x=pth.x-0.25 + math.random()*0.5
			pth.z=pth.z-0.25 + math.random()*0.5
			pth=pth.next
		end
		
		
		--[[
		--consume points as long as no collision occurs from start
		cx=x1--pth_head.x
		cy=y1--pth_head.y
		cz=z1--pth_head.z
		local steps=0
		while pth_head.next and steps<10 do
			if threeLinesCollision(cx,cy,cz, pth_head.next.x,cy,pth_head.next.z) then
				break
			else
				steps=steps+1
				pth_head=pth_head.next
			end
		end
		--]]
		
		
		
		
		
		
		--for some reason the last point is sometimes not the destination point, make sure it is!
		--pth.x= startNode.x
		--pth.y=startNode.y
		--pth.z=startNode.z
		if target and target~=gObjects[playerBox] then
			--danger, dont enable next three lines
			pth_tail.x,waste,pth_tail.z=getObjectInfo(target.cObj, IG3D_POSITION)
		end
		
		--pth.next=pth_tail--haha, dirty trick, append the path tail
		return pth_head,true
	else
		
		local pth_tail = {x= x1, y=y1, z=z1, next=nil, last=nil }
		pth_tail.last=pth_tail
		local pth_head={x= x1, y=y1, z=z1, last=pth_tail, next=pth_tail}
		return pth_head,false
	end
end







function crazyJumpBack()
	if time()>crazyJumpBackTime then
		ig3d_SetMode_i(4)
	end
end

function serializeNode(tbl)
	local oldsuccessors=tbl.scs
	tbl.scs={}
	
	local i
	for i=1,#oldsuccessors,1 do
		table.insert(tbl.scs, {oldsuccessors[i].idx0, oldsuccessors[i].idx1, oldsuccessors[i].idx2})
	end
	oldsuccessors=nil
end

function deserializeNode(tbl)
	local oldsuccessors=tbl.scs
	tbl.scs={}
	
	local i
	for i=1,#oldsuccessors,1 do
		table.insert(tbl.scs, grid[oldsuccessors[i][1]][oldsuccessors[i][2]][oldsuccessors[i][3]])
	end
	oldsuccessors=nil
end

function flattenGrid()
	--rcf = row column flags, 1: new row and column, 2: new column only
	local tbl={}
	local i,j,k
	for i=1,gNumRowVertices,1 do
		for j=1,gNumColumnVertices,1 do
			for k=1,#grid[i][j],1 do
				table.insert(tbl, grid[i][j][k])
				if j==1 and k==1 then
					tbl[#tbl].rcf=1
				end
				if j~=1 and k==1 then
					tbl[#tbl].rcf=2
				end
			end
			
		end
	end	
	return tbl
end

function expandGrid(tbl)
	local grid={}
	
	local i=0
	local j=0
	local l,k
	for l=1,#tbl,1 do
		if tbl[l].rcf==1 then
			i=i+1
			j=0
			grid[i]={}
		end
		if tbl[l].rcf==2 or tbl[l].rcf==1 then
			j=j+1
			grid[i][j]={}
		end
		
		table.insert(grid[i][j], tbl[l])
		
		k=#grid[i][j]
		grid[i][j][k].idx0 = i
		grid[i][j][k].idx1 = j
		grid[i][j][k].idx2 = k
		grid[i][j][k].x=i*gGridSize+gXOffset
		grid[i][j][k].z=j*gGridSize+gZOffset
		
	end
	return grid
end

function loadNodeGrid(luafile)
	dofile(luafile)

	grid={}
	grid=expandGrid(flat_serialized_grid)
	gNumRowVertices=#grid
	gNumColumnVertices=#grid[1]

	
	for i=1,gNumRowVertices,1 do
		for j=1,gNumColumnVertices,1 do
			for k=1,#grid[i][j],1 do
				deserializeNode(grid[i][j][k])
			end	
		end
	end
	
	flat_serialized_grid =nil
end

function saveNodeGrid(luafile)
	local i,j,k
	for i=1,gNumRowVertices,1 do
		for j=1,gNumColumnVertices,1 do
			for k=1,#grid[i][j],1 do
				serializeNode(grid[i][j][k])
			end
			
		end
	end	

	local tbl=flattenGrid()
	local fil=io.open(luafile, "w")
	fil:write("flat_serialized_grid={")
	for i=1,#tbl,1 do
		fil:write("{")
		if tbl[i].rcf then
			fil:write("rcf="..tbl[i].rcf..", ")
		end
		
				--fil:write("name=\""..tbl[i].name.."\", x="..tbl[i].x..", y="..tbl[i].y..", z="..tbl[i].z..", scs={")
				--fil:write("x="..tbl[i].x..", y="..tbl[i].y..", z="..tbl[i].z..", scs={")
				fil:write("y="..tbl[i].y..", scs={")
				--write successors
				for j=1,#tbl[i].scs,1 do
					fil:write("{"..tbl[i].scs[j][1]..","..tbl[i].scs[j][2]..","..tbl[i].scs[j][3].."}")
					if j~=#tbl[i].scs then
						fil:write(",")
					end
				end
				fil:write("}}")
				--fil:write("}, icl=false, idx0="..tbl[i].idx0..", idx1="..tbl[i].idx1..", idx2="..tbl[i].idx2..", inside="..tostring(tbl[i].inside).."}")
				if i~=#tbl then
					fil:write(",")
				end
--				
	end
	fil:write("}\n--This is a serialized and flattened A* grid table")
	fil:close()
	
	tbl=nil
	
	for i=1,gNumRowVertices,1 do
		for j=1,gNumColumnVertices,1 do
			for k=1,#grid[i][j],1 do
				deserializeNode(grid[i][j][k])
			end	
		end
	end
	
end

function loadOrCreateNodeGrid(gridfile, numrows, numcolumns, xoffset, yoffset, gridsize)
	local fil=io.open(gridfile, "r")
	if fil==nil then
		createNodeGrid(numrows, numcolumns, xoffset, yoffset, gridsize)
		saveNodeGrid(gridfile)
	else
		fil:close()
		loadNodeGrid(gridfile)
	end
end

if not gGridSize then gGridSize=2 end
function setupAStarGrid()
	local sx,bx,sy,by,sz,bz=ig3d_GetMeshBounds__6f()
	
	--gNumRowVertices=200
	--gNumColumnVertices=200
	--[[
	sx=sx-gGridSize
	bx=bx+gGridSize
	sz=sz-gGridSize
	bz=bz+gGridSize
	--]]
	gNumRowVertices=math.ceil( (bx-sx)/gGridSize) +1
	gNumColumnVertices=math.ceil( (bz-sz)/gGridSize ) +1

	

	gXOffset=math.floor(sx/gGridSize)*gGridSize---1 --new adaptive grid should work a lot better
	gZOffset=math.floor(sz/gGridSize)*gGridSize---1 --new adaptive grid should work a lot better

	
	--need to put objects out of interesting area, so that they dont confuse the ray scanner for node creation
	for i=1,#gObjects,1 do
		x,y,z=getObjectInfo(gObjects[i].cObj, IG3D_POSITION)
		setObjectInfo(gObjects[i].cObj, IG3D_POSITION, x,y-1000,z)
	end
	
	--createNodeGrid(gNumRowVertices, gNumColumnVertices, gXOffset, gZOffset, gGridSize)
	loadOrCreateNodeGrid(gameroot..ig3d_GetLevelName__s().."/AStarGrid.lua", gNumRowVertices, gNumColumnVertices, gXOffset, gZOffset, gGridSize)
	
	--reset object positions
	for i=1,#gObjects,1 do
		x,y,z=getObjectInfo(gObjects[i].cObj, IG3D_POSITION)
		setObjectInfo(gObjects[i].cObj, IG3D_POSITION, x,y+1000,z)
	end
end

function reachableFromPosition(sx,sy,sz, dx,dy,dz)
	local waste,success=generateAStarPathBetweenPositions(nil, sx,sy,sz, dx,dy,dz, 0)
	return success
end


function drawGridVertices()
	for i=1,gNumRowVertices,1 do
		for j=1,gNumColumnVertices,1 do
			drawVertex(grid[i][j][1].x,grid[i][j][1].y,grid[i][j][1].z)
		end
	end
end