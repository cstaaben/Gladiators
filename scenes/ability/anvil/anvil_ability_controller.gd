extends Node

@export var anvil_ability_scene: PackedScene

const BASE_RANGE = 100
const BASE_DAMAGE = 15

var anvil_count: int = 0

func _ready():
	$Timer.timeout.connect(_on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(_on_ability_upgrade_added)


func _on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return

	var direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var rotation_degrees = 360.0 / (anvil_count + 1)
	var distance = randf_range(0, BASE_RANGE)
	for i in (anvil_count + 1):
		var rotated_direction = direction.rotated(deg_to_rad(i * rotation_degrees))
		var spawn_position = player.global_position + (rotated_direction * distance)

		var param = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, 1 << 0)
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(param)
		if !result.is_empty():
			spawn_position = result["position"]

		var anvil_ability = anvil_ability_scene.instantiate()
		get_tree().get_first_node_in_group("foreground_layer").add_child(anvil_ability)
		anvil_ability.global_position = spawn_position
		anvil_ability.hitbox_component.damage = BASE_DAMAGE


func _on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == "anvil_count":
		anvil_count = current_upgrades["anvil_count"]["quantity"]
