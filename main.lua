require 'level.lua'
require 'editor.lua'
require 'img.lua'

function love.load()
	bkg = Img( "bkg.png" )
	img = Img( "awesome.png" )
	--img2 = Img( "awesome.png" )

	lines = { 10,10, 20,10, 10,20 }
	lvl = Level:new("levels/test.lvl");
	editor_load()
end

function love.draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(bkg, 0, 0)
	love.graphics.print("Hello World", 400, 300)
	love.graphics.draw(img, 20, 20)
	
	love.graphics.setColor(0, 0, 0)
	editor_draw(lvl)
end

function love.update(dt)
	editor_update(lvl, dt)
end
function love.mousepressed(x, y, button)
	editor_mousepressed(lvl, x,y,button)
end
function love.mousereleased(x, y, button)
	editor_mousereleased(lvl, x,y,button)
end