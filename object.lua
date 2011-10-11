require 'oo.lua'
require 'img.lua'

Object = NewClass()

function Object:new(world, x,y,radius,img)
	local b = NewInstance(Object)
	b.radius = radius
	b.img = Img(img)
	b.x,b.y = x,y
	b:createPhysics(world.physics)
	world:addObject(b)
	return b
end

function Object:update(delta)
	self.x,self.y = self.body:getPosition()
end

function Object:draw()
	local a = self.body:getAngle()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.img, self.x-10,self.y-10,angle)
	if self.body:isSleeping() then
		love.graphics.setColor(0, 255, 0, 100)
	else
		love.graphics.setColor(255, 0, 0, 100)
	end
	love.graphics.circle("fill", self.x, self.y, self.radius)
end

function Object:createPhysics(world)
	self.body = love.physics.newBody(world, self.x,self.y, 15, 12)
	love.physics.newCircleShape(self.body, 0, 0, self.radius )
	self.body:setMassFromShapes()
end

function Object:applyImpulse(p,x,y)
	self.body:applyImpulse(p.x,p.y,x,y)
end
function Object:applyForce(p,x,y)
	self.body:applyForce(p.x,p.y,x,y)
end