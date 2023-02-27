pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- snek ██████😐 ●
-- by wahtzy 😐

res = 8
cols = flr(128 / res)
rows = flr(128 / res)

speed = 5

back = 15
apple = 8

two_player = false
snake1 = {}
snake2 = {}

food_a = {}

counter = 0
function _init()
	if two_player then
		snake2 = new_snake(0,0,1)
	end
	snake1 = new_snake(0,0,0)
	add(food_a,new_apple())
end

function _update()
	if two_player then
		control_snake(snake2)
	end
	control_snake(snake1)
	
	update_food(food_a)
	
	if counter % speed == 0 then
		if two_player then
			move_snake(snake2)
		end
 	move_snake(snake1)
	end
	counter += 1
end

function _draw()
	rectfill(0,0,127,127,back)
	draw_snake(snake1)
	draw_food(food_a)
end
-->8
-- map
function draw_cell(x,y,c)
	x1 = x * res
	y1 = y * res
	rectfill(x1,y1,x1+res-1,y1+res-1,c)
end
-->8
-- snake
function new_snake(x,y,p)
	snake = {}
	snake.x = x
	snake.y = y
	snake.body = {}
	snake.len = 3
	snake.direction = 1
	snake.col = 12
	
	for i=0,snake.len-1 do
		snake.body[i] = new_body(x,y)
	end

	return snake
end

function new_body(x,y)
	body = {}
	body.x = x
	body.y = y
end

function grow_snake(snake)

	snake.len += 1
	

end

function control_snake(snek)
	if (btnp(0,snek.p)) snek.direction = 3
	if (btnp(1,snek.p)) snek.direction = 1
	if (btnp(2,snek.p)) snek.direction = 0
	if (btnp(3,snek.p)) snek.direction = 2
end

function move_snake(snek)
	if (snek.direction == 0) snek.y -= 1
	if (snek.direction == 1) snek.x += 1
	if (snek.direction == 2) snek.y += 1
	if (snek.direction == 3) snek.x -= 1
	
	snek.x = (snake.x + cols) % cols
	snek.y = (snake.y + rows) % rows
end

function draw_snake(snake)
	draw_cell(snake.x,snake.y,snake.col)
end
-->8
-- apples ●
function new_apple()
		a = {}
		a.x = flr(rnd(cols))
		a.y = flr(rnd(rows))
		return a
end

function update_food(a)
	for item in all(a) do
		if snake1.x == item.x and
					snake1.y == item.y then
			-- eat apple
			grow_snake(snake1)
			new_apple()
		end
		if snake2.x == item.x and
					snake2.y == item.y then
					
			grow_snake(snake2)
			new_apple()
				
		end
	end
end

function draw_food(a)
	for item in all(a) do
		draw_cell(item.x,item.y,apple)
	end
end
