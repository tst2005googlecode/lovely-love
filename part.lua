require 'oo.lua'
require 'strings.lua'

Part = NewClass()

function Part:new(info)
	local p = NewInstance(Part)
	p.cont = {}
	tokens = GetTokens(info)
	local c=0
	for i,s in ipairs(tokens) do
		table.insert(p.cont, tonumber(s))
		c = c+1
	end
	if c<6 then
		error("Invalid line, to few arguments(" .. c .. ") " .. info)
	end
	if c%2 ~= 0 then
		error("Invalid line, odd number of arguments(" .. c .. ") " .. info)
	end
	return p
end

function Part:FromPoints(c)
	local p = NewInstance(Part)
	p.cont = c
	return p
end

function Part:draw()
	love.graphics.line(self.cont)
end