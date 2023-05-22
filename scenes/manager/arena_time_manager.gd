extends Node

signal difficulty_increased(difficulty: int)

const DIFFICULTY_INTERVAL = 5

@export var end_screen_scene: PackedScene

@onready var timer = $Timer

var difficulty = 0

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	
	
func _process(_delta):
	var next_time_target = timer.wait_time - ((difficulty + 1) * DIFFICULTY_INTERVAL)
	if timer.time_left <= next_time_target:
		difficulty += 1
		difficulty_increased.emit(difficulty)


func get_time_elapsed():
	return timer.wait_time - timer.time_left
	

func _on_timer_timeout():
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
