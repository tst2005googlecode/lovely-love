require 'radial.lua'

function editor_load()
	editor = {}
	editor.r = false
	editor.points = {}
	editor.RA = 70
end

function editor_draw(lvl)
	lvl:draw()
	if #editor.points >= 4 then
		love.graphics.line(editor.points)
	end
	if #editor.points >= 2 then
		for i=1, #editor.points,2 do
			love.graphics.setPointSize( 5 )
		  love.graphics.point(editor.points[i], editor.points[i+1])
	   end
	end
	if editor.r then
		local r = Radial:new(editor.x,editor.y, editor.RA)
		if r:within(love.mouse.getPosition()) then
			love.graphics.setColor(0, 0, 0, 255)
		else
			love.graphics.setColor(0, 0, 0, 100)
		end
		love.graphics.circle("fill", editor.x, editor.y, r.r, 20)
	end
end

function editor_update(lvl, dt)
	if editor.r == false then
		editor.x,editor.y = love.mouse.getPosition()
	end
end

function editor_mousepressed(lvl, x,y,button)
	if button == "l" then
		table.insert(editor.points, x)
		table.insert(editor.points, y)
	end
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