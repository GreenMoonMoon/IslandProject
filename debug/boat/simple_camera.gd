extends Node3D
class_name CameraControl

const maximum_height := 12.0

var mouse_look_input: Vector2
var mouse_zoom_input: float
var target: Node3D

@export var height := 4.0
@export var distance := 6.0
@export var sensitivity := Vector2(2.0, 10.0)
@export var mouse_sensitivity := Vector2(-0.05, -0.5)
@export var chase_speed := 1.0

@onready var camera: Camera3D = $"Camera3D"


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera.position.z = -distance
	camera.position.y = height


func _process(delta):
	if target:
		var velocity = target.global_position - global_position
		global_position = target.global_position
#		if velocity.length() > 0.1:
#			global_rotation.y = lerp_angle(global_rotation.y, target.global_rotation.y, delta)
	
	# Handle mouse
	if mouse_look_input.length_squared() > 0.1:
		rotation.y = wrapf(rotation.y + mouse_look_input.x * delta, 0.0, TAU)
#		camera.position.y += mouse_look_input.y * delta
#		camera.position.y = clampf(camera.position.y, 0.1, maximum_height)
	
#	if mouse_zoom_input < 0.0:
#		camera.position.z = clampf(camera.position.z + mouse_zoom_input * delta, 1.0, distance)

	# Set camera
	camera.look_at(position, Vector3.UP)
	mouse_look_input = lerp(mouse_look_input, Vector2.ZERO, delta * 10.0)


func _input(event):
#	mouse_zoom_input = 0.0
	match event.get_class():
		"InputEventMouseMotion":
			mouse_look_input = event.get_relative() * mouse_sensitivity
#		"InputEventMouseButton":
#			match(event.button_index):
#				MOUSE_BUTTON_WHEEL_UP:
#					mouse_zoom_input = 1.0
#				MOUSE_BUTTON_WHEEL_DOWN:
#					mouse_zoom_input = -1.0


func change_focus(new_target: Node3D):
	target = new_target
