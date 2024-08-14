export type OpCode = "#" | "v" | "vt" | "vn" | "f"

local ERROR_CORRUPTION = "Wavefront OBJ file is corrupted"

local function toEditableMesh(file: buffer): EditableMesh
	local fileString = buffer.tostring(file)
	local editableMesh = Instance.new("EditableMesh")

	local vertices = {} :: { number }
	local normals = {} :: { number }

	for line in fileString:gmatch("[^\r\n]+") do
		local arguments = line:gsub("%s+", " "):split(" ")
		local opcode = arguments[1] :: OpCode

		if opcode == "#" then
			continue
		elseif opcode == "v" then
			local x = tonumber(arguments[2])
			local y = tonumber(arguments[3])
			local z = tonumber(arguments[4])

			assert(x ~= nil and y ~= nil and z ~= nil, ERROR_CORRUPTION)

			local vertexId = editableMesh:AddVertex(Vector3.new(x, y, z))
			table.insert(vertices, vertexId)
		elseif opcode == "vt" then
			local u = tonumber(arguments[2])
			local v = tonumber(arguments[3])

			assert(u ~= nil and v ~= nil, ERROR_CORRUPTION)

			-- no texture support (yet?)
		elseif opcode == "vn" then
			local x = tonumber(arguments[2])
			local y = tonumber(arguments[3])
			local z = tonumber(arguments[4])

			assert(x ~= nil and y ~= nil and z ~= nil, ERROR_CORRUPTION)

			table.insert(normals, x)
			table.insert(normals, y)
			table.insert(normals, z)
		elseif opcode == "f" then
			local triangleVertexIds = {} :: { number }

			for i = 2, 4 do
				local faceElement = arguments[i]:split("/")

				local serialVertexId = tonumber(faceElement[1])
				local _textureId = tonumber(faceElement[2])
				local normalId = tonumber(faceElement[3])

				assert(serialVertexId ~= nil, ERROR_CORRUPTION)

				table.insert(triangleVertexIds, vertices[serialVertexId])

				if normalId ~= nil then
					local normalX = normals[normalId * 3 - 2]
					local normalY = normals[normalId * 3 - 1]
					local normalZ = normals[normalId * 3]

					assert(normalX ~= nil and normalY ~= nil and normalZ ~= nil, ERROR_CORRUPTION)

					editableMesh:SetVertexNormal(vertices[serialVertexId], Vector3.new(normalX, normalY, normalZ))
				end
			end

			editableMesh:AddTriangle(
				triangleVertexIds[1] :: number,
				triangleVertexIds[2] :: number,
				triangleVertexIds[3] :: number
			)
		end
	end

	return editableMesh
end

return { toEditableMesh = toEditableMesh }
