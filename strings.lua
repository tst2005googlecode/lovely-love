function Trim(s)
	return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function GetTokens(line)
	local r = {}
	for token in string.gmatch(line, "[^%s]+") do
		table.insert(r, token)
	end
	return r
end