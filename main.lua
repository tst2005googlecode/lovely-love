require 'level.lua'

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