Imgs = {}
function Img(path)
	r = Imgs[path]
	if r == nil then
		print("loading", path)
		r = love.graphics.newImage( path )
		Imgs[path]=r
	end
	return r
end

function NewClass()
	c = {}
	c.__index = c
	return c
end

function NewInstance(c)
	return setmetatable({}, c);
end

function Trim(s)
	return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function GetTokens(line)
	local r = {}
	for token in string.gmatch(line, "[^%s]+") do
		table.insert(r, token)
	end
	return r
end

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

function Part:draw()
	love.graphics.line(self.cont)
end

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

function Level:draw(lvl)
	for i,p in ipairs(self.parts) do
		p:draw()
	end
end

function love.load()
	bkg = Img( "bkg.png" )
	img = Img( "awesome.png" )
	--img2 = Img( "awesome.png" )

	lines = { 10,10, 20,10, 10,20 }
	lvl = Level:new("levels/test.lvl");
end

function love.draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(bkg, 0, 0)
	love.graphics.print("Hello World", 400, 300)
	love.graphics.draw(img, 20, 20)
	
	love.graphics.setColor(0, 0, 0)
	lvl:draw()
end