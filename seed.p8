pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- seed
-- by wahtzy 😐

randomize = false

res = 2
col = 0
row = 0
front = 8
back = 1

na = {}

function _init()
	col = flr(128 / res)
	row = flr(128 / res)
	if randomize then
		newfieldrand()
	else
		rectfill(0,0,127,127,back)
		x = flr(col/2)
		y = flr(row/2)
		draw_cell(x,y,true)
		draw_cell(x+1,y,true)
		draw_cell(x,y+1,true)
	end
end

function _update()
	if btn(4) then
		newfieldrand()
	end
end

function _draw()
	
	na = getneigborarray()
	
	for x=0, col, 1 do
		for y=0, row, 1 do
		 if not get_cell(x,y)
		 			and na[x][y] == 2 
		  		then
		  
		  draw_cell(x,y,true)
		 	
		 else			
		 	draw_cell(x,y,false)
		 
		 end
			
		end
	end
end
-->8
-- array functions
function newfieldrand()
	rectfill(0,0,127,127,back)
	for x=0, col, 1 do
		for y=0, row, 1 do
			if flr(rnd(3)) == 1 then
				draw_cell(x,y,true)				
			end
		end
	end
end

function getneigborarray()
	a={}
	for x=0,col,1 do
		a[x] = {}
		for y=0,row,1 do
			a[x][y] = countneighbor(x,y)
		end
	end
	return a
end
-->8
-- neighbor check

function countneighbor(x,y)
	sum = 0
	
	for i=-1,1 do
		for j=-1,1 do
		
			c = (x+i+col) % col
			r = (y+j+row) % row
		
			if (i!=0 or j!=0)
						and get_cell(c,r)
						then
				
				sum += 1
				
			end
		end
	end
		
	
	
	return sum
end
-->8
-- cell control

function draw_cell(x,y,l)
	x1 = x * res
	y1 = y * res
	if l then
		rectfill(x1,y1,x1+res-1,y1+res-1,front)
	else
		rectfill(x1,y1,x1+res-1,y1+res-1,back)
	end
end

function get_cell(x,y)
	x1 = x * res
	y1 = y * res
	
	if pget(x1,y1) == front then
		return true
	else
	 return false
	end

end
