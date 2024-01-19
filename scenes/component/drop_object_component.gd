extends Node


@export_range(0,1) var drop_percent: float = 0.5
@export var health_component: HealthComponent
@export var xp_vial_scene: PackedScene
@export var health_potion_scene: PackedScene

var drop_table: WeightedTable = WeightedTable.new()
var adjusted_xp_drop_percent: float = drop_percent

func _ready():
	health_component.died.connect(_on_died)
	
	var upgrade_count = MetaProgression.get_upgrade_quantity("experience_gain")
	if upgrade_count > 0:
		adjusted_xp_drop_percent += (0.1 * upgrade_count)
		
	drop_table.add_item("xp", 50)
	drop_table.add_item("health", 1)


func _on_died():
	if xp_vial_scene == null or health_potion_scene == null or \
			not owner is Node2D:
		return
		
	var adjusted_percent: float = drop_percent
	var drop_obj_scene: PackedScene
	var drop_id = drop_table.random_item() as String
	match drop_id:
		"xp":
			adjusted_percent = adjusted_xp_drop_percent
			drop_obj_scene = xp_vial_scene
		"health":
			drop_obj_scene = health_potion_scene
		_:
			push_error("unrecognized drop object id: %s" % drop_id)
			
	if randf() > adjusted_percent:
		return

	var spawn_position = (owner as Node2D).global_position
	var drop_object_instance = drop_obj_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	if entities_layer == null:
		return
		
	entities_layer.add_child(drop_object_instance)
	drop_object_instance.global_position = spawn_position
