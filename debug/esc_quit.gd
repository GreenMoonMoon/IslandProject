extends Node
class_name EscQuit

func _unhandled_input(event):
	if event.get_class() == "InputEventKey" and event.keycode == KEY_ESCAPE:
		get_tree().quit()
