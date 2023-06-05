extends RigidBody3D

@onready var camera: Node3D = $Camera
@onready var water_patch: MeshInstance3D = $WaterPatch
@onready var hull_collider: CollisionShape3D = $HullCollider
@onready var hull_mesh: MeshInstance3D = $HullMesh

@export var speed := 5.0

func _ready():
	var hull_aabb := hull_mesh.get_aabb()
	var bouding_diagonal: float = hull_aabb.position.distance_to(Vector3(hull_aabb.end.x, hull_aabb.position.y, hull_aabb.end.z))
	water_patch.mesh.size = Vector2(bouding_diagonal, bouding_diagonal)
	water_patch.mesh.subdivide_width = 4
	water_patch.mesh.subdivide_depth = 4

func _process(delta):
	var input_dir := Input.get_vector("left", "right", "backward", "forward")
	var direction := camera.basis * Vector3(input_dir.x, 0.0, input_dir.y)
