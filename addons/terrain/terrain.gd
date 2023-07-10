@tool
extends EditorPlugin


func _enter_tree():
	# Register custom types
	add_custom_type("Terrain", "GeometryInstance3D", preload("terrain_node.gd"), preload("icons/TerrainIcon4.svg"))


func _exit_tree():
	remove_custom_type("Terrain")
