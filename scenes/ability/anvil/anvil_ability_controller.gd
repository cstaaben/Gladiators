extends Node

@export var anvil_ability_scene: PackedScene

const BASE_RANGE = 100
const BASE_DAMAGE = 15

func _ready():
	$Timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout():
	var direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return

	var spawn_position = player.global_position + (direction * randf_range(0, BASE_RANGE))

	var param = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, 1 << 0)
	var result = get_tree().root.world_2d.direct_space_state.intersect_ray(param)
	if !result.is_empty():
		spawn_position = result["position"]

	var anvil_ability = anvil_ability_scene.instantiate()
	get_tree().get_first_node_in_group("foreground_layer").add_child(anvil_ability)
	anvil_ability.global_position = spawn_position
	anvil_ability.hitbox_component.damage = BASE_DAMAGE
