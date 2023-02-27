pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- brians brain 웃
-- by wahtzy 😐

res = 4
rows = 128 / res
cols = 128 / res

dead = 1
alive = 7
dying = 12

na = {}
ca = {}

function _init()
	rectfill(0,0,127,127,dead)
	offset = flr(cols/4)
	for x=0,flr(cols/2) do
		for y=0,flr(rows/2) do
			if (flr(rnd(3)) == 1) then
				draw_cell(x+offset,y+offset,alive)
			end
		end
	end
end

function _draw()
	na = neighborarray()
	
	for x=0,cols do
		for y=0,rows do
			c = get_cell(x,y)
			if c == dying then
				draw_cell(x,y,dead)
			elseif c == alive then
				draw_cell(x,y,dying)
			elseif c == dead then
				if	na[x][y] == 2 then
					
					draw_cell(x,y,alive)
							
				end
			end
		end
	end
end
-->8
-- cell control

function draw_cell(x,y,t)
	x1 = x * res
	y1 = y * res
	
	rectfill(x1,y1,x1+res-1,y1+res-1,t)
end

function get_cell(x,y)
	x1 = x * res
	y1 = y * res
	
	return pget(x1,y1)
end

function currentarray()
	a = {}
	
	for x=0,cols do
		a[x] = {}
		for y=0,rows do
			a[x][y] = get_cell(x,y)
		end
	end

	return a
end

function draw_array(a)
	for x=0,cols do
		for y=0,rows do
			draw_cell(x,y,a[x][y])
		end
	end
end
-->8
-- neighbors

function neighborarray()
	a = {}

	for x=0,cols do
		a[x] = {}
		for y=0,rows do
			a[x][y] = getneighbors(x,y)
		end
	end

	return a
end

function getneighbors(x,y)
	sum = 0
	
	for i=-1,1 do
		for j=-1,1 do
			c = (x + i + cols) % cols
			r = (y + j + rows) % rows
			
			if (i != 0 or j != 0)
						and get_cell(c,r) == alive
						then
				
				sum += 1
				
			end	
		end
	end
	
	return sum
end
