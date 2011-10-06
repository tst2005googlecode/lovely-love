require 'oo.lua'
require 'part.lua'
require 'vec.lua'

Level = NewClass()

function Level:new(path)
	local l = NewInstance(Level)
	l.parts = {}
	
	print("loading", path)
	
	--for line in love.filesystem.lines(path) do
	--	table.insert(l.parts, Part:new(line))
	--end
	
	print "done parsing"
	l.objects = {}
	l:createPhysics()
	
	return l
end

function Level:add(part)
	table.insert(self.parts, part)
end

function Level:addObject(o)
	table.insert(self.objects, o)
end

function Level:draw()
	for i,p in ipairs(self.parts) do
		p:draw()
	end
	
	for i,o in ipairs(self.objects) do
		o:draw()
	end
end

function Level:update(delta)
	self.physics:update(delta)
	for i,o in ipairs(self.objects) do
		o:update(delta)
	end
end

function Level:createPhysics()
	local h,w = 800,600
	print "creating world physics"
	self.physics = love.physics.newWorld(-w,-h, w, h, 0, 400, true)
	print "starting parts"
	for i,p in ipairs(self.parts) do
		print "creating object"
		p:createPhysics(self.physics)
	end
	print "creating objects"
	for i,o in ipairs(self.objects) do
		o:createPhysics(self.physics)
	end
	print "done"
end

function Level:bomb(x,y,doSuction,maxDistance, maxForce)
	--local maxDistance = 9 -- In your head don't forget this number is low because we're multiplying it by 32 pixels
	--local maxForce = 22
	--doSuction = true --Very cool looking implosion effect instead of explosion
	local pos = vec:new(x,y)
	local PTM_RATIO = 1
	--In Box2D the bodies are a linked list, so keep getting the next one until it doesn't exist.
	for i,o in ipairs(self.objects) do
		--Box2D uses meters, there's 32 pixels in one meter. PTM_RATIO is defined somewhere in the class.
		local b2TouchPosition = vec:new(pos.x/PTM_RATIO, pos.y/PTM_RATIO)
		local b2BodyPosition = vec:new(o.x, o.y)

		--Don't forget any measurements always need to take PTM_RATIO into account
		local distance -- Why do i want to use CGFloat vs float - I'm not sure, but this mixing seems to work fine for this little test.
		local strength
		local force
		local angle

		if doSuction then -- To go towards the press, all we really change is the atanf function, and swap which goes first to reverse the angle
			-- Get the distance, and cap it
			distance = vec:Distance(b2BodyPosition, b2TouchPosition)
			if distance > maxDistance then
				distance = maxDistance - 0.01
			end
			-- Get the strength
			--strength = distance / maxDistance -- Uncomment and reverse these two. and ones further away will get more force instead of less
			strength = (maxDistance - distance) / maxDistance -- This makes it so that the closer something is - the stronger, instead of further
			force  = strength * maxForce

			-- Get the angle
			angle = math.atan2(b2TouchPosition.y - b2BodyPosition.y, b2TouchPosition.x - b2BodyPosition.x)
			-- Apply an impulse to the body, using the angle
			o:ApplyImpulse(vec:new(math.cos(angle) * force, math.sin(angle) * force), o.x,o.y)
		else
			distance = vec:Distance(b2BodyPosition, b2TouchPosition)
			if distance > maxDistance then
				distance = maxDistance - 0.01
			end

			-- Normally if distance is max distance, it'll have the most strength, this makes it so the opposite is true - closer = stronger
			strength = (maxDistance - distance) / maxDistance -- This makes it so that the closer something is - the stronger, instead of further
			force = strength * maxForce
			angle = math.atan2(b2BodyPosition.y - b2TouchPosition.y, b2BodyPosition.x - b2TouchPosition.x)
			-- Apply an impulse to the body, using the angle
			o:ApplyImpulse(vec:new(math.cos(angle) * force, math.sin(angle) * force), o.x, o.y)
		end
	end
end