pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- wire world ∧
-- by wahtzy 😐

res = 4
rows = 0
cols = 0

empty = 1
head = 12
tail = 8
cond = 10
blink = 7

cursor_x = 0
cursor_y = 0
cursor_c = 1

play = true

na = {}
ca = {}

function _init()
	rectfill(0,0,127,127,empty)
	rows = 128 / res
	cols = 128 / res
	ca = cellarray()
	
	ca[2][1] = cond
	ca[3][1] = cond
	ca[4][1] = cond
	
	ca[2][5] = cond
	ca[3][5] = cond
	ca[4][5] = cond
	
	ca[1][2] = cond
	ca[1][3] = cond
	ca[1][4] = cond

	ca[5][2] = cond
	ca[5][3] = cond
	ca[5][4] = cond
	
	ca[1][2] = head
	ca[1][3] = tail
	
	draw_array(ca)
end

function _update()
	if play then
		if btnp(0) and btnp(1) then
			play = false
		end
	else
		if btnp(0) and btnp(1) then
			play = true
			draw_array(ca)
		else
			cursor_ctrl()
		end
	end
end

function _draw()
	if play then
		na = neighborarray()
		
		for x=0,cols do
			for y=0,rows do
				c = get_cell(x,y)
				if c == head then
					draw_cell(x,y,tail)
				elseif c == tail then
					draw_cell(x,y,cond)
				elseif c == cond then
					if na[x][y] >= 1 and
								na[x][y] <= 2 then
						
						draw_cell(x,y,head)
								
					end
				end
			end
		end
	else
		draw_array(ca)
		draw_cursor()
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

function cellarray()
	a={}

	for x=0,cols do
		a[x] = {}
		for y=0,rows do
			a[x][y] = empty
		end
	end
	
	return a
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
						and get_cell(c,r) == head
						then
				
				sum += 1
				
			end	
		end
	end
	
	return sum
end
-->8
-- cursor controls

function cursor_ctrl()
	if (btnp(0)) cursor_x -= 1
	if (btnp(1)) cursor_x += 1
	if (btnp(2)) cursor_y -= 1
	if (btnp(3)) cursor_y += 1
	
	if (btnp(4)) ca[cursor_x][cursor_y] = get_color(cursor_c)
	if (btnp(5)) then
		cursor_c += 1
		cursor_c = cursor_c % 4
	end
		
end

function get_color(n)

	if (n == 0) return empty
	if (n == 1) return cond
	if (n == 2) return head
	if (n == 3) return tail

end

function draw_cursor()
	draw_cell(cursor_x,cursor_y,get_color(cursor_c))
end
