require 'radial.lua'

function editor_load()
	editor = {}
	editor.r = false
	editor.points = {}
	editor.RA = 70
end

function editor_draw(lvl)
	lvl:draw()
	love.graphics.setColor(0, 0, 0)
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
	love.graphics.print("[EDITOR ENABLED]", 10, 10)
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
			lvl:createPhysics()
		end
		editor.r = false
	end
	editor.x,editor.y = x,y
end

function editor_keyreleased(lvl, key)
	if key == " " then
		editor.points = {}
	end
	if key == "return" then
		lvl:add(Part:FromPoints(editor.points))
		editor.points = {}
		lvl:createPhysics()
	end
	if key == "backspace" then
		if #editor.points >=2 then
			editor.points[#editor.points] = nil
			editor.points[#editor.points] = nil
		end
	end
end