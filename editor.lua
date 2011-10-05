require 'radial.lua'

function editor_load()
	editor = {}
	editor.r = false
	editor.RA = 50
end

function editor_draw(lvl)
	lvl:draw()
	if editor.r then
		local r = Radial:new(editor.x,editor.y, editor.RA)
		if r:within(love.mouse.getPosition()) then
			love.graphics.setColor(0, 0, 0, 255)
		else
			love.graphics.setColor(0, 0, 0, 100)
		end
		love.graphics.circle("fill", editor.x, editor.y, r.r)
		
		local r = Radial:new(editor.x,editor.y, editor.RA)
		local x,y = love.mouse.getPosition()
		love.graphics.setColor(0, 0, 255)
		love.graphics.print(r:angle(love.mouse.getPosition()), x, y+15)
	end
end

function editor_update(lvl, dt)
	if editor.r == false then
		editor.x,editor.y = love.mouse.getPosition()
	end
end

function editor_mousepressed(lvl, x,y,button)
	if button == "r" then
		editor.r = true
	end
	editor.x,editor.y = x,y
end

function editor_mousereleased(lvl, x,y,button)
	if button == "r" then
		local r = Radial:new(editor.x,editor.y, editor.RA)
		if r:within(x,y) then
			print("within", r:angle(x,y))
		end
		editor.r = false
	end
	editor.x,editor.y = x,y
end