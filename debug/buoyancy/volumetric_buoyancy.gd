extends RigidBody3D

var volume: float
var density: float

@onready var mesh: BuoyancyMesh = $Mesh
@onready var gravity: float = ProjectSettings.get("physics/3d/default_gravity")


func _ready():
	volume = mesh.calculate_volume()
	density = mass / volume


func _process(delta):
	pass
