gRoadNames={"Otto-Hahn-Strasse","Vogelpothsweg","Baroper Strasse","Dahmsfeldstrasse","Rutschweg","Uhugasse","Kuckuck-Allee","Taubenstrasse","Bartgeierweg","Kolibristrasse","Kohlmeisenheide","Rotkehlchenweg"}


gRoads={}
--road type 1: east-west, type 2: north-south
rdidx=math.random(1,#gRoadNames)
rdnm=gRoadNames[rdidx]
table.remove(gRoadNames, rdidx)
table.insert(gRoads, {name=rdnm, type=1, offset=6, startCoord=20, endCoord=-72, numAddresses=6})
rdidx=math.random(1,#gRoadNames)
rdnm=gRoadNames[rdidx]
table.remove(gRoadNames, rdidx)
table.insert(gRoads, {name=rdnm, type=1, offset=-14, startCoord=20, endCoord=-72, numAddresses=6})
rdidx=math.random(1,#gRoadNames)
rdnm=gRoadNames[rdidx]
table.remove(gRoadNames, rdidx)
table.insert(gRoads, {name= rdnm, type=2, offset=22, startCoord=24, endCoord=-32, numAddresses=4})
rdidx=math.random(1,#gRoadNames)
rdnm=gRoadNames[rdidx]
table.remove(gRoadNames, rdidx)
table.insert(gRoads, {name= rdnm, type=2, offset=-2, startCoord=24, endCoord=-32, numAddresses=4})
rdidx=math.random(1,#gRoadNames)
rdnm=gRoadNames[rdidx]
table.remove(gRoadNames, rdidx)
table.insert(gRoads, {name= rdnm, type=2, offset=-26, startCoord=24, endCoord=-32, numAddresses=4})
rdidx=math.random(1,#gRoadNames)
rdnm=gRoadNames[rdidx]
table.remove(gRoadNames, rdidx)
table.insert(gRoads, {name= rdnm, type=2, offset=-50, startCoord=24, endCoord=-32, numAddresses=4})
rdidx=math.random(1,#gRoadNames)
rdnm=gRoadNames[rdidx]
table.remove(gRoadNames, rdidx)
table.insert(gRoads, {name= rdnm, type=2, offset=-74, startCoord=24, endCoord=-32, numAddresses=4})

function getNearestRoad(x,y,z)
	local dst=-1
	local whichRoad=1
	for i=1,#gRoads,1 do
		if gRoads[i].type==1 then
			if dst==-1 or math.abs(z-gRoads[i].offset)<dst then
				dst=math.abs(z-gRoads[i].offset)
				whichRoad=i
			end
		end
		if gRoads[i].type==2 then
			if dst==-1 or math.abs(x-gRoads[i].offset)<dst then
				dst=math.abs(x-gRoads[i].offset)
				whichRoad=i
			end
		end
	end
	
	return gRoads[whichRoad]
end