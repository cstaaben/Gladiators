extends Node

const SPAWN_RADIUS = 375

@export var rat_scene: PackedScene
@export var wizard_scene: PackedScene
@export var bat_scene: PackedScene
@export var arena_time_manager: Node

@onready var timer: Timer = $Timer

var base_spawn_time = 0
var enemy_table = WeightedTable.new()


func _ready():
	base_spawn_time = timer.wait_time
	timer.timeout.connect(_on_timer_timeout)
	arena_time_manager.difficulty_increased.connect(_on_difficulty_increased)
	enemy_table.add_item(rat_scene, 10)
	
	
func get_spawn_position():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return Vector2.ZERO
		
	var spawn_position = Vector2.ZERO
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	for i in 4:
		spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
		var collision_offset = random_direction * 20
		
		var param = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position + collision_offset, 1 << 0)
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(param)
		if result.is_empty():
			# no collision
			break
		else:
			# collision, rotate 90 degrees
			random_direction = random_direction.rotated(deg_to_rad(90))
			
	return spawn_position


func _on_timer_timeout():
	timer.start()
	
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return

	var enemy_scene = enemy_table.random_item()
	var enemy_instance = enemy_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	if entities_layer == null:
		return
		
	entities_layer.add_child(enemy_instance)
	enemy_instance.global_position = get_spawn_position()
	

func _on_difficulty_increased(difficulty: int):
	var timer_decrease = min((.1 / 12) * difficulty, 0.7)
	timer.wait_time = base_spawn_time - timer_decrease
	
	if difficulty == 6:
		enemy_table.add_item(wizard_scene, 15)
	elif difficulty == 18:
		enemy_table.add_item(bat_scene, 8)
