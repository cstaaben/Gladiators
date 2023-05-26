extends Node


func _ready():
	get_tree().paused = true
	
	%ResumeButton.pressed.connect(_on_resume_button_pressed)
	%QuitButton.pressed.connect(_on_quit_button_pressed)
	
	
func _on_resume_button_pressed():
	get_tree().paused = false
	queue_free()
	
	
func _on_quit_button_pressed():
	get_tree().quit()
