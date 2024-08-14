local wavefrontOBJ = require(script.Parent.readers.wavefrontOBJ)
local types = require(script.Parent.types)

local function generateEditableMesh(file: buffer, fileFormat: types.MeshFileFormat): EditableMesh
	if fileFormat == "WavefrontOBJ" then
		return wavefrontOBJ.toEditableMesh(file)
	end

	error(`invalid file format: {fileFormat}`)
end

return generateEditableMesh
