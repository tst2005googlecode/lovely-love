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