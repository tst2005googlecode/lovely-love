require 'oo.lua'
require 'object.lua'

Grab = InheritsFrom(Object)

function Grab:new(world, x,y)
	r= Grab:create(Grab, Object:new(world, x,y, 25, "grab.png"))
	return r
end

function Grab:update(world, delta)
	Object:update(self, world, delta)
end