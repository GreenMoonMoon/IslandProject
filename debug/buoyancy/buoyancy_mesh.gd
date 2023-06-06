extends MeshInstance3D
class_name BuoyancyMesh


func calculate_volume() -> float:
	var mdt := MeshDataTool.new()
	var array_mesh := ArrayMesh.new()
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, mesh.get_mesh_arrays())
	mdt.create_from_surface(array_mesh, 0)
	
	var sum := 0.0
	for fi in range(mdt.get_face_count()):
		sum += calculate_triangle_signed_volume(
			mdt.get_vertex(mdt.get_face_vertex(fi, 0)),
			mdt.get_vertex(mdt.get_face_vertex(fi, 1)),
			mdt.get_vertex(mdt.get_face_vertex(fi, 2)),
		)	
	return abs(sum)


func calculate_triangle_signed_volume(a: Vector3, b: Vector3, c: Vector3) -> float:
	return a.dot(b.cross(c)) / 6.0;
