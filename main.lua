require 'level.lua'
require 'editor.lua'
require 'img.lua'
require 'object.lua'

function love.load()
	bkg = Img( "bkg.png" )

	lines = { 10,10, 20,10, 10,20 }
	lvl = Level:new("levels/test.lvl");
	editor_load()
	useEditor = false
end

function love.draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(bkg, 0, 0)
	
	love.graphics.setColor(0, 0, 0)
	if useEditor then
		editor_draw(lvl)
	else
		lvl:draw()
	end
end

function love.update(dt)
	if useEditor then
		editor_update(lvl, dt)
	else
		lvl:update(dt)
	end
end

function love.mousepressed(x, y, button)
	if useEditor then
		editor_mousepressed(lvl, x,y,button)
	end
end

function love.mousereleased(x, y, button)
	if useEditor then
		editor_mousereleased(lvl, x,y,button)
	else
		if button == "l" then
			Object:new(lvl, x,y,10,"awesome.png")
		end
	end
end

function love.keyreleased(key)
	if key == "f1" then
		useEditor = useEditor~=true
	elseif useEditor then
		editor_keyreleased(lvl, key)
	end
end