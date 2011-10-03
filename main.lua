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

function CreatePart(info)
	print(info)
	local p = {}
	tokens = GetTokens(info)
	local c=0
	for i,s in ipairs(tokens) do
		table.insert(p, tonumber(s))
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

function DrawPart(p)
	love.graphics.line(p)
end

function LoadLevel(path)
	local l = {}
	
	print("loading", path)
	
	for line in love.filesystem.lines(path) do
		table.insert(l, CreatePart(line))
	end
	
	return l
end

function DrawLevel(lvl)
	for i,p in ipairs(lvl) do
		DrawPart(p)
	end
end

function LoadLevel(path)
	local l = {}
	
	print("loading", path)
	
	for line in love.filesystem.lines(path) do
		table.insert(l, CreatePart(line))
	end
	
	return l
end

function love.load()
	bkg = Img( "bkg.png" )
	img = Img( "awesome.png" )
	--img2 = Img( "awesome.png" )

	lines = { 10,10, 20,10, 10,20 }
	lvl = LoadLevel("levels/test.lvl");
end

function love.draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(bkg, 0, 0)
	love.graphics.print("Hello World", 400, 300)
	love.graphics.draw(img, 20, 20)
	
	love.graphics.setColor(0, 0, 0)
	DrawLevel(lvl)
end