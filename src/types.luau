export type MeshFileFormat = "WavefrontOBJ"

export type MeshReader = {
	toEditableMesh: (file: buffer) -> EditableMesh,
}

return nil
