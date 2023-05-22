extends Node

const SPAWN_RADIUS = 375

@export var enemy_scene: PackedScene
@export var arena_time_manager: Node

@onready var timer: Timer = $Timer

var base_spawn_time = 0

func _ready():
	base_spawn_time = timer.wait_time
	timer.timeout.connect(_on_timer_timeout)
	arena_time_manager.difficulty_increased.connect(_on_difficulty_increased)
	
	
func _on_timer_timeout():
	timer.start()
	
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
		
	var enemy_instance = enemy_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	if entities_layer == null:
		return
		
	entities_layer.add_child(enemy_instance)
	enemy_instance.global_position = spawn_position
	

func _on_difficulty_increased(difficulty: int):
	var timer_decrease = min((.1 / 12) * difficulty, 0.7)
	timer.wait_time = base_spawn_time - timer_decrease
