extends CanvasLayer


func _ready():
	get_tree().paused = true
	$AnimationPlayer.play("fade_in")

	%RestartButton.pressed.connect(_on_restart_button_pressed)
	%QuitButton.pressed.connect(_on_quit_button_pressed)


func set_defeat():
	%TitleLabel.text = "GAME OVER"
	%DescriptionLabel.text = "You lost!"
	
	
func _on_restart_button_pressed():
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main/root.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
