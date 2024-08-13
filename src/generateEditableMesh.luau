local WavefrontOBJ = require(script.Parent.readers.WavefrontOBJ)
local types = require(script.Parent.types)

local function generateEditableMesh(file: buffer, fileFormat: types.MeshFileFormat): EditableMesh
	if fileFormat == "WavefrontOBJ" then
		return WavefrontOBJ.toEditableMesh(file)
	end

	error(`invalid file format: {fileFormat}`)
end

return generateEditableMesh
