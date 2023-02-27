pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- lorenz attractor
-- by wahtzy 😐

x = 0.1
y = 0.1
z = 0.1

a = 10
b = 8/3
c = 28

scale = 2

function _init()
	cls()
	rectfill(0,0,127,127,1)

end

function _draw()
	--rectfill(0,0,127,127,1)
	dt = 0.01
	dx = (a * (y - x)) * dt
	dy = (x * (c - z) - y) * dt
	dz = (x * y - b * z) * dt
	
	x += dx
	y += dy
	z += dz
	
	pset((x*scale)+64,(y*scale)+64,8)
end
