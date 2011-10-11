require 'oo.lua'
require 'object.lua'

Grab = InheritsFrom(Object)

function Grab:new(world, x,y)
	r= Grab:create()
	r:setup(world, x,y, 25, "grab.png")
	return r
end

function Grab:update(world, delta)
	Object.update(self, world, delta)
	world:force(self.x, self.y, false, 50, 10, self.body)
end