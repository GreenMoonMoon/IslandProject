extends Node3D
class_name CameraControl

const maximum_height := 25.0

var mouse_look_input: Vector2
var target: Node3D

@export var height := 4.0
@export var distance := 12.0
@export var sensitivity := Vector2(2.0, 10.0)
@export var mouse_sensitivity := Vector2(-0.05, -0.5)
@export var chase_speed := 1.0

@onready var camera: Camera3D = $"Camera3D"


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera.position.z = -distance
	camera.position.y = height
	target = get_parent()


func _process(delta):
	var velocity = target.global_position - global_position
	global_position = target.global_position
	if velocity.length() > 0.1:
		global_rotation.y = lerp_angle(global_rotation.y, target.global_rotation.y, delta)
	
	# Handle mouse
	if mouse_look_input.length_squared() > 0.1:
		rotation.y = wrapf(rotation.y + mouse_look_input.x * delta, 0.0, TAU)
		camera.position.y += mouse_look_input.y * delta
		camera.position.y = clampf(camera.position.y, -2.0, maximum_height)

	# Set camera
	camera.look_at(position, Vector3.UP)
	mouse_look_input = lerp(mouse_look_input, Vector2.ZERO, delta * 10.0)


func _input(event):
	if event is InputEventMouseMotion:
		mouse_look_input = event.get_relative() * mouse_sensitivity
