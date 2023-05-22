extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var xp_manager: ExperienceManager
@export var upgrade_screen_scene: PackedScene

# key = upgrade id
var current_upgrades = {}


func _ready():
	xp_manager.level_up.connect(_on_level_up)
	
	
func apply_upgrade(upgrade: AbilityUpgrade):
	if !current_upgrades.has(upgrade.id):
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
		
	GameEvents.ability_upgrade_added.emit(upgrade, current_upgrades)


func pick_upgrades():
	var chosen_upgrades: Array[AbilityUpgrade] = []
	var filtered_upgrades = upgrade_pool.duplicate()
	for i in 2:
		var chosen_upgrade = filtered_upgrades.pick_random() as AbilityUpgrade
		filtered_upgrades = filtered_upgrades.filter(func(upgrade: AbilityUpgrade):
			return upgrade.id != chosen_upgrade.id
		)
		chosen_upgrades.append(chosen_upgrade)
		
	return chosen_upgrades


func _on_level_up(_current_level: int):
	var upgrade_screen_instance = upgrade_screen_scene.instantiate() as UpgradeScreen
	add_child(upgrade_screen_instance)
	var chosen_upgrades = pick_upgrades()
	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(_on_upgrade_selected)


func _on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)
