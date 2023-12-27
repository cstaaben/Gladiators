extends Node


@export_range(0,1) var drop_percent: float = 0.5
@export var health_component: Node
@export var vial_scene: PackedScene

func _ready():
	(health_component as HealthComponent).died.connect(_on_died)

func _on_died():
	var adjusted_percent = drop_percent
	var upgrade_count = MetaProgression.get_upgrade_quantity("experience_gain")
	if upgrade_count > 0:
		adjusted_percent += (0.1 * upgrade_count)
		
	if vial_scene == null or not owner is Node2D or randf() > adjusted_percent:
		return

	var spawn_position = (owner as Node2D).global_position
	var vial_instance = vial_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	if entities_layer == null:
		return
		
	entities_layer.add_child(vial_instance)
	vial_instance.global_position = spawn_position
