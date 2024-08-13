local OBJ = require(script.readers.OBJ)
local types = require(script.types)

export type MeshReader = types.MeshReader

return {
	OBJ = OBJ,
}
