require 'oo.lua'
require 'part.lua'

Level = NewClass()

function Level:new(path)
	local l = NewInstance(Level)
	l.parts = {}
	
	print("loading", path)
	
	--for line in love.filesystem.lines(path) do
	--	table.insert(l.parts, Part:new(line))
	--end
	
	print "done parsing"
	l.objects = {}
	l:createPhysics()
	
	return l
end

function Level:add(part)
	table.insert(self.parts, part)
end

function Level:addObject(o)
	table.insert(self.objects, o)
end

function Level:draw()
	for i,p in ipairs(self.parts) do
		p:draw()
	end
	
	for i,o in ipairs(self.objects) do
		o:draw()
	end
end

function Level:update(delta)
	self.physics:update(delta)
	for i,o in ipairs(self.objects) do
		o:update(delta)
	end
end

function Level:createPhysics()
	local h,w = 800,600
	print "creating world physics"
	self.physics = love.physics.newWorld(-w,-h, w, h, 0, 400, true)
	print "starting parts"
	for i,p in ipairs(self.parts) do
		print "creating object"
		p:createPhysics(self.physics)
	end
	print "creating objects"
	for i,o in ipairs(self.objects) do
		o:createPhysics(self.physics)
	end
	print "done"
end