vec = NewClass()

function vec:new(x,y)
	local v = NewInstance(vec)
	v.x,v.y = x,y
	return v
end

function vec:length()
	return math.sqrt(self.x * self.x + self.y*self.y)
end

function vec:Distance(a,b)
	return vec:FromTo(a,b):length()
end

function vec:FromTo(a,b)
	return vec:new(a.x-b.x, a.y-b.y)
end