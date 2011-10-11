require 'level.lua'
require 'editor.lua'
require 'img.lua'
require 'object.lua'
require 'grab.lua'

DISTANCE = 120
FORCE = 15

function love.load()
	bkg = Img( "bkg.png" )

	lines = { 10,10, 20,10, 10,20 }
	lvl = Level:new("levels/test.lvl");
	editor_load()
	useEditor = false
	useForce = false
	shiftIsDown = false
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

function handleKey(key, down)
	--print("handle key: ", key, down)
	if key=="lshift" then
		shiftIsDown = down
	elseif key == "x2" then
		useForce = down
	end
end

function love.update(dt)
	if useEditor then
		editor_update(lvl, dt)
	else
		lvl:update(dt)
		if useForce then
			local x, y = love.mouse.getPosition()
			lvl:force(x,y,shiftIsDown==false,DISTANCE,FORCE)
		end
	end
end

function love.mousepressed(x, y, button)
	if useEditor then
		editor_mousepressed(lvl, x,y,button)
	else
		handleKey(button,true)
	end
end

function love.mousereleased(x, y, button)
	if useEditor then
		editor_mousereleased(lvl, x,y,button)
	else
		if button == "l" then
			Object:new(lvl, x,y,10,"awesome.png")
		elseif button == "r" then
			lvl:bomb(x,y,shiftIsDown,DISTANCE,FORCE)
		elseif button == "x1" then
			Grab:new(lvl, x, y)
		else
			handleKey(button,false)
		end
	end
end

function love.keyreleased(key)
	if key == "f1" then
		useEditor = useEditor~=true
	elseif useEditor then
		editor_keyreleased(lvl, key)
	else
		handleKey(key,false)
	end
end

function love.keypressed(key)
	if useEditor==false then
		handleKey(key,true)
	end
end