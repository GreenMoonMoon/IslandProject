extends Node3D

var tangent: Vector3
var binormal: Vector3

@onready var gravity: float = ProjectSettings.get("physics/3d/default_gravity")

@export var wave_a := Vector4(1.0, 0.0, 0.75, 24.0)
@export var wave_b := Vector4(0.0, 1.0, 0.5, 60.0)
@export var wave_c := Vector4(0.7, 0.7, 0.25, 80.0)


func grestner_wave(profile: Vector4, position: Vector3) -> Vector3:
	var d := Vector2(profile.x, profile.y).normalized()
	
	var k := TAU / profile.w
	var c := sqrt(gravity / k)
	var f := k * (d.dot(Vector2(position.x, position.z)) - c * (Time.get_ticks_msec() * 0.001))
	var a := profile.z / k
	
	tangent += Vector3(
		-d.x * d.x * (profile.z * sin(f)),
		d.x * (profile.z * cos(f)),
		-d.x * d.y * (profile.z * sin(f))
	)
	binormal += Vector3(
		-d.x * d.y * (profile.z * sin(f)),
		d.y * (profile.z * cos(f)),
		-d.y * d.y * (profile.z * sin(f))
	)

	return Vector3(d.x * (a * cos(f)), a * sin(f), d.y * (a * cos(f)))


func _process(delta):
	tangent = Vector3.RIGHT
	binormal = Vector3.FORWARD
	
	var current_position := Vector3(position.x, 0.0, position.z);
	current_position += grestner_wave(wave_a, current_position)
	current_position += grestner_wave(wave_b, current_position)
	current_position += grestner_wave(wave_c, current_position)
	
	basis = Basis(tangent, binormal.cross(tangent), binormal).orthonormalized();
	position.y = current_position.y
