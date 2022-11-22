rndseed=math.randomseed(os.time())rnd=math.random(1,os.time())


-- "return true if x,y inside of rectangle"
function insideRECT(locx,locy,Left,Top,Right,Bottom)
result=0
if locx >= Left and locx <= Right then result=result+1  end
if locy >= Top and locy <= Bottom then result=result+1  end
if result==2 then 
return true
end
end

-- rnd="random number from lowest to highest"
function rnd(lo,hi)output(lo,hi)result=math.random(lo,hi)end 


function getrandthree()
a=math.random(1,3)-2b=math.random(1,3)-2c=math.random(1,3)-2
return a,b,c
end


function threerandom()
result=commaDelItems(getrandthree())
return result
end

function rndlist(steps,div)
for cnt=1,steps,div do print(threerandom()) end
end

m=rndlist(10,2)