extends CanvasLayer

@export var arena_time_manager: Node
@onready var label = %Label

func _process(delta):
	if arena_time_manager == null:
		return
	var time_elapsed = arena_time_manager.get_time_elapsed()
	label.text = format_seconds(time_elapsed)
	
	
func format_seconds(seconds: float):
	var minutes = floor(seconds / 60)
	var remaining_secs = int(floor(seconds)) % 60
	return ("%02d" % minutes) + ":" + ("%02d" % remaining_secs) 
