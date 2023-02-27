pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
x = 128/2 -1
y = 128/2 -1

global = {}
global.gravity = 0.3
global.maxgrav = 3

cls()

function _init()
	player = make_player(x,y)

end

function _update()
	player_update(player)
end

function _draw()
	rectfill(0,0,127,127,0)
	player_draw(player)
end

-->8
function make_player(x,y)
	local pl = make_actor(x,y)
	return pl
end

function player_update(pl)
	right = 0
	left = 0
	if (btn(0)) left = 1
	if (btn(1)) right = 1
	
	if (btnp(4)) then
		pl.vsp = -pl.maxjspd
	end
	
	mov = -left + right
	pl.hsp = mov * pl.speed

	-- gravity
	if (pl.vsp < global.maxgrav) then
		pl.vsp += global.gravity
	end

	if (pl.y + pl.vsp > 127) then
		while (pl.y + 1 < 127) do
			pl.y += 1
		end
		pl.vsp = 0
		pl.ground = true
	end

	pl.x += pl.hsp
	pl.y += pl.vsp
end

function player_draw(pl)
	circfill(pl.x,pl.y,5,8)
end
-->8
function make_actor(x,y)
	local a = {}
	a.h = 5
	a.w = 5
	a.life = 1
	a.speed = 2
	a.hsp = 0
	a.vsp = 0
	a.jumping = false
	a.jmpspeed = 5
	a.maxjspd = 3
	a.x = x a.y = y
	a.ground = false
	return a
end
-->8

