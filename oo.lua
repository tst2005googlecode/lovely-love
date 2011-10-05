function NewClass()
	c = {}
	c.__index = c
	return c
end

function NewInstance(c)
	return setmetatable({}, c);
end