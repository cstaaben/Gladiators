extends Node2D

@export var end_screen_scene: PackedScene
@export var pause_menu_scene: PackedScene


func _ready():
	%Player.health.died.connect(_on_player_died)
	
	
func _input(event: InputEvent):
	if !InputMap.action_has_event("pause", event):
		return
		
	add_child(pause_menu_scene.instantiate())


func _on_player_died():
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
	end_screen_instance.set_defeat()
