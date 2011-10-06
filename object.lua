require 'oo.lua'
require 'img.lua'

Object = NewClass()

function Object:new(world, x,y,radius,img)
	local b = NewInstance(Object)
	b.body = love.physics.newBody(world.physics, x,y, 15)
	love.physics.newCircleShape(b.body, 0, 0, radius )
	b.radius = radius
	b.body:setMassFromShapes()
	b.img = Img(img)
	world:addObject(b)
	return b
end

function Object:update(delta)
end

function Object:draw()
	local x,y = self.body:getPosition()
	local a = self.body:getAngle()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.img, x-10,y-10,angle)
	if self.body:isSleeping() then
		love.graphics.setColor(0, 255, 0, 100)
	else
		love.graphics.setColor(255, 0, 0, 100)
	end
	love.graphics.circle("fill", x, y, self.radius)
end