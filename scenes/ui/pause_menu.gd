extends Node

@onready var panel_container = %PanelContainer

var _options_menu_scene: PackedScene = preload("res://scenes/ui/options_menu.tscn")
var _is_closing: bool = false

func _ready():
	get_tree().paused = true
	panel_container.pivot_offset = panel_container.size / 2

	%ResumeButton.pressed.connect(_on_resume_button_pressed)
	%OptionsButton.pressed.connect(_on_options_pressed)
	%MainMenuButton.pressed.connect(_on_main_menu_pressed)
	%QuitButton.pressed.connect(_on_quit_button_pressed)

	$AnimationPlayer.play("fade_in")
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0.3)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)

	
	
func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		_close()
		get_tree().root.set_input_as_handled()
		

func _close():
	if _is_closing:
		return

	_is_closing = true
	$AnimationPlayer.play_backwards("fade_in")

	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0)
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0.3)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)

	await tween.finished
	get_tree().paused = false
	queue_free()



func _on_resume_button_pressed():
	_close()

	
func _on_quit_button_pressed():
	MetaProgression.save_data()
	get_tree().quit()


func _on_main_menu_pressed():
	get_tree().paused = false
	ScreenTransition.transition_to_scene("res://scenes/ui/main_menu.tscn")


func _on_options_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway

	var options_menu_instance = _options_menu_scene.instantiate()
	add_child(options_menu_instance)
	options_menu_instance.back_pressed.connect(_on_options_back_pressed.bind(options_menu_instance))


func _on_options_back_pressed(options_menu: Node):
	options_menu.queue_free()
