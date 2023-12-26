extends Node2D

@export var end_screen_scene: PackedScene
@export var pause_menu_scene: PackedScene


func _ready():
	%Player.health.died.connect(_on_player_died)
	
	
func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		add_child(pause_menu_scene.instantiate())
		get_tree().root.set_input_as_handled()


func _on_player_died():
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
	end_screen_instance.set_defeat()
