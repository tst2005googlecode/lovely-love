require 'oo.lua'
require 'part.lua'

Level = NewClass()

function Level:new(path)
	local l = NewInstance(Level)
	l.parts = {}
	
	print("loading", path)
	
	for line in love.filesystem.lines(path) do
		table.insert(l.parts, Part:new(line))
	end
	
	return l
end

function Level:add(part)
	table.insert(self.parts, part)
end

function Level:draw(lvl)
	for i,p in ipairs(self.parts) do
		p:draw()
	end
end