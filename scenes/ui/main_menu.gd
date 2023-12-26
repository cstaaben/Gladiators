extends CanvasLayer

var options_scene = preload("res://scenes/ui/options_menu.tscn")

func _ready():
	%PlayButton.pressed.connect(_on_play_pressed)
	%OptionsButton.pressed.connect(_on_options_pressed)
	%QuitButton.pressed.connect(_on_quit_pressed)


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main/root.tscn")


func _on_options_pressed() -> void:
	var options_instance = options_scene.instantiate()
	add_child(options_instance)
	options_instance.back_pressed.connect(_on_options_closed.bind(options_instance))


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_options_closed(options_instance: Node):
	options_instance.queue_free()
