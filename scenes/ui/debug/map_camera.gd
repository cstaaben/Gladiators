extends Camera2D
class_name MapCamera


func _ready():
	make_current()
	position = Vector2.ZERO
	zoom = Vector2(0.08, 0.08)


func zoom_in():
	zoom *= 1.75
	print_debug("zoom: ", zoom, "\nposition:", global_position)


func zoom_out():
	zoom *= 0.75
	print_debug("zoom: ", zoom, "\nposition:", global_position)
