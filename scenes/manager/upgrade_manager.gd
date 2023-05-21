extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var xp_manager: ExperienceManager
@export var upgrade_screen_scene: PackedScene

# key = upgrade id
var current_upgrades = {}


func _ready():
	xp_manager.level_up.connect(_on_level_up)
	
	
func _on_level_up(_current_level: int):
	var chosen_upgrade = upgrade_pool.pick_random() as AbilityUpgrade
	if chosen_upgrade == null:
		return
		
	var upgrade_screen_instance = upgrade_screen_scene.instantiate() as UpgradeScreen
	add_child(upgrade_screen_instance)
	upgrade_screen_instance.set_ability_upgrades([chosen_upgrade] as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(_on_upgrade_selected)


func apply_upgrade(upgrade: AbilityUpgrade):
	if !current_upgrades.has(upgrade.id):
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
		
	print(current_upgrades)


func _on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)
