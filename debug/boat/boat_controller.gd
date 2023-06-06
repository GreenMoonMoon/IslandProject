extends RigidBody3D

@onready var water_patch: MeshInstance3D = $WaterPatch
@onready var hull_collider: CollisionShape3D = $HullCollider
@onready var hull_mesh: MeshInstance3D = $HullMesh

@export var camera: Node3D
@export var speed := 5.0

func _ready():
	# Calculate the water patch size
	var hull_aabb := hull_mesh.get_aabb()
	var bouding_diagonal: float = hull_aabb.position.distance_to(Vector3(hull_aabb.end.x, hull_aabb.position.y, hull_aabb.end.z))
	water_patch.mesh.size = Vector2(ceil(bouding_diagonal), ceil(bouding_diagonal))
	water_patch.mesh.subdivide_width = maxf(water_patch.mesh.size.x - 1, 0.0)
	water_patch.mesh.subdivide_depth = maxf(water_patch.mesh.size.x - 1, 0.0)

func _process(_delta):
#	var input_dir := Input.get_vector("left", "right", "backward", "forward")
#	var direction := camera.basis * Vector3(input_dir.x, 0.0, input_dir.y)
	pass
