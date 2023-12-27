extends CanvasLayer


@onready var panel_container: PanelContainer = %PanelContainer

func _ready():
	panel_container.pivot_offset = panel_container.size / 2
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0.3)\
		.from(Vector2.ZERO)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_BACK)
	tween.parallel()\
		.tween_property(panel_container, "rotation", TAU, 0.3)\
		.from(deg_to_rad(0))\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUINT)
	
	get_tree().paused = true
	$AnimationPlayer.play("fade_in")

	%ContinueButton.pressed.connect(_on_continue_button_pressed)
	%MenuButton.pressed.connect(_on_menu_button_pressed)
	%QuitButton.pressed.connect(_on_quit_button_pressed)


func set_defeat():
	%TitleLabel.text = "GAME OVER"
	%DescriptionLabel.text = "You lost!"
	play_jingle(true)
	
	
func play_jingle(defeat: bool = false) -> void:
	var streamPlayer: AudioStreamPlayer
	if defeat:
		streamPlayer = $DefeatStreamPlayer
	else:
		streamPlayer = $VictoryStreamPlayer
	streamPlayer.play()


func _on_continue_button_pressed():
	ScreenTransition.transition_to_scene("res://scenes/ui/meta_upgrade_menu.tscn")
	await ScreenTransition.transitioned_halfway
	get_tree().paused = false


func _on_quit_button_pressed():
	MetaProgression.save_data()
	get_tree().quit()


func _on_menu_button_pressed():
	ScreenTransition.transition_to_scene("res://scenes/ui/main_menu.tscn")
	await ScreenTransition.transitioned_halfway
	get_tree().paused = false
