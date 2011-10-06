require 'oo.lua'

Radial = NewClass()

function Radial:new(x,y,ra)
	r = NewInstance(Radial)
	r.r = ra
	r.x,r.y = x,y
	return r
end

function Radial:within(x,y)
	local dx,dy = x-r.x,y-r.y
	local d = dx*dx+dy*dy
	return d < r.r*r.r
end

function Radial:angle(x,y)
	local dx,dy = x-r.x,r.y-y
	local d = dx*dx+dy*dy
	d = math.sqrt(d)
	local a = math.asin(dy/d)
	local b = math.asin(dx/d)
	
	a = (a * 360) / (2* math.pi)
	if dx < 0 then
		a = 180 -a
	end
	if dy <= 0 and dx >= 0 then
		a = 360 + a
	end
	if a == 360 then
		a = 0
	end
	return a
end