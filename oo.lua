-- http://lua-users.org/wiki/InheritanceTutorial

function NewClass()
	c = {}
	c.__index = c
	return c
end

function InheritsFrom(baseClass)
	-- The following lines are equivalent to the SimpleClass example:
	-- Create the table and metatable representing the class.
	local new_class = {}
	local class_mt = { __index = new_class }

	-- Note that this function uses class_mt as an upvalue, so every instance
	-- of the class will share the same metatable.
	function new_class:create(base)
		local newinst = base
		setmetatable( newinst, class_mt )
		return newinst
	end

	if baseClass then
		setmetatable( new_class, { __index = baseClass } )
	end

	return new_class
end

function NewInstance(c)
	return setmetatable({}, c);
end