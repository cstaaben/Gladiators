extends CanvasLayer

var options_scene = preload("res://scenes/ui/options_menu.tscn")
var meta_upgrades_scene = preload("res://scenes/ui/meta_upgrade_menu.tscn")

func _ready():
	%PlayButton.pressed.connect(_on_play_pressed)
	%UpgradesButton.pressed.connect(_on_upgrades_pressed)
	%OptionsButton.pressed.connect(_on_options_pressed)
	%QuitButton.pressed.connect(_on_quit_pressed)


func _on_play_pressed() -> void:
	ScreenTransition.transition_to_scene("res://scenes/main/root.tscn")


func _on_options_pressed() -> void:
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway

	var options_instance = options_scene.instantiate()
	add_child(options_instance)
	options_instance.back_pressed.connect(_on_options_closed.bind(options_instance))


func _on_quit_pressed() -> void:
	MetaProgression.save_data()
	get_tree().quit()


func _on_options_closed(options_instance: Node):
	options_instance.queue_free()


func _on_upgrades_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway

	var meta_upgrades_instance = meta_upgrades_scene.instantiate()
	add_child(meta_upgrades_instance)
