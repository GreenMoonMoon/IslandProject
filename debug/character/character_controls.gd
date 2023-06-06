extends CharacterBody3D

const HALF_PI := PI / 2

var input_direction: Vector2

@onready var gravity: float = ProjectSettings.get("physics/3d/default_gravity")
@onready var model: Node3D = $Model

@export var camera: Node3D
@export var move_speed := 12.0
@export var orientation_speed := 2.5


func _ready():
	camera.change_focus(self)


func _physics_process(delta):
	process_input()
	
	if is_on_floor():
		if input_direction.length_squared() > 0.1:
			var move_direction := camera.basis * Vector3(input_direction.x, 0.0, input_direction.y)
			velocity.x = lerpf(velocity.x, move_direction.x * move_speed, delta * 8.0) #quick acceleration
			velocity.z = lerpf(velocity.z, move_direction.z * move_speed, delta * 8.0)
			
			orient_character(Vector2(move_direction.x, -move_direction.z), delta)
		else:
			velocity.x = lerpf(velocity.x, 0.0, delta * 10.0)
			velocity.z = lerpf(velocity.z, 0.0, delta * 10.0)
	else:
		velocity.y -= gravity * delta
	
	move_and_slide()


func process_input():
	input_direction = Input.get_vector("right", "left", "backward", "forward")


func orient_character(direction: Vector2, delta: float):
	model.rotation.y = lerp_angle(model.rotation.y, direction.angle() + HALF_PI, delta * orientation_speed)
